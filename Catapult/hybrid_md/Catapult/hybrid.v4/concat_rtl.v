
//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/ccs_libs/interfaces/amba/ccs_axi4_slave_mem.v 
////////////////////////////////////////////////////////////////////////////////
// Catapult Synthesis - Custom Interfaces
//
// Copyright (c) 2018 Mentor Graphics Corp.
//       All Rights Reserved
// 
// This document contains information that is proprietary to Mentor Graphics
// Corp. The original recipient of this document may duplicate this  
// document in whole or in part for internal business purposes only, provided  
// that this entire notice appears in all copies. In duplicating any part of  
// this document, the recipient agrees to make every reasonable effort to  
// prevent the unauthorized use and distribution of the proprietary information.
// 
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in prepartion for creating
// their own custom interfaces. This design does not present a complete
// implementation of the named protocol or standard.
//
// NO WARRANTY.
// MENTOR GRAPHICS CORP. EXPRESSLY DISCLAIMS ALL WARRANTY
// FOR THE SOFTWARE. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE
// LAW, THE SOFTWARE AND ANY RELATED DOCUMENTATION IS PROVIDED "AS IS"
// AND WITH ALL FAULTS AND WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE, OR NONINFRINGEMENT. THE ENTIRE RISK ARISING OUT OF USE OR
// DISTRIBUTION OF THE SOFTWARE REMAINS WITH YOU.
// 
////////////////////////////////////////////////////////////////////////////////

// --------------------------------------------------------------------------
// DESIGN UNIT:        ccs_axi4_slave_mem
//
// DESCRIPTION:
//   This model implements an AXI4 Slave memory interface for use in 
//   Interface Synthesis in Catapult. The component details are described in the datasheet
//
//   AXI/Catapult read/write to the same address in the same cycle is non-determinant
//
// Notes:
//  1. This model implements a local memory of size {cwidth x depth}.
//     If the Catapult operation requires a memory width cwidth <= AXI bus width
//     this model will zero-pad the high end bits as necessary.
// CHANGE LOG:
//
//  01/29/19 - Add reset phase and separate base address for read/write channels
//  11/26/18 - Add burst and other tweaks
//  02/28/18 - Initial implementation
//
// --------------------------------------------------------------------------

// -------------------------------------------------------------------------------
//  Memory Organization
//   This model is designed to provide storage for only the bits/elements that
//   the Catapult core actually interacts with.
//   The user supplies a base address for the AXI memory store via BASE_ADDRESS
//   parameter.  
// Example:
//   C++ array declared as "ac_int<7,false>  coeffs[4];"
//   results in a Catapult operator width (op_width) of 7,
//   and cwidth=7 and addr_w=2 (addressing 4 element locations).
//   The library forces DATA_WIDTH to be big enough to hold
//   cwidth bits, rounded up to power-of-2 as needed.
// 
//   The AXI address scheme addresses bytes and so increments
//   by number-of-bytes per data transaction, plus the BASE_ADDRESS. 
//   The top and left describe the AXI view of the memory. 
//   The bottom and right describe the Catapult view of the memory.
//
//      AXI-4 SIGNALS
//      ADDR_WIDTH=4        DATA_WIDTH=32
//        AxADDR               xDATA
//                    31                       0
//                    +------------+-----------+
//      BA+0000       |            |           |
//                    +------------+-----------+
//      BA+0000       |            |           |
//                    +------------+===========+
//      BA+1100       |            |  elem3    |    11
//                    +------------+===========+
//      BA+1000       |            |  elem2    |    10
//                    +------------+===========+
//      BA+0100       |            |  elem1    |    01
//                    +------------+===========+
//      BA+0000       |            |  elem0    |    00
//                    +------------+===========+
//                                 6           0
//                                   s_din/out     s_addr
//                                   cwidth=7      addr_w=2
//                                         CATAPULT SIGNALS
//
// -------------------------------------------------------------------------------

// Uncomment this for lots of messages
//`define SLAVE_DBG_READ 1
//`define SLAVE_DBG_WRITE 1

`define AXI4_AxBURST_FIXED      2'b00
`define AXI4_AxBURST_INCR       2'b01
`define AXI4_AxBURST_WRAP       2'b10
`define AXI4_AxBURST_RESERVED   2'b11
`define AXI4_AxSIZE_001_BYTE    3'b000
`define AXI4_AxSIZE_002_BYTE    3'b001
`define AXI4_AxSIZE_004_BYTE    3'b010
`define AXI4_AxSIZE_008_BYTE    3'b011
`define AXI4_AxSIZE_016_BYTE    3'b100
`define AXI4_AxSIZE_032_BYTE    3'b101
`define AXI4_AxSIZE_064_BYTE    3'b110
`define AXI4_AxSIZE_128_BYTE    3'b111
`define AXI4_AxLOCK_NORMAL      1'b0
`define AXI4_AxLOCK_EXCLUSIVE   1'b1

`define AXI3_AxLOCK_NORMAL      2'b00
`define AXI3_AxLOCK_EXCLUSIVE   2'b01
`define AXI3_AxLOCK_LOCKED      2'b10
`define AXI3_AxLOCK_RESERVED    2'b11

`define AXI4_AxCACHE_NORM_NN    4'b0010

// W and R cache consts are almost the same
`define AXI4_AWCACHE_NB        4'b0000
`define AXI4_AWCACHE_B         4'b0001
`define AXI4_AWCACHE_NORM_NCNB 4'b0010
`define AXI4_AWCACHE_NORM_NCB  4'b0011
`define AXI4_AWCACHE_WTNA      4'b0110
`define AXI4_AWCACHE_WTRA      4'b0110
`define AXI4_AWCACHE_WTWA      4'b1110
`define AXI4_AWCACHE_WTRWA     4'b1110
`define AXI4_AWCACHE_WBNA      4'b0111
`define AXI4_AWCACHE_WBRA      4'b0111
`define AXI4_WACACHE_WBWA      4'b1111
`define AXI4_AWCACHE_WBRWA     4'b1111
`define AXI4_ARCACHE_NB        4'b0000
`define AXI4_ARCACHE_B         4'b0001
`define AXI4_ARCACHE_NORM_NCNB 4'b0010
`define AXI4_ARCACHE_NORM_NCB  4'b0011
`define AXI4_ARCACHE_WTNA      4'b1010
`define AXI4_ARCACHE_WTRA      4'b1110
`define AXI4_ARCACHE_WTWA      4'b1010
`define AXI4_ARCACHE_WTRWA     4'b1110
`define AXI4_ARCACHE_WBNA      4'b1011
`define AXI4_ARCACHE_WBRA      4'b1111
`define AXI4_ARCACHE_WBWA      4'b1011
`define AXI4_ARCACHE_WBRWA     4'b1111

`define AXI4_AxPROT_b0_UNPRIV     1'b0
`define AXI4_AxPROT_b0_PRIV       1'b1
`define AXI4_AxPROT_b1_SECURE     1'b0
`define AXI4_AxPROT_b1_UNSECURE   1'b1
`define AXI4_AxPROT_b2_DATA       1'b0
`define AXI4_AxPROT_b2_INSTR      1'b1
`define AXI4_AxQOS_NONE           4'b0000
`define AXI4_xRESP_OKAY           2'b00
`define AXI4_xRESP_EXOKAY         2'b01
`define AXI4_xRESP_SLVERR         2'b10
`define AXI4_xRESP_DECERR         2'b11

`define CLOG2(x) \
      (x <= 1) ?   0 : \
      (x <= 2) ?   1 : \
      (x <= 4) ?   2 : \
      (x <= 8) ?   3 : \
      (x <= 16) ?  4 : \
      (x <= 32) ?  5 : \
      (x <= 64) ?  6 : \
      (x <= 128) ? 7 : \
      -1

module ccs_axi4_slave_mem ( ACLK, ARESETn, 
  AWID, AWADDR, AWLEN, AWSIZE, AWBURST, AWLOCK, AWCACHE, AWPROT, AWQOS, AWREGION, AWUSER, AWVALID, AWREADY,
  WDATA, WSTRB, WLAST, WUSER, WVALID, WREADY,
  BID, BRESP, BUSER, BVALID, BREADY,
  ARID, ARADDR, ARLEN, ARSIZE, ARBURST, ARLOCK, ARCACHE, ARPROT, ARQOS, ARREGION, ARUSER, ARVALID, ARREADY,
  RID, RDATA, RRESP, RLAST, RUSER, RVALID, RREADY,
  s_re, s_we, s_raddr, s_waddr, s_din, s_dout, s_rrdy, s_wrdy, is_idle, tr_write_done, s_tdone);

   parameter rscid = 1;           // Required resource ID parameter
   parameter depth  = 16;         // Number of addressable elements
   parameter op_width = 1;        // dummy parameter for cwidth calculation
   parameter cwidth = 8;          // Internal memory data width
   parameter addr_w = 4;          // Internal memory address width
   parameter nopreload = 0;       // 1= no preload before Catapult can read
   parameter rst_ph = 0;          // Reset phase.  1= Positive edge. Default is AXI negative edge
   parameter ADDR_WIDTH = 32;     // AXI4 address width (must be >= addr_w)
   parameter DATA_WIDTH = 32;     // AXI4 data width (must be between 8 and 1024, and power of 2
   parameter ID_WIDTH    = 1;     // AXI4 ID field width (ignored in this model)
   parameter USER_WIDTH  = 1;     // AXI4 User field width (ignored in this model)
   parameter REGION_MAP_SIZE = 1; // AXI4 Region Map (ignored in this model)
   parameter wBASE_ADDRESS = 0;    // AXI4 write channel base address
   parameter rBASE_ADDRESS = 0;    // AXI4 read channel base address
   
   // AXI Clocking
   input                               ACLK;                           // Rising edge clock
   input                               ARESETn;                        // Active LOW asynchronous reset
   wire                                int_ARESETn;
   assign int_ARESETn = rst_ph ? ~ARESETn : ARESETn;

   // ============== AXI4 Slave Write Address Channel Signals
   input [ID_WIDTH-1:0]                AWID;                           // Write Transaction ID
   input [ADDR_WIDTH-1:0]              AWADDR;                         // Write address
   input [7:0]                         AWLEN;                          // Write burst length in beats
   input [2:0]                         AWSIZE;                         // Write burst size - encoding(above)
   input [1:0]                         AWBURST;                        // Write burst mode
   input                               AWLOCK;                         // Lock type
   input [3:0]                         AWCACHE;                        // Memory type
   input [2:0]                         AWPROT;                         // Protection Type
   input [3:0]                         AWQOS;                          // Quality of Service
   input [3:0]                         AWREGION;                       // Region identifier
   input [USER_WIDTH-1:0]              AWUSER;                         // User signal
   input                               AWVALID;                        // Write address valid
   output                              AWREADY;                        // Write address ready
   
   // ============== AXI4 Slave Write Data Channel
   input [DATA_WIDTH-1:0]              WDATA;                          // Write data
   input [DATA_WIDTH/8 - 1:0]          WSTRB;                          // Write strobe (bytewise)
   input                               WLAST;                          // Write last
   input [USER_WIDTH-1:0]              WUSER;                          // User signal
   input                               WVALID;                         // Write data is valid
   output                              WREADY;                         // Write ready

   // ============== AXI4 Slave Write Response Channel Signals
   output [ID_WIDTH-1:0]               BID;                            // Response Transaction ID tag
   output [1:0]                        BRESP;                          // Write response (of slave)
   output [USER_WIDTH-1:0]             BUSER;                          // User signal
   output                              BVALID;                         // Write response valid
   input                               BREADY;                         // Response ready

   // ============== AXI4 Slave Read Address Channel Signals
   input [ID_WIDTH-1:0]                ARID;                           // Read Transaction ID
   input [ADDR_WIDTH-1:0]              ARADDR;                         // Read address
   input [7:0]                         ARLEN;                          // Read burst length in beats
   input [2:0]                         ARSIZE;                         // Read burst size - encoding(above)
   input [1:0]                         ARBURST;                        // Read burst mode
   input                               ARLOCK;                         // Lock type
   input [3:0]                         ARCACHE;                        // Memory type
   input [2:0]                         ARPROT;                         // Protection Type
   input [3:0]                         ARQOS;                          // Quality of Service
   input [3:0]                         ARREGION;                       // Region identifier
   input [USER_WIDTH-1:0]              ARUSER;                         // User signal
   input                               ARVALID;                        // Read address valid
   output                              ARREADY;                        // Read address ready
   
   // ============== AXI4 Slave Read Data Channel Signals
   output [ID_WIDTH-1:0]               RID;                            // Read Transaction ID tag
   output [DATA_WIDTH-1:0]             RDATA;                          // Read data
   output [1:0]                        RRESP;                          // Read response
   output                              RLAST;                          // Read last
   output [USER_WIDTH-1:0]             RUSER;                          // User signal
   output                              RVALID;                         // Read valid
   input                               RREADY;                         // Read ready

   reg                                 AWREADY_reg;
   assign AWREADY = AWREADY_reg;
   reg                                 WREADY_reg;
   assign WREADY = WREADY_reg;
   reg [ID_WIDTH-1:0]                  AWID_reg;
   assign BID = AWID_reg;
   reg [1:0]                           BRESP_reg;
   assign BRESP = BRESP_reg;
   assign BUSER = 0;
   reg                                 BVALID_reg;
   assign BVALID = BVALID_reg;
   
   reg                                 ARREADY_reg;
   assign ARREADY = ARREADY_reg;

   reg [ID_WIDTH-1:0]                  ARID_reg;
   assign RID = ARID_reg;   
   reg [DATA_WIDTH-1:0]                RDATA_reg;
   assign RDATA = RDATA_reg;
   reg [1:0]                           RRESP_reg;
   assign RRESP = RRESP_reg;
   reg                                 RLAST_reg;
   assign RLAST = RLAST_reg;
   assign RUSER = 0;
   reg                                 RVALID_reg;
   assign RVALID = RVALID_reg;
   
   // Catapult interface
   input                               s_re;     // Catapult attempting read of slave memory
   input                               s_we;     // Catapult attempting write to slave memory
   input [addr_w-1:0]                  s_raddr;  // Catapult addressing into memory
   input [addr_w-1:0]                  s_waddr;  // Catapult addressing into memory
   output [cwidth-1:0]                 s_din;    // Data into catapult block through this interface
   input [cwidth-1:0]                  s_dout;   // Data out to slave from catapult
   output                              s_rrdy;   // Slave memory ready for access by Catapult (1=ready)
   output                              s_wrdy;   // Slave memory ready for access by Catapult (1=ready)
   output                              is_idle;  // The component is idle - clock can be suppressed
   input                               tr_write_done;  // transactor resource preload write done
   input                               s_tdone;        // Transaction_done in scverify
   
   reg [cwidth-1:0]                    s_din_reg;
   assign s_din = s_din_reg;
   reg                                 s_rrdy_reg;

   wire                                rCatOutOfOrder;
   reg                                 catIsReading;
   integer                             next_raddr;
   
   assign s_rrdy = s_rrdy_reg && !rCatOutOfOrder;
   
   reg                                 s_wrdy_reg;
   assign s_wrdy = s_wrdy_reg && !s_tdone;
   assign is_idle = 0;
   
   // Statemachine for read and write operations are separate
   localparam [2:0] axi4r_idle=0, axi4r_read=1;   
   localparam [2:0] axi4w_idle=0, axi4w_write=1, axi4w_write_done=2,  axi4w_catwrite=3, axi4w_catwrite_done=4;
   localparam addrShift = `CLOG2(DATA_WIDTH/8);

   reg [2:0]     read_state;
   reg [2:0]     write_state;
   
   reg [7:0]     readBurstCnt;  // how many are left

  // Memory embedded in this slave
   reg [cwidth-1:0] mem[depth-1:0];

   wire [ADDR_WIDTH-1:0] wbase_address;
   wire [ADDR_WIDTH-1:0] rbase_address;
   assign wbase_address = wBASE_ADDRESS;
   assign rbase_address = rBASE_ADDRESS;
   
   reg [ADDR_WIDTH-1:0] address;
      
   // AXI4 Bus Read processing
   reg [ADDR_WIDTH-1:0] useAddr ;

   // The "last" catapult address processed in a burst
   integer readAddr;

   always @(posedge ACLK or negedge int_ARESETn) begin
      if (~int_ARESETn) begin
         read_state <= axi4r_idle;
         ARREADY_reg <= 1;
         ARID_reg <= 0;
         RDATA_reg <= 0;
         RRESP_reg <= `AXI4_xRESP_OKAY;
         RLAST_reg <= 0;
         RVALID_reg <= 0;
         readAddr <= 0;
         readBurstCnt <= 0;
      end else begin
         if ((read_state == axi4r_idle) && (ARVALID == 1)) begin
            useAddr = (ARADDR - rbase_address) >> addrShift;
            // Protect from out of range addressing

`ifdef SLAVE_DBG_WRITE
            $display("ARADDR=%d rbase_address=%d addrShift=%d useAddr=%d at T=%t",
                     ARADDR, rbase_address, addrShift, useAddr, $time);
`endif
            if (useAddr < depth) begin
               if (cwidth < DATA_WIDTH) begin
                  //RDATA_reg[DATA_WIDTH-1:cwidth] <= 0;   // vcs doesnt like this
                  //RDATA_reg[cwidth-1:0] <= mem[useAddr];
                  RDATA_reg <= {{DATA_WIDTH - cwidth{1'b0}}, mem[useAddr]};
               end else begin
                  RDATA_reg <= mem[useAddr];
               end
`ifdef SLAVE_DBG_READ
               $display("Slave AXI1 read:mem[%d]=%h at T=%t", useAddr, mem[useAddr], $time);
`endif
            end else begin
               // synopsys translate_off               
               $display("Error:  Out-of-range AXI memory read access:%h at T=%t", ARADDR, $time);
               // synopsys translate_on
            end
            RRESP_reg <= `AXI4_xRESP_OKAY;
            readAddr <= useAddr;            
            readBurstCnt <= ARLEN;
            if (ARLEN== 0) begin
               ARREADY_reg <= 0;        
               RLAST_reg <= 1;
            end
            RVALID_reg <= 1;
            ARID_reg <= ARID;
            read_state <= axi4r_read;
         end else if (read_state == axi4r_read) begin
            if (RREADY == 1) begin
               if (readBurstCnt == 0) begin
                  // we already sent the last data
                  ARREADY_reg <= 1;
                  RRESP_reg <= `AXI4_xRESP_OKAY;
                  RLAST_reg <= 0;
                  RVALID_reg <= 0;
                  read_state <= axi4r_idle;               
               end else begin 
                  useAddr = readAddr + 1;
                  readAddr <= readAddr + 1;
                  // Protect from out of range addressing
                  if (useAddr < depth) begin
                     if (cwidth < DATA_WIDTH) begin
                        //RDATA_reg[DATA_WIDTH-1:cwidth] <= 0;  // vcs errors on this
                        //RDATA_reg[cwidth-1:0] <= mem[useAddr];
                        RDATA_reg <= {{DATA_WIDTH - cwidth{1'b0}}, mem[useAddr]};
                     end else begin
                        RDATA_reg <= mem[useAddr];
                     end
`ifdef SLAVE_DBG_READ
                     $display("Slave AXI2 read:mem[%d]=%h at T=%t", useAddr, mem[useAddr], $time);
`endif
                  end else begin
                     // We bursted right off the end of the array
                     // synopsys translate_off               
                     $display("Error:  Out-of-range AXI memory read access:%h at T=%t", ARADDR, $time);
                     // synopsys translate_on
                  end
                  readBurstCnt <= readBurstCnt - 1;
                  if ((readBurstCnt - 1) == 0) begin
                     ARREADY_reg <= 0;        
                     RRESP_reg <= `AXI4_xRESP_OKAY;
                     RLAST_reg <= 1;
                  end
                  RVALID_reg <= 1;
               end // else: !if(readBurstCnt == 0)
            end // if (RREADY == 1)
         end // if (read_state == axi4r_read)
      end // else: !if(~int_ARESETn)
   end // always@ (posedge ACLK or negedge int_ARESETn)
   

   // AXI and catapult write processing.
   // Catapult write is one-cycle long so basically a write can happen
   // in any axi state.  AXI has precedence in that catapult write is processed
   // first at each cycle
   integer writeAddr;  // last cat addr written
   integer i;
   
   always @(posedge ACLK or negedge int_ARESETn) begin
      if (~int_ARESETn) begin
         AWREADY_reg <= 1;
         AWID_reg <= 0;
         WREADY_reg <= 1;
         BRESP_reg <= `AXI4_xRESP_OKAY;
         BVALID_reg <= 0;
         write_state <= axi4w_idle;
         writeAddr <= 0;
         s_wrdy_reg <= 0;
         // synopsys translate_off
         for (i=0; i<depth; i=i+1) begin
            mem[i] <= 0;
         end
         // synopsys translate_on
      end else begin
         // When in idle state, catapult and AXI can both initiate writes.
         // If to the same address, then AXI wins...
         if ((s_we == 1) && (write_state == axi4w_idle) && !s_tdone) begin
            mem[s_waddr] <= s_dout;
`ifdef SLAVE_DBG_WRITE
            $display("Slave CAT write:mem[%d]=%h at T=%t", s_waddr, s_dout, $time);
`endif
         end
         if ((write_state == axi4w_idle) && (AWVALID == 1)) begin
            s_wrdy_reg <= 0;
            AWREADY_reg <= 0;
            AWID_reg <= AWID;
            useAddr = (AWADDR - wbase_address) >> addrShift;
`ifdef SLAVE_DBG_WRITE
            $display("AWADDR=%d wbase_address=%d addrShift=%d useAddr=%d at T=%t",
                     AWADDR, wbase_address, addrShift, useAddr, $time);
`endif
            if (WVALID == 1) begin
               // allow for address and data to be presented in one cycle
               // Check for the write to be masked
               if (WSTRB != 0) begin // a byte at a time.  Watch for cwidth much less than DATA_WIDTH
                  if (useAddr < depth) begin
                     for (i=0; i<(DATA_WIDTH/8);i=i+1) begin
                        if (WSTRB[i] == 1) begin
                           if ((8*i) < cwidth) begin
                              mem[useAddr][8*i +: 8] <= WDATA[8*i +: 8];
                           end
                        end
                     end
`ifdef SLAVE_DBG_WRITE
                     $display("Slave AXI1 write:mem[%d]=%h at T=%t", useAddr, WDATA, $time);
`endif
                  end else begin
                     // synopsys translate_off               
                     $display("Error:  Out-of-range AXI memory write access:%h at T=%t", AWADDR, $time);
                     // synopsys translate_on
                  end
               end
            end
            writeAddr <= useAddr;
            if ((WLAST == 1) && (WVALID == 1)) begin
               write_state <= axi4w_write_done;
               WREADY_reg <= 0;
               BRESP_reg <= `AXI4_xRESP_OKAY;
               BVALID_reg <= 1;
            end else begin
               write_state <= axi4w_write;
            end
         end else if (write_state == axi4w_write) begin
            if (WVALID == 1) begin
               useAddr = writeAddr+1;
               if (WSTRB != 0) begin // a byte at a time.  Watch for cwidth much less than DATA_WIDTH
                  if (useAddr < depth) begin
                     for (i=0; i<(DATA_WIDTH/8);i=i+1) begin
                        if (WSTRB[i] == 1) begin
                           if ((8*i) < cwidth) begin
                              mem[useAddr][8*i +: 8] <= WDATA[8*i +: 8];
                           end
                        end
                     end
`ifdef SLAVE_DBG_WRITE
                     $display("SLAVE AXI2 write:mem[%d]=%h at T=%t", useAddr, WDATA, $time);
`endif
                  end else begin
                     // synopsys translate_off
                     $display("Error:  Out-of-range AXI memory write access:%h at T=%t", AWADDR, $time);
                     // synopsys translate_on
                  end
               end
               writeAddr <= useAddr;
               if (WLAST == 1) begin
                  write_state <= axi4w_write_done;
                  WREADY_reg <= 0;
                  BRESP_reg <= `AXI4_xRESP_OKAY;
                  BVALID_reg <= 1;
               end 
            end // if (WVALID == 1)
         end else if (write_state == axi4w_write_done) begin // if (write_state == axi4w_write)
            if (BREADY == 1) begin
               AWREADY_reg <= 1;
               WREADY_reg <= 1;
               BRESP_reg <= `AXI4_xRESP_OKAY;
               BVALID_reg <= 0;
               write_state <= axi4w_idle;
               s_wrdy_reg <= 1;
            end
         end else begin
            s_wrdy_reg <= 1;
         end
      end // else: !if(~int_ARESETn)
   end // always@ (posedge ACLK or negedge int_ARESETn)

   assign rCatOutOfOrder = s_re && s_rrdy_reg && catIsReading && (next_raddr != s_raddr+1);
   
   // Catapult read processing
   always @(posedge ACLK or negedge int_ARESETn) begin
      if (~int_ARESETn) begin
         s_din_reg <= 0;
         s_rrdy_reg <= 0;
         catIsReading <= 0;
         next_raddr <= 0;
      end else begin
         // Catapult has read access to memory
         if (tr_write_done == 1'b1) begin
            if (s_re == 1'b1) begin
`ifdef SLAVE_DBG_READ
               $display("Slave CAT read.  Addr=%d nextAddr=%d Data=%d OOO=%d isReading=%d T=%t", s_raddr, next_raddr, 
                        mem[s_raddr], rCatOutOfOrder, catIsReading, $time);
`endif
               if (catIsReading && !rCatOutOfOrder) begin 
                  if (next_raddr < depth) begin
                     s_din_reg <= mem[next_raddr];
                     next_raddr <= next_raddr+1;                  
`ifdef SLAVE_DBG_READ
                     $display("  Burst continues");                  
`endif
                  end else begin
                     s_rrdy_reg <= 0;
                     catIsReading <= 0;
                     next_raddr <= 0;                  
                  end
               end else begin
                  s_din_reg <= mem[s_raddr];
                  s_rrdy_reg <= 1;
                  next_raddr <= s_raddr+1;                  
                  if (catIsReading && rCatOutOfOrder) begin
`ifdef SLAVE_DBG_READ
                     $display("  OutOfOrder");                  
`endif                  
                     catIsReading <= 0;  // a hiccup
                  end else begin
                     catIsReading <= 1;
                  end
               end
            end else begin
               s_rrdy_reg <= 0;
               catIsReading <= 0;
               next_raddr <= 0;
            end
         end else begin 
            s_rrdy_reg <= 0;
            catIsReading <= 0;
            next_raddr <= 0;
         end
      end
   end
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


//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_mul_pipe_beh.v 
//
// File:      $Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_mul_pipe_beh.v
//
// BASELINE:  Catapult-C version 2006b.63
// MODIFIED:  2007-04-03, tnagler
//
// Note: this file uses Verilog2001 features; 
//       please enable Verilog2001 in the flow!

module mgc_mul_pipe (a, b, clk, en, a_rst, s_rst, z);

    // Parameters:
    parameter integer width_a = 32'd4;  // input a bit width
    parameter         signd_a =  1'b1;  // input a type (1=signed, 0=unsigned)
    parameter integer width_b = 32'd4;  // input b bit width
    parameter         signd_b =  1'b1;  // input b type (1=signed, 0=unsigned)
    parameter integer width_z = 32'd8;  // result bit width (= width_a + width_b)
    parameter      clock_edge =  1'b0;  // clock polarity (1=posedge, 0=negedge)
    parameter   enable_active =  1'b0;  // enable polarity (1=posedge, 0=negedge)
    parameter    a_rst_active =  1'b1;  // unused
    parameter    s_rst_active =  1'b1;  // unused
    parameter integer  stages = 32'd2;  // number of output registers + 1 (careful!)
    parameter integer n_inreg = 32'd0;  // number of input registers
   
    localparam integer width_ab = width_a + width_b;  // multiplier result width
    localparam integer n_inreg_min = (n_inreg > 1) ? (n_inreg-1) : 0; // for Synopsys DC
   
    // I/O ports:
    input  [width_a-1:0] a;      // input A
    input  [width_b-1:0] b;      // input B
    input                clk;    // clock
    input                en;     // enable
    input                a_rst;  // async reset (unused)
    input                s_rst;  // sync reset (unused)
    output [width_z-1:0] z;      // output


    // Input registers:

    wire [width_a-1:0] a_f;
    wire [width_b-1:0] b_f;

    integer i;

    generate
    if (clock_edge == 1'b0)
    begin: NEG_EDGE1
        case (n_inreg)
        32'd0: begin: B1
            assign a_f = a, 
                   b_f = b;
        end
        default: begin: B2
            reg [width_a-1:0] a_reg [n_inreg_min:0];
            reg [width_b-1:0] b_reg [n_inreg_min:0];
            always @(negedge clk)
            if (en == enable_active)
            begin: B21
                a_reg[0] <= a;
                b_reg[0] <= b;
                for (i = 0; i < n_inreg_min; i = i + 1)
                begin: B3
                    a_reg[i+1] <= a_reg[i];
                    b_reg[i+1] <= b_reg[i];
                end
            end
            assign a_f = a_reg[n_inreg_min],
                   b_f = b_reg[n_inreg_min];
        end
        endcase
    end
    else
    begin: POS_EDGE1
        case (n_inreg)
        32'd0: begin: B1
            assign a_f = a, 
                   b_f = b;
        end
        default: begin: B2
            reg [width_a-1:0] a_reg [n_inreg_min:0];
            reg [width_b-1:0] b_reg [n_inreg_min:0];
            always @(posedge clk)
            if (en == enable_active)
            begin: B21
                a_reg[0] <= a;
                b_reg[0] <= b;
                for (i = 0; i < n_inreg_min; i = i + 1)
                begin: B3
                    a_reg[i+1] <= a_reg[i];
                    b_reg[i+1] <= b_reg[i];
                end
            end
            assign a_f = a_reg[n_inreg_min],
                   b_f = b_reg[n_inreg_min];
        end
        endcase
    end
    endgenerate


    // Output:
    wire [width_z-1:0]  xz;

    function signed [width_z-1:0] conv_signed;
      input signed [width_ab-1:0] res;
      conv_signed = res[width_z-1:0];
    endfunction

    generate
      wire signed [width_ab-1:0] res;
      if ( (signd_a == 1'b1) && (signd_b == 1'b1) )
      begin: SIGNED_AB
              assign res = $signed(a_f) * $signed(b_f);
              assign xz = conv_signed(res);
      end
      else if ( (signd_a == 1'b1) && (signd_b == 1'b0) )
      begin: SIGNED_A
              assign res = $signed(a_f) * $signed({1'b0, b_f});
              assign xz = conv_signed(res);
      end
      else if ( (signd_a == 1'b0) && (signd_b == 1'b1) )
      begin: SIGNED_B
              assign res = $signed({1'b0,a_f}) * $signed(b_f);
              assign xz = conv_signed(res);
      end
      else
      begin: UNSIGNED_AB
              assign res = a_f * b_f;
	      assign xz = res[width_z-1:0];
      end
    endgenerate


    // Output registers:

    reg  [width_z-1:0] reg_array[stages-2:0];
    wire [width_z-1:0] z;

    generate
    if (clock_edge == 1'b0)
    begin: NEG_EDGE2
        always @(negedge clk)
        if (en == enable_active)
            for (i = stages-2; i >= 0; i = i-1)
                if (i == 0)
                    reg_array[i] <= xz;
                else
                    reg_array[i] <= reg_array[i-1];
    end
    else
    begin: POS_EDGE2
        always @(posedge clk)
        if (en == enable_active)
            for (i = stages-2; i >= 0; i = i-1)
                if (i == 0)
                    reg_array[i] <= xz;
                else
                    reg_array[i] <= reg_array[i-1];
    end
    endgenerate

    assign z = reg_array[stages-2];
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
//  Generated by:   jd4691@newnano.poly.edu
//  Generated date: Mon Sep 13 23:01:29 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    hybrid_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_9_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module hybrid_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_9_10_32_1024_1024_32_1_gen (
  clken, q, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [31:0] q;
  output [9:0] radr;
  output we;
  output [31:0] d;
  output [9:0] wadr;
  input clken_d;
  input [31:0] d_d;
  output [31:0] q_d;
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
//  Design Unit:    hybrid_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_8_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module hybrid_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_8_10_32_1024_1024_32_1_gen (
  clken, q, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [31:0] q;
  output [9:0] radr;
  output we;
  output [31:0] d;
  output [9:0] wadr;
  input clken_d;
  input [31:0] d_d;
  output [31:0] q_d;
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
//  Design Unit:    hybrid_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module hybrid_core_core_fsm (
  clk, rst, core_wen, fsm_output, S1_OUTER_LOOP_for_C_4_tr0, S1_OUTER_LOOP_C_0_tr0,
      S2_COPY_LOOP_for_C_3_tr0, S2_COPY_LOOP_C_0_tr0, S2_INNER_LOOP1_for_C_23_tr0,
      S2_INNER_LOOP1_C_0_tr0, S2_INNER_LOOP2_for_C_23_tr0, S2_INNER_LOOP2_C_0_tr0,
      S2_INNER_LOOP2_C_0_tr1, S2_INNER_LOOP3_for_C_23_tr0, S2_INNER_LOOP3_C_0_tr0,
      S34_OUTER_LOOP_for_C_12_tr0, S34_OUTER_LOOP_C_0_tr0, S5_COPY_LOOP_for_C_3_tr0,
      S5_COPY_LOOP_C_0_tr0, S5_INNER_LOOP1_for_C_23_tr0, S5_INNER_LOOP1_C_0_tr0,
      S5_INNER_LOOP2_for_C_23_tr0, S5_INNER_LOOP2_C_0_tr0, S5_INNER_LOOP2_C_0_tr1,
      S5_INNER_LOOP3_for_C_23_tr0, S5_INNER_LOOP3_C_0_tr0, S6_OUTER_LOOP_for_C_3_tr0,
      S6_OUTER_LOOP_C_0_tr0
);
  input clk;
  input rst;
  input core_wen;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input S1_OUTER_LOOP_for_C_4_tr0;
  input S1_OUTER_LOOP_C_0_tr0;
  input S2_COPY_LOOP_for_C_3_tr0;
  input S2_COPY_LOOP_C_0_tr0;
  input S2_INNER_LOOP1_for_C_23_tr0;
  input S2_INNER_LOOP1_C_0_tr0;
  input S2_INNER_LOOP2_for_C_23_tr0;
  input S2_INNER_LOOP2_C_0_tr0;
  input S2_INNER_LOOP2_C_0_tr1;
  input S2_INNER_LOOP3_for_C_23_tr0;
  input S2_INNER_LOOP3_C_0_tr0;
  input S34_OUTER_LOOP_for_C_12_tr0;
  input S34_OUTER_LOOP_C_0_tr0;
  input S5_COPY_LOOP_for_C_3_tr0;
  input S5_COPY_LOOP_C_0_tr0;
  input S5_INNER_LOOP1_for_C_23_tr0;
  input S5_INNER_LOOP1_C_0_tr0;
  input S5_INNER_LOOP2_for_C_23_tr0;
  input S5_INNER_LOOP2_C_0_tr0;
  input S5_INNER_LOOP2_C_0_tr1;
  input S5_INNER_LOOP3_for_C_23_tr0;
  input S5_INNER_LOOP3_C_0_tr0;
  input S6_OUTER_LOOP_for_C_3_tr0;
  input S6_OUTER_LOOP_C_0_tr0;


  // FSM State Type Declaration for hybrid_core_core_fsm_1
  parameter
    main_C_0 = 8'd0,
    S1_OUTER_LOOP_for_C_0 = 8'd1,
    S1_OUTER_LOOP_for_C_1 = 8'd2,
    S1_OUTER_LOOP_for_C_2 = 8'd3,
    S1_OUTER_LOOP_for_C_3 = 8'd4,
    S1_OUTER_LOOP_for_C_4 = 8'd5,
    S1_OUTER_LOOP_C_0 = 8'd6,
    S2_COPY_LOOP_for_C_0 = 8'd7,
    S2_COPY_LOOP_for_C_1 = 8'd8,
    S2_COPY_LOOP_for_C_2 = 8'd9,
    S2_COPY_LOOP_for_C_3 = 8'd10,
    S2_COPY_LOOP_C_0 = 8'd11,
    S2_OUTER_LOOP_C_0 = 8'd12,
    S2_INNER_LOOP1_for_C_0 = 8'd13,
    S2_INNER_LOOP1_for_C_1 = 8'd14,
    S2_INNER_LOOP1_for_C_2 = 8'd15,
    S2_INNER_LOOP1_for_C_3 = 8'd16,
    S2_INNER_LOOP1_for_C_4 = 8'd17,
    S2_INNER_LOOP1_for_C_5 = 8'd18,
    S2_INNER_LOOP1_for_C_6 = 8'd19,
    S2_INNER_LOOP1_for_C_7 = 8'd20,
    S2_INNER_LOOP1_for_C_8 = 8'd21,
    S2_INNER_LOOP1_for_C_9 = 8'd22,
    S2_INNER_LOOP1_for_C_10 = 8'd23,
    S2_INNER_LOOP1_for_C_11 = 8'd24,
    S2_INNER_LOOP1_for_C_12 = 8'd25,
    S2_INNER_LOOP1_for_C_13 = 8'd26,
    S2_INNER_LOOP1_for_C_14 = 8'd27,
    S2_INNER_LOOP1_for_C_15 = 8'd28,
    S2_INNER_LOOP1_for_C_16 = 8'd29,
    S2_INNER_LOOP1_for_C_17 = 8'd30,
    S2_INNER_LOOP1_for_C_18 = 8'd31,
    S2_INNER_LOOP1_for_C_19 = 8'd32,
    S2_INNER_LOOP1_for_C_20 = 8'd33,
    S2_INNER_LOOP1_for_C_21 = 8'd34,
    S2_INNER_LOOP1_for_C_22 = 8'd35,
    S2_INNER_LOOP1_for_C_23 = 8'd36,
    S2_INNER_LOOP1_C_0 = 8'd37,
    S2_OUTER_LOOP_C_1 = 8'd38,
    S2_INNER_LOOP2_for_C_0 = 8'd39,
    S2_INNER_LOOP2_for_C_1 = 8'd40,
    S2_INNER_LOOP2_for_C_2 = 8'd41,
    S2_INNER_LOOP2_for_C_3 = 8'd42,
    S2_INNER_LOOP2_for_C_4 = 8'd43,
    S2_INNER_LOOP2_for_C_5 = 8'd44,
    S2_INNER_LOOP2_for_C_6 = 8'd45,
    S2_INNER_LOOP2_for_C_7 = 8'd46,
    S2_INNER_LOOP2_for_C_8 = 8'd47,
    S2_INNER_LOOP2_for_C_9 = 8'd48,
    S2_INNER_LOOP2_for_C_10 = 8'd49,
    S2_INNER_LOOP2_for_C_11 = 8'd50,
    S2_INNER_LOOP2_for_C_12 = 8'd51,
    S2_INNER_LOOP2_for_C_13 = 8'd52,
    S2_INNER_LOOP2_for_C_14 = 8'd53,
    S2_INNER_LOOP2_for_C_15 = 8'd54,
    S2_INNER_LOOP2_for_C_16 = 8'd55,
    S2_INNER_LOOP2_for_C_17 = 8'd56,
    S2_INNER_LOOP2_for_C_18 = 8'd57,
    S2_INNER_LOOP2_for_C_19 = 8'd58,
    S2_INNER_LOOP2_for_C_20 = 8'd59,
    S2_INNER_LOOP2_for_C_21 = 8'd60,
    S2_INNER_LOOP2_for_C_22 = 8'd61,
    S2_INNER_LOOP2_for_C_23 = 8'd62,
    S2_INNER_LOOP2_C_0 = 8'd63,
    S2_INNER_LOOP3_for_C_0 = 8'd64,
    S2_INNER_LOOP3_for_C_1 = 8'd65,
    S2_INNER_LOOP3_for_C_2 = 8'd66,
    S2_INNER_LOOP3_for_C_3 = 8'd67,
    S2_INNER_LOOP3_for_C_4 = 8'd68,
    S2_INNER_LOOP3_for_C_5 = 8'd69,
    S2_INNER_LOOP3_for_C_6 = 8'd70,
    S2_INNER_LOOP3_for_C_7 = 8'd71,
    S2_INNER_LOOP3_for_C_8 = 8'd72,
    S2_INNER_LOOP3_for_C_9 = 8'd73,
    S2_INNER_LOOP3_for_C_10 = 8'd74,
    S2_INNER_LOOP3_for_C_11 = 8'd75,
    S2_INNER_LOOP3_for_C_12 = 8'd76,
    S2_INNER_LOOP3_for_C_13 = 8'd77,
    S2_INNER_LOOP3_for_C_14 = 8'd78,
    S2_INNER_LOOP3_for_C_15 = 8'd79,
    S2_INNER_LOOP3_for_C_16 = 8'd80,
    S2_INNER_LOOP3_for_C_17 = 8'd81,
    S2_INNER_LOOP3_for_C_18 = 8'd82,
    S2_INNER_LOOP3_for_C_19 = 8'd83,
    S2_INNER_LOOP3_for_C_20 = 8'd84,
    S2_INNER_LOOP3_for_C_21 = 8'd85,
    S2_INNER_LOOP3_for_C_22 = 8'd86,
    S2_INNER_LOOP3_for_C_23 = 8'd87,
    S2_INNER_LOOP3_C_0 = 8'd88,
    S34_OUTER_LOOP_for_C_0 = 8'd89,
    S34_OUTER_LOOP_for_C_1 = 8'd90,
    S34_OUTER_LOOP_for_C_2 = 8'd91,
    S34_OUTER_LOOP_for_C_3 = 8'd92,
    S34_OUTER_LOOP_for_C_4 = 8'd93,
    S34_OUTER_LOOP_for_C_5 = 8'd94,
    S34_OUTER_LOOP_for_C_6 = 8'd95,
    S34_OUTER_LOOP_for_C_7 = 8'd96,
    S34_OUTER_LOOP_for_C_8 = 8'd97,
    S34_OUTER_LOOP_for_C_9 = 8'd98,
    S34_OUTER_LOOP_for_C_10 = 8'd99,
    S34_OUTER_LOOP_for_C_11 = 8'd100,
    S34_OUTER_LOOP_for_C_12 = 8'd101,
    S34_OUTER_LOOP_C_0 = 8'd102,
    S5_COPY_LOOP_for_C_0 = 8'd103,
    S5_COPY_LOOP_for_C_1 = 8'd104,
    S5_COPY_LOOP_for_C_2 = 8'd105,
    S5_COPY_LOOP_for_C_3 = 8'd106,
    S5_COPY_LOOP_C_0 = 8'd107,
    S5_OUTER_LOOP_C_0 = 8'd108,
    S5_INNER_LOOP1_for_C_0 = 8'd109,
    S5_INNER_LOOP1_for_C_1 = 8'd110,
    S5_INNER_LOOP1_for_C_2 = 8'd111,
    S5_INNER_LOOP1_for_C_3 = 8'd112,
    S5_INNER_LOOP1_for_C_4 = 8'd113,
    S5_INNER_LOOP1_for_C_5 = 8'd114,
    S5_INNER_LOOP1_for_C_6 = 8'd115,
    S5_INNER_LOOP1_for_C_7 = 8'd116,
    S5_INNER_LOOP1_for_C_8 = 8'd117,
    S5_INNER_LOOP1_for_C_9 = 8'd118,
    S5_INNER_LOOP1_for_C_10 = 8'd119,
    S5_INNER_LOOP1_for_C_11 = 8'd120,
    S5_INNER_LOOP1_for_C_12 = 8'd121,
    S5_INNER_LOOP1_for_C_13 = 8'd122,
    S5_INNER_LOOP1_for_C_14 = 8'd123,
    S5_INNER_LOOP1_for_C_15 = 8'd124,
    S5_INNER_LOOP1_for_C_16 = 8'd125,
    S5_INNER_LOOP1_for_C_17 = 8'd126,
    S5_INNER_LOOP1_for_C_18 = 8'd127,
    S5_INNER_LOOP1_for_C_19 = 8'd128,
    S5_INNER_LOOP1_for_C_20 = 8'd129,
    S5_INNER_LOOP1_for_C_21 = 8'd130,
    S5_INNER_LOOP1_for_C_22 = 8'd131,
    S5_INNER_LOOP1_for_C_23 = 8'd132,
    S5_INNER_LOOP1_C_0 = 8'd133,
    S5_OUTER_LOOP_C_1 = 8'd134,
    S5_INNER_LOOP2_for_C_0 = 8'd135,
    S5_INNER_LOOP2_for_C_1 = 8'd136,
    S5_INNER_LOOP2_for_C_2 = 8'd137,
    S5_INNER_LOOP2_for_C_3 = 8'd138,
    S5_INNER_LOOP2_for_C_4 = 8'd139,
    S5_INNER_LOOP2_for_C_5 = 8'd140,
    S5_INNER_LOOP2_for_C_6 = 8'd141,
    S5_INNER_LOOP2_for_C_7 = 8'd142,
    S5_INNER_LOOP2_for_C_8 = 8'd143,
    S5_INNER_LOOP2_for_C_9 = 8'd144,
    S5_INNER_LOOP2_for_C_10 = 8'd145,
    S5_INNER_LOOP2_for_C_11 = 8'd146,
    S5_INNER_LOOP2_for_C_12 = 8'd147,
    S5_INNER_LOOP2_for_C_13 = 8'd148,
    S5_INNER_LOOP2_for_C_14 = 8'd149,
    S5_INNER_LOOP2_for_C_15 = 8'd150,
    S5_INNER_LOOP2_for_C_16 = 8'd151,
    S5_INNER_LOOP2_for_C_17 = 8'd152,
    S5_INNER_LOOP2_for_C_18 = 8'd153,
    S5_INNER_LOOP2_for_C_19 = 8'd154,
    S5_INNER_LOOP2_for_C_20 = 8'd155,
    S5_INNER_LOOP2_for_C_21 = 8'd156,
    S5_INNER_LOOP2_for_C_22 = 8'd157,
    S5_INNER_LOOP2_for_C_23 = 8'd158,
    S5_INNER_LOOP2_C_0 = 8'd159,
    S5_INNER_LOOP3_for_C_0 = 8'd160,
    S5_INNER_LOOP3_for_C_1 = 8'd161,
    S5_INNER_LOOP3_for_C_2 = 8'd162,
    S5_INNER_LOOP3_for_C_3 = 8'd163,
    S5_INNER_LOOP3_for_C_4 = 8'd164,
    S5_INNER_LOOP3_for_C_5 = 8'd165,
    S5_INNER_LOOP3_for_C_6 = 8'd166,
    S5_INNER_LOOP3_for_C_7 = 8'd167,
    S5_INNER_LOOP3_for_C_8 = 8'd168,
    S5_INNER_LOOP3_for_C_9 = 8'd169,
    S5_INNER_LOOP3_for_C_10 = 8'd170,
    S5_INNER_LOOP3_for_C_11 = 8'd171,
    S5_INNER_LOOP3_for_C_12 = 8'd172,
    S5_INNER_LOOP3_for_C_13 = 8'd173,
    S5_INNER_LOOP3_for_C_14 = 8'd174,
    S5_INNER_LOOP3_for_C_15 = 8'd175,
    S5_INNER_LOOP3_for_C_16 = 8'd176,
    S5_INNER_LOOP3_for_C_17 = 8'd177,
    S5_INNER_LOOP3_for_C_18 = 8'd178,
    S5_INNER_LOOP3_for_C_19 = 8'd179,
    S5_INNER_LOOP3_for_C_20 = 8'd180,
    S5_INNER_LOOP3_for_C_21 = 8'd181,
    S5_INNER_LOOP3_for_C_22 = 8'd182,
    S5_INNER_LOOP3_for_C_23 = 8'd183,
    S5_INNER_LOOP3_C_0 = 8'd184,
    S6_OUTER_LOOP_for_C_0 = 8'd185,
    S6_OUTER_LOOP_for_C_1 = 8'd186,
    S6_OUTER_LOOP_for_C_2 = 8'd187,
    S6_OUTER_LOOP_for_C_3 = 8'd188,
    S6_OUTER_LOOP_C_0 = 8'd189,
    main_C_1 = 8'd190;

  reg [7:0] state_var;
  reg [7:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : hybrid_core_core_fsm_1
    case (state_var)
      S1_OUTER_LOOP_for_C_0 : begin
        fsm_output = 8'b00000001;
        state_var_NS = S1_OUTER_LOOP_for_C_1;
      end
      S1_OUTER_LOOP_for_C_1 : begin
        fsm_output = 8'b00000010;
        state_var_NS = S1_OUTER_LOOP_for_C_2;
      end
      S1_OUTER_LOOP_for_C_2 : begin
        fsm_output = 8'b00000011;
        state_var_NS = S1_OUTER_LOOP_for_C_3;
      end
      S1_OUTER_LOOP_for_C_3 : begin
        fsm_output = 8'b00000100;
        state_var_NS = S1_OUTER_LOOP_for_C_4;
      end
      S1_OUTER_LOOP_for_C_4 : begin
        fsm_output = 8'b00000101;
        if ( S1_OUTER_LOOP_for_C_4_tr0 ) begin
          state_var_NS = S1_OUTER_LOOP_C_0;
        end
        else begin
          state_var_NS = S1_OUTER_LOOP_for_C_0;
        end
      end
      S1_OUTER_LOOP_C_0 : begin
        fsm_output = 8'b00000110;
        if ( S1_OUTER_LOOP_C_0_tr0 ) begin
          state_var_NS = S2_COPY_LOOP_for_C_0;
        end
        else begin
          state_var_NS = S1_OUTER_LOOP_for_C_0;
        end
      end
      S2_COPY_LOOP_for_C_0 : begin
        fsm_output = 8'b00000111;
        state_var_NS = S2_COPY_LOOP_for_C_1;
      end
      S2_COPY_LOOP_for_C_1 : begin
        fsm_output = 8'b00001000;
        state_var_NS = S2_COPY_LOOP_for_C_2;
      end
      S2_COPY_LOOP_for_C_2 : begin
        fsm_output = 8'b00001001;
        state_var_NS = S2_COPY_LOOP_for_C_3;
      end
      S2_COPY_LOOP_for_C_3 : begin
        fsm_output = 8'b00001010;
        if ( S2_COPY_LOOP_for_C_3_tr0 ) begin
          state_var_NS = S2_COPY_LOOP_C_0;
        end
        else begin
          state_var_NS = S2_COPY_LOOP_for_C_0;
        end
      end
      S2_COPY_LOOP_C_0 : begin
        fsm_output = 8'b00001011;
        if ( S2_COPY_LOOP_C_0_tr0 ) begin
          state_var_NS = S2_OUTER_LOOP_C_0;
        end
        else begin
          state_var_NS = S2_COPY_LOOP_for_C_0;
        end
      end
      S2_OUTER_LOOP_C_0 : begin
        fsm_output = 8'b00001100;
        state_var_NS = S2_INNER_LOOP1_for_C_0;
      end
      S2_INNER_LOOP1_for_C_0 : begin
        fsm_output = 8'b00001101;
        state_var_NS = S2_INNER_LOOP1_for_C_1;
      end
      S2_INNER_LOOP1_for_C_1 : begin
        fsm_output = 8'b00001110;
        state_var_NS = S2_INNER_LOOP1_for_C_2;
      end
      S2_INNER_LOOP1_for_C_2 : begin
        fsm_output = 8'b00001111;
        state_var_NS = S2_INNER_LOOP1_for_C_3;
      end
      S2_INNER_LOOP1_for_C_3 : begin
        fsm_output = 8'b00010000;
        state_var_NS = S2_INNER_LOOP1_for_C_4;
      end
      S2_INNER_LOOP1_for_C_4 : begin
        fsm_output = 8'b00010001;
        state_var_NS = S2_INNER_LOOP1_for_C_5;
      end
      S2_INNER_LOOP1_for_C_5 : begin
        fsm_output = 8'b00010010;
        state_var_NS = S2_INNER_LOOP1_for_C_6;
      end
      S2_INNER_LOOP1_for_C_6 : begin
        fsm_output = 8'b00010011;
        state_var_NS = S2_INNER_LOOP1_for_C_7;
      end
      S2_INNER_LOOP1_for_C_7 : begin
        fsm_output = 8'b00010100;
        state_var_NS = S2_INNER_LOOP1_for_C_8;
      end
      S2_INNER_LOOP1_for_C_8 : begin
        fsm_output = 8'b00010101;
        state_var_NS = S2_INNER_LOOP1_for_C_9;
      end
      S2_INNER_LOOP1_for_C_9 : begin
        fsm_output = 8'b00010110;
        state_var_NS = S2_INNER_LOOP1_for_C_10;
      end
      S2_INNER_LOOP1_for_C_10 : begin
        fsm_output = 8'b00010111;
        state_var_NS = S2_INNER_LOOP1_for_C_11;
      end
      S2_INNER_LOOP1_for_C_11 : begin
        fsm_output = 8'b00011000;
        state_var_NS = S2_INNER_LOOP1_for_C_12;
      end
      S2_INNER_LOOP1_for_C_12 : begin
        fsm_output = 8'b00011001;
        state_var_NS = S2_INNER_LOOP1_for_C_13;
      end
      S2_INNER_LOOP1_for_C_13 : begin
        fsm_output = 8'b00011010;
        state_var_NS = S2_INNER_LOOP1_for_C_14;
      end
      S2_INNER_LOOP1_for_C_14 : begin
        fsm_output = 8'b00011011;
        state_var_NS = S2_INNER_LOOP1_for_C_15;
      end
      S2_INNER_LOOP1_for_C_15 : begin
        fsm_output = 8'b00011100;
        state_var_NS = S2_INNER_LOOP1_for_C_16;
      end
      S2_INNER_LOOP1_for_C_16 : begin
        fsm_output = 8'b00011101;
        state_var_NS = S2_INNER_LOOP1_for_C_17;
      end
      S2_INNER_LOOP1_for_C_17 : begin
        fsm_output = 8'b00011110;
        state_var_NS = S2_INNER_LOOP1_for_C_18;
      end
      S2_INNER_LOOP1_for_C_18 : begin
        fsm_output = 8'b00011111;
        state_var_NS = S2_INNER_LOOP1_for_C_19;
      end
      S2_INNER_LOOP1_for_C_19 : begin
        fsm_output = 8'b00100000;
        state_var_NS = S2_INNER_LOOP1_for_C_20;
      end
      S2_INNER_LOOP1_for_C_20 : begin
        fsm_output = 8'b00100001;
        state_var_NS = S2_INNER_LOOP1_for_C_21;
      end
      S2_INNER_LOOP1_for_C_21 : begin
        fsm_output = 8'b00100010;
        state_var_NS = S2_INNER_LOOP1_for_C_22;
      end
      S2_INNER_LOOP1_for_C_22 : begin
        fsm_output = 8'b00100011;
        state_var_NS = S2_INNER_LOOP1_for_C_23;
      end
      S2_INNER_LOOP1_for_C_23 : begin
        fsm_output = 8'b00100100;
        if ( S2_INNER_LOOP1_for_C_23_tr0 ) begin
          state_var_NS = S2_INNER_LOOP1_C_0;
        end
        else begin
          state_var_NS = S2_INNER_LOOP1_for_C_0;
        end
      end
      S2_INNER_LOOP1_C_0 : begin
        fsm_output = 8'b00100101;
        if ( S2_INNER_LOOP1_C_0_tr0 ) begin
          state_var_NS = S2_OUTER_LOOP_C_1;
        end
        else begin
          state_var_NS = S2_INNER_LOOP1_for_C_0;
        end
      end
      S2_OUTER_LOOP_C_1 : begin
        fsm_output = 8'b00100110;
        state_var_NS = S2_INNER_LOOP2_for_C_0;
      end
      S2_INNER_LOOP2_for_C_0 : begin
        fsm_output = 8'b00100111;
        state_var_NS = S2_INNER_LOOP2_for_C_1;
      end
      S2_INNER_LOOP2_for_C_1 : begin
        fsm_output = 8'b00101000;
        state_var_NS = S2_INNER_LOOP2_for_C_2;
      end
      S2_INNER_LOOP2_for_C_2 : begin
        fsm_output = 8'b00101001;
        state_var_NS = S2_INNER_LOOP2_for_C_3;
      end
      S2_INNER_LOOP2_for_C_3 : begin
        fsm_output = 8'b00101010;
        state_var_NS = S2_INNER_LOOP2_for_C_4;
      end
      S2_INNER_LOOP2_for_C_4 : begin
        fsm_output = 8'b00101011;
        state_var_NS = S2_INNER_LOOP2_for_C_5;
      end
      S2_INNER_LOOP2_for_C_5 : begin
        fsm_output = 8'b00101100;
        state_var_NS = S2_INNER_LOOP2_for_C_6;
      end
      S2_INNER_LOOP2_for_C_6 : begin
        fsm_output = 8'b00101101;
        state_var_NS = S2_INNER_LOOP2_for_C_7;
      end
      S2_INNER_LOOP2_for_C_7 : begin
        fsm_output = 8'b00101110;
        state_var_NS = S2_INNER_LOOP2_for_C_8;
      end
      S2_INNER_LOOP2_for_C_8 : begin
        fsm_output = 8'b00101111;
        state_var_NS = S2_INNER_LOOP2_for_C_9;
      end
      S2_INNER_LOOP2_for_C_9 : begin
        fsm_output = 8'b00110000;
        state_var_NS = S2_INNER_LOOP2_for_C_10;
      end
      S2_INNER_LOOP2_for_C_10 : begin
        fsm_output = 8'b00110001;
        state_var_NS = S2_INNER_LOOP2_for_C_11;
      end
      S2_INNER_LOOP2_for_C_11 : begin
        fsm_output = 8'b00110010;
        state_var_NS = S2_INNER_LOOP2_for_C_12;
      end
      S2_INNER_LOOP2_for_C_12 : begin
        fsm_output = 8'b00110011;
        state_var_NS = S2_INNER_LOOP2_for_C_13;
      end
      S2_INNER_LOOP2_for_C_13 : begin
        fsm_output = 8'b00110100;
        state_var_NS = S2_INNER_LOOP2_for_C_14;
      end
      S2_INNER_LOOP2_for_C_14 : begin
        fsm_output = 8'b00110101;
        state_var_NS = S2_INNER_LOOP2_for_C_15;
      end
      S2_INNER_LOOP2_for_C_15 : begin
        fsm_output = 8'b00110110;
        state_var_NS = S2_INNER_LOOP2_for_C_16;
      end
      S2_INNER_LOOP2_for_C_16 : begin
        fsm_output = 8'b00110111;
        state_var_NS = S2_INNER_LOOP2_for_C_17;
      end
      S2_INNER_LOOP2_for_C_17 : begin
        fsm_output = 8'b00111000;
        state_var_NS = S2_INNER_LOOP2_for_C_18;
      end
      S2_INNER_LOOP2_for_C_18 : begin
        fsm_output = 8'b00111001;
        state_var_NS = S2_INNER_LOOP2_for_C_19;
      end
      S2_INNER_LOOP2_for_C_19 : begin
        fsm_output = 8'b00111010;
        state_var_NS = S2_INNER_LOOP2_for_C_20;
      end
      S2_INNER_LOOP2_for_C_20 : begin
        fsm_output = 8'b00111011;
        state_var_NS = S2_INNER_LOOP2_for_C_21;
      end
      S2_INNER_LOOP2_for_C_21 : begin
        fsm_output = 8'b00111100;
        state_var_NS = S2_INNER_LOOP2_for_C_22;
      end
      S2_INNER_LOOP2_for_C_22 : begin
        fsm_output = 8'b00111101;
        state_var_NS = S2_INNER_LOOP2_for_C_23;
      end
      S2_INNER_LOOP2_for_C_23 : begin
        fsm_output = 8'b00111110;
        if ( S2_INNER_LOOP2_for_C_23_tr0 ) begin
          state_var_NS = S2_INNER_LOOP2_C_0;
        end
        else begin
          state_var_NS = S2_INNER_LOOP2_for_C_0;
        end
      end
      S2_INNER_LOOP2_C_0 : begin
        fsm_output = 8'b00111111;
        if ( S2_INNER_LOOP2_C_0_tr0 ) begin
          state_var_NS = S2_INNER_LOOP3_for_C_0;
        end
        else if ( S2_INNER_LOOP2_C_0_tr1 ) begin
          state_var_NS = S2_INNER_LOOP2_for_C_0;
        end
        else begin
          state_var_NS = S2_OUTER_LOOP_C_0;
        end
      end
      S2_INNER_LOOP3_for_C_0 : begin
        fsm_output = 8'b01000000;
        state_var_NS = S2_INNER_LOOP3_for_C_1;
      end
      S2_INNER_LOOP3_for_C_1 : begin
        fsm_output = 8'b01000001;
        state_var_NS = S2_INNER_LOOP3_for_C_2;
      end
      S2_INNER_LOOP3_for_C_2 : begin
        fsm_output = 8'b01000010;
        state_var_NS = S2_INNER_LOOP3_for_C_3;
      end
      S2_INNER_LOOP3_for_C_3 : begin
        fsm_output = 8'b01000011;
        state_var_NS = S2_INNER_LOOP3_for_C_4;
      end
      S2_INNER_LOOP3_for_C_4 : begin
        fsm_output = 8'b01000100;
        state_var_NS = S2_INNER_LOOP3_for_C_5;
      end
      S2_INNER_LOOP3_for_C_5 : begin
        fsm_output = 8'b01000101;
        state_var_NS = S2_INNER_LOOP3_for_C_6;
      end
      S2_INNER_LOOP3_for_C_6 : begin
        fsm_output = 8'b01000110;
        state_var_NS = S2_INNER_LOOP3_for_C_7;
      end
      S2_INNER_LOOP3_for_C_7 : begin
        fsm_output = 8'b01000111;
        state_var_NS = S2_INNER_LOOP3_for_C_8;
      end
      S2_INNER_LOOP3_for_C_8 : begin
        fsm_output = 8'b01001000;
        state_var_NS = S2_INNER_LOOP3_for_C_9;
      end
      S2_INNER_LOOP3_for_C_9 : begin
        fsm_output = 8'b01001001;
        state_var_NS = S2_INNER_LOOP3_for_C_10;
      end
      S2_INNER_LOOP3_for_C_10 : begin
        fsm_output = 8'b01001010;
        state_var_NS = S2_INNER_LOOP3_for_C_11;
      end
      S2_INNER_LOOP3_for_C_11 : begin
        fsm_output = 8'b01001011;
        state_var_NS = S2_INNER_LOOP3_for_C_12;
      end
      S2_INNER_LOOP3_for_C_12 : begin
        fsm_output = 8'b01001100;
        state_var_NS = S2_INNER_LOOP3_for_C_13;
      end
      S2_INNER_LOOP3_for_C_13 : begin
        fsm_output = 8'b01001101;
        state_var_NS = S2_INNER_LOOP3_for_C_14;
      end
      S2_INNER_LOOP3_for_C_14 : begin
        fsm_output = 8'b01001110;
        state_var_NS = S2_INNER_LOOP3_for_C_15;
      end
      S2_INNER_LOOP3_for_C_15 : begin
        fsm_output = 8'b01001111;
        state_var_NS = S2_INNER_LOOP3_for_C_16;
      end
      S2_INNER_LOOP3_for_C_16 : begin
        fsm_output = 8'b01010000;
        state_var_NS = S2_INNER_LOOP3_for_C_17;
      end
      S2_INNER_LOOP3_for_C_17 : begin
        fsm_output = 8'b01010001;
        state_var_NS = S2_INNER_LOOP3_for_C_18;
      end
      S2_INNER_LOOP3_for_C_18 : begin
        fsm_output = 8'b01010010;
        state_var_NS = S2_INNER_LOOP3_for_C_19;
      end
      S2_INNER_LOOP3_for_C_19 : begin
        fsm_output = 8'b01010011;
        state_var_NS = S2_INNER_LOOP3_for_C_20;
      end
      S2_INNER_LOOP3_for_C_20 : begin
        fsm_output = 8'b01010100;
        state_var_NS = S2_INNER_LOOP3_for_C_21;
      end
      S2_INNER_LOOP3_for_C_21 : begin
        fsm_output = 8'b01010101;
        state_var_NS = S2_INNER_LOOP3_for_C_22;
      end
      S2_INNER_LOOP3_for_C_22 : begin
        fsm_output = 8'b01010110;
        state_var_NS = S2_INNER_LOOP3_for_C_23;
      end
      S2_INNER_LOOP3_for_C_23 : begin
        fsm_output = 8'b01010111;
        if ( S2_INNER_LOOP3_for_C_23_tr0 ) begin
          state_var_NS = S2_INNER_LOOP3_C_0;
        end
        else begin
          state_var_NS = S2_INNER_LOOP3_for_C_0;
        end
      end
      S2_INNER_LOOP3_C_0 : begin
        fsm_output = 8'b01011000;
        if ( S2_INNER_LOOP3_C_0_tr0 ) begin
          state_var_NS = S34_OUTER_LOOP_for_C_0;
        end
        else begin
          state_var_NS = S2_INNER_LOOP3_for_C_0;
        end
      end
      S34_OUTER_LOOP_for_C_0 : begin
        fsm_output = 8'b01011001;
        state_var_NS = S34_OUTER_LOOP_for_C_1;
      end
      S34_OUTER_LOOP_for_C_1 : begin
        fsm_output = 8'b01011010;
        state_var_NS = S34_OUTER_LOOP_for_C_2;
      end
      S34_OUTER_LOOP_for_C_2 : begin
        fsm_output = 8'b01011011;
        state_var_NS = S34_OUTER_LOOP_for_C_3;
      end
      S34_OUTER_LOOP_for_C_3 : begin
        fsm_output = 8'b01011100;
        state_var_NS = S34_OUTER_LOOP_for_C_4;
      end
      S34_OUTER_LOOP_for_C_4 : begin
        fsm_output = 8'b01011101;
        state_var_NS = S34_OUTER_LOOP_for_C_5;
      end
      S34_OUTER_LOOP_for_C_5 : begin
        fsm_output = 8'b01011110;
        state_var_NS = S34_OUTER_LOOP_for_C_6;
      end
      S34_OUTER_LOOP_for_C_6 : begin
        fsm_output = 8'b01011111;
        state_var_NS = S34_OUTER_LOOP_for_C_7;
      end
      S34_OUTER_LOOP_for_C_7 : begin
        fsm_output = 8'b01100000;
        state_var_NS = S34_OUTER_LOOP_for_C_8;
      end
      S34_OUTER_LOOP_for_C_8 : begin
        fsm_output = 8'b01100001;
        state_var_NS = S34_OUTER_LOOP_for_C_9;
      end
      S34_OUTER_LOOP_for_C_9 : begin
        fsm_output = 8'b01100010;
        state_var_NS = S34_OUTER_LOOP_for_C_10;
      end
      S34_OUTER_LOOP_for_C_10 : begin
        fsm_output = 8'b01100011;
        state_var_NS = S34_OUTER_LOOP_for_C_11;
      end
      S34_OUTER_LOOP_for_C_11 : begin
        fsm_output = 8'b01100100;
        state_var_NS = S34_OUTER_LOOP_for_C_12;
      end
      S34_OUTER_LOOP_for_C_12 : begin
        fsm_output = 8'b01100101;
        if ( S34_OUTER_LOOP_for_C_12_tr0 ) begin
          state_var_NS = S34_OUTER_LOOP_C_0;
        end
        else begin
          state_var_NS = S34_OUTER_LOOP_for_C_0;
        end
      end
      S34_OUTER_LOOP_C_0 : begin
        fsm_output = 8'b01100110;
        if ( S34_OUTER_LOOP_C_0_tr0 ) begin
          state_var_NS = S5_COPY_LOOP_for_C_0;
        end
        else begin
          state_var_NS = S34_OUTER_LOOP_for_C_0;
        end
      end
      S5_COPY_LOOP_for_C_0 : begin
        fsm_output = 8'b01100111;
        state_var_NS = S5_COPY_LOOP_for_C_1;
      end
      S5_COPY_LOOP_for_C_1 : begin
        fsm_output = 8'b01101000;
        state_var_NS = S5_COPY_LOOP_for_C_2;
      end
      S5_COPY_LOOP_for_C_2 : begin
        fsm_output = 8'b01101001;
        state_var_NS = S5_COPY_LOOP_for_C_3;
      end
      S5_COPY_LOOP_for_C_3 : begin
        fsm_output = 8'b01101010;
        if ( S5_COPY_LOOP_for_C_3_tr0 ) begin
          state_var_NS = S5_COPY_LOOP_C_0;
        end
        else begin
          state_var_NS = S5_COPY_LOOP_for_C_0;
        end
      end
      S5_COPY_LOOP_C_0 : begin
        fsm_output = 8'b01101011;
        if ( S5_COPY_LOOP_C_0_tr0 ) begin
          state_var_NS = S5_OUTER_LOOP_C_0;
        end
        else begin
          state_var_NS = S5_COPY_LOOP_for_C_0;
        end
      end
      S5_OUTER_LOOP_C_0 : begin
        fsm_output = 8'b01101100;
        state_var_NS = S5_INNER_LOOP1_for_C_0;
      end
      S5_INNER_LOOP1_for_C_0 : begin
        fsm_output = 8'b01101101;
        state_var_NS = S5_INNER_LOOP1_for_C_1;
      end
      S5_INNER_LOOP1_for_C_1 : begin
        fsm_output = 8'b01101110;
        state_var_NS = S5_INNER_LOOP1_for_C_2;
      end
      S5_INNER_LOOP1_for_C_2 : begin
        fsm_output = 8'b01101111;
        state_var_NS = S5_INNER_LOOP1_for_C_3;
      end
      S5_INNER_LOOP1_for_C_3 : begin
        fsm_output = 8'b01110000;
        state_var_NS = S5_INNER_LOOP1_for_C_4;
      end
      S5_INNER_LOOP1_for_C_4 : begin
        fsm_output = 8'b01110001;
        state_var_NS = S5_INNER_LOOP1_for_C_5;
      end
      S5_INNER_LOOP1_for_C_5 : begin
        fsm_output = 8'b01110010;
        state_var_NS = S5_INNER_LOOP1_for_C_6;
      end
      S5_INNER_LOOP1_for_C_6 : begin
        fsm_output = 8'b01110011;
        state_var_NS = S5_INNER_LOOP1_for_C_7;
      end
      S5_INNER_LOOP1_for_C_7 : begin
        fsm_output = 8'b01110100;
        state_var_NS = S5_INNER_LOOP1_for_C_8;
      end
      S5_INNER_LOOP1_for_C_8 : begin
        fsm_output = 8'b01110101;
        state_var_NS = S5_INNER_LOOP1_for_C_9;
      end
      S5_INNER_LOOP1_for_C_9 : begin
        fsm_output = 8'b01110110;
        state_var_NS = S5_INNER_LOOP1_for_C_10;
      end
      S5_INNER_LOOP1_for_C_10 : begin
        fsm_output = 8'b01110111;
        state_var_NS = S5_INNER_LOOP1_for_C_11;
      end
      S5_INNER_LOOP1_for_C_11 : begin
        fsm_output = 8'b01111000;
        state_var_NS = S5_INNER_LOOP1_for_C_12;
      end
      S5_INNER_LOOP1_for_C_12 : begin
        fsm_output = 8'b01111001;
        state_var_NS = S5_INNER_LOOP1_for_C_13;
      end
      S5_INNER_LOOP1_for_C_13 : begin
        fsm_output = 8'b01111010;
        state_var_NS = S5_INNER_LOOP1_for_C_14;
      end
      S5_INNER_LOOP1_for_C_14 : begin
        fsm_output = 8'b01111011;
        state_var_NS = S5_INNER_LOOP1_for_C_15;
      end
      S5_INNER_LOOP1_for_C_15 : begin
        fsm_output = 8'b01111100;
        state_var_NS = S5_INNER_LOOP1_for_C_16;
      end
      S5_INNER_LOOP1_for_C_16 : begin
        fsm_output = 8'b01111101;
        state_var_NS = S5_INNER_LOOP1_for_C_17;
      end
      S5_INNER_LOOP1_for_C_17 : begin
        fsm_output = 8'b01111110;
        state_var_NS = S5_INNER_LOOP1_for_C_18;
      end
      S5_INNER_LOOP1_for_C_18 : begin
        fsm_output = 8'b01111111;
        state_var_NS = S5_INNER_LOOP1_for_C_19;
      end
      S5_INNER_LOOP1_for_C_19 : begin
        fsm_output = 8'b10000000;
        state_var_NS = S5_INNER_LOOP1_for_C_20;
      end
      S5_INNER_LOOP1_for_C_20 : begin
        fsm_output = 8'b10000001;
        state_var_NS = S5_INNER_LOOP1_for_C_21;
      end
      S5_INNER_LOOP1_for_C_21 : begin
        fsm_output = 8'b10000010;
        state_var_NS = S5_INNER_LOOP1_for_C_22;
      end
      S5_INNER_LOOP1_for_C_22 : begin
        fsm_output = 8'b10000011;
        state_var_NS = S5_INNER_LOOP1_for_C_23;
      end
      S5_INNER_LOOP1_for_C_23 : begin
        fsm_output = 8'b10000100;
        if ( S5_INNER_LOOP1_for_C_23_tr0 ) begin
          state_var_NS = S5_INNER_LOOP1_C_0;
        end
        else begin
          state_var_NS = S5_INNER_LOOP1_for_C_0;
        end
      end
      S5_INNER_LOOP1_C_0 : begin
        fsm_output = 8'b10000101;
        if ( S5_INNER_LOOP1_C_0_tr0 ) begin
          state_var_NS = S5_OUTER_LOOP_C_1;
        end
        else begin
          state_var_NS = S5_INNER_LOOP1_for_C_0;
        end
      end
      S5_OUTER_LOOP_C_1 : begin
        fsm_output = 8'b10000110;
        state_var_NS = S5_INNER_LOOP2_for_C_0;
      end
      S5_INNER_LOOP2_for_C_0 : begin
        fsm_output = 8'b10000111;
        state_var_NS = S5_INNER_LOOP2_for_C_1;
      end
      S5_INNER_LOOP2_for_C_1 : begin
        fsm_output = 8'b10001000;
        state_var_NS = S5_INNER_LOOP2_for_C_2;
      end
      S5_INNER_LOOP2_for_C_2 : begin
        fsm_output = 8'b10001001;
        state_var_NS = S5_INNER_LOOP2_for_C_3;
      end
      S5_INNER_LOOP2_for_C_3 : begin
        fsm_output = 8'b10001010;
        state_var_NS = S5_INNER_LOOP2_for_C_4;
      end
      S5_INNER_LOOP2_for_C_4 : begin
        fsm_output = 8'b10001011;
        state_var_NS = S5_INNER_LOOP2_for_C_5;
      end
      S5_INNER_LOOP2_for_C_5 : begin
        fsm_output = 8'b10001100;
        state_var_NS = S5_INNER_LOOP2_for_C_6;
      end
      S5_INNER_LOOP2_for_C_6 : begin
        fsm_output = 8'b10001101;
        state_var_NS = S5_INNER_LOOP2_for_C_7;
      end
      S5_INNER_LOOP2_for_C_7 : begin
        fsm_output = 8'b10001110;
        state_var_NS = S5_INNER_LOOP2_for_C_8;
      end
      S5_INNER_LOOP2_for_C_8 : begin
        fsm_output = 8'b10001111;
        state_var_NS = S5_INNER_LOOP2_for_C_9;
      end
      S5_INNER_LOOP2_for_C_9 : begin
        fsm_output = 8'b10010000;
        state_var_NS = S5_INNER_LOOP2_for_C_10;
      end
      S5_INNER_LOOP2_for_C_10 : begin
        fsm_output = 8'b10010001;
        state_var_NS = S5_INNER_LOOP2_for_C_11;
      end
      S5_INNER_LOOP2_for_C_11 : begin
        fsm_output = 8'b10010010;
        state_var_NS = S5_INNER_LOOP2_for_C_12;
      end
      S5_INNER_LOOP2_for_C_12 : begin
        fsm_output = 8'b10010011;
        state_var_NS = S5_INNER_LOOP2_for_C_13;
      end
      S5_INNER_LOOP2_for_C_13 : begin
        fsm_output = 8'b10010100;
        state_var_NS = S5_INNER_LOOP2_for_C_14;
      end
      S5_INNER_LOOP2_for_C_14 : begin
        fsm_output = 8'b10010101;
        state_var_NS = S5_INNER_LOOP2_for_C_15;
      end
      S5_INNER_LOOP2_for_C_15 : begin
        fsm_output = 8'b10010110;
        state_var_NS = S5_INNER_LOOP2_for_C_16;
      end
      S5_INNER_LOOP2_for_C_16 : begin
        fsm_output = 8'b10010111;
        state_var_NS = S5_INNER_LOOP2_for_C_17;
      end
      S5_INNER_LOOP2_for_C_17 : begin
        fsm_output = 8'b10011000;
        state_var_NS = S5_INNER_LOOP2_for_C_18;
      end
      S5_INNER_LOOP2_for_C_18 : begin
        fsm_output = 8'b10011001;
        state_var_NS = S5_INNER_LOOP2_for_C_19;
      end
      S5_INNER_LOOP2_for_C_19 : begin
        fsm_output = 8'b10011010;
        state_var_NS = S5_INNER_LOOP2_for_C_20;
      end
      S5_INNER_LOOP2_for_C_20 : begin
        fsm_output = 8'b10011011;
        state_var_NS = S5_INNER_LOOP2_for_C_21;
      end
      S5_INNER_LOOP2_for_C_21 : begin
        fsm_output = 8'b10011100;
        state_var_NS = S5_INNER_LOOP2_for_C_22;
      end
      S5_INNER_LOOP2_for_C_22 : begin
        fsm_output = 8'b10011101;
        state_var_NS = S5_INNER_LOOP2_for_C_23;
      end
      S5_INNER_LOOP2_for_C_23 : begin
        fsm_output = 8'b10011110;
        if ( S5_INNER_LOOP2_for_C_23_tr0 ) begin
          state_var_NS = S5_INNER_LOOP2_C_0;
        end
        else begin
          state_var_NS = S5_INNER_LOOP2_for_C_0;
        end
      end
      S5_INNER_LOOP2_C_0 : begin
        fsm_output = 8'b10011111;
        if ( S5_INNER_LOOP2_C_0_tr0 ) begin
          state_var_NS = S5_INNER_LOOP3_for_C_0;
        end
        else if ( S5_INNER_LOOP2_C_0_tr1 ) begin
          state_var_NS = S5_INNER_LOOP2_for_C_0;
        end
        else begin
          state_var_NS = S5_OUTER_LOOP_C_0;
        end
      end
      S5_INNER_LOOP3_for_C_0 : begin
        fsm_output = 8'b10100000;
        state_var_NS = S5_INNER_LOOP3_for_C_1;
      end
      S5_INNER_LOOP3_for_C_1 : begin
        fsm_output = 8'b10100001;
        state_var_NS = S5_INNER_LOOP3_for_C_2;
      end
      S5_INNER_LOOP3_for_C_2 : begin
        fsm_output = 8'b10100010;
        state_var_NS = S5_INNER_LOOP3_for_C_3;
      end
      S5_INNER_LOOP3_for_C_3 : begin
        fsm_output = 8'b10100011;
        state_var_NS = S5_INNER_LOOP3_for_C_4;
      end
      S5_INNER_LOOP3_for_C_4 : begin
        fsm_output = 8'b10100100;
        state_var_NS = S5_INNER_LOOP3_for_C_5;
      end
      S5_INNER_LOOP3_for_C_5 : begin
        fsm_output = 8'b10100101;
        state_var_NS = S5_INNER_LOOP3_for_C_6;
      end
      S5_INNER_LOOP3_for_C_6 : begin
        fsm_output = 8'b10100110;
        state_var_NS = S5_INNER_LOOP3_for_C_7;
      end
      S5_INNER_LOOP3_for_C_7 : begin
        fsm_output = 8'b10100111;
        state_var_NS = S5_INNER_LOOP3_for_C_8;
      end
      S5_INNER_LOOP3_for_C_8 : begin
        fsm_output = 8'b10101000;
        state_var_NS = S5_INNER_LOOP3_for_C_9;
      end
      S5_INNER_LOOP3_for_C_9 : begin
        fsm_output = 8'b10101001;
        state_var_NS = S5_INNER_LOOP3_for_C_10;
      end
      S5_INNER_LOOP3_for_C_10 : begin
        fsm_output = 8'b10101010;
        state_var_NS = S5_INNER_LOOP3_for_C_11;
      end
      S5_INNER_LOOP3_for_C_11 : begin
        fsm_output = 8'b10101011;
        state_var_NS = S5_INNER_LOOP3_for_C_12;
      end
      S5_INNER_LOOP3_for_C_12 : begin
        fsm_output = 8'b10101100;
        state_var_NS = S5_INNER_LOOP3_for_C_13;
      end
      S5_INNER_LOOP3_for_C_13 : begin
        fsm_output = 8'b10101101;
        state_var_NS = S5_INNER_LOOP3_for_C_14;
      end
      S5_INNER_LOOP3_for_C_14 : begin
        fsm_output = 8'b10101110;
        state_var_NS = S5_INNER_LOOP3_for_C_15;
      end
      S5_INNER_LOOP3_for_C_15 : begin
        fsm_output = 8'b10101111;
        state_var_NS = S5_INNER_LOOP3_for_C_16;
      end
      S5_INNER_LOOP3_for_C_16 : begin
        fsm_output = 8'b10110000;
        state_var_NS = S5_INNER_LOOP3_for_C_17;
      end
      S5_INNER_LOOP3_for_C_17 : begin
        fsm_output = 8'b10110001;
        state_var_NS = S5_INNER_LOOP3_for_C_18;
      end
      S5_INNER_LOOP3_for_C_18 : begin
        fsm_output = 8'b10110010;
        state_var_NS = S5_INNER_LOOP3_for_C_19;
      end
      S5_INNER_LOOP3_for_C_19 : begin
        fsm_output = 8'b10110011;
        state_var_NS = S5_INNER_LOOP3_for_C_20;
      end
      S5_INNER_LOOP3_for_C_20 : begin
        fsm_output = 8'b10110100;
        state_var_NS = S5_INNER_LOOP3_for_C_21;
      end
      S5_INNER_LOOP3_for_C_21 : begin
        fsm_output = 8'b10110101;
        state_var_NS = S5_INNER_LOOP3_for_C_22;
      end
      S5_INNER_LOOP3_for_C_22 : begin
        fsm_output = 8'b10110110;
        state_var_NS = S5_INNER_LOOP3_for_C_23;
      end
      S5_INNER_LOOP3_for_C_23 : begin
        fsm_output = 8'b10110111;
        if ( S5_INNER_LOOP3_for_C_23_tr0 ) begin
          state_var_NS = S5_INNER_LOOP3_C_0;
        end
        else begin
          state_var_NS = S5_INNER_LOOP3_for_C_0;
        end
      end
      S5_INNER_LOOP3_C_0 : begin
        fsm_output = 8'b10111000;
        if ( S5_INNER_LOOP3_C_0_tr0 ) begin
          state_var_NS = S6_OUTER_LOOP_for_C_0;
        end
        else begin
          state_var_NS = S5_INNER_LOOP3_for_C_0;
        end
      end
      S6_OUTER_LOOP_for_C_0 : begin
        fsm_output = 8'b10111001;
        state_var_NS = S6_OUTER_LOOP_for_C_1;
      end
      S6_OUTER_LOOP_for_C_1 : begin
        fsm_output = 8'b10111010;
        state_var_NS = S6_OUTER_LOOP_for_C_2;
      end
      S6_OUTER_LOOP_for_C_2 : begin
        fsm_output = 8'b10111011;
        state_var_NS = S6_OUTER_LOOP_for_C_3;
      end
      S6_OUTER_LOOP_for_C_3 : begin
        fsm_output = 8'b10111100;
        if ( S6_OUTER_LOOP_for_C_3_tr0 ) begin
          state_var_NS = S6_OUTER_LOOP_C_0;
        end
        else begin
          state_var_NS = S6_OUTER_LOOP_for_C_0;
        end
      end
      S6_OUTER_LOOP_C_0 : begin
        fsm_output = 8'b10111101;
        if ( S6_OUTER_LOOP_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = S6_OUTER_LOOP_for_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 8'b10111110;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 8'b00000000;
        state_var_NS = S1_OUTER_LOOP_for_C_0;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= main_C_0;
    end
    else if ( core_wen ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_staller
// ------------------------------------------------------------------


module hybrid_core_staller (
  clk, rst, core_wen, core_wten, x_rsci_wen_comp, x_rsci_wen_comp_1, twiddle_rsci_wen_comp,
      twiddle_h_rsci_wen_comp, revArr_rsci_wen_comp, tw_rsci_wen_comp, tw_h_rsci_wen_comp
);
  input clk;
  input rst;
  output core_wen;
  output core_wten;
  reg core_wten;
  input x_rsci_wen_comp;
  input x_rsci_wen_comp_1;
  input twiddle_rsci_wen_comp;
  input twiddle_h_rsci_wen_comp;
  input revArr_rsci_wen_comp;
  input tw_rsci_wen_comp;
  input tw_h_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign core_wen = x_rsci_wen_comp & x_rsci_wen_comp_1 & twiddle_rsci_wen_comp &
      twiddle_h_rsci_wen_comp & revArr_rsci_wen_comp & tw_rsci_wen_comp & tw_h_rsci_wen_comp;
  always @(posedge clk) begin
    if ( rst ) begin
      core_wten <= 1'b0;
    end
    else begin
      core_wten <= ~ core_wen;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_h_rsc_triosy_obj_tw_h_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_tw_h_rsc_triosy_obj_tw_h_rsc_triosy_wait_ctrl (
  core_wten, tw_h_rsc_triosy_obj_iswt0, tw_h_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input tw_h_rsc_triosy_obj_iswt0;
  output tw_h_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign tw_h_rsc_triosy_obj_ld_core_sct = tw_h_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_rsc_triosy_obj_tw_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_tw_rsc_triosy_obj_tw_rsc_triosy_wait_ctrl (
  core_wten, tw_rsc_triosy_obj_iswt0, tw_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input tw_rsc_triosy_obj_iswt0;
  output tw_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign tw_rsc_triosy_obj_ld_core_sct = tw_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_revArr_rsc_triosy_obj_revArr_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_revArr_rsc_triosy_obj_revArr_rsc_triosy_wait_ctrl (
  core_wten, revArr_rsc_triosy_obj_iswt0, revArr_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input revArr_rsc_triosy_obj_iswt0;
  output revArr_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign revArr_rsc_triosy_obj_ld_core_sct = revArr_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl (
  core_wten, twiddle_h_rsc_triosy_obj_iswt0, twiddle_h_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_obj_iswt0;
  output twiddle_h_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_obj_ld_core_sct = twiddle_h_rsc_triosy_obj_iswt0 &
      (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl (
  core_wten, twiddle_rsc_triosy_obj_iswt0, twiddle_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_obj_iswt0;
  output twiddle_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_obj_ld_core_sct = twiddle_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_m_rsc_triosy_obj_m_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_m_rsc_triosy_obj_m_rsc_triosy_wait_ctrl (
  core_wten, m_rsc_triosy_obj_iswt0, m_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input m_rsc_triosy_obj_iswt0;
  output m_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign m_rsc_triosy_obj_ld_core_sct = m_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_x_rsc_triosy_obj_x_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_x_rsc_triosy_obj_x_rsc_triosy_wait_ctrl (
  core_wten, x_rsc_triosy_obj_iswt0, x_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input x_rsc_triosy_obj_iswt0;
  output x_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign x_rsc_triosy_obj_ld_core_sct = x_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_h_rsci_tw_h_rsc_wait_dp
// ------------------------------------------------------------------


module hybrid_core_tw_h_rsci_tw_h_rsc_wait_dp (
  clk, rst, tw_h_rsci_oswt, tw_h_rsci_wen_comp, tw_h_rsci_s_raddr_core, tw_h_rsci_s_din_mxwt,
      tw_h_rsci_biwt, tw_h_rsci_bdwt, tw_h_rsci_bcwt, tw_h_rsci_s_raddr, tw_h_rsci_s_raddr_core_sct,
      tw_h_rsci_s_din
);
  input clk;
  input rst;
  input tw_h_rsci_oswt;
  output tw_h_rsci_wen_comp;
  input [9:0] tw_h_rsci_s_raddr_core;
  output [19:0] tw_h_rsci_s_din_mxwt;
  input tw_h_rsci_biwt;
  input tw_h_rsci_bdwt;
  output tw_h_rsci_bcwt;
  reg tw_h_rsci_bcwt;
  output [9:0] tw_h_rsci_s_raddr;
  input tw_h_rsci_s_raddr_core_sct;
  input [31:0] tw_h_rsci_s_din;


  // Interconnect Declarations
  reg [19:0] tw_h_rsci_s_din_bfwt_19_0;


  // Interconnect Declarations for Component Instantiations 
  assign tw_h_rsci_wen_comp = (~ tw_h_rsci_oswt) | tw_h_rsci_biwt | tw_h_rsci_bcwt;
  assign tw_h_rsci_s_raddr = MUX_v_10_2_2(10'b0000000000, tw_h_rsci_s_raddr_core,
      tw_h_rsci_s_raddr_core_sct);
  assign tw_h_rsci_s_din_mxwt = MUX_v_20_2_2((tw_h_rsci_s_din[19:0]), tw_h_rsci_s_din_bfwt_19_0,
      tw_h_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      tw_h_rsci_bcwt <= 1'b0;
    end
    else begin
      tw_h_rsci_bcwt <= ~((~(tw_h_rsci_bcwt | tw_h_rsci_biwt)) | tw_h_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( tw_h_rsci_biwt ) begin
      tw_h_rsci_s_din_bfwt_19_0 <= tw_h_rsci_s_din[19:0];
    end
  end

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


  function automatic [19:0] MUX_v_20_2_2;
    input [19:0] input_0;
    input [19:0] input_1;
    input [0:0] sel;
    reg [19:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_20_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_h_rsci_tw_h_rsc_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_tw_h_rsci_tw_h_rsc_wait_ctrl (
  core_wen, tw_h_rsci_oswt, tw_h_rsci_biwt, tw_h_rsci_bdwt, tw_h_rsci_bcwt, tw_h_rsci_s_re_core_sct,
      tw_h_rsci_s_rrdy
);
  input core_wen;
  input tw_h_rsci_oswt;
  output tw_h_rsci_biwt;
  output tw_h_rsci_bdwt;
  input tw_h_rsci_bcwt;
  output tw_h_rsci_s_re_core_sct;
  input tw_h_rsci_s_rrdy;


  // Interconnect Declarations
  wire tw_h_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign tw_h_rsci_bdwt = tw_h_rsci_oswt & core_wen;
  assign tw_h_rsci_biwt = tw_h_rsci_ogwt & tw_h_rsci_s_rrdy;
  assign tw_h_rsci_ogwt = tw_h_rsci_oswt & (~ tw_h_rsci_bcwt);
  assign tw_h_rsci_s_re_core_sct = tw_h_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_rsci_tw_rsc_wait_dp
// ------------------------------------------------------------------


module hybrid_core_tw_rsci_tw_rsc_wait_dp (
  clk, rst, tw_rsci_oswt, tw_rsci_wen_comp, tw_rsci_s_raddr_core, tw_rsci_s_din_mxwt,
      tw_rsci_biwt, tw_rsci_bdwt, tw_rsci_bcwt, tw_rsci_s_raddr, tw_rsci_s_raddr_core_sct,
      tw_rsci_s_din
);
  input clk;
  input rst;
  input tw_rsci_oswt;
  output tw_rsci_wen_comp;
  input [9:0] tw_rsci_s_raddr_core;
  output [19:0] tw_rsci_s_din_mxwt;
  input tw_rsci_biwt;
  input tw_rsci_bdwt;
  output tw_rsci_bcwt;
  reg tw_rsci_bcwt;
  output [9:0] tw_rsci_s_raddr;
  input tw_rsci_s_raddr_core_sct;
  input [31:0] tw_rsci_s_din;


  // Interconnect Declarations
  reg [19:0] tw_rsci_s_din_bfwt_19_0;


  // Interconnect Declarations for Component Instantiations 
  assign tw_rsci_wen_comp = (~ tw_rsci_oswt) | tw_rsci_biwt | tw_rsci_bcwt;
  assign tw_rsci_s_raddr = MUX_v_10_2_2(10'b0000000000, tw_rsci_s_raddr_core, tw_rsci_s_raddr_core_sct);
  assign tw_rsci_s_din_mxwt = MUX_v_20_2_2((tw_rsci_s_din[19:0]), tw_rsci_s_din_bfwt_19_0,
      tw_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      tw_rsci_bcwt <= 1'b0;
    end
    else begin
      tw_rsci_bcwt <= ~((~(tw_rsci_bcwt | tw_rsci_biwt)) | tw_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( tw_rsci_biwt ) begin
      tw_rsci_s_din_bfwt_19_0 <= tw_rsci_s_din[19:0];
    end
  end

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


  function automatic [19:0] MUX_v_20_2_2;
    input [19:0] input_0;
    input [19:0] input_1;
    input [0:0] sel;
    reg [19:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_20_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_rsci_tw_rsc_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_tw_rsci_tw_rsc_wait_ctrl (
  core_wen, tw_rsci_oswt, tw_rsci_biwt, tw_rsci_bdwt, tw_rsci_bcwt, tw_rsci_s_re_core_sct,
      tw_rsci_s_rrdy
);
  input core_wen;
  input tw_rsci_oswt;
  output tw_rsci_biwt;
  output tw_rsci_bdwt;
  input tw_rsci_bcwt;
  output tw_rsci_s_re_core_sct;
  input tw_rsci_s_rrdy;


  // Interconnect Declarations
  wire tw_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign tw_rsci_bdwt = tw_rsci_oswt & core_wen;
  assign tw_rsci_biwt = tw_rsci_ogwt & tw_rsci_s_rrdy;
  assign tw_rsci_ogwt = tw_rsci_oswt & (~ tw_rsci_bcwt);
  assign tw_rsci_s_re_core_sct = tw_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_revArr_rsci_revArr_rsc_wait_dp
// ------------------------------------------------------------------


module hybrid_core_revArr_rsci_revArr_rsc_wait_dp (
  clk, rst, revArr_rsci_oswt, revArr_rsci_wen_comp, revArr_rsci_s_raddr_core, revArr_rsci_s_din_mxwt,
      revArr_rsci_biwt, revArr_rsci_bdwt, revArr_rsci_bcwt, revArr_rsci_s_raddr,
      revArr_rsci_s_raddr_core_sct, revArr_rsci_s_din
);
  input clk;
  input rst;
  input revArr_rsci_oswt;
  output revArr_rsci_wen_comp;
  input [4:0] revArr_rsci_s_raddr_core;
  output [9:0] revArr_rsci_s_din_mxwt;
  input revArr_rsci_biwt;
  input revArr_rsci_bdwt;
  output revArr_rsci_bcwt;
  reg revArr_rsci_bcwt;
  output [4:0] revArr_rsci_s_raddr;
  input revArr_rsci_s_raddr_core_sct;
  input [31:0] revArr_rsci_s_din;


  // Interconnect Declarations
  reg [9:0] revArr_rsci_s_din_bfwt_9_0;


  // Interconnect Declarations for Component Instantiations 
  assign revArr_rsci_wen_comp = (~ revArr_rsci_oswt) | revArr_rsci_biwt | revArr_rsci_bcwt;
  assign revArr_rsci_s_raddr = MUX_v_5_2_2(5'b00000, revArr_rsci_s_raddr_core, revArr_rsci_s_raddr_core_sct);
  assign revArr_rsci_s_din_mxwt = MUX_v_10_2_2((revArr_rsci_s_din[9:0]), revArr_rsci_s_din_bfwt_9_0,
      revArr_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      revArr_rsci_bcwt <= 1'b0;
    end
    else begin
      revArr_rsci_bcwt <= ~((~(revArr_rsci_bcwt | revArr_rsci_biwt)) | revArr_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( revArr_rsci_biwt ) begin
      revArr_rsci_s_din_bfwt_9_0 <= revArr_rsci_s_din[9:0];
    end
  end

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


  function automatic [4:0] MUX_v_5_2_2;
    input [4:0] input_0;
    input [4:0] input_1;
    input [0:0] sel;
    reg [4:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_5_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_revArr_rsci_revArr_rsc_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_revArr_rsci_revArr_rsc_wait_ctrl (
  core_wen, revArr_rsci_oswt, revArr_rsci_biwt, revArr_rsci_bdwt, revArr_rsci_bcwt,
      revArr_rsci_s_re_core_sct, revArr_rsci_s_rrdy
);
  input core_wen;
  input revArr_rsci_oswt;
  output revArr_rsci_biwt;
  output revArr_rsci_bdwt;
  input revArr_rsci_bcwt;
  output revArr_rsci_s_re_core_sct;
  input revArr_rsci_s_rrdy;


  // Interconnect Declarations
  wire revArr_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign revArr_rsci_bdwt = revArr_rsci_oswt & core_wen;
  assign revArr_rsci_biwt = revArr_rsci_ogwt & revArr_rsci_s_rrdy;
  assign revArr_rsci_ogwt = revArr_rsci_oswt & (~ revArr_rsci_bcwt);
  assign revArr_rsci_s_re_core_sct = revArr_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_dp
// ------------------------------------------------------------------


module hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_dp (
  clk, rst, twiddle_h_rsci_oswt, twiddle_h_rsci_wen_comp, twiddle_h_rsci_s_raddr_core,
      twiddle_h_rsci_s_din_mxwt, twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt, twiddle_h_rsci_bcwt,
      twiddle_h_rsci_s_raddr, twiddle_h_rsci_s_raddr_core_sct, twiddle_h_rsci_s_din
);
  input clk;
  input rst;
  input twiddle_h_rsci_oswt;
  output twiddle_h_rsci_wen_comp;
  input [4:0] twiddle_h_rsci_s_raddr_core;
  output [31:0] twiddle_h_rsci_s_din_mxwt;
  input twiddle_h_rsci_biwt;
  input twiddle_h_rsci_bdwt;
  output twiddle_h_rsci_bcwt;
  reg twiddle_h_rsci_bcwt;
  output [4:0] twiddle_h_rsci_s_raddr;
  input twiddle_h_rsci_s_raddr_core_sct;
  input [31:0] twiddle_h_rsci_s_din;


  // Interconnect Declarations
  reg [31:0] twiddle_h_rsci_s_din_bfwt;

  wire[3:0] butterFly_tw_h_butterFly_tw_h_and_nl;

  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_wen_comp = (~ twiddle_h_rsci_oswt) | twiddle_h_rsci_biwt
      | twiddle_h_rsci_bcwt;
  assign butterFly_tw_h_butterFly_tw_h_and_nl = MUX_v_4_2_2(4'b0000, (twiddle_h_rsci_s_raddr_core[3:0]),
      twiddle_h_rsci_s_raddr_core_sct);
  assign twiddle_h_rsci_s_raddr = {1'b0, butterFly_tw_h_butterFly_tw_h_and_nl};
  assign twiddle_h_rsci_s_din_mxwt = MUX_v_32_2_2(twiddle_h_rsci_s_din, twiddle_h_rsci_s_din_bfwt,
      twiddle_h_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsci_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsci_bcwt <= ~((~(twiddle_h_rsci_bcwt | twiddle_h_rsci_biwt)) | twiddle_h_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsci_biwt ) begin
      twiddle_h_rsci_s_din_bfwt <= twiddle_h_rsci_s_din;
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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_ctrl (
  core_wen, twiddle_h_rsci_oswt, twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt, twiddle_h_rsci_bcwt,
      twiddle_h_rsci_s_re_core_sct, twiddle_h_rsci_s_rrdy
);
  input core_wen;
  input twiddle_h_rsci_oswt;
  output twiddle_h_rsci_biwt;
  output twiddle_h_rsci_bdwt;
  input twiddle_h_rsci_bcwt;
  output twiddle_h_rsci_s_re_core_sct;
  input twiddle_h_rsci_s_rrdy;


  // Interconnect Declarations
  wire twiddle_h_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_bdwt = twiddle_h_rsci_oswt & core_wen;
  assign twiddle_h_rsci_biwt = twiddle_h_rsci_ogwt & twiddle_h_rsci_s_rrdy;
  assign twiddle_h_rsci_ogwt = twiddle_h_rsci_oswt & (~ twiddle_h_rsci_bcwt);
  assign twiddle_h_rsci_s_re_core_sct = twiddle_h_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_rsci_twiddle_rsc_wait_dp
// ------------------------------------------------------------------


module hybrid_core_twiddle_rsci_twiddle_rsc_wait_dp (
  clk, rst, twiddle_rsci_oswt, twiddle_rsci_wen_comp, twiddle_rsci_s_raddr_core,
      twiddle_rsci_s_din_mxwt, twiddle_rsci_biwt, twiddle_rsci_bdwt, twiddle_rsci_bcwt,
      twiddle_rsci_s_raddr, twiddle_rsci_s_raddr_core_sct, twiddle_rsci_s_din
);
  input clk;
  input rst;
  input twiddle_rsci_oswt;
  output twiddle_rsci_wen_comp;
  input [4:0] twiddle_rsci_s_raddr_core;
  output [31:0] twiddle_rsci_s_din_mxwt;
  input twiddle_rsci_biwt;
  input twiddle_rsci_bdwt;
  output twiddle_rsci_bcwt;
  reg twiddle_rsci_bcwt;
  output [4:0] twiddle_rsci_s_raddr;
  input twiddle_rsci_s_raddr_core_sct;
  input [31:0] twiddle_rsci_s_din;


  // Interconnect Declarations
  reg [31:0] twiddle_rsci_s_din_bfwt;

  wire[3:0] butterFly_tw_butterFly_tw_and_nl;

  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_wen_comp = (~ twiddle_rsci_oswt) | twiddle_rsci_biwt | twiddle_rsci_bcwt;
  assign butterFly_tw_butterFly_tw_and_nl = MUX_v_4_2_2(4'b0000, (twiddle_rsci_s_raddr_core[3:0]),
      twiddle_rsci_s_raddr_core_sct);
  assign twiddle_rsci_s_raddr = {1'b0, butterFly_tw_butterFly_tw_and_nl};
  assign twiddle_rsci_s_din_mxwt = MUX_v_32_2_2(twiddle_rsci_s_din, twiddle_rsci_s_din_bfwt,
      twiddle_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsci_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsci_bcwt <= ~((~(twiddle_rsci_bcwt | twiddle_rsci_biwt)) | twiddle_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsci_biwt ) begin
      twiddle_rsci_s_din_bfwt <= twiddle_rsci_s_din;
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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_rsci_twiddle_rsc_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_twiddle_rsci_twiddle_rsc_wait_ctrl (
  core_wen, twiddle_rsci_oswt, twiddle_rsci_biwt, twiddle_rsci_bdwt, twiddle_rsci_bcwt,
      twiddle_rsci_s_re_core_sct, twiddle_rsci_s_rrdy
);
  input core_wen;
  input twiddle_rsci_oswt;
  output twiddle_rsci_biwt;
  output twiddle_rsci_bdwt;
  input twiddle_rsci_bcwt;
  output twiddle_rsci_s_re_core_sct;
  input twiddle_rsci_s_rrdy;


  // Interconnect Declarations
  wire twiddle_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_bdwt = twiddle_rsci_oswt & core_wen;
  assign twiddle_rsci_biwt = twiddle_rsci_ogwt & twiddle_rsci_s_rrdy;
  assign twiddle_rsci_ogwt = twiddle_rsci_oswt & (~ twiddle_rsci_bcwt);
  assign twiddle_rsci_s_re_core_sct = twiddle_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_x_rsci_x_rsc_wait_dp
// ------------------------------------------------------------------


module hybrid_core_x_rsci_x_rsc_wait_dp (
  clk, rst, x_rsci_oswt, x_rsci_wen_comp, x_rsci_oswt_1, x_rsci_wen_comp_1, x_rsci_s_raddr_core,
      x_rsci_s_waddr_core, x_rsci_s_din_mxwt, x_rsci_s_dout_core, x_rsci_biwt, x_rsci_bdwt,
      x_rsci_bcwt, x_rsci_biwt_1, x_rsci_bdwt_2, x_rsci_bcwt_1, x_rsci_s_raddr, x_rsci_s_raddr_core_sct,
      x_rsci_s_waddr, x_rsci_s_waddr_core_sct, x_rsci_s_din, x_rsci_s_dout
);
  input clk;
  input rst;
  input x_rsci_oswt;
  output x_rsci_wen_comp;
  input x_rsci_oswt_1;
  output x_rsci_wen_comp_1;
  input [9:0] x_rsci_s_raddr_core;
  input [9:0] x_rsci_s_waddr_core;
  output [31:0] x_rsci_s_din_mxwt;
  input [31:0] x_rsci_s_dout_core;
  input x_rsci_biwt;
  input x_rsci_bdwt;
  output x_rsci_bcwt;
  reg x_rsci_bcwt;
  input x_rsci_biwt_1;
  input x_rsci_bdwt_2;
  output x_rsci_bcwt_1;
  reg x_rsci_bcwt_1;
  output [9:0] x_rsci_s_raddr;
  input x_rsci_s_raddr_core_sct;
  output [9:0] x_rsci_s_waddr;
  input x_rsci_s_waddr_core_sct;
  input [31:0] x_rsci_s_din;
  output [31:0] x_rsci_s_dout;


  // Interconnect Declarations
  reg [31:0] x_rsci_s_din_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign x_rsci_wen_comp = (~ x_rsci_oswt) | x_rsci_biwt | x_rsci_bcwt;
  assign x_rsci_wen_comp_1 = (~ x_rsci_oswt_1) | x_rsci_biwt_1 | x_rsci_bcwt_1;
  assign x_rsci_s_raddr = MUX_v_10_2_2(10'b0000000000, x_rsci_s_raddr_core, x_rsci_s_raddr_core_sct);
  assign x_rsci_s_waddr = MUX_v_10_2_2(10'b0000000000, x_rsci_s_waddr_core, x_rsci_s_waddr_core_sct);
  assign x_rsci_s_din_mxwt = MUX_v_32_2_2(x_rsci_s_din, x_rsci_s_din_bfwt, x_rsci_bcwt);
  assign x_rsci_s_dout = MUX_v_32_2_2(32'b00000000000000000000000000000000, x_rsci_s_dout_core,
      x_rsci_s_waddr_core_sct);
  always @(posedge clk) begin
    if ( rst ) begin
      x_rsci_bcwt <= 1'b0;
      x_rsci_bcwt_1 <= 1'b0;
    end
    else begin
      x_rsci_bcwt <= ~((~(x_rsci_bcwt | x_rsci_biwt)) | x_rsci_bdwt);
      x_rsci_bcwt_1 <= ~((~(x_rsci_bcwt_1 | x_rsci_biwt_1)) | x_rsci_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( x_rsci_biwt ) begin
      x_rsci_s_din_bfwt <= x_rsci_s_din;
    end
  end

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
//  Design Unit:    hybrid_core_x_rsci_x_rsc_wait_ctrl
// ------------------------------------------------------------------


module hybrid_core_x_rsci_x_rsc_wait_ctrl (
  core_wen, x_rsci_oswt, x_rsci_oswt_1, x_rsci_biwt, x_rsci_bdwt, x_rsci_bcwt, x_rsci_s_re_core_sct,
      x_rsci_biwt_1, x_rsci_bdwt_2, x_rsci_bcwt_1, x_rsci_s_we_core_sct, x_rsci_s_rrdy,
      x_rsci_s_wrdy
);
  input core_wen;
  input x_rsci_oswt;
  input x_rsci_oswt_1;
  output x_rsci_biwt;
  output x_rsci_bdwt;
  input x_rsci_bcwt;
  output x_rsci_s_re_core_sct;
  output x_rsci_biwt_1;
  output x_rsci_bdwt_2;
  input x_rsci_bcwt_1;
  output x_rsci_s_we_core_sct;
  input x_rsci_s_rrdy;
  input x_rsci_s_wrdy;


  // Interconnect Declarations
  wire x_rsci_ogwt;
  wire x_rsci_ogwt_1;


  // Interconnect Declarations for Component Instantiations 
  assign x_rsci_bdwt = x_rsci_oswt & core_wen;
  assign x_rsci_biwt = x_rsci_ogwt & x_rsci_s_rrdy;
  assign x_rsci_ogwt = x_rsci_oswt & (~ x_rsci_bcwt);
  assign x_rsci_s_re_core_sct = x_rsci_ogwt;
  assign x_rsci_bdwt_2 = x_rsci_oswt_1 & core_wen;
  assign x_rsci_biwt_1 = x_rsci_ogwt_1 & x_rsci_s_wrdy;
  assign x_rsci_ogwt_1 = x_rsci_oswt_1 & (~ x_rsci_bcwt_1);
  assign x_rsci_s_we_core_sct = x_rsci_ogwt_1;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_wait_dp
// ------------------------------------------------------------------


module hybrid_core_wait_dp (
  clk, xx_rsc_cgo_iro, xx_rsci_clken_d, yy_rsc_cgo_iro, yy_rsci_clken_d, ensig_cgo_iro,
      S34_OUTER_LOOP_for_tf_mul_cmp_z, ensig_cgo_iro_1, core_wen, xx_rsc_cgo, yy_rsc_cgo,
      ensig_cgo, mult_12_z_mul_cmp_en, S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg, ensig_cgo_1,
      mult_z_mul_cmp_en
);
  input clk;
  input xx_rsc_cgo_iro;
  output xx_rsci_clken_d;
  input yy_rsc_cgo_iro;
  output yy_rsci_clken_d;
  input ensig_cgo_iro;
  input [9:0] S34_OUTER_LOOP_for_tf_mul_cmp_z;
  input ensig_cgo_iro_1;
  input core_wen;
  input xx_rsc_cgo;
  input yy_rsc_cgo;
  input ensig_cgo;
  output mult_12_z_mul_cmp_en;
  output [9:0] S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg;
  reg [9:0] S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg;
  input ensig_cgo_1;
  output mult_z_mul_cmp_en;



  // Interconnect Declarations for Component Instantiations 
  assign xx_rsci_clken_d = core_wen & (xx_rsc_cgo | xx_rsc_cgo_iro);
  assign yy_rsci_clken_d = core_wen & (yy_rsc_cgo | yy_rsc_cgo_iro);
  assign mult_12_z_mul_cmp_en = core_wen & (ensig_cgo | ensig_cgo_iro);
  assign mult_z_mul_cmp_en = core_wen & (ensig_cgo_1 | ensig_cgo_iro_1);
  always @(posedge clk) begin
    if ( core_wen ) begin
      S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg <= S34_OUTER_LOOP_for_tf_mul_cmp_z;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_h_rsc_triosy_obj
// ------------------------------------------------------------------


module hybrid_core_tw_h_rsc_triosy_obj (
  tw_h_rsc_triosy_lz, core_wten, tw_h_rsc_triosy_obj_iswt0
);
  output tw_h_rsc_triosy_lz;
  input core_wten;
  input tw_h_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire tw_h_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) tw_h_rsc_triosy_obj (
      .ld(tw_h_rsc_triosy_obj_ld_core_sct),
      .lz(tw_h_rsc_triosy_lz)
    );
  hybrid_core_tw_h_rsc_triosy_obj_tw_h_rsc_triosy_wait_ctrl hybrid_core_tw_h_rsc_triosy_obj_tw_h_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .tw_h_rsc_triosy_obj_iswt0(tw_h_rsc_triosy_obj_iswt0),
      .tw_h_rsc_triosy_obj_ld_core_sct(tw_h_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_rsc_triosy_obj
// ------------------------------------------------------------------


module hybrid_core_tw_rsc_triosy_obj (
  tw_rsc_triosy_lz, core_wten, tw_rsc_triosy_obj_iswt0
);
  output tw_rsc_triosy_lz;
  input core_wten;
  input tw_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire tw_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) tw_rsc_triosy_obj (
      .ld(tw_rsc_triosy_obj_ld_core_sct),
      .lz(tw_rsc_triosy_lz)
    );
  hybrid_core_tw_rsc_triosy_obj_tw_rsc_triosy_wait_ctrl hybrid_core_tw_rsc_triosy_obj_tw_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .tw_rsc_triosy_obj_iswt0(tw_rsc_triosy_obj_iswt0),
      .tw_rsc_triosy_obj_ld_core_sct(tw_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_revArr_rsc_triosy_obj
// ------------------------------------------------------------------


module hybrid_core_revArr_rsc_triosy_obj (
  revArr_rsc_triosy_lz, core_wten, revArr_rsc_triosy_obj_iswt0
);
  output revArr_rsc_triosy_lz;
  input core_wten;
  input revArr_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire revArr_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) revArr_rsc_triosy_obj (
      .ld(revArr_rsc_triosy_obj_ld_core_sct),
      .lz(revArr_rsc_triosy_lz)
    );
  hybrid_core_revArr_rsc_triosy_obj_revArr_rsc_triosy_wait_ctrl hybrid_core_revArr_rsc_triosy_obj_revArr_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .revArr_rsc_triosy_obj_iswt0(revArr_rsc_triosy_obj_iswt0),
      .revArr_rsc_triosy_obj_ld_core_sct(revArr_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_h_rsc_triosy_obj
// ------------------------------------------------------------------


module hybrid_core_twiddle_h_rsc_triosy_obj (
  twiddle_h_rsc_triosy_lz, core_wten, twiddle_h_rsc_triosy_obj_iswt0
);
  output twiddle_h_rsc_triosy_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_obj (
      .ld(twiddle_h_rsc_triosy_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_lz)
    );
  hybrid_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl hybrid_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_obj_iswt0(twiddle_h_rsc_triosy_obj_iswt0),
      .twiddle_h_rsc_triosy_obj_ld_core_sct(twiddle_h_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_rsc_triosy_obj
// ------------------------------------------------------------------


module hybrid_core_twiddle_rsc_triosy_obj (
  twiddle_rsc_triosy_lz, core_wten, twiddle_rsc_triosy_obj_iswt0
);
  output twiddle_rsc_triosy_lz;
  input core_wten;
  input twiddle_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_obj (
      .ld(twiddle_rsc_triosy_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_lz)
    );
  hybrid_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl hybrid_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_obj_iswt0(twiddle_rsc_triosy_obj_iswt0),
      .twiddle_rsc_triosy_obj_ld_core_sct(twiddle_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_m_rsc_triosy_obj
// ------------------------------------------------------------------


module hybrid_core_m_rsc_triosy_obj (
  m_rsc_triosy_lz, core_wten, m_rsc_triosy_obj_iswt0
);
  output m_rsc_triosy_lz;
  input core_wten;
  input m_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire m_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) m_rsc_triosy_obj (
      .ld(m_rsc_triosy_obj_ld_core_sct),
      .lz(m_rsc_triosy_lz)
    );
  hybrid_core_m_rsc_triosy_obj_m_rsc_triosy_wait_ctrl hybrid_core_m_rsc_triosy_obj_m_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .m_rsc_triosy_obj_iswt0(m_rsc_triosy_obj_iswt0),
      .m_rsc_triosy_obj_ld_core_sct(m_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_x_rsc_triosy_obj
// ------------------------------------------------------------------


module hybrid_core_x_rsc_triosy_obj (
  x_rsc_triosy_lz, core_wten, x_rsc_triosy_obj_iswt0
);
  output x_rsc_triosy_lz;
  input core_wten;
  input x_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire x_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) x_rsc_triosy_obj (
      .ld(x_rsc_triosy_obj_ld_core_sct),
      .lz(x_rsc_triosy_lz)
    );
  hybrid_core_x_rsc_triosy_obj_x_rsc_triosy_wait_ctrl hybrid_core_x_rsc_triosy_obj_x_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .x_rsc_triosy_obj_iswt0(x_rsc_triosy_obj_iswt0),
      .x_rsc_triosy_obj_ld_core_sct(x_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_h_rsci
// ------------------------------------------------------------------


module hybrid_core_tw_h_rsci (
  clk, rst, tw_h_rsc_s_tdone, tw_h_rsc_tr_write_done, tw_h_rsc_RREADY, tw_h_rsc_RVALID,
      tw_h_rsc_RUSER, tw_h_rsc_RLAST, tw_h_rsc_RRESP, tw_h_rsc_RDATA, tw_h_rsc_RID,
      tw_h_rsc_ARREADY, tw_h_rsc_ARVALID, tw_h_rsc_ARUSER, tw_h_rsc_ARREGION, tw_h_rsc_ARQOS,
      tw_h_rsc_ARPROT, tw_h_rsc_ARCACHE, tw_h_rsc_ARLOCK, tw_h_rsc_ARBURST, tw_h_rsc_ARSIZE,
      tw_h_rsc_ARLEN, tw_h_rsc_ARADDR, tw_h_rsc_ARID, tw_h_rsc_BREADY, tw_h_rsc_BVALID,
      tw_h_rsc_BUSER, tw_h_rsc_BRESP, tw_h_rsc_BID, tw_h_rsc_WREADY, tw_h_rsc_WVALID,
      tw_h_rsc_WUSER, tw_h_rsc_WLAST, tw_h_rsc_WSTRB, tw_h_rsc_WDATA, tw_h_rsc_AWREADY,
      tw_h_rsc_AWVALID, tw_h_rsc_AWUSER, tw_h_rsc_AWREGION, tw_h_rsc_AWQOS, tw_h_rsc_AWPROT,
      tw_h_rsc_AWCACHE, tw_h_rsc_AWLOCK, tw_h_rsc_AWBURST, tw_h_rsc_AWSIZE, tw_h_rsc_AWLEN,
      tw_h_rsc_AWADDR, tw_h_rsc_AWID, core_wen, tw_h_rsci_oswt, tw_h_rsci_wen_comp,
      tw_h_rsci_s_raddr_core, tw_h_rsci_s_din_mxwt
);
  input clk;
  input rst;
  input tw_h_rsc_s_tdone;
  input tw_h_rsc_tr_write_done;
  input tw_h_rsc_RREADY;
  output tw_h_rsc_RVALID;
  output tw_h_rsc_RUSER;
  output tw_h_rsc_RLAST;
  output [1:0] tw_h_rsc_RRESP;
  output [31:0] tw_h_rsc_RDATA;
  output tw_h_rsc_RID;
  output tw_h_rsc_ARREADY;
  input tw_h_rsc_ARVALID;
  input tw_h_rsc_ARUSER;
  input [3:0] tw_h_rsc_ARREGION;
  input [3:0] tw_h_rsc_ARQOS;
  input [2:0] tw_h_rsc_ARPROT;
  input [3:0] tw_h_rsc_ARCACHE;
  input tw_h_rsc_ARLOCK;
  input [1:0] tw_h_rsc_ARBURST;
  input [2:0] tw_h_rsc_ARSIZE;
  input [7:0] tw_h_rsc_ARLEN;
  input [11:0] tw_h_rsc_ARADDR;
  input tw_h_rsc_ARID;
  input tw_h_rsc_BREADY;
  output tw_h_rsc_BVALID;
  output tw_h_rsc_BUSER;
  output [1:0] tw_h_rsc_BRESP;
  output tw_h_rsc_BID;
  output tw_h_rsc_WREADY;
  input tw_h_rsc_WVALID;
  input tw_h_rsc_WUSER;
  input tw_h_rsc_WLAST;
  input [3:0] tw_h_rsc_WSTRB;
  input [31:0] tw_h_rsc_WDATA;
  output tw_h_rsc_AWREADY;
  input tw_h_rsc_AWVALID;
  input tw_h_rsc_AWUSER;
  input [3:0] tw_h_rsc_AWREGION;
  input [3:0] tw_h_rsc_AWQOS;
  input [2:0] tw_h_rsc_AWPROT;
  input [3:0] tw_h_rsc_AWCACHE;
  input tw_h_rsc_AWLOCK;
  input [1:0] tw_h_rsc_AWBURST;
  input [2:0] tw_h_rsc_AWSIZE;
  input [7:0] tw_h_rsc_AWLEN;
  input [11:0] tw_h_rsc_AWADDR;
  input tw_h_rsc_AWID;
  input core_wen;
  input tw_h_rsci_oswt;
  output tw_h_rsci_wen_comp;
  input [9:0] tw_h_rsci_s_raddr_core;
  output [19:0] tw_h_rsci_s_din_mxwt;


  // Interconnect Declarations
  wire tw_h_rsci_biwt;
  wire tw_h_rsci_bdwt;
  wire tw_h_rsci_bcwt;
  wire tw_h_rsci_s_re_core_sct;
  wire [9:0] tw_h_rsci_s_raddr;
  wire [31:0] tw_h_rsci_s_din;
  wire tw_h_rsci_s_rrdy;
  wire tw_h_rsci_s_wrdy;
  wire tw_h_rsc_is_idle;
  wire [19:0] tw_h_rsci_s_din_mxwt_pconst;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd1024),
  .op_width(32'sd32),
  .cwidth(32'sd32),
  .addr_w(32'sd10),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd32),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) tw_h_rsci (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(tw_h_rsc_AWID),
      .AWADDR(tw_h_rsc_AWADDR),
      .AWLEN(tw_h_rsc_AWLEN),
      .AWSIZE(tw_h_rsc_AWSIZE),
      .AWBURST(tw_h_rsc_AWBURST),
      .AWLOCK(tw_h_rsc_AWLOCK),
      .AWCACHE(tw_h_rsc_AWCACHE),
      .AWPROT(tw_h_rsc_AWPROT),
      .AWQOS(tw_h_rsc_AWQOS),
      .AWREGION(tw_h_rsc_AWREGION),
      .AWUSER(tw_h_rsc_AWUSER),
      .AWVALID(tw_h_rsc_AWVALID),
      .AWREADY(tw_h_rsc_AWREADY),
      .WDATA(tw_h_rsc_WDATA),
      .WSTRB(tw_h_rsc_WSTRB),
      .WLAST(tw_h_rsc_WLAST),
      .WUSER(tw_h_rsc_WUSER),
      .WVALID(tw_h_rsc_WVALID),
      .WREADY(tw_h_rsc_WREADY),
      .BID(tw_h_rsc_BID),
      .BRESP(tw_h_rsc_BRESP),
      .BUSER(tw_h_rsc_BUSER),
      .BVALID(tw_h_rsc_BVALID),
      .BREADY(tw_h_rsc_BREADY),
      .ARID(tw_h_rsc_ARID),
      .ARADDR(tw_h_rsc_ARADDR),
      .ARLEN(tw_h_rsc_ARLEN),
      .ARSIZE(tw_h_rsc_ARSIZE),
      .ARBURST(tw_h_rsc_ARBURST),
      .ARLOCK(tw_h_rsc_ARLOCK),
      .ARCACHE(tw_h_rsc_ARCACHE),
      .ARPROT(tw_h_rsc_ARPROT),
      .ARQOS(tw_h_rsc_ARQOS),
      .ARREGION(tw_h_rsc_ARREGION),
      .ARUSER(tw_h_rsc_ARUSER),
      .ARVALID(tw_h_rsc_ARVALID),
      .ARREADY(tw_h_rsc_ARREADY),
      .RID(tw_h_rsc_RID),
      .RDATA(tw_h_rsc_RDATA),
      .RRESP(tw_h_rsc_RRESP),
      .RLAST(tw_h_rsc_RLAST),
      .RUSER(tw_h_rsc_RUSER),
      .RVALID(tw_h_rsc_RVALID),
      .RREADY(tw_h_rsc_RREADY),
      .s_re(tw_h_rsci_s_re_core_sct),
      .s_we(1'b0),
      .s_raddr(tw_h_rsci_s_raddr),
      .s_waddr(10'b0000000000),
      .s_din(tw_h_rsci_s_din),
      .s_dout(32'b00000000000000000000000000000000),
      .s_rrdy(tw_h_rsci_s_rrdy),
      .s_wrdy(tw_h_rsci_s_wrdy),
      .is_idle(tw_h_rsc_is_idle),
      .tr_write_done(tw_h_rsc_tr_write_done),
      .s_tdone(tw_h_rsc_s_tdone)
    );
  hybrid_core_tw_h_rsci_tw_h_rsc_wait_ctrl hybrid_core_tw_h_rsci_tw_h_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .tw_h_rsci_oswt(tw_h_rsci_oswt),
      .tw_h_rsci_biwt(tw_h_rsci_biwt),
      .tw_h_rsci_bdwt(tw_h_rsci_bdwt),
      .tw_h_rsci_bcwt(tw_h_rsci_bcwt),
      .tw_h_rsci_s_re_core_sct(tw_h_rsci_s_re_core_sct),
      .tw_h_rsci_s_rrdy(tw_h_rsci_s_rrdy)
    );
  hybrid_core_tw_h_rsci_tw_h_rsc_wait_dp hybrid_core_tw_h_rsci_tw_h_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .tw_h_rsci_oswt(tw_h_rsci_oswt),
      .tw_h_rsci_wen_comp(tw_h_rsci_wen_comp),
      .tw_h_rsci_s_raddr_core(tw_h_rsci_s_raddr_core),
      .tw_h_rsci_s_din_mxwt(tw_h_rsci_s_din_mxwt_pconst),
      .tw_h_rsci_biwt(tw_h_rsci_biwt),
      .tw_h_rsci_bdwt(tw_h_rsci_bdwt),
      .tw_h_rsci_bcwt(tw_h_rsci_bcwt),
      .tw_h_rsci_s_raddr(tw_h_rsci_s_raddr),
      .tw_h_rsci_s_raddr_core_sct(tw_h_rsci_s_re_core_sct),
      .tw_h_rsci_s_din(tw_h_rsci_s_din)
    );
  assign tw_h_rsci_s_din_mxwt = tw_h_rsci_s_din_mxwt_pconst;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_tw_rsci
// ------------------------------------------------------------------


module hybrid_core_tw_rsci (
  clk, rst, tw_rsc_s_tdone, tw_rsc_tr_write_done, tw_rsc_RREADY, tw_rsc_RVALID, tw_rsc_RUSER,
      tw_rsc_RLAST, tw_rsc_RRESP, tw_rsc_RDATA, tw_rsc_RID, tw_rsc_ARREADY, tw_rsc_ARVALID,
      tw_rsc_ARUSER, tw_rsc_ARREGION, tw_rsc_ARQOS, tw_rsc_ARPROT, tw_rsc_ARCACHE,
      tw_rsc_ARLOCK, tw_rsc_ARBURST, tw_rsc_ARSIZE, tw_rsc_ARLEN, tw_rsc_ARADDR,
      tw_rsc_ARID, tw_rsc_BREADY, tw_rsc_BVALID, tw_rsc_BUSER, tw_rsc_BRESP, tw_rsc_BID,
      tw_rsc_WREADY, tw_rsc_WVALID, tw_rsc_WUSER, tw_rsc_WLAST, tw_rsc_WSTRB, tw_rsc_WDATA,
      tw_rsc_AWREADY, tw_rsc_AWVALID, tw_rsc_AWUSER, tw_rsc_AWREGION, tw_rsc_AWQOS,
      tw_rsc_AWPROT, tw_rsc_AWCACHE, tw_rsc_AWLOCK, tw_rsc_AWBURST, tw_rsc_AWSIZE,
      tw_rsc_AWLEN, tw_rsc_AWADDR, tw_rsc_AWID, core_wen, tw_rsci_oswt, tw_rsci_wen_comp,
      tw_rsci_s_raddr_core, tw_rsci_s_din_mxwt
);
  input clk;
  input rst;
  input tw_rsc_s_tdone;
  input tw_rsc_tr_write_done;
  input tw_rsc_RREADY;
  output tw_rsc_RVALID;
  output tw_rsc_RUSER;
  output tw_rsc_RLAST;
  output [1:0] tw_rsc_RRESP;
  output [31:0] tw_rsc_RDATA;
  output tw_rsc_RID;
  output tw_rsc_ARREADY;
  input tw_rsc_ARVALID;
  input tw_rsc_ARUSER;
  input [3:0] tw_rsc_ARREGION;
  input [3:0] tw_rsc_ARQOS;
  input [2:0] tw_rsc_ARPROT;
  input [3:0] tw_rsc_ARCACHE;
  input tw_rsc_ARLOCK;
  input [1:0] tw_rsc_ARBURST;
  input [2:0] tw_rsc_ARSIZE;
  input [7:0] tw_rsc_ARLEN;
  input [11:0] tw_rsc_ARADDR;
  input tw_rsc_ARID;
  input tw_rsc_BREADY;
  output tw_rsc_BVALID;
  output tw_rsc_BUSER;
  output [1:0] tw_rsc_BRESP;
  output tw_rsc_BID;
  output tw_rsc_WREADY;
  input tw_rsc_WVALID;
  input tw_rsc_WUSER;
  input tw_rsc_WLAST;
  input [3:0] tw_rsc_WSTRB;
  input [31:0] tw_rsc_WDATA;
  output tw_rsc_AWREADY;
  input tw_rsc_AWVALID;
  input tw_rsc_AWUSER;
  input [3:0] tw_rsc_AWREGION;
  input [3:0] tw_rsc_AWQOS;
  input [2:0] tw_rsc_AWPROT;
  input [3:0] tw_rsc_AWCACHE;
  input tw_rsc_AWLOCK;
  input [1:0] tw_rsc_AWBURST;
  input [2:0] tw_rsc_AWSIZE;
  input [7:0] tw_rsc_AWLEN;
  input [11:0] tw_rsc_AWADDR;
  input tw_rsc_AWID;
  input core_wen;
  input tw_rsci_oswt;
  output tw_rsci_wen_comp;
  input [9:0] tw_rsci_s_raddr_core;
  output [19:0] tw_rsci_s_din_mxwt;


  // Interconnect Declarations
  wire tw_rsci_biwt;
  wire tw_rsci_bdwt;
  wire tw_rsci_bcwt;
  wire tw_rsci_s_re_core_sct;
  wire [9:0] tw_rsci_s_raddr;
  wire [31:0] tw_rsci_s_din;
  wire tw_rsci_s_rrdy;
  wire tw_rsci_s_wrdy;
  wire tw_rsc_is_idle;
  wire [19:0] tw_rsci_s_din_mxwt_pconst;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd1024),
  .op_width(32'sd32),
  .cwidth(32'sd32),
  .addr_w(32'sd10),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd32),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) tw_rsci (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(tw_rsc_AWID),
      .AWADDR(tw_rsc_AWADDR),
      .AWLEN(tw_rsc_AWLEN),
      .AWSIZE(tw_rsc_AWSIZE),
      .AWBURST(tw_rsc_AWBURST),
      .AWLOCK(tw_rsc_AWLOCK),
      .AWCACHE(tw_rsc_AWCACHE),
      .AWPROT(tw_rsc_AWPROT),
      .AWQOS(tw_rsc_AWQOS),
      .AWREGION(tw_rsc_AWREGION),
      .AWUSER(tw_rsc_AWUSER),
      .AWVALID(tw_rsc_AWVALID),
      .AWREADY(tw_rsc_AWREADY),
      .WDATA(tw_rsc_WDATA),
      .WSTRB(tw_rsc_WSTRB),
      .WLAST(tw_rsc_WLAST),
      .WUSER(tw_rsc_WUSER),
      .WVALID(tw_rsc_WVALID),
      .WREADY(tw_rsc_WREADY),
      .BID(tw_rsc_BID),
      .BRESP(tw_rsc_BRESP),
      .BUSER(tw_rsc_BUSER),
      .BVALID(tw_rsc_BVALID),
      .BREADY(tw_rsc_BREADY),
      .ARID(tw_rsc_ARID),
      .ARADDR(tw_rsc_ARADDR),
      .ARLEN(tw_rsc_ARLEN),
      .ARSIZE(tw_rsc_ARSIZE),
      .ARBURST(tw_rsc_ARBURST),
      .ARLOCK(tw_rsc_ARLOCK),
      .ARCACHE(tw_rsc_ARCACHE),
      .ARPROT(tw_rsc_ARPROT),
      .ARQOS(tw_rsc_ARQOS),
      .ARREGION(tw_rsc_ARREGION),
      .ARUSER(tw_rsc_ARUSER),
      .ARVALID(tw_rsc_ARVALID),
      .ARREADY(tw_rsc_ARREADY),
      .RID(tw_rsc_RID),
      .RDATA(tw_rsc_RDATA),
      .RRESP(tw_rsc_RRESP),
      .RLAST(tw_rsc_RLAST),
      .RUSER(tw_rsc_RUSER),
      .RVALID(tw_rsc_RVALID),
      .RREADY(tw_rsc_RREADY),
      .s_re(tw_rsci_s_re_core_sct),
      .s_we(1'b0),
      .s_raddr(tw_rsci_s_raddr),
      .s_waddr(10'b0000000000),
      .s_din(tw_rsci_s_din),
      .s_dout(32'b00000000000000000000000000000000),
      .s_rrdy(tw_rsci_s_rrdy),
      .s_wrdy(tw_rsci_s_wrdy),
      .is_idle(tw_rsc_is_idle),
      .tr_write_done(tw_rsc_tr_write_done),
      .s_tdone(tw_rsc_s_tdone)
    );
  hybrid_core_tw_rsci_tw_rsc_wait_ctrl hybrid_core_tw_rsci_tw_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .tw_rsci_oswt(tw_rsci_oswt),
      .tw_rsci_biwt(tw_rsci_biwt),
      .tw_rsci_bdwt(tw_rsci_bdwt),
      .tw_rsci_bcwt(tw_rsci_bcwt),
      .tw_rsci_s_re_core_sct(tw_rsci_s_re_core_sct),
      .tw_rsci_s_rrdy(tw_rsci_s_rrdy)
    );
  hybrid_core_tw_rsci_tw_rsc_wait_dp hybrid_core_tw_rsci_tw_rsc_wait_dp_inst (
      .clk(clk),
      .rst(rst),
      .tw_rsci_oswt(tw_rsci_oswt),
      .tw_rsci_wen_comp(tw_rsci_wen_comp),
      .tw_rsci_s_raddr_core(tw_rsci_s_raddr_core),
      .tw_rsci_s_din_mxwt(tw_rsci_s_din_mxwt_pconst),
      .tw_rsci_biwt(tw_rsci_biwt),
      .tw_rsci_bdwt(tw_rsci_bdwt),
      .tw_rsci_bcwt(tw_rsci_bcwt),
      .tw_rsci_s_raddr(tw_rsci_s_raddr),
      .tw_rsci_s_raddr_core_sct(tw_rsci_s_re_core_sct),
      .tw_rsci_s_din(tw_rsci_s_din)
    );
  assign tw_rsci_s_din_mxwt = tw_rsci_s_din_mxwt_pconst;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_revArr_rsci
// ------------------------------------------------------------------


module hybrid_core_revArr_rsci (
  clk, rst, revArr_rsc_s_tdone, revArr_rsc_tr_write_done, revArr_rsc_RREADY, revArr_rsc_RVALID,
      revArr_rsc_RUSER, revArr_rsc_RLAST, revArr_rsc_RRESP, revArr_rsc_RDATA, revArr_rsc_RID,
      revArr_rsc_ARREADY, revArr_rsc_ARVALID, revArr_rsc_ARUSER, revArr_rsc_ARREGION,
      revArr_rsc_ARQOS, revArr_rsc_ARPROT, revArr_rsc_ARCACHE, revArr_rsc_ARLOCK,
      revArr_rsc_ARBURST, revArr_rsc_ARSIZE, revArr_rsc_ARLEN, revArr_rsc_ARADDR,
      revArr_rsc_ARID, revArr_rsc_BREADY, revArr_rsc_BVALID, revArr_rsc_BUSER, revArr_rsc_BRESP,
      revArr_rsc_BID, revArr_rsc_WREADY, revArr_rsc_WVALID, revArr_rsc_WUSER, revArr_rsc_WLAST,
      revArr_rsc_WSTRB, revArr_rsc_WDATA, revArr_rsc_AWREADY, revArr_rsc_AWVALID,
      revArr_rsc_AWUSER, revArr_rsc_AWREGION, revArr_rsc_AWQOS, revArr_rsc_AWPROT,
      revArr_rsc_AWCACHE, revArr_rsc_AWLOCK, revArr_rsc_AWBURST, revArr_rsc_AWSIZE,
      revArr_rsc_AWLEN, revArr_rsc_AWADDR, revArr_rsc_AWID, core_wen, revArr_rsci_oswt,
      revArr_rsci_wen_comp, revArr_rsci_s_raddr_core, revArr_rsci_s_din_mxwt
);
  input clk;
  input rst;
  input revArr_rsc_s_tdone;
  input revArr_rsc_tr_write_done;
  input revArr_rsc_RREADY;
  output revArr_rsc_RVALID;
  output revArr_rsc_RUSER;
  output revArr_rsc_RLAST;
  output [1:0] revArr_rsc_RRESP;
  output [31:0] revArr_rsc_RDATA;
  output revArr_rsc_RID;
  output revArr_rsc_ARREADY;
  input revArr_rsc_ARVALID;
  input revArr_rsc_ARUSER;
  input [3:0] revArr_rsc_ARREGION;
  input [3:0] revArr_rsc_ARQOS;
  input [2:0] revArr_rsc_ARPROT;
  input [3:0] revArr_rsc_ARCACHE;
  input revArr_rsc_ARLOCK;
  input [1:0] revArr_rsc_ARBURST;
  input [2:0] revArr_rsc_ARSIZE;
  input [7:0] revArr_rsc_ARLEN;
  input [11:0] revArr_rsc_ARADDR;
  input revArr_rsc_ARID;
  input revArr_rsc_BREADY;
  output revArr_rsc_BVALID;
  output revArr_rsc_BUSER;
  output [1:0] revArr_rsc_BRESP;
  output revArr_rsc_BID;
  output revArr_rsc_WREADY;
  input revArr_rsc_WVALID;
  input revArr_rsc_WUSER;
  input revArr_rsc_WLAST;
  input [3:0] revArr_rsc_WSTRB;
  input [31:0] revArr_rsc_WDATA;
  output revArr_rsc_AWREADY;
  input revArr_rsc_AWVALID;
  input revArr_rsc_AWUSER;
  input [3:0] revArr_rsc_AWREGION;
  input [3:0] revArr_rsc_AWQOS;
  input [2:0] revArr_rsc_AWPROT;
  input [3:0] revArr_rsc_AWCACHE;
  input revArr_rsc_AWLOCK;
  input [1:0] revArr_rsc_AWBURST;
  input [2:0] revArr_rsc_AWSIZE;
  input [7:0] revArr_rsc_AWLEN;
  input [11:0] revArr_rsc_AWADDR;
  input revArr_rsc_AWID;
  input core_wen;
  input revArr_rsci_oswt;
  output revArr_rsci_wen_comp;
  input [4:0] revArr_rsci_s_raddr_core;
  output [9:0] revArr_rsci_s_din_mxwt;


  // Interconnect Declarations
  wire revArr_rsci_biwt;
  wire revArr_rsci_bdwt;
  wire revArr_rsci_bcwt;
  wire revArr_rsci_s_re_core_sct;
  wire [4:0] revArr_rsci_s_raddr;
  wire [31:0] revArr_rsci_s_din;
  wire revArr_rsci_s_rrdy;
  wire revArr_rsci_s_wrdy;
  wire revArr_rsc_is_idle;
  wire [9:0] revArr_rsci_s_din_mxwt_pconst;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd32),
  .op_width(32'sd20),
  .cwidth(32'sd32),
  .addr_w(32'sd5),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd32),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) revArr_rsci (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(revArr_rsc_AWID),
      .AWADDR(revArr_rsc_AWADDR),
      .AWLEN(revArr_rsc_AWLEN),
      .AWSIZE(revArr_rsc_AWSIZE),
      .AWBURST(revArr_rsc_AWBURST),
      .AWLOCK(revArr_rsc_AWLOCK),
      .AWCACHE(revArr_rsc_AWCACHE),
      .AWPROT(revArr_rsc_AWPROT),
      .AWQOS(revArr_rsc_AWQOS),
      .AWREGION(revArr_rsc_AWREGION),
      .AWUSER(revArr_rsc_AWUSER),
      .AWVALID(revArr_rsc_AWVALID),
      .AWREADY(revArr_rsc_AWREADY),
      .WDATA(revArr_rsc_WDATA),
      .WSTRB(revArr_rsc_WSTRB),
      .WLAST(revArr_rsc_WLAST),
      .WUSER(revArr_rsc_WUSER),
      .WVALID(revArr_rsc_WVALID),
      .WREADY(revArr_rsc_WREADY),
      .BID(revArr_rsc_BID),
      .BRESP(revArr_rsc_BRESP),
      .BUSER(revArr_rsc_BUSER),
      .BVALID(revArr_rsc_BVALID),
      .BREADY(revArr_rsc_BREADY),
      .ARID(revArr_rsc_ARID),
      .ARADDR(revArr_rsc_ARADDR),
      .ARLEN(revArr_rsc_ARLEN),
      .ARSIZE(revArr_rsc_ARSIZE),
      .ARBURST(revArr_rsc_ARBURST),
      .ARLOCK(revArr_rsc_ARLOCK),
      .ARCACHE(revArr_rsc_ARCACHE),
      .ARPROT(revArr_rsc_ARPROT),
      .ARQOS(revArr_rsc_ARQOS),
      .ARREGION(revArr_rsc_ARREGION),
      .ARUSER(revArr_rsc_ARUSER),
      .ARVALID(revArr_rsc_ARVALID),
      .ARREADY(revArr_rsc_ARREADY),
      .RID(revArr_rsc_RID),
      .RDATA(revArr_rsc_RDATA),
      .RRESP(revArr_rsc_RRESP),
      .RLAST(revArr_rsc_RLAST),
      .RUSER(revArr_rsc_RUSER),
      .RVALID(revArr_rsc_RVALID),
      .RREADY(revArr_rsc_RREADY),
      .s_re(revArr_rsci_s_re_core_sct),
      .s_we(1'b0),
      .s_raddr(revArr_rsci_s_raddr),
      .s_waddr(5'b00000),
      .s_din(revArr_rsci_s_din),
      .s_dout(32'b00000000000000000000000000000000),
      .s_rrdy(revArr_rsci_s_rrdy),
      .s_wrdy(revArr_rsci_s_wrdy),
      .is_idle(revArr_rsc_is_idle),
      .tr_write_done(revArr_rsc_tr_write_done),
      .s_tdone(revArr_rsc_s_tdone)
    );
  hybrid_core_revArr_rsci_revArr_rsc_wait_ctrl hybrid_core_revArr_rsci_revArr_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .revArr_rsci_oswt(revArr_rsci_oswt),
      .revArr_rsci_biwt(revArr_rsci_biwt),
      .revArr_rsci_bdwt(revArr_rsci_bdwt),
      .revArr_rsci_bcwt(revArr_rsci_bcwt),
      .revArr_rsci_s_re_core_sct(revArr_rsci_s_re_core_sct),
      .revArr_rsci_s_rrdy(revArr_rsci_s_rrdy)
    );
  hybrid_core_revArr_rsci_revArr_rsc_wait_dp hybrid_core_revArr_rsci_revArr_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .revArr_rsci_oswt(revArr_rsci_oswt),
      .revArr_rsci_wen_comp(revArr_rsci_wen_comp),
      .revArr_rsci_s_raddr_core(revArr_rsci_s_raddr_core),
      .revArr_rsci_s_din_mxwt(revArr_rsci_s_din_mxwt_pconst),
      .revArr_rsci_biwt(revArr_rsci_biwt),
      .revArr_rsci_bdwt(revArr_rsci_bdwt),
      .revArr_rsci_bcwt(revArr_rsci_bcwt),
      .revArr_rsci_s_raddr(revArr_rsci_s_raddr),
      .revArr_rsci_s_raddr_core_sct(revArr_rsci_s_re_core_sct),
      .revArr_rsci_s_din(revArr_rsci_s_din)
    );
  assign revArr_rsci_s_din_mxwt = revArr_rsci_s_din_mxwt_pconst;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_h_rsci
// ------------------------------------------------------------------


module hybrid_core_twiddle_h_rsci (
  clk, rst, twiddle_h_rsc_s_tdone, twiddle_h_rsc_tr_write_done, twiddle_h_rsc_RREADY,
      twiddle_h_rsc_RVALID, twiddle_h_rsc_RUSER, twiddle_h_rsc_RLAST, twiddle_h_rsc_RRESP,
      twiddle_h_rsc_RDATA, twiddle_h_rsc_RID, twiddle_h_rsc_ARREADY, twiddle_h_rsc_ARVALID,
      twiddle_h_rsc_ARUSER, twiddle_h_rsc_ARREGION, twiddle_h_rsc_ARQOS, twiddle_h_rsc_ARPROT,
      twiddle_h_rsc_ARCACHE, twiddle_h_rsc_ARLOCK, twiddle_h_rsc_ARBURST, twiddle_h_rsc_ARSIZE,
      twiddle_h_rsc_ARLEN, twiddle_h_rsc_ARADDR, twiddle_h_rsc_ARID, twiddle_h_rsc_BREADY,
      twiddle_h_rsc_BVALID, twiddle_h_rsc_BUSER, twiddle_h_rsc_BRESP, twiddle_h_rsc_BID,
      twiddle_h_rsc_WREADY, twiddle_h_rsc_WVALID, twiddle_h_rsc_WUSER, twiddle_h_rsc_WLAST,
      twiddle_h_rsc_WSTRB, twiddle_h_rsc_WDATA, twiddle_h_rsc_AWREADY, twiddle_h_rsc_AWVALID,
      twiddle_h_rsc_AWUSER, twiddle_h_rsc_AWREGION, twiddle_h_rsc_AWQOS, twiddle_h_rsc_AWPROT,
      twiddle_h_rsc_AWCACHE, twiddle_h_rsc_AWLOCK, twiddle_h_rsc_AWBURST, twiddle_h_rsc_AWSIZE,
      twiddle_h_rsc_AWLEN, twiddle_h_rsc_AWADDR, twiddle_h_rsc_AWID, core_wen, twiddle_h_rsci_oswt,
      twiddle_h_rsci_wen_comp, twiddle_h_rsci_s_raddr_core, twiddle_h_rsci_s_din_mxwt
);
  input clk;
  input rst;
  input twiddle_h_rsc_s_tdone;
  input twiddle_h_rsc_tr_write_done;
  input twiddle_h_rsc_RREADY;
  output twiddle_h_rsc_RVALID;
  output twiddle_h_rsc_RUSER;
  output twiddle_h_rsc_RLAST;
  output [1:0] twiddle_h_rsc_RRESP;
  output [31:0] twiddle_h_rsc_RDATA;
  output twiddle_h_rsc_RID;
  output twiddle_h_rsc_ARREADY;
  input twiddle_h_rsc_ARVALID;
  input twiddle_h_rsc_ARUSER;
  input [3:0] twiddle_h_rsc_ARREGION;
  input [3:0] twiddle_h_rsc_ARQOS;
  input [2:0] twiddle_h_rsc_ARPROT;
  input [3:0] twiddle_h_rsc_ARCACHE;
  input twiddle_h_rsc_ARLOCK;
  input [1:0] twiddle_h_rsc_ARBURST;
  input [2:0] twiddle_h_rsc_ARSIZE;
  input [7:0] twiddle_h_rsc_ARLEN;
  input [11:0] twiddle_h_rsc_ARADDR;
  input twiddle_h_rsc_ARID;
  input twiddle_h_rsc_BREADY;
  output twiddle_h_rsc_BVALID;
  output twiddle_h_rsc_BUSER;
  output [1:0] twiddle_h_rsc_BRESP;
  output twiddle_h_rsc_BID;
  output twiddle_h_rsc_WREADY;
  input twiddle_h_rsc_WVALID;
  input twiddle_h_rsc_WUSER;
  input twiddle_h_rsc_WLAST;
  input [3:0] twiddle_h_rsc_WSTRB;
  input [31:0] twiddle_h_rsc_WDATA;
  output twiddle_h_rsc_AWREADY;
  input twiddle_h_rsc_AWVALID;
  input twiddle_h_rsc_AWUSER;
  input [3:0] twiddle_h_rsc_AWREGION;
  input [3:0] twiddle_h_rsc_AWQOS;
  input [2:0] twiddle_h_rsc_AWPROT;
  input [3:0] twiddle_h_rsc_AWCACHE;
  input twiddle_h_rsc_AWLOCK;
  input [1:0] twiddle_h_rsc_AWBURST;
  input [2:0] twiddle_h_rsc_AWSIZE;
  input [7:0] twiddle_h_rsc_AWLEN;
  input [11:0] twiddle_h_rsc_AWADDR;
  input twiddle_h_rsc_AWID;
  input core_wen;
  input twiddle_h_rsci_oswt;
  output twiddle_h_rsci_wen_comp;
  input [4:0] twiddle_h_rsci_s_raddr_core;
  output [31:0] twiddle_h_rsci_s_din_mxwt;


  // Interconnect Declarations
  wire twiddle_h_rsci_biwt;
  wire twiddle_h_rsci_bdwt;
  wire twiddle_h_rsci_bcwt;
  wire twiddle_h_rsci_s_re_core_sct;
  wire [4:0] twiddle_h_rsci_s_raddr;
  wire [31:0] twiddle_h_rsci_s_din;
  wire twiddle_h_rsci_s_rrdy;
  wire twiddle_h_rsci_s_wrdy;
  wire twiddle_h_rsc_is_idle;


  // Interconnect Declarations for Component Instantiations 
  wire [4:0] nl_hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_s_raddr_core;
  assign nl_hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_s_raddr_core
      = {1'b0 , (twiddle_h_rsci_s_raddr_core[3:0])};
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd32),
  .op_width(32'sd32),
  .cwidth(32'sd32),
  .addr_w(32'sd5),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd32),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) twiddle_h_rsci (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(twiddle_h_rsc_AWID),
      .AWADDR(twiddle_h_rsc_AWADDR),
      .AWLEN(twiddle_h_rsc_AWLEN),
      .AWSIZE(twiddle_h_rsc_AWSIZE),
      .AWBURST(twiddle_h_rsc_AWBURST),
      .AWLOCK(twiddle_h_rsc_AWLOCK),
      .AWCACHE(twiddle_h_rsc_AWCACHE),
      .AWPROT(twiddle_h_rsc_AWPROT),
      .AWQOS(twiddle_h_rsc_AWQOS),
      .AWREGION(twiddle_h_rsc_AWREGION),
      .AWUSER(twiddle_h_rsc_AWUSER),
      .AWVALID(twiddle_h_rsc_AWVALID),
      .AWREADY(twiddle_h_rsc_AWREADY),
      .WDATA(twiddle_h_rsc_WDATA),
      .WSTRB(twiddle_h_rsc_WSTRB),
      .WLAST(twiddle_h_rsc_WLAST),
      .WUSER(twiddle_h_rsc_WUSER),
      .WVALID(twiddle_h_rsc_WVALID),
      .WREADY(twiddle_h_rsc_WREADY),
      .BID(twiddle_h_rsc_BID),
      .BRESP(twiddle_h_rsc_BRESP),
      .BUSER(twiddle_h_rsc_BUSER),
      .BVALID(twiddle_h_rsc_BVALID),
      .BREADY(twiddle_h_rsc_BREADY),
      .ARID(twiddle_h_rsc_ARID),
      .ARADDR(twiddle_h_rsc_ARADDR),
      .ARLEN(twiddle_h_rsc_ARLEN),
      .ARSIZE(twiddle_h_rsc_ARSIZE),
      .ARBURST(twiddle_h_rsc_ARBURST),
      .ARLOCK(twiddle_h_rsc_ARLOCK),
      .ARCACHE(twiddle_h_rsc_ARCACHE),
      .ARPROT(twiddle_h_rsc_ARPROT),
      .ARQOS(twiddle_h_rsc_ARQOS),
      .ARREGION(twiddle_h_rsc_ARREGION),
      .ARUSER(twiddle_h_rsc_ARUSER),
      .ARVALID(twiddle_h_rsc_ARVALID),
      .ARREADY(twiddle_h_rsc_ARREADY),
      .RID(twiddle_h_rsc_RID),
      .RDATA(twiddle_h_rsc_RDATA),
      .RRESP(twiddle_h_rsc_RRESP),
      .RLAST(twiddle_h_rsc_RLAST),
      .RUSER(twiddle_h_rsc_RUSER),
      .RVALID(twiddle_h_rsc_RVALID),
      .RREADY(twiddle_h_rsc_RREADY),
      .s_re(twiddle_h_rsci_s_re_core_sct),
      .s_we(1'b0),
      .s_raddr(twiddle_h_rsci_s_raddr),
      .s_waddr(5'b00000),
      .s_din(twiddle_h_rsci_s_din),
      .s_dout(32'b00000000000000000000000000000000),
      .s_rrdy(twiddle_h_rsci_s_rrdy),
      .s_wrdy(twiddle_h_rsci_s_wrdy),
      .is_idle(twiddle_h_rsc_is_idle),
      .tr_write_done(twiddle_h_rsc_tr_write_done),
      .s_tdone(twiddle_h_rsc_s_tdone)
    );
  hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_ctrl hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .twiddle_h_rsci_oswt(twiddle_h_rsci_oswt),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt),
      .twiddle_h_rsci_bcwt(twiddle_h_rsci_bcwt),
      .twiddle_h_rsci_s_re_core_sct(twiddle_h_rsci_s_re_core_sct),
      .twiddle_h_rsci_s_rrdy(twiddle_h_rsci_s_rrdy)
    );
  hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_dp hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_oswt(twiddle_h_rsci_oswt),
      .twiddle_h_rsci_wen_comp(twiddle_h_rsci_wen_comp),
      .twiddle_h_rsci_s_raddr_core(nl_hybrid_core_twiddle_h_rsci_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_s_raddr_core[4:0]),
      .twiddle_h_rsci_s_din_mxwt(twiddle_h_rsci_s_din_mxwt),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt),
      .twiddle_h_rsci_bcwt(twiddle_h_rsci_bcwt),
      .twiddle_h_rsci_s_raddr(twiddle_h_rsci_s_raddr),
      .twiddle_h_rsci_s_raddr_core_sct(twiddle_h_rsci_s_re_core_sct),
      .twiddle_h_rsci_s_din(twiddle_h_rsci_s_din)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_twiddle_rsci
// ------------------------------------------------------------------


module hybrid_core_twiddle_rsci (
  clk, rst, twiddle_rsc_s_tdone, twiddle_rsc_tr_write_done, twiddle_rsc_RREADY, twiddle_rsc_RVALID,
      twiddle_rsc_RUSER, twiddle_rsc_RLAST, twiddle_rsc_RRESP, twiddle_rsc_RDATA,
      twiddle_rsc_RID, twiddle_rsc_ARREADY, twiddle_rsc_ARVALID, twiddle_rsc_ARUSER,
      twiddle_rsc_ARREGION, twiddle_rsc_ARQOS, twiddle_rsc_ARPROT, twiddle_rsc_ARCACHE,
      twiddle_rsc_ARLOCK, twiddle_rsc_ARBURST, twiddle_rsc_ARSIZE, twiddle_rsc_ARLEN,
      twiddle_rsc_ARADDR, twiddle_rsc_ARID, twiddle_rsc_BREADY, twiddle_rsc_BVALID,
      twiddle_rsc_BUSER, twiddle_rsc_BRESP, twiddle_rsc_BID, twiddle_rsc_WREADY,
      twiddle_rsc_WVALID, twiddle_rsc_WUSER, twiddle_rsc_WLAST, twiddle_rsc_WSTRB,
      twiddle_rsc_WDATA, twiddle_rsc_AWREADY, twiddle_rsc_AWVALID, twiddle_rsc_AWUSER,
      twiddle_rsc_AWREGION, twiddle_rsc_AWQOS, twiddle_rsc_AWPROT, twiddle_rsc_AWCACHE,
      twiddle_rsc_AWLOCK, twiddle_rsc_AWBURST, twiddle_rsc_AWSIZE, twiddle_rsc_AWLEN,
      twiddle_rsc_AWADDR, twiddle_rsc_AWID, core_wen, twiddle_rsci_oswt, twiddle_rsci_wen_comp,
      twiddle_rsci_s_raddr_core, twiddle_rsci_s_din_mxwt
);
  input clk;
  input rst;
  input twiddle_rsc_s_tdone;
  input twiddle_rsc_tr_write_done;
  input twiddle_rsc_RREADY;
  output twiddle_rsc_RVALID;
  output twiddle_rsc_RUSER;
  output twiddle_rsc_RLAST;
  output [1:0] twiddle_rsc_RRESP;
  output [31:0] twiddle_rsc_RDATA;
  output twiddle_rsc_RID;
  output twiddle_rsc_ARREADY;
  input twiddle_rsc_ARVALID;
  input twiddle_rsc_ARUSER;
  input [3:0] twiddle_rsc_ARREGION;
  input [3:0] twiddle_rsc_ARQOS;
  input [2:0] twiddle_rsc_ARPROT;
  input [3:0] twiddle_rsc_ARCACHE;
  input twiddle_rsc_ARLOCK;
  input [1:0] twiddle_rsc_ARBURST;
  input [2:0] twiddle_rsc_ARSIZE;
  input [7:0] twiddle_rsc_ARLEN;
  input [11:0] twiddle_rsc_ARADDR;
  input twiddle_rsc_ARID;
  input twiddle_rsc_BREADY;
  output twiddle_rsc_BVALID;
  output twiddle_rsc_BUSER;
  output [1:0] twiddle_rsc_BRESP;
  output twiddle_rsc_BID;
  output twiddle_rsc_WREADY;
  input twiddle_rsc_WVALID;
  input twiddle_rsc_WUSER;
  input twiddle_rsc_WLAST;
  input [3:0] twiddle_rsc_WSTRB;
  input [31:0] twiddle_rsc_WDATA;
  output twiddle_rsc_AWREADY;
  input twiddle_rsc_AWVALID;
  input twiddle_rsc_AWUSER;
  input [3:0] twiddle_rsc_AWREGION;
  input [3:0] twiddle_rsc_AWQOS;
  input [2:0] twiddle_rsc_AWPROT;
  input [3:0] twiddle_rsc_AWCACHE;
  input twiddle_rsc_AWLOCK;
  input [1:0] twiddle_rsc_AWBURST;
  input [2:0] twiddle_rsc_AWSIZE;
  input [7:0] twiddle_rsc_AWLEN;
  input [11:0] twiddle_rsc_AWADDR;
  input twiddle_rsc_AWID;
  input core_wen;
  input twiddle_rsci_oswt;
  output twiddle_rsci_wen_comp;
  input [4:0] twiddle_rsci_s_raddr_core;
  output [31:0] twiddle_rsci_s_din_mxwt;


  // Interconnect Declarations
  wire twiddle_rsci_biwt;
  wire twiddle_rsci_bdwt;
  wire twiddle_rsci_bcwt;
  wire twiddle_rsci_s_re_core_sct;
  wire [4:0] twiddle_rsci_s_raddr;
  wire [31:0] twiddle_rsci_s_din;
  wire twiddle_rsci_s_rrdy;
  wire twiddle_rsci_s_wrdy;
  wire twiddle_rsc_is_idle;


  // Interconnect Declarations for Component Instantiations 
  wire [4:0] nl_hybrid_core_twiddle_rsci_twiddle_rsc_wait_dp_inst_twiddle_rsci_s_raddr_core;
  assign nl_hybrid_core_twiddle_rsci_twiddle_rsc_wait_dp_inst_twiddle_rsci_s_raddr_core
      = {1'b0 , (twiddle_rsci_s_raddr_core[3:0])};
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd32),
  .op_width(32'sd32),
  .cwidth(32'sd32),
  .addr_w(32'sd5),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd32),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) twiddle_rsci (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(twiddle_rsc_AWID),
      .AWADDR(twiddle_rsc_AWADDR),
      .AWLEN(twiddle_rsc_AWLEN),
      .AWSIZE(twiddle_rsc_AWSIZE),
      .AWBURST(twiddle_rsc_AWBURST),
      .AWLOCK(twiddle_rsc_AWLOCK),
      .AWCACHE(twiddle_rsc_AWCACHE),
      .AWPROT(twiddle_rsc_AWPROT),
      .AWQOS(twiddle_rsc_AWQOS),
      .AWREGION(twiddle_rsc_AWREGION),
      .AWUSER(twiddle_rsc_AWUSER),
      .AWVALID(twiddle_rsc_AWVALID),
      .AWREADY(twiddle_rsc_AWREADY),
      .WDATA(twiddle_rsc_WDATA),
      .WSTRB(twiddle_rsc_WSTRB),
      .WLAST(twiddle_rsc_WLAST),
      .WUSER(twiddle_rsc_WUSER),
      .WVALID(twiddle_rsc_WVALID),
      .WREADY(twiddle_rsc_WREADY),
      .BID(twiddle_rsc_BID),
      .BRESP(twiddle_rsc_BRESP),
      .BUSER(twiddle_rsc_BUSER),
      .BVALID(twiddle_rsc_BVALID),
      .BREADY(twiddle_rsc_BREADY),
      .ARID(twiddle_rsc_ARID),
      .ARADDR(twiddle_rsc_ARADDR),
      .ARLEN(twiddle_rsc_ARLEN),
      .ARSIZE(twiddle_rsc_ARSIZE),
      .ARBURST(twiddle_rsc_ARBURST),
      .ARLOCK(twiddle_rsc_ARLOCK),
      .ARCACHE(twiddle_rsc_ARCACHE),
      .ARPROT(twiddle_rsc_ARPROT),
      .ARQOS(twiddle_rsc_ARQOS),
      .ARREGION(twiddle_rsc_ARREGION),
      .ARUSER(twiddle_rsc_ARUSER),
      .ARVALID(twiddle_rsc_ARVALID),
      .ARREADY(twiddle_rsc_ARREADY),
      .RID(twiddle_rsc_RID),
      .RDATA(twiddle_rsc_RDATA),
      .RRESP(twiddle_rsc_RRESP),
      .RLAST(twiddle_rsc_RLAST),
      .RUSER(twiddle_rsc_RUSER),
      .RVALID(twiddle_rsc_RVALID),
      .RREADY(twiddle_rsc_RREADY),
      .s_re(twiddle_rsci_s_re_core_sct),
      .s_we(1'b0),
      .s_raddr(twiddle_rsci_s_raddr),
      .s_waddr(5'b00000),
      .s_din(twiddle_rsci_s_din),
      .s_dout(32'b00000000000000000000000000000000),
      .s_rrdy(twiddle_rsci_s_rrdy),
      .s_wrdy(twiddle_rsci_s_wrdy),
      .is_idle(twiddle_rsc_is_idle),
      .tr_write_done(twiddle_rsc_tr_write_done),
      .s_tdone(twiddle_rsc_s_tdone)
    );
  hybrid_core_twiddle_rsci_twiddle_rsc_wait_ctrl hybrid_core_twiddle_rsci_twiddle_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .twiddle_rsci_oswt(twiddle_rsci_oswt),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt),
      .twiddle_rsci_bcwt(twiddle_rsci_bcwt),
      .twiddle_rsci_s_re_core_sct(twiddle_rsci_s_re_core_sct),
      .twiddle_rsci_s_rrdy(twiddle_rsci_s_rrdy)
    );
  hybrid_core_twiddle_rsci_twiddle_rsc_wait_dp hybrid_core_twiddle_rsci_twiddle_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsci_oswt(twiddle_rsci_oswt),
      .twiddle_rsci_wen_comp(twiddle_rsci_wen_comp),
      .twiddle_rsci_s_raddr_core(nl_hybrid_core_twiddle_rsci_twiddle_rsc_wait_dp_inst_twiddle_rsci_s_raddr_core[4:0]),
      .twiddle_rsci_s_din_mxwt(twiddle_rsci_s_din_mxwt),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt),
      .twiddle_rsci_bcwt(twiddle_rsci_bcwt),
      .twiddle_rsci_s_raddr(twiddle_rsci_s_raddr),
      .twiddle_rsci_s_raddr_core_sct(twiddle_rsci_s_re_core_sct),
      .twiddle_rsci_s_din(twiddle_rsci_s_din)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core_x_rsci
// ------------------------------------------------------------------


module hybrid_core_x_rsci (
  clk, rst, x_rsc_s_tdone, x_rsc_tr_write_done, x_rsc_RREADY, x_rsc_RVALID, x_rsc_RUSER,
      x_rsc_RLAST, x_rsc_RRESP, x_rsc_RDATA, x_rsc_RID, x_rsc_ARREADY, x_rsc_ARVALID,
      x_rsc_ARUSER, x_rsc_ARREGION, x_rsc_ARQOS, x_rsc_ARPROT, x_rsc_ARCACHE, x_rsc_ARLOCK,
      x_rsc_ARBURST, x_rsc_ARSIZE, x_rsc_ARLEN, x_rsc_ARADDR, x_rsc_ARID, x_rsc_BREADY,
      x_rsc_BVALID, x_rsc_BUSER, x_rsc_BRESP, x_rsc_BID, x_rsc_WREADY, x_rsc_WVALID,
      x_rsc_WUSER, x_rsc_WLAST, x_rsc_WSTRB, x_rsc_WDATA, x_rsc_AWREADY, x_rsc_AWVALID,
      x_rsc_AWUSER, x_rsc_AWREGION, x_rsc_AWQOS, x_rsc_AWPROT, x_rsc_AWCACHE, x_rsc_AWLOCK,
      x_rsc_AWBURST, x_rsc_AWSIZE, x_rsc_AWLEN, x_rsc_AWADDR, x_rsc_AWID, core_wen,
      x_rsci_oswt, x_rsci_wen_comp, x_rsci_oswt_1, x_rsci_wen_comp_1, x_rsci_s_raddr_core,
      x_rsci_s_waddr_core, x_rsci_s_din_mxwt, x_rsci_s_dout_core
);
  input clk;
  input rst;
  input x_rsc_s_tdone;
  input x_rsc_tr_write_done;
  input x_rsc_RREADY;
  output x_rsc_RVALID;
  output x_rsc_RUSER;
  output x_rsc_RLAST;
  output [1:0] x_rsc_RRESP;
  output [31:0] x_rsc_RDATA;
  output x_rsc_RID;
  output x_rsc_ARREADY;
  input x_rsc_ARVALID;
  input x_rsc_ARUSER;
  input [3:0] x_rsc_ARREGION;
  input [3:0] x_rsc_ARQOS;
  input [2:0] x_rsc_ARPROT;
  input [3:0] x_rsc_ARCACHE;
  input x_rsc_ARLOCK;
  input [1:0] x_rsc_ARBURST;
  input [2:0] x_rsc_ARSIZE;
  input [7:0] x_rsc_ARLEN;
  input [11:0] x_rsc_ARADDR;
  input x_rsc_ARID;
  input x_rsc_BREADY;
  output x_rsc_BVALID;
  output x_rsc_BUSER;
  output [1:0] x_rsc_BRESP;
  output x_rsc_BID;
  output x_rsc_WREADY;
  input x_rsc_WVALID;
  input x_rsc_WUSER;
  input x_rsc_WLAST;
  input [3:0] x_rsc_WSTRB;
  input [31:0] x_rsc_WDATA;
  output x_rsc_AWREADY;
  input x_rsc_AWVALID;
  input x_rsc_AWUSER;
  input [3:0] x_rsc_AWREGION;
  input [3:0] x_rsc_AWQOS;
  input [2:0] x_rsc_AWPROT;
  input [3:0] x_rsc_AWCACHE;
  input x_rsc_AWLOCK;
  input [1:0] x_rsc_AWBURST;
  input [2:0] x_rsc_AWSIZE;
  input [7:0] x_rsc_AWLEN;
  input [11:0] x_rsc_AWADDR;
  input x_rsc_AWID;
  input core_wen;
  input x_rsci_oswt;
  output x_rsci_wen_comp;
  input x_rsci_oswt_1;
  output x_rsci_wen_comp_1;
  input [9:0] x_rsci_s_raddr_core;
  input [9:0] x_rsci_s_waddr_core;
  output [31:0] x_rsci_s_din_mxwt;
  input [31:0] x_rsci_s_dout_core;


  // Interconnect Declarations
  wire x_rsci_biwt;
  wire x_rsci_bdwt;
  wire x_rsci_bcwt;
  wire x_rsci_s_re_core_sct;
  wire x_rsci_biwt_1;
  wire x_rsci_bdwt_2;
  wire x_rsci_bcwt_1;
  wire x_rsci_s_we_core_sct;
  wire [9:0] x_rsci_s_raddr;
  wire [9:0] x_rsci_s_waddr;
  wire [31:0] x_rsci_s_din;
  wire [31:0] x_rsci_s_dout;
  wire x_rsci_s_rrdy;
  wire x_rsci_s_wrdy;
  wire x_rsc_is_idle_1;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd1024),
  .op_width(32'sd32),
  .cwidth(32'sd32),
  .addr_w(32'sd10),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd32),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) x_rsci (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(x_rsc_AWID),
      .AWADDR(x_rsc_AWADDR),
      .AWLEN(x_rsc_AWLEN),
      .AWSIZE(x_rsc_AWSIZE),
      .AWBURST(x_rsc_AWBURST),
      .AWLOCK(x_rsc_AWLOCK),
      .AWCACHE(x_rsc_AWCACHE),
      .AWPROT(x_rsc_AWPROT),
      .AWQOS(x_rsc_AWQOS),
      .AWREGION(x_rsc_AWREGION),
      .AWUSER(x_rsc_AWUSER),
      .AWVALID(x_rsc_AWVALID),
      .AWREADY(x_rsc_AWREADY),
      .WDATA(x_rsc_WDATA),
      .WSTRB(x_rsc_WSTRB),
      .WLAST(x_rsc_WLAST),
      .WUSER(x_rsc_WUSER),
      .WVALID(x_rsc_WVALID),
      .WREADY(x_rsc_WREADY),
      .BID(x_rsc_BID),
      .BRESP(x_rsc_BRESP),
      .BUSER(x_rsc_BUSER),
      .BVALID(x_rsc_BVALID),
      .BREADY(x_rsc_BREADY),
      .ARID(x_rsc_ARID),
      .ARADDR(x_rsc_ARADDR),
      .ARLEN(x_rsc_ARLEN),
      .ARSIZE(x_rsc_ARSIZE),
      .ARBURST(x_rsc_ARBURST),
      .ARLOCK(x_rsc_ARLOCK),
      .ARCACHE(x_rsc_ARCACHE),
      .ARPROT(x_rsc_ARPROT),
      .ARQOS(x_rsc_ARQOS),
      .ARREGION(x_rsc_ARREGION),
      .ARUSER(x_rsc_ARUSER),
      .ARVALID(x_rsc_ARVALID),
      .ARREADY(x_rsc_ARREADY),
      .RID(x_rsc_RID),
      .RDATA(x_rsc_RDATA),
      .RRESP(x_rsc_RRESP),
      .RLAST(x_rsc_RLAST),
      .RUSER(x_rsc_RUSER),
      .RVALID(x_rsc_RVALID),
      .RREADY(x_rsc_RREADY),
      .s_re(x_rsci_s_re_core_sct),
      .s_we(x_rsci_s_we_core_sct),
      .s_raddr(x_rsci_s_raddr),
      .s_waddr(x_rsci_s_waddr),
      .s_din(x_rsci_s_din),
      .s_dout(x_rsci_s_dout),
      .s_rrdy(x_rsci_s_rrdy),
      .s_wrdy(x_rsci_s_wrdy),
      .is_idle(x_rsc_is_idle_1),
      .tr_write_done(x_rsc_tr_write_done),
      .s_tdone(x_rsc_s_tdone)
    );
  hybrid_core_x_rsci_x_rsc_wait_ctrl hybrid_core_x_rsci_x_rsc_wait_ctrl_inst (
      .core_wen(core_wen),
      .x_rsci_oswt(x_rsci_oswt),
      .x_rsci_oswt_1(x_rsci_oswt_1),
      .x_rsci_biwt(x_rsci_biwt),
      .x_rsci_bdwt(x_rsci_bdwt),
      .x_rsci_bcwt(x_rsci_bcwt),
      .x_rsci_s_re_core_sct(x_rsci_s_re_core_sct),
      .x_rsci_biwt_1(x_rsci_biwt_1),
      .x_rsci_bdwt_2(x_rsci_bdwt_2),
      .x_rsci_bcwt_1(x_rsci_bcwt_1),
      .x_rsci_s_we_core_sct(x_rsci_s_we_core_sct),
      .x_rsci_s_rrdy(x_rsci_s_rrdy),
      .x_rsci_s_wrdy(x_rsci_s_wrdy)
    );
  hybrid_core_x_rsci_x_rsc_wait_dp hybrid_core_x_rsci_x_rsc_wait_dp_inst (
      .clk(clk),
      .rst(rst),
      .x_rsci_oswt(x_rsci_oswt),
      .x_rsci_wen_comp(x_rsci_wen_comp),
      .x_rsci_oswt_1(x_rsci_oswt_1),
      .x_rsci_wen_comp_1(x_rsci_wen_comp_1),
      .x_rsci_s_raddr_core(x_rsci_s_raddr_core),
      .x_rsci_s_waddr_core(x_rsci_s_waddr_core),
      .x_rsci_s_din_mxwt(x_rsci_s_din_mxwt),
      .x_rsci_s_dout_core(x_rsci_s_dout_core),
      .x_rsci_biwt(x_rsci_biwt),
      .x_rsci_bdwt(x_rsci_bdwt),
      .x_rsci_bcwt(x_rsci_bcwt),
      .x_rsci_biwt_1(x_rsci_biwt_1),
      .x_rsci_bdwt_2(x_rsci_bdwt_2),
      .x_rsci_bcwt_1(x_rsci_bcwt_1),
      .x_rsci_s_raddr(x_rsci_s_raddr),
      .x_rsci_s_raddr_core_sct(x_rsci_s_re_core_sct),
      .x_rsci_s_waddr(x_rsci_s_waddr),
      .x_rsci_s_waddr_core_sct(x_rsci_s_we_core_sct),
      .x_rsci_s_din(x_rsci_s_din),
      .x_rsci_s_dout(x_rsci_s_dout)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid_core
// ------------------------------------------------------------------


module hybrid_core (
  clk, rst, x_rsc_s_tdone, x_rsc_tr_write_done, x_rsc_RREADY, x_rsc_RVALID, x_rsc_RUSER,
      x_rsc_RLAST, x_rsc_RRESP, x_rsc_RDATA, x_rsc_RID, x_rsc_ARREADY, x_rsc_ARVALID,
      x_rsc_ARUSER, x_rsc_ARREGION, x_rsc_ARQOS, x_rsc_ARPROT, x_rsc_ARCACHE, x_rsc_ARLOCK,
      x_rsc_ARBURST, x_rsc_ARSIZE, x_rsc_ARLEN, x_rsc_ARADDR, x_rsc_ARID, x_rsc_BREADY,
      x_rsc_BVALID, x_rsc_BUSER, x_rsc_BRESP, x_rsc_BID, x_rsc_WREADY, x_rsc_WVALID,
      x_rsc_WUSER, x_rsc_WLAST, x_rsc_WSTRB, x_rsc_WDATA, x_rsc_AWREADY, x_rsc_AWVALID,
      x_rsc_AWUSER, x_rsc_AWREGION, x_rsc_AWQOS, x_rsc_AWPROT, x_rsc_AWCACHE, x_rsc_AWLOCK,
      x_rsc_AWBURST, x_rsc_AWSIZE, x_rsc_AWLEN, x_rsc_AWADDR, x_rsc_AWID, x_rsc_triosy_lz,
      m_rsc_dat, m_rsc_triosy_lz, twiddle_rsc_s_tdone, twiddle_rsc_tr_write_done,
      twiddle_rsc_RREADY, twiddle_rsc_RVALID, twiddle_rsc_RUSER, twiddle_rsc_RLAST,
      twiddle_rsc_RRESP, twiddle_rsc_RDATA, twiddle_rsc_RID, twiddle_rsc_ARREADY,
      twiddle_rsc_ARVALID, twiddle_rsc_ARUSER, twiddle_rsc_ARREGION, twiddle_rsc_ARQOS,
      twiddle_rsc_ARPROT, twiddle_rsc_ARCACHE, twiddle_rsc_ARLOCK, twiddle_rsc_ARBURST,
      twiddle_rsc_ARSIZE, twiddle_rsc_ARLEN, twiddle_rsc_ARADDR, twiddle_rsc_ARID,
      twiddle_rsc_BREADY, twiddle_rsc_BVALID, twiddle_rsc_BUSER, twiddle_rsc_BRESP,
      twiddle_rsc_BID, twiddle_rsc_WREADY, twiddle_rsc_WVALID, twiddle_rsc_WUSER,
      twiddle_rsc_WLAST, twiddle_rsc_WSTRB, twiddle_rsc_WDATA, twiddle_rsc_AWREADY,
      twiddle_rsc_AWVALID, twiddle_rsc_AWUSER, twiddle_rsc_AWREGION, twiddle_rsc_AWQOS,
      twiddle_rsc_AWPROT, twiddle_rsc_AWCACHE, twiddle_rsc_AWLOCK, twiddle_rsc_AWBURST,
      twiddle_rsc_AWSIZE, twiddle_rsc_AWLEN, twiddle_rsc_AWADDR, twiddle_rsc_AWID,
      twiddle_rsc_triosy_lz, twiddle_h_rsc_s_tdone, twiddle_h_rsc_tr_write_done,
      twiddle_h_rsc_RREADY, twiddle_h_rsc_RVALID, twiddle_h_rsc_RUSER, twiddle_h_rsc_RLAST,
      twiddle_h_rsc_RRESP, twiddle_h_rsc_RDATA, twiddle_h_rsc_RID, twiddle_h_rsc_ARREADY,
      twiddle_h_rsc_ARVALID, twiddle_h_rsc_ARUSER, twiddle_h_rsc_ARREGION, twiddle_h_rsc_ARQOS,
      twiddle_h_rsc_ARPROT, twiddle_h_rsc_ARCACHE, twiddle_h_rsc_ARLOCK, twiddle_h_rsc_ARBURST,
      twiddle_h_rsc_ARSIZE, twiddle_h_rsc_ARLEN, twiddle_h_rsc_ARADDR, twiddle_h_rsc_ARID,
      twiddle_h_rsc_BREADY, twiddle_h_rsc_BVALID, twiddle_h_rsc_BUSER, twiddle_h_rsc_BRESP,
      twiddle_h_rsc_BID, twiddle_h_rsc_WREADY, twiddle_h_rsc_WVALID, twiddle_h_rsc_WUSER,
      twiddle_h_rsc_WLAST, twiddle_h_rsc_WSTRB, twiddle_h_rsc_WDATA, twiddle_h_rsc_AWREADY,
      twiddle_h_rsc_AWVALID, twiddle_h_rsc_AWUSER, twiddle_h_rsc_AWREGION, twiddle_h_rsc_AWQOS,
      twiddle_h_rsc_AWPROT, twiddle_h_rsc_AWCACHE, twiddle_h_rsc_AWLOCK, twiddle_h_rsc_AWBURST,
      twiddle_h_rsc_AWSIZE, twiddle_h_rsc_AWLEN, twiddle_h_rsc_AWADDR, twiddle_h_rsc_AWID,
      twiddle_h_rsc_triosy_lz, revArr_rsc_s_tdone, revArr_rsc_tr_write_done, revArr_rsc_RREADY,
      revArr_rsc_RVALID, revArr_rsc_RUSER, revArr_rsc_RLAST, revArr_rsc_RRESP, revArr_rsc_RDATA,
      revArr_rsc_RID, revArr_rsc_ARREADY, revArr_rsc_ARVALID, revArr_rsc_ARUSER,
      revArr_rsc_ARREGION, revArr_rsc_ARQOS, revArr_rsc_ARPROT, revArr_rsc_ARCACHE,
      revArr_rsc_ARLOCK, revArr_rsc_ARBURST, revArr_rsc_ARSIZE, revArr_rsc_ARLEN,
      revArr_rsc_ARADDR, revArr_rsc_ARID, revArr_rsc_BREADY, revArr_rsc_BVALID, revArr_rsc_BUSER,
      revArr_rsc_BRESP, revArr_rsc_BID, revArr_rsc_WREADY, revArr_rsc_WVALID, revArr_rsc_WUSER,
      revArr_rsc_WLAST, revArr_rsc_WSTRB, revArr_rsc_WDATA, revArr_rsc_AWREADY, revArr_rsc_AWVALID,
      revArr_rsc_AWUSER, revArr_rsc_AWREGION, revArr_rsc_AWQOS, revArr_rsc_AWPROT,
      revArr_rsc_AWCACHE, revArr_rsc_AWLOCK, revArr_rsc_AWBURST, revArr_rsc_AWSIZE,
      revArr_rsc_AWLEN, revArr_rsc_AWADDR, revArr_rsc_AWID, revArr_rsc_triosy_lz,
      tw_rsc_s_tdone, tw_rsc_tr_write_done, tw_rsc_RREADY, tw_rsc_RVALID, tw_rsc_RUSER,
      tw_rsc_RLAST, tw_rsc_RRESP, tw_rsc_RDATA, tw_rsc_RID, tw_rsc_ARREADY, tw_rsc_ARVALID,
      tw_rsc_ARUSER, tw_rsc_ARREGION, tw_rsc_ARQOS, tw_rsc_ARPROT, tw_rsc_ARCACHE,
      tw_rsc_ARLOCK, tw_rsc_ARBURST, tw_rsc_ARSIZE, tw_rsc_ARLEN, tw_rsc_ARADDR,
      tw_rsc_ARID, tw_rsc_BREADY, tw_rsc_BVALID, tw_rsc_BUSER, tw_rsc_BRESP, tw_rsc_BID,
      tw_rsc_WREADY, tw_rsc_WVALID, tw_rsc_WUSER, tw_rsc_WLAST, tw_rsc_WSTRB, tw_rsc_WDATA,
      tw_rsc_AWREADY, tw_rsc_AWVALID, tw_rsc_AWUSER, tw_rsc_AWREGION, tw_rsc_AWQOS,
      tw_rsc_AWPROT, tw_rsc_AWCACHE, tw_rsc_AWLOCK, tw_rsc_AWBURST, tw_rsc_AWSIZE,
      tw_rsc_AWLEN, tw_rsc_AWADDR, tw_rsc_AWID, tw_rsc_triosy_lz, tw_h_rsc_s_tdone,
      tw_h_rsc_tr_write_done, tw_h_rsc_RREADY, tw_h_rsc_RVALID, tw_h_rsc_RUSER, tw_h_rsc_RLAST,
      tw_h_rsc_RRESP, tw_h_rsc_RDATA, tw_h_rsc_RID, tw_h_rsc_ARREADY, tw_h_rsc_ARVALID,
      tw_h_rsc_ARUSER, tw_h_rsc_ARREGION, tw_h_rsc_ARQOS, tw_h_rsc_ARPROT, tw_h_rsc_ARCACHE,
      tw_h_rsc_ARLOCK, tw_h_rsc_ARBURST, tw_h_rsc_ARSIZE, tw_h_rsc_ARLEN, tw_h_rsc_ARADDR,
      tw_h_rsc_ARID, tw_h_rsc_BREADY, tw_h_rsc_BVALID, tw_h_rsc_BUSER, tw_h_rsc_BRESP,
      tw_h_rsc_BID, tw_h_rsc_WREADY, tw_h_rsc_WVALID, tw_h_rsc_WUSER, tw_h_rsc_WLAST,
      tw_h_rsc_WSTRB, tw_h_rsc_WDATA, tw_h_rsc_AWREADY, tw_h_rsc_AWVALID, tw_h_rsc_AWUSER,
      tw_h_rsc_AWREGION, tw_h_rsc_AWQOS, tw_h_rsc_AWPROT, tw_h_rsc_AWCACHE, tw_h_rsc_AWLOCK,
      tw_h_rsc_AWBURST, tw_h_rsc_AWSIZE, tw_h_rsc_AWLEN, tw_h_rsc_AWADDR, tw_h_rsc_AWID,
      tw_h_rsc_triosy_lz, xx_rsci_clken_d, xx_rsci_d_d, xx_rsci_q_d, xx_rsci_radr_d,
      xx_rsci_wadr_d, xx_rsci_readA_r_ram_ir_internal_RMASK_B_d, yy_rsci_clken_d,
      yy_rsci_d_d, yy_rsci_q_d, yy_rsci_radr_d, yy_rsci_wadr_d, yy_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      S34_OUTER_LOOP_for_tf_mul_cmp_a, S34_OUTER_LOOP_for_tf_mul_cmp_b, S34_OUTER_LOOP_for_tf_mul_cmp_z,
      xx_rsci_we_d_pff, yy_rsci_we_d_pff
);
  input clk;
  input rst;
  input x_rsc_s_tdone;
  input x_rsc_tr_write_done;
  input x_rsc_RREADY;
  output x_rsc_RVALID;
  output x_rsc_RUSER;
  output x_rsc_RLAST;
  output [1:0] x_rsc_RRESP;
  output [31:0] x_rsc_RDATA;
  output x_rsc_RID;
  output x_rsc_ARREADY;
  input x_rsc_ARVALID;
  input x_rsc_ARUSER;
  input [3:0] x_rsc_ARREGION;
  input [3:0] x_rsc_ARQOS;
  input [2:0] x_rsc_ARPROT;
  input [3:0] x_rsc_ARCACHE;
  input x_rsc_ARLOCK;
  input [1:0] x_rsc_ARBURST;
  input [2:0] x_rsc_ARSIZE;
  input [7:0] x_rsc_ARLEN;
  input [11:0] x_rsc_ARADDR;
  input x_rsc_ARID;
  input x_rsc_BREADY;
  output x_rsc_BVALID;
  output x_rsc_BUSER;
  output [1:0] x_rsc_BRESP;
  output x_rsc_BID;
  output x_rsc_WREADY;
  input x_rsc_WVALID;
  input x_rsc_WUSER;
  input x_rsc_WLAST;
  input [3:0] x_rsc_WSTRB;
  input [31:0] x_rsc_WDATA;
  output x_rsc_AWREADY;
  input x_rsc_AWVALID;
  input x_rsc_AWUSER;
  input [3:0] x_rsc_AWREGION;
  input [3:0] x_rsc_AWQOS;
  input [2:0] x_rsc_AWPROT;
  input [3:0] x_rsc_AWCACHE;
  input x_rsc_AWLOCK;
  input [1:0] x_rsc_AWBURST;
  input [2:0] x_rsc_AWSIZE;
  input [7:0] x_rsc_AWLEN;
  input [11:0] x_rsc_AWADDR;
  input x_rsc_AWID;
  output x_rsc_triosy_lz;
  input [31:0] m_rsc_dat;
  output m_rsc_triosy_lz;
  input twiddle_rsc_s_tdone;
  input twiddle_rsc_tr_write_done;
  input twiddle_rsc_RREADY;
  output twiddle_rsc_RVALID;
  output twiddle_rsc_RUSER;
  output twiddle_rsc_RLAST;
  output [1:0] twiddle_rsc_RRESP;
  output [31:0] twiddle_rsc_RDATA;
  output twiddle_rsc_RID;
  output twiddle_rsc_ARREADY;
  input twiddle_rsc_ARVALID;
  input twiddle_rsc_ARUSER;
  input [3:0] twiddle_rsc_ARREGION;
  input [3:0] twiddle_rsc_ARQOS;
  input [2:0] twiddle_rsc_ARPROT;
  input [3:0] twiddle_rsc_ARCACHE;
  input twiddle_rsc_ARLOCK;
  input [1:0] twiddle_rsc_ARBURST;
  input [2:0] twiddle_rsc_ARSIZE;
  input [7:0] twiddle_rsc_ARLEN;
  input [11:0] twiddle_rsc_ARADDR;
  input twiddle_rsc_ARID;
  input twiddle_rsc_BREADY;
  output twiddle_rsc_BVALID;
  output twiddle_rsc_BUSER;
  output [1:0] twiddle_rsc_BRESP;
  output twiddle_rsc_BID;
  output twiddle_rsc_WREADY;
  input twiddle_rsc_WVALID;
  input twiddle_rsc_WUSER;
  input twiddle_rsc_WLAST;
  input [3:0] twiddle_rsc_WSTRB;
  input [31:0] twiddle_rsc_WDATA;
  output twiddle_rsc_AWREADY;
  input twiddle_rsc_AWVALID;
  input twiddle_rsc_AWUSER;
  input [3:0] twiddle_rsc_AWREGION;
  input [3:0] twiddle_rsc_AWQOS;
  input [2:0] twiddle_rsc_AWPROT;
  input [3:0] twiddle_rsc_AWCACHE;
  input twiddle_rsc_AWLOCK;
  input [1:0] twiddle_rsc_AWBURST;
  input [2:0] twiddle_rsc_AWSIZE;
  input [7:0] twiddle_rsc_AWLEN;
  input [11:0] twiddle_rsc_AWADDR;
  input twiddle_rsc_AWID;
  output twiddle_rsc_triosy_lz;
  input twiddle_h_rsc_s_tdone;
  input twiddle_h_rsc_tr_write_done;
  input twiddle_h_rsc_RREADY;
  output twiddle_h_rsc_RVALID;
  output twiddle_h_rsc_RUSER;
  output twiddle_h_rsc_RLAST;
  output [1:0] twiddle_h_rsc_RRESP;
  output [31:0] twiddle_h_rsc_RDATA;
  output twiddle_h_rsc_RID;
  output twiddle_h_rsc_ARREADY;
  input twiddle_h_rsc_ARVALID;
  input twiddle_h_rsc_ARUSER;
  input [3:0] twiddle_h_rsc_ARREGION;
  input [3:0] twiddle_h_rsc_ARQOS;
  input [2:0] twiddle_h_rsc_ARPROT;
  input [3:0] twiddle_h_rsc_ARCACHE;
  input twiddle_h_rsc_ARLOCK;
  input [1:0] twiddle_h_rsc_ARBURST;
  input [2:0] twiddle_h_rsc_ARSIZE;
  input [7:0] twiddle_h_rsc_ARLEN;
  input [11:0] twiddle_h_rsc_ARADDR;
  input twiddle_h_rsc_ARID;
  input twiddle_h_rsc_BREADY;
  output twiddle_h_rsc_BVALID;
  output twiddle_h_rsc_BUSER;
  output [1:0] twiddle_h_rsc_BRESP;
  output twiddle_h_rsc_BID;
  output twiddle_h_rsc_WREADY;
  input twiddle_h_rsc_WVALID;
  input twiddle_h_rsc_WUSER;
  input twiddle_h_rsc_WLAST;
  input [3:0] twiddle_h_rsc_WSTRB;
  input [31:0] twiddle_h_rsc_WDATA;
  output twiddle_h_rsc_AWREADY;
  input twiddle_h_rsc_AWVALID;
  input twiddle_h_rsc_AWUSER;
  input [3:0] twiddle_h_rsc_AWREGION;
  input [3:0] twiddle_h_rsc_AWQOS;
  input [2:0] twiddle_h_rsc_AWPROT;
  input [3:0] twiddle_h_rsc_AWCACHE;
  input twiddle_h_rsc_AWLOCK;
  input [1:0] twiddle_h_rsc_AWBURST;
  input [2:0] twiddle_h_rsc_AWSIZE;
  input [7:0] twiddle_h_rsc_AWLEN;
  input [11:0] twiddle_h_rsc_AWADDR;
  input twiddle_h_rsc_AWID;
  output twiddle_h_rsc_triosy_lz;
  input revArr_rsc_s_tdone;
  input revArr_rsc_tr_write_done;
  input revArr_rsc_RREADY;
  output revArr_rsc_RVALID;
  output revArr_rsc_RUSER;
  output revArr_rsc_RLAST;
  output [1:0] revArr_rsc_RRESP;
  output [31:0] revArr_rsc_RDATA;
  output revArr_rsc_RID;
  output revArr_rsc_ARREADY;
  input revArr_rsc_ARVALID;
  input revArr_rsc_ARUSER;
  input [3:0] revArr_rsc_ARREGION;
  input [3:0] revArr_rsc_ARQOS;
  input [2:0] revArr_rsc_ARPROT;
  input [3:0] revArr_rsc_ARCACHE;
  input revArr_rsc_ARLOCK;
  input [1:0] revArr_rsc_ARBURST;
  input [2:0] revArr_rsc_ARSIZE;
  input [7:0] revArr_rsc_ARLEN;
  input [11:0] revArr_rsc_ARADDR;
  input revArr_rsc_ARID;
  input revArr_rsc_BREADY;
  output revArr_rsc_BVALID;
  output revArr_rsc_BUSER;
  output [1:0] revArr_rsc_BRESP;
  output revArr_rsc_BID;
  output revArr_rsc_WREADY;
  input revArr_rsc_WVALID;
  input revArr_rsc_WUSER;
  input revArr_rsc_WLAST;
  input [3:0] revArr_rsc_WSTRB;
  input [31:0] revArr_rsc_WDATA;
  output revArr_rsc_AWREADY;
  input revArr_rsc_AWVALID;
  input revArr_rsc_AWUSER;
  input [3:0] revArr_rsc_AWREGION;
  input [3:0] revArr_rsc_AWQOS;
  input [2:0] revArr_rsc_AWPROT;
  input [3:0] revArr_rsc_AWCACHE;
  input revArr_rsc_AWLOCK;
  input [1:0] revArr_rsc_AWBURST;
  input [2:0] revArr_rsc_AWSIZE;
  input [7:0] revArr_rsc_AWLEN;
  input [11:0] revArr_rsc_AWADDR;
  input revArr_rsc_AWID;
  output revArr_rsc_triosy_lz;
  input tw_rsc_s_tdone;
  input tw_rsc_tr_write_done;
  input tw_rsc_RREADY;
  output tw_rsc_RVALID;
  output tw_rsc_RUSER;
  output tw_rsc_RLAST;
  output [1:0] tw_rsc_RRESP;
  output [31:0] tw_rsc_RDATA;
  output tw_rsc_RID;
  output tw_rsc_ARREADY;
  input tw_rsc_ARVALID;
  input tw_rsc_ARUSER;
  input [3:0] tw_rsc_ARREGION;
  input [3:0] tw_rsc_ARQOS;
  input [2:0] tw_rsc_ARPROT;
  input [3:0] tw_rsc_ARCACHE;
  input tw_rsc_ARLOCK;
  input [1:0] tw_rsc_ARBURST;
  input [2:0] tw_rsc_ARSIZE;
  input [7:0] tw_rsc_ARLEN;
  input [11:0] tw_rsc_ARADDR;
  input tw_rsc_ARID;
  input tw_rsc_BREADY;
  output tw_rsc_BVALID;
  output tw_rsc_BUSER;
  output [1:0] tw_rsc_BRESP;
  output tw_rsc_BID;
  output tw_rsc_WREADY;
  input tw_rsc_WVALID;
  input tw_rsc_WUSER;
  input tw_rsc_WLAST;
  input [3:0] tw_rsc_WSTRB;
  input [31:0] tw_rsc_WDATA;
  output tw_rsc_AWREADY;
  input tw_rsc_AWVALID;
  input tw_rsc_AWUSER;
  input [3:0] tw_rsc_AWREGION;
  input [3:0] tw_rsc_AWQOS;
  input [2:0] tw_rsc_AWPROT;
  input [3:0] tw_rsc_AWCACHE;
  input tw_rsc_AWLOCK;
  input [1:0] tw_rsc_AWBURST;
  input [2:0] tw_rsc_AWSIZE;
  input [7:0] tw_rsc_AWLEN;
  input [11:0] tw_rsc_AWADDR;
  input tw_rsc_AWID;
  output tw_rsc_triosy_lz;
  input tw_h_rsc_s_tdone;
  input tw_h_rsc_tr_write_done;
  input tw_h_rsc_RREADY;
  output tw_h_rsc_RVALID;
  output tw_h_rsc_RUSER;
  output tw_h_rsc_RLAST;
  output [1:0] tw_h_rsc_RRESP;
  output [31:0] tw_h_rsc_RDATA;
  output tw_h_rsc_RID;
  output tw_h_rsc_ARREADY;
  input tw_h_rsc_ARVALID;
  input tw_h_rsc_ARUSER;
  input [3:0] tw_h_rsc_ARREGION;
  input [3:0] tw_h_rsc_ARQOS;
  input [2:0] tw_h_rsc_ARPROT;
  input [3:0] tw_h_rsc_ARCACHE;
  input tw_h_rsc_ARLOCK;
  input [1:0] tw_h_rsc_ARBURST;
  input [2:0] tw_h_rsc_ARSIZE;
  input [7:0] tw_h_rsc_ARLEN;
  input [11:0] tw_h_rsc_ARADDR;
  input tw_h_rsc_ARID;
  input tw_h_rsc_BREADY;
  output tw_h_rsc_BVALID;
  output tw_h_rsc_BUSER;
  output [1:0] tw_h_rsc_BRESP;
  output tw_h_rsc_BID;
  output tw_h_rsc_WREADY;
  input tw_h_rsc_WVALID;
  input tw_h_rsc_WUSER;
  input tw_h_rsc_WLAST;
  input [3:0] tw_h_rsc_WSTRB;
  input [31:0] tw_h_rsc_WDATA;
  output tw_h_rsc_AWREADY;
  input tw_h_rsc_AWVALID;
  input tw_h_rsc_AWUSER;
  input [3:0] tw_h_rsc_AWREGION;
  input [3:0] tw_h_rsc_AWQOS;
  input [2:0] tw_h_rsc_AWPROT;
  input [3:0] tw_h_rsc_AWCACHE;
  input tw_h_rsc_AWLOCK;
  input [1:0] tw_h_rsc_AWBURST;
  input [2:0] tw_h_rsc_AWSIZE;
  input [7:0] tw_h_rsc_AWLEN;
  input [11:0] tw_h_rsc_AWADDR;
  input tw_h_rsc_AWID;
  output tw_h_rsc_triosy_lz;
  output xx_rsci_clken_d;
  output [31:0] xx_rsci_d_d;
  input [31:0] xx_rsci_q_d;
  output [9:0] xx_rsci_radr_d;
  output [9:0] xx_rsci_wadr_d;
  output xx_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output yy_rsci_clken_d;
  output [31:0] yy_rsci_d_d;
  input [31:0] yy_rsci_q_d;
  output [9:0] yy_rsci_radr_d;
  output [9:0] yy_rsci_wadr_d;
  output yy_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output [4:0] S34_OUTER_LOOP_for_tf_mul_cmp_a;
  reg [4:0] S34_OUTER_LOOP_for_tf_mul_cmp_a;
  output [9:0] S34_OUTER_LOOP_for_tf_mul_cmp_b;
  input [9:0] S34_OUTER_LOOP_for_tf_mul_cmp_z;
  output xx_rsci_we_d_pff;
  output yy_rsci_we_d_pff;


  // Interconnect Declarations
  wire core_wen;
  wire core_wten;
  wire x_rsci_wen_comp;
  wire x_rsci_wen_comp_1;
  wire [31:0] x_rsci_s_din_mxwt;
  reg [31:0] x_rsci_s_dout_core;
  wire [31:0] m_rsci_idat;
  wire twiddle_rsci_wen_comp;
  wire [31:0] twiddle_rsci_s_din_mxwt;
  wire twiddle_h_rsci_wen_comp;
  wire [31:0] twiddle_h_rsci_s_din_mxwt;
  wire revArr_rsci_wen_comp;
  reg [4:0] revArr_rsci_s_raddr_core;
  wire [9:0] revArr_rsci_s_din_mxwt;
  wire tw_rsci_wen_comp;
  wire [19:0] tw_rsci_s_din_mxwt;
  wire tw_h_rsci_wen_comp;
  wire [19:0] tw_h_rsci_s_din_mxwt;
  wire mult_12_z_mul_cmp_en;
  wire [31:0] mult_12_z_mul_cmp_z;
  wire [9:0] S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg;
  wire mult_z_mul_cmp_en;
  wire [51:0] mult_z_mul_cmp_z;
  reg [4:0] x_rsci_s_raddr_core_9_5;
  reg [4:0] x_rsci_s_raddr_core_4_0;
  reg [4:0] x_rsci_s_waddr_core_9_5;
  reg [4:0] x_rsci_s_waddr_core_4_0;
  reg [4:0] S34_OUTER_LOOP_for_k_slc_S34_OUTER_LOOP_for_k_sva_19_5_4_0_1;
  reg [4:0] S34_OUTER_LOOP_for_k_sva_4_0;
  wire [7:0] fsm_output;
  wire or_tmp_2;
  wire mux_tmp_1;
  wire xor_dcpl;
  wire nand_tmp_2;
  wire mux_tmp_10;
  wire nor_tmp_16;
  wire or_tmp_40;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_33;
  wire and_dcpl_36;
  wire and_dcpl_39;
  wire and_dcpl_40;
  wire and_dcpl_42;
  wire and_dcpl_43;
  wire and_dcpl_44;
  wire and_dcpl_45;
  wire and_dcpl_47;
  wire and_dcpl_48;
  wire and_dcpl_50;
  wire xor_dcpl_2;
  wire or_tmp_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_59;
  wire and_dcpl_61;
  wire and_dcpl_63;
  wire and_dcpl_65;
  wire and_dcpl_66;
  wire and_dcpl_67;
  wire and_dcpl_68;
  wire and_dcpl_70;
  wire or_dcpl_12;
  wire and_dcpl_76;
  wire or_tmp_58;
  wire and_dcpl_80;
  wire or_tmp_59;
  wire and_dcpl_88;
  wire and_dcpl_89;
  wire and_dcpl_90;
  wire and_dcpl_91;
  wire and_dcpl_92;
  wire and_dcpl_93;
  wire and_dcpl_94;
  wire and_dcpl_95;
  wire or_tmp_79;
  wire and_dcpl_97;
  wire not_tmp_72;
  wire and_dcpl_99;
  wire and_dcpl_100;
  wire and_dcpl_101;
  wire and_dcpl_102;
  wire and_dcpl_103;
  wire and_dcpl_104;
  wire and_dcpl_105;
  wire and_dcpl_106;
  wire and_dcpl_107;
  wire and_dcpl_108;
  wire and_dcpl_111;
  wire and_dcpl_112;
  wire and_dcpl_113;
  wire and_dcpl_114;
  wire and_dcpl_116;
  wire or_tmp_90;
  wire or_tmp_97;
  wire or_tmp_99;
  wire or_tmp_102;
  wire or_tmp_104;
  wire mux_tmp_99;
  wire or_tmp_110;
  wire or_tmp_112;
  wire or_tmp_114;
  wire or_tmp_117;
  wire and_dcpl_126;
  wire and_dcpl_129;
  wire and_dcpl_131;
  wire or_tmp_118;
  wire mux_tmp_107;
  wire or_tmp_121;
  wire or_tmp_145;
  wire or_tmp_152;
  wire mux_tmp_133;
  wire mux_tmp_134;
  wire mux_tmp_139;
  wire or_tmp_162;
  wire or_tmp_163;
  wire mux_tmp_148;
  wire and_dcpl_141;
  wire and_dcpl_142;
  wire and_dcpl_143;
  wire and_dcpl_144;
  wire not_tmp_111;
  wire and_dcpl_147;
  wire and_dcpl_148;
  wire and_dcpl_149;
  wire and_dcpl_152;
  wire and_dcpl_153;
  wire and_dcpl_154;
  wire and_dcpl_160;
  wire and_dcpl_162;
  wire and_dcpl_164;
  wire and_dcpl_165;
  wire and_dcpl_166;
  wire or_tmp_215;
  wire nor_tmp_34;
  wire or_tmp_227;
  wire mux_tmp_197;
  wire mux_tmp_200;
  wire and_dcpl_177;
  wire and_dcpl_179;
  wire and_dcpl_180;
  wire and_dcpl_181;
  wire and_dcpl_188;
  wire and_dcpl_189;
  wire nor_tmp_37;
  wire mux_tmp_206;
  wire nor_tmp_38;
  wire mux_tmp_210;
  wire mux_tmp_212;
  wire or_tmp_237;
  wire or_tmp_247;
  wire or_tmp_250;
  wire or_tmp_258;
  wire or_tmp_263;
  wire or_tmp_284;
  wire not_tmp_152;
  wire or_tmp_352;
  wire mux_tmp_314;
  wire or_tmp_372;
  wire or_tmp_384;
  wire or_dcpl_17;
  wire and_dcpl_204;
  wire or_tmp_406;
  wire and_dcpl_209;
  wire or_dcpl_22;
  wire or_tmp_462;
  wire or_tmp_539;
  wire or_tmp_540;
  wire or_tmp_541;
  wire or_tmp_570;
  wire and_dcpl_224;
  wire or_tmp_651;
  wire or_tmp_669;
  wire mux_tmp_578;
  wire and_dcpl_239;
  wire and_dcpl_250;
  wire and_dcpl_251;
  wire and_dcpl_258;
  wire and_dcpl_259;
  wire and_dcpl_270;
  wire and_dcpl_271;
  wire and_dcpl_278;
  wire and_dcpl_285;
  wire and_dcpl_286;
  wire and_dcpl_293;
  wire or_dcpl_44;
  wire and_dcpl_300;
  wire and_dcpl_301;
  wire and_dcpl_308;
  wire and_dcpl_315;
  wire and_dcpl_316;
  wire and_dcpl_323;
  wire and_dcpl_330;
  reg operator_20_true_15_slc_operator_20_true_15_acc_14_itm;
  reg operator_20_true_8_slc_operator_20_true_8_acc_14_itm;
  wire [5:0] S1_OUTER_LOOP_k_5_0_sva_2;
  wire [6:0] nl_S1_OUTER_LOOP_k_5_0_sva_2;
  reg operator_20_true_1_slc_operator_20_true_1_acc_14_itm;
  reg S2_OUTER_LOOP_c_1_sva;
  wire [31:0] modulo_add_base_22_sva_mx0w24;
  wire [32:0] nl_modulo_add_base_22_sva_mx0w24;
  wire [31:0] modulo_add_base_21_sva_mx0w23;
  wire [32:0] nl_modulo_add_base_21_sva_mx0w23;
  wire [31:0] modulo_add_base_20_sva_mx0w22;
  wire [32:0] nl_modulo_add_base_20_sva_mx0w22;
  wire [31:0] modulo_add_base_23_sva_mx0w21;
  wire [32:0] nl_modulo_add_base_23_sva_mx0w21;
  wire [31:0] modulo_add_base_18_sva_mx0w20;
  wire [32:0] nl_modulo_add_base_18_sva_mx0w20;
  wire [31:0] modulo_add_base_17_sva_mx0w19;
  wire [32:0] nl_modulo_add_base_17_sva_mx0w19;
  wire [31:0] modulo_add_base_16_sva_mx0w18;
  wire [32:0] nl_modulo_add_base_16_sva_mx0w18;
  wire [31:0] modulo_add_base_19_sva_mx0w17;
  wire [32:0] nl_modulo_add_base_19_sva_mx0w17;
  wire [31:0] modulo_add_base_14_sva_mx0w16;
  wire [32:0] nl_modulo_add_base_14_sva_mx0w16;
  wire [31:0] modulo_add_base_13_sva_mx0w15;
  wire [32:0] nl_modulo_add_base_13_sva_mx0w15;
  wire [31:0] modulo_add_base_12_sva_mx0w14;
  wire [32:0] nl_modulo_add_base_12_sva_mx0w14;
  wire [31:0] modulo_add_base_15_sva_mx0w13;
  wire [32:0] nl_modulo_add_base_15_sva_mx0w13;
  wire [31:0] modulo_add_base_10_sva_mx0w12;
  wire [32:0] nl_modulo_add_base_10_sva_mx0w12;
  wire [31:0] modulo_add_base_9_sva_mx0w11;
  wire [32:0] nl_modulo_add_base_9_sva_mx0w11;
  wire [31:0] modulo_add_base_8_sva_mx0w10;
  wire [32:0] nl_modulo_add_base_8_sva_mx0w10;
  wire [31:0] modulo_add_base_11_sva_mx0w9;
  wire [32:0] nl_modulo_add_base_11_sva_mx0w9;
  wire [31:0] modulo_add_base_6_sva_mx0w8;
  wire [32:0] nl_modulo_add_base_6_sva_mx0w8;
  wire [31:0] modulo_add_base_5_sva_mx0w7;
  wire [32:0] nl_modulo_add_base_5_sva_mx0w7;
  wire [31:0] modulo_add_base_4_sva_mx0w6;
  wire [32:0] nl_modulo_add_base_4_sva_mx0w6;
  wire [31:0] modulo_add_base_7_sva_mx0w5;
  wire [32:0] nl_modulo_add_base_7_sva_mx0w5;
  wire [31:0] modulo_add_base_2_sva_mx0w4;
  wire [32:0] nl_modulo_add_base_2_sva_mx0w4;
  wire [31:0] modulo_add_base_1_sva_mx0w3;
  wire [32:0] nl_modulo_add_base_1_sva_mx0w3;
  wire [31:0] modulo_add_base_sva_mx0w2;
  wire [32:0] nl_modulo_add_base_sva_mx0w2;
  wire [31:0] modulo_add_base_3_sva_mx0w1;
  wire [32:0] nl_modulo_add_base_3_sva_mx0w1;
  reg [31:0] mult_3_res_sva;
  reg [31:0] m_sva;
  reg [4:0] S1_OUTER_LOOP_for_acc_cse_sva;
  reg reg_x_rsci_oswt_cse;
  reg reg_x_rsci_oswt_1_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_twiddle_rsci_s_raddr_core_1_cse;
  reg reg_twiddle_rsci_s_raddr_core_2_cse;
  reg reg_twiddle_rsci_s_raddr_core_0_cse;
  reg reg_twiddle_rsci_s_raddr_core_3_cse;
  reg reg_revArr_rsci_oswt_cse;
  reg reg_tw_rsci_oswt_cse;
  reg [9:0] reg_tw_rsci_s_raddr_core_cse;
  reg reg_xx_rsc_cgo_cse;
  reg reg_yy_rsc_cgo_cse;
  reg reg_x_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_1_cse;
  wire or_165_cse;
  wire or_270_cse;
  wire or_242_cse;
  wire or_350_cse;
  wire or_39_cse;
  wire or_44_cse;
  wire or_819_cse;
  wire nand_121_cse;
  reg [4:0] reg_drf_revArr_ptr_smx_9_0_cse;
  wire and_371_cse;
  wire and_370_cse;
  wire nor_64_cse;
  wire or_301_cse;
  wire nand_119_cse;
  wire nand_130_cse;
  wire or_352_cse;
  wire or_353_cse;
  wire and_372_cse;
  wire nor_285_cse;
  wire and_407_cse;
  wire or_310_cse;
  wire or_718_cse;
  wire or_471_cse;
  wire or_397_cse;
  wire or_115_cse;
  wire or_181_cse;
  wire nand_136_cse;
  wire or_820_cse;
  wire or_253_cse;
  wire nand_108_cse;
  wire and_400_cse;
  wire or_563_cse;
  wire and_19_cse;
  wire nand_102_cse;
  wire nor_254_cse;
  wire nor_284_cse;
  wire or_244_cse;
  wire mux_51_cse;
  wire mux_556_cse;
  wire mux_290_cse;
  wire mux_5_cse;
  wire mux_365_cse;
  wire mux_526_cse;
  wire nand_8_cse;
  wire nand_59_cse;
  wire mux_84_rmff;
  wire and_188_rmff;
  reg [19:0] S34_OUTER_LOOP_for_tf_sva;
  reg [31:0] mult_x_1_sva;
  reg [31:0] mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm;
  reg [31:0] mult_x_15_sva;
  reg [31:0] operator_96_false_10_operator_96_false_10_slc_mult_10_t_mul_51_20_itm;
  reg [31:0] operator_96_false_15_operator_96_false_15_slc_mult_15_t_mul_51_20_itm;
  reg [31:0] butterFly_10_tw_asn_itm;
  reg [31:0] butterFly_10_f1_sva;
  reg [31:0] butterFly_10_tw_h_asn_itm;
  reg [31:0] butterFly_13_tw_h_asn_itm;
  reg [19:0] S34_OUTER_LOOP_for_tf_h_sva;
  wire yy_rsci_wadr_d_mx0c1;
  wire yy_rsci_wadr_d_mx0c0;
  wire yy_rsci_wadr_d_mx0c10;
  wire yy_rsci_wadr_d_mx0c4;
  wire yy_rsci_wadr_d_mx0c5;
  wire yy_rsci_wadr_d_mx0c7;
  wire yy_rsci_wadr_d_mx0c2;
  wire yy_rsci_wadr_d_mx0c3;
  wire yy_rsci_wadr_d_mx0c6;
  wire yy_rsci_wadr_d_mx0c8;
  reg [1:0] S2_INNER_LOOP1_r_4_2_sva_1_0;
  wire yy_rsci_radr_d_mx0c0;
  wire yy_rsci_radr_d_mx0c1;
  wire yy_rsci_radr_d_mx0c2;
  wire yy_rsci_radr_d_mx0c5;
  wire yy_rsci_radr_d_mx0c9;
  wire xx_rsci_wadr_d_mx0c3;
  wire xx_rsci_wadr_d_mx0c4;
  wire xx_rsci_wadr_d_mx0c6;
  wire xx_rsci_wadr_d_mx0c1;
  wire xx_rsci_wadr_d_mx0c2;
  wire xx_rsci_wadr_d_mx0c5;
  wire xx_rsci_wadr_d_mx0c7;
  wire xx_rsci_radr_d_mx0c0;
  wire xx_rsci_radr_d_mx0c10;
  wire xx_rsci_radr_d_mx0c1;
  wire xx_rsci_radr_d_mx0c2;
  wire xx_rsci_radr_d_mx0c3;
  wire xx_rsci_radr_d_mx0c4;
  wire xx_rsci_radr_d_mx0c5;
  wire xx_rsci_radr_d_mx0c6;
  wire xx_rsci_radr_d_mx0c7;
  wire xx_rsci_radr_d_mx0c8;
  reg [31:0] modulo_sub_7_mux_itm;
  reg [31:0] modulo_sub_4_mux_itm;
  reg [31:0] modulo_sub_5_mux_itm;
  reg [31:0] modulo_sub_6_mux_itm;
  reg [31:0] modulo_sub_15_mux_itm;
  reg [31:0] modulo_sub_12_mux_itm;
  reg [31:0] modulo_sub_13_mux_itm;
  reg [31:0] modulo_sub_14_mux_itm;
  reg [31:0] modulo_sub_23_mux_itm;
  reg [31:0] modulo_sub_20_mux_itm;
  reg [31:0] modulo_sub_21_mux_itm;
  reg [31:0] modulo_sub_22_mux_itm;
  reg [31:0] modulo_sub_3_mux_itm;
  reg [31:0] modulo_sub_mux_itm;
  reg [31:0] modulo_sub_1_mux_itm;
  reg [31:0] modulo_sub_2_mux_itm;
  reg [31:0] modulo_sub_11_mux_itm;
  reg [31:0] modulo_sub_8_mux_itm;
  reg [31:0] modulo_sub_9_mux_itm;
  reg [31:0] modulo_sub_10_mux_itm;
  reg [31:0] modulo_sub_19_mux_itm;
  reg [31:0] modulo_sub_16_mux_itm;
  reg [31:0] modulo_sub_17_mux_itm;
  reg [31:0] modulo_sub_18_mux_itm;
  wire mux_163_itm;
  wire mux_222_itm;
  wire mux_94_itm;
  wire mux_96_itm;
  wire mux_98_itm;
  wire mux_100_itm;
  wire mux_110_itm;
  wire mux_112_itm;
  wire mux_114_itm;
  wire mux_173_itm;
  wire [3:0] z_out;
  wire not_tmp_358;
  wire [19:0] z_out_2;
  wire [20:0] nl_z_out_2;
  wire and_dcpl_372;
  wire and_dcpl_639;
  wire and_dcpl_649;
  wire and_dcpl_662;
  wire and_dcpl_665;
  wire and_dcpl_730;
  reg [19:0] S1_OUTER_LOOP_for_p_sva_1;
  reg [31:0] modulo_add_base_1_sva;
  reg [31:0] butterFly_11_f1_sva;
  reg [31:0] butterFly_14_f1_sva;
  reg [31:0] butterFly_15_f1_sva;
  wire butterFly_4_tw_and_cse_2_sva_mx0w2;
  wire S1_OUTER_LOOP_for_p_sva_1_mx0c1;
  wire S1_OUTER_LOOP_for_acc_cse_sva_mx0c0;
  wire S1_OUTER_LOOP_for_acc_cse_sva_mx0c1;
  wire S1_OUTER_LOOP_for_acc_cse_sva_mx0c2;
  wire S1_OUTER_LOOP_for_acc_cse_sva_mx0c3;
  wire butterFly_10_f1_sva_mx0c0;
  wire butterFly_10_f1_sva_mx0c1;
  wire butterFly_10_f1_sva_mx0c2;
  wire butterFly_10_f1_sva_mx0c3;
  wire S2_OUTER_LOOP_c_1_sva_mx0c1;
  wire S2_OUTER_LOOP_c_1_sva_mx0c2;
  wire S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c1;
  wire S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c2;
  wire [1:0] butterFly_tw_and_cse_3_2_sva_1;
  wire [31:0] modulo_add_3_mux_itm_mx0w1;
  wire [32:0] nl_modulo_add_3_mux_itm_mx0w1;
  wire butterFly_10_tw_asn_itm_mx0c0;
  wire butterFly_10_tw_asn_itm_mx0c1;
  wire butterFly_10_tw_asn_itm_mx0c2;
  wire butterFly_13_tw_h_asn_itm_mx0c1;
  wire butterFly_13_tw_h_asn_itm_mx0c2;
  wire butterFly_10_tw_h_asn_itm_mx0c0;
  wire butterFly_10_tw_h_asn_itm_mx0c1;
  wire butterFly_10_tw_h_asn_itm_mx0c2;
  wire butterFly_10_tw_h_asn_itm_mx0c3;
  wire butterFly_10_tw_h_asn_itm_mx0c4;
  wire mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c0;
  wire mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c1;
  wire modulo_add_base_1_sva_mx0c0;
  wire modulo_add_base_1_sva_mx0c1;
  wire modulo_add_base_1_sva_mx0c4;
  wire modulo_add_base_1_sva_mx0c5;
  wire modulo_add_base_1_sva_mx0c8;
  wire modulo_add_base_1_sva_mx0c9;
  wire modulo_add_base_1_sva_mx0c12;
  wire modulo_add_base_1_sva_mx0c13;
  wire modulo_add_base_1_sva_mx0c16;
  wire modulo_add_base_1_sva_mx0c17;
  wire modulo_add_base_1_sva_mx0c20;
  wire modulo_add_base_1_sva_mx0c21;
  wire modulo_add_base_1_sva_mx0c24;
  wire modulo_sub_1_mux_itm_mx0c1;
  wire modulo_sub_2_mux_itm_mx0c1;
  wire modulo_sub_5_mux_itm_mx0c1;
  wire modulo_sub_6_mux_itm_mx0c1;
  wire modulo_sub_9_mux_itm_mx0c1;
  wire modulo_sub_10_mux_itm_mx0c1;
  wire modulo_sub_13_mux_itm_mx0c1;
  wire modulo_sub_14_mux_itm_mx0c1;
  wire modulo_sub_17_mux_itm_mx0c1;
  wire modulo_sub_18_mux_itm_mx0c1;
  wire modulo_sub_21_mux_itm_mx0c1;
  wire modulo_sub_22_mux_itm_mx0c1;
  wire and_428_ssc;
  reg reg_modulo_add_3_slc_32_svs_st_cse;
  reg reg_modulo_add_6_slc_32_svs_st_cse;
  reg reg_modulo_add_5_slc_32_svs_st_cse;
  reg reg_modulo_add_7_slc_32_svs_st_cse;
  reg reg_modulo_add_1_slc_32_svs_st_cse;
  reg reg_modulo_add_slc_32_svs_st_cse;
  reg reg_modulo_add_4_slc_32_svs_st_cse;
  wire nand_143_cse;
  wire nor_154_cse;
  wire nor_140_cse;
  wire nor_158_cse;
  wire nor_144_cse;
  wire or_tmp_789;
  wire mux_tmp_665;
  wire mux_tmp_684;
  wire nand_tmp_104;
  wire nor_tmp_111;
  wire [5:0] S2_COPY_LOOP_for_i_S2_COPY_LOOP_for_i_mux_rgt;
  wire [1:0] butterFly_tw_butterFly_tw_mux_rgt;
  reg S2_COPY_LOOP_for_i_5_0_sva_1_5;
  reg [4:0] S2_COPY_LOOP_for_i_5_0_sva_1_4_0;
  reg butterFly_12_tw_and_cse_3_2_sva_1;
  reg butterFly_12_tw_and_cse_3_2_sva_0;
  reg reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg;
  reg reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg;
  reg [2:0] reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg;
  wire S2_COPY_LOOP_p_or_1_seb;
  wire and_373_cse_1;
  wire mux_28_cse;
  wire or_814_cse;
  wire mux_337_cse;
  wire mux_712_cse;
  wire nand_166_cse;
  wire mux_434_cse;
  wire mux_313_itm;
  wire mux_489_itm;
  wire mux_699_itm;
  wire operator_20_true_1_acc_1_itm_14;
  wire [31:0] acc_5_cse_32_1;
  wire [31:0] acc_9_cse_32_1;
  wire [31:0] acc_7_cse_32_1;
  wire [31:0] acc_6_cse_32_1;
  reg [31:0] reg_mult_3_res_lpi_4_dfm_cse_1;

  wire[0:0] mux_31_nl;
  wire[0:0] mux_30_nl;
  wire[0:0] mux_29_nl;
  wire[0:0] or_30_nl;
  wire[0:0] mux_27_nl;
  wire[0:0] and_405_nl;
  wire[0:0] mux_26_nl;
  wire[0:0] and_402_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] or_60_nl;
  wire[0:0] or_59_nl;
  wire[0:0] or_57_nl;
  wire[0:0] mux_50_nl;
  wire[0:0] or_811_nl;
  wire[0:0] mux_60_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] or_65_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] or_61_nl;
  wire[0:0] butterFly_tw_h_or_2_nl;
  wire[0:0] and_58_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] mux_63_nl;
  wire[0:0] or_809_nl;
  wire[0:0] mux_62_nl;
  wire[0:0] and_87_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] nand_12_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] nor_270_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] nor_271_nl;
  wire[0:0] and_412_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] nor_274_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] nor_275_nl;
  wire[0:0] nor_276_nl;
  wire[0:0] mux_75_nl;
  wire[0:0] mux_74_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] nor_277_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] mux_71_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] nor_278_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] and_413_nl;
  wire[0:0] nor_280_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] nor_281_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] and_414_nl;
  wire[0:0] mux_162_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] mux_160_nl;
  wire[0:0] mux_159_nl;
  wire[0:0] or_187_nl;
  wire[0:0] mux_158_nl;
  wire[0:0] mux_157_nl;
  wire[0:0] mux_156_nl;
  wire[0:0] nor_253_nl;
  wire[0:0] mux_155_nl;
  wire[0:0] mux_154_nl;
  wire[0:0] mux_153_nl;
  wire[0:0] mux_152_nl;
  wire[0:0] or_183_nl;
  wire[0:0] nand_135_nl;
  wire[0:0] mux_151_nl;
  wire[0:0] mux_150_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] mux_146_nl;
  wire[0:0] or_180_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] or_179_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] mux_143_nl;
  wire[0:0] nand_16_nl;
  wire[4:0] S34_OUTER_LOOP_for_tf_mux_1_nl;
  wire[0:0] not_1247_nl;
  wire[4:0] S34_OUTER_LOOP_for_k_mux_nl;
  wire[0:0] not_1487_nl;
  wire[0:0] and_191_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[0:0] mux_219_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] mux_215_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] mux_207_nl;
  wire[0:0] mux_205_nl;
  wire[0:0] or_247_nl;
  wire[0:0] mux_13_nl;
  wire[0:0] mux_311_nl;
  wire[0:0] mux_310_nl;
  wire[0:0] mux_316_nl;
  wire[0:0] or_380_nl;
  wire[0:0] mux_315_nl;
  wire[0:0] or_378_nl;
  wire[0:0] mux_677_nl;
  wire[0:0] mux_676_nl;
  wire[0:0] mux_675_nl;
  wire[0:0] mux_674_nl;
  wire[0:0] mux_673_nl;
  wire[0:0] or_885_nl;
  wire[0:0] mux_672_nl;
  wire[0:0] mux_671_nl;
  wire[0:0] mux_670_nl;
  wire[0:0] mux_669_nl;
  wire[0:0] and_913_nl;
  wire[0:0] mux_668_nl;
  wire[0:0] mux_667_nl;
  wire[0:0] or_884_nl;
  wire[0:0] S2_COPY_LOOP_p_S2_COPY_LOOP_p_mux_nl;
  wire[0:0] mux_697_nl;
  wire[0:0] mux_696_nl;
  wire[0:0] mux_695_nl;
  wire[0:0] mux_694_nl;
  wire[0:0] mux_693_nl;
  wire[0:0] or_890_nl;
  wire[0:0] mux_692_nl;
  wire[0:0] mux_691_nl;
  wire[0:0] mux_690_nl;
  wire[0:0] mux_689_nl;
  wire[0:0] mux_688_nl;
  wire[0:0] mux_687_nl;
  wire[0:0] mux_686_nl;
  wire[0:0] mux_682_nl;
  wire[0:0] mux_681_nl;
  wire[0:0] mux_680_nl;
  wire[0:0] mux_679_nl;
  wire[2:0] S2_COPY_LOOP_p_S2_COPY_LOOP_p_mux_1_nl;
  wire[0:0] S2_COPY_LOOP_p_S2_COPY_LOOP_p_nand_nl;
  wire[0:0] mux_705_nl;
  wire[0:0] mux_704_nl;
  wire[0:0] nor_421_nl;
  wire[0:0] mux_703_nl;
  wire[0:0] mux_702_nl;
  wire[0:0] or_905_nl;
  wire[0:0] or_904_nl;
  wire[0:0] nand_174_nl;
  wire[0:0] mux_701_nl;
  wire[0:0] nor_422_nl;
  wire[0:0] and_933_nl;
  wire[0:0] mux_700_nl;
  wire[0:0] nor_424_nl;
  wire[0:0] nor_425_nl;
  wire[0:0] mux_698_nl;
  wire[0:0] or_893_nl;
  wire[0:0] or_891_nl;
  wire[4:0] S1_OUTER_LOOP_for_p_asn_S2_COPY_LOOP_for_i_5_0_sva_2_4_S1_OUTER_LOOP_k_and_nl;
  wire[4:0] S1_OUTER_LOOP_k_S1_OUTER_LOOP_k_mux_nl;
  wire[0:0] S1_OUTER_LOOP_k_or_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] or_52_nl;
  wire[0:0] mux_39_nl;
  wire[0:0] nor_330_nl;
  wire[0:0] mux_38_nl;
  wire[0:0] mux_37_nl;
  wire[0:0] mux_36_nl;
  wire[0:0] nand_5_nl;
  wire[0:0] or_35_nl;
  wire[0:0] and_418_nl;
  wire[0:0] mux_34_nl;
  wire[0:0] nand_3_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] or_31_nl;
  wire[5:0] S2_INNER_LOOP1_for_acc_nl;
  wire[6:0] nl_S2_INNER_LOOP1_for_acc_nl;
  wire[0:0] nor_308_nl;
  wire[0:0] mux_339_nl;
  wire[0:0] or_390_nl;
  wire[0:0] mux_338_nl;
  wire[0:0] nand_35_nl;
  wire[0:0] or_810_nl;
  wire[0:0] mux_719_nl;
  wire[0:0] mux_718_nl;
  wire[0:0] mux_717_nl;
  wire[0:0] mux_716_nl;
  wire[0:0] mux_715_nl;
  wire[0:0] mux_713_nl;
  wire[0:0] or_933_nl;
  wire[0:0] nand_164_nl;
  wire[0:0] mux_709_nl;
  wire[0:0] mux_708_nl;
  wire[0:0] mux_707_nl;
  wire[0:0] mux_729_nl;
  wire[0:0] mux_728_nl;
  wire[0:0] mux_727_nl;
  wire[0:0] mux_726_nl;
  wire[0:0] nor_415_nl;
  wire[0:0] mux_725_nl;
  wire[0:0] and_925_nl;
  wire[0:0] and_926_nl;
  wire[0:0] and_927_nl;
  wire[0:0] mux_724_nl;
  wire[0:0] nor_416_nl;
  wire[0:0] nor_417_nl;
  wire[0:0] nor_418_nl;
  wire[14:0] S1_OUTER_LOOP_for_p_S1_OUTER_LOOP_for_p_and_nl;
  wire[0:0] and_21_nl;
  wire[0:0] mux_46_nl;
  wire[0:0] nor_nl;
  wire[0:0] nor_426_nl;
  wire[0:0] mux_351_nl;
  wire[0:0] nand_61_nl;
  wire[4:0] S1_OUTER_LOOP_for_mux1h_3_nl;
  wire[4:0] S1_OUTER_LOOP_for_acc_nl;
  wire[5:0] nl_S1_OUTER_LOOP_for_acc_nl;
  wire[4:0] S1_OUTER_LOOP_for_mux_15_nl;
  wire[0:0] and_934_nl;
  wire[4:0] S6_OUTER_LOOP_for_acc_nl;
  wire[5:0] nl_S6_OUTER_LOOP_for_acc_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_nl;
  wire[0:0] S1_OUTER_LOOP_for_not_4_nl;
  wire[1:0] S2_INNER_LOOP1_r_mux_nl;
  wire[0:0] S2_OUTER_LOOP_c_nor_nl;
  wire[0:0] S2_INNER_LOOP1_r_not_nl;
  wire[0:0] mux_415_nl;
  wire[0:0] or_485_nl;
  wire[0:0] mux_426_nl;
  wire[0:0] nor_66_nl;
  wire[0:0] or_502_nl;
  wire[0:0] and_222_nl;
  wire[0:0] mux_733_nl;
  wire[0:0] mux_732_nl;
  wire[0:0] mux_731_nl;
  wire[0:0] nand_173_nl;
  wire[0:0] or_924_nl;
  wire[0:0] or_921_nl;
  wire[0:0] mux_736_nl;
  wire[0:0] mux_735_nl;
  wire[0:0] mux_734_nl;
  wire[0:0] nor_411_nl;
  wire[0:0] nor_412_nl;
  wire[0:0] nor_413_nl;
  wire[0:0] nor_414_nl;
  wire[0:0] mux_483_nl;
  wire[0:0] mux_482_nl;
  wire[0:0] mux_481_nl;
  wire[0:0] mux_480_nl;
  wire[0:0] mux_479_nl;
  wire[0:0] or_561_nl;
  wire[0:0] or_560_nl;
  wire[0:0] nor_327_nl;
  wire[0:0] mux_525_nl;
  wire[0:0] or_618_nl;
  wire[0:0] nor_328_nl;
  wire[0:0] mux_524_nl;
  wire[0:0] nand_79_nl;
  wire[0:0] mux_523_nl;
  wire[0:0] nor_126_nl;
  wire[0:0] nor_127_nl;
  wire[0:0] mux_522_nl;
  wire[0:0] or_613_nl;
  wire[0:0] or_612_nl;
  wire[0:0] mux_521_nl;
  wire[0:0] or_611_nl;
  wire[0:0] mux_520_nl;
  wire[0:0] or_610_nl;
  wire[0:0] mux_587_nl;
  wire[0:0] mux_586_nl;
  wire[0:0] mux_585_nl;
  wire[0:0] or_705_nl;
  wire[0:0] or_703_nl;
  wire[0:0] mux_584_nl;
  wire[0:0] mux_583_nl;
  wire[0:0] or_702_nl;
  wire[0:0] mux_582_nl;
  wire[0:0] or_701_nl;
  wire[0:0] mux_581_nl;
  wire[0:0] nand_90_nl;
  wire[0:0] mux_580_nl;
  wire[0:0] mux_579_nl;
  wire[0:0] or_696_nl;
  wire[0:0] mux_577_nl;
  wire[0:0] or_694_nl;
  wire[0:0] mux_589_nl;
  wire[0:0] mux_588_nl;
  wire[0:0] or_708_nl;
  wire[0:0] or_706_nl;
  wire[0:0] mux_596_nl;
  wire[0:0] mux_595_nl;
  wire[0:0] mux_623_nl;
  wire[0:0] mux_622_nl;
  wire[0:0] or_746_nl;
  wire[0:0] mux_636_nl;
  wire[0:0] mux_635_nl;
  wire[0:0] nor_316_nl;
  wire[0:0] nor_317_nl;
  wire[0:0] mux_634_nl;
  wire[0:0] mux_633_nl;
  wire[0:0] or_661_nl;
  wire[0:0] nand_96_nl;
  wire[0:0] nor_318_nl;
  wire[0:0] mux_632_nl;
  wire[0:0] or_762_nl;
  wire[0:0] mux_631_nl;
  wire[0:0] mux_629_nl;
  wire[0:0] or_757_nl;
  wire[0:0] or_756_nl;
  wire[32:0] acc_2_nl;
  wire[33:0] nl_acc_2_nl;
  wire[31:0] mult_3_res_mux1h_2_nl;
  wire[0:0] mux_737_nl;
  wire[0:0] nor_429_nl;
  wire[0:0] mux_738_nl;
  wire[0:0] and_935_nl;
  wire[0:0] mux_739_nl;
  wire[0:0] and_936_nl;
  wire[0:0] nor_430_nl;
  wire[0:0] nor_431_nl;
  wire[0:0] mux_740_nl;
  wire[0:0] or_934_nl;
  wire[0:0] mux_741_nl;
  wire[0:0] or_935_nl;
  wire[0:0] or_936_nl;
  wire[0:0] mux_742_nl;
  wire[0:0] mux_743_nl;
  wire[0:0] and_937_nl;
  wire[0:0] mux_744_nl;
  wire[0:0] nor_432_nl;
  wire[0:0] nor_433_nl;
  wire[0:0] nor_434_nl;
  wire[0:0] mux_745_nl;
  wire[0:0] mux_746_nl;
  wire[0:0] and_938_nl;
  wire[0:0] nor_435_nl;
  wire[0:0] nor_436_nl;
  wire[0:0] mux_747_nl;
  wire[0:0] nor_437_nl;
  wire[0:0] mux_748_nl;
  wire[0:0] or_937_nl;
  wire[0:0] or_938_nl;
  wire[0:0] mux_749_nl;
  wire[0:0] or_939_nl;
  wire[0:0] or_940_nl;
  wire[0:0] mux_750_nl;
  wire[0:0] nor_438_nl;
  wire[0:0] mux_751_nl;
  wire[0:0] and_939_nl;
  wire[0:0] mux_752_nl;
  wire[0:0] nor_439_nl;
  wire[0:0] nor_440_nl;
  wire[0:0] nor_441_nl;
  wire[0:0] mux_753_nl;
  wire[0:0] and_940_nl;
  wire[0:0] mux_754_nl;
  wire[0:0] nor_443_nl;
  wire[0:0] nor_444_nl;
  wire[0:0] mux_755_nl;
  wire[0:0] or_941_nl;
  wire[0:0] mux_756_nl;
  wire[0:0] nor_445_nl;
  wire[0:0] mux_757_nl;
  wire[0:0] or_942_nl;
  wire[0:0] or_943_nl;
  wire[0:0] mux_758_nl;
  wire[0:0] nor_446_nl;
  wire[0:0] nor_447_nl;
  wire[32:0] acc_3_nl;
  wire[33:0] nl_acc_3_nl;
  wire[33:0] acc_13_nl;
  wire[34:0] nl_acc_13_nl;
  wire[31:0] modulo_sub_3_qif_acc_nl;
  wire[32:0] nl_modulo_sub_3_qif_acc_nl;
  wire[33:0] acc_15_nl;
  wire[34:0] nl_acc_15_nl;
  wire[31:0] modulo_add_3_mux1h_3_nl;
  wire[0:0] and_945_nl;
  wire[0:0] and_946_nl;
  wire[0:0] and_947_nl;
  wire[31:0] modulo_sub_qif_acc_nl;
  wire[32:0] nl_modulo_sub_qif_acc_nl;
  wire[33:0] acc_17_nl;
  wire[34:0] nl_acc_17_nl;
  wire[31:0] modulo_add_mux1h_3_nl;
  wire[0:0] and_948_nl;
  wire[0:0] and_949_nl;
  wire[0:0] and_950_nl;
  wire[0:0] and_951_nl;
  wire[31:0] modulo_sub_1_qif_acc_nl;
  wire[32:0] nl_modulo_sub_1_qif_acc_nl;
  wire[33:0] acc_19_nl;
  wire[34:0] nl_acc_19_nl;
  wire[31:0] modulo_add_1_mux1h_3_nl;
  wire[0:0] and_953_nl;
  wire[31:0] modulo_sub_2_qif_acc_nl;
  wire[32:0] nl_modulo_sub_2_qif_acc_nl;
  wire[31:0] modulo_sub_7_qif_acc_nl;
  wire[32:0] nl_modulo_sub_7_qif_acc_nl;
  wire[33:0] acc_20_nl;
  wire[34:0] nl_acc_20_nl;
  wire[31:0] modulo_add_7_mux1h_3_nl;
  wire[0:0] and_954_nl;
  wire[0:0] and_955_nl;
  wire[0:0] and_956_nl;
  wire[0:0] and_957_nl;
  wire[31:0] modulo_sub_4_qif_acc_nl;
  wire[32:0] nl_modulo_sub_4_qif_acc_nl;
  wire[33:0] acc_14_nl;
  wire[34:0] nl_acc_14_nl;
  wire[31:0] modulo_add_4_mux1h_3_nl;
  wire[0:0] and_941_nl;
  wire[0:0] and_942_nl;
  wire[0:0] and_943_nl;
  wire[0:0] and_944_nl;
  wire[31:0] modulo_sub_5_qif_acc_nl;
  wire[32:0] nl_modulo_sub_5_qif_acc_nl;
  wire[33:0] acc_18_nl;
  wire[34:0] nl_acc_18_nl;
  wire[31:0] modulo_add_5_mux1h_3_nl;
  wire[0:0] and_952_nl;
  wire[31:0] modulo_sub_6_qif_acc_nl;
  wire[32:0] nl_modulo_sub_6_qif_acc_nl;
  wire[33:0] acc_21_nl;
  wire[34:0] nl_acc_21_nl;
  wire[31:0] modulo_add_6_mux1h_3_nl;
  wire[31:0] modulo_sub_11_qif_acc_nl;
  wire[32:0] nl_modulo_sub_11_qif_acc_nl;
  wire[31:0] modulo_sub_8_qif_acc_nl;
  wire[32:0] nl_modulo_sub_8_qif_acc_nl;
  wire[31:0] modulo_sub_9_qif_acc_nl;
  wire[32:0] nl_modulo_sub_9_qif_acc_nl;
  wire[31:0] modulo_sub_10_qif_acc_nl;
  wire[32:0] nl_modulo_sub_10_qif_acc_nl;
  wire[31:0] modulo_sub_15_qif_acc_nl;
  wire[32:0] nl_modulo_sub_15_qif_acc_nl;
  wire[31:0] modulo_sub_12_qif_acc_nl;
  wire[32:0] nl_modulo_sub_12_qif_acc_nl;
  wire[31:0] modulo_sub_13_qif_acc_nl;
  wire[32:0] nl_modulo_sub_13_qif_acc_nl;
  wire[31:0] modulo_sub_14_qif_acc_nl;
  wire[32:0] nl_modulo_sub_14_qif_acc_nl;
  wire[31:0] modulo_sub_19_qif_acc_nl;
  wire[32:0] nl_modulo_sub_19_qif_acc_nl;
  wire[31:0] modulo_sub_16_qif_acc_nl;
  wire[32:0] nl_modulo_sub_16_qif_acc_nl;
  wire[31:0] modulo_sub_17_qif_acc_nl;
  wire[32:0] nl_modulo_sub_17_qif_acc_nl;
  wire[31:0] modulo_sub_18_qif_acc_nl;
  wire[32:0] nl_modulo_sub_18_qif_acc_nl;
  wire[31:0] modulo_sub_23_qif_acc_nl;
  wire[32:0] nl_modulo_sub_23_qif_acc_nl;
  wire[31:0] modulo_sub_20_qif_acc_nl;
  wire[32:0] nl_modulo_sub_20_qif_acc_nl;
  wire[31:0] modulo_sub_21_qif_acc_nl;
  wire[32:0] nl_modulo_sub_21_qif_acc_nl;
  wire[31:0] modulo_sub_22_qif_acc_nl;
  wire[32:0] nl_modulo_sub_22_qif_acc_nl;
  wire[14:0] operator_20_true_1_acc_1_nl;
  wire[15:0] nl_operator_20_true_1_acc_1_nl;
  wire[0:0] mux_61_nl;
  wire[0:0] nor_283_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] or_825_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] or_826_nl;
  wire[0:0] or_827_nl;
  wire[0:0] or_107_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] nand_127_nl;
  wire[0:0] mux_95_nl;
  wire[0:0] or_109_nl;
  wire[0:0] or_108_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] or_112_nl;
  wire[0:0] or_119_nl;
  wire[0:0] or_134_nl;
  wire[0:0] or_137_nl;
  wire[0:0] mux_109_nl;
  wire[0:0] mux_111_nl;
  wire[0:0] or_140_nl;
  wire[0:0] or_139_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] or_143_nl;
  wire[0:0] nand_139_nl;
  wire[0:0] or_172_nl;
  wire[0:0] or_169_nl;
  wire[0:0] mux_138_nl;
  wire[0:0] or_174_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] or_173_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] nor_243_nl;
  wire[0:0] mux_171_nl;
  wire[0:0] nor_244_nl;
  wire[0:0] nor_245_nl;
  wire[0:0] or_205_nl;
  wire[0:0] mux_177_nl;
  wire[0:0] or_212_nl;
  wire[0:0] mux_176_nl;
  wire[0:0] or_210_nl;
  wire[0:0] mux_179_nl;
  wire[0:0] or_215_nl;
  wire[0:0] mux_178_nl;
  wire[0:0] or_213_nl;
  wire[0:0] nand_17_nl;
  wire[0:0] mux_199_nl;
  wire[0:0] nor_36_nl;
  wire[0:0] mux_235_nl;
  wire[0:0] nand_122_nl;
  wire[0:0] or_379_nl;
  wire[0:0] or_804_nl;
  wire[0:0] mux_343_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] or_828_nl;
  wire[0:0] or_829_nl;
  wire[0:0] or_830_nl;
  wire[0:0] mux_104_nl;
  wire[0:0] or_127_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] mux_106_nl;
  wire[0:0] mux_105_nl;
  wire[0:0] or_130_nl;
  wire[0:0] mux_108_nl;
  wire[0:0] mux_116_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] nor_260_nl;
  wire[0:0] nor_261_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] or_823_nl;
  wire[0:0] nand_138_nl;
  wire[0:0] or_824_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] or_154_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] or_152_nl;
  wire[0:0] mux_175_nl;
  wire[0:0] mux_174_nl;
  wire[0:0] nor_240_nl;
  wire[0:0] nor_241_nl;
  wire[0:0] nor_242_nl;
  wire[0:0] mux_180_nl;
  wire[0:0] or_216_nl;
  wire[0:0] mux_182_nl;
  wire[0:0] mux_181_nl;
  wire[0:0] or_831_nl;
  wire[0:0] or_832_nl;
  wire[0:0] or_833_nl;
  wire[0:0] mux_183_nl;
  wire[0:0] nor_234_nl;
  wire[0:0] nor_235_nl;
  wire[0:0] nor_236_nl;
  wire[0:0] nor_231_nl;
  wire[0:0] mux_185_nl;
  wire[0:0] nor_232_nl;
  wire[0:0] nor_233_nl;
  wire[0:0] nor_184_nl;
  wire[0:0] mux_357_nl;
  wire[0:0] mux_356_nl;
  wire[0:0] or_408_nl;
  wire[0:0] nand_38_nl;
  wire[0:0] nand_37_nl;
  wire[0:0] nor_185_nl;
  wire[0:0] mux_354_nl;
  wire[0:0] mux_353_nl;
  wire[0:0] or_404_nl;
  wire[0:0] or_403_nl;
  wire[0:0] mux_364_nl;
  wire[0:0] and_368_nl;
  wire[0:0] mux_372_nl;
  wire[0:0] and_366_nl;
  wire[0:0] mux_371_nl;
  wire[0:0] nand_43_nl;
  wire[0:0] mux_340_nl;
  wire[0:0] nor_179_nl;
  wire[0:0] mux_344_nl;
  wire[0:0] mux_368_nl;
  wire[0:0] nor_180_nl;
  wire[0:0] and_367_nl;
  wire[0:0] mux_367_nl;
  wire[0:0] nand_41_nl;
  wire[0:0] mux_378_nl;
  wire[0:0] nor_333_nl;
  wire[0:0] and_363_nl;
  wire[0:0] mux_377_nl;
  wire[0:0] nor_178_nl;
  wire[0:0] and_364_nl;
  wire[0:0] and_365_nl;
  wire[0:0] nor_175_nl;
  wire[0:0] mux_393_nl;
  wire[0:0] mux_392_nl;
  wire[0:0] nor_176_nl;
  wire[0:0] nor_177_nl;
  wire[0:0] nor_172_nl;
  wire[0:0] mux_398_nl;
  wire[0:0] nor_173_nl;
  wire[0:0] mux_397_nl;
  wire[0:0] or_458_nl;
  wire[0:0] mux_396_nl;
  wire[0:0] or_457_nl;
  wire[0:0] or_456_nl;
  wire[0:0] or_455_nl;
  wire[0:0] nor_174_nl;
  wire[0:0] mux_395_nl;
  wire[0:0] or_453_nl;
  wire[0:0] or_452_nl;
  wire[0:0] nor_170_nl;
  wire[0:0] nor_171_nl;
  wire[0:0] mux_401_nl;
  wire[0:0] or_464_nl;
  wire[0:0] mux_400_nl;
  wire[0:0] mux_419_nl;
  wire[0:0] mux_418_nl;
  wire[0:0] or_489_nl;
  wire[0:0] mux_417_nl;
  wire[0:0] mux_416_nl;
  wire[0:0] or_387_nl;
  wire[0:0] nand_55_nl;
  wire[0:0] nor_331_nl;
  wire[0:0] and_359_nl;
  wire[0:0] mux_422_nl;
  wire[0:0] nor_167_nl;
  wire[0:0] nor_332_nl;
  wire[0:0] mux_439_nl;
  wire[0:0] mux_438_nl;
  wire[0:0] mux_437_nl;
  wire[0:0] nand_65_nl;
  wire[0:0] or_506_nl;
  wire[0:0] nand_64_nl;
  wire[0:0] mux_456_nl;
  wire[0:0] mux_455_nl;
  wire[0:0] mux_454_nl;
  wire[0:0] mux_453_nl;
  wire[0:0] mux_452_nl;
  wire[0:0] nor_152_nl;
  wire[0:0] nor_153_nl;
  wire[0:0] mux_451_nl;
  wire[0:0] nor_155_nl;
  wire[0:0] nor_156_nl;
  wire[0:0] mux_450_nl;
  wire[0:0] or_525_nl;
  wire[0:0] or_524_nl;
  wire[0:0] nor_157_nl;
  wire[0:0] mux_449_nl;
  wire[0:0] mux_448_nl;
  wire[0:0] or_521_nl;
  wire[0:0] or_519_nl;
  wire[0:0] mux_447_nl;
  wire[0:0] or_518_nl;
  wire[0:0] or_516_nl;
  wire[0:0] mux_446_nl;
  wire[0:0] and_356_nl;
  wire[0:0] mux_445_nl;
  wire[0:0] nor_159_nl;
  wire[0:0] mux_444_nl;
  wire[0:0] and_357_nl;
  wire[0:0] mux_443_nl;
  wire[0:0] nor_160_nl;
  wire[0:0] mux_442_nl;
  wire[0:0] mux_441_nl;
  wire[0:0] nor_162_nl;
  wire[0:0] nor_163_nl;
  wire[0:0] mux_440_nl;
  wire[0:0] nor_164_nl;
  wire[0:0] nor_165_nl;
  wire[0:0] mux_473_nl;
  wire[0:0] mux_472_nl;
  wire[0:0] mux_471_nl;
  wire[0:0] mux_470_nl;
  wire[0:0] mux_469_nl;
  wire[0:0] nor_138_nl;
  wire[0:0] nor_139_nl;
  wire[0:0] mux_468_nl;
  wire[0:0] nor_141_nl;
  wire[0:0] nor_142_nl;
  wire[0:0] mux_467_nl;
  wire[0:0] or_551_nl;
  wire[0:0] or_550_nl;
  wire[0:0] nor_143_nl;
  wire[0:0] mux_466_nl;
  wire[0:0] mux_465_nl;
  wire[0:0] or_547_nl;
  wire[0:0] or_545_nl;
  wire[0:0] mux_464_nl;
  wire[0:0] or_544_nl;
  wire[0:0] or_542_nl;
  wire[0:0] mux_463_nl;
  wire[0:0] and_354_nl;
  wire[0:0] mux_462_nl;
  wire[0:0] nor_145_nl;
  wire[0:0] mux_461_nl;
  wire[0:0] and_355_nl;
  wire[0:0] mux_460_nl;
  wire[0:0] nor_146_nl;
  wire[0:0] mux_459_nl;
  wire[0:0] mux_458_nl;
  wire[0:0] nor_148_nl;
  wire[0:0] nor_149_nl;
  wire[0:0] mux_457_nl;
  wire[0:0] nor_150_nl;
  wire[0:0] nor_151_nl;
  wire[0:0] or_574_nl;
  wire[0:0] mux_488_nl;
  wire[0:0] mux_487_nl;
  wire[0:0] or_572_nl;
  wire[0:0] mux_486_nl;
  wire[0:0] or_571_nl;
  wire[0:0] or_570_nl;
  wire[0:0] mux_485_nl;
  wire[0:0] mux_484_nl;
  wire[0:0] or_569_nl;
  wire[0:0] or_568_nl;
  wire[0:0] nor_130_nl;
  wire[0:0] mux_509_nl;
  wire[0:0] nor_131_nl;
  wire[0:0] mux_508_nl;
  wire[0:0] nand_77_nl;
  wire[0:0] mux_507_nl;
  wire[0:0] and_353_nl;
  wire[0:0] mux_506_nl;
  wire[0:0] or_594_nl;
  wire[0:0] mux_530_nl;
  wire[0:0] nor_123_nl;
  wire[0:0] nor_124_nl;
  wire[0:0] mux_590_nl;
  wire[0:0] or_710_nl;
  wire[0:0] or_709_nl;
  wire[0:0] nor_125_nl;
  wire[0:0] mux_528_nl;
  wire[0:0] or_623_nl;
  wire[0:0] or_622_nl;
  wire[0:0] mux_527_nl;
  wire[0:0] or_621_nl;
  wire[0:0] or_620_nl;
  wire[0:0] mux_535_nl;
  wire[0:0] nor_119_nl;
  wire[0:0] and_351_nl;
  wire[0:0] mux_534_nl;
  wire[0:0] nor_120_nl;
  wire[0:0] mux_533_nl;
  wire[0:0] or_634_nl;
  wire[0:0] nor_121_nl;
  wire[0:0] nor_122_nl;
  wire[0:0] mux_532_nl;
  wire[0:0] or_631_nl;
  wire[0:0] mux_541_nl;
  wire[0:0] and_348_nl;
  wire[0:0] mux_540_nl;
  wire[0:0] and_349_nl;
  wire[0:0] mux_539_nl;
  wire[0:0] nor_115_nl;
  wire[0:0] nor_116_nl;
  wire[0:0] mux_538_nl;
  wire[0:0] or_643_nl;
  wire[0:0] or_642_nl;
  wire[0:0] and_350_nl;
  wire[0:0] mux_537_nl;
  wire[0:0] nor_117_nl;
  wire[0:0] mux_546_nl;
  wire[0:0] and_345_nl;
  wire[0:0] mux_545_nl;
  wire[0:0] and_346_nl;
  wire[0:0] mux_544_nl;
  wire[0:0] nor_110_nl;
  wire[0:0] nor_111_nl;
  wire[0:0] mux_543_nl;
  wire[0:0] or_652_nl;
  wire[0:0] or_651_nl;
  wire[0:0] and_347_nl;
  wire[0:0] mux_542_nl;
  wire[0:0] nor_112_nl;
  wire[0:0] mux_563_nl;
  wire[0:0] mux_562_nl;
  wire[0:0] or_672_nl;
  wire[0:0] nor_107_nl;
  wire[0:0] mux_567_nl;
  wire[0:0] nand_88_nl;
  wire[0:0] mux_566_nl;
  wire[0:0] or_679_nl;
  wire[0:0] mux_565_nl;
  wire[0:0] nor_108_nl;
  wire[0:0] mux_564_nl;
  wire[0:0] or_717_nl;
  wire[0:0] nor_101_nl;
  wire[0:0] mux_605_nl;
  wire[0:0] mux_604_nl;
  wire[0:0] mux_603_nl;
  wire[0:0] nand_99_nl;
  wire[0:0] or_731_nl;
  wire[0:0] or_730_nl;
  wire[0:0] or_728_nl;
  wire[0:0] mux_602_nl;
  wire[0:0] nor_102_nl;
  wire[0:0] nor_103_nl;
  wire[0:0] mux_90_nl;
  wire[0:0] nor_268_nl;
  wire[0:0] and_392_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] and_393_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] or_97_nl;
  wire[0:0] or_96_nl;
  wire[0:0] nor_269_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] or_807_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] and_97_nl;
  wire[0:0] and_99_nl;
  wire[0:0] butterFly_10_f1_or_1_nl;
  wire[0:0] and_110_nl;
  wire[0:0] and_111_nl;
  wire[0:0] and_116_nl;
  wire[0:0] and_118_nl;
  wire[4:0] S2_COPY_LOOP_for_mux1h_nl;
  wire[0:0] S2_COPY_LOOP_for_or_7_nl;
  wire[1:0] S2_COPY_LOOP_for_mux1h_9_nl;
  wire[0:0] S2_COPY_LOOP_for_or_8_nl;
  wire[2:0] S2_COPY_LOOP_for_or_5_nl;
  wire[2:0] S2_COPY_LOOP_for_and_2_nl;
  wire[2:0] S2_COPY_LOOP_for_mux1h_10_nl;
  wire[0:0] S2_COPY_LOOP_for_not_nl;
  wire[4:0] S2_COPY_LOOP_for_S2_COPY_LOOP_for_mux_5_nl;
  wire[0:0] S2_COPY_LOOP_for_or_nl;
  wire[0:0] S2_COPY_LOOP_for_mux1h_11_nl;
  wire[1:0] S2_COPY_LOOP_for_mux1h_12_nl;
  wire[0:0] S2_COPY_LOOP_for_or_9_nl;
  wire[1:0] S2_COPY_LOOP_for_or_1_nl;
  wire[1:0] S2_COPY_LOOP_for_and_1_nl;
  wire[1:0] S2_COPY_LOOP_for_mux1h_13_nl;
  wire[0:0] S2_COPY_LOOP_for_or_2_nl;
  wire[0:0] S2_COPY_LOOP_for_or_3_nl;
  wire[0:0] S2_COPY_LOOP_for_nor_1_nl;
  wire[0:0] S2_COPY_LOOP_for_or_4_nl;
  wire[0:0] mux_130_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] or_164_nl;
  wire[0:0] mux_128_nl;
  wire[0:0] or_163_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] or_162_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] or_160_nl;
  wire[0:0] nand_15_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] nor_256_nl;
  wire[0:0] and_389_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] nor_257_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] mux_141_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] or_168_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] mux_131_nl;
  wire[0:0] and_141_nl;
  wire[0:0] mux_165_nl;
  wire[0:0] mux_164_nl;
  wire[0:0] nor_249_nl;
  wire[0:0] nor_250_nl;
  wire[0:0] nor_251_nl;
  wire[0:0] mux_170_nl;
  wire[0:0] mux_169_nl;
  wire[0:0] mux_168_nl;
  wire[0:0] nor_246_nl;
  wire[0:0] and_386_nl;
  wire[0:0] nor_247_nl;
  wire[0:0] mux_167_nl;
  wire[0:0] mux_166_nl;
  wire[0:0] or_196_nl;
  wire[0:0] or_195_nl;
  wire[0:0] or_194_nl;
  wire[0:0] nor_248_nl;
  wire[0:0] and_146_nl;
  wire[0:0] and_147_nl;
  wire[0:0] and_151_nl;
  wire[0:0] and_152_nl;
  wire[0:0] and_156_nl;
  wire[0:0] and_157_nl;
  wire[4:0] S1_OUTER_LOOP_for_mux1h_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_8_nl;
  wire[1:0] S1_OUTER_LOOP_for_mux1h_5_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_10_nl;
  wire[2:0] S1_OUTER_LOOP_for_or_6_nl;
  wire[2:0] S1_OUTER_LOOP_for_and_3_nl;
  wire[2:0] S1_OUTER_LOOP_for_mux1h_6_nl;
  wire[0:0] S1_OUTER_LOOP_for_not_5_nl;
  wire[4:0] S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_mux_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_1_nl;
  wire[0:0] S1_OUTER_LOOP_for_mux1h_7_nl;
  wire[1:0] S1_OUTER_LOOP_for_mux1h_8_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_9_nl;
  wire[1:0] S1_OUTER_LOOP_for_or_2_nl;
  wire[1:0] S1_OUTER_LOOP_for_and_2_nl;
  wire[1:0] S1_OUTER_LOOP_for_mux1h_9_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_3_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_4_nl;
  wire[0:0] S1_OUTER_LOOP_for_nor_1_nl;
  wire[0:0] S1_OUTER_LOOP_for_or_5_nl;
  wire[0:0] mux_194_nl;
  wire[0:0] mux_193_nl;
  wire[0:0] mux_192_nl;
  wire[0:0] nor_226_nl;
  wire[0:0] mux_191_nl;
  wire[0:0] nor_227_nl;
  wire[0:0] nor_228_nl;
  wire[0:0] nor_229_nl;
  wire[0:0] mux_190_nl;
  wire[0:0] mux_189_nl;
  wire[0:0] mux_188_nl;
  wire[0:0] nor_230_nl;
  wire[0:0] nand_142_nl;
  wire[0:0] mux_187_nl;
  wire[0:0] or_231_nl;
  wire[0:0] mux_204_nl;
  wire[0:0] mux_203_nl;
  wire[0:0] mux_202_nl;
  wire[0:0] mux_201_nl;
  wire[0:0] mux_198_nl;
  wire[0:0] mux_196_nl;
  wire[0:0] or_240_nl;
  wire[0:0] nor_372_nl;
  wire[0:0] and_910_nl;
  wire[0:0] mux_640_nl;
  wire[0:0] nor_363_nl;
  wire[0:0] and_911_nl;
  wire[0:0] mux_665_nl;
  wire[0:0] mux_684_nl;
  wire[0:0] nor_419_nl;
  wire[14:0] S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_and_2_nl;
  wire[0:0] not_1650_nl;
  wire[2:0] S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_and_3_nl;
  wire[0:0] not_1651_nl;
  wire[1:0] S1_OUTER_LOOP_for_mux_16_nl;
  wire[32:0] acc_5_nl;
  wire[33:0] nl_acc_5_nl;
  wire[32:0] acc_6_nl;
  wire[33:0] nl_acc_6_nl;
  wire[32:0] acc_7_nl;
  wire[33:0] nl_acc_7_nl;
  wire[32:0] acc_9_nl;
  wire[33:0] nl_acc_9_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [19:0] nl_mult_12_z_mul_cmp_a;
  assign nl_mult_12_z_mul_cmp_a = MUX_v_20_2_2(tw_rsci_s_din_mxwt, S34_OUTER_LOOP_for_tf_sva,
      and_dcpl_188);
  wire [31:0] nl_mult_12_z_mul_cmp_b;
  assign nl_mult_12_z_mul_cmp_b = mult_x_1_sva;
  wire[0:0] nor_290_nl;
  wire[0:0] mux_227_nl;
  wire[0:0] mux_226_nl;
  wire[0:0] mux_225_nl;
  wire[0:0] or_nl;
  wire[0:0] mux_224_nl;
  wire[0:0] or_821_nl;
  wire[0:0] or_822_nl;
  wire[0:0] mux_223_nl;
  wire[0:0] or_255_nl;
  wire[0:0] mux_240_nl;
  wire[0:0] mux_239_nl;
  wire[0:0] or_275_nl;
  wire[0:0] mux_238_nl;
  wire[0:0] or_274_nl;
  wire[0:0] mux_237_nl;
  wire[0:0] mux_236_nl;
  wire[0:0] or_271_nl;
  wire[0:0] mux_234_nl;
  wire[0:0] mux_233_nl;
  wire[0:0] or_268_nl;
  wire[0:0] mux_232_nl;
  wire[0:0] or_267_nl;
  wire[0:0] mux_231_nl;
  wire[0:0] or_266_nl;
  wire[0:0] mux_230_nl;
  wire[0:0] or_806_nl;
  wire[0:0] mux_229_nl;
  wire[0:0] mux_228_nl;
  wire[0:0] mux_245_nl;
  wire[0:0] mux_244_nl;
  wire[0:0] or_284_nl;
  wire[0:0] or_283_nl;
  wire[0:0] mux_243_nl;
  wire[0:0] mux_242_nl;
  wire[0:0] nand_137_nl;
  wire[0:0] mux_241_nl;
  wire[0:0] or_280_nl;
  wire[0:0] or_278_nl;
  wire[0:0] mux_250_nl;
  wire[0:0] and_380_nl;
  wire[0:0] mux_249_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] and_nl;
  wire[0:0] mux_247_nl;
  wire[0:0] nor_214_nl;
  wire[0:0] nor_215_nl;
  wire[0:0] nor_216_nl;
  wire[0:0] mux_246_nl;
  wire[0:0] nor_217_nl;
  wire[0:0] nor_218_nl;
  wire[0:0] mux_259_nl;
  wire[0:0] nand_20_nl;
  wire[0:0] mux_258_nl;
  wire[0:0] nor_211_nl;
  wire[0:0] mux_257_nl;
  wire[0:0] nor_212_nl;
  wire[0:0] mux_256_nl;
  wire[0:0] or_303_nl;
  wire[0:0] mux_255_nl;
  wire[0:0] mux_254_nl;
  wire[0:0] mux_253_nl;
  wire[0:0] mux_252_nl;
  wire[0:0] or_300_nl;
  wire[0:0] or_297_nl;
  wire[0:0] nand_134_nl;
  wire[0:0] mux_251_nl;
  wire[0:0] or_294_nl;
  wire[0:0] or_293_nl;
  wire[0:0] mux_265_nl;
  wire[0:0] mux_264_nl;
  wire[0:0] and_379_nl;
  wire[0:0] mux_263_nl;
  wire[0:0] or_316_nl;
  wire[0:0] mux_262_nl;
  wire[0:0] mux_261_nl;
  wire[0:0] nor_207_nl;
  wire[0:0] nor_208_nl;
  wire[0:0] nor_209_nl;
  wire[0:0] nor_210_nl;
  wire[0:0] mux_260_nl;
  wire[0:0] and_193_nl;
  wire[0:0] mux_270_nl;
  wire[0:0] mux_269_nl;
  wire[0:0] mux_268_nl;
  wire[0:0] nor_203_nl;
  wire[0:0] nor_204_nl;
  wire[0:0] mux_267_nl;
  wire[0:0] nor_205_nl;
  wire[0:0] nor_206_nl;
  wire[0:0] mux_266_nl;
  wire[0:0] or_319_nl;
  wire[0:0] or_318_nl;
  wire[0:0] and_195_nl;
  wire [31:0] nl_mult_z_mul_cmp_a;
  assign or_nl = (~ (fsm_output[3])) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_224_nl = MUX_s_1_2_2(or_819_cse, or_820_cse, fsm_output[3]);
  assign mux_225_nl = MUX_s_1_2_2(or_nl, mux_224_nl, fsm_output[0]);
  assign or_821_nl = (fsm_output[3]) | (fsm_output[1]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_226_nl = MUX_s_1_2_2(mux_225_nl, or_821_nl, fsm_output[4]);
  assign or_255_nl = (fsm_output[1]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_223_nl = MUX_s_1_2_2(or_255_nl, or_253_cse, fsm_output[3]);
  assign or_822_nl = (fsm_output[4]) | (fsm_output[0]) | mux_223_nl;
  assign mux_227_nl = MUX_s_1_2_2(mux_226_nl, or_822_nl, fsm_output[2]);
  assign nor_290_nl = ~(mux_227_nl | (fsm_output[5]));
  assign or_274_nl = (~ (fsm_output[6])) | (fsm_output[5]) | (fsm_output[7]) | (~
      (fsm_output[3]));
  assign mux_238_nl = MUX_s_1_2_2(or_274_nl, or_tmp_258, fsm_output[0]);
  assign or_275_nl = (fsm_output[4]) | mux_238_nl;
  assign or_271_nl = (fsm_output[6]) | (~ (fsm_output[5])) | (~ (fsm_output[7]))
      | (fsm_output[3]);
  assign mux_236_nl = MUX_s_1_2_2(or_tmp_258, or_271_nl, fsm_output[0]);
  assign mux_237_nl = MUX_s_1_2_2(mux_236_nl, or_270_cse, fsm_output[4]);
  assign mux_239_nl = MUX_s_1_2_2(or_275_nl, mux_237_nl, fsm_output[2]);
  assign or_267_nl = (~ (fsm_output[5])) | (~ (fsm_output[7])) | (fsm_output[3]);
  assign mux_232_nl = MUX_s_1_2_2(or_267_nl, or_471_cse, fsm_output[6]);
  assign or_268_nl = (fsm_output[0]) | mux_232_nl;
  assign or_266_nl = (~ (fsm_output[6])) | (~ (fsm_output[5])) | (fsm_output[7])
      | (fsm_output[3]);
  assign mux_230_nl = MUX_s_1_2_2(or_471_cse, or_tmp_250, fsm_output[6]);
  assign mux_231_nl = MUX_s_1_2_2(or_266_nl, mux_230_nl, fsm_output[0]);
  assign mux_233_nl = MUX_s_1_2_2(or_268_nl, mux_231_nl, fsm_output[4]);
  assign mux_228_nl = MUX_s_1_2_2(or_165_cse, or_tmp_247, fsm_output[5]);
  assign mux_229_nl = MUX_s_1_2_2(or_tmp_250, mux_228_nl, fsm_output[6]);
  assign or_806_nl = (fsm_output[4]) | (~ (fsm_output[0])) | mux_229_nl;
  assign mux_234_nl = MUX_s_1_2_2(mux_233_nl, or_806_nl, fsm_output[2]);
  assign mux_240_nl = MUX_s_1_2_2(mux_239_nl, mux_234_nl, fsm_output[1]);
  assign or_284_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (~ (fsm_output[4]))
      | (fsm_output[5]) | (fsm_output[7]) | (fsm_output[6]);
  assign or_283_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4]) | (~ (fsm_output[5]))
      | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_244_nl = MUX_s_1_2_2(or_284_nl, or_283_nl, fsm_output[3]);
  assign nand_137_nl = ~((fsm_output[7:4]==4'b0111));
  assign or_280_nl = (fsm_output[7:4]!=4'b0100);
  assign or_278_nl = (fsm_output[7:4]!=4'b1010);
  assign mux_241_nl = MUX_s_1_2_2(or_280_nl, or_278_nl, fsm_output[0]);
  assign mux_242_nl = MUX_s_1_2_2(nand_137_nl, mux_241_nl, fsm_output[1]);
  assign mux_243_nl = MUX_s_1_2_2(mux_242_nl, or_tmp_263, fsm_output[3]);
  assign mux_245_nl = MUX_s_1_2_2(mux_244_nl, mux_243_nl, fsm_output[2]);
  assign and_nl = (fsm_output[7]) & (fsm_output[1]) & (~ (fsm_output[3])) & (fsm_output[5]);
  assign nor_214_nl = ~((fsm_output[1]) | nand_121_cse);
  assign nor_215_nl = ~((fsm_output[1]) | (~ (fsm_output[3])) | (fsm_output[5]));
  assign mux_247_nl = MUX_s_1_2_2(nor_214_nl, nor_215_nl, fsm_output[7]);
  assign mux_248_nl = MUX_s_1_2_2(and_nl, mux_247_nl, fsm_output[0]);
  assign nor_216_nl = ~((fsm_output[7]) | (fsm_output[1]) | (fsm_output[3]) | (fsm_output[5]));
  assign mux_249_nl = MUX_s_1_2_2(mux_248_nl, nor_216_nl, fsm_output[4]);
  assign and_380_nl = (fsm_output[2]) & mux_249_nl;
  assign nor_217_nl = ~((~ (fsm_output[4])) | (~ (fsm_output[0])) | (fsm_output[7])
      | (~ (fsm_output[1])) | (fsm_output[3]) | (~ (fsm_output[5])));
  assign nor_218_nl = ~((fsm_output[4]) | (~ (fsm_output[0])) | (fsm_output[7]) |
      (fsm_output[1]) | (fsm_output[3]) | (fsm_output[5]));
  assign mux_246_nl = MUX_s_1_2_2(nor_217_nl, nor_218_nl, fsm_output[2]);
  assign mux_250_nl = MUX_s_1_2_2(and_380_nl, mux_246_nl, fsm_output[6]);
  assign mux_257_nl = MUX_s_1_2_2(nand_119_cse, or_tmp_284, fsm_output[1]);
  assign nor_211_nl = ~((~ (fsm_output[5])) | (fsm_output[0]) | mux_257_nl);
  assign or_303_nl = (fsm_output[1]) | (fsm_output[7]) | (~ (fsm_output[2]));
  assign mux_256_nl = MUX_s_1_2_2(or_303_nl, or_301_cse, fsm_output[0]);
  assign nor_212_nl = ~((fsm_output[5]) | mux_256_nl);
  assign mux_258_nl = MUX_s_1_2_2(nor_211_nl, nor_212_nl, fsm_output[6]);
  assign nand_20_nl = ~((fsm_output[3]) & mux_258_nl);
  assign or_300_nl = (~ (fsm_output[1])) | (fsm_output[7]) | (~ (fsm_output[2]));
  assign mux_252_nl = MUX_s_1_2_2(or_300_nl, or_tmp_284, fsm_output[0]);
  assign or_297_nl = (~ (fsm_output[0])) | (fsm_output[7]) | (fsm_output[2]);
  assign mux_253_nl = MUX_s_1_2_2(mux_252_nl, or_297_nl, fsm_output[5]);
  assign nand_134_nl = ~((fsm_output[5]) & (fsm_output[0]) & (fsm_output[1]) & (~
      (fsm_output[7])) & (fsm_output[2]));
  assign mux_254_nl = MUX_s_1_2_2(mux_253_nl, nand_134_nl, fsm_output[6]);
  assign or_294_nl = (fsm_output[5]) | (fsm_output[1]) | (fsm_output[7]) | (fsm_output[2]);
  assign or_293_nl = (~ (fsm_output[5])) | (~ (fsm_output[0])) | (fsm_output[1])
      | (fsm_output[7]) | (fsm_output[2]);
  assign mux_251_nl = MUX_s_1_2_2(or_294_nl, or_293_nl, fsm_output[6]);
  assign mux_255_nl = MUX_s_1_2_2(mux_254_nl, mux_251_nl, fsm_output[3]);
  assign mux_259_nl = MUX_s_1_2_2(nand_20_nl, mux_255_nl, fsm_output[4]);
  assign or_316_nl = (~ (fsm_output[7])) | (~ (fsm_output[0])) | (fsm_output[6]);
  assign mux_263_nl = MUX_s_1_2_2(or_115_cse, or_316_nl, fsm_output[5]);
  assign and_379_nl = (fsm_output[3]) & (~ mux_263_nl);
  assign nor_207_nl = ~((~ (fsm_output[7])) | (fsm_output[0]) | (fsm_output[6]));
  assign nor_208_nl = ~((fsm_output[7]) | (fsm_output[0]) | (fsm_output[6]));
  assign mux_261_nl = MUX_s_1_2_2(nor_207_nl, nor_208_nl, fsm_output[5]);
  assign nor_209_nl = ~((~ (fsm_output[5])) | (fsm_output[1]) | (fsm_output[7]) |
      (fsm_output[0]) | (~ (fsm_output[6])));
  assign mux_262_nl = MUX_s_1_2_2(mux_261_nl, nor_209_nl, fsm_output[3]);
  assign mux_264_nl = MUX_s_1_2_2(and_379_nl, mux_262_nl, fsm_output[4]);
  assign mux_260_nl = MUX_s_1_2_2(or_310_cse, or_115_cse, fsm_output[5]);
  assign nor_210_nl = ~((fsm_output[4:3]!=2'b10) | mux_260_nl);
  assign mux_265_nl = MUX_s_1_2_2(mux_264_nl, nor_210_nl, fsm_output[2]);
  assign nor_203_nl = ~((fsm_output[6]) | (fsm_output[7]) | (~ (fsm_output[3])));
  assign mux_267_nl = MUX_s_1_2_2(not_tmp_152, (fsm_output[3]), fsm_output[7]);
  assign nor_204_nl = ~((fsm_output[6]) | mux_267_nl);
  assign mux_268_nl = MUX_s_1_2_2(nor_203_nl, nor_204_nl, fsm_output[0]);
  assign nor_205_nl = ~((~ (fsm_output[6])) | (fsm_output[7]) | (fsm_output[3]) |
      (fsm_output[1]));
  assign mux_269_nl = MUX_s_1_2_2(mux_268_nl, nor_205_nl, fsm_output[4]);
  assign or_319_nl = (~ (fsm_output[7])) | (fsm_output[3]) | (fsm_output[1]);
  assign or_318_nl = (fsm_output[7]) | not_tmp_152;
  assign mux_266_nl = MUX_s_1_2_2(or_319_nl, or_318_nl, fsm_output[6]);
  assign nor_206_nl = ~((fsm_output[4]) | (fsm_output[0]) | mux_266_nl);
  assign mux_270_nl = MUX_s_1_2_2(mux_269_nl, nor_206_nl, fsm_output[2]);
  assign and_193_nl = mux_270_nl & (fsm_output[5]);
  assign and_195_nl = and_dcpl_90 & and_dcpl_36 & (fsm_output[2]);
  assign nl_mult_z_mul_cmp_a = MUX1HOT_v_32_8_2(xx_rsci_q_d, mult_x_1_sva, mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm,
      mult_x_15_sva, operator_96_false_10_operator_96_false_10_slc_mult_10_t_mul_51_20_itm,
      operator_96_false_15_operator_96_false_15_slc_mult_15_t_mul_51_20_itm, yy_rsci_q_d,
      (mult_z_mul_cmp_z[51:20]), {nor_290_nl , (~ mux_240_nl) , (~ mux_245_nl) ,
      mux_250_nl , (~ mux_259_nl) , mux_265_nl , and_193_nl , and_195_nl});
  wire[0:0] nor_293_nl;
  wire[0:0] mux_272_nl;
  wire[0:0] mux_271_nl;
  wire[0:0] or_805_nl;
  wire[0:0] or_326_nl;
  wire[0:0] mux_280_nl;
  wire[0:0] mux_279_nl;
  wire[0:0] nor_334_nl;
  wire[0:0] nor_201_nl;
  wire[0:0] nor_202_nl;
  wire[0:0] mux_278_nl;
  wire[0:0] mux_277_nl;
  wire[0:0] or_330_nl;
  wire[0:0] nand_24_nl;
  wire[0:0] nand_23_nl;
  wire[0:0] mux_275_nl;
  wire[0:0] mux_283_nl;
  wire[0:0] mux_282_nl;
  wire[0:0] mux_281_nl;
  wire[0:0] or_337_nl;
  wire[0:0] or_335_nl;
  wire[0:0] mux_288_nl;
  wire[0:0] mux_287_nl;
  wire[0:0] nor_197_nl;
  wire[0:0] nor_198_nl;
  wire[0:0] mux_286_nl;
  wire[0:0] or_344_nl;
  wire[0:0] nand_27_nl;
  wire[0:0] mux_285_nl;
  wire[0:0] and_377_nl;
  wire[0:0] nor_199_nl;
  wire[0:0] nor_200_nl;
  wire[0:0] mux_284_nl;
  wire[0:0] or_340_nl;
  wire[0:0] or_339_nl;
  wire[0:0] mux_293_nl;
  wire[0:0] nor_195_nl;
  wire[0:0] mux_292_nl;
  wire[0:0] mux_291_nl;
  wire[0:0] nand_117_nl;
  wire[0:0] or_354_nl;
  wire[0:0] nor_196_nl;
  wire[0:0] mux_289_nl;
  wire[0:0] or_348_nl;
  wire[0:0] mux_298_nl;
  wire[0:0] nor_190_nl;
  wire[0:0] mux_297_nl;
  wire[0:0] and_376_nl;
  wire[0:0] mux_296_nl;
  wire[0:0] mux_295_nl;
  wire[0:0] nor_191_nl;
  wire[0:0] mux_294_nl;
  wire[0:0] nor_192_nl;
  wire[0:0] nor_193_nl;
  wire[0:0] nor_194_nl;
  wire[0:0] mux_305_nl;
  wire[0:0] mux_304_nl;
  wire[0:0] mux_303_nl;
  wire[0:0] mux_302_nl;
  wire[0:0] mux_301_nl;
  wire[0:0] or_369_nl;
  wire[0:0] mux_300_nl;
  wire[0:0] nand_29_nl;
  wire[0:0] mux_299_nl;
  wire[0:0] or_368_nl;
  wire[0:0] and_197_nl;
  wire [31:0] nl_mult_z_mul_cmp_b;
  assign or_805_nl = (fsm_output[1:0]!=2'b01) | mux_51_cse;
  assign mux_271_nl = MUX_s_1_2_2(or_805_nl, or_tmp_53, fsm_output[3]);
  assign or_326_nl = (~ (fsm_output[3])) | (~ (fsm_output[1])) | (fsm_output[0])
      | mux_556_cse;
  assign mux_272_nl = MUX_s_1_2_2(mux_271_nl, or_326_nl, fsm_output[2]);
  assign nor_293_nl = ~(mux_272_nl | (fsm_output[4]));
  assign nor_334_nl = ~((~ (fsm_output[0])) | (fsm_output[2]) | (~ (fsm_output[3]))
      | mux_290_cse);
  assign nor_201_nl = ~((fsm_output[0]) | (~ (fsm_output[2])) | (fsm_output[3]) |
      mux_556_cse);
  assign mux_279_nl = MUX_s_1_2_2(nor_334_nl, nor_201_nl, fsm_output[4]);
  assign or_330_nl = (fsm_output[3]) | mux_51_cse;
  assign nand_24_nl = ~((fsm_output[3]) & (~ mux_290_cse));
  assign mux_277_nl = MUX_s_1_2_2(or_330_nl, nand_24_nl, fsm_output[2]);
  assign mux_275_nl = MUX_s_1_2_2(mux_51_cse, mux_556_cse, fsm_output[3]);
  assign nand_23_nl = ~((fsm_output[2]) & (~ mux_275_nl));
  assign mux_278_nl = MUX_s_1_2_2(mux_277_nl, nand_23_nl, fsm_output[0]);
  assign nor_202_nl = ~((fsm_output[4]) | mux_278_nl);
  assign mux_280_nl = MUX_s_1_2_2(mux_279_nl, nor_202_nl, fsm_output[1]);
  assign or_337_nl = (~ (fsm_output[0])) | (fsm_output[4]) | mux_51_cse;
  assign mux_281_nl = MUX_s_1_2_2(nand_tmp_2, or_337_nl, fsm_output[1]);
  assign mux_282_nl = MUX_s_1_2_2(mux_281_nl, or_tmp_263, fsm_output[3]);
  assign or_335_nl = (fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4])
      | mux_51_cse;
  assign mux_283_nl = MUX_s_1_2_2(mux_282_nl, or_335_nl, fsm_output[2]);
  assign nor_197_nl = ~((~ (fsm_output[6])) | (~ (fsm_output[2])) | (fsm_output[0])
      | (fsm_output[7]) | (~ (fsm_output[1])) | (fsm_output[5]));
  assign or_344_nl = (fsm_output[0]) | (~ (fsm_output[7])) | (fsm_output[1]) | (~
      (fsm_output[5]));
  assign and_377_nl = (fsm_output[1]) & (fsm_output[5]);
  assign nor_199_nl = ~((~ (fsm_output[1])) | (fsm_output[5]));
  assign mux_285_nl = MUX_s_1_2_2(and_377_nl, nor_199_nl, fsm_output[7]);
  assign nand_27_nl = ~((fsm_output[0]) & mux_285_nl);
  assign mux_286_nl = MUX_s_1_2_2(or_344_nl, nand_27_nl, fsm_output[2]);
  assign nor_198_nl = ~((fsm_output[6]) | mux_286_nl);
  assign mux_287_nl = MUX_s_1_2_2(nor_197_nl, nor_198_nl, fsm_output[3]);
  assign or_340_nl = (fsm_output[2]) | (fsm_output[0]) | (fsm_output[7]) | (~ (fsm_output[1]))
      | (fsm_output[5]);
  assign or_339_nl = (~ (fsm_output[2])) | (~ (fsm_output[0])) | (fsm_output[7])
      | (fsm_output[1]) | (~ (fsm_output[5]));
  assign mux_284_nl = MUX_s_1_2_2(or_340_nl, or_339_nl, fsm_output[6]);
  assign nor_200_nl = ~((fsm_output[3]) | mux_284_nl);
  assign mux_288_nl = MUX_s_1_2_2(mux_287_nl, nor_200_nl, fsm_output[4]);
  assign nand_117_nl = ~((fsm_output[0]) & (fsm_output[5]) & (fsm_output[7]) & (~
      (fsm_output[6])));
  assign or_354_nl = (fsm_output[0]) | mux_290_cse;
  assign mux_291_nl = MUX_s_1_2_2(nand_117_nl, or_354_nl, fsm_output[3]);
  assign mux_292_nl = MUX_s_1_2_2(or_270_cse, mux_291_nl, fsm_output[2]);
  assign nor_195_nl = ~((fsm_output[4]) | mux_292_nl);
  assign or_348_nl = (fsm_output[7:5]!=3'b000);
  assign mux_289_nl = MUX_s_1_2_2(or_350_cse, or_348_nl, fsm_output[0]);
  assign nor_196_nl = ~((fsm_output[4:2]!=3'b100) | mux_289_nl);
  assign mux_293_nl = MUX_s_1_2_2(nor_195_nl, nor_196_nl, fsm_output[1]);
  assign nor_190_nl = ~((fsm_output[7:1]!=7'b1010011));
  assign mux_294_nl = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[4]);
  assign nor_191_nl = ~((fsm_output[5]) | mux_294_nl);
  assign nor_192_nl = ~((fsm_output[6:4]!=3'b010));
  assign mux_295_nl = MUX_s_1_2_2(nor_191_nl, nor_192_nl, fsm_output[3]);
  assign nor_193_nl = ~((fsm_output[6:3]!=4'b0001));
  assign mux_296_nl = MUX_s_1_2_2(mux_295_nl, nor_193_nl, fsm_output[7]);
  assign and_376_nl = (fsm_output[2]) & mux_296_nl;
  assign nor_194_nl = ~((fsm_output[7:2]!=6'b011100));
  assign mux_297_nl = MUX_s_1_2_2(and_376_nl, nor_194_nl, fsm_output[1]);
  assign mux_298_nl = MUX_s_1_2_2(nor_190_nl, mux_297_nl, fsm_output[0]);
  assign mux_301_nl = MUX_s_1_2_2(mux_51_cse, mux_556_cse, fsm_output[4]);
  assign mux_302_nl = MUX_s_1_2_2(nand_tmp_2, mux_301_nl, fsm_output[0]);
  assign or_369_nl = (fsm_output[4]) | mux_51_cse;
  assign mux_303_nl = MUX_s_1_2_2(mux_302_nl, or_369_nl, fsm_output[1]);
  assign mux_304_nl = MUX_s_1_2_2(nand_59_cse, mux_303_nl, fsm_output[3]);
  assign nand_29_nl = ~((fsm_output[1]) & (fsm_output[4]) & (~ mux_556_cse));
  assign or_368_nl = (fsm_output[0]) | (fsm_output[4]) | mux_51_cse;
  assign mux_299_nl = MUX_s_1_2_2(or_368_nl, or_tmp_352, fsm_output[1]);
  assign mux_300_nl = MUX_s_1_2_2(nand_29_nl, mux_299_nl, fsm_output[3]);
  assign mux_305_nl = MUX_s_1_2_2(mux_304_nl, mux_300_nl, fsm_output[2]);
  assign and_197_nl = and_dcpl_90 & and_dcpl_47;
  assign nl_mult_z_mul_cmp_b = MUX1HOT_v_32_9_2(twiddle_h_rsci_s_din_mxwt, butterFly_10_tw_asn_itm,
      twiddle_rsci_s_din_mxwt, butterFly_10_f1_sva, butterFly_10_tw_h_asn_itm, butterFly_13_tw_h_asn_itm,
      m_sva, ({{12{tw_h_rsci_s_din_mxwt[19]}}, tw_h_rsci_s_din_mxwt}), ({{12{S34_OUTER_LOOP_for_tf_h_sva[19]}},
      S34_OUTER_LOOP_for_tf_h_sva}), {nor_293_nl , mux_280_nl , (~ mux_283_nl) ,
      mux_288_nl , mux_293_nl , mux_298_nl , (~ mux_305_nl) , and_197_nl , and_dcpl_188});
  wire[0:0] operator_33_true_operator_33_true_and_nl;
  wire[0:0] operator_33_true_mux_nl;
  wire [3:0] nl_operator_33_true_1_lshift_rg_s;
  assign operator_33_true_operator_33_true_and_nl = (S2_INNER_LOOP1_r_4_2_sva_1_0[0])
      & (~ and_428_ssc);
  assign operator_33_true_mux_nl = MUX_s_1_2_2(S2_OUTER_LOOP_c_1_sva, (~ S2_OUTER_LOOP_c_1_sva),
      and_428_ssc);
  assign nl_operator_33_true_1_lshift_rg_s = {1'b0 , operator_33_true_operator_33_true_and_nl
      , operator_33_true_mux_nl , and_428_ssc};
  wire [0:0] nl_hybrid_core_wait_dp_inst_yy_rsc_cgo_iro;
  assign nl_hybrid_core_wait_dp_inst_yy_rsc_cgo_iro = ~ mux_163_itm;
  wire [0:0] nl_hybrid_core_wait_dp_inst_ensig_cgo_iro_1;
  assign nl_hybrid_core_wait_dp_inst_ensig_cgo_iro_1 = ~ mux_222_itm;
  wire [9:0] nl_hybrid_core_x_rsci_inst_x_rsci_s_raddr_core;
  assign nl_hybrid_core_x_rsci_inst_x_rsci_s_raddr_core = {x_rsci_s_raddr_core_9_5
      , x_rsci_s_raddr_core_4_0};
  wire [9:0] nl_hybrid_core_x_rsci_inst_x_rsci_s_waddr_core;
  assign nl_hybrid_core_x_rsci_inst_x_rsci_s_waddr_core = {x_rsci_s_waddr_core_9_5
      , x_rsci_s_waddr_core_4_0};
  wire [4:0] nl_hybrid_core_twiddle_rsci_inst_twiddle_rsci_s_raddr_core;
  assign nl_hybrid_core_twiddle_rsci_inst_twiddle_rsci_s_raddr_core = {1'b0 , reg_twiddle_rsci_s_raddr_core_3_cse
      , reg_twiddle_rsci_s_raddr_core_2_cse , reg_twiddle_rsci_s_raddr_core_1_cse
      , reg_twiddle_rsci_s_raddr_core_0_cse};
  wire [4:0] nl_hybrid_core_twiddle_h_rsci_inst_twiddle_h_rsci_s_raddr_core;
  assign nl_hybrid_core_twiddle_h_rsci_inst_twiddle_h_rsci_s_raddr_core = {1'b0 ,
      reg_twiddle_rsci_s_raddr_core_3_cse , reg_twiddle_rsci_s_raddr_core_2_cse ,
      reg_twiddle_rsci_s_raddr_core_1_cse , reg_twiddle_rsci_s_raddr_core_0_cse};
  wire [0:0] nl_hybrid_core_core_fsm_inst_S1_OUTER_LOOP_for_C_4_tr0;
  assign nl_hybrid_core_core_fsm_inst_S1_OUTER_LOOP_for_C_4_tr0 = ~ operator_20_true_1_slc_operator_20_true_1_acc_14_itm;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S1_OUTER_LOOP_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S1_OUTER_LOOP_C_0_tr0 = S1_OUTER_LOOP_k_5_0_sva_2[5];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_COPY_LOOP_for_C_3_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_COPY_LOOP_for_C_3_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_COPY_LOOP_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_COPY_LOOP_C_0_tr0 = S1_OUTER_LOOP_k_5_0_sva_2[5];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP1_for_C_23_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP1_for_C_23_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP1_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP1_C_0_tr0 = z_out_2[2];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_for_C_23_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_for_C_23_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_C_0_tr0 = and_19_cse;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_C_0_tr1;
  assign nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_C_0_tr1 = ~ (z_out_2[2]);
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP3_for_C_23_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP3_for_C_23_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP3_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP3_C_0_tr0 = z_out_2[2];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S34_OUTER_LOOP_for_C_12_tr0;
  assign nl_hybrid_core_core_fsm_inst_S34_OUTER_LOOP_for_C_12_tr0 = ~ operator_20_true_8_slc_operator_20_true_8_acc_14_itm;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S34_OUTER_LOOP_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S34_OUTER_LOOP_C_0_tr0 = S1_OUTER_LOOP_k_5_0_sva_2[5];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_COPY_LOOP_for_C_3_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_COPY_LOOP_for_C_3_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_COPY_LOOP_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_COPY_LOOP_C_0_tr0 = S1_OUTER_LOOP_k_5_0_sva_2[5];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP1_for_C_23_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP1_for_C_23_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP1_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP1_C_0_tr0 = z_out_2[2];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_for_C_23_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_for_C_23_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_C_0_tr0 = and_19_cse;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_C_0_tr1;
  assign nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_C_0_tr1 = ~ (z_out_2[2]);
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP3_for_C_23_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP3_for_C_23_tr0 = S2_COPY_LOOP_for_i_5_0_sva_1_5;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP3_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP3_C_0_tr0 = z_out_2[2];
  wire [0:0] nl_hybrid_core_core_fsm_inst_S6_OUTER_LOOP_for_C_3_tr0;
  assign nl_hybrid_core_core_fsm_inst_S6_OUTER_LOOP_for_C_3_tr0 = ~ operator_20_true_15_slc_operator_20_true_15_acc_14_itm;
  wire [0:0] nl_hybrid_core_core_fsm_inst_S6_OUTER_LOOP_C_0_tr0;
  assign nl_hybrid_core_core_fsm_inst_S6_OUTER_LOOP_C_0_tr0 = S1_OUTER_LOOP_k_5_0_sva_2[5];
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd32)) m_rsci (
      .dat(m_rsc_dat),
      .idat(m_rsci_idat)
    );
  mgc_mul_pipe #(.width_a(32'sd20),
  .signd_a(32'sd1),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd32),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) mult_12_z_mul_cmp (
      .a(nl_mult_12_z_mul_cmp_a[19:0]),
      .b(nl_mult_12_z_mul_cmp_b[31:0]),
      .clk(clk),
      .en(mult_12_z_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(mult_12_z_mul_cmp_z)
    );
  mgc_mul_pipe #(.width_a(32'sd32),
  .signd_a(32'sd0),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd52),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) mult_z_mul_cmp (
      .a(nl_mult_z_mul_cmp_a[31:0]),
      .b(nl_mult_z_mul_cmp_b[31:0]),
      .clk(clk),
      .en(mult_z_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(mult_z_mul_cmp_z)
    );
  mgc_shift_bl_v5 #(.width_a(32'sd1),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd4)) operator_33_true_1_lshift_rg (
      .a(1'b1),
      .s(nl_operator_33_true_1_lshift_rg_s[3:0]),
      .z(z_out)
    );
  hybrid_core_wait_dp hybrid_core_wait_dp_inst (
      .clk(clk),
      .xx_rsc_cgo_iro(mux_84_rmff),
      .xx_rsci_clken_d(xx_rsci_clken_d),
      .yy_rsc_cgo_iro(nl_hybrid_core_wait_dp_inst_yy_rsc_cgo_iro[0:0]),
      .yy_rsci_clken_d(yy_rsci_clken_d),
      .ensig_cgo_iro(and_188_rmff),
      .S34_OUTER_LOOP_for_tf_mul_cmp_z(S34_OUTER_LOOP_for_tf_mul_cmp_z),
      .ensig_cgo_iro_1(nl_hybrid_core_wait_dp_inst_ensig_cgo_iro_1[0:0]),
      .core_wen(core_wen),
      .xx_rsc_cgo(reg_xx_rsc_cgo_cse),
      .yy_rsc_cgo(reg_yy_rsc_cgo_cse),
      .ensig_cgo(reg_ensig_cgo_cse),
      .mult_12_z_mul_cmp_en(mult_12_z_mul_cmp_en),
      .S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg(S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg),
      .ensig_cgo_1(reg_ensig_cgo_1_cse),
      .mult_z_mul_cmp_en(mult_z_mul_cmp_en)
    );
  hybrid_core_x_rsci hybrid_core_x_rsci_inst (
      .clk(clk),
      .rst(rst),
      .x_rsc_s_tdone(x_rsc_s_tdone),
      .x_rsc_tr_write_done(x_rsc_tr_write_done),
      .x_rsc_RREADY(x_rsc_RREADY),
      .x_rsc_RVALID(x_rsc_RVALID),
      .x_rsc_RUSER(x_rsc_RUSER),
      .x_rsc_RLAST(x_rsc_RLAST),
      .x_rsc_RRESP(x_rsc_RRESP),
      .x_rsc_RDATA(x_rsc_RDATA),
      .x_rsc_RID(x_rsc_RID),
      .x_rsc_ARREADY(x_rsc_ARREADY),
      .x_rsc_ARVALID(x_rsc_ARVALID),
      .x_rsc_ARUSER(x_rsc_ARUSER),
      .x_rsc_ARREGION(x_rsc_ARREGION),
      .x_rsc_ARQOS(x_rsc_ARQOS),
      .x_rsc_ARPROT(x_rsc_ARPROT),
      .x_rsc_ARCACHE(x_rsc_ARCACHE),
      .x_rsc_ARLOCK(x_rsc_ARLOCK),
      .x_rsc_ARBURST(x_rsc_ARBURST),
      .x_rsc_ARSIZE(x_rsc_ARSIZE),
      .x_rsc_ARLEN(x_rsc_ARLEN),
      .x_rsc_ARADDR(x_rsc_ARADDR),
      .x_rsc_ARID(x_rsc_ARID),
      .x_rsc_BREADY(x_rsc_BREADY),
      .x_rsc_BVALID(x_rsc_BVALID),
      .x_rsc_BUSER(x_rsc_BUSER),
      .x_rsc_BRESP(x_rsc_BRESP),
      .x_rsc_BID(x_rsc_BID),
      .x_rsc_WREADY(x_rsc_WREADY),
      .x_rsc_WVALID(x_rsc_WVALID),
      .x_rsc_WUSER(x_rsc_WUSER),
      .x_rsc_WLAST(x_rsc_WLAST),
      .x_rsc_WSTRB(x_rsc_WSTRB),
      .x_rsc_WDATA(x_rsc_WDATA),
      .x_rsc_AWREADY(x_rsc_AWREADY),
      .x_rsc_AWVALID(x_rsc_AWVALID),
      .x_rsc_AWUSER(x_rsc_AWUSER),
      .x_rsc_AWREGION(x_rsc_AWREGION),
      .x_rsc_AWQOS(x_rsc_AWQOS),
      .x_rsc_AWPROT(x_rsc_AWPROT),
      .x_rsc_AWCACHE(x_rsc_AWCACHE),
      .x_rsc_AWLOCK(x_rsc_AWLOCK),
      .x_rsc_AWBURST(x_rsc_AWBURST),
      .x_rsc_AWSIZE(x_rsc_AWSIZE),
      .x_rsc_AWLEN(x_rsc_AWLEN),
      .x_rsc_AWADDR(x_rsc_AWADDR),
      .x_rsc_AWID(x_rsc_AWID),
      .core_wen(core_wen),
      .x_rsci_oswt(reg_x_rsci_oswt_cse),
      .x_rsci_wen_comp(x_rsci_wen_comp),
      .x_rsci_oswt_1(reg_x_rsci_oswt_1_cse),
      .x_rsci_wen_comp_1(x_rsci_wen_comp_1),
      .x_rsci_s_raddr_core(nl_hybrid_core_x_rsci_inst_x_rsci_s_raddr_core[9:0]),
      .x_rsci_s_waddr_core(nl_hybrid_core_x_rsci_inst_x_rsci_s_waddr_core[9:0]),
      .x_rsci_s_din_mxwt(x_rsci_s_din_mxwt),
      .x_rsci_s_dout_core(x_rsci_s_dout_core)
    );
  hybrid_core_twiddle_rsci hybrid_core_twiddle_rsci_inst (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_s_tdone(twiddle_rsc_s_tdone),
      .twiddle_rsc_tr_write_done(twiddle_rsc_tr_write_done),
      .twiddle_rsc_RREADY(twiddle_rsc_RREADY),
      .twiddle_rsc_RVALID(twiddle_rsc_RVALID),
      .twiddle_rsc_RUSER(twiddle_rsc_RUSER),
      .twiddle_rsc_RLAST(twiddle_rsc_RLAST),
      .twiddle_rsc_RRESP(twiddle_rsc_RRESP),
      .twiddle_rsc_RDATA(twiddle_rsc_RDATA),
      .twiddle_rsc_RID(twiddle_rsc_RID),
      .twiddle_rsc_ARREADY(twiddle_rsc_ARREADY),
      .twiddle_rsc_ARVALID(twiddle_rsc_ARVALID),
      .twiddle_rsc_ARUSER(twiddle_rsc_ARUSER),
      .twiddle_rsc_ARREGION(twiddle_rsc_ARREGION),
      .twiddle_rsc_ARQOS(twiddle_rsc_ARQOS),
      .twiddle_rsc_ARPROT(twiddle_rsc_ARPROT),
      .twiddle_rsc_ARCACHE(twiddle_rsc_ARCACHE),
      .twiddle_rsc_ARLOCK(twiddle_rsc_ARLOCK),
      .twiddle_rsc_ARBURST(twiddle_rsc_ARBURST),
      .twiddle_rsc_ARSIZE(twiddle_rsc_ARSIZE),
      .twiddle_rsc_ARLEN(twiddle_rsc_ARLEN),
      .twiddle_rsc_ARADDR(twiddle_rsc_ARADDR),
      .twiddle_rsc_ARID(twiddle_rsc_ARID),
      .twiddle_rsc_BREADY(twiddle_rsc_BREADY),
      .twiddle_rsc_BVALID(twiddle_rsc_BVALID),
      .twiddle_rsc_BUSER(twiddle_rsc_BUSER),
      .twiddle_rsc_BRESP(twiddle_rsc_BRESP),
      .twiddle_rsc_BID(twiddle_rsc_BID),
      .twiddle_rsc_WREADY(twiddle_rsc_WREADY),
      .twiddle_rsc_WVALID(twiddle_rsc_WVALID),
      .twiddle_rsc_WUSER(twiddle_rsc_WUSER),
      .twiddle_rsc_WLAST(twiddle_rsc_WLAST),
      .twiddle_rsc_WSTRB(twiddle_rsc_WSTRB),
      .twiddle_rsc_WDATA(twiddle_rsc_WDATA),
      .twiddle_rsc_AWREADY(twiddle_rsc_AWREADY),
      .twiddle_rsc_AWVALID(twiddle_rsc_AWVALID),
      .twiddle_rsc_AWUSER(twiddle_rsc_AWUSER),
      .twiddle_rsc_AWREGION(twiddle_rsc_AWREGION),
      .twiddle_rsc_AWQOS(twiddle_rsc_AWQOS),
      .twiddle_rsc_AWPROT(twiddle_rsc_AWPROT),
      .twiddle_rsc_AWCACHE(twiddle_rsc_AWCACHE),
      .twiddle_rsc_AWLOCK(twiddle_rsc_AWLOCK),
      .twiddle_rsc_AWBURST(twiddle_rsc_AWBURST),
      .twiddle_rsc_AWSIZE(twiddle_rsc_AWSIZE),
      .twiddle_rsc_AWLEN(twiddle_rsc_AWLEN),
      .twiddle_rsc_AWADDR(twiddle_rsc_AWADDR),
      .twiddle_rsc_AWID(twiddle_rsc_AWID),
      .core_wen(core_wen),
      .twiddle_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_rsci_wen_comp(twiddle_rsci_wen_comp),
      .twiddle_rsci_s_raddr_core(nl_hybrid_core_twiddle_rsci_inst_twiddle_rsci_s_raddr_core[4:0]),
      .twiddle_rsci_s_din_mxwt(twiddle_rsci_s_din_mxwt)
    );
  hybrid_core_twiddle_h_rsci hybrid_core_twiddle_h_rsci_inst (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_s_tdone(twiddle_h_rsc_s_tdone),
      .twiddle_h_rsc_tr_write_done(twiddle_h_rsc_tr_write_done),
      .twiddle_h_rsc_RREADY(twiddle_h_rsc_RREADY),
      .twiddle_h_rsc_RVALID(twiddle_h_rsc_RVALID),
      .twiddle_h_rsc_RUSER(twiddle_h_rsc_RUSER),
      .twiddle_h_rsc_RLAST(twiddle_h_rsc_RLAST),
      .twiddle_h_rsc_RRESP(twiddle_h_rsc_RRESP),
      .twiddle_h_rsc_RDATA(twiddle_h_rsc_RDATA),
      .twiddle_h_rsc_RID(twiddle_h_rsc_RID),
      .twiddle_h_rsc_ARREADY(twiddle_h_rsc_ARREADY),
      .twiddle_h_rsc_ARVALID(twiddle_h_rsc_ARVALID),
      .twiddle_h_rsc_ARUSER(twiddle_h_rsc_ARUSER),
      .twiddle_h_rsc_ARREGION(twiddle_h_rsc_ARREGION),
      .twiddle_h_rsc_ARQOS(twiddle_h_rsc_ARQOS),
      .twiddle_h_rsc_ARPROT(twiddle_h_rsc_ARPROT),
      .twiddle_h_rsc_ARCACHE(twiddle_h_rsc_ARCACHE),
      .twiddle_h_rsc_ARLOCK(twiddle_h_rsc_ARLOCK),
      .twiddle_h_rsc_ARBURST(twiddle_h_rsc_ARBURST),
      .twiddle_h_rsc_ARSIZE(twiddle_h_rsc_ARSIZE),
      .twiddle_h_rsc_ARLEN(twiddle_h_rsc_ARLEN),
      .twiddle_h_rsc_ARADDR(twiddle_h_rsc_ARADDR),
      .twiddle_h_rsc_ARID(twiddle_h_rsc_ARID),
      .twiddle_h_rsc_BREADY(twiddle_h_rsc_BREADY),
      .twiddle_h_rsc_BVALID(twiddle_h_rsc_BVALID),
      .twiddle_h_rsc_BUSER(twiddle_h_rsc_BUSER),
      .twiddle_h_rsc_BRESP(twiddle_h_rsc_BRESP),
      .twiddle_h_rsc_BID(twiddle_h_rsc_BID),
      .twiddle_h_rsc_WREADY(twiddle_h_rsc_WREADY),
      .twiddle_h_rsc_WVALID(twiddle_h_rsc_WVALID),
      .twiddle_h_rsc_WUSER(twiddle_h_rsc_WUSER),
      .twiddle_h_rsc_WLAST(twiddle_h_rsc_WLAST),
      .twiddle_h_rsc_WSTRB(twiddle_h_rsc_WSTRB),
      .twiddle_h_rsc_WDATA(twiddle_h_rsc_WDATA),
      .twiddle_h_rsc_AWREADY(twiddle_h_rsc_AWREADY),
      .twiddle_h_rsc_AWVALID(twiddle_h_rsc_AWVALID),
      .twiddle_h_rsc_AWUSER(twiddle_h_rsc_AWUSER),
      .twiddle_h_rsc_AWREGION(twiddle_h_rsc_AWREGION),
      .twiddle_h_rsc_AWQOS(twiddle_h_rsc_AWQOS),
      .twiddle_h_rsc_AWPROT(twiddle_h_rsc_AWPROT),
      .twiddle_h_rsc_AWCACHE(twiddle_h_rsc_AWCACHE),
      .twiddle_h_rsc_AWLOCK(twiddle_h_rsc_AWLOCK),
      .twiddle_h_rsc_AWBURST(twiddle_h_rsc_AWBURST),
      .twiddle_h_rsc_AWSIZE(twiddle_h_rsc_AWSIZE),
      .twiddle_h_rsc_AWLEN(twiddle_h_rsc_AWLEN),
      .twiddle_h_rsc_AWADDR(twiddle_h_rsc_AWADDR),
      .twiddle_h_rsc_AWID(twiddle_h_rsc_AWID),
      .core_wen(core_wen),
      .twiddle_h_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_h_rsci_wen_comp(twiddle_h_rsci_wen_comp),
      .twiddle_h_rsci_s_raddr_core(nl_hybrid_core_twiddle_h_rsci_inst_twiddle_h_rsci_s_raddr_core[4:0]),
      .twiddle_h_rsci_s_din_mxwt(twiddle_h_rsci_s_din_mxwt)
    );
  hybrid_core_revArr_rsci hybrid_core_revArr_rsci_inst (
      .clk(clk),
      .rst(rst),
      .revArr_rsc_s_tdone(revArr_rsc_s_tdone),
      .revArr_rsc_tr_write_done(revArr_rsc_tr_write_done),
      .revArr_rsc_RREADY(revArr_rsc_RREADY),
      .revArr_rsc_RVALID(revArr_rsc_RVALID),
      .revArr_rsc_RUSER(revArr_rsc_RUSER),
      .revArr_rsc_RLAST(revArr_rsc_RLAST),
      .revArr_rsc_RRESP(revArr_rsc_RRESP),
      .revArr_rsc_RDATA(revArr_rsc_RDATA),
      .revArr_rsc_RID(revArr_rsc_RID),
      .revArr_rsc_ARREADY(revArr_rsc_ARREADY),
      .revArr_rsc_ARVALID(revArr_rsc_ARVALID),
      .revArr_rsc_ARUSER(revArr_rsc_ARUSER),
      .revArr_rsc_ARREGION(revArr_rsc_ARREGION),
      .revArr_rsc_ARQOS(revArr_rsc_ARQOS),
      .revArr_rsc_ARPROT(revArr_rsc_ARPROT),
      .revArr_rsc_ARCACHE(revArr_rsc_ARCACHE),
      .revArr_rsc_ARLOCK(revArr_rsc_ARLOCK),
      .revArr_rsc_ARBURST(revArr_rsc_ARBURST),
      .revArr_rsc_ARSIZE(revArr_rsc_ARSIZE),
      .revArr_rsc_ARLEN(revArr_rsc_ARLEN),
      .revArr_rsc_ARADDR(revArr_rsc_ARADDR),
      .revArr_rsc_ARID(revArr_rsc_ARID),
      .revArr_rsc_BREADY(revArr_rsc_BREADY),
      .revArr_rsc_BVALID(revArr_rsc_BVALID),
      .revArr_rsc_BUSER(revArr_rsc_BUSER),
      .revArr_rsc_BRESP(revArr_rsc_BRESP),
      .revArr_rsc_BID(revArr_rsc_BID),
      .revArr_rsc_WREADY(revArr_rsc_WREADY),
      .revArr_rsc_WVALID(revArr_rsc_WVALID),
      .revArr_rsc_WUSER(revArr_rsc_WUSER),
      .revArr_rsc_WLAST(revArr_rsc_WLAST),
      .revArr_rsc_WSTRB(revArr_rsc_WSTRB),
      .revArr_rsc_WDATA(revArr_rsc_WDATA),
      .revArr_rsc_AWREADY(revArr_rsc_AWREADY),
      .revArr_rsc_AWVALID(revArr_rsc_AWVALID),
      .revArr_rsc_AWUSER(revArr_rsc_AWUSER),
      .revArr_rsc_AWREGION(revArr_rsc_AWREGION),
      .revArr_rsc_AWQOS(revArr_rsc_AWQOS),
      .revArr_rsc_AWPROT(revArr_rsc_AWPROT),
      .revArr_rsc_AWCACHE(revArr_rsc_AWCACHE),
      .revArr_rsc_AWLOCK(revArr_rsc_AWLOCK),
      .revArr_rsc_AWBURST(revArr_rsc_AWBURST),
      .revArr_rsc_AWSIZE(revArr_rsc_AWSIZE),
      .revArr_rsc_AWLEN(revArr_rsc_AWLEN),
      .revArr_rsc_AWADDR(revArr_rsc_AWADDR),
      .revArr_rsc_AWID(revArr_rsc_AWID),
      .core_wen(core_wen),
      .revArr_rsci_oswt(reg_revArr_rsci_oswt_cse),
      .revArr_rsci_wen_comp(revArr_rsci_wen_comp),
      .revArr_rsci_s_raddr_core(revArr_rsci_s_raddr_core),
      .revArr_rsci_s_din_mxwt(revArr_rsci_s_din_mxwt)
    );
  hybrid_core_tw_rsci hybrid_core_tw_rsci_inst (
      .clk(clk),
      .rst(rst),
      .tw_rsc_s_tdone(tw_rsc_s_tdone),
      .tw_rsc_tr_write_done(tw_rsc_tr_write_done),
      .tw_rsc_RREADY(tw_rsc_RREADY),
      .tw_rsc_RVALID(tw_rsc_RVALID),
      .tw_rsc_RUSER(tw_rsc_RUSER),
      .tw_rsc_RLAST(tw_rsc_RLAST),
      .tw_rsc_RRESP(tw_rsc_RRESP),
      .tw_rsc_RDATA(tw_rsc_RDATA),
      .tw_rsc_RID(tw_rsc_RID),
      .tw_rsc_ARREADY(tw_rsc_ARREADY),
      .tw_rsc_ARVALID(tw_rsc_ARVALID),
      .tw_rsc_ARUSER(tw_rsc_ARUSER),
      .tw_rsc_ARREGION(tw_rsc_ARREGION),
      .tw_rsc_ARQOS(tw_rsc_ARQOS),
      .tw_rsc_ARPROT(tw_rsc_ARPROT),
      .tw_rsc_ARCACHE(tw_rsc_ARCACHE),
      .tw_rsc_ARLOCK(tw_rsc_ARLOCK),
      .tw_rsc_ARBURST(tw_rsc_ARBURST),
      .tw_rsc_ARSIZE(tw_rsc_ARSIZE),
      .tw_rsc_ARLEN(tw_rsc_ARLEN),
      .tw_rsc_ARADDR(tw_rsc_ARADDR),
      .tw_rsc_ARID(tw_rsc_ARID),
      .tw_rsc_BREADY(tw_rsc_BREADY),
      .tw_rsc_BVALID(tw_rsc_BVALID),
      .tw_rsc_BUSER(tw_rsc_BUSER),
      .tw_rsc_BRESP(tw_rsc_BRESP),
      .tw_rsc_BID(tw_rsc_BID),
      .tw_rsc_WREADY(tw_rsc_WREADY),
      .tw_rsc_WVALID(tw_rsc_WVALID),
      .tw_rsc_WUSER(tw_rsc_WUSER),
      .tw_rsc_WLAST(tw_rsc_WLAST),
      .tw_rsc_WSTRB(tw_rsc_WSTRB),
      .tw_rsc_WDATA(tw_rsc_WDATA),
      .tw_rsc_AWREADY(tw_rsc_AWREADY),
      .tw_rsc_AWVALID(tw_rsc_AWVALID),
      .tw_rsc_AWUSER(tw_rsc_AWUSER),
      .tw_rsc_AWREGION(tw_rsc_AWREGION),
      .tw_rsc_AWQOS(tw_rsc_AWQOS),
      .tw_rsc_AWPROT(tw_rsc_AWPROT),
      .tw_rsc_AWCACHE(tw_rsc_AWCACHE),
      .tw_rsc_AWLOCK(tw_rsc_AWLOCK),
      .tw_rsc_AWBURST(tw_rsc_AWBURST),
      .tw_rsc_AWSIZE(tw_rsc_AWSIZE),
      .tw_rsc_AWLEN(tw_rsc_AWLEN),
      .tw_rsc_AWADDR(tw_rsc_AWADDR),
      .tw_rsc_AWID(tw_rsc_AWID),
      .core_wen(core_wen),
      .tw_rsci_oswt(reg_tw_rsci_oswt_cse),
      .tw_rsci_wen_comp(tw_rsci_wen_comp),
      .tw_rsci_s_raddr_core(reg_tw_rsci_s_raddr_core_cse),
      .tw_rsci_s_din_mxwt(tw_rsci_s_din_mxwt)
    );
  hybrid_core_tw_h_rsci hybrid_core_tw_h_rsci_inst (
      .clk(clk),
      .rst(rst),
      .tw_h_rsc_s_tdone(tw_h_rsc_s_tdone),
      .tw_h_rsc_tr_write_done(tw_h_rsc_tr_write_done),
      .tw_h_rsc_RREADY(tw_h_rsc_RREADY),
      .tw_h_rsc_RVALID(tw_h_rsc_RVALID),
      .tw_h_rsc_RUSER(tw_h_rsc_RUSER),
      .tw_h_rsc_RLAST(tw_h_rsc_RLAST),
      .tw_h_rsc_RRESP(tw_h_rsc_RRESP),
      .tw_h_rsc_RDATA(tw_h_rsc_RDATA),
      .tw_h_rsc_RID(tw_h_rsc_RID),
      .tw_h_rsc_ARREADY(tw_h_rsc_ARREADY),
      .tw_h_rsc_ARVALID(tw_h_rsc_ARVALID),
      .tw_h_rsc_ARUSER(tw_h_rsc_ARUSER),
      .tw_h_rsc_ARREGION(tw_h_rsc_ARREGION),
      .tw_h_rsc_ARQOS(tw_h_rsc_ARQOS),
      .tw_h_rsc_ARPROT(tw_h_rsc_ARPROT),
      .tw_h_rsc_ARCACHE(tw_h_rsc_ARCACHE),
      .tw_h_rsc_ARLOCK(tw_h_rsc_ARLOCK),
      .tw_h_rsc_ARBURST(tw_h_rsc_ARBURST),
      .tw_h_rsc_ARSIZE(tw_h_rsc_ARSIZE),
      .tw_h_rsc_ARLEN(tw_h_rsc_ARLEN),
      .tw_h_rsc_ARADDR(tw_h_rsc_ARADDR),
      .tw_h_rsc_ARID(tw_h_rsc_ARID),
      .tw_h_rsc_BREADY(tw_h_rsc_BREADY),
      .tw_h_rsc_BVALID(tw_h_rsc_BVALID),
      .tw_h_rsc_BUSER(tw_h_rsc_BUSER),
      .tw_h_rsc_BRESP(tw_h_rsc_BRESP),
      .tw_h_rsc_BID(tw_h_rsc_BID),
      .tw_h_rsc_WREADY(tw_h_rsc_WREADY),
      .tw_h_rsc_WVALID(tw_h_rsc_WVALID),
      .tw_h_rsc_WUSER(tw_h_rsc_WUSER),
      .tw_h_rsc_WLAST(tw_h_rsc_WLAST),
      .tw_h_rsc_WSTRB(tw_h_rsc_WSTRB),
      .tw_h_rsc_WDATA(tw_h_rsc_WDATA),
      .tw_h_rsc_AWREADY(tw_h_rsc_AWREADY),
      .tw_h_rsc_AWVALID(tw_h_rsc_AWVALID),
      .tw_h_rsc_AWUSER(tw_h_rsc_AWUSER),
      .tw_h_rsc_AWREGION(tw_h_rsc_AWREGION),
      .tw_h_rsc_AWQOS(tw_h_rsc_AWQOS),
      .tw_h_rsc_AWPROT(tw_h_rsc_AWPROT),
      .tw_h_rsc_AWCACHE(tw_h_rsc_AWCACHE),
      .tw_h_rsc_AWLOCK(tw_h_rsc_AWLOCK),
      .tw_h_rsc_AWBURST(tw_h_rsc_AWBURST),
      .tw_h_rsc_AWSIZE(tw_h_rsc_AWSIZE),
      .tw_h_rsc_AWLEN(tw_h_rsc_AWLEN),
      .tw_h_rsc_AWADDR(tw_h_rsc_AWADDR),
      .tw_h_rsc_AWID(tw_h_rsc_AWID),
      .core_wen(core_wen),
      .tw_h_rsci_oswt(reg_tw_rsci_oswt_cse),
      .tw_h_rsci_wen_comp(tw_h_rsci_wen_comp),
      .tw_h_rsci_s_raddr_core(reg_tw_rsci_s_raddr_core_cse),
      .tw_h_rsci_s_din_mxwt(tw_h_rsci_s_din_mxwt)
    );
  hybrid_core_x_rsc_triosy_obj hybrid_core_x_rsc_triosy_obj_inst (
      .x_rsc_triosy_lz(x_rsc_triosy_lz),
      .core_wten(core_wten),
      .x_rsc_triosy_obj_iswt0(reg_x_rsc_triosy_obj_iswt0_cse)
    );
  hybrid_core_m_rsc_triosy_obj hybrid_core_m_rsc_triosy_obj_inst (
      .m_rsc_triosy_lz(m_rsc_triosy_lz),
      .core_wten(core_wten),
      .m_rsc_triosy_obj_iswt0(reg_x_rsc_triosy_obj_iswt0_cse)
    );
  hybrid_core_twiddle_rsc_triosy_obj hybrid_core_twiddle_rsc_triosy_obj_inst (
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_obj_iswt0(reg_x_rsc_triosy_obj_iswt0_cse)
    );
  hybrid_core_twiddle_h_rsc_triosy_obj hybrid_core_twiddle_h_rsc_triosy_obj_inst
      (
      .twiddle_h_rsc_triosy_lz(twiddle_h_rsc_triosy_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_obj_iswt0(reg_x_rsc_triosy_obj_iswt0_cse)
    );
  hybrid_core_revArr_rsc_triosy_obj hybrid_core_revArr_rsc_triosy_obj_inst (
      .revArr_rsc_triosy_lz(revArr_rsc_triosy_lz),
      .core_wten(core_wten),
      .revArr_rsc_triosy_obj_iswt0(reg_x_rsc_triosy_obj_iswt0_cse)
    );
  hybrid_core_tw_rsc_triosy_obj hybrid_core_tw_rsc_triosy_obj_inst (
      .tw_rsc_triosy_lz(tw_rsc_triosy_lz),
      .core_wten(core_wten),
      .tw_rsc_triosy_obj_iswt0(reg_x_rsc_triosy_obj_iswt0_cse)
    );
  hybrid_core_tw_h_rsc_triosy_obj hybrid_core_tw_h_rsc_triosy_obj_inst (
      .tw_h_rsc_triosy_lz(tw_h_rsc_triosy_lz),
      .core_wten(core_wten),
      .tw_h_rsc_triosy_obj_iswt0(reg_x_rsc_triosy_obj_iswt0_cse)
    );
  hybrid_core_staller hybrid_core_staller_inst (
      .clk(clk),
      .rst(rst),
      .core_wen(core_wen),
      .core_wten(core_wten),
      .x_rsci_wen_comp(x_rsci_wen_comp),
      .x_rsci_wen_comp_1(x_rsci_wen_comp_1),
      .twiddle_rsci_wen_comp(twiddle_rsci_wen_comp),
      .twiddle_h_rsci_wen_comp(twiddle_h_rsci_wen_comp),
      .revArr_rsci_wen_comp(revArr_rsci_wen_comp),
      .tw_rsci_wen_comp(tw_rsci_wen_comp),
      .tw_h_rsci_wen_comp(tw_h_rsci_wen_comp)
    );
  hybrid_core_core_fsm hybrid_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .core_wen(core_wen),
      .fsm_output(fsm_output),
      .S1_OUTER_LOOP_for_C_4_tr0(nl_hybrid_core_core_fsm_inst_S1_OUTER_LOOP_for_C_4_tr0[0:0]),
      .S1_OUTER_LOOP_C_0_tr0(nl_hybrid_core_core_fsm_inst_S1_OUTER_LOOP_C_0_tr0[0:0]),
      .S2_COPY_LOOP_for_C_3_tr0(nl_hybrid_core_core_fsm_inst_S2_COPY_LOOP_for_C_3_tr0[0:0]),
      .S2_COPY_LOOP_C_0_tr0(nl_hybrid_core_core_fsm_inst_S2_COPY_LOOP_C_0_tr0[0:0]),
      .S2_INNER_LOOP1_for_C_23_tr0(nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP1_for_C_23_tr0[0:0]),
      .S2_INNER_LOOP1_C_0_tr0(nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP1_C_0_tr0[0:0]),
      .S2_INNER_LOOP2_for_C_23_tr0(nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_for_C_23_tr0[0:0]),
      .S2_INNER_LOOP2_C_0_tr0(nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_C_0_tr0[0:0]),
      .S2_INNER_LOOP2_C_0_tr1(nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP2_C_0_tr1[0:0]),
      .S2_INNER_LOOP3_for_C_23_tr0(nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP3_for_C_23_tr0[0:0]),
      .S2_INNER_LOOP3_C_0_tr0(nl_hybrid_core_core_fsm_inst_S2_INNER_LOOP3_C_0_tr0[0:0]),
      .S34_OUTER_LOOP_for_C_12_tr0(nl_hybrid_core_core_fsm_inst_S34_OUTER_LOOP_for_C_12_tr0[0:0]),
      .S34_OUTER_LOOP_C_0_tr0(nl_hybrid_core_core_fsm_inst_S34_OUTER_LOOP_C_0_tr0[0:0]),
      .S5_COPY_LOOP_for_C_3_tr0(nl_hybrid_core_core_fsm_inst_S5_COPY_LOOP_for_C_3_tr0[0:0]),
      .S5_COPY_LOOP_C_0_tr0(nl_hybrid_core_core_fsm_inst_S5_COPY_LOOP_C_0_tr0[0:0]),
      .S5_INNER_LOOP1_for_C_23_tr0(nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP1_for_C_23_tr0[0:0]),
      .S5_INNER_LOOP1_C_0_tr0(nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP1_C_0_tr0[0:0]),
      .S5_INNER_LOOP2_for_C_23_tr0(nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_for_C_23_tr0[0:0]),
      .S5_INNER_LOOP2_C_0_tr0(nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_C_0_tr0[0:0]),
      .S5_INNER_LOOP2_C_0_tr1(nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP2_C_0_tr1[0:0]),
      .S5_INNER_LOOP3_for_C_23_tr0(nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP3_for_C_23_tr0[0:0]),
      .S5_INNER_LOOP3_C_0_tr0(nl_hybrid_core_core_fsm_inst_S5_INNER_LOOP3_C_0_tr0[0:0]),
      .S6_OUTER_LOOP_for_C_3_tr0(nl_hybrid_core_core_fsm_inst_S6_OUTER_LOOP_for_C_3_tr0[0:0]),
      .S6_OUTER_LOOP_C_0_tr0(nl_hybrid_core_core_fsm_inst_S6_OUTER_LOOP_C_0_tr0[0:0])
    );
  assign S34_OUTER_LOOP_for_tf_mul_cmp_b = {S34_OUTER_LOOP_for_k_slc_S34_OUTER_LOOP_for_k_sva_19_5_4_0_1
      , S34_OUTER_LOOP_for_k_sva_4_0};
  assign and_407_cse = (fsm_output[5:4]==2'b11);
  assign mux_28_cse = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[7]);
  assign or_814_cse = (fsm_output[1:0]!=2'b00);
  assign mux_51_cse = MUX_s_1_2_2(or_819_cse, or_353_cse, fsm_output[5]);
  assign nand_8_cse = ~((fsm_output[1:0]==2'b11) & (~ mux_290_cse));
  assign nor_270_nl = ~(and_370_cse | (~ (fsm_output[7])) | (fsm_output[5]));
  assign mux_80_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[7]);
  assign mux_81_nl = MUX_s_1_2_2(nor_270_nl, mux_80_nl, fsm_output[4]);
  assign nor_271_nl = ~((~((fsm_output[0]) | (fsm_output[7]))) | (fsm_output[5]));
  assign and_412_nl = (~(((~ (fsm_output[0])) | (fsm_output[2])) & (fsm_output[7])))
      & (fsm_output[5]);
  assign mux_79_nl = MUX_s_1_2_2(nor_271_nl, and_412_nl, fsm_output[4]);
  assign mux_82_nl = MUX_s_1_2_2(mux_81_nl, mux_79_nl, fsm_output[3]);
  assign mux_77_nl = MUX_s_1_2_2(or_tmp_2, (fsm_output[7]), fsm_output[2]);
  assign nor_274_nl = ~((fsm_output[4]) | mux_77_nl);
  assign nor_275_nl = ~((fsm_output[0]) | (fsm_output[2]) | (fsm_output[7]));
  assign nor_276_nl = ~((~ (fsm_output[2])) | (fsm_output[7]) | (~ (fsm_output[5])));
  assign mux_76_nl = MUX_s_1_2_2(nor_275_nl, nor_276_nl, fsm_output[4]);
  assign mux_78_nl = MUX_s_1_2_2(nor_274_nl, mux_76_nl, fsm_output[3]);
  assign mux_83_nl = MUX_s_1_2_2(mux_82_nl, mux_78_nl, fsm_output[6]);
  assign nor_277_nl = ~(nor_64_cse | (~ (fsm_output[7])) | (fsm_output[5]));
  assign mux_72_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), or_301_cse);
  assign mux_73_nl = MUX_s_1_2_2(nor_277_nl, mux_72_nl, fsm_output[4]);
  assign nor_278_nl = ~((~ (fsm_output[7])) | (fsm_output[5]));
  assign mux_69_nl = MUX_s_1_2_2(nor_278_nl, or_44_cse, fsm_output[2]);
  assign mux_70_nl = MUX_s_1_2_2((~ (fsm_output[5])), mux_69_nl, fsm_output[0]);
  assign and_413_nl = nand_119_cse & (fsm_output[5]);
  assign nor_280_nl = ~((fsm_output[2]) | (~ (fsm_output[5])));
  assign mux_68_nl = MUX_s_1_2_2(and_413_nl, nor_280_nl, fsm_output[0]);
  assign mux_71_nl = MUX_s_1_2_2(mux_70_nl, mux_68_nl, fsm_output[4]);
  assign mux_74_nl = MUX_s_1_2_2(mux_73_nl, mux_71_nl, fsm_output[3]);
  assign mux_66_nl = MUX_s_1_2_2(or_tmp_2, (fsm_output[7]), fsm_output[0]);
  assign nor_281_nl = ~((fsm_output[4]) | mux_66_nl);
  assign and_414_nl = (fsm_output[4]) & (fsm_output[2]) & (~ (fsm_output[7])) & (fsm_output[5]);
  assign mux_67_nl = MUX_s_1_2_2(nor_281_nl, and_414_nl, fsm_output[3]);
  assign mux_75_nl = MUX_s_1_2_2(mux_74_nl, mux_67_nl, fsm_output[6]);
  assign mux_84_rmff = MUX_s_1_2_2(mux_83_nl, mux_75_nl, fsm_output[1]);
  assign or_165_cse = (fsm_output[7]) | (fsm_output[3]);
  assign or_187_nl = (~((fsm_output[2]) | (fsm_output[5]))) | (fsm_output[6]);
  assign mux_158_nl = MUX_s_1_2_2(or_tmp_163, or_397_cse, fsm_output[2]);
  assign mux_159_nl = MUX_s_1_2_2(or_187_nl, mux_158_nl, fsm_output[0]);
  assign mux_160_nl = MUX_s_1_2_2(mux_159_nl, (~ (fsm_output[6])), fsm_output[4]);
  assign nor_253_nl = ~(nor_254_cse | (fsm_output[6]));
  assign mux_156_nl = MUX_s_1_2_2(nor_253_nl, (fsm_output[5]), fsm_output[0]);
  assign mux_155_nl = MUX_s_1_2_2(or_tmp_162, mux_tmp_148, fsm_output[0]);
  assign mux_157_nl = MUX_s_1_2_2((~ mux_156_nl), mux_155_nl, fsm_output[4]);
  assign mux_161_nl = MUX_s_1_2_2(mux_160_nl, mux_157_nl, fsm_output[3]);
  assign or_183_nl = (fsm_output[2]) | (~ (fsm_output[5])) | (fsm_output[6]);
  assign mux_152_nl = MUX_s_1_2_2(or_183_nl, (fsm_output[6]), fsm_output[0]);
  assign nand_135_nl = ~(nand_136_cse & (fsm_output[6]));
  assign mux_153_nl = MUX_s_1_2_2(mux_152_nl, nand_135_nl, fsm_output[4]);
  assign mux_149_nl = MUX_s_1_2_2((~ or_tmp_163), or_397_cse, fsm_output[2]);
  assign mux_150_nl = MUX_s_1_2_2((fsm_output[5]), mux_149_nl, fsm_output[0]);
  assign mux_151_nl = MUX_s_1_2_2((~ mux_150_nl), mux_tmp_148, fsm_output[4]);
  assign mux_154_nl = MUX_s_1_2_2(mux_153_nl, mux_151_nl, fsm_output[3]);
  assign mux_162_nl = MUX_s_1_2_2(mux_161_nl, mux_154_nl, fsm_output[1]);
  assign or_180_nl = (fsm_output[6:4]!=3'b010);
  assign or_179_nl = (fsm_output[0]) | (fsm_output[2]) | (~ (fsm_output[5])) | (fsm_output[6]);
  assign mux_145_nl = MUX_s_1_2_2(or_179_nl, or_397_cse, fsm_output[4]);
  assign mux_146_nl = MUX_s_1_2_2(or_180_nl, mux_145_nl, fsm_output[3]);
  assign mux_143_nl = MUX_s_1_2_2(or_tmp_163, or_tmp_162, fsm_output[4]);
  assign nand_16_nl = ~((fsm_output[4]) & (~(and_370_cse | (fsm_output[6:5]!=2'b00))));
  assign mux_144_nl = MUX_s_1_2_2(mux_143_nl, nand_16_nl, fsm_output[3]);
  assign mux_147_nl = MUX_s_1_2_2(mux_146_nl, mux_144_nl, fsm_output[1]);
  assign mux_163_itm = MUX_s_1_2_2(mux_162_nl, mux_147_nl, fsm_output[7]);
  assign or_242_cse = (fsm_output[4:3]!=2'b00);
  assign and_188_rmff = (and_371_cse ^ (fsm_output[2])) & (fsm_output[7:3]==5'b01011);
  assign mux_218_nl = MUX_s_1_2_2((~ nor_tmp_37), or_tmp_237, fsm_output[6]);
  assign mux_219_nl = MUX_s_1_2_2(mux_218_nl, mux_tmp_212, fsm_output[1]);
  assign mux_220_nl = MUX_s_1_2_2(mux_219_nl, mux_tmp_210, fsm_output[4]);
  assign mux_215_nl = MUX_s_1_2_2(or_tmp_2, or_tmp_237, fsm_output[6]);
  assign mux_216_nl = MUX_s_1_2_2(mux_5_cse, mux_215_nl, fsm_output[1]);
  assign mux_217_nl = MUX_s_1_2_2(mux_tmp_206, mux_216_nl, fsm_output[4]);
  assign mux_221_nl = MUX_s_1_2_2(mux_220_nl, mux_217_nl, fsm_output[3]);
  assign mux_211_nl = MUX_s_1_2_2(mux_tmp_210, mux_5_cse, fsm_output[1]);
  assign mux_213_nl = MUX_s_1_2_2(mux_tmp_212, mux_211_nl, fsm_output[4]);
  assign or_247_nl = (~((~ (fsm_output[0])) | (fsm_output[5]))) | (fsm_output[7]);
  assign mux_205_nl = MUX_s_1_2_2(nor_tmp_37, or_247_nl, fsm_output[6]);
  assign mux_207_nl = MUX_s_1_2_2(mux_tmp_206, mux_205_nl, fsm_output[1]);
  assign mux_208_nl = MUX_s_1_2_2(mux_207_nl, or_39_cse, fsm_output[4]);
  assign mux_214_nl = MUX_s_1_2_2(mux_213_nl, mux_208_nl, fsm_output[3]);
  assign mux_222_itm = MUX_s_1_2_2(mux_221_nl, mux_214_nl, fsm_output[2]);
  assign or_270_cse = (fsm_output[0]) | (~ (fsm_output[6])) | (fsm_output[5]) | (fsm_output[7])
      | (~ (fsm_output[3]));
  assign or_819_cse = (fsm_output[7:6]!=2'b01);
  assign nand_121_cse = ~((fsm_output[3]) & (fsm_output[5]));
  assign or_301_cse = (fsm_output[7]) | (fsm_output[2]);
  assign nand_119_cse = ~((fsm_output[7]) & (fsm_output[2]));
  assign or_310_cse = (~ (fsm_output[1])) | (fsm_output[7]) | (~ (fsm_output[0]))
      | (fsm_output[6]);
  assign or_820_cse = (~ (fsm_output[1])) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign or_253_cse = (~ (fsm_output[1])) | (fsm_output[7]) | (fsm_output[6]);
  assign or_350_cse = (fsm_output[7:5]!=3'b011);
  assign or_352_cse = (fsm_output[7:6]!=2'b00);
  assign or_353_cse = (fsm_output[7:6]!=2'b10);
  assign mux_290_cse = MUX_s_1_2_2(or_353_cse, or_352_cse, fsm_output[5]);
  assign and_372_cse = (fsm_output[7:6]==2'b11);
  assign and_373_cse_1 = (fsm_output[3:2]==2'b11);
  assign mux_13_nl = MUX_s_1_2_2(mux_tmp_10, nand_tmp_2, fsm_output[3]);
  assign mux_310_nl = MUX_s_1_2_2(mux_tmp_10, nand_tmp_2, fsm_output[1]);
  assign mux_311_nl = MUX_s_1_2_2(mux_310_nl, mux_556_cse, fsm_output[3]);
  assign mux_313_itm = MUX_s_1_2_2(mux_13_nl, mux_311_nl, fsm_output[2]);
  assign or_380_nl = (fsm_output[2]) | mux_tmp_314;
  assign or_378_nl = (fsm_output[3]) | (~ (fsm_output[1])) | (fsm_output[4]) | mux_556_cse;
  assign mux_315_nl = MUX_s_1_2_2(mux_tmp_314, or_378_nl, fsm_output[2]);
  assign mux_316_nl = MUX_s_1_2_2(or_380_nl, mux_315_nl, S1_OUTER_LOOP_k_5_0_sva_2[5]);
  assign S2_COPY_LOOP_p_or_1_seb = mux_316_nl | (fsm_output[0]);
  assign or_39_cse = (fsm_output[7:5]!=3'b010);
  assign or_44_cse = (fsm_output[7]) | (~ (fsm_output[5]));
  assign and_371_cse = (fsm_output[1:0]==2'b11);
  assign and_370_cse = (fsm_output[0]) & (fsm_output[2]);
  assign nand_130_cse = ~((fsm_output[7]) & (fsm_output[5]));
  assign or_397_cse = (fsm_output[6:5]!=2'b00);
  assign and_400_cse = (fsm_output[2:1]==2'b11);
  assign mux_5_cse = MUX_s_1_2_2(or_tmp_2, or_44_cse, fsm_output[6]);
  assign mux_337_cse = MUX_s_1_2_2((fsm_output[6]), (fsm_output[7]), fsm_output[5]);
  assign or_52_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[4]) | (fsm_output[5])
      | (fsm_output[7]);
  assign mux_47_nl = MUX_s_1_2_2(or_52_nl, or_tmp_40, fsm_output[3]);
  assign S1_OUTER_LOOP_k_or_nl = ((~ mux_47_nl) & (~ (fsm_output[6])) & (fsm_output[2]))
      | and_dcpl_29;
  assign S1_OUTER_LOOP_k_S1_OUTER_LOOP_k_mux_nl = MUX_v_5_2_2((S1_OUTER_LOOP_for_p_sva_1[4:0]),
      (S1_OUTER_LOOP_k_5_0_sva_2[4:0]), S1_OUTER_LOOP_k_or_nl);
  assign mux_36_nl = MUX_s_1_2_2(or_350_cse, mux_5_cse, fsm_output[1]);
  assign nand_5_nl = ~((fsm_output[1]) & (~ mux_5_cse));
  assign mux_37_nl = MUX_s_1_2_2(mux_36_nl, nand_5_nl, fsm_output[2]);
  assign or_35_nl = and_400_cse | mux_5_cse;
  assign mux_38_nl = MUX_s_1_2_2(mux_37_nl, or_35_nl, fsm_output[0]);
  assign nor_330_nl = ~((fsm_output[4]) | mux_38_nl);
  assign nand_3_nl = ~((fsm_output[1]) & (~ mux_tmp_1));
  assign mux_33_nl = MUX_s_1_2_2(mux_tmp_1, or_39_cse, fsm_output[1]);
  assign or_31_nl = (fsm_output[0]) | (fsm_output[2]);
  assign mux_34_nl = MUX_s_1_2_2(nand_3_nl, mux_33_nl, or_31_nl);
  assign and_418_nl = (fsm_output[4]) & (~ mux_34_nl);
  assign mux_39_nl = MUX_s_1_2_2(nor_330_nl, and_418_nl, fsm_output[3]);
  assign S1_OUTER_LOOP_for_p_asn_S2_COPY_LOOP_for_i_5_0_sva_2_4_S1_OUTER_LOOP_k_and_nl
      = MUX_v_5_2_2(5'b00000, S1_OUTER_LOOP_k_S1_OUTER_LOOP_k_mux_nl, mux_39_nl);
  assign nl_S2_INNER_LOOP1_for_acc_nl = conv_u2s_5_6(S1_OUTER_LOOP_for_acc_cse_sva)
      + 6'b000001;
  assign S2_INNER_LOOP1_for_acc_nl = nl_S2_INNER_LOOP1_for_acc_nl[5:0];
  assign or_390_nl = (fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | mux_51_cse;
  assign nand_35_nl = ~((fsm_output[1:0]==2'b11) & (~ mux_337_cse));
  assign or_810_nl = (fsm_output[1:0]!=2'b01) | mux_556_cse;
  assign mux_338_nl = MUX_s_1_2_2(nand_35_nl, or_810_nl, fsm_output[3]);
  assign mux_339_nl = MUX_s_1_2_2(or_390_nl, mux_338_nl, fsm_output[2]);
  assign nor_308_nl = ~(mux_339_nl | (fsm_output[4]));
  assign S2_COPY_LOOP_for_i_S2_COPY_LOOP_for_i_mux_rgt = MUX_v_6_2_2(({1'b0 , S1_OUTER_LOOP_for_p_asn_S2_COPY_LOOP_for_i_5_0_sva_2_4_S1_OUTER_LOOP_k_and_nl}),
      S2_INNER_LOOP1_for_acc_nl, nor_308_nl);
  assign mux_712_cse = MUX_s_1_2_2(mux_556_cse, mux_337_cse, fsm_output[0]);
  assign nand_166_cse = ~((fsm_output[0]) & (~ mux_556_cse));
  assign nor_64_cse = ~((fsm_output[0]) | (~ (fsm_output[2])));
  assign or_471_cse = (fsm_output[3]) | (fsm_output[7]) | (fsm_output[5]);
  assign nand_59_cse = ~((fsm_output[4]) & (~ mux_290_cse));
  assign or_502_nl = (~ (fsm_output[3])) | (fsm_output[1]);
  assign mux_434_cse = MUX_s_1_2_2(or_502_nl, or_tmp_59, fsm_output[2]);
  assign and_222_nl = (~ mux_434_cse) & xor_dcpl & and_dcpl_55;
  assign butterFly_tw_butterFly_tw_mux_rgt = MUX_v_2_2_2(butterFly_tw_and_cse_3_2_sva_1,
      ({1'b0 , butterFly_4_tw_and_cse_2_sva_mx0w2}), and_222_nl);
  assign or_563_cse = (fsm_output[0]) | (fsm_output[4]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign nand_108_cse = ~((fsm_output[5:4]==2'b11));
  assign or_618_nl = (fsm_output[5:4]!=2'b00);
  assign mux_525_nl = MUX_s_1_2_2(nand_108_cse, or_618_nl, fsm_output[2]);
  assign nor_327_nl = ~((~ (fsm_output[6])) | (fsm_output[0]) | (fsm_output[3]) |
      (fsm_output[7]) | mux_525_nl);
  assign nor_126_nl = ~((fsm_output[2]) | (~ (fsm_output[5])) | (fsm_output[4]));
  assign nor_127_nl = ~((fsm_output[2]) | (fsm_output[5]) | (fsm_output[4]));
  assign mux_523_nl = MUX_s_1_2_2(nor_126_nl, nor_127_nl, fsm_output[7]);
  assign nand_79_nl = ~((fsm_output[3]) & mux_523_nl);
  assign or_613_nl = (~ (fsm_output[7])) | (fsm_output[2]) | (~ (fsm_output[5]))
      | (fsm_output[4]);
  assign or_612_nl = (fsm_output[7]) | (~ (fsm_output[2])) | (fsm_output[5]) | (fsm_output[4]);
  assign mux_522_nl = MUX_s_1_2_2(or_613_nl, or_612_nl, fsm_output[3]);
  assign mux_524_nl = MUX_s_1_2_2(nand_79_nl, mux_522_nl, fsm_output[0]);
  assign nor_328_nl = ~((fsm_output[6]) | mux_524_nl);
  assign mux_526_cse = MUX_s_1_2_2(nor_327_nl, nor_328_nl, fsm_output[1]);
  assign mux_556_cse = MUX_s_1_2_2(or_352_cse, or_819_cse, fsm_output[5]);
  assign nand_102_cse = ~((fsm_output[5]) & (fsm_output[7]) & (fsm_output[2]));
  assign or_718_cse = (~ (fsm_output[3])) | (fsm_output[5]);
  assign nor_285_cse = ~((fsm_output[1:0]!=2'b00));
  assign butterFly_4_tw_and_cse_2_sva_mx0w2 = (reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[2])
      & (S2_INNER_LOOP1_r_4_2_sva_1_0[0]);
  assign nand_136_cse = ~((fsm_output[2]) & (fsm_output[5]));
  assign nor_254_cse = ~((~ (fsm_output[2])) | (fsm_output[5]));
  assign nl_S1_OUTER_LOOP_k_5_0_sva_2 = conv_u2s_5_6({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg
      , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg})
      + 6'b000001;
  assign S1_OUTER_LOOP_k_5_0_sva_2 = nl_S1_OUTER_LOOP_k_5_0_sva_2[5:0];
  assign butterFly_tw_and_cse_3_2_sva_1 = ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg
      , (reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[2])}) & S2_INNER_LOOP1_r_4_2_sva_1_0;
  assign nl_modulo_add_3_mux_itm_mx0w1 = modulo_add_base_1_sva - m_sva;
  assign modulo_add_3_mux_itm_mx0w1 = nl_modulo_add_3_mux_itm_mx0w1[31:0];
  assign nl_modulo_add_base_3_sva_mx0w1 = butterFly_14_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_3_sva_mx0w1 = nl_modulo_add_base_3_sva_mx0w1[31:0];
  assign nl_modulo_add_base_sva_mx0w2 = butterFly_15_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_sva_mx0w2 = nl_modulo_add_base_sva_mx0w2[31:0];
  assign nl_modulo_add_base_1_sva_mx0w3 = butterFly_10_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_1_sva_mx0w3 = nl_modulo_add_base_1_sva_mx0w3[31:0];
  assign nl_modulo_add_base_2_sva_mx0w4 = butterFly_11_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_2_sva_mx0w4 = nl_modulo_add_base_2_sva_mx0w4[31:0];
  assign nl_modulo_add_base_7_sva_mx0w5 = butterFly_15_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_7_sva_mx0w5 = nl_modulo_add_base_7_sva_mx0w5[31:0];
  assign nl_modulo_add_base_4_sva_mx0w6 = butterFly_10_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_4_sva_mx0w6 = nl_modulo_add_base_4_sva_mx0w6[31:0];
  assign nl_modulo_add_base_5_sva_mx0w7 = butterFly_11_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_5_sva_mx0w7 = nl_modulo_add_base_5_sva_mx0w7[31:0];
  assign nl_modulo_add_base_6_sva_mx0w8 = butterFly_14_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_6_sva_mx0w8 = nl_modulo_add_base_6_sva_mx0w8[31:0];
  assign nl_modulo_add_base_11_sva_mx0w9 = butterFly_11_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_11_sva_mx0w9 = nl_modulo_add_base_11_sva_mx0w9[31:0];
  assign nl_modulo_add_base_8_sva_mx0w10 = butterFly_14_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_8_sva_mx0w10 = nl_modulo_add_base_8_sva_mx0w10[31:0];
  assign nl_modulo_add_base_9_sva_mx0w11 = butterFly_15_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_9_sva_mx0w11 = nl_modulo_add_base_9_sva_mx0w11[31:0];
  assign nl_modulo_add_base_10_sva_mx0w12 = butterFly_10_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_10_sva_mx0w12 = nl_modulo_add_base_10_sva_mx0w12[31:0];
  assign nl_modulo_add_base_15_sva_mx0w13 = butterFly_15_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_15_sva_mx0w13 = nl_modulo_add_base_15_sva_mx0w13[31:0];
  assign nl_modulo_add_base_12_sva_mx0w14 = butterFly_10_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_12_sva_mx0w14 = nl_modulo_add_base_12_sva_mx0w14[31:0];
  assign nl_modulo_add_base_13_sva_mx0w15 = butterFly_11_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_13_sva_mx0w15 = nl_modulo_add_base_13_sva_mx0w15[31:0];
  assign nl_modulo_add_base_14_sva_mx0w16 = butterFly_14_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_14_sva_mx0w16 = nl_modulo_add_base_14_sva_mx0w16[31:0];
  assign nl_modulo_add_base_19_sva_mx0w17 = butterFly_15_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_19_sva_mx0w17 = nl_modulo_add_base_19_sva_mx0w17[31:0];
  assign nl_modulo_add_base_16_sva_mx0w18 = butterFly_10_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_16_sva_mx0w18 = nl_modulo_add_base_16_sva_mx0w18[31:0];
  assign nl_modulo_add_base_17_sva_mx0w19 = butterFly_11_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_17_sva_mx0w19 = nl_modulo_add_base_17_sva_mx0w19[31:0];
  assign nl_modulo_add_base_18_sva_mx0w20 = butterFly_14_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_18_sva_mx0w20 = nl_modulo_add_base_18_sva_mx0w20[31:0];
  assign nl_modulo_add_base_23_sva_mx0w21 = butterFly_15_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_23_sva_mx0w21 = nl_modulo_add_base_23_sva_mx0w21[31:0];
  assign nl_modulo_add_base_20_sva_mx0w22 = butterFly_10_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_20_sva_mx0w22 = nl_modulo_add_base_20_sva_mx0w22[31:0];
  assign nl_modulo_add_base_21_sva_mx0w23 = butterFly_11_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_21_sva_mx0w23 = nl_modulo_add_base_21_sva_mx0w23[31:0];
  assign nl_modulo_add_base_22_sva_mx0w24 = butterFly_14_f1_sva + reg_mult_3_res_lpi_4_dfm_cse_1;
  assign modulo_add_base_22_sva_mx0w24 = nl_modulo_add_base_22_sva_mx0w24[31:0];
  assign nl_operator_20_true_1_acc_1_nl = (z_out_2[19:5]) + 15'b111111111111111;
  assign operator_20_true_1_acc_1_nl = nl_operator_20_true_1_acc_1_nl[14:0];
  assign operator_20_true_1_acc_1_itm_14 = readslicef_15_1_14(operator_20_true_1_acc_1_nl);
  assign or_tmp_2 = (fsm_output[7]) | (fsm_output[5]);
  assign mux_tmp_1 = MUX_s_1_2_2(nand_130_cse, or_tmp_2, fsm_output[6]);
  assign xor_dcpl = (fsm_output[7]) ^ (fsm_output[5]);
  assign nand_tmp_2 = ~((fsm_output[4]) & (~ mux_556_cse));
  assign mux_tmp_10 = MUX_s_1_2_2(mux_290_cse, mux_556_cse, fsm_output[4]);
  assign and_19_cse = (z_out_2[2]) & S2_OUTER_LOOP_c_1_sva;
  assign nor_tmp_16 = (fsm_output[0]) & (fsm_output[4]) & (fsm_output[5]) & (fsm_output[7]);
  assign or_tmp_40 = (fsm_output[1]) | (~ nor_tmp_16);
  assign and_dcpl_23 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_24 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_25 = and_dcpl_24 & and_dcpl_23;
  assign and_dcpl_26 = (fsm_output[5:4]==2'b10);
  assign and_dcpl_27 = (fsm_output[7:6]==2'b01);
  assign and_dcpl_28 = and_dcpl_27 & and_dcpl_26;
  assign and_dcpl_29 = and_dcpl_28 & and_dcpl_25;
  assign and_dcpl_30 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_31 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_33 = ~((fsm_output[7:6]!=2'b00));
  assign and_dcpl_36 = (fsm_output[1]) & (fsm_output[3]);
  assign and_dcpl_39 = (fsm_output[7:6]==2'b10);
  assign and_dcpl_40 = and_dcpl_39 & and_407_cse;
  assign and_dcpl_42 = and_dcpl_24 & and_dcpl_30;
  assign and_dcpl_43 = and_dcpl_33 & and_dcpl_31;
  assign and_dcpl_44 = and_dcpl_43 & and_dcpl_42;
  assign and_dcpl_45 = (fsm_output[3:2]==2'b10);
  assign and_dcpl_47 = and_371_cse & and_dcpl_45;
  assign and_dcpl_48 = and_dcpl_40 & and_dcpl_47;
  assign and_dcpl_50 = ~((fsm_output[7]) | (fsm_output[4]));
  assign or_tmp_53 = (fsm_output[1:0]!=2'b00) | mux_290_cse;
  assign and_dcpl_54 = and_371_cse & and_dcpl_23;
  assign and_dcpl_55 = ~((fsm_output[6]) | (fsm_output[4]));
  assign and_dcpl_59 = nor_285_cse & and_dcpl_45;
  assign and_dcpl_61 = ~((fsm_output[1]) | (fsm_output[3]));
  assign and_dcpl_63 = ~(mux_51_cse | (fsm_output[4]));
  assign and_dcpl_65 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_66 = and_dcpl_65 & and_373_cse_1;
  assign and_dcpl_67 = xor_dcpl_2 & and_dcpl_50;
  assign and_dcpl_68 = and_dcpl_67 & and_dcpl_66;
  assign nor_284_cse = ~((~ (fsm_output[3])) | (~ (fsm_output[1])) | (fsm_output[4]));
  assign nor_283_nl = ~((fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (~
      (fsm_output[4])));
  assign mux_61_nl = MUX_s_1_2_2(nor_283_nl, nor_284_cse, fsm_output[2]);
  assign and_dcpl_70 = mux_61_nl & (~ (fsm_output[7])) & xor_dcpl_2;
  assign or_dcpl_12 = ~((fsm_output[1:0]==2'b11));
  assign and_dcpl_76 = ~(mux_51_cse | (fsm_output[4:2]!=3'b000));
  assign or_tmp_58 = (fsm_output[0]) | mux_51_cse;
  assign and_dcpl_80 = and_dcpl_65 & and_dcpl_45;
  assign or_tmp_59 = (fsm_output[3]) | or_dcpl_12;
  assign and_dcpl_88 = and_dcpl_24 & and_dcpl_45;
  assign and_dcpl_89 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_90 = and_dcpl_27 & and_dcpl_89;
  assign and_dcpl_91 = and_dcpl_90 & and_dcpl_88;
  assign and_dcpl_92 = and_dcpl_43 & and_dcpl_80;
  assign and_dcpl_93 = and_dcpl_33 & and_407_cse;
  assign and_dcpl_94 = and_dcpl_93 & and_dcpl_25;
  assign and_dcpl_95 = and_dcpl_93 & and_dcpl_54;
  assign or_tmp_79 = (~ (fsm_output[0])) | (fsm_output[6]);
  assign and_dcpl_97 = nor_285_cse & and_373_cse_1;
  assign not_tmp_72 = ~((fsm_output[4]) & (fsm_output[5]) & (fsm_output[7]));
  assign or_825_nl = (fsm_output[3]) | (~ (fsm_output[1])) | (~ (fsm_output[0]))
      | (fsm_output[4]) | (fsm_output[5]) | (~ (fsm_output[7]));
  assign or_826_nl = (fsm_output[1:0]!=2'b10) | not_tmp_72;
  assign or_827_nl = (fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[4]))
      | (~ (fsm_output[5])) | (fsm_output[7]);
  assign mux_91_nl = MUX_s_1_2_2(or_826_nl, or_827_nl, fsm_output[3]);
  assign mux_92_nl = MUX_s_1_2_2(or_825_nl, mux_91_nl, fsm_output[2]);
  assign and_dcpl_99 = ~(mux_92_nl | (fsm_output[6]));
  assign and_dcpl_100 = and_371_cse & and_dcpl_30;
  assign and_dcpl_101 = and_dcpl_28 & and_dcpl_100;
  assign and_dcpl_102 = nor_285_cse & and_dcpl_23;
  assign and_dcpl_103 = and_dcpl_28 & and_dcpl_102;
  assign and_dcpl_104 = and_dcpl_27 & and_407_cse;
  assign and_dcpl_105 = and_dcpl_104 & and_dcpl_97;
  assign and_dcpl_106 = and_dcpl_104 & and_dcpl_66;
  assign and_dcpl_107 = nor_285_cse & and_dcpl_30;
  assign and_dcpl_108 = and_dcpl_39 & and_dcpl_31;
  assign and_dcpl_111 = and_371_cse & and_373_cse_1;
  assign and_dcpl_112 = and_dcpl_39 & and_dcpl_26;
  assign and_dcpl_113 = and_dcpl_112 & and_dcpl_111;
  assign and_dcpl_114 = and_dcpl_40 & and_dcpl_107;
  assign and_dcpl_116 = and_dcpl_65 & and_dcpl_23;
  assign or_tmp_90 = (fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[7]) | (fsm_output[6]);
  assign or_107_nl = (fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (fsm_output[7])
      | (~ (fsm_output[6]));
  assign nand_127_nl = ~((fsm_output[1]) & (fsm_output[0]) & (fsm_output[7]) & (~
      (fsm_output[6])));
  assign mux_93_nl = MUX_s_1_2_2(nand_127_nl, or_tmp_90, fsm_output[3]);
  assign mux_94_itm = MUX_s_1_2_2(or_107_nl, mux_93_nl, fsm_output[2]);
  assign or_tmp_97 = (fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[7]) | (~
      (fsm_output[6]));
  assign or_109_nl = (fsm_output[1]) | (fsm_output[0]) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_95_nl = MUX_s_1_2_2(or_tmp_97, or_109_nl, fsm_output[3]);
  assign or_108_nl = (~ (fsm_output[3])) | (~ (fsm_output[1])) | (fsm_output[0])
      | (fsm_output[7]) | (fsm_output[6]);
  assign mux_96_itm = MUX_s_1_2_2(mux_95_nl, or_108_nl, fsm_output[2]);
  assign or_tmp_99 = (fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[7]))
      | (fsm_output[6]);
  assign or_115_cse = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[7]) | (~
      (fsm_output[6]));
  assign mux_97_nl = MUX_s_1_2_2(or_115_cse, or_tmp_99, fsm_output[3]);
  assign or_112_nl = (~ (fsm_output[3])) | (~ (fsm_output[1])) | (~ (fsm_output[0]))
      | (fsm_output[7]) | (fsm_output[6]);
  assign mux_98_itm = MUX_s_1_2_2(mux_97_nl, or_112_nl, fsm_output[2]);
  assign or_tmp_102 = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[4]) | (~
      (fsm_output[7])) | (fsm_output[6]);
  assign or_tmp_104 = (~ (fsm_output[0])) | (fsm_output[4]) | (fsm_output[7]) | (~
      (fsm_output[6]));
  assign or_119_nl = (fsm_output[0]) | (~ (fsm_output[4])) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_tmp_99 = MUX_s_1_2_2(or_119_nl, or_tmp_104, fsm_output[1]);
  assign mux_100_itm = MUX_s_1_2_2(mux_tmp_99, or_tmp_102, fsm_output[3]);
  assign or_tmp_110 = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4]) | (~ (fsm_output[7]))
      | (fsm_output[6]);
  assign or_tmp_112 = (fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[4]) | (fsm_output[7])
      | (~ (fsm_output[6]));
  assign or_tmp_114 = (fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[4]) | (~
      (fsm_output[7])) | (fsm_output[6]);
  assign or_tmp_117 = (fsm_output[3]) | (~ (fsm_output[1])) | (~ (fsm_output[0]))
      | (~ (fsm_output[4])) | (fsm_output[7]) | (fsm_output[6]);
  assign and_dcpl_126 = (~ (fsm_output[5])) & (fsm_output[2]);
  assign and_dcpl_129 = and_dcpl_40 & and_dcpl_80;
  assign and_dcpl_131 = (fsm_output[5]) & (fsm_output[2]);
  assign or_tmp_118 = (~ (fsm_output[0])) | (fsm_output[4]) | (~ (fsm_output[7]))
      | (fsm_output[6]);
  assign or_134_nl = (fsm_output[0]) | (~ (fsm_output[4])) | (fsm_output[7]) | (~
      (fsm_output[6]));
  assign mux_tmp_107 = MUX_s_1_2_2(or_134_nl, or_tmp_118, fsm_output[1]);
  assign or_tmp_121 = (~ (fsm_output[1])) | (fsm_output[0]) | (~ (fsm_output[4]))
      | (fsm_output[7]) | (fsm_output[6]);
  assign or_137_nl = (fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (~ (fsm_output[7]))
      | (fsm_output[6]);
  assign mux_109_nl = MUX_s_1_2_2(or_310_cse, or_tmp_97, fsm_output[3]);
  assign mux_110_itm = MUX_s_1_2_2(or_137_nl, mux_109_nl, fsm_output[2]);
  assign or_140_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_111_nl = MUX_s_1_2_2(or_tmp_99, or_140_nl, fsm_output[3]);
  assign or_139_nl = (~ (fsm_output[3])) | (~ (fsm_output[1])) | (fsm_output[0])
      | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_112_itm = MUX_s_1_2_2(mux_111_nl, or_139_nl, fsm_output[2]);
  assign or_143_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (~ (fsm_output[7]))
      | (fsm_output[6]);
  assign mux_113_nl = MUX_s_1_2_2(or_143_nl, or_tmp_90, fsm_output[3]);
  assign nand_139_nl = ~((fsm_output[3]) & (fsm_output[1]) & (fsm_output[0]) & (~
      (fsm_output[7])) & (fsm_output[6]));
  assign mux_114_itm = MUX_s_1_2_2(mux_113_nl, nand_139_nl, fsm_output[2]);
  assign or_tmp_145 = (fsm_output[3]) | (fsm_output[6]);
  assign or_tmp_152 = (fsm_output[5]) | (fsm_output[3]);
  assign or_172_nl = (~ (fsm_output[7])) | (fsm_output[5]) | (~ (fsm_output[3]));
  assign mux_tmp_133 = MUX_s_1_2_2(or_172_nl, or_471_cse, fsm_output[6]);
  assign or_169_nl = (fsm_output[6]) | (fsm_output[7]) | (fsm_output[5]) | (fsm_output[3]);
  assign mux_tmp_134 = MUX_s_1_2_2(mux_tmp_133, or_169_nl, fsm_output[4]);
  assign mux_137_nl = MUX_s_1_2_2(or_tmp_152, nand_121_cse, fsm_output[7]);
  assign or_174_nl = (fsm_output[6]) | mux_137_nl;
  assign mux_138_nl = MUX_s_1_2_2(mux_tmp_133, or_174_nl, fsm_output[4]);
  assign mux_136_nl = MUX_s_1_2_2(or_718_cse, or_471_cse, fsm_output[6]);
  assign or_173_nl = (fsm_output[4]) | mux_136_nl;
  assign mux_tmp_139 = MUX_s_1_2_2(mux_138_nl, or_173_nl, fsm_output[2]);
  assign or_tmp_162 = (~ (fsm_output[2])) | (fsm_output[5]) | (fsm_output[6]);
  assign or_tmp_163 = (fsm_output[6:5]!=2'b01);
  assign or_181_cse = (fsm_output[6:5]!=2'b10);
  assign mux_tmp_148 = MUX_s_1_2_2(or_181_cse, or_397_cse, fsm_output[2]);
  assign and_dcpl_141 = and_dcpl_33 & and_dcpl_89;
  assign and_dcpl_142 = and_dcpl_141 & and_dcpl_97;
  assign and_dcpl_143 = and_dcpl_141 & and_dcpl_66;
  assign and_dcpl_144 = and_dcpl_33 & and_dcpl_26;
  assign nor_243_nl = ~((fsm_output[3]) | (~ (fsm_output[1])) | (~ (fsm_output[0]))
      | (fsm_output[4]) | (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[6]));
  assign nor_244_nl = ~((~ (fsm_output[1])) | (fsm_output[0]) | (~ (fsm_output[4]))
      | (fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[6])));
  assign nor_245_nl = ~((fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[4]))
      | (fsm_output[5]) | (~ (fsm_output[7])) | (fsm_output[6]));
  assign mux_171_nl = MUX_s_1_2_2(nor_244_nl, nor_245_nl, fsm_output[3]);
  assign not_tmp_111 = MUX_s_1_2_2(nor_243_nl, mux_171_nl, fsm_output[2]);
  assign and_dcpl_147 = and_dcpl_27 & and_dcpl_31;
  assign and_dcpl_148 = and_dcpl_147 & and_dcpl_111;
  assign and_dcpl_149 = and_dcpl_90 & and_dcpl_107;
  assign and_dcpl_152 = and_dcpl_39 & and_dcpl_89;
  assign and_dcpl_153 = and_dcpl_152 & and_dcpl_25;
  assign and_dcpl_154 = and_dcpl_152 & and_dcpl_54;
  assign and_dcpl_160 = (~ mux_114_itm) & and_dcpl_26;
  assign or_205_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[4]) | (fsm_output[7])
      | (fsm_output[6]);
  assign mux_173_itm = MUX_s_1_2_2(mux_tmp_107, or_205_nl, fsm_output[3]);
  assign and_dcpl_162 = (~ mux_173_itm) & (fsm_output[5]) & (~ (fsm_output[2]));
  assign or_212_nl = (fsm_output[3]) | (~ (fsm_output[1])) | (fsm_output[0]) | (~
      (fsm_output[4])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign or_210_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4]) | (fsm_output[7])
      | (fsm_output[6]);
  assign mux_176_nl = MUX_s_1_2_2(or_tmp_114, or_210_nl, fsm_output[3]);
  assign mux_177_nl = MUX_s_1_2_2(or_212_nl, mux_176_nl, fsm_output[2]);
  assign and_dcpl_164 = (~ mux_177_nl) & (fsm_output[5]);
  assign or_215_nl = (fsm_output[3]) | (~ (fsm_output[1])) | (~ (fsm_output[0]))
      | (~ (fsm_output[4])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign or_213_nl = (fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[4]) | (fsm_output[7])
      | (fsm_output[6]);
  assign mux_178_nl = MUX_s_1_2_2(or_tmp_102, or_213_nl, fsm_output[3]);
  assign mux_179_nl = MUX_s_1_2_2(or_215_nl, mux_178_nl, fsm_output[2]);
  assign and_dcpl_165 = (~ mux_179_nl) & (fsm_output[5]);
  assign and_dcpl_166 = (~ mux_173_itm) & and_dcpl_131;
  assign or_tmp_215 = (~ (fsm_output[1])) | (~ (fsm_output[0])) | (fsm_output[7])
      | (fsm_output[4]);
  assign nor_tmp_34 = (fsm_output[7]) & (fsm_output[4]);
  assign or_tmp_227 = (fsm_output[4]) | nand_121_cse;
  assign or_244_cse = (fsm_output[5:3]!=3'b110);
  assign mux_tmp_197 = MUX_s_1_2_2(or_tmp_227, or_244_cse, fsm_output[6]);
  assign mux_199_nl = MUX_s_1_2_2((fsm_output[5]), (~ (fsm_output[5])), fsm_output[3]);
  assign nand_17_nl = ~((fsm_output[4]) & mux_199_nl);
  assign nor_36_nl = ~((fsm_output[2]) | (~ (fsm_output[6])));
  assign mux_tmp_200 = MUX_s_1_2_2(or_tmp_227, nand_17_nl, nor_36_nl);
  assign and_dcpl_177 = (~ (fsm_output[1])) & (fsm_output[3]);
  assign and_dcpl_179 = (fsm_output[4]) & (fsm_output[0]);
  assign and_dcpl_180 = and_dcpl_39 & (fsm_output[5]);
  assign and_dcpl_181 = and_dcpl_180 & and_dcpl_179;
  assign and_dcpl_188 = and_dcpl_90 & and_dcpl_97;
  assign and_dcpl_189 = and_dcpl_90 & and_dcpl_59;
  assign nor_tmp_37 = (fsm_output[0]) & (fsm_output[5]) & (fsm_output[7]);
  assign mux_tmp_206 = MUX_s_1_2_2((~ or_tmp_2), or_tmp_2, fsm_output[6]);
  assign nor_tmp_38 = (fsm_output[5]) & (fsm_output[7]);
  assign mux_tmp_210 = MUX_s_1_2_2(nor_tmp_38, or_44_cse, fsm_output[6]);
  assign mux_tmp_212 = MUX_s_1_2_2((~ nor_tmp_38), or_tmp_2, fsm_output[6]);
  assign or_tmp_237 = (~((fsm_output[0]) | (fsm_output[5]))) | (fsm_output[7]);
  assign or_tmp_247 = (fsm_output[7]) | (~ (fsm_output[3]));
  assign or_tmp_250 = (fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[3]));
  assign nand_122_nl = ~((fsm_output[7]) & (fsm_output[3]));
  assign mux_235_nl = MUX_s_1_2_2(nand_122_nl, or_tmp_247, fsm_output[5]);
  assign or_tmp_258 = (fsm_output[6]) | mux_235_nl;
  assign or_tmp_263 = (~ (fsm_output[1])) | (fsm_output[4]) | mux_290_cse;
  assign or_tmp_284 = (~ (fsm_output[7])) | (fsm_output[2]);
  assign not_tmp_152 = ~((fsm_output[3]) & (fsm_output[1]));
  assign or_tmp_352 = (fsm_output[7:4]!=4'b0101);
  assign or_379_nl = (fsm_output[1]) | (fsm_output[4]) | (fsm_output[5]) | (fsm_output[7])
      | (fsm_output[6]);
  assign or_804_nl = (fsm_output[1]) | (~ (fsm_output[4])) | mux_51_cse;
  assign mux_tmp_314 = MUX_s_1_2_2(or_379_nl, or_804_nl, fsm_output[3]);
  assign or_tmp_372 = (fsm_output[4]) | mux_556_cse;
  assign or_tmp_384 = (fsm_output[7:4]!=4'b0000);
  assign or_dcpl_17 = (fsm_output[1:0]!=2'b01);
  assign and_dcpl_204 = (~ (fsm_output[5])) & (fsm_output[0]);
  assign mux_365_cse = MUX_s_1_2_2(or_tmp_163, or_397_cse, fsm_output[7]);
  assign mux_343_nl = MUX_s_1_2_2((fsm_output[5]), (~ (fsm_output[5])), fsm_output[6]);
  assign or_tmp_406 = (fsm_output[4]) | (fsm_output[7]) | mux_343_nl;
  assign and_dcpl_209 = (fsm_output[1]) & (~ (fsm_output[3]));
  assign or_dcpl_22 = (fsm_output[3:2]!=2'b10);
  assign or_tmp_462 = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[4]) | mux_290_cse;
  assign or_tmp_539 = (fsm_output[4]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign or_tmp_540 = (~ (fsm_output[4])) | (fsm_output[7]) | (fsm_output[6]);
  assign or_tmp_541 = (fsm_output[4]) | (fsm_output[6]) | (fsm_output[3]) | (fsm_output[1]);
  assign or_tmp_570 = (fsm_output[3]) | (fsm_output[7]) | (fsm_output[5]) | (~ (fsm_output[2]));
  assign and_dcpl_224 = and_dcpl_24 & and_373_cse_1;
  assign or_tmp_651 = (fsm_output[5:3]!=3'b010);
  assign or_tmp_669 = (fsm_output[2]) | (fsm_output[1]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_tmp_578 = MUX_s_1_2_2(or_820_cse, or_253_cse, fsm_output[2]);
  assign and_dcpl_239 = and_dcpl_65 & and_dcpl_30;
  assign and_dcpl_250 = and_dcpl_33 & (~ (fsm_output[5]));
  assign and_dcpl_251 = and_dcpl_250 & and_dcpl_179;
  assign and_dcpl_258 = (fsm_output[4]) & (~ (fsm_output[0]));
  assign and_dcpl_259 = and_dcpl_250 & and_dcpl_258;
  assign and_dcpl_270 = and_dcpl_33 & (fsm_output[5]);
  assign and_dcpl_271 = and_dcpl_270 & and_dcpl_179;
  assign and_dcpl_278 = and_dcpl_270 & and_dcpl_258;
  assign and_dcpl_285 = and_dcpl_27 & (~ (fsm_output[5]));
  assign and_dcpl_286 = and_dcpl_285 & and_dcpl_258;
  assign and_dcpl_293 = and_dcpl_285 & and_dcpl_179;
  assign or_dcpl_44 = or_dcpl_17 | or_dcpl_22;
  assign and_dcpl_300 = and_dcpl_27 & (fsm_output[5]);
  assign and_dcpl_301 = and_dcpl_300 & and_dcpl_179;
  assign and_dcpl_308 = and_dcpl_300 & and_dcpl_258;
  assign and_dcpl_315 = and_dcpl_39 & (~ (fsm_output[5]));
  assign and_dcpl_316 = and_dcpl_315 & and_dcpl_179;
  assign and_dcpl_323 = and_dcpl_315 & and_dcpl_258;
  assign and_dcpl_330 = and_dcpl_180 & and_dcpl_258;
  assign xx_rsci_radr_d_mx0c0 = (~ mux_94_itm) & and_dcpl_31;
  assign xx_rsci_radr_d_mx0c1 = (~ mux_96_itm) & and_dcpl_31;
  assign xx_rsci_radr_d_mx0c2 = (~ mux_98_itm) & and_dcpl_31;
  assign xx_rsci_radr_d_mx0c3 = ~(mux_100_itm | (fsm_output[5]) | (fsm_output[2]));
  assign or_828_nl = (fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[4]))
      | (fsm_output[7]) | (fsm_output[6]);
  assign or_829_nl = (~ (fsm_output[1])) | (~ (fsm_output[0])) | (fsm_output[4])
      | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_101_nl = MUX_s_1_2_2(or_828_nl, or_829_nl, fsm_output[3]);
  assign or_830_nl = (fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4])
      | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_102_nl = MUX_s_1_2_2(mux_101_nl, or_830_nl, fsm_output[2]);
  assign xx_rsci_radr_d_mx0c4 = ~(mux_102_nl | (fsm_output[5]));
  assign or_127_nl = (fsm_output[3]) | (~ (fsm_output[1])) | (fsm_output[0]) | (~
      (fsm_output[4])) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_103_nl = MUX_s_1_2_2(or_tmp_112, or_tmp_110, fsm_output[3]);
  assign mux_104_nl = MUX_s_1_2_2(or_127_nl, mux_103_nl, fsm_output[2]);
  assign xx_rsci_radr_d_mx0c5 = ~(mux_104_nl | (fsm_output[5]));
  assign or_130_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[4]) | (fsm_output[7])
      | (~ (fsm_output[6]));
  assign mux_105_nl = MUX_s_1_2_2(or_130_nl, or_tmp_114, fsm_output[3]);
  assign mux_106_nl = MUX_s_1_2_2(or_tmp_117, mux_105_nl, fsm_output[2]);
  assign xx_rsci_radr_d_mx0c6 = ~(mux_106_nl | (fsm_output[5]));
  assign xx_rsci_radr_d_mx0c7 = (~ mux_100_itm) & and_dcpl_126;
  assign xx_rsci_radr_d_mx0c8 = and_dcpl_28 & and_dcpl_54;
  assign xx_rsci_radr_d_mx0c10 = and_dcpl_40 & and_dcpl_88;
  assign mux_108_nl = MUX_s_1_2_2(or_tmp_121, mux_tmp_107, fsm_output[3]);
  assign xx_rsci_wadr_d_mx0c1 = (~ mux_108_nl) & and_dcpl_131;
  assign xx_rsci_wadr_d_mx0c2 = (~ mux_110_itm) & and_407_cse;
  assign xx_rsci_wadr_d_mx0c3 = (~ mux_112_itm) & and_407_cse;
  assign xx_rsci_wadr_d_mx0c4 = (~ mux_114_itm) & and_407_cse;
  assign nor_260_nl = ~((fsm_output[0]) | (fsm_output[4]) | (fsm_output[5]) | (~
      (fsm_output[7])));
  assign mux_115_nl = MUX_s_1_2_2(nor_260_nl, nor_tmp_16, fsm_output[1]);
  assign nor_261_nl = ~((~ (fsm_output[1])) | (fsm_output[0]) | (~ (fsm_output[4]))
      | (~ (fsm_output[5])) | (fsm_output[7]));
  assign mux_116_nl = MUX_s_1_2_2(mux_115_nl, nor_261_nl, fsm_output[3]);
  assign xx_rsci_wadr_d_mx0c5 = mux_116_nl & (~ (fsm_output[6])) & (~ (fsm_output[2]));
  assign or_823_nl = (fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[4]) | (fsm_output[5])
      | (~ (fsm_output[7]));
  assign nand_138_nl = ~((fsm_output[1]) & (fsm_output[0]) & (fsm_output[4]) & (fsm_output[5])
      & (~ (fsm_output[7])));
  assign mux_117_nl = MUX_s_1_2_2(or_823_nl, nand_138_nl, fsm_output[3]);
  assign or_824_nl = (fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | not_tmp_72;
  assign mux_118_nl = MUX_s_1_2_2(mux_117_nl, or_824_nl, fsm_output[2]);
  assign xx_rsci_wadr_d_mx0c6 = ~(mux_118_nl | (fsm_output[6]));
  assign or_154_nl = (fsm_output[3]) | (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[4])
      | (fsm_output[5]) | (~ (fsm_output[7]));
  assign or_152_nl = (fsm_output[1]) | (fsm_output[0]) | (~ (fsm_output[4])) | (~
      (fsm_output[5])) | (fsm_output[7]);
  assign mux_119_nl = MUX_s_1_2_2(or_tmp_40, or_152_nl, fsm_output[3]);
  assign mux_120_nl = MUX_s_1_2_2(or_154_nl, mux_119_nl, fsm_output[2]);
  assign xx_rsci_wadr_d_mx0c7 = ~(mux_120_nl | (fsm_output[6]));
  assign yy_rsci_radr_d_mx0c0 = and_dcpl_43 & and_dcpl_54;
  assign yy_rsci_radr_d_mx0c1 = (~ mux_110_itm) & and_dcpl_26;
  assign yy_rsci_radr_d_mx0c2 = (~ mux_112_itm) & and_dcpl_26;
  assign nor_240_nl = ~((fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[4]))
      | (fsm_output[7]) | (~ (fsm_output[6])));
  assign nor_241_nl = ~((~ (fsm_output[1])) | (~ (fsm_output[0])) | (fsm_output[4])
      | (fsm_output[7]) | (fsm_output[6]));
  assign mux_174_nl = MUX_s_1_2_2(nor_240_nl, nor_241_nl, fsm_output[3]);
  assign nor_242_nl = ~((fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4])
      | (~ (fsm_output[7])) | (fsm_output[6]));
  assign mux_175_nl = MUX_s_1_2_2(mux_174_nl, nor_242_nl, fsm_output[2]);
  assign yy_rsci_radr_d_mx0c5 = mux_175_nl & (fsm_output[5]);
  assign yy_rsci_radr_d_mx0c9 = and_dcpl_90 & and_dcpl_80;
  assign yy_rsci_wadr_d_mx0c0 = and_dcpl_43 & and_dcpl_100;
  assign yy_rsci_wadr_d_mx0c1 = and_dcpl_43 & and_dcpl_102;
  assign or_216_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (~ (fsm_output[4]))
      | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_180_nl = MUX_s_1_2_2(or_216_nl, mux_tmp_99, fsm_output[3]);
  assign yy_rsci_wadr_d_mx0c2 = (~ mux_180_nl) & and_dcpl_126;
  assign yy_rsci_wadr_d_mx0c3 = (~ mux_94_itm) & and_dcpl_89;
  assign yy_rsci_wadr_d_mx0c4 = (~ mux_96_itm) & and_dcpl_89;
  assign yy_rsci_wadr_d_mx0c5 = (~ mux_98_itm) & and_dcpl_89;
  assign or_831_nl = (fsm_output[0]) | (fsm_output[4]) | (~ (fsm_output[5])) | (fsm_output[7])
      | (fsm_output[6]);
  assign or_832_nl = (~ (fsm_output[0])) | (~ (fsm_output[4])) | (fsm_output[5])
      | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_181_nl = MUX_s_1_2_2(or_831_nl, or_832_nl, fsm_output[1]);
  assign or_833_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (~ (fsm_output[4]))
      | (fsm_output[5]) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_182_nl = MUX_s_1_2_2(mux_181_nl, or_833_nl, fsm_output[3]);
  assign yy_rsci_wadr_d_mx0c6 = ~(mux_182_nl | (fsm_output[2]));
  assign nor_234_nl = ~((fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[4]) |
      (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[6]));
  assign nor_235_nl = ~((~ (fsm_output[1])) | (~ (fsm_output[0])) | (~ (fsm_output[4]))
      | (fsm_output[5]) | (~ (fsm_output[7])) | (fsm_output[6]));
  assign mux_183_nl = MUX_s_1_2_2(nor_234_nl, nor_235_nl, fsm_output[3]);
  assign nor_236_nl = ~((fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (~
      (fsm_output[4])) | (fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[6])));
  assign yy_rsci_wadr_d_mx0c7 = MUX_s_1_2_2(mux_183_nl, nor_236_nl, fsm_output[2]);
  assign nor_231_nl = ~((fsm_output[3]) | (~ (fsm_output[1])) | (fsm_output[0]) |
      (fsm_output[4]) | (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[6]));
  assign nor_232_nl = ~((fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[4]))
      | (fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[6])));
  assign nor_233_nl = ~((fsm_output[1]) | (fsm_output[0]) | (~ (fsm_output[4])) |
      (fsm_output[5]) | (~ (fsm_output[7])) | (fsm_output[6]));
  assign mux_185_nl = MUX_s_1_2_2(nor_232_nl, nor_233_nl, fsm_output[3]);
  assign yy_rsci_wadr_d_mx0c8 = MUX_s_1_2_2(nor_231_nl, mux_185_nl, fsm_output[2]);
  assign yy_rsci_wadr_d_mx0c10 = and_dcpl_28 & and_dcpl_80;
  assign or_408_nl = (fsm_output[2]) | (fsm_output[6]) | (fsm_output[7]) | (fsm_output[5]);
  assign nand_38_nl = ~((fsm_output[2]) & (~ mux_5_cse));
  assign mux_356_nl = MUX_s_1_2_2(or_408_nl, nand_38_nl, fsm_output[0]);
  assign nand_37_nl = ~(nor_64_cse & (~ mux_5_cse));
  assign mux_357_nl = MUX_s_1_2_2(mux_356_nl, nand_37_nl, fsm_output[1]);
  assign nor_184_nl = ~((fsm_output[4]) | mux_357_nl);
  assign or_404_nl = (fsm_output[6]) | nand_130_cse;
  assign mux_353_nl = MUX_s_1_2_2(mux_tmp_1, or_404_nl, fsm_output[2]);
  assign or_403_nl = (~ (fsm_output[2])) | (fsm_output[6]) | nand_130_cse;
  assign mux_354_nl = MUX_s_1_2_2(mux_353_nl, or_403_nl, fsm_output[0]);
  assign nor_185_nl = ~((~ (fsm_output[4])) | (fsm_output[1]) | mux_354_nl);
  assign S1_OUTER_LOOP_for_p_sva_1_mx0c1 = MUX_s_1_2_2(nor_184_nl, nor_185_nl, fsm_output[3]);
  assign and_368_nl = (fsm_output[4]) & (fsm_output[6]);
  assign mux_364_nl = MUX_s_1_2_2(and_dcpl_55, and_368_nl, fsm_output[3]);
  assign S1_OUTER_LOOP_for_acc_cse_sva_mx0c0 = mux_364_nl & (~ (fsm_output[7])) &
      and_dcpl_204 & (fsm_output[2:1]==2'b00);
  assign mux_340_nl = MUX_s_1_2_2(or_181_cse, or_tmp_163, fsm_output[7]);
  assign nand_43_nl = ~((fsm_output[4]) & (~ mux_340_nl));
  assign mux_371_nl = MUX_s_1_2_2(nand_43_nl, or_tmp_406, fsm_output[2]);
  assign and_366_nl = (fsm_output[3]) & (~ mux_371_nl);
  assign mux_344_nl = MUX_s_1_2_2((~ or_181_cse), or_397_cse, fsm_output[7]);
  assign nor_179_nl = ~((fsm_output[4:2]!=3'b001) | mux_344_nl);
  assign mux_372_nl = MUX_s_1_2_2(and_366_nl, nor_179_nl, fsm_output[1]);
  assign nor_180_nl = ~((fsm_output[4:2]!=3'b001) | mux_365_cse);
  assign nand_41_nl = ~((fsm_output[4]) & (~ mux_365_cse));
  assign mux_367_nl = MUX_s_1_2_2(or_tmp_406, nand_41_nl, fsm_output[2]);
  assign and_367_nl = (fsm_output[3]) & (~ mux_367_nl);
  assign mux_368_nl = MUX_s_1_2_2(nor_180_nl, and_367_nl, fsm_output[1]);
  assign S1_OUTER_LOOP_for_acc_cse_sva_mx0c1 = MUX_s_1_2_2(mux_372_nl, mux_368_nl,
      fsm_output[0]);
  assign S1_OUTER_LOOP_for_acc_cse_sva_mx0c2 = and_dcpl_67 & and_dcpl_59;
  assign nor_333_nl = ~((fsm_output[4:2]!=3'b001) | mux_290_cse);
  assign nor_178_nl = ~((fsm_output[2]) | mux_556_cse);
  assign and_364_nl = (fsm_output[2]) & (~ mux_290_cse);
  assign mux_377_nl = MUX_s_1_2_2(nor_178_nl, and_364_nl, fsm_output[4]);
  assign and_363_nl = (fsm_output[3]) & mux_377_nl;
  assign mux_378_nl = MUX_s_1_2_2(nor_333_nl, and_363_nl, fsm_output[1]);
  assign and_365_nl = (fsm_output[4:1]==4'b1011) & (~ mux_51_cse);
  assign S1_OUTER_LOOP_for_acc_cse_sva_mx0c3 = MUX_s_1_2_2(mux_378_nl, and_365_nl,
      fsm_output[0]);
  assign butterFly_10_f1_sva_mx0c0 = and_dcpl_43 & and_dcpl_209 & (~ (fsm_output[2]));
  assign mux_393_nl = MUX_s_1_2_2(or_352_cse, or_353_cse, fsm_output[5]);
  assign nor_175_nl = ~((~ (fsm_output[3])) | (fsm_output[1]) | (fsm_output[0]) |
      (fsm_output[4]) | mux_393_nl);
  assign nor_176_nl = ~((fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[4]))
      | (~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[6])));
  assign nor_177_nl = ~((~ (fsm_output[1])) | (~ (fsm_output[0])) | (fsm_output[4])
      | (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[6]));
  assign mux_392_nl = MUX_s_1_2_2(nor_176_nl, nor_177_nl, fsm_output[3]);
  assign butterFly_10_f1_sva_mx0c1 = MUX_s_1_2_2(nor_175_nl, mux_392_nl, fsm_output[2]);
  assign nor_172_nl = ~((fsm_output[7:1]!=7'b1010001));
  assign or_457_nl = (fsm_output[5:4]!=2'b01);
  assign or_456_nl = (fsm_output[5:4]!=2'b10);
  assign mux_396_nl = MUX_s_1_2_2(or_457_nl, or_456_nl, fsm_output[3]);
  assign or_458_nl = (fsm_output[2]) | mux_396_nl;
  assign or_455_nl = (fsm_output[5:2]!=4'b0010);
  assign mux_397_nl = MUX_s_1_2_2(or_458_nl, or_455_nl, fsm_output[7]);
  assign nor_173_nl = ~((fsm_output[6]) | mux_397_nl);
  assign or_453_nl = (fsm_output[5:3]!=3'b000);
  assign or_452_nl = (fsm_output[5:3]!=3'b101);
  assign mux_395_nl = MUX_s_1_2_2(or_453_nl, or_452_nl, fsm_output[2]);
  assign nor_174_nl = ~((fsm_output[7:6]!=2'b01) | mux_395_nl);
  assign mux_398_nl = MUX_s_1_2_2(nor_173_nl, nor_174_nl, fsm_output[1]);
  assign butterFly_10_f1_sva_mx0c2 = MUX_s_1_2_2(nor_172_nl, mux_398_nl, fsm_output[0]);
  assign nor_170_nl = ~((~ (fsm_output[5])) | (fsm_output[1]) | (~ (fsm_output[3]))
      | (fsm_output[0]) | (fsm_output[7]) | (~ (fsm_output[6])) | (fsm_output[4]));
  assign or_464_nl = (fsm_output[3]) | (fsm_output[0]) | (fsm_output[7]) | (fsm_output[6])
      | (~ (fsm_output[4]));
  assign mux_400_nl = MUX_s_1_2_2(or_563_cse, or_tmp_118, fsm_output[3]);
  assign mux_401_nl = MUX_s_1_2_2(or_464_nl, mux_400_nl, fsm_output[1]);
  assign nor_171_nl = ~((fsm_output[5]) | mux_401_nl);
  assign butterFly_10_f1_sva_mx0c3 = MUX_s_1_2_2(nor_170_nl, nor_171_nl, fsm_output[2]);
  assign S2_OUTER_LOOP_c_1_sva_mx0c1 = and_dcpl_93 & and_dcpl_111;
  assign S2_OUTER_LOOP_c_1_sva_mx0c2 = and_dcpl_152 & and_dcpl_111;
  assign or_489_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4]) | mux_556_cse;
  assign mux_418_nl = MUX_s_1_2_2(or_tmp_462, or_489_nl, fsm_output[3]);
  assign or_387_nl = (fsm_output[0]) | (fsm_output[4]) | mux_556_cse;
  assign nand_55_nl = ~((fsm_output[0]) & (fsm_output[4]) & (~ mux_290_cse));
  assign mux_416_nl = MUX_s_1_2_2(or_387_nl, nand_55_nl, fsm_output[1]);
  assign mux_417_nl = MUX_s_1_2_2(or_tmp_462, mux_416_nl, fsm_output[3]);
  assign mux_419_nl = MUX_s_1_2_2(mux_418_nl, mux_417_nl, and_19_cse);
  assign S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c1 = (~ mux_419_nl) & (fsm_output[2]);
  assign nor_331_nl = ~((fsm_output[4]) | (fsm_output[1]) | (~ (fsm_output[0])) |
      (~ (fsm_output[2])) | mux_290_cse);
  assign nor_167_nl = ~((fsm_output[0]) | (fsm_output[2]) | mux_51_cse);
  assign nor_332_nl = ~((z_out_2[2]) | (~ (fsm_output[0])) | (~ (fsm_output[2]))
      | mux_290_cse);
  assign mux_422_nl = MUX_s_1_2_2(nor_167_nl, nor_332_nl, fsm_output[1]);
  assign and_359_nl = (fsm_output[4]) & mux_422_nl;
  assign S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c2 = MUX_s_1_2_2(nor_331_nl, and_359_nl,
      fsm_output[3]);
  assign nand_65_nl = ~((fsm_output[0]) & (~ mux_51_cse));
  assign mux_437_nl = MUX_s_1_2_2(nand_65_nl, or_tmp_58, fsm_output[1]);
  assign or_506_nl = (fsm_output[1]) | mux_290_cse;
  assign mux_438_nl = MUX_s_1_2_2(mux_437_nl, or_506_nl, fsm_output[3]);
  assign nand_64_nl = ~((fsm_output[3]) & (fsm_output[1]) & (~ mux_556_cse));
  assign mux_439_nl = MUX_s_1_2_2(mux_438_nl, nand_64_nl, fsm_output[2]);
  assign butterFly_10_tw_asn_itm_mx0c0 = ~(mux_439_nl | (fsm_output[4]));
  assign nor_154_cse = ~((~ reg_modulo_add_7_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b01));
  assign nor_158_cse = ~((~ reg_modulo_add_4_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b10));
  assign nor_152_nl = ~((~ reg_modulo_add_5_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b01));
  assign nor_153_nl = ~((~ reg_modulo_add_7_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b10));
  assign mux_452_nl = MUX_s_1_2_2(nor_152_nl, nor_153_nl, fsm_output[5]);
  assign nor_155_nl = ~((~ reg_modulo_add_5_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b10));
  assign mux_451_nl = MUX_s_1_2_2(nor_154_cse, nor_155_nl, fsm_output[5]);
  assign mux_453_nl = MUX_s_1_2_2(mux_452_nl, mux_451_nl, fsm_output[0]);
  assign or_525_nl = (~ reg_modulo_add_1_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b01);
  assign or_524_nl = (~ reg_modulo_add_1_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b10);
  assign mux_450_nl = MUX_s_1_2_2(or_525_nl, or_524_nl, fsm_output[5]);
  assign nor_156_nl = ~((fsm_output[0]) | mux_450_nl);
  assign mux_454_nl = MUX_s_1_2_2(mux_453_nl, nor_156_nl, fsm_output[1]);
  assign or_521_nl = (~ reg_modulo_add_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b10);
  assign or_519_nl = (~ reg_modulo_add_5_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00);
  assign mux_448_nl = MUX_s_1_2_2(or_521_nl, or_519_nl, fsm_output[5]);
  assign or_518_nl = (~ reg_modulo_add_6_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b10);
  assign or_516_nl = (~ reg_modulo_add_6_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00);
  assign mux_447_nl = MUX_s_1_2_2(or_518_nl, or_516_nl, fsm_output[5]);
  assign mux_449_nl = MUX_s_1_2_2(mux_448_nl, mux_447_nl, fsm_output[0]);
  assign nor_157_nl = ~((fsm_output[1]) | mux_449_nl);
  assign mux_455_nl = MUX_s_1_2_2(mux_454_nl, nor_157_nl, fsm_output[3]);
  assign nor_159_nl = ~((~ reg_modulo_add_4_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00));
  assign mux_445_nl = MUX_s_1_2_2(nor_158_cse, nor_159_nl, fsm_output[5]);
  assign and_356_nl = (fsm_output[1:0]==2'b11) & mux_445_nl;
  assign nor_160_nl = ~((~ reg_modulo_add_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00));
  assign mux_443_nl = MUX_s_1_2_2(nor_160_nl, nor_154_cse, fsm_output[5]);
  assign and_357_nl = (fsm_output[0]) & mux_443_nl;
  assign nor_162_nl = ~((~ reg_modulo_add_1_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00));
  assign nor_163_nl = ~((~ reg_modulo_add_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b01));
  assign mux_441_nl = MUX_s_1_2_2(nor_162_nl, nor_163_nl, fsm_output[5]);
  assign nor_164_nl = ~((~ reg_modulo_add_3_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00));
  assign nor_165_nl = ~((~ reg_modulo_add_3_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b01));
  assign mux_440_nl = MUX_s_1_2_2(nor_164_nl, nor_165_nl, fsm_output[5]);
  assign mux_442_nl = MUX_s_1_2_2(mux_441_nl, mux_440_nl, fsm_output[0]);
  assign mux_444_nl = MUX_s_1_2_2(and_357_nl, mux_442_nl, fsm_output[1]);
  assign mux_446_nl = MUX_s_1_2_2(and_356_nl, mux_444_nl, fsm_output[3]);
  assign mux_456_nl = MUX_s_1_2_2(mux_455_nl, mux_446_nl, fsm_output[2]);
  assign butterFly_10_tw_asn_itm_mx0c1 = mux_456_nl & (fsm_output[4]);
  assign nor_140_cse = ~(reg_modulo_add_7_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b01));
  assign nor_144_cse = ~(reg_modulo_add_4_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b10));
  assign nor_138_nl = ~(reg_modulo_add_5_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b01));
  assign nor_139_nl = ~(reg_modulo_add_7_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b10));
  assign mux_469_nl = MUX_s_1_2_2(nor_138_nl, nor_139_nl, fsm_output[5]);
  assign nor_141_nl = ~(reg_modulo_add_5_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b10));
  assign mux_468_nl = MUX_s_1_2_2(nor_140_cse, nor_141_nl, fsm_output[5]);
  assign mux_470_nl = MUX_s_1_2_2(mux_469_nl, mux_468_nl, fsm_output[0]);
  assign or_551_nl = reg_modulo_add_1_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b01);
  assign or_550_nl = reg_modulo_add_1_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b10);
  assign mux_467_nl = MUX_s_1_2_2(or_551_nl, or_550_nl, fsm_output[5]);
  assign nor_142_nl = ~((fsm_output[0]) | mux_467_nl);
  assign mux_471_nl = MUX_s_1_2_2(mux_470_nl, nor_142_nl, fsm_output[1]);
  assign or_547_nl = reg_modulo_add_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b10);
  assign or_545_nl = reg_modulo_add_5_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00);
  assign mux_465_nl = MUX_s_1_2_2(or_547_nl, or_545_nl, fsm_output[5]);
  assign or_544_nl = reg_modulo_add_6_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b10);
  assign or_542_nl = reg_modulo_add_6_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00);
  assign mux_464_nl = MUX_s_1_2_2(or_544_nl, or_542_nl, fsm_output[5]);
  assign mux_466_nl = MUX_s_1_2_2(mux_465_nl, mux_464_nl, fsm_output[0]);
  assign nor_143_nl = ~((fsm_output[1]) | mux_466_nl);
  assign mux_472_nl = MUX_s_1_2_2(mux_471_nl, nor_143_nl, fsm_output[3]);
  assign nor_145_nl = ~(reg_modulo_add_4_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00));
  assign mux_462_nl = MUX_s_1_2_2(nor_144_cse, nor_145_nl, fsm_output[5]);
  assign and_354_nl = (fsm_output[1:0]==2'b11) & mux_462_nl;
  assign nor_146_nl = ~(reg_modulo_add_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00));
  assign mux_460_nl = MUX_s_1_2_2(nor_146_nl, nor_140_cse, fsm_output[5]);
  assign and_355_nl = (fsm_output[0]) & mux_460_nl;
  assign nor_148_nl = ~(reg_modulo_add_1_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00));
  assign nor_149_nl = ~(reg_modulo_add_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b01));
  assign mux_458_nl = MUX_s_1_2_2(nor_148_nl, nor_149_nl, fsm_output[5]);
  assign nor_150_nl = ~(reg_modulo_add_3_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00));
  assign nor_151_nl = ~(reg_modulo_add_3_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b01));
  assign mux_457_nl = MUX_s_1_2_2(nor_150_nl, nor_151_nl, fsm_output[5]);
  assign mux_459_nl = MUX_s_1_2_2(mux_458_nl, mux_457_nl, fsm_output[0]);
  assign mux_461_nl = MUX_s_1_2_2(and_355_nl, mux_459_nl, fsm_output[1]);
  assign mux_463_nl = MUX_s_1_2_2(and_354_nl, mux_461_nl, fsm_output[3]);
  assign mux_473_nl = MUX_s_1_2_2(mux_472_nl, mux_463_nl, fsm_output[2]);
  assign butterFly_10_tw_asn_itm_mx0c2 = mux_473_nl & (fsm_output[4]);
  assign or_574_nl = (fsm_output[2]) | (fsm_output[7]) | (~((fsm_output[4]) & (fsm_output[6])
      & (fsm_output[3]) & (fsm_output[1])));
  assign or_572_nl = (fsm_output[7]) | (fsm_output[4]) | (fsm_output[6]) | (~ (fsm_output[3]))
      | (fsm_output[1]);
  assign or_571_nl = (fsm_output[4]) | (~((fsm_output[6]) & (fsm_output[3]) & (fsm_output[1])));
  assign mux_486_nl = MUX_s_1_2_2(or_571_nl, or_tmp_541, fsm_output[7]);
  assign mux_487_nl = MUX_s_1_2_2(or_572_nl, mux_486_nl, fsm_output[2]);
  assign or_569_nl = (fsm_output[6]) | not_tmp_152;
  assign or_568_nl = (~ (fsm_output[6])) | (fsm_output[3]) | (fsm_output[1]);
  assign mux_484_nl = MUX_s_1_2_2(or_569_nl, or_568_nl, fsm_output[4]);
  assign mux_485_nl = MUX_s_1_2_2(mux_484_nl, or_tmp_541, fsm_output[7]);
  assign or_570_nl = (fsm_output[2]) | mux_485_nl;
  assign mux_488_nl = MUX_s_1_2_2(mux_487_nl, or_570_nl, fsm_output[0]);
  assign mux_489_itm = MUX_s_1_2_2(or_574_nl, mux_488_nl, fsm_output[5]);
  assign nor_130_nl = ~((~ (fsm_output[1])) | (fsm_output[4]) | (fsm_output[6]) |
      (fsm_output[3]) | nand_102_cse);
  assign mux_507_nl = MUX_s_1_2_2(and_dcpl_131, nor_254_cse, fsm_output[7]);
  assign nand_77_nl = ~((fsm_output[3]) & mux_507_nl);
  assign mux_508_nl = MUX_s_1_2_2(nand_77_nl, or_tmp_570, fsm_output[6]);
  assign nor_131_nl = ~((fsm_output[4]) | mux_508_nl);
  assign or_594_nl = (fsm_output[3]) | (fsm_output[7]) | (~ (fsm_output[5])) | (fsm_output[2]);
  assign mux_506_nl = MUX_s_1_2_2(or_tmp_570, or_594_nl, fsm_output[6]);
  assign and_353_nl = (fsm_output[4]) & (~ mux_506_nl);
  assign mux_509_nl = MUX_s_1_2_2(nor_131_nl, and_353_nl, fsm_output[1]);
  assign butterFly_13_tw_h_asn_itm_mx0c1 = MUX_s_1_2_2(nor_130_nl, mux_509_nl, fsm_output[0]);
  assign butterFly_13_tw_h_asn_itm_mx0c2 = and_dcpl_90 & and_dcpl_224;
  assign nor_123_nl = ~((fsm_output[3]) | (fsm_output[6]) | (~ (fsm_output[7])) |
      (fsm_output[0]) | nand_136_cse);
  assign or_710_nl = (fsm_output[0]) | (fsm_output[5]) | (fsm_output[7]) | (fsm_output[2]);
  assign or_709_nl = (~ (fsm_output[0])) | (~ (fsm_output[5])) | (fsm_output[7])
      | (fsm_output[2]);
  assign mux_590_nl = MUX_s_1_2_2(or_710_nl, or_709_nl, fsm_output[6]);
  assign nor_124_nl = ~((fsm_output[3]) | mux_590_nl);
  assign mux_530_nl = MUX_s_1_2_2(nor_123_nl, nor_124_nl, fsm_output[4]);
  assign or_623_nl = (~ (fsm_output[6])) | (fsm_output[7]) | (fsm_output[0]) | (fsm_output[5])
      | (fsm_output[2]);
  assign or_621_nl = (~ (fsm_output[0])) | (~ (fsm_output[5])) | (fsm_output[2]);
  assign or_620_nl = (~ (fsm_output[0])) | (fsm_output[5]) | (fsm_output[2]);
  assign mux_527_nl = MUX_s_1_2_2(or_621_nl, or_620_nl, fsm_output[7]);
  assign or_622_nl = (fsm_output[6]) | mux_527_nl;
  assign mux_528_nl = MUX_s_1_2_2(or_623_nl, or_622_nl, fsm_output[3]);
  assign nor_125_nl = ~((fsm_output[4]) | mux_528_nl);
  assign butterFly_10_tw_h_asn_itm_mx0c0 = MUX_s_1_2_2(mux_530_nl, nor_125_nl, fsm_output[1]);
  assign nor_119_nl = ~((fsm_output[3]) | (~ (fsm_output[6])) | (~ (fsm_output[4]))
      | (fsm_output[7]) | nand_136_cse);
  assign or_634_nl = (~ (fsm_output[2])) | (fsm_output[5]);
  assign mux_533_nl = MUX_s_1_2_2(nand_136_cse, or_634_nl, fsm_output[7]);
  assign nor_120_nl = ~((fsm_output[4]) | mux_533_nl);
  assign nor_121_nl = ~((fsm_output[4]) | (fsm_output[7]) | (fsm_output[2]) | (fsm_output[5]));
  assign mux_534_nl = MUX_s_1_2_2(nor_120_nl, nor_121_nl, fsm_output[6]);
  assign and_351_nl = (fsm_output[3]) & mux_534_nl;
  assign mux_535_nl = MUX_s_1_2_2(nor_119_nl, and_351_nl, fsm_output[1]);
  assign or_631_nl = (fsm_output[7]) | (fsm_output[2]) | (fsm_output[5]);
  assign mux_532_nl = MUX_s_1_2_2(nand_102_cse, or_631_nl, fsm_output[4]);
  assign nor_122_nl = ~((~ (fsm_output[1])) | (fsm_output[3]) | (fsm_output[6]) |
      mux_532_nl);
  assign butterFly_10_tw_h_asn_itm_mx0c1 = MUX_s_1_2_2(mux_535_nl, nor_122_nl, fsm_output[0]);
  assign nor_115_nl = ~((~ reg_modulo_add_7_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00));
  assign mux_539_nl = MUX_s_1_2_2(nor_158_cse, nor_115_nl, fsm_output[5]);
  assign and_349_nl = (fsm_output[1]) & mux_539_nl;
  assign or_643_nl = (~ reg_modulo_add_3_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b00);
  assign or_642_nl = (~ reg_modulo_add_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b01);
  assign mux_538_nl = MUX_s_1_2_2(or_643_nl, or_642_nl, fsm_output[5]);
  assign nor_116_nl = ~((fsm_output[1]) | mux_538_nl);
  assign mux_540_nl = MUX_s_1_2_2(and_349_nl, nor_116_nl, fsm_output[3]);
  assign and_348_nl = (fsm_output[4]) & mux_540_nl;
  assign nor_117_nl = ~((~ reg_modulo_add_6_slc_32_svs_st_cse) | (fsm_output[7:6]!=2'b01));
  assign mux_537_nl = MUX_s_1_2_2(nor_117_nl, nor_158_cse, fsm_output[5]);
  assign and_350_nl = nor_284_cse & mux_537_nl;
  assign mux_541_nl = MUX_s_1_2_2(and_348_nl, and_350_nl, fsm_output[0]);
  assign butterFly_10_tw_h_asn_itm_mx0c2 = mux_541_nl & (fsm_output[2]);
  assign nor_110_nl = ~(reg_modulo_add_7_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00));
  assign mux_544_nl = MUX_s_1_2_2(nor_144_cse, nor_110_nl, fsm_output[5]);
  assign and_346_nl = (fsm_output[1]) & mux_544_nl;
  assign or_652_nl = reg_modulo_add_3_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b00);
  assign or_651_nl = reg_modulo_add_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b01);
  assign mux_543_nl = MUX_s_1_2_2(or_652_nl, or_651_nl, fsm_output[5]);
  assign nor_111_nl = ~((fsm_output[1]) | mux_543_nl);
  assign mux_545_nl = MUX_s_1_2_2(and_346_nl, nor_111_nl, fsm_output[3]);
  assign and_345_nl = (fsm_output[4]) & mux_545_nl;
  assign nor_112_nl = ~(reg_modulo_add_6_slc_32_svs_st_cse | (fsm_output[7:6]!=2'b01));
  assign mux_542_nl = MUX_s_1_2_2(nor_112_nl, nor_144_cse, fsm_output[5]);
  assign and_347_nl = nor_284_cse & mux_542_nl;
  assign mux_546_nl = MUX_s_1_2_2(and_345_nl, and_347_nl, fsm_output[0]);
  assign butterFly_10_tw_h_asn_itm_mx0c3 = mux_546_nl & (fsm_output[2]);
  assign butterFly_10_tw_h_asn_itm_mx0c4 = and_dcpl_90 & and_dcpl_111;
  assign mux_562_nl = MUX_s_1_2_2(or_tmp_540, or_tmp_539, fsm_output[1]);
  assign or_672_nl = (fsm_output[1]) | (fsm_output[4]) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_563_nl = MUX_s_1_2_2(mux_562_nl, or_672_nl, fsm_output[3]);
  assign mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c0 = (~ mux_563_nl) & and_dcpl_204
      & (~ (fsm_output[2]));
  assign mux_566_nl = MUX_s_1_2_2(or_tmp_651, or_tmp_227, fsm_output[7]);
  assign nand_88_nl = ~((fsm_output[1]) & (~ mux_566_nl));
  assign mux_565_nl = MUX_s_1_2_2(or_244_cse, or_tmp_651, fsm_output[7]);
  assign or_679_nl = (fsm_output[1]) | mux_565_nl;
  assign mux_567_nl = MUX_s_1_2_2(nand_88_nl, or_679_nl, fsm_output[0]);
  assign nor_107_nl = ~((fsm_output[6]) | mux_567_nl);
  assign or_717_nl = (fsm_output[3]) | (~ (fsm_output[5]));
  assign mux_564_nl = MUX_s_1_2_2(or_tmp_152, or_717_nl, fsm_output[4]);
  assign nor_108_nl = ~((~((fsm_output[6]) & (fsm_output[0]) & (fsm_output[1]) &
      (~ (fsm_output[7])))) | mux_564_nl);
  assign mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c1 = MUX_s_1_2_2(nor_107_nl,
      nor_108_nl, fsm_output[2]);
  assign nand_99_nl = ~((fsm_output[2]) & (fsm_output[1]) & (fsm_output[6]));
  assign or_731_nl = (~ (fsm_output[2])) | (fsm_output[1]) | (fsm_output[6]);
  assign mux_603_nl = MUX_s_1_2_2(nand_99_nl, or_731_nl, fsm_output[4]);
  assign or_730_nl = (~ (fsm_output[4])) | (fsm_output[2]) | (~((fsm_output[1]) &
      (fsm_output[6])));
  assign mux_604_nl = MUX_s_1_2_2(mux_603_nl, or_730_nl, fsm_output[5]);
  assign or_728_nl = (~ (fsm_output[5])) | (fsm_output[4]) | (~ (fsm_output[2]))
      | (fsm_output[1]) | (fsm_output[6]);
  assign mux_605_nl = MUX_s_1_2_2(mux_604_nl, or_728_nl, fsm_output[3]);
  assign nor_101_nl = ~((fsm_output[0]) | mux_605_nl);
  assign nor_102_nl = ~((fsm_output[6:1]!=6'b000110));
  assign nor_103_nl = ~((fsm_output[6:1]!=6'b010010));
  assign mux_602_nl = MUX_s_1_2_2(nor_102_nl, nor_103_nl, fsm_output[0]);
  assign modulo_add_base_1_sva_mx0c0 = MUX_s_1_2_2(nor_101_nl, mux_602_nl, fsm_output[7]);
  assign modulo_add_base_1_sva_mx0c1 = and_dcpl_141 & and_dcpl_47;
  assign modulo_add_base_1_sva_mx0c4 = and_dcpl_141 & and_dcpl_224;
  assign modulo_add_base_1_sva_mx0c5 = and_dcpl_93 & and_dcpl_116;
  assign modulo_add_base_1_sva_mx0c8 = and_dcpl_93 & and_dcpl_59;
  assign modulo_add_base_1_sva_mx0c9 = and_dcpl_147 & and_dcpl_224;
  assign modulo_add_base_1_sva_mx0c12 = and_dcpl_90 & and_dcpl_239;
  assign modulo_add_base_1_sva_mx0c13 = and_dcpl_104 & and_dcpl_47;
  assign modulo_add_base_1_sva_mx0c16 = and_dcpl_104 & and_dcpl_224;
  assign modulo_add_base_1_sva_mx0c17 = and_dcpl_152 & and_dcpl_116;
  assign modulo_add_base_1_sva_mx0c20 = and_dcpl_152 & and_dcpl_59;
  assign modulo_add_base_1_sva_mx0c21 = and_dcpl_112 & and_dcpl_224;
  assign modulo_add_base_1_sva_mx0c24 = and_dcpl_40 & and_dcpl_239;
  assign modulo_sub_1_mux_itm_mx0c1 = and_dcpl_251 & and_dcpl_177 & (fsm_output[2])
      & (~ (acc_7_cse_32_1[31]));
  assign modulo_sub_2_mux_itm_mx0c1 = and_dcpl_259 & and_dcpl_36 & (fsm_output[2])
      & (~ (acc_6_cse_32_1[31]));
  assign modulo_sub_5_mux_itm_mx0c1 = and_dcpl_271 & and_dcpl_209 & (fsm_output[2])
      & (~ (acc_6_cse_32_1[31]));
  assign modulo_sub_6_mux_itm_mx0c1 = and_dcpl_278 & and_dcpl_177 & (~ (fsm_output[2]))
      & (~ (acc_9_cse_32_1[31]));
  assign modulo_sub_9_mux_itm_mx0c1 = and_dcpl_286 & and_dcpl_61 & (~ (fsm_output[2]))
      & (~ (acc_5_cse_32_1[31]));
  assign modulo_sub_10_mux_itm_mx0c1 = and_dcpl_293 & and_dcpl_61 & (~ (fsm_output[2]))
      & (~ (acc_7_cse_32_1[31]));
  assign modulo_sub_13_mux_itm_mx0c1 = and_dcpl_301 & and_dcpl_177 & (fsm_output[2])
      & (~ (acc_6_cse_32_1[31]));
  assign modulo_sub_14_mux_itm_mx0c1 = and_dcpl_308 & and_dcpl_36 & (fsm_output[2])
      & (~ (acc_9_cse_32_1[31]));
  assign modulo_sub_17_mux_itm_mx0c1 = and_dcpl_316 & and_dcpl_209 & (fsm_output[2])
      & (~ (acc_6_cse_32_1[31]));
  assign modulo_sub_18_mux_itm_mx0c1 = and_dcpl_323 & and_dcpl_177 & (~ (fsm_output[2]))
      & (~ (acc_9_cse_32_1[31]));
  assign modulo_sub_21_mux_itm_mx0c1 = and_dcpl_330 & and_dcpl_61 & (~ (fsm_output[2]))
      & (~ (acc_6_cse_32_1[31]));
  assign modulo_sub_22_mux_itm_mx0c1 = and_dcpl_181 & and_dcpl_61 & (~ (fsm_output[2]))
      & (~ (acc_9_cse_32_1[31]));
  assign xor_dcpl_2 = ~((fsm_output[6]) ^ (fsm_output[5]));
  assign nor_268_nl = ~((fsm_output[5]) | (fsm_output[3]) | (~ (fsm_output[7])) |
      (fsm_output[1]) | (fsm_output[2]) | (~ (fsm_output[0])) | (fsm_output[6]));
  assign or_97_nl = (fsm_output[0]) | (fsm_output[6]);
  assign mux_87_nl = MUX_s_1_2_2(or_tmp_79, or_97_nl, fsm_output[2]);
  assign or_96_nl = (fsm_output[2]) | (fsm_output[0]) | (fsm_output[6]);
  assign mux_88_nl = MUX_s_1_2_2(mux_87_nl, or_96_nl, fsm_output[1]);
  assign and_393_nl = (fsm_output[7]) & (~ mux_88_nl);
  assign or_807_nl = (fsm_output[2]) | (fsm_output[6]);
  assign mux_85_nl = MUX_s_1_2_2(or_tmp_79, (~ (fsm_output[6])), fsm_output[2]);
  assign mux_86_nl = MUX_s_1_2_2(or_807_nl, mux_85_nl, fsm_output[1]);
  assign nor_269_nl = ~((fsm_output[7]) | mux_86_nl);
  assign mux_89_nl = MUX_s_1_2_2(and_393_nl, nor_269_nl, fsm_output[3]);
  assign and_392_nl = (fsm_output[5]) & mux_89_nl;
  assign mux_90_nl = MUX_s_1_2_2(nor_268_nl, and_392_nl, fsm_output[4]);
  assign and_97_nl = and_dcpl_93 & and_dcpl_88;
  assign and_99_nl = and_dcpl_93 & and_dcpl_97;
  assign butterFly_10_f1_or_1_nl = and_dcpl_101 | and_dcpl_103;
  assign and_110_nl = and_dcpl_108 & and_dcpl_107;
  assign and_111_nl = and_dcpl_108 & and_dcpl_42;
  assign and_116_nl = and_dcpl_40 & and_dcpl_100;
  assign and_118_nl = and_dcpl_40 & and_dcpl_116;
  assign xx_rsci_d_d = MUX1HOT_v_32_16_2(butterFly_10_f1_sva, modulo_sub_7_mux_itm,
      modulo_sub_4_mux_itm, butterFly_10_tw_asn_itm, modulo_sub_5_mux_itm, modulo_sub_6_mux_itm,
      butterFly_10_tw_h_asn_itm, reg_mult_3_res_lpi_4_dfm_cse_1, modulo_sub_15_mux_itm,
      modulo_sub_12_mux_itm, modulo_sub_13_mux_itm, modulo_sub_14_mux_itm, modulo_sub_23_mux_itm,
      modulo_sub_20_mux_itm, modulo_sub_21_mux_itm, modulo_sub_22_mux_itm, {and_dcpl_92
      , and_dcpl_94 , and_dcpl_95 , mux_90_nl , and_97_nl , and_99_nl , and_dcpl_99
      , butterFly_10_f1_or_1_nl , and_dcpl_105 , and_dcpl_106 , and_110_nl , and_111_nl
      , and_dcpl_113 , and_dcpl_114 , and_116_nl , and_118_nl});
  assign S2_COPY_LOOP_for_or_7_nl = xx_rsci_radr_d_mx0c0 | xx_rsci_radr_d_mx0c10
      | xx_rsci_radr_d_mx0c1 | xx_rsci_radr_d_mx0c2 | xx_rsci_radr_d_mx0c3 | xx_rsci_radr_d_mx0c4
      | xx_rsci_radr_d_mx0c5 | xx_rsci_radr_d_mx0c6 | xx_rsci_radr_d_mx0c7;
  assign S2_COPY_LOOP_for_mux1h_nl = MUX1HOT_v_5_3_2(S1_OUTER_LOOP_for_acc_cse_sva,
      ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg
      , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg}), S2_COPY_LOOP_for_i_5_0_sva_1_4_0,
      {S2_COPY_LOOP_for_or_7_nl , xx_rsci_radr_d_mx0c8 , and_dcpl_129});
  assign S2_COPY_LOOP_for_or_8_nl = xx_rsci_radr_d_mx0c0 | xx_rsci_radr_d_mx0c1 |
      xx_rsci_radr_d_mx0c2 | xx_rsci_radr_d_mx0c3 | xx_rsci_radr_d_mx0c4 | xx_rsci_radr_d_mx0c5
      | xx_rsci_radr_d_mx0c6 | xx_rsci_radr_d_mx0c7;
  assign S2_COPY_LOOP_for_mux1h_9_nl = MUX1HOT_v_2_4_2(S2_INNER_LOOP1_r_4_2_sva_1_0,
      (S1_OUTER_LOOP_for_acc_cse_sva[4:3]), ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg
      , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg}), (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[4:3]),
      {S2_COPY_LOOP_for_or_8_nl , xx_rsci_radr_d_mx0c8 , and_dcpl_129 , xx_rsci_radr_d_mx0c10});
  assign S2_COPY_LOOP_for_mux1h_10_nl = MUX1HOT_v_3_9_2(3'b101, 3'b011, 3'b001, 3'b110,
      3'b100, 3'b010, (S1_OUTER_LOOP_for_acc_cse_sva[2:0]), reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg,
      (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[2:0]), {xx_rsci_radr_d_mx0c1 , xx_rsci_radr_d_mx0c2
      , xx_rsci_radr_d_mx0c3 , xx_rsci_radr_d_mx0c4 , xx_rsci_radr_d_mx0c5 , xx_rsci_radr_d_mx0c6
      , xx_rsci_radr_d_mx0c8 , and_dcpl_129 , xx_rsci_radr_d_mx0c10});
  assign S2_COPY_LOOP_for_not_nl = ~ xx_rsci_radr_d_mx0c7;
  assign S2_COPY_LOOP_for_and_2_nl = MUX_v_3_2_2(3'b000, S2_COPY_LOOP_for_mux1h_10_nl,
      S2_COPY_LOOP_for_not_nl);
  assign S2_COPY_LOOP_for_or_5_nl = MUX_v_3_2_2(S2_COPY_LOOP_for_and_2_nl, 3'b111,
      xx_rsci_radr_d_mx0c0);
  assign xx_rsci_radr_d = {S2_COPY_LOOP_for_mux1h_nl , S2_COPY_LOOP_for_mux1h_9_nl
      , S2_COPY_LOOP_for_or_5_nl};
  assign S2_COPY_LOOP_for_S2_COPY_LOOP_for_mux_5_nl = MUX_v_5_2_2(S1_OUTER_LOOP_for_acc_cse_sva,
      S2_COPY_LOOP_for_i_5_0_sva_1_4_0, and_dcpl_103);
  assign S2_COPY_LOOP_for_mux1h_11_nl = MUX1HOT_s_1_3_2((reg_drf_revArr_ptr_smx_9_0_cse[4]),
      (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[4]), reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg,
      {and_dcpl_92 , and_dcpl_101 , and_dcpl_103});
  assign S2_COPY_LOOP_for_or_nl = (S2_COPY_LOOP_for_mux1h_11_nl & (~(xx_rsci_wadr_d_mx0c3
      | xx_rsci_wadr_d_mx0c4 | xx_rsci_wadr_d_mx0c6 | and_dcpl_99))) | xx_rsci_wadr_d_mx0c1
      | xx_rsci_wadr_d_mx0c2 | xx_rsci_wadr_d_mx0c5 | xx_rsci_wadr_d_mx0c7;
  assign S2_COPY_LOOP_for_or_9_nl = xx_rsci_wadr_d_mx0c1 | xx_rsci_wadr_d_mx0c2 |
      xx_rsci_wadr_d_mx0c3 | xx_rsci_wadr_d_mx0c4 | xx_rsci_wadr_d_mx0c5 | xx_rsci_wadr_d_mx0c6
      | xx_rsci_wadr_d_mx0c7 | and_dcpl_99;
  assign S2_COPY_LOOP_for_mux1h_12_nl = MUX1HOT_v_2_4_2((reg_drf_revArr_ptr_smx_9_0_cse[3:2]),
      S2_INNER_LOOP1_r_4_2_sva_1_0, (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[3:2]), ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg
      , (reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[2])}), {and_dcpl_92 , S2_COPY_LOOP_for_or_9_nl
      , and_dcpl_101 , and_dcpl_103});
  assign S2_COPY_LOOP_for_or_2_nl = xx_rsci_wadr_d_mx0c4 | xx_rsci_wadr_d_mx0c5;
  assign S2_COPY_LOOP_for_or_3_nl = xx_rsci_wadr_d_mx0c6 | xx_rsci_wadr_d_mx0c7;
  assign S2_COPY_LOOP_for_mux1h_13_nl = MUX1HOT_v_2_5_2((reg_drf_revArr_ptr_smx_9_0_cse[1:0]),
      2'b01, 2'b10, (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[1:0]), (reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[1:0]),
      {and_dcpl_92 , S2_COPY_LOOP_for_or_2_nl , S2_COPY_LOOP_for_or_3_nl , and_dcpl_101
      , and_dcpl_103});
  assign S2_COPY_LOOP_for_nor_1_nl = ~(xx_rsci_wadr_d_mx0c2 | xx_rsci_wadr_d_mx0c3);
  assign S2_COPY_LOOP_for_and_1_nl = MUX_v_2_2_2(2'b00, S2_COPY_LOOP_for_mux1h_13_nl,
      S2_COPY_LOOP_for_nor_1_nl);
  assign S2_COPY_LOOP_for_or_4_nl = xx_rsci_wadr_d_mx0c1 | and_dcpl_99;
  assign S2_COPY_LOOP_for_or_1_nl = MUX_v_2_2_2(S2_COPY_LOOP_for_and_1_nl, 2'b11,
      S2_COPY_LOOP_for_or_4_nl);
  assign xx_rsci_wadr_d = {S2_COPY_LOOP_for_S2_COPY_LOOP_for_mux_5_nl , S2_COPY_LOOP_for_or_nl
      , S2_COPY_LOOP_for_mux1h_12_nl , S2_COPY_LOOP_for_or_1_nl};
  assign or_163_nl = (fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[3]))
      | (fsm_output[6]);
  assign mux_128_nl = MUX_s_1_2_2(or_163_nl, or_tmp_145, fsm_output[7]);
  assign or_164_nl = (fsm_output[4]) | mux_128_nl;
  assign or_162_nl = (fsm_output[7]) | (~ (fsm_output[1])) | (~ (fsm_output[0]))
      | (fsm_output[3]) | (~ (fsm_output[6]));
  assign or_160_nl = (~ (fsm_output[3])) | (fsm_output[6]);
  assign mux_126_nl = MUX_s_1_2_2(or_160_nl, or_tmp_145, fsm_output[7]);
  assign mux_127_nl = MUX_s_1_2_2(or_162_nl, mux_126_nl, fsm_output[4]);
  assign mux_129_nl = MUX_s_1_2_2(or_164_nl, mux_127_nl, fsm_output[5]);
  assign nor_256_nl = ~((fsm_output[1]) | (fsm_output[0]) | (fsm_output[3]) | (~
      (fsm_output[6])));
  assign and_389_nl = (fsm_output[1]) & (fsm_output[0]) & (fsm_output[3]) & (~ (fsm_output[6]));
  assign mux_124_nl = MUX_s_1_2_2(nor_256_nl, and_389_nl, fsm_output[7]);
  assign mux_121_nl = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[3]);
  assign mux_122_nl = MUX_s_1_2_2((fsm_output[3]), mux_121_nl, fsm_output[1]);
  assign nor_257_nl = ~(and_371_cse | (fsm_output[3]) | (fsm_output[6]));
  assign mux_123_nl = MUX_s_1_2_2(mux_122_nl, nor_257_nl, fsm_output[7]);
  assign mux_125_nl = MUX_s_1_2_2(mux_124_nl, mux_123_nl, fsm_output[4]);
  assign nand_15_nl = ~((fsm_output[5]) & mux_125_nl);
  assign mux_130_nl = MUX_s_1_2_2(mux_129_nl, nand_15_nl, fsm_output[2]);
  assign xx_rsci_we_d_pff = ~ mux_130_nl;
  assign mux_141_nl = MUX_s_1_2_2(mux_tmp_134, mux_tmp_139, fsm_output[1]);
  assign mux_131_nl = MUX_s_1_2_2(or_718_cse, or_tmp_152, fsm_output[7]);
  assign mux_132_nl = MUX_s_1_2_2(mux_131_nl, or_165_cse, fsm_output[6]);
  assign or_168_nl = (fsm_output[4]) | mux_132_nl;
  assign mux_135_nl = MUX_s_1_2_2(mux_tmp_134, or_168_nl, fsm_output[2]);
  assign mux_140_nl = MUX_s_1_2_2(mux_tmp_139, mux_135_nl, fsm_output[1]);
  assign mux_142_nl = MUX_s_1_2_2(mux_141_nl, mux_140_nl, fsm_output[0]);
  assign xx_rsci_readA_r_ram_ir_internal_RMASK_B_d = ~ mux_142_nl;
  assign nor_249_nl = ~((~ (fsm_output[1])) | (~ (fsm_output[0])) | (fsm_output[5])
      | (fsm_output[6]));
  assign nor_250_nl = ~((fsm_output[1]) | (~((fsm_output[0]) & (fsm_output[5]) &
      (fsm_output[6]))));
  assign mux_164_nl = MUX_s_1_2_2(nor_249_nl, nor_250_nl, fsm_output[3]);
  assign nor_251_nl = ~((fsm_output[3]) | (fsm_output[1]) | (fsm_output[0]) | (fsm_output[5])
      | (fsm_output[6]));
  assign mux_165_nl = MUX_s_1_2_2(mux_164_nl, nor_251_nl, fsm_output[2]);
  assign and_141_nl = mux_165_nl & and_dcpl_50;
  assign nor_246_nl = ~((fsm_output[2]) | (~ (fsm_output[0])) | (fsm_output[1]) |
      (fsm_output[4]) | (~ (fsm_output[5])));
  assign and_386_nl = (fsm_output[2]) & (fsm_output[1]) & (fsm_output[4]) & (~ (fsm_output[5]));
  assign mux_168_nl = MUX_s_1_2_2(nor_246_nl, and_386_nl, fsm_output[3]);
  assign or_196_nl = (~ (fsm_output[1])) | (~ (fsm_output[4])) | (fsm_output[5]);
  assign or_195_nl = (fsm_output[1]) | (~ (fsm_output[4])) | (fsm_output[5]);
  assign mux_166_nl = MUX_s_1_2_2(or_196_nl, or_195_nl, fsm_output[0]);
  assign or_194_nl = (fsm_output[0]) | (fsm_output[1]) | (~ (fsm_output[4])) | (fsm_output[5]);
  assign mux_167_nl = MUX_s_1_2_2(mux_166_nl, or_194_nl, fsm_output[2]);
  assign nor_247_nl = ~((fsm_output[3]) | mux_167_nl);
  assign mux_169_nl = MUX_s_1_2_2(mux_168_nl, nor_247_nl, fsm_output[6]);
  assign nor_248_nl = ~((fsm_output[6]) | (~ (fsm_output[3])) | (fsm_output[2]) |
      (~((fsm_output[1:0]!=2'b10))) | (fsm_output[5:4]!=2'b01));
  assign mux_170_nl = MUX_s_1_2_2(mux_169_nl, nor_248_nl, fsm_output[7]);
  assign and_146_nl = and_dcpl_144 & and_dcpl_107;
  assign and_147_nl = and_dcpl_144 & and_dcpl_42;
  assign and_151_nl = and_dcpl_90 & and_dcpl_100;
  assign and_152_nl = and_dcpl_90 & and_dcpl_116;
  assign and_156_nl = and_dcpl_152 & and_dcpl_88;
  assign and_157_nl = and_dcpl_152 & and_dcpl_97;
  assign yy_rsci_d_d = MUX1HOT_v_32_15_2(butterFly_10_f1_sva, modulo_sub_3_mux_itm,
      modulo_sub_mux_itm, butterFly_10_tw_asn_itm, modulo_sub_1_mux_itm, modulo_sub_2_mux_itm,
      butterFly_10_tw_h_asn_itm, modulo_sub_11_mux_itm, modulo_sub_8_mux_itm, modulo_sub_9_mux_itm,
      modulo_sub_10_mux_itm, modulo_sub_19_mux_itm, modulo_sub_16_mux_itm, modulo_sub_17_mux_itm,
      modulo_sub_18_mux_itm, {and_141_nl , and_dcpl_142 , and_dcpl_143 , mux_170_nl
      , and_146_nl , and_147_nl , not_tmp_111 , and_dcpl_148 , and_dcpl_149 , and_151_nl
      , and_152_nl , and_dcpl_153 , and_dcpl_154 , and_156_nl , and_157_nl});
  assign S1_OUTER_LOOP_for_or_8_nl = yy_rsci_radr_d_mx0c1 | and_dcpl_91 | yy_rsci_radr_d_mx0c2
      | and_dcpl_160 | and_dcpl_162 | yy_rsci_radr_d_mx0c5 | and_dcpl_164 | and_dcpl_165
      | and_dcpl_166;
  assign S1_OUTER_LOOP_for_mux1h_nl = MUX1HOT_v_5_3_2(({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg
      , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg}),
      S1_OUTER_LOOP_for_acc_cse_sva, S2_COPY_LOOP_for_i_5_0_sva_1_4_0, {yy_rsci_radr_d_mx0c0
      , S1_OUTER_LOOP_for_or_8_nl , yy_rsci_radr_d_mx0c9});
  assign S1_OUTER_LOOP_for_or_10_nl = yy_rsci_radr_d_mx0c1 | yy_rsci_radr_d_mx0c2
      | and_dcpl_160 | and_dcpl_162 | yy_rsci_radr_d_mx0c5 | and_dcpl_164 | and_dcpl_165
      | and_dcpl_166;
  assign S1_OUTER_LOOP_for_mux1h_5_nl = MUX1HOT_v_2_4_2((S1_OUTER_LOOP_for_acc_cse_sva[4:3]),
      S2_INNER_LOOP1_r_4_2_sva_1_0, ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg}),
      (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[4:3]), {yy_rsci_radr_d_mx0c0 , S1_OUTER_LOOP_for_or_10_nl
      , yy_rsci_radr_d_mx0c9 , and_dcpl_91});
  assign S1_OUTER_LOOP_for_mux1h_6_nl = MUX1HOT_v_3_9_2((S1_OUTER_LOOP_for_acc_cse_sva[2:0]),
      3'b101, 3'b011, 3'b001, 3'b110, 3'b100, 3'b010, reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg,
      (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[2:0]), {yy_rsci_radr_d_mx0c0 , yy_rsci_radr_d_mx0c2
      , and_dcpl_160 , and_dcpl_162 , yy_rsci_radr_d_mx0c5 , and_dcpl_164 , and_dcpl_165
      , yy_rsci_radr_d_mx0c9 , and_dcpl_91});
  assign S1_OUTER_LOOP_for_not_5_nl = ~ and_dcpl_166;
  assign S1_OUTER_LOOP_for_and_3_nl = MUX_v_3_2_2(3'b000, S1_OUTER_LOOP_for_mux1h_6_nl,
      S1_OUTER_LOOP_for_not_5_nl);
  assign S1_OUTER_LOOP_for_or_6_nl = MUX_v_3_2_2(S1_OUTER_LOOP_for_and_3_nl, 3'b111,
      yy_rsci_radr_d_mx0c1);
  assign yy_rsci_radr_d = {S1_OUTER_LOOP_for_mux1h_nl , S1_OUTER_LOOP_for_mux1h_5_nl
      , S1_OUTER_LOOP_for_or_6_nl};
  assign S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_mux_nl = MUX_v_5_2_2(S1_OUTER_LOOP_for_acc_cse_sva,
      S2_COPY_LOOP_for_i_5_0_sva_1_4_0, yy_rsci_wadr_d_mx0c1);
  assign S1_OUTER_LOOP_for_mux1h_7_nl = MUX1HOT_s_1_3_2((S2_COPY_LOOP_for_i_5_0_sva_1_4_0[4]),
      reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg, (reg_drf_revArr_ptr_smx_9_0_cse[4]), {yy_rsci_wadr_d_mx0c0
      , yy_rsci_wadr_d_mx0c1 , yy_rsci_wadr_d_mx0c10});
  assign S1_OUTER_LOOP_for_or_1_nl = (S1_OUTER_LOOP_for_mux1h_7_nl & (~(yy_rsci_wadr_d_mx0c4
      | yy_rsci_wadr_d_mx0c5 | yy_rsci_wadr_d_mx0c7 | not_tmp_111))) | yy_rsci_wadr_d_mx0c2
      | yy_rsci_wadr_d_mx0c3 | yy_rsci_wadr_d_mx0c6 | yy_rsci_wadr_d_mx0c8;
  assign S1_OUTER_LOOP_for_or_9_nl = yy_rsci_wadr_d_mx0c2 | yy_rsci_wadr_d_mx0c3
      | yy_rsci_wadr_d_mx0c4 | yy_rsci_wadr_d_mx0c5 | yy_rsci_wadr_d_mx0c6 | yy_rsci_wadr_d_mx0c7
      | yy_rsci_wadr_d_mx0c8 | not_tmp_111;
  assign S1_OUTER_LOOP_for_mux1h_8_nl = MUX1HOT_v_2_4_2((S2_COPY_LOOP_for_i_5_0_sva_1_4_0[3:2]),
      ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg , (reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[2])}),
      S2_INNER_LOOP1_r_4_2_sva_1_0, (reg_drf_revArr_ptr_smx_9_0_cse[3:2]), {yy_rsci_wadr_d_mx0c0
      , yy_rsci_wadr_d_mx0c1 , S1_OUTER_LOOP_for_or_9_nl , yy_rsci_wadr_d_mx0c10});
  assign S1_OUTER_LOOP_for_or_3_nl = yy_rsci_wadr_d_mx0c5 | yy_rsci_wadr_d_mx0c6;
  assign S1_OUTER_LOOP_for_or_4_nl = yy_rsci_wadr_d_mx0c7 | yy_rsci_wadr_d_mx0c8;
  assign S1_OUTER_LOOP_for_mux1h_9_nl = MUX1HOT_v_2_5_2((S2_COPY_LOOP_for_i_5_0_sva_1_4_0[1:0]),
      (reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[1:0]), 2'b01, 2'b10, (reg_drf_revArr_ptr_smx_9_0_cse[1:0]),
      {yy_rsci_wadr_d_mx0c0 , yy_rsci_wadr_d_mx0c1 , S1_OUTER_LOOP_for_or_3_nl ,
      S1_OUTER_LOOP_for_or_4_nl , yy_rsci_wadr_d_mx0c10});
  assign S1_OUTER_LOOP_for_nor_1_nl = ~(yy_rsci_wadr_d_mx0c3 | yy_rsci_wadr_d_mx0c4);
  assign S1_OUTER_LOOP_for_and_2_nl = MUX_v_2_2_2(2'b00, S1_OUTER_LOOP_for_mux1h_9_nl,
      S1_OUTER_LOOP_for_nor_1_nl);
  assign S1_OUTER_LOOP_for_or_5_nl = yy_rsci_wadr_d_mx0c2 | not_tmp_111;
  assign S1_OUTER_LOOP_for_or_2_nl = MUX_v_2_2_2(S1_OUTER_LOOP_for_and_2_nl, 2'b11,
      S1_OUTER_LOOP_for_or_5_nl);
  assign yy_rsci_wadr_d = {S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_mux_nl , S1_OUTER_LOOP_for_or_1_nl
      , S1_OUTER_LOOP_for_mux1h_8_nl , S1_OUTER_LOOP_for_or_2_nl};
  assign nand_143_cse = ~((fsm_output[1]) & (fsm_output[7]));
  assign mux_192_nl = MUX_s_1_2_2((~ or_tmp_215), nor_tmp_34, fsm_output[3]);
  assign nor_226_nl = ~((fsm_output[3]) | (fsm_output[7]) | (~ (fsm_output[4])));
  assign mux_193_nl = MUX_s_1_2_2(mux_192_nl, nor_226_nl, fsm_output[6]);
  assign nor_227_nl = ~((fsm_output[3]) | (fsm_output[7]) | (fsm_output[4]));
  assign nor_228_nl = ~((~ (fsm_output[3])) | (fsm_output[1]) | (~ (fsm_output[0]))
      | (fsm_output[7]) | (fsm_output[4]));
  assign mux_191_nl = MUX_s_1_2_2(nor_227_nl, nor_228_nl, fsm_output[6]);
  assign mux_194_nl = MUX_s_1_2_2(mux_193_nl, mux_191_nl, fsm_output[5]);
  assign nor_230_nl = ~((fsm_output[0]) | (fsm_output[7]) | (fsm_output[4]));
  assign mux_188_nl = MUX_s_1_2_2(nor_230_nl, nor_tmp_34, fsm_output[1]);
  assign nand_142_nl = ~(nand_143_cse & (fsm_output[4]));
  assign mux_189_nl = MUX_s_1_2_2((~ mux_188_nl), nand_142_nl, fsm_output[3]);
  assign or_231_nl = and_371_cse | (fsm_output[7]) | (~ (fsm_output[4]));
  assign mux_187_nl = MUX_s_1_2_2(or_231_nl, or_tmp_215, fsm_output[3]);
  assign mux_190_nl = MUX_s_1_2_2(mux_189_nl, mux_187_nl, fsm_output[6]);
  assign nor_229_nl = ~((fsm_output[5]) | mux_190_nl);
  assign yy_rsci_we_d_pff = MUX_s_1_2_2(mux_194_nl, nor_229_nl, fsm_output[2]);
  assign mux_202_nl = MUX_s_1_2_2(mux_tmp_197, mux_tmp_200, fsm_output[1]);
  assign mux_196_nl = MUX_s_1_2_2(or_242_cse, or_tmp_227, fsm_output[6]);
  assign mux_198_nl = MUX_s_1_2_2(mux_tmp_197, mux_196_nl, fsm_output[2]);
  assign mux_201_nl = MUX_s_1_2_2(mux_tmp_200, mux_198_nl, fsm_output[1]);
  assign mux_203_nl = MUX_s_1_2_2(mux_202_nl, mux_201_nl, fsm_output[0]);
  assign or_240_nl = (fsm_output[6:3]!=4'b0100);
  assign mux_204_nl = MUX_s_1_2_2(mux_203_nl, or_240_nl, fsm_output[7]);
  assign yy_rsci_readA_r_ram_ir_internal_RMASK_B_d = ~ mux_204_nl;
  assign nor_372_nl = ~((fsm_output[4:1]!=4'b1100) | mux_51_cse);
  assign nor_363_nl = ~((fsm_output[1]) | (fsm_output[4]) | mux_290_cse);
  assign and_911_nl = (fsm_output[1]) & (fsm_output[4]) & (~ mux_290_cse);
  assign mux_640_nl = MUX_s_1_2_2(nor_363_nl, and_911_nl, fsm_output[3]);
  assign and_910_nl = (fsm_output[2]) & mux_640_nl;
  assign not_tmp_358 = MUX_s_1_2_2(nor_372_nl, and_910_nl, fsm_output[0]);
  assign and_dcpl_372 = (fsm_output[2]) & (~ (fsm_output[0]));
  assign and_dcpl_639 = (fsm_output[1]) & (~ (fsm_output[3])) & and_dcpl_372;
  assign and_dcpl_649 = and_dcpl_39 & (fsm_output[5:4]==2'b01);
  assign and_dcpl_662 = ~((fsm_output[7:4]!=4'b0001));
  assign and_dcpl_665 = and_dcpl_36 & (fsm_output[2]) & (~ (fsm_output[0]));
  assign and_dcpl_730 = (fsm_output[7:4]==4'b0111);
  assign and_428_ssc = xor_dcpl & and_dcpl_55 & (fsm_output[3:0]==4'b0110);
  assign mux_665_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[5]);
  assign or_tmp_789 = (fsm_output[6]) | mux_665_nl;
  assign mux_tmp_665 = MUX_s_1_2_2(or_tmp_789, mux_tmp_210, or_242_cse);
  assign mux_684_nl = MUX_s_1_2_2(mux_337_cse, mux_290_cse, fsm_output[4]);
  assign mux_tmp_684 = MUX_s_1_2_2(nand_59_cse, mux_684_nl, fsm_output[3]);
  assign nand_tmp_104 = (~((fsm_output[4:3]!=2'b00))) | mux_290_cse;
  assign nor_tmp_111 = (fsm_output[6]) & (fsm_output[3]);
  assign nor_419_nl = ~((fsm_output[6]) | (~ (fsm_output[3])));
  assign mux_699_itm = MUX_s_1_2_2(nor_419_nl, nor_tmp_111, fsm_output[5]);
  always @(posedge clk) begin
    if ( core_wen & mux_31_nl ) begin
      m_sva <= m_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( core_wen ) begin
      x_rsci_s_raddr_core_4_0 <= MUX_v_5_2_2(({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg
          , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg}),
          S2_COPY_LOOP_for_i_5_0_sva_1_4_0, and_dcpl_44);
      x_rsci_s_raddr_core_9_5 <= MUX_v_5_2_2(S2_COPY_LOOP_for_i_5_0_sva_1_4_0, S1_OUTER_LOOP_for_acc_cse_sva,
          and_dcpl_44);
      x_rsci_s_waddr_core_4_0 <= MUX_v_5_2_2(S2_COPY_LOOP_for_i_5_0_sva_1_4_0, ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg
          , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg}),
          and_dcpl_48);
      x_rsci_s_waddr_core_9_5 <= MUX_v_5_2_2(S1_OUTER_LOOP_for_acc_cse_sva, S2_COPY_LOOP_for_i_5_0_sva_1_4_0,
          and_dcpl_48);
      x_rsci_s_dout_core <= xx_rsci_q_d;
      reg_twiddle_rsci_s_raddr_core_1_cse <= ((reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[1])
          & (~(mux_60_nl | (fsm_output[4])))) | (and_dcpl_63 & and_dcpl_61 & (~ (fsm_output[2])));
      reg_twiddle_rsci_s_raddr_core_2_cse <= MUX1HOT_s_1_4_2((butterFly_tw_and_cse_3_2_sva_1[0]),
          butterFly_12_tw_and_cse_3_2_sva_0, butterFly_4_tw_and_cse_2_sva_mx0w2,
          (S2_INNER_LOOP1_r_4_2_sva_1_0[0]), {and_dcpl_68 , butterFly_tw_h_or_2_nl
          , and_58_nl , and_dcpl_76});
      reg_twiddle_rsci_s_raddr_core_0_cse <= ((reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg[0])
          & (~(mux_64_nl | (fsm_output[4])))) | (~((~ and_dcpl_63) | (fsm_output[0])
          | (fsm_output[3]) | (fsm_output[2])));
      reg_twiddle_rsci_s_raddr_core_3_cse <= MUX1HOT_s_1_4_2((butterFly_tw_and_cse_3_2_sva_1[1]),
          butterFly_12_tw_and_cse_3_2_sva_1, (S2_INNER_LOOP1_r_4_2_sva_1_0[1]), (S2_INNER_LOOP1_r_4_2_sva_1_0[1]),
          {and_dcpl_68 , and_dcpl_70 , and_87_nl , and_dcpl_76});
      revArr_rsci_s_raddr_core <= S1_OUTER_LOOP_for_acc_cse_sva;
      reg_tw_rsci_s_raddr_core_cse <= S34_OUTER_LOOP_for_tf_mul_cmp_z_oreg;
      S34_OUTER_LOOP_for_tf_mul_cmp_a <= MUX_v_5_2_2(5'b00000, S34_OUTER_LOOP_for_tf_mux_1_nl,
          not_1247_nl);
      S34_OUTER_LOOP_for_k_sva_4_0 <= MUX_v_5_2_2(5'b00000, S34_OUTER_LOOP_for_k_mux_nl,
          not_1487_nl);
      reg_drf_revArr_ptr_smx_9_0_cse <= revArr_rsci_s_din_mxwt[4:0];
      mult_3_res_sva <= readslicef_33_32_1(acc_2_nl);
      reg_mult_3_res_lpi_4_dfm_cse_1 <= MUX_v_32_2_2((readslicef_33_32_1(acc_3_nl)),
          mult_3_res_sva, readslicef_34_1_33(acc_13_nl));
      modulo_sub_3_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_9_cse_32_1[30:0])}), modulo_sub_3_qif_acc_nl,
          acc_9_cse_32_1[31]);
      modulo_sub_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_5_cse_32_1[30:0])}), modulo_sub_qif_acc_nl,
          acc_5_cse_32_1[31]);
      modulo_sub_7_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_5_cse_32_1[30:0])}), modulo_sub_7_qif_acc_nl,
          acc_5_cse_32_1[31]);
      modulo_sub_4_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_7_cse_32_1[30:0])}), modulo_sub_4_qif_acc_nl,
          acc_7_cse_32_1[31]);
      modulo_sub_11_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_6_cse_32_1[30:0])}), modulo_sub_11_qif_acc_nl,
          acc_6_cse_32_1[31]);
      modulo_sub_8_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_9_cse_32_1[30:0])}), modulo_sub_8_qif_acc_nl,
          acc_9_cse_32_1[31]);
      S34_OUTER_LOOP_for_tf_h_sva <= tw_h_rsci_s_din_mxwt;
      S34_OUTER_LOOP_for_tf_sva <= tw_rsci_s_din_mxwt;
      modulo_sub_15_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_5_cse_32_1[30:0])}), modulo_sub_15_qif_acc_nl,
          acc_5_cse_32_1[31]);
      modulo_sub_12_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_7_cse_32_1[30:0])}), modulo_sub_12_qif_acc_nl,
          acc_7_cse_32_1[31]);
      modulo_sub_19_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_5_cse_32_1[30:0])}), modulo_sub_19_qif_acc_nl,
          acc_5_cse_32_1[31]);
      modulo_sub_16_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_7_cse_32_1[30:0])}), modulo_sub_16_qif_acc_nl,
          acc_7_cse_32_1[31]);
      modulo_sub_23_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_5_cse_32_1[30:0])}), modulo_sub_23_qif_acc_nl,
          acc_5_cse_32_1[31]);
      modulo_sub_20_mux_itm <= MUX_v_32_2_2(({1'b0 , (acc_7_cse_32_1[30:0])}), modulo_sub_20_qif_acc_nl,
          acc_7_cse_32_1[31]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_x_rsci_oswt_cse <= 1'b0;
      reg_x_rsci_oswt_1_cse <= 1'b0;
      reg_twiddle_rsci_oswt_cse <= 1'b0;
      reg_revArr_rsci_oswt_cse <= 1'b0;
      reg_tw_rsci_oswt_cse <= 1'b0;
      reg_xx_rsc_cgo_cse <= 1'b0;
      reg_yy_rsc_cgo_cse <= 1'b0;
      reg_x_rsc_triosy_obj_iswt0_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      reg_ensig_cgo_1_cse <= 1'b0;
      reg_modulo_add_3_slc_32_svs_st_cse <= 1'b0;
      reg_modulo_add_slc_32_svs_st_cse <= 1'b0;
      reg_modulo_add_1_slc_32_svs_st_cse <= 1'b0;
      reg_modulo_add_7_slc_32_svs_st_cse <= 1'b0;
      reg_modulo_add_4_slc_32_svs_st_cse <= 1'b0;
      reg_modulo_add_5_slc_32_svs_st_cse <= 1'b0;
      reg_modulo_add_6_slc_32_svs_st_cse <= 1'b0;
    end
    else if ( core_wen ) begin
      reg_x_rsci_oswt_cse <= and_dcpl_33 & ((fsm_output[0]) ^ (fsm_output[1])) &
          and_dcpl_31 & and_dcpl_30;
      reg_x_rsci_oswt_1_cse <= and_dcpl_40 & and_dcpl_36 & (~ (fsm_output[2]));
      reg_twiddle_rsci_oswt_cse <= ~ mux_54_nl;
      reg_revArr_rsci_oswt_cse <= and_dcpl_67 & and_dcpl_54;
      reg_tw_rsci_oswt_cse <= and_dcpl_91;
      reg_xx_rsc_cgo_cse <= mux_84_rmff;
      reg_yy_rsc_cgo_cse <= ~ mux_163_itm;
      reg_x_rsc_triosy_obj_iswt0_cse <= and_dcpl_181 & and_dcpl_177 & (fsm_output[2])
          & (S1_OUTER_LOOP_k_5_0_sva_2[5]);
      reg_ensig_cgo_cse <= and_188_rmff;
      reg_ensig_cgo_1_cse <= ~ mux_222_itm;
      reg_modulo_add_3_slc_32_svs_st_cse <= readslicef_34_1_33(acc_15_nl);
      reg_modulo_add_slc_32_svs_st_cse <= readslicef_34_1_33(acc_17_nl);
      reg_modulo_add_1_slc_32_svs_st_cse <= readslicef_34_1_33(acc_19_nl);
      reg_modulo_add_7_slc_32_svs_st_cse <= readslicef_34_1_33(acc_20_nl);
      reg_modulo_add_4_slc_32_svs_st_cse <= readslicef_34_1_33(acc_14_nl);
      reg_modulo_add_5_slc_32_svs_st_cse <= readslicef_34_1_33(acc_18_nl);
      reg_modulo_add_6_slc_32_svs_st_cse <= readslicef_34_1_33(acc_21_nl);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((z_out_2[2]) | (~ (S1_OUTER_LOOP_k_5_0_sva_2[5])) | operator_20_true_8_slc_operator_20_true_8_acc_14_itm)
        ) begin
      S34_OUTER_LOOP_for_k_slc_S34_OUTER_LOOP_for_k_sva_19_5_4_0_1 <= MUX_v_5_2_2(5'b00000,
          (S1_OUTER_LOOP_for_p_sva_1[9:5]), and_191_nl);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_677_nl) & core_wen ) begin
      reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg <= (S1_OUTER_LOOP_k_5_0_sva_2[4]) & S2_COPY_LOOP_p_or_1_seb;
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_697_nl) & core_wen ) begin
      reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg <= S2_COPY_LOOP_p_S2_COPY_LOOP_p_mux_nl
          & S2_COPY_LOOP_p_or_1_seb;
    end
  end
  always @(posedge clk) begin
    if ( mux_705_nl & core_wen ) begin
      reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg <= MUX_v_3_2_2(3'b000, S2_COPY_LOOP_p_S2_COPY_LOOP_p_mux_1_nl,
          S2_COPY_LOOP_p_or_1_seb);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      S2_COPY_LOOP_for_i_5_0_sva_1_5 <= 1'b0;
    end
    else if ( (~ mux_719_nl) & core_wen ) begin
      S2_COPY_LOOP_for_i_5_0_sva_1_5 <= S2_COPY_LOOP_for_i_S2_COPY_LOOP_for_i_mux_rgt[5];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      S2_COPY_LOOP_for_i_5_0_sva_1_4_0 <= 5'b00000;
    end
    else if ( mux_729_nl & core_wen ) begin
      S2_COPY_LOOP_for_i_5_0_sva_1_4_0 <= S2_COPY_LOOP_for_i_S2_COPY_LOOP_for_i_mux_rgt[4:0];
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (((~ mux_351_nl) & and_dcpl_65 & (~ (fsm_output[2]))) | S1_OUTER_LOOP_for_p_sva_1_mx0c1)
        ) begin
      S1_OUTER_LOOP_for_p_sva_1 <= MUX_v_20_2_2(z_out_2, ({5'b00000 , S1_OUTER_LOOP_for_p_S1_OUTER_LOOP_for_p_and_nl}),
          S1_OUTER_LOOP_for_p_sva_1_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (~(or_tmp_384 | or_dcpl_17 | (fsm_output[3:2]!=2'b00))) ) begin
      operator_20_true_1_slc_operator_20_true_1_acc_14_itm <= operator_20_true_1_acc_1_itm_14;
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (S1_OUTER_LOOP_for_acc_cse_sva_mx0c0 | S1_OUTER_LOOP_for_acc_cse_sva_mx0c1
        | S1_OUTER_LOOP_for_acc_cse_sva_mx0c2 | S1_OUTER_LOOP_for_acc_cse_sva_mx0c3
        | and_dcpl_129) ) begin
      S1_OUTER_LOOP_for_acc_cse_sva <= MUX_v_5_2_2(5'b00000, S1_OUTER_LOOP_for_mux1h_3_nl,
          S1_OUTER_LOOP_for_not_4_nl);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (butterFly_10_f1_sva_mx0c0 | butterFly_10_f1_sva_mx0c1 | butterFly_10_f1_sva_mx0c2
        | butterFly_10_f1_sva_mx0c3) ) begin
      butterFly_10_f1_sva <= MUX1HOT_v_32_4_2(x_rsci_s_din_mxwt, yy_rsci_q_d, twiddle_h_rsci_s_din_mxwt,
          xx_rsci_q_d, {butterFly_10_f1_sva_mx0c0 , butterFly_10_f1_sva_mx0c1 , butterFly_10_f1_sva_mx0c2
          , butterFly_10_f1_sva_mx0c3});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      S2_OUTER_LOOP_c_1_sva <= 1'b0;
    end
    else if ( core_wen & ((and_dcpl_67 & and_dcpl_47) | S2_OUTER_LOOP_c_1_sva_mx0c1
        | S2_OUTER_LOOP_c_1_sva_mx0c2) ) begin
      S2_OUTER_LOOP_c_1_sva <= (S2_OUTER_LOOP_c_1_sva | (z_out_2[2])) & (S2_OUTER_LOOP_c_1_sva_mx0c1
          | S2_OUTER_LOOP_c_1_sva_mx0c2);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (((~ mux_415_nl) & and_371_cse & (fsm_output[3])) | S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c1
        | S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c2) ) begin
      S2_INNER_LOOP1_r_4_2_sva_1_0 <= MUX_v_2_2_2(2'b00, S2_INNER_LOOP1_r_mux_nl,
          S2_INNER_LOOP1_r_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_733_nl) & (~ (fsm_output[4])) & core_wen ) begin
      butterFly_12_tw_and_cse_3_2_sva_1 <= butterFly_tw_butterFly_tw_mux_rgt[1];
    end
  end
  always @(posedge clk) begin
    if ( mux_736_nl & (fsm_output[0]) & (fsm_output[2]) & (~ (fsm_output[4])) & core_wen
        ) begin
      butterFly_12_tw_and_cse_3_2_sva_0 <= butterFly_tw_butterFly_tw_mux_rgt[0];
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (butterFly_10_tw_asn_itm_mx0c0 | butterFly_10_tw_asn_itm_mx0c1
        | butterFly_10_tw_asn_itm_mx0c2) ) begin
      butterFly_10_tw_asn_itm <= MUX1HOT_v_32_3_2(twiddle_rsci_s_din_mxwt, modulo_add_3_mux_itm_mx0w1,
          modulo_add_base_1_sva, {butterFly_10_tw_asn_itm_mx0c0 , butterFly_10_tw_asn_itm_mx0c1
          , butterFly_10_tw_asn_itm_mx0c2});
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (~((mux_483_nl | (fsm_output[5])) & mux_489_itm)) ) begin
      mult_x_1_sva <= MUX_v_32_2_2(yy_rsci_q_d, xx_rsci_q_d, mux_489_itm);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (mux_526_cse | butterFly_13_tw_h_asn_itm_mx0c1 | butterFly_13_tw_h_asn_itm_mx0c2)
        ) begin
      butterFly_13_tw_h_asn_itm <= MUX1HOT_v_32_3_2(twiddle_h_rsci_s_din_mxwt, (mult_z_mul_cmp_z[31:0]),
          mult_12_z_mul_cmp_z, {mux_526_cse , butterFly_13_tw_h_asn_itm_mx0c1 , butterFly_13_tw_h_asn_itm_mx0c2});
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (((~ mux_521_nl) & and_dcpl_31) | and_dcpl_162) ) begin
      mult_x_15_sva <= MUX_v_32_2_2(xx_rsci_q_d, yy_rsci_q_d, and_dcpl_162);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (butterFly_10_tw_h_asn_itm_mx0c0 | butterFly_10_tw_h_asn_itm_mx0c1
        | butterFly_10_tw_h_asn_itm_mx0c2 | butterFly_10_tw_h_asn_itm_mx0c3 | butterFly_10_tw_h_asn_itm_mx0c4)
        ) begin
      butterFly_10_tw_h_asn_itm <= MUX1HOT_v_32_5_2(twiddle_h_rsci_s_din_mxwt, (mult_z_mul_cmp_z[31:0]),
          modulo_add_3_mux_itm_mx0w1, modulo_add_base_1_sva, mult_12_z_mul_cmp_z,
          {butterFly_10_tw_h_asn_itm_mx0c0 , butterFly_10_tw_h_asn_itm_mx0c1 , butterFly_10_tw_h_asn_itm_mx0c2
          , butterFly_10_tw_h_asn_itm_mx0c3 , butterFly_10_tw_h_asn_itm_mx0c4});
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c0 | mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c1
        | and_dcpl_160) ) begin
      mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm <= MUX1HOT_v_32_3_2(xx_rsci_q_d, (mult_z_mul_cmp_z[31:0]),
          yy_rsci_q_d, {mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c0 , mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm_mx0c1
          , and_dcpl_160});
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (~ mux_587_nl) ) begin
      operator_96_false_10_operator_96_false_10_slc_mult_10_t_mul_51_20_itm <= mult_z_mul_cmp_z[51:20];
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((~(mux_589_nl | (fsm_output[5]))) | and_dcpl_165) ) begin
      butterFly_14_f1_sva <= MUX_v_32_2_2(xx_rsci_q_d, yy_rsci_q_d, and_dcpl_165);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((~(mux_596_nl | (fsm_output[5]))) | and_dcpl_166) ) begin
      butterFly_11_f1_sva <= MUX_v_32_2_2(xx_rsci_q_d, yy_rsci_q_d, and_dcpl_166);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (modulo_add_base_1_sva_mx0c0 | modulo_add_base_1_sva_mx0c1 |
        and_dcpl_142 | and_dcpl_143 | modulo_add_base_1_sva_mx0c4 | modulo_add_base_1_sva_mx0c5
        | and_dcpl_94 | and_dcpl_95 | modulo_add_base_1_sva_mx0c8 | modulo_add_base_1_sva_mx0c9
        | and_dcpl_148 | and_dcpl_149 | modulo_add_base_1_sva_mx0c12 | modulo_add_base_1_sva_mx0c13
        | and_dcpl_105 | and_dcpl_106 | modulo_add_base_1_sva_mx0c16 | modulo_add_base_1_sva_mx0c17
        | and_dcpl_153 | and_dcpl_154 | modulo_add_base_1_sva_mx0c20 | modulo_add_base_1_sva_mx0c21
        | and_dcpl_113 | and_dcpl_114 | modulo_add_base_1_sva_mx0c24) ) begin
      modulo_add_base_1_sva <= MUX1HOT_v_32_25_2((mult_z_mul_cmp_z[31:0]), modulo_add_base_3_sva_mx0w1,
          modulo_add_base_sva_mx0w2, modulo_add_base_1_sva_mx0w3, modulo_add_base_2_sva_mx0w4,
          modulo_add_base_7_sva_mx0w5, modulo_add_base_4_sva_mx0w6, modulo_add_base_5_sva_mx0w7,
          modulo_add_base_6_sva_mx0w8, modulo_add_base_11_sva_mx0w9, modulo_add_base_8_sva_mx0w10,
          modulo_add_base_9_sva_mx0w11, modulo_add_base_10_sva_mx0w12, modulo_add_base_15_sva_mx0w13,
          modulo_add_base_12_sva_mx0w14, modulo_add_base_13_sva_mx0w15, modulo_add_base_14_sva_mx0w16,
          modulo_add_base_19_sva_mx0w17, modulo_add_base_16_sva_mx0w18, modulo_add_base_17_sva_mx0w19,
          modulo_add_base_18_sva_mx0w20, modulo_add_base_23_sva_mx0w21, modulo_add_base_20_sva_mx0w22,
          modulo_add_base_21_sva_mx0w23, modulo_add_base_22_sva_mx0w24, {modulo_add_base_1_sva_mx0c0
          , modulo_add_base_1_sva_mx0c1 , and_dcpl_142 , and_dcpl_143 , modulo_add_base_1_sva_mx0c4
          , modulo_add_base_1_sva_mx0c5 , and_dcpl_94 , and_dcpl_95 , modulo_add_base_1_sva_mx0c8
          , modulo_add_base_1_sva_mx0c9 , and_dcpl_148 , and_dcpl_149 , modulo_add_base_1_sva_mx0c12
          , modulo_add_base_1_sva_mx0c13 , and_dcpl_105 , and_dcpl_106 , modulo_add_base_1_sva_mx0c16
          , modulo_add_base_1_sva_mx0c17 , and_dcpl_153 , and_dcpl_154 , modulo_add_base_1_sva_mx0c20
          , modulo_add_base_1_sva_mx0c21 , and_dcpl_113 , and_dcpl_114 , modulo_add_base_1_sva_mx0c24});
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (((~ mux_623_nl) & and_dcpl_126) | and_dcpl_164) ) begin
      butterFly_15_f1_sva <= MUX_v_32_2_2(xx_rsci_q_d, yy_rsci_q_d, and_dcpl_164);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & mux_636_nl ) begin
      operator_96_false_15_operator_96_false_15_slc_mult_15_t_mul_51_20_itm <= mult_z_mul_cmp_z[51:20];
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_251 & and_dcpl_177 & (fsm_output[2]) & (acc_7_cse_32_1[31]))
        | modulo_sub_1_mux_itm_mx0c1) ) begin
      modulo_sub_1_mux_itm <= MUX_v_32_2_2(modulo_sub_1_qif_acc_nl, ({1'b0 , (acc_7_cse_32_1[30:0])}),
          modulo_sub_1_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_259 & and_dcpl_36 & (fsm_output[2]) & (acc_6_cse_32_1[31]))
        | modulo_sub_2_mux_itm_mx0c1) ) begin
      modulo_sub_2_mux_itm <= MUX_v_32_2_2(modulo_sub_2_qif_acc_nl, ({1'b0 , (acc_6_cse_32_1[30:0])}),
          modulo_sub_2_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_271 & and_dcpl_209 & (fsm_output[2]) & (acc_6_cse_32_1[31]))
        | modulo_sub_5_mux_itm_mx0c1) ) begin
      modulo_sub_5_mux_itm <= MUX_v_32_2_2(modulo_sub_5_qif_acc_nl, ({1'b0 , (acc_6_cse_32_1[30:0])}),
          modulo_sub_5_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_278 & and_dcpl_177 & (~ (fsm_output[2])) & (acc_9_cse_32_1[31]))
        | modulo_sub_6_mux_itm_mx0c1) ) begin
      modulo_sub_6_mux_itm <= MUX_v_32_2_2(modulo_sub_6_qif_acc_nl, ({1'b0 , (acc_9_cse_32_1[30:0])}),
          modulo_sub_6_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_286 & and_dcpl_61 & (~ (fsm_output[2])) & (acc_5_cse_32_1[31]))
        | modulo_sub_9_mux_itm_mx0c1) ) begin
      modulo_sub_9_mux_itm <= MUX_v_32_2_2(modulo_sub_9_qif_acc_nl, ({1'b0 , (acc_5_cse_32_1[30:0])}),
          modulo_sub_9_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_293 & and_dcpl_61 & (~ (fsm_output[2])) & (acc_7_cse_32_1[31]))
        | modulo_sub_10_mux_itm_mx0c1) ) begin
      modulo_sub_10_mux_itm <= MUX_v_32_2_2(modulo_sub_10_qif_acc_nl, ({1'b0 , (acc_7_cse_32_1[30:0])}),
          modulo_sub_10_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (~(or_tmp_352 | or_dcpl_44)) ) begin
      operator_20_true_8_slc_operator_20_true_8_acc_14_itm <= operator_20_true_1_acc_1_itm_14;
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_301 & and_dcpl_177 & (fsm_output[2]) & (acc_6_cse_32_1[31]))
        | modulo_sub_13_mux_itm_mx0c1) ) begin
      modulo_sub_13_mux_itm <= MUX_v_32_2_2(modulo_sub_13_qif_acc_nl, ({1'b0 , (acc_6_cse_32_1[30:0])}),
          modulo_sub_13_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_308 & and_dcpl_36 & (fsm_output[2]) & (acc_9_cse_32_1[31]))
        | modulo_sub_14_mux_itm_mx0c1) ) begin
      modulo_sub_14_mux_itm <= MUX_v_32_2_2(modulo_sub_14_qif_acc_nl, ({1'b0 , (acc_9_cse_32_1[30:0])}),
          modulo_sub_14_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_316 & and_dcpl_209 & (fsm_output[2]) & (acc_6_cse_32_1[31]))
        | modulo_sub_17_mux_itm_mx0c1) ) begin
      modulo_sub_17_mux_itm <= MUX_v_32_2_2(modulo_sub_17_qif_acc_nl, ({1'b0 , (acc_6_cse_32_1[30:0])}),
          modulo_sub_17_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_323 & and_dcpl_177 & (~ (fsm_output[2])) & (acc_9_cse_32_1[31]))
        | modulo_sub_18_mux_itm_mx0c1) ) begin
      modulo_sub_18_mux_itm <= MUX_v_32_2_2(modulo_sub_18_qif_acc_nl, ({1'b0 , (acc_9_cse_32_1[30:0])}),
          modulo_sub_18_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_330 & and_dcpl_61 & (~ (fsm_output[2])) & (acc_6_cse_32_1[31]))
        | modulo_sub_21_mux_itm_mx0c1) ) begin
      modulo_sub_21_mux_itm <= MUX_v_32_2_2(modulo_sub_21_qif_acc_nl, ({1'b0 , (acc_6_cse_32_1[30:0])}),
          modulo_sub_21_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_181 & and_dcpl_61 & (~ (fsm_output[2])) & (acc_9_cse_32_1[31]))
        | modulo_sub_22_mux_itm_mx0c1) ) begin
      modulo_sub_22_mux_itm <= MUX_v_32_2_2(modulo_sub_22_qif_acc_nl, ({1'b0 , (acc_9_cse_32_1[30:0])}),
          modulo_sub_22_mux_itm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (~(or_353_cse | nand_108_cse | or_dcpl_44)) ) begin
      operator_20_true_15_slc_operator_20_true_15_acc_14_itm <= operator_20_true_1_acc_1_itm_14;
    end
  end
  assign or_30_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4]) | (fsm_output[5]);
  assign mux_29_nl = MUX_s_1_2_2(mux_28_cse, and_372_cse, or_30_nl);
  assign and_405_nl = or_814_cse & (fsm_output[5:4]==2'b11);
  assign mux_27_nl = MUX_s_1_2_2(and_372_cse, (fsm_output[7]), and_405_nl);
  assign mux_30_nl = MUX_s_1_2_2(mux_29_nl, mux_27_nl, fsm_output[3]);
  assign and_402_nl = (fsm_output[5:3]==3'b111);
  assign mux_26_nl = MUX_s_1_2_2(and_372_cse, (fsm_output[7]), and_402_nl);
  assign mux_31_nl = MUX_s_1_2_2(mux_30_nl, mux_26_nl, fsm_output[2]);
  assign or_60_nl = and_371_cse | mux_290_cse;
  assign mux_52_nl = MUX_s_1_2_2(mux_51_cse, or_60_nl, fsm_output[3]);
  assign or_59_nl = (fsm_output[3]) | (fsm_output[0]) | (fsm_output[1]) | mux_556_cse;
  assign mux_53_nl = MUX_s_1_2_2(mux_52_nl, or_59_nl, fsm_output[4]);
  assign or_811_nl = nor_285_cse | mux_556_cse;
  assign mux_50_nl = MUX_s_1_2_2(nand_8_cse, or_811_nl, fsm_output[3]);
  assign or_57_nl = (fsm_output[4]) | mux_50_nl;
  assign mux_54_nl = MUX_s_1_2_2(mux_53_nl, or_57_nl, fsm_output[2]);
  assign or_65_nl = (fsm_output[1]) | mux_51_cse;
  assign mux_59_nl = MUX_s_1_2_2(or_65_nl, or_tmp_53, fsm_output[3]);
  assign or_61_nl = (fsm_output[0]) | mux_556_cse;
  assign mux_55_nl = MUX_s_1_2_2(nand_166_cse, or_61_nl, fsm_output[1]);
  assign mux_57_nl = MUX_s_1_2_2(nand_8_cse, mux_55_nl, fsm_output[3]);
  assign mux_60_nl = MUX_s_1_2_2(mux_59_nl, mux_57_nl, fsm_output[2]);
  assign butterFly_tw_h_or_2_nl = and_dcpl_70 | (xor_dcpl & or_dcpl_12 & and_dcpl_55
      & and_dcpl_45);
  assign and_58_nl = xor_dcpl & and_dcpl_55 & and_dcpl_54;
  assign or_809_nl = (fsm_output[1:0]!=2'b01) | mux_290_cse;
  assign mux_63_nl = MUX_s_1_2_2(or_tmp_58, or_809_nl, fsm_output[3]);
  assign mux_62_nl = MUX_s_1_2_2(nand_8_cse, nand_166_cse, fsm_output[3]);
  assign mux_64_nl = MUX_s_1_2_2(mux_63_nl, mux_62_nl, fsm_output[2]);
  assign nand_12_nl = ~((fsm_output[3]) & or_dcpl_12);
  assign mux_65_nl = MUX_s_1_2_2(nand_12_nl, or_tmp_59, fsm_output[2]);
  assign and_87_nl = (~ mux_65_nl) & xor_dcpl & and_dcpl_55;
  assign S34_OUTER_LOOP_for_tf_mux_1_nl = MUX_v_5_2_2(({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg
      , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg}),
      (S1_OUTER_LOOP_k_5_0_sva_2[4:0]), and_dcpl_29);
  assign not_1247_nl = ~ and_dcpl_189;
  assign S34_OUTER_LOOP_for_k_mux_nl = MUX_v_5_2_2((S1_OUTER_LOOP_for_p_sva_1[4:0]),
      (S1_OUTER_LOOP_k_5_0_sva_2[4:0]), and_dcpl_29);
  assign not_1487_nl = ~ and_dcpl_189;
  assign nor_429_nl = ~((~ (fsm_output[4])) | (~ (fsm_output[0])) | (fsm_output[6])
      | (~ (fsm_output[3])) | (fsm_output[5]) | (fsm_output[1]) | (fsm_output[7]));
  assign and_936_nl = (fsm_output[3]) & (fsm_output[5]) & (fsm_output[1]) & (fsm_output[7]);
  assign nor_430_nl = ~((~ (fsm_output[3])) | (fsm_output[5]) | (fsm_output[1]) |
      (fsm_output[7]));
  assign mux_739_nl = MUX_s_1_2_2(and_936_nl, nor_430_nl, fsm_output[6]);
  assign and_935_nl = (fsm_output[0]) & mux_739_nl;
  assign or_935_nl = (~ (fsm_output[1])) | (fsm_output[7]);
  assign mux_741_nl = MUX_s_1_2_2(nand_143_cse, or_935_nl, fsm_output[5]);
  assign or_934_nl = (fsm_output[3]) | mux_741_nl;
  assign or_936_nl = (~ (fsm_output[3])) | (~ (fsm_output[5])) | (fsm_output[1])
      | (fsm_output[7]);
  assign mux_740_nl = MUX_s_1_2_2(or_934_nl, or_936_nl, fsm_output[6]);
  assign nor_431_nl = ~((fsm_output[0]) | mux_740_nl);
  assign mux_738_nl = MUX_s_1_2_2(and_935_nl, nor_431_nl, fsm_output[4]);
  assign mux_737_nl = MUX_s_1_2_2(nor_429_nl, mux_738_nl, fsm_output[2]);
  assign nor_432_nl = ~((fsm_output[0]) | (fsm_output[2]) | (~ (fsm_output[4])));
  assign nor_433_nl = ~((fsm_output[0]) | (~ (fsm_output[2])) | (fsm_output[4]));
  assign mux_744_nl = MUX_s_1_2_2(nor_432_nl, nor_433_nl, fsm_output[6]);
  assign and_937_nl = (fsm_output[1]) & (fsm_output[3]) & mux_744_nl;
  assign nor_434_nl = ~((~ (fsm_output[1])) | (fsm_output[3]) | (fsm_output[6]) |
      (~ (fsm_output[0])) | (fsm_output[2]) | (~ (fsm_output[4])));
  assign mux_743_nl = MUX_s_1_2_2(and_937_nl, nor_434_nl, fsm_output[7]);
  assign and_938_nl = (fsm_output[3]) & (fsm_output[6]) & (fsm_output[0]) & (~ (fsm_output[2]))
      & (fsm_output[4]);
  assign nor_435_nl = ~((fsm_output[3]) | (fsm_output[6]) | (~ (fsm_output[0])) |
      (fsm_output[2]) | (~ (fsm_output[4])));
  assign mux_746_nl = MUX_s_1_2_2(and_938_nl, nor_435_nl, fsm_output[1]);
  assign nor_436_nl = ~((fsm_output[1]) | (~ (fsm_output[3])) | (fsm_output[6]) |
      (fsm_output[0]) | (~ (fsm_output[2])) | (fsm_output[4]));
  assign mux_745_nl = MUX_s_1_2_2(mux_746_nl, nor_436_nl, fsm_output[7]);
  assign mux_742_nl = MUX_s_1_2_2(mux_743_nl, mux_745_nl, fsm_output[5]);
  assign or_937_nl = (fsm_output[2]) | (~ (fsm_output[6])) | (~ (fsm_output[5]))
      | (fsm_output[7]) | (~ (fsm_output[1]));
  assign or_939_nl = (~ (fsm_output[7])) | (fsm_output[1]);
  assign or_940_nl = (fsm_output[7]) | (fsm_output[1]);
  assign mux_749_nl = MUX_s_1_2_2(or_939_nl, or_940_nl, fsm_output[5]);
  assign or_938_nl = (~ (fsm_output[2])) | (fsm_output[6]) | mux_749_nl;
  assign mux_748_nl = MUX_s_1_2_2(or_937_nl, or_938_nl, fsm_output[4]);
  assign nor_437_nl = ~((fsm_output[0]) | mux_748_nl);
  assign nor_438_nl = ~((~ (fsm_output[4])) | (fsm_output[2]) | (~ (fsm_output[6]))
      | (~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[1])));
  assign nor_439_nl = ~((~ (fsm_output[5])) | (~ (fsm_output[7])) | (fsm_output[1]));
  assign nor_440_nl = ~((fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[1])));
  assign mux_752_nl = MUX_s_1_2_2(nor_439_nl, nor_440_nl, fsm_output[6]);
  assign and_939_nl = (fsm_output[2]) & mux_752_nl;
  assign nor_441_nl = ~((fsm_output[2]) | (fsm_output[6]) | (fsm_output[5]) | (fsm_output[7])
      | (~ (fsm_output[1])));
  assign mux_751_nl = MUX_s_1_2_2(and_939_nl, nor_441_nl, fsm_output[4]);
  assign mux_750_nl = MUX_s_1_2_2(nor_438_nl, mux_751_nl, fsm_output[0]);
  assign mux_747_nl = MUX_s_1_2_2(nor_437_nl, mux_750_nl, fsm_output[3]);
  assign nor_443_nl = ~((~ (fsm_output[6])) | (~ (fsm_output[5])) | (fsm_output[2])
      | (fsm_output[7]));
  assign or_941_nl = (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_755_nl = MUX_s_1_2_2(nand_119_cse, or_941_nl, fsm_output[5]);
  assign nor_444_nl = ~((fsm_output[6]) | mux_755_nl);
  assign mux_754_nl = MUX_s_1_2_2(nor_443_nl, nor_444_nl, fsm_output[4]);
  assign and_940_nl = (~((fsm_output[1:0]!=2'b01))) & mux_754_nl;
  assign or_942_nl = (~ (fsm_output[6])) | (fsm_output[5]) | (~ (fsm_output[2]))
      | (fsm_output[7]);
  assign or_943_nl = (fsm_output[6]) | (fsm_output[5]) | (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_757_nl = MUX_s_1_2_2(or_942_nl, or_943_nl, fsm_output[4]);
  assign nor_445_nl = ~((fsm_output[0]) | mux_757_nl);
  assign nor_446_nl = ~((fsm_output[4]) | (fsm_output[6]) | nand_102_cse);
  assign nor_447_nl = ~((~ (fsm_output[4])) | (~ (fsm_output[6])) | (~ (fsm_output[5]))
      | (fsm_output[2]) | (fsm_output[7]));
  assign mux_758_nl = MUX_s_1_2_2(nor_446_nl, nor_447_nl, fsm_output[0]);
  assign mux_756_nl = MUX_s_1_2_2(nor_445_nl, mux_758_nl, fsm_output[1]);
  assign mux_753_nl = MUX_s_1_2_2(and_940_nl, mux_756_nl, fsm_output[3]);
  assign mult_3_res_mux1h_2_nl = MUX1HOT_v_32_4_2(mult_16_z_slc_mult_z_mul_cmp_z_31_0_itm,
      modulo_add_base_1_sva, butterFly_10_tw_h_asn_itm, butterFly_13_tw_h_asn_itm,
      {mux_737_nl , mux_742_nl , mux_747_nl , mux_753_nl});
  assign nl_acc_2_nl = ({mult_3_res_mux1h_2_nl , 1'b1}) + ({(~ (mult_z_mul_cmp_z[31:0]))
      , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[32:0];
  assign nl_acc_3_nl = ({mult_3_res_sva , 1'b1}) + ({(~ m_sva) , 1'b1});
  assign acc_3_nl = nl_acc_3_nl[32:0];
  assign nl_acc_13_nl = ({1'b1 , mult_3_res_sva , 1'b1}) + conv_u2u_33_34({(~ m_sva)
      , 1'b1});
  assign acc_13_nl = nl_acc_13_nl[33:0];
  assign nl_modulo_sub_3_qif_acc_nl = ({1'b1 , (acc_9_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_3_qif_acc_nl = nl_modulo_sub_3_qif_acc_nl[31:0];
  assign and_945_nl = and_dcpl_662 & and_dcpl_36 & (~ (fsm_output[2])) & (fsm_output[0]);
  assign and_946_nl = and_dcpl_662 & and_dcpl_665;
  assign and_947_nl = (fsm_output[7:4]==4'b0111) & and_dcpl_665;
  assign modulo_add_3_mux1h_3_nl = MUX1HOT_v_32_3_2((~ modulo_add_base_3_sva_mx0w1),
      (~ modulo_add_base_2_sva_mx0w4), (~ modulo_add_base_14_sva_mx0w16), {and_945_nl
      , and_946_nl , and_947_nl});
  assign nl_acc_15_nl = ({1'b1 , m_sva , 1'b1}) + conv_u2u_33_34({modulo_add_3_mux1h_3_nl
      , 1'b1});
  assign acc_15_nl = nl_acc_15_nl[33:0];
  assign nl_modulo_sub_qif_acc_nl = ({1'b1 , (acc_5_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_qif_acc_nl = nl_modulo_sub_qif_acc_nl[31:0];
  assign and_948_nl = (fsm_output[7:6]==2'b00) & and_dcpl_89 & and_dcpl_177 & (fsm_output[2])
      & (~ (fsm_output[0]));
  assign and_949_nl = and_dcpl_730 & (fsm_output[3:0]==4'b1011);
  assign and_950_nl = and_dcpl_730 & and_dcpl_177 & and_370_cse;
  assign and_951_nl = (fsm_output[7:6]==2'b10) & and_dcpl_89 & (fsm_output[1]) &
      (~ (fsm_output[3])) & and_370_cse;
  assign modulo_add_mux1h_3_nl = MUX1HOT_v_32_4_2((~ modulo_add_base_sva_mx0w2),
      (~ modulo_add_base_15_sva_mx0w13), (~ modulo_add_base_13_sva_mx0w15), (~ modulo_add_base_17_sva_mx0w19),
      {and_948_nl , and_949_nl , and_950_nl , and_951_nl});
  assign nl_acc_17_nl = ({1'b1 , m_sva , 1'b1}) + conv_u2u_33_34({modulo_add_mux1h_3_nl
      , 1'b1});
  assign acc_17_nl = nl_acc_17_nl[33:0];
  assign and_953_nl = (fsm_output[7:6]==2'b00) & and_dcpl_89 & (fsm_output[3:0]==4'b1101);
  assign modulo_add_1_mux1h_3_nl = MUX1HOT_v_32_3_2((~ modulo_add_base_1_sva_mx0w3),
      (~ modulo_add_base_10_sva_mx0w12), (~ modulo_add_base_22_sva_mx0w24), {and_953_nl
      , (fsm_output[6]) , (fsm_output[7])});
  assign nl_acc_19_nl = ({1'b1 , m_sva , 1'b1}) + conv_u2u_33_34({modulo_add_1_mux1h_3_nl
      , 1'b1});
  assign acc_19_nl = nl_acc_19_nl[33:0];
  assign nl_modulo_sub_7_qif_acc_nl = ({1'b1 , (acc_5_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_7_qif_acc_nl = nl_modulo_sub_7_qif_acc_nl[31:0];
  assign and_954_nl = (fsm_output[7:6]==2'b00) & and_407_cse & and_dcpl_61 & and_370_cse;
  assign and_955_nl = and_dcpl_27 & (fsm_output[5:4]==2'b01) & and_dcpl_61 & (~ (fsm_output[2]))
      & (~ (fsm_output[0]));
  assign and_956_nl = and_dcpl_27 & and_407_cse & (fsm_output[3:0]==4'b1100);
  assign and_957_nl = (fsm_output[7]) & (~ (fsm_output[6])) & (fsm_output[5]) & (~
      (fsm_output[4])) & (fsm_output[1]) & (fsm_output[3]) & and_370_cse;
  assign modulo_add_7_mux1h_3_nl = MUX1HOT_v_32_4_2((~ modulo_add_base_7_sva_mx0w5),
      (~ modulo_add_base_9_sva_mx0w11), (~ modulo_add_base_12_sva_mx0w14), (~ modulo_add_base_20_sva_mx0w22),
      {and_954_nl , and_955_nl , and_956_nl , and_957_nl});
  assign nl_acc_20_nl = ({1'b1 , m_sva , 1'b1}) + conv_u2u_33_34({modulo_add_7_mux1h_3_nl
      , 1'b1});
  assign acc_20_nl = nl_acc_20_nl[33:0];
  assign nl_modulo_sub_4_qif_acc_nl = ({1'b1 , (acc_7_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_4_qif_acc_nl = nl_modulo_sub_4_qif_acc_nl[31:0];
  assign and_941_nl = (fsm_output[7:4]==4'b0011) & and_dcpl_639;
  assign and_942_nl = and_dcpl_649 & (fsm_output[3:0]==4'b0101);
  assign and_943_nl = and_dcpl_649 & and_dcpl_639;
  assign and_944_nl = and_dcpl_39 & (fsm_output[5]) & (~ (fsm_output[4])) & (fsm_output[1])
      & (fsm_output[3]) & and_dcpl_372;
  assign modulo_add_4_mux1h_3_nl = MUX1HOT_v_32_4_2((~ modulo_add_base_4_sva_mx0w6),
      (~ modulo_add_base_19_sva_mx0w17), (~ modulo_add_base_16_sva_mx0w18), (~ modulo_add_base_23_sva_mx0w21),
      {and_941_nl , and_942_nl , and_943_nl , and_944_nl});
  assign nl_acc_14_nl = ({1'b1 , m_sva , 1'b1}) + conv_u2u_33_34({modulo_add_4_mux1h_3_nl
      , 1'b1});
  assign acc_14_nl = nl_acc_14_nl[33:0];
  assign and_952_nl = (fsm_output[7:6]==2'b00) & and_407_cse & (fsm_output[1]) &
      (~ (fsm_output[3])) & and_370_cse;
  assign modulo_add_5_mux1h_3_nl = MUX1HOT_v_32_3_2((~ modulo_add_base_5_sva_mx0w7),
      (~ modulo_add_base_8_sva_mx0w10), (~ modulo_add_base_21_sva_mx0w23), {and_952_nl
      , (fsm_output[6]) , (fsm_output[7])});
  assign nl_acc_18_nl = ({1'b1 , m_sva , 1'b1}) + conv_u2u_33_34({modulo_add_5_mux1h_3_nl
      , 1'b1});
  assign acc_18_nl = nl_acc_18_nl[33:0];
  assign modulo_add_6_mux1h_3_nl = MUX1HOT_v_32_3_2((~ modulo_add_base_6_sva_mx0w8),
      (~ modulo_add_base_11_sva_mx0w9), (~ modulo_add_base_18_sva_mx0w20), {(fsm_output[5])
      , (fsm_output[6]) , (fsm_output[7])});
  assign nl_acc_21_nl = ({1'b1 , m_sva , 1'b1}) + conv_u2u_33_34({modulo_add_6_mux1h_3_nl
      , 1'b1});
  assign acc_21_nl = nl_acc_21_nl[33:0];
  assign nl_modulo_sub_11_qif_acc_nl = ({1'b1 , (acc_6_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_11_qif_acc_nl = nl_modulo_sub_11_qif_acc_nl[31:0];
  assign nl_modulo_sub_8_qif_acc_nl = ({1'b1 , (acc_9_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_8_qif_acc_nl = nl_modulo_sub_8_qif_acc_nl[31:0];
  assign nl_modulo_sub_15_qif_acc_nl = ({1'b1 , (acc_5_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_15_qif_acc_nl = nl_modulo_sub_15_qif_acc_nl[31:0];
  assign nl_modulo_sub_12_qif_acc_nl = ({1'b1 , (acc_7_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_12_qif_acc_nl = nl_modulo_sub_12_qif_acc_nl[31:0];
  assign nl_modulo_sub_19_qif_acc_nl = ({1'b1 , (acc_5_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_19_qif_acc_nl = nl_modulo_sub_19_qif_acc_nl[31:0];
  assign nl_modulo_sub_16_qif_acc_nl = ({1'b1 , (acc_7_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_16_qif_acc_nl = nl_modulo_sub_16_qif_acc_nl[31:0];
  assign nl_modulo_sub_23_qif_acc_nl = ({1'b1 , (acc_5_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_23_qif_acc_nl = nl_modulo_sub_23_qif_acc_nl[31:0];
  assign nl_modulo_sub_20_qif_acc_nl = ({1'b1 , (acc_7_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_20_qif_acc_nl = nl_modulo_sub_20_qif_acc_nl[31:0];
  assign and_191_nl = and_dcpl_28 & and_dcpl_116;
  assign or_885_nl = (fsm_output[6]) | nor_tmp_38;
  assign mux_673_nl = MUX_s_1_2_2(or_885_nl, mux_tmp_210, fsm_output[4]);
  assign mux_672_nl = MUX_s_1_2_2(or_tmp_789, and_372_cse, fsm_output[4]);
  assign mux_674_nl = MUX_s_1_2_2(mux_673_nl, mux_672_nl, fsm_output[3]);
  assign mux_675_nl = MUX_s_1_2_2(mux_674_nl, mux_tmp_665, fsm_output[2]);
  assign mux_670_nl = MUX_s_1_2_2(or_tmp_789, mux_tmp_210, fsm_output[4]);
  assign and_913_nl = (fsm_output[6]) & or_44_cse;
  assign mux_669_nl = MUX_s_1_2_2(mux_tmp_210, and_913_nl, fsm_output[4]);
  assign mux_671_nl = MUX_s_1_2_2(mux_670_nl, mux_669_nl, and_373_cse_1);
  assign mux_676_nl = MUX_s_1_2_2(mux_675_nl, mux_671_nl, fsm_output[0]);
  assign or_884_nl = (fsm_output[2]) | (fsm_output[4]);
  assign mux_667_nl = MUX_s_1_2_2(or_tmp_789, mux_tmp_210, or_884_nl);
  assign mux_668_nl = MUX_s_1_2_2(mux_667_nl, mux_tmp_665, fsm_output[0]);
  assign mux_677_nl = MUX_s_1_2_2(mux_676_nl, mux_668_nl, fsm_output[1]);
  assign S2_COPY_LOOP_p_S2_COPY_LOOP_p_mux_nl = MUX_s_1_2_2((z_out[3]), (S1_OUTER_LOOP_k_5_0_sva_2[3]),
      mux_313_itm);
  assign or_890_nl = (fsm_output[7:5]!=3'b000);
  assign mux_693_nl = MUX_s_1_2_2(or_890_nl, mux_290_cse, fsm_output[4]);
  assign mux_690_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign mux_691_nl = MUX_s_1_2_2(mux_690_nl, (fsm_output[6]), fsm_output[5]);
  assign mux_692_nl = MUX_s_1_2_2(mux_290_cse, mux_691_nl, fsm_output[4]);
  assign mux_694_nl = MUX_s_1_2_2(mux_693_nl, mux_692_nl, fsm_output[3]);
  assign mux_695_nl = MUX_s_1_2_2(mux_694_nl, nand_tmp_104, fsm_output[1]);
  assign mux_688_nl = MUX_s_1_2_2(mux_337_cse, mux_290_cse, or_242_cse);
  assign mux_689_nl = MUX_s_1_2_2(mux_tmp_684, mux_688_nl, fsm_output[1]);
  assign mux_696_nl = MUX_s_1_2_2(mux_695_nl, mux_689_nl, fsm_output[2]);
  assign mux_686_nl = MUX_s_1_2_2(nand_tmp_104, mux_tmp_684, fsm_output[1]);
  assign mux_679_nl = MUX_s_1_2_2(or_353_cse, (fsm_output[6]), fsm_output[5]);
  assign mux_680_nl = MUX_s_1_2_2(mux_290_cse, mux_679_nl, fsm_output[4]);
  assign mux_681_nl = MUX_s_1_2_2(nand_59_cse, mux_680_nl, fsm_output[3]);
  assign mux_682_nl = MUX_s_1_2_2(mux_681_nl, mux_290_cse, fsm_output[1]);
  assign mux_687_nl = MUX_s_1_2_2(mux_686_nl, mux_682_nl, fsm_output[2]);
  assign mux_697_nl = MUX_s_1_2_2(mux_696_nl, mux_687_nl, fsm_output[0]);
  assign S2_COPY_LOOP_p_S2_COPY_LOOP_p_nand_nl = ~(mux_313_itm & ((~(or_242_cse |
      and_400_cse)) | mux_290_cse));
  assign S2_COPY_LOOP_p_S2_COPY_LOOP_p_mux_1_nl = MUX_v_3_2_2((S1_OUTER_LOOP_k_5_0_sva_2[2:0]),
      (z_out[2:0]), S2_COPY_LOOP_p_S2_COPY_LOOP_p_nand_nl);
  assign or_905_nl = (fsm_output[5]) | (fsm_output[6]) | (fsm_output[3]);
  assign or_904_nl = (fsm_output[5]) | (~ nor_tmp_111);
  assign mux_702_nl = MUX_s_1_2_2(or_905_nl, or_904_nl, fsm_output[4]);
  assign nand_174_nl = ~((fsm_output[6:3]==4'b0111));
  assign mux_703_nl = MUX_s_1_2_2(mux_702_nl, nand_174_nl, fsm_output[7]);
  assign nor_421_nl = ~((fsm_output[0]) | mux_703_nl);
  assign nor_422_nl = ~((fsm_output[7]) | (fsm_output[4]) | (~ mux_699_itm));
  assign and_933_nl = (fsm_output[7:3]==5'b10111);
  assign mux_701_nl = MUX_s_1_2_2(nor_422_nl, and_933_nl, fsm_output[0]);
  assign mux_704_nl = MUX_s_1_2_2(nor_421_nl, mux_701_nl, fsm_output[2]);
  assign nor_424_nl = ~((~ (fsm_output[0])) | (fsm_output[7]) | (fsm_output[4]) |
      (~ mux_699_itm));
  assign or_893_nl = (fsm_output[4]) | (~((fsm_output[6:5]!=2'b10))) | (fsm_output[3]);
  assign or_891_nl = (fsm_output[6:3]!=4'b0000);
  assign mux_698_nl = MUX_s_1_2_2(or_893_nl, or_891_nl, fsm_output[7]);
  assign nor_425_nl = ~((fsm_output[0]) | mux_698_nl);
  assign mux_700_nl = MUX_s_1_2_2(nor_424_nl, nor_425_nl, fsm_output[2]);
  assign mux_705_nl = MUX_s_1_2_2(mux_704_nl, mux_700_nl, fsm_output[1]);
  assign mux_715_nl = MUX_s_1_2_2((fsm_output[7]), mux_28_cse, fsm_output[5]);
  assign mux_716_nl = MUX_s_1_2_2(mux_715_nl, mux_556_cse, or_814_cse);
  assign mux_713_nl = MUX_s_1_2_2(nand_166_cse, mux_712_cse, fsm_output[1]);
  assign mux_717_nl = MUX_s_1_2_2(mux_716_nl, mux_713_nl, fsm_output[2]);
  assign or_933_nl = (fsm_output[2:0]!=3'b101) | mux_556_cse;
  assign mux_718_nl = MUX_s_1_2_2(mux_717_nl, or_933_nl, fsm_output[3]);
  assign mux_708_nl = MUX_s_1_2_2(mux_51_cse, or_39_cse, and_371_cse);
  assign mux_707_nl = MUX_s_1_2_2(mux_51_cse, or_39_cse, fsm_output[1]);
  assign mux_709_nl = MUX_s_1_2_2(mux_708_nl, mux_707_nl, fsm_output[2]);
  assign nand_164_nl = ~((fsm_output[3]) & (~ mux_709_nl));
  assign mux_719_nl = MUX_s_1_2_2(mux_718_nl, nand_164_nl, fsm_output[4]);
  assign mux_725_nl = MUX_s_1_2_2((fsm_output[7]), or_353_cse, fsm_output[5]);
  assign nor_415_nl = ~((fsm_output[0]) | mux_725_nl);
  assign and_925_nl = (fsm_output[0]) & (~ mux_556_cse);
  assign mux_726_nl = MUX_s_1_2_2(nor_415_nl, and_925_nl, fsm_output[2]);
  assign and_926_nl = (fsm_output[2]) & (fsm_output[0]) & (~ mux_556_cse);
  assign mux_727_nl = MUX_s_1_2_2(mux_726_nl, and_926_nl, fsm_output[3]);
  assign nor_416_nl = ~((fsm_output[0]) | mux_51_cse);
  assign nor_417_nl = ~((fsm_output[7:5]!=3'b101));
  assign mux_724_nl = MUX_s_1_2_2(nor_416_nl, nor_417_nl, fsm_output[2]);
  assign and_927_nl = (fsm_output[3]) & mux_724_nl;
  assign mux_728_nl = MUX_s_1_2_2(mux_727_nl, and_927_nl, fsm_output[4]);
  assign nor_418_nl = ~((fsm_output[4:2]!=3'b001) | mux_712_cse);
  assign mux_729_nl = MUX_s_1_2_2(mux_728_nl, nor_418_nl, fsm_output[1]);
  assign nor_nl = ~((~ (fsm_output[0])) | (fsm_output[4]) | mux_556_cse);
  assign nor_426_nl = ~((fsm_output[0]) | (~ (fsm_output[4])) | (~ (fsm_output[5]))
      | (~ (fsm_output[7])) | (fsm_output[6]));
  assign mux_46_nl = MUX_s_1_2_2(nor_nl, nor_426_nl, fsm_output[3]);
  assign and_21_nl = mux_46_nl & (fsm_output[2:1]==2'b10);
  assign S1_OUTER_LOOP_for_p_S1_OUTER_LOOP_for_p_and_nl = MUX_v_15_2_2(15'b000000000000000,
      (S1_OUTER_LOOP_for_p_sva_1[19:5]), and_21_nl);
  assign nand_61_nl = ~((fsm_output[4]) & (~ mux_51_cse));
  assign mux_351_nl = MUX_s_1_2_2(or_tmp_384, nand_61_nl, fsm_output[3]);
  assign and_934_nl = xor_dcpl_2 & and_dcpl_50 & (fsm_output[3:0]==4'b1000);
  assign S1_OUTER_LOOP_for_mux_15_nl = MUX_v_5_2_2((S1_OUTER_LOOP_for_p_sva_1[4:0]),
      (revArr_rsci_s_din_mxwt[9:5]), and_934_nl);
  assign nl_S1_OUTER_LOOP_for_acc_nl = ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg
      , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg}) + S1_OUTER_LOOP_for_mux_15_nl;
  assign S1_OUTER_LOOP_for_acc_nl = nl_S1_OUTER_LOOP_for_acc_nl[4:0];
  assign nl_S6_OUTER_LOOP_for_acc_nl = (S1_OUTER_LOOP_for_p_sva_1[4:0]) + ({reg_S2_COPY_LOOP_p_5_0_sva_4_0_reg
      , reg_S2_COPY_LOOP_p_5_0_sva_4_0_1_reg , reg_S2_COPY_LOOP_p_5_0_sva_4_0_2_reg});
  assign S6_OUTER_LOOP_for_acc_nl = nl_S6_OUTER_LOOP_for_acc_nl[4:0];
  assign S1_OUTER_LOOP_for_or_nl = S1_OUTER_LOOP_for_acc_cse_sva_mx0c0 | S1_OUTER_LOOP_for_acc_cse_sva_mx0c2;
  assign S1_OUTER_LOOP_for_mux1h_3_nl = MUX1HOT_v_5_3_2(S1_OUTER_LOOP_for_acc_nl,
      S2_COPY_LOOP_for_i_5_0_sva_1_4_0, S6_OUTER_LOOP_for_acc_nl, {S1_OUTER_LOOP_for_or_nl
      , S1_OUTER_LOOP_for_acc_cse_sva_mx0c3 , and_dcpl_129});
  assign S1_OUTER_LOOP_for_not_4_nl = ~ S1_OUTER_LOOP_for_acc_cse_sva_mx0c1;
  assign S2_OUTER_LOOP_c_nor_nl = ~(or_tmp_372 | or_dcpl_12 | or_dcpl_22);
  assign S2_INNER_LOOP1_r_mux_nl = MUX_v_2_2_2(({1'b0 , S2_OUTER_LOOP_c_nor_nl}),
      (z_out_2[1:0]), S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c2);
  assign S2_INNER_LOOP1_r_not_nl = ~ S2_INNER_LOOP1_r_4_2_sva_1_0_mx0c1;
  assign or_485_nl = (fsm_output[2]) | (fsm_output[4]) | mux_556_cse;
  assign mux_426_nl = MUX_s_1_2_2(or_tmp_372, nand_59_cse, fsm_output[2]);
  assign nor_66_nl = ~(S2_OUTER_LOOP_c_1_sva | (~ (z_out_2[2])));
  assign mux_415_nl = MUX_s_1_2_2(or_485_nl, mux_426_nl, nor_66_nl);
  assign nand_173_nl = ~((fsm_output[3:0]==4'b1101));
  assign mux_731_nl = MUX_s_1_2_2(nand_173_nl, mux_434_cse, fsm_output[7]);
  assign or_924_nl = (fsm_output[7]) | mux_434_cse;
  assign mux_732_nl = MUX_s_1_2_2(mux_731_nl, or_924_nl, fsm_output[5]);
  assign or_921_nl = (~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[2]))
      | (~ (fsm_output[3])) | (fsm_output[1]) | (~ (fsm_output[0]));
  assign mux_733_nl = MUX_s_1_2_2(mux_732_nl, or_921_nl, fsm_output[6]);
  assign nor_411_nl = ~((~ (fsm_output[3])) | (fsm_output[1]));
  assign nor_412_nl = ~((fsm_output[3]) | (~ (fsm_output[1])));
  assign mux_734_nl = MUX_s_1_2_2(nor_411_nl, nor_412_nl, fsm_output[7]);
  assign nor_413_nl = ~((fsm_output[7]) | (fsm_output[3]) | (~ (fsm_output[1])));
  assign mux_735_nl = MUX_s_1_2_2(mux_734_nl, nor_413_nl, fsm_output[5]);
  assign nor_414_nl = ~((~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[3]))
      | (fsm_output[1]));
  assign mux_736_nl = MUX_s_1_2_2(mux_735_nl, nor_414_nl, fsm_output[6]);
  assign mux_480_nl = MUX_s_1_2_2(or_tmp_540, or_tmp_539, fsm_output[0]);
  assign mux_481_nl = MUX_s_1_2_2(mux_480_nl, or_563_cse, fsm_output[1]);
  assign or_561_nl = (fsm_output[0]) | (fsm_output[4]) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_479_nl = MUX_s_1_2_2(or_561_nl, or_tmp_118, fsm_output[1]);
  assign mux_482_nl = MUX_s_1_2_2(mux_481_nl, mux_479_nl, fsm_output[3]);
  assign or_560_nl = (~ (fsm_output[3])) | (~ (fsm_output[1])) | (fsm_output[0])
      | (fsm_output[4]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_483_nl = MUX_s_1_2_2(mux_482_nl, or_560_nl, fsm_output[2]);
  assign or_611_nl = (~ (fsm_output[3])) | (~ (fsm_output[1])) | (fsm_output[0])
      | (~ (fsm_output[7])) | (fsm_output[6]);
  assign or_610_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_520_nl = MUX_s_1_2_2(or_610_nl, or_310_cse, fsm_output[3]);
  assign mux_521_nl = MUX_s_1_2_2(or_611_nl, mux_520_nl, fsm_output[2]);
  assign or_705_nl = (fsm_output[5]) | (~ (fsm_output[2])) | (fsm_output[1]) | (fsm_output[7])
      | (~ (fsm_output[6]));
  assign or_703_nl = (~ (fsm_output[5])) | (fsm_output[2]) | (fsm_output[1]) | (~
      (fsm_output[7])) | (fsm_output[6]);
  assign mux_585_nl = MUX_s_1_2_2(or_705_nl, or_703_nl, fsm_output[3]);
  assign or_702_nl = (fsm_output[2]) | (~ (fsm_output[1])) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_583_nl = MUX_s_1_2_2(mux_tmp_578, or_702_nl, fsm_output[5]);
  assign or_701_nl = (fsm_output[2]) | (fsm_output[1]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_582_nl = MUX_s_1_2_2(or_tmp_669, or_701_nl, fsm_output[5]);
  assign mux_584_nl = MUX_s_1_2_2(mux_583_nl, mux_582_nl, fsm_output[3]);
  assign mux_586_nl = MUX_s_1_2_2(mux_585_nl, mux_584_nl, fsm_output[4]);
  assign mux_579_nl = MUX_s_1_2_2(or_819_cse, or_820_cse, fsm_output[2]);
  assign mux_580_nl = MUX_s_1_2_2(mux_579_nl, mux_tmp_578, fsm_output[5]);
  assign nand_90_nl = ~((fsm_output[3]) & (~ mux_580_nl));
  assign or_694_nl = (~ (fsm_output[2])) | (fsm_output[1]) | (fsm_output[7]) | (~
      (fsm_output[6]));
  assign mux_577_nl = MUX_s_1_2_2(or_tmp_669, or_694_nl, fsm_output[5]);
  assign or_696_nl = (fsm_output[3]) | mux_577_nl;
  assign mux_581_nl = MUX_s_1_2_2(nand_90_nl, or_696_nl, fsm_output[4]);
  assign mux_587_nl = MUX_s_1_2_2(mux_586_nl, mux_581_nl, fsm_output[0]);
  assign or_708_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4]) | (fsm_output[7])
      | (~ (fsm_output[6]));
  assign mux_588_nl = MUX_s_1_2_2(or_tmp_121, or_708_nl, fsm_output[3]);
  assign or_706_nl = (~ (fsm_output[3])) | (fsm_output[1]) | (~ (fsm_output[0]))
      | (fsm_output[4]) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_589_nl = MUX_s_1_2_2(mux_588_nl, or_706_nl, fsm_output[2]);
  assign mux_595_nl = MUX_s_1_2_2(or_tmp_112, or_tmp_102, fsm_output[3]);
  assign mux_596_nl = MUX_s_1_2_2(or_tmp_117, mux_595_nl, fsm_output[2]);
  assign or_746_nl = (~ (fsm_output[0])) | (~ (fsm_output[4])) | (fsm_output[7])
      | (fsm_output[6]);
  assign mux_622_nl = MUX_s_1_2_2(or_746_nl, or_tmp_104, fsm_output[1]);
  assign mux_623_nl = MUX_s_1_2_2(mux_622_nl, or_tmp_110, fsm_output[3]);
  assign nor_316_nl = ~((~ (fsm_output[2])) | (fsm_output[1]) | (fsm_output[0]) |
      (~ (fsm_output[5])) | (~ (fsm_output[7])) | (fsm_output[6]));
  assign or_661_nl = (fsm_output[7:5]!=3'b101);
  assign mux_633_nl = MUX_s_1_2_2(or_39_cse, or_661_nl, fsm_output[0]);
  assign nand_96_nl = ~((fsm_output[0]) & (~ mux_290_cse));
  assign mux_634_nl = MUX_s_1_2_2(mux_633_nl, nand_96_nl, fsm_output[1]);
  assign nor_317_nl = ~((fsm_output[2]) | mux_634_nl);
  assign mux_635_nl = MUX_s_1_2_2(nor_316_nl, nor_317_nl, fsm_output[3]);
  assign mux_631_nl = MUX_s_1_2_2(mux_290_cse, or_350_cse, fsm_output[0]);
  assign or_762_nl = (fsm_output[1]) | mux_631_nl;
  assign or_757_nl = (~ (fsm_output[0])) | (fsm_output[5]) | (fsm_output[7]) | (fsm_output[6]);
  assign or_756_nl = (fsm_output[0]) | (~ (fsm_output[5])) | (fsm_output[7]) | (~
      (fsm_output[6]));
  assign mux_629_nl = MUX_s_1_2_2(or_757_nl, or_756_nl, fsm_output[1]);
  assign mux_632_nl = MUX_s_1_2_2(or_762_nl, mux_629_nl, fsm_output[2]);
  assign nor_318_nl = ~((fsm_output[3]) | mux_632_nl);
  assign mux_636_nl = MUX_s_1_2_2(mux_635_nl, nor_318_nl, fsm_output[4]);
  assign nl_modulo_sub_1_qif_acc_nl = ({1'b1 , (acc_7_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_1_qif_acc_nl = nl_modulo_sub_1_qif_acc_nl[31:0];
  assign nl_modulo_sub_2_qif_acc_nl = ({1'b1 , (acc_6_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_2_qif_acc_nl = nl_modulo_sub_2_qif_acc_nl[31:0];
  assign nl_modulo_sub_5_qif_acc_nl = ({1'b1 , (acc_6_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_5_qif_acc_nl = nl_modulo_sub_5_qif_acc_nl[31:0];
  assign nl_modulo_sub_6_qif_acc_nl = ({1'b1 , (acc_9_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_6_qif_acc_nl = nl_modulo_sub_6_qif_acc_nl[31:0];
  assign nl_modulo_sub_9_qif_acc_nl = ({1'b1 , (acc_5_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_9_qif_acc_nl = nl_modulo_sub_9_qif_acc_nl[31:0];
  assign nl_modulo_sub_10_qif_acc_nl = ({1'b1 , (acc_7_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_10_qif_acc_nl = nl_modulo_sub_10_qif_acc_nl[31:0];
  assign nl_modulo_sub_13_qif_acc_nl = ({1'b1 , (acc_6_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_13_qif_acc_nl = nl_modulo_sub_13_qif_acc_nl[31:0];
  assign nl_modulo_sub_14_qif_acc_nl = ({1'b1 , (acc_9_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_14_qif_acc_nl = nl_modulo_sub_14_qif_acc_nl[31:0];
  assign nl_modulo_sub_17_qif_acc_nl = ({1'b1 , (acc_6_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_17_qif_acc_nl = nl_modulo_sub_17_qif_acc_nl[31:0];
  assign nl_modulo_sub_18_qif_acc_nl = ({1'b1 , (acc_9_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_18_qif_acc_nl = nl_modulo_sub_18_qif_acc_nl[31:0];
  assign nl_modulo_sub_21_qif_acc_nl = ({1'b1 , (acc_6_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_21_qif_acc_nl = nl_modulo_sub_21_qif_acc_nl[31:0];
  assign nl_modulo_sub_22_qif_acc_nl = ({1'b1 , (acc_9_cse_32_1[30:0])}) + m_sva;
  assign modulo_sub_22_qif_acc_nl = nl_modulo_sub_22_qif_acc_nl[31:0];
  assign not_1650_nl = ~ not_tmp_358;
  assign S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_and_2_nl = MUX_v_15_2_2(15'b000000000000000,
      (S1_OUTER_LOOP_for_p_sva_1[14:0]), not_1650_nl);
  assign not_1651_nl = ~ not_tmp_358;
  assign S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_and_3_nl = MUX_v_3_2_2(3'b000, (S2_COPY_LOOP_for_i_5_0_sva_1_4_0[4:2]),
      not_1651_nl);
  assign S1_OUTER_LOOP_for_mux_16_nl = MUX_v_2_2_2((S2_COPY_LOOP_for_i_5_0_sva_1_4_0[1:0]),
      S2_INNER_LOOP1_r_4_2_sva_1_0, not_tmp_358);
  assign nl_z_out_2 = ({S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_and_2_nl , S1_OUTER_LOOP_for_S1_OUTER_LOOP_for_and_3_nl
      , S1_OUTER_LOOP_for_mux_16_nl}) + 20'b00000000000000000001;
  assign z_out_2 = nl_z_out_2[19:0];
  assign nl_acc_5_nl = ({butterFly_15_f1_sva , 1'b1}) + ({(~ reg_mult_3_res_lpi_4_dfm_cse_1)
      , 1'b1});
  assign acc_5_nl = nl_acc_5_nl[32:0];
  assign acc_5_cse_32_1 = readslicef_33_32_1(acc_5_nl);
  assign nl_acc_6_nl = ({butterFly_11_f1_sva , 1'b1}) + ({(~ reg_mult_3_res_lpi_4_dfm_cse_1)
      , 1'b1});
  assign acc_6_nl = nl_acc_6_nl[32:0];
  assign acc_6_cse_32_1 = readslicef_33_32_1(acc_6_nl);
  assign nl_acc_7_nl = ({butterFly_10_f1_sva , 1'b1}) + ({(~ reg_mult_3_res_lpi_4_dfm_cse_1)
      , 1'b1});
  assign acc_7_nl = nl_acc_7_nl[32:0];
  assign acc_7_cse_32_1 = readslicef_33_32_1(acc_7_nl);
  assign nl_acc_9_nl = ({butterFly_14_f1_sva , 1'b1}) + ({(~ reg_mult_3_res_lpi_4_dfm_cse_1)
      , 1'b1});
  assign acc_9_nl = nl_acc_9_nl[32:0];
  assign acc_9_cse_32_1 = readslicef_33_32_1(acc_9_nl);

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


  function automatic [1:0] MUX1HOT_v_2_4_2;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [3:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | ( input_1 & {2{sel[1]}});
    result = result | ( input_2 & {2{sel[2]}});
    result = result | ( input_3 & {2{sel[3]}});
    MUX1HOT_v_2_4_2 = result;
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


  function automatic [31:0] MUX1HOT_v_32_15_2;
    input [31:0] input_14;
    input [31:0] input_13;
    input [31:0] input_12;
    input [31:0] input_11;
    input [31:0] input_10;
    input [31:0] input_9;
    input [31:0] input_8;
    input [31:0] input_7;
    input [31:0] input_6;
    input [31:0] input_5;
    input [31:0] input_4;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [14:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    result = result | ( input_4 & {32{sel[4]}});
    result = result | ( input_5 & {32{sel[5]}});
    result = result | ( input_6 & {32{sel[6]}});
    result = result | ( input_7 & {32{sel[7]}});
    result = result | ( input_8 & {32{sel[8]}});
    result = result | ( input_9 & {32{sel[9]}});
    result = result | ( input_10 & {32{sel[10]}});
    result = result | ( input_11 & {32{sel[11]}});
    result = result | ( input_12 & {32{sel[12]}});
    result = result | ( input_13 & {32{sel[13]}});
    result = result | ( input_14 & {32{sel[14]}});
    MUX1HOT_v_32_15_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_16_2;
    input [31:0] input_15;
    input [31:0] input_14;
    input [31:0] input_13;
    input [31:0] input_12;
    input [31:0] input_11;
    input [31:0] input_10;
    input [31:0] input_9;
    input [31:0] input_8;
    input [31:0] input_7;
    input [31:0] input_6;
    input [31:0] input_5;
    input [31:0] input_4;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [15:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    result = result | ( input_4 & {32{sel[4]}});
    result = result | ( input_5 & {32{sel[5]}});
    result = result | ( input_6 & {32{sel[6]}});
    result = result | ( input_7 & {32{sel[7]}});
    result = result | ( input_8 & {32{sel[8]}});
    result = result | ( input_9 & {32{sel[9]}});
    result = result | ( input_10 & {32{sel[10]}});
    result = result | ( input_11 & {32{sel[11]}});
    result = result | ( input_12 & {32{sel[12]}});
    result = result | ( input_13 & {32{sel[13]}});
    result = result | ( input_14 & {32{sel[14]}});
    result = result | ( input_15 & {32{sel[15]}});
    MUX1HOT_v_32_16_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_25_2;
    input [31:0] input_24;
    input [31:0] input_23;
    input [31:0] input_22;
    input [31:0] input_21;
    input [31:0] input_20;
    input [31:0] input_19;
    input [31:0] input_18;
    input [31:0] input_17;
    input [31:0] input_16;
    input [31:0] input_15;
    input [31:0] input_14;
    input [31:0] input_13;
    input [31:0] input_12;
    input [31:0] input_11;
    input [31:0] input_10;
    input [31:0] input_9;
    input [31:0] input_8;
    input [31:0] input_7;
    input [31:0] input_6;
    input [31:0] input_5;
    input [31:0] input_4;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [24:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    result = result | ( input_4 & {32{sel[4]}});
    result = result | ( input_5 & {32{sel[5]}});
    result = result | ( input_6 & {32{sel[6]}});
    result = result | ( input_7 & {32{sel[7]}});
    result = result | ( input_8 & {32{sel[8]}});
    result = result | ( input_9 & {32{sel[9]}});
    result = result | ( input_10 & {32{sel[10]}});
    result = result | ( input_11 & {32{sel[11]}});
    result = result | ( input_12 & {32{sel[12]}});
    result = result | ( input_13 & {32{sel[13]}});
    result = result | ( input_14 & {32{sel[14]}});
    result = result | ( input_15 & {32{sel[15]}});
    result = result | ( input_16 & {32{sel[16]}});
    result = result | ( input_17 & {32{sel[17]}});
    result = result | ( input_18 & {32{sel[18]}});
    result = result | ( input_19 & {32{sel[19]}});
    result = result | ( input_20 & {32{sel[20]}});
    result = result | ( input_21 & {32{sel[21]}});
    result = result | ( input_22 & {32{sel[22]}});
    result = result | ( input_23 & {32{sel[23]}});
    result = result | ( input_24 & {32{sel[24]}});
    MUX1HOT_v_32_25_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_3_2;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [2:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    MUX1HOT_v_32_3_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_4_2;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [3:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    MUX1HOT_v_32_4_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_5_2;
    input [31:0] input_4;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [4:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    result = result | ( input_4 & {32{sel[4]}});
    MUX1HOT_v_32_5_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_8_2;
    input [31:0] input_7;
    input [31:0] input_6;
    input [31:0] input_5;
    input [31:0] input_4;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [7:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    result = result | ( input_4 & {32{sel[4]}});
    result = result | ( input_5 & {32{sel[5]}});
    result = result | ( input_6 & {32{sel[6]}});
    result = result | ( input_7 & {32{sel[7]}});
    MUX1HOT_v_32_8_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_9_2;
    input [31:0] input_8;
    input [31:0] input_7;
    input [31:0] input_6;
    input [31:0] input_5;
    input [31:0] input_4;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [8:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    result = result | ( input_4 & {32{sel[4]}});
    result = result | ( input_5 & {32{sel[5]}});
    result = result | ( input_6 & {32{sel[6]}});
    result = result | ( input_7 & {32{sel[7]}});
    result = result | ( input_8 & {32{sel[8]}});
    MUX1HOT_v_32_9_2 = result;
  end
  endfunction


  function automatic [2:0] MUX1HOT_v_3_9_2;
    input [2:0] input_8;
    input [2:0] input_7;
    input [2:0] input_6;
    input [2:0] input_5;
    input [2:0] input_4;
    input [2:0] input_3;
    input [2:0] input_2;
    input [2:0] input_1;
    input [2:0] input_0;
    input [8:0] sel;
    reg [2:0] result;
  begin
    result = input_0 & {3{sel[0]}};
    result = result | ( input_1 & {3{sel[1]}});
    result = result | ( input_2 & {3{sel[2]}});
    result = result | ( input_3 & {3{sel[3]}});
    result = result | ( input_4 & {3{sel[4]}});
    result = result | ( input_5 & {3{sel[5]}});
    result = result | ( input_6 & {3{sel[6]}});
    result = result | ( input_7 & {3{sel[7]}});
    result = result | ( input_8 & {3{sel[8]}});
    MUX1HOT_v_3_9_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_3_2;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [2:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | ( input_1 & {5{sel[1]}});
    result = result | ( input_2 & {5{sel[2]}});
    MUX1HOT_v_5_3_2 = result;
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


  function automatic [14:0] MUX_v_15_2_2;
    input [14:0] input_0;
    input [14:0] input_1;
    input [0:0] sel;
    reg [14:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_15_2_2 = result;
  end
  endfunction


  function automatic [19:0] MUX_v_20_2_2;
    input [19:0] input_0;
    input [19:0] input_1;
    input [0:0] sel;
    reg [19:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_20_2_2 = result;
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


  function automatic [2:0] MUX_v_3_2_2;
    input [2:0] input_0;
    input [2:0] input_1;
    input [0:0] sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function automatic [4:0] MUX_v_5_2_2;
    input [4:0] input_0;
    input [4:0] input_1;
    input [0:0] sel;
    reg [4:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_5_2_2 = result;
  end
  endfunction


  function automatic [5:0] MUX_v_6_2_2;
    input [5:0] input_0;
    input [5:0] input_1;
    input [0:0] sel;
    reg [5:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_6_2_2 = result;
  end
  endfunction


  function automatic [0:0] readslicef_15_1_14;
    input [14:0] vector;
    reg [14:0] tmp;
  begin
    tmp = vector >> 14;
    readslicef_15_1_14 = tmp[0:0];
  end
  endfunction


  function automatic [31:0] readslicef_33_32_1;
    input [32:0] vector;
    reg [32:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_33_32_1 = tmp[31:0];
  end
  endfunction


  function automatic [0:0] readslicef_34_1_33;
    input [33:0] vector;
    reg [33:0] tmp;
  begin
    tmp = vector >> 33;
    readslicef_34_1_33 = tmp[0:0];
  end
  endfunction


  function automatic [5:0] conv_u2s_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_6 =  {1'b0, vector};
  end
  endfunction


  function automatic [33:0] conv_u2u_33_34 ;
    input [32:0]  vector ;
  begin
    conv_u2u_33_34 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    hybrid
// ------------------------------------------------------------------


module hybrid (
  clk, rst, x_rsc_s_tdone, x_rsc_tr_write_done, x_rsc_RREADY, x_rsc_RVALID, x_rsc_RUSER,
      x_rsc_RLAST, x_rsc_RRESP, x_rsc_RDATA, x_rsc_RID, x_rsc_ARREADY, x_rsc_ARVALID,
      x_rsc_ARUSER, x_rsc_ARREGION, x_rsc_ARQOS, x_rsc_ARPROT, x_rsc_ARCACHE, x_rsc_ARLOCK,
      x_rsc_ARBURST, x_rsc_ARSIZE, x_rsc_ARLEN, x_rsc_ARADDR, x_rsc_ARID, x_rsc_BREADY,
      x_rsc_BVALID, x_rsc_BUSER, x_rsc_BRESP, x_rsc_BID, x_rsc_WREADY, x_rsc_WVALID,
      x_rsc_WUSER, x_rsc_WLAST, x_rsc_WSTRB, x_rsc_WDATA, x_rsc_AWREADY, x_rsc_AWVALID,
      x_rsc_AWUSER, x_rsc_AWREGION, x_rsc_AWQOS, x_rsc_AWPROT, x_rsc_AWCACHE, x_rsc_AWLOCK,
      x_rsc_AWBURST, x_rsc_AWSIZE, x_rsc_AWLEN, x_rsc_AWADDR, x_rsc_AWID, x_rsc_triosy_lz,
      m_rsc_dat, m_rsc_triosy_lz, twiddle_rsc_s_tdone, twiddle_rsc_tr_write_done,
      twiddle_rsc_RREADY, twiddle_rsc_RVALID, twiddle_rsc_RUSER, twiddle_rsc_RLAST,
      twiddle_rsc_RRESP, twiddle_rsc_RDATA, twiddle_rsc_RID, twiddle_rsc_ARREADY,
      twiddle_rsc_ARVALID, twiddle_rsc_ARUSER, twiddle_rsc_ARREGION, twiddle_rsc_ARQOS,
      twiddle_rsc_ARPROT, twiddle_rsc_ARCACHE, twiddle_rsc_ARLOCK, twiddle_rsc_ARBURST,
      twiddle_rsc_ARSIZE, twiddle_rsc_ARLEN, twiddle_rsc_ARADDR, twiddle_rsc_ARID,
      twiddle_rsc_BREADY, twiddle_rsc_BVALID, twiddle_rsc_BUSER, twiddle_rsc_BRESP,
      twiddle_rsc_BID, twiddle_rsc_WREADY, twiddle_rsc_WVALID, twiddle_rsc_WUSER,
      twiddle_rsc_WLAST, twiddle_rsc_WSTRB, twiddle_rsc_WDATA, twiddle_rsc_AWREADY,
      twiddle_rsc_AWVALID, twiddle_rsc_AWUSER, twiddle_rsc_AWREGION, twiddle_rsc_AWQOS,
      twiddle_rsc_AWPROT, twiddle_rsc_AWCACHE, twiddle_rsc_AWLOCK, twiddle_rsc_AWBURST,
      twiddle_rsc_AWSIZE, twiddle_rsc_AWLEN, twiddle_rsc_AWADDR, twiddle_rsc_AWID,
      twiddle_rsc_triosy_lz, twiddle_h_rsc_s_tdone, twiddle_h_rsc_tr_write_done,
      twiddle_h_rsc_RREADY, twiddle_h_rsc_RVALID, twiddle_h_rsc_RUSER, twiddle_h_rsc_RLAST,
      twiddle_h_rsc_RRESP, twiddle_h_rsc_RDATA, twiddle_h_rsc_RID, twiddle_h_rsc_ARREADY,
      twiddle_h_rsc_ARVALID, twiddle_h_rsc_ARUSER, twiddle_h_rsc_ARREGION, twiddle_h_rsc_ARQOS,
      twiddle_h_rsc_ARPROT, twiddle_h_rsc_ARCACHE, twiddle_h_rsc_ARLOCK, twiddle_h_rsc_ARBURST,
      twiddle_h_rsc_ARSIZE, twiddle_h_rsc_ARLEN, twiddle_h_rsc_ARADDR, twiddle_h_rsc_ARID,
      twiddle_h_rsc_BREADY, twiddle_h_rsc_BVALID, twiddle_h_rsc_BUSER, twiddle_h_rsc_BRESP,
      twiddle_h_rsc_BID, twiddle_h_rsc_WREADY, twiddle_h_rsc_WVALID, twiddle_h_rsc_WUSER,
      twiddle_h_rsc_WLAST, twiddle_h_rsc_WSTRB, twiddle_h_rsc_WDATA, twiddle_h_rsc_AWREADY,
      twiddle_h_rsc_AWVALID, twiddle_h_rsc_AWUSER, twiddle_h_rsc_AWREGION, twiddle_h_rsc_AWQOS,
      twiddle_h_rsc_AWPROT, twiddle_h_rsc_AWCACHE, twiddle_h_rsc_AWLOCK, twiddle_h_rsc_AWBURST,
      twiddle_h_rsc_AWSIZE, twiddle_h_rsc_AWLEN, twiddle_h_rsc_AWADDR, twiddle_h_rsc_AWID,
      twiddle_h_rsc_triosy_lz, revArr_rsc_s_tdone, revArr_rsc_tr_write_done, revArr_rsc_RREADY,
      revArr_rsc_RVALID, revArr_rsc_RUSER, revArr_rsc_RLAST, revArr_rsc_RRESP, revArr_rsc_RDATA,
      revArr_rsc_RID, revArr_rsc_ARREADY, revArr_rsc_ARVALID, revArr_rsc_ARUSER,
      revArr_rsc_ARREGION, revArr_rsc_ARQOS, revArr_rsc_ARPROT, revArr_rsc_ARCACHE,
      revArr_rsc_ARLOCK, revArr_rsc_ARBURST, revArr_rsc_ARSIZE, revArr_rsc_ARLEN,
      revArr_rsc_ARADDR, revArr_rsc_ARID, revArr_rsc_BREADY, revArr_rsc_BVALID, revArr_rsc_BUSER,
      revArr_rsc_BRESP, revArr_rsc_BID, revArr_rsc_WREADY, revArr_rsc_WVALID, revArr_rsc_WUSER,
      revArr_rsc_WLAST, revArr_rsc_WSTRB, revArr_rsc_WDATA, revArr_rsc_AWREADY, revArr_rsc_AWVALID,
      revArr_rsc_AWUSER, revArr_rsc_AWREGION, revArr_rsc_AWQOS, revArr_rsc_AWPROT,
      revArr_rsc_AWCACHE, revArr_rsc_AWLOCK, revArr_rsc_AWBURST, revArr_rsc_AWSIZE,
      revArr_rsc_AWLEN, revArr_rsc_AWADDR, revArr_rsc_AWID, revArr_rsc_triosy_lz,
      tw_rsc_s_tdone, tw_rsc_tr_write_done, tw_rsc_RREADY, tw_rsc_RVALID, tw_rsc_RUSER,
      tw_rsc_RLAST, tw_rsc_RRESP, tw_rsc_RDATA, tw_rsc_RID, tw_rsc_ARREADY, tw_rsc_ARVALID,
      tw_rsc_ARUSER, tw_rsc_ARREGION, tw_rsc_ARQOS, tw_rsc_ARPROT, tw_rsc_ARCACHE,
      tw_rsc_ARLOCK, tw_rsc_ARBURST, tw_rsc_ARSIZE, tw_rsc_ARLEN, tw_rsc_ARADDR,
      tw_rsc_ARID, tw_rsc_BREADY, tw_rsc_BVALID, tw_rsc_BUSER, tw_rsc_BRESP, tw_rsc_BID,
      tw_rsc_WREADY, tw_rsc_WVALID, tw_rsc_WUSER, tw_rsc_WLAST, tw_rsc_WSTRB, tw_rsc_WDATA,
      tw_rsc_AWREADY, tw_rsc_AWVALID, tw_rsc_AWUSER, tw_rsc_AWREGION, tw_rsc_AWQOS,
      tw_rsc_AWPROT, tw_rsc_AWCACHE, tw_rsc_AWLOCK, tw_rsc_AWBURST, tw_rsc_AWSIZE,
      tw_rsc_AWLEN, tw_rsc_AWADDR, tw_rsc_AWID, tw_rsc_triosy_lz, tw_h_rsc_s_tdone,
      tw_h_rsc_tr_write_done, tw_h_rsc_RREADY, tw_h_rsc_RVALID, tw_h_rsc_RUSER, tw_h_rsc_RLAST,
      tw_h_rsc_RRESP, tw_h_rsc_RDATA, tw_h_rsc_RID, tw_h_rsc_ARREADY, tw_h_rsc_ARVALID,
      tw_h_rsc_ARUSER, tw_h_rsc_ARREGION, tw_h_rsc_ARQOS, tw_h_rsc_ARPROT, tw_h_rsc_ARCACHE,
      tw_h_rsc_ARLOCK, tw_h_rsc_ARBURST, tw_h_rsc_ARSIZE, tw_h_rsc_ARLEN, tw_h_rsc_ARADDR,
      tw_h_rsc_ARID, tw_h_rsc_BREADY, tw_h_rsc_BVALID, tw_h_rsc_BUSER, tw_h_rsc_BRESP,
      tw_h_rsc_BID, tw_h_rsc_WREADY, tw_h_rsc_WVALID, tw_h_rsc_WUSER, tw_h_rsc_WLAST,
      tw_h_rsc_WSTRB, tw_h_rsc_WDATA, tw_h_rsc_AWREADY, tw_h_rsc_AWVALID, tw_h_rsc_AWUSER,
      tw_h_rsc_AWREGION, tw_h_rsc_AWQOS, tw_h_rsc_AWPROT, tw_h_rsc_AWCACHE, tw_h_rsc_AWLOCK,
      tw_h_rsc_AWBURST, tw_h_rsc_AWSIZE, tw_h_rsc_AWLEN, tw_h_rsc_AWADDR, tw_h_rsc_AWID,
      tw_h_rsc_triosy_lz
);
  input clk;
  input rst;
  input x_rsc_s_tdone;
  input x_rsc_tr_write_done;
  input x_rsc_RREADY;
  output x_rsc_RVALID;
  output x_rsc_RUSER;
  output x_rsc_RLAST;
  output [1:0] x_rsc_RRESP;
  output [31:0] x_rsc_RDATA;
  output x_rsc_RID;
  output x_rsc_ARREADY;
  input x_rsc_ARVALID;
  input x_rsc_ARUSER;
  input [3:0] x_rsc_ARREGION;
  input [3:0] x_rsc_ARQOS;
  input [2:0] x_rsc_ARPROT;
  input [3:0] x_rsc_ARCACHE;
  input x_rsc_ARLOCK;
  input [1:0] x_rsc_ARBURST;
  input [2:0] x_rsc_ARSIZE;
  input [7:0] x_rsc_ARLEN;
  input [11:0] x_rsc_ARADDR;
  input x_rsc_ARID;
  input x_rsc_BREADY;
  output x_rsc_BVALID;
  output x_rsc_BUSER;
  output [1:0] x_rsc_BRESP;
  output x_rsc_BID;
  output x_rsc_WREADY;
  input x_rsc_WVALID;
  input x_rsc_WUSER;
  input x_rsc_WLAST;
  input [3:0] x_rsc_WSTRB;
  input [31:0] x_rsc_WDATA;
  output x_rsc_AWREADY;
  input x_rsc_AWVALID;
  input x_rsc_AWUSER;
  input [3:0] x_rsc_AWREGION;
  input [3:0] x_rsc_AWQOS;
  input [2:0] x_rsc_AWPROT;
  input [3:0] x_rsc_AWCACHE;
  input x_rsc_AWLOCK;
  input [1:0] x_rsc_AWBURST;
  input [2:0] x_rsc_AWSIZE;
  input [7:0] x_rsc_AWLEN;
  input [11:0] x_rsc_AWADDR;
  input x_rsc_AWID;
  output x_rsc_triosy_lz;
  input [31:0] m_rsc_dat;
  output m_rsc_triosy_lz;
  input twiddle_rsc_s_tdone;
  input twiddle_rsc_tr_write_done;
  input twiddle_rsc_RREADY;
  output twiddle_rsc_RVALID;
  output twiddle_rsc_RUSER;
  output twiddle_rsc_RLAST;
  output [1:0] twiddle_rsc_RRESP;
  output [31:0] twiddle_rsc_RDATA;
  output twiddle_rsc_RID;
  output twiddle_rsc_ARREADY;
  input twiddle_rsc_ARVALID;
  input twiddle_rsc_ARUSER;
  input [3:0] twiddle_rsc_ARREGION;
  input [3:0] twiddle_rsc_ARQOS;
  input [2:0] twiddle_rsc_ARPROT;
  input [3:0] twiddle_rsc_ARCACHE;
  input twiddle_rsc_ARLOCK;
  input [1:0] twiddle_rsc_ARBURST;
  input [2:0] twiddle_rsc_ARSIZE;
  input [7:0] twiddle_rsc_ARLEN;
  input [11:0] twiddle_rsc_ARADDR;
  input twiddle_rsc_ARID;
  input twiddle_rsc_BREADY;
  output twiddle_rsc_BVALID;
  output twiddle_rsc_BUSER;
  output [1:0] twiddle_rsc_BRESP;
  output twiddle_rsc_BID;
  output twiddle_rsc_WREADY;
  input twiddle_rsc_WVALID;
  input twiddle_rsc_WUSER;
  input twiddle_rsc_WLAST;
  input [3:0] twiddle_rsc_WSTRB;
  input [31:0] twiddle_rsc_WDATA;
  output twiddle_rsc_AWREADY;
  input twiddle_rsc_AWVALID;
  input twiddle_rsc_AWUSER;
  input [3:0] twiddle_rsc_AWREGION;
  input [3:0] twiddle_rsc_AWQOS;
  input [2:0] twiddle_rsc_AWPROT;
  input [3:0] twiddle_rsc_AWCACHE;
  input twiddle_rsc_AWLOCK;
  input [1:0] twiddle_rsc_AWBURST;
  input [2:0] twiddle_rsc_AWSIZE;
  input [7:0] twiddle_rsc_AWLEN;
  input [11:0] twiddle_rsc_AWADDR;
  input twiddle_rsc_AWID;
  output twiddle_rsc_triosy_lz;
  input twiddle_h_rsc_s_tdone;
  input twiddle_h_rsc_tr_write_done;
  input twiddle_h_rsc_RREADY;
  output twiddle_h_rsc_RVALID;
  output twiddle_h_rsc_RUSER;
  output twiddle_h_rsc_RLAST;
  output [1:0] twiddle_h_rsc_RRESP;
  output [31:0] twiddle_h_rsc_RDATA;
  output twiddle_h_rsc_RID;
  output twiddle_h_rsc_ARREADY;
  input twiddle_h_rsc_ARVALID;
  input twiddle_h_rsc_ARUSER;
  input [3:0] twiddle_h_rsc_ARREGION;
  input [3:0] twiddle_h_rsc_ARQOS;
  input [2:0] twiddle_h_rsc_ARPROT;
  input [3:0] twiddle_h_rsc_ARCACHE;
  input twiddle_h_rsc_ARLOCK;
  input [1:0] twiddle_h_rsc_ARBURST;
  input [2:0] twiddle_h_rsc_ARSIZE;
  input [7:0] twiddle_h_rsc_ARLEN;
  input [11:0] twiddle_h_rsc_ARADDR;
  input twiddle_h_rsc_ARID;
  input twiddle_h_rsc_BREADY;
  output twiddle_h_rsc_BVALID;
  output twiddle_h_rsc_BUSER;
  output [1:0] twiddle_h_rsc_BRESP;
  output twiddle_h_rsc_BID;
  output twiddle_h_rsc_WREADY;
  input twiddle_h_rsc_WVALID;
  input twiddle_h_rsc_WUSER;
  input twiddle_h_rsc_WLAST;
  input [3:0] twiddle_h_rsc_WSTRB;
  input [31:0] twiddle_h_rsc_WDATA;
  output twiddle_h_rsc_AWREADY;
  input twiddle_h_rsc_AWVALID;
  input twiddle_h_rsc_AWUSER;
  input [3:0] twiddle_h_rsc_AWREGION;
  input [3:0] twiddle_h_rsc_AWQOS;
  input [2:0] twiddle_h_rsc_AWPROT;
  input [3:0] twiddle_h_rsc_AWCACHE;
  input twiddle_h_rsc_AWLOCK;
  input [1:0] twiddle_h_rsc_AWBURST;
  input [2:0] twiddle_h_rsc_AWSIZE;
  input [7:0] twiddle_h_rsc_AWLEN;
  input [11:0] twiddle_h_rsc_AWADDR;
  input twiddle_h_rsc_AWID;
  output twiddle_h_rsc_triosy_lz;
  input revArr_rsc_s_tdone;
  input revArr_rsc_tr_write_done;
  input revArr_rsc_RREADY;
  output revArr_rsc_RVALID;
  output revArr_rsc_RUSER;
  output revArr_rsc_RLAST;
  output [1:0] revArr_rsc_RRESP;
  output [31:0] revArr_rsc_RDATA;
  output revArr_rsc_RID;
  output revArr_rsc_ARREADY;
  input revArr_rsc_ARVALID;
  input revArr_rsc_ARUSER;
  input [3:0] revArr_rsc_ARREGION;
  input [3:0] revArr_rsc_ARQOS;
  input [2:0] revArr_rsc_ARPROT;
  input [3:0] revArr_rsc_ARCACHE;
  input revArr_rsc_ARLOCK;
  input [1:0] revArr_rsc_ARBURST;
  input [2:0] revArr_rsc_ARSIZE;
  input [7:0] revArr_rsc_ARLEN;
  input [11:0] revArr_rsc_ARADDR;
  input revArr_rsc_ARID;
  input revArr_rsc_BREADY;
  output revArr_rsc_BVALID;
  output revArr_rsc_BUSER;
  output [1:0] revArr_rsc_BRESP;
  output revArr_rsc_BID;
  output revArr_rsc_WREADY;
  input revArr_rsc_WVALID;
  input revArr_rsc_WUSER;
  input revArr_rsc_WLAST;
  input [3:0] revArr_rsc_WSTRB;
  input [31:0] revArr_rsc_WDATA;
  output revArr_rsc_AWREADY;
  input revArr_rsc_AWVALID;
  input revArr_rsc_AWUSER;
  input [3:0] revArr_rsc_AWREGION;
  input [3:0] revArr_rsc_AWQOS;
  input [2:0] revArr_rsc_AWPROT;
  input [3:0] revArr_rsc_AWCACHE;
  input revArr_rsc_AWLOCK;
  input [1:0] revArr_rsc_AWBURST;
  input [2:0] revArr_rsc_AWSIZE;
  input [7:0] revArr_rsc_AWLEN;
  input [11:0] revArr_rsc_AWADDR;
  input revArr_rsc_AWID;
  output revArr_rsc_triosy_lz;
  input tw_rsc_s_tdone;
  input tw_rsc_tr_write_done;
  input tw_rsc_RREADY;
  output tw_rsc_RVALID;
  output tw_rsc_RUSER;
  output tw_rsc_RLAST;
  output [1:0] tw_rsc_RRESP;
  output [31:0] tw_rsc_RDATA;
  output tw_rsc_RID;
  output tw_rsc_ARREADY;
  input tw_rsc_ARVALID;
  input tw_rsc_ARUSER;
  input [3:0] tw_rsc_ARREGION;
  input [3:0] tw_rsc_ARQOS;
  input [2:0] tw_rsc_ARPROT;
  input [3:0] tw_rsc_ARCACHE;
  input tw_rsc_ARLOCK;
  input [1:0] tw_rsc_ARBURST;
  input [2:0] tw_rsc_ARSIZE;
  input [7:0] tw_rsc_ARLEN;
  input [11:0] tw_rsc_ARADDR;
  input tw_rsc_ARID;
  input tw_rsc_BREADY;
  output tw_rsc_BVALID;
  output tw_rsc_BUSER;
  output [1:0] tw_rsc_BRESP;
  output tw_rsc_BID;
  output tw_rsc_WREADY;
  input tw_rsc_WVALID;
  input tw_rsc_WUSER;
  input tw_rsc_WLAST;
  input [3:0] tw_rsc_WSTRB;
  input [31:0] tw_rsc_WDATA;
  output tw_rsc_AWREADY;
  input tw_rsc_AWVALID;
  input tw_rsc_AWUSER;
  input [3:0] tw_rsc_AWREGION;
  input [3:0] tw_rsc_AWQOS;
  input [2:0] tw_rsc_AWPROT;
  input [3:0] tw_rsc_AWCACHE;
  input tw_rsc_AWLOCK;
  input [1:0] tw_rsc_AWBURST;
  input [2:0] tw_rsc_AWSIZE;
  input [7:0] tw_rsc_AWLEN;
  input [11:0] tw_rsc_AWADDR;
  input tw_rsc_AWID;
  output tw_rsc_triosy_lz;
  input tw_h_rsc_s_tdone;
  input tw_h_rsc_tr_write_done;
  input tw_h_rsc_RREADY;
  output tw_h_rsc_RVALID;
  output tw_h_rsc_RUSER;
  output tw_h_rsc_RLAST;
  output [1:0] tw_h_rsc_RRESP;
  output [31:0] tw_h_rsc_RDATA;
  output tw_h_rsc_RID;
  output tw_h_rsc_ARREADY;
  input tw_h_rsc_ARVALID;
  input tw_h_rsc_ARUSER;
  input [3:0] tw_h_rsc_ARREGION;
  input [3:0] tw_h_rsc_ARQOS;
  input [2:0] tw_h_rsc_ARPROT;
  input [3:0] tw_h_rsc_ARCACHE;
  input tw_h_rsc_ARLOCK;
  input [1:0] tw_h_rsc_ARBURST;
  input [2:0] tw_h_rsc_ARSIZE;
  input [7:0] tw_h_rsc_ARLEN;
  input [11:0] tw_h_rsc_ARADDR;
  input tw_h_rsc_ARID;
  input tw_h_rsc_BREADY;
  output tw_h_rsc_BVALID;
  output tw_h_rsc_BUSER;
  output [1:0] tw_h_rsc_BRESP;
  output tw_h_rsc_BID;
  output tw_h_rsc_WREADY;
  input tw_h_rsc_WVALID;
  input tw_h_rsc_WUSER;
  input tw_h_rsc_WLAST;
  input [3:0] tw_h_rsc_WSTRB;
  input [31:0] tw_h_rsc_WDATA;
  output tw_h_rsc_AWREADY;
  input tw_h_rsc_AWVALID;
  input tw_h_rsc_AWUSER;
  input [3:0] tw_h_rsc_AWREGION;
  input [3:0] tw_h_rsc_AWQOS;
  input [2:0] tw_h_rsc_AWPROT;
  input [3:0] tw_h_rsc_AWCACHE;
  input tw_h_rsc_AWLOCK;
  input [1:0] tw_h_rsc_AWBURST;
  input [2:0] tw_h_rsc_AWSIZE;
  input [7:0] tw_h_rsc_AWLEN;
  input [11:0] tw_h_rsc_AWADDR;
  input tw_h_rsc_AWID;
  output tw_h_rsc_triosy_lz;


  // Interconnect Declarations
  wire xx_rsci_clken_d;
  wire [31:0] xx_rsci_d_d;
  wire [31:0] xx_rsci_q_d;
  wire [9:0] xx_rsci_radr_d;
  wire [9:0] xx_rsci_wadr_d;
  wire xx_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire yy_rsci_clken_d;
  wire [31:0] yy_rsci_d_d;
  wire [31:0] yy_rsci_q_d;
  wire [9:0] yy_rsci_radr_d;
  wire [9:0] yy_rsci_wadr_d;
  wire yy_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [4:0] S34_OUTER_LOOP_for_tf_mul_cmp_a;
  wire [9:0] S34_OUTER_LOOP_for_tf_mul_cmp_b;
  wire xx_rsc_clken;
  wire [31:0] xx_rsc_q;
  wire [9:0] xx_rsc_radr;
  wire xx_rsc_we;
  wire [31:0] xx_rsc_d;
  wire [9:0] xx_rsc_wadr;
  wire yy_rsc_clken;
  wire [31:0] yy_rsc_q;
  wire [9:0] yy_rsc_radr;
  wire yy_rsc_we;
  wire [31:0] yy_rsc_d;
  wire [9:0] yy_rsc_wadr;
  wire xx_rsci_we_d_iff;
  wire yy_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  wire [9:0] nl_hybrid_core_inst_S34_OUTER_LOOP_for_tf_mul_cmp_z;
  assign nl_hybrid_core_inst_S34_OUTER_LOOP_for_tf_mul_cmp_z = conv_u2u_15_10(S34_OUTER_LOOP_for_tf_mul_cmp_a
      * S34_OUTER_LOOP_for_tf_mul_cmp_b);
  BLOCK_1R1W_RBW #(.addr_width(32'sd10),
  .data_width(32'sd32),
  .depth(32'sd1024),
  .latency(32'sd1)) xx_rsc_comp (
      .clk(clk),
      .clken(xx_rsc_clken),
      .d(xx_rsc_d),
      .q(xx_rsc_q),
      .radr(xx_rsc_radr),
      .wadr(xx_rsc_wadr),
      .we(xx_rsc_we)
    );
  BLOCK_1R1W_RBW #(.addr_width(32'sd10),
  .data_width(32'sd32),
  .depth(32'sd1024),
  .latency(32'sd1)) yy_rsc_comp (
      .clk(clk),
      .clken(yy_rsc_clken),
      .d(yy_rsc_d),
      .q(yy_rsc_q),
      .radr(yy_rsc_radr),
      .wadr(yy_rsc_wadr),
      .we(yy_rsc_we)
    );
  hybrid_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_8_10_32_1024_1024_32_1_gen xx_rsci
      (
      .clken(xx_rsc_clken),
      .q(xx_rsc_q),
      .radr(xx_rsc_radr),
      .we(xx_rsc_we),
      .d(xx_rsc_d),
      .wadr(xx_rsc_wadr),
      .clken_d(xx_rsci_clken_d),
      .d_d(xx_rsci_d_d),
      .q_d(xx_rsci_q_d),
      .radr_d(xx_rsci_radr_d),
      .wadr_d(xx_rsci_wadr_d),
      .we_d(xx_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(xx_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(xx_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  hybrid_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_9_10_32_1024_1024_32_1_gen yy_rsci
      (
      .clken(yy_rsc_clken),
      .q(yy_rsc_q),
      .radr(yy_rsc_radr),
      .we(yy_rsc_we),
      .d(yy_rsc_d),
      .wadr(yy_rsc_wadr),
      .clken_d(yy_rsci_clken_d),
      .d_d(yy_rsci_d_d),
      .q_d(yy_rsci_q_d),
      .radr_d(yy_rsci_radr_d),
      .wadr_d(yy_rsci_wadr_d),
      .we_d(yy_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(yy_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(yy_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  hybrid_core hybrid_core_inst (
      .clk(clk),
      .rst(rst),
      .x_rsc_s_tdone(x_rsc_s_tdone),
      .x_rsc_tr_write_done(x_rsc_tr_write_done),
      .x_rsc_RREADY(x_rsc_RREADY),
      .x_rsc_RVALID(x_rsc_RVALID),
      .x_rsc_RUSER(x_rsc_RUSER),
      .x_rsc_RLAST(x_rsc_RLAST),
      .x_rsc_RRESP(x_rsc_RRESP),
      .x_rsc_RDATA(x_rsc_RDATA),
      .x_rsc_RID(x_rsc_RID),
      .x_rsc_ARREADY(x_rsc_ARREADY),
      .x_rsc_ARVALID(x_rsc_ARVALID),
      .x_rsc_ARUSER(x_rsc_ARUSER),
      .x_rsc_ARREGION(x_rsc_ARREGION),
      .x_rsc_ARQOS(x_rsc_ARQOS),
      .x_rsc_ARPROT(x_rsc_ARPROT),
      .x_rsc_ARCACHE(x_rsc_ARCACHE),
      .x_rsc_ARLOCK(x_rsc_ARLOCK),
      .x_rsc_ARBURST(x_rsc_ARBURST),
      .x_rsc_ARSIZE(x_rsc_ARSIZE),
      .x_rsc_ARLEN(x_rsc_ARLEN),
      .x_rsc_ARADDR(x_rsc_ARADDR),
      .x_rsc_ARID(x_rsc_ARID),
      .x_rsc_BREADY(x_rsc_BREADY),
      .x_rsc_BVALID(x_rsc_BVALID),
      .x_rsc_BUSER(x_rsc_BUSER),
      .x_rsc_BRESP(x_rsc_BRESP),
      .x_rsc_BID(x_rsc_BID),
      .x_rsc_WREADY(x_rsc_WREADY),
      .x_rsc_WVALID(x_rsc_WVALID),
      .x_rsc_WUSER(x_rsc_WUSER),
      .x_rsc_WLAST(x_rsc_WLAST),
      .x_rsc_WSTRB(x_rsc_WSTRB),
      .x_rsc_WDATA(x_rsc_WDATA),
      .x_rsc_AWREADY(x_rsc_AWREADY),
      .x_rsc_AWVALID(x_rsc_AWVALID),
      .x_rsc_AWUSER(x_rsc_AWUSER),
      .x_rsc_AWREGION(x_rsc_AWREGION),
      .x_rsc_AWQOS(x_rsc_AWQOS),
      .x_rsc_AWPROT(x_rsc_AWPROT),
      .x_rsc_AWCACHE(x_rsc_AWCACHE),
      .x_rsc_AWLOCK(x_rsc_AWLOCK),
      .x_rsc_AWBURST(x_rsc_AWBURST),
      .x_rsc_AWSIZE(x_rsc_AWSIZE),
      .x_rsc_AWLEN(x_rsc_AWLEN),
      .x_rsc_AWADDR(x_rsc_AWADDR),
      .x_rsc_AWID(x_rsc_AWID),
      .x_rsc_triosy_lz(x_rsc_triosy_lz),
      .m_rsc_dat(m_rsc_dat),
      .m_rsc_triosy_lz(m_rsc_triosy_lz),
      .twiddle_rsc_s_tdone(twiddle_rsc_s_tdone),
      .twiddle_rsc_tr_write_done(twiddle_rsc_tr_write_done),
      .twiddle_rsc_RREADY(twiddle_rsc_RREADY),
      .twiddle_rsc_RVALID(twiddle_rsc_RVALID),
      .twiddle_rsc_RUSER(twiddle_rsc_RUSER),
      .twiddle_rsc_RLAST(twiddle_rsc_RLAST),
      .twiddle_rsc_RRESP(twiddle_rsc_RRESP),
      .twiddle_rsc_RDATA(twiddle_rsc_RDATA),
      .twiddle_rsc_RID(twiddle_rsc_RID),
      .twiddle_rsc_ARREADY(twiddle_rsc_ARREADY),
      .twiddle_rsc_ARVALID(twiddle_rsc_ARVALID),
      .twiddle_rsc_ARUSER(twiddle_rsc_ARUSER),
      .twiddle_rsc_ARREGION(twiddle_rsc_ARREGION),
      .twiddle_rsc_ARQOS(twiddle_rsc_ARQOS),
      .twiddle_rsc_ARPROT(twiddle_rsc_ARPROT),
      .twiddle_rsc_ARCACHE(twiddle_rsc_ARCACHE),
      .twiddle_rsc_ARLOCK(twiddle_rsc_ARLOCK),
      .twiddle_rsc_ARBURST(twiddle_rsc_ARBURST),
      .twiddle_rsc_ARSIZE(twiddle_rsc_ARSIZE),
      .twiddle_rsc_ARLEN(twiddle_rsc_ARLEN),
      .twiddle_rsc_ARADDR(twiddle_rsc_ARADDR),
      .twiddle_rsc_ARID(twiddle_rsc_ARID),
      .twiddle_rsc_BREADY(twiddle_rsc_BREADY),
      .twiddle_rsc_BVALID(twiddle_rsc_BVALID),
      .twiddle_rsc_BUSER(twiddle_rsc_BUSER),
      .twiddle_rsc_BRESP(twiddle_rsc_BRESP),
      .twiddle_rsc_BID(twiddle_rsc_BID),
      .twiddle_rsc_WREADY(twiddle_rsc_WREADY),
      .twiddle_rsc_WVALID(twiddle_rsc_WVALID),
      .twiddle_rsc_WUSER(twiddle_rsc_WUSER),
      .twiddle_rsc_WLAST(twiddle_rsc_WLAST),
      .twiddle_rsc_WSTRB(twiddle_rsc_WSTRB),
      .twiddle_rsc_WDATA(twiddle_rsc_WDATA),
      .twiddle_rsc_AWREADY(twiddle_rsc_AWREADY),
      .twiddle_rsc_AWVALID(twiddle_rsc_AWVALID),
      .twiddle_rsc_AWUSER(twiddle_rsc_AWUSER),
      .twiddle_rsc_AWREGION(twiddle_rsc_AWREGION),
      .twiddle_rsc_AWQOS(twiddle_rsc_AWQOS),
      .twiddle_rsc_AWPROT(twiddle_rsc_AWPROT),
      .twiddle_rsc_AWCACHE(twiddle_rsc_AWCACHE),
      .twiddle_rsc_AWLOCK(twiddle_rsc_AWLOCK),
      .twiddle_rsc_AWBURST(twiddle_rsc_AWBURST),
      .twiddle_rsc_AWSIZE(twiddle_rsc_AWSIZE),
      .twiddle_rsc_AWLEN(twiddle_rsc_AWLEN),
      .twiddle_rsc_AWADDR(twiddle_rsc_AWADDR),
      .twiddle_rsc_AWID(twiddle_rsc_AWID),
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .twiddle_h_rsc_s_tdone(twiddle_h_rsc_s_tdone),
      .twiddle_h_rsc_tr_write_done(twiddle_h_rsc_tr_write_done),
      .twiddle_h_rsc_RREADY(twiddle_h_rsc_RREADY),
      .twiddle_h_rsc_RVALID(twiddle_h_rsc_RVALID),
      .twiddle_h_rsc_RUSER(twiddle_h_rsc_RUSER),
      .twiddle_h_rsc_RLAST(twiddle_h_rsc_RLAST),
      .twiddle_h_rsc_RRESP(twiddle_h_rsc_RRESP),
      .twiddle_h_rsc_RDATA(twiddle_h_rsc_RDATA),
      .twiddle_h_rsc_RID(twiddle_h_rsc_RID),
      .twiddle_h_rsc_ARREADY(twiddle_h_rsc_ARREADY),
      .twiddle_h_rsc_ARVALID(twiddle_h_rsc_ARVALID),
      .twiddle_h_rsc_ARUSER(twiddle_h_rsc_ARUSER),
      .twiddle_h_rsc_ARREGION(twiddle_h_rsc_ARREGION),
      .twiddle_h_rsc_ARQOS(twiddle_h_rsc_ARQOS),
      .twiddle_h_rsc_ARPROT(twiddle_h_rsc_ARPROT),
      .twiddle_h_rsc_ARCACHE(twiddle_h_rsc_ARCACHE),
      .twiddle_h_rsc_ARLOCK(twiddle_h_rsc_ARLOCK),
      .twiddle_h_rsc_ARBURST(twiddle_h_rsc_ARBURST),
      .twiddle_h_rsc_ARSIZE(twiddle_h_rsc_ARSIZE),
      .twiddle_h_rsc_ARLEN(twiddle_h_rsc_ARLEN),
      .twiddle_h_rsc_ARADDR(twiddle_h_rsc_ARADDR),
      .twiddle_h_rsc_ARID(twiddle_h_rsc_ARID),
      .twiddle_h_rsc_BREADY(twiddle_h_rsc_BREADY),
      .twiddle_h_rsc_BVALID(twiddle_h_rsc_BVALID),
      .twiddle_h_rsc_BUSER(twiddle_h_rsc_BUSER),
      .twiddle_h_rsc_BRESP(twiddle_h_rsc_BRESP),
      .twiddle_h_rsc_BID(twiddle_h_rsc_BID),
      .twiddle_h_rsc_WREADY(twiddle_h_rsc_WREADY),
      .twiddle_h_rsc_WVALID(twiddle_h_rsc_WVALID),
      .twiddle_h_rsc_WUSER(twiddle_h_rsc_WUSER),
      .twiddle_h_rsc_WLAST(twiddle_h_rsc_WLAST),
      .twiddle_h_rsc_WSTRB(twiddle_h_rsc_WSTRB),
      .twiddle_h_rsc_WDATA(twiddle_h_rsc_WDATA),
      .twiddle_h_rsc_AWREADY(twiddle_h_rsc_AWREADY),
      .twiddle_h_rsc_AWVALID(twiddle_h_rsc_AWVALID),
      .twiddle_h_rsc_AWUSER(twiddle_h_rsc_AWUSER),
      .twiddle_h_rsc_AWREGION(twiddle_h_rsc_AWREGION),
      .twiddle_h_rsc_AWQOS(twiddle_h_rsc_AWQOS),
      .twiddle_h_rsc_AWPROT(twiddle_h_rsc_AWPROT),
      .twiddle_h_rsc_AWCACHE(twiddle_h_rsc_AWCACHE),
      .twiddle_h_rsc_AWLOCK(twiddle_h_rsc_AWLOCK),
      .twiddle_h_rsc_AWBURST(twiddle_h_rsc_AWBURST),
      .twiddle_h_rsc_AWSIZE(twiddle_h_rsc_AWSIZE),
      .twiddle_h_rsc_AWLEN(twiddle_h_rsc_AWLEN),
      .twiddle_h_rsc_AWADDR(twiddle_h_rsc_AWADDR),
      .twiddle_h_rsc_AWID(twiddle_h_rsc_AWID),
      .twiddle_h_rsc_triosy_lz(twiddle_h_rsc_triosy_lz),
      .revArr_rsc_s_tdone(revArr_rsc_s_tdone),
      .revArr_rsc_tr_write_done(revArr_rsc_tr_write_done),
      .revArr_rsc_RREADY(revArr_rsc_RREADY),
      .revArr_rsc_RVALID(revArr_rsc_RVALID),
      .revArr_rsc_RUSER(revArr_rsc_RUSER),
      .revArr_rsc_RLAST(revArr_rsc_RLAST),
      .revArr_rsc_RRESP(revArr_rsc_RRESP),
      .revArr_rsc_RDATA(revArr_rsc_RDATA),
      .revArr_rsc_RID(revArr_rsc_RID),
      .revArr_rsc_ARREADY(revArr_rsc_ARREADY),
      .revArr_rsc_ARVALID(revArr_rsc_ARVALID),
      .revArr_rsc_ARUSER(revArr_rsc_ARUSER),
      .revArr_rsc_ARREGION(revArr_rsc_ARREGION),
      .revArr_rsc_ARQOS(revArr_rsc_ARQOS),
      .revArr_rsc_ARPROT(revArr_rsc_ARPROT),
      .revArr_rsc_ARCACHE(revArr_rsc_ARCACHE),
      .revArr_rsc_ARLOCK(revArr_rsc_ARLOCK),
      .revArr_rsc_ARBURST(revArr_rsc_ARBURST),
      .revArr_rsc_ARSIZE(revArr_rsc_ARSIZE),
      .revArr_rsc_ARLEN(revArr_rsc_ARLEN),
      .revArr_rsc_ARADDR(revArr_rsc_ARADDR),
      .revArr_rsc_ARID(revArr_rsc_ARID),
      .revArr_rsc_BREADY(revArr_rsc_BREADY),
      .revArr_rsc_BVALID(revArr_rsc_BVALID),
      .revArr_rsc_BUSER(revArr_rsc_BUSER),
      .revArr_rsc_BRESP(revArr_rsc_BRESP),
      .revArr_rsc_BID(revArr_rsc_BID),
      .revArr_rsc_WREADY(revArr_rsc_WREADY),
      .revArr_rsc_WVALID(revArr_rsc_WVALID),
      .revArr_rsc_WUSER(revArr_rsc_WUSER),
      .revArr_rsc_WLAST(revArr_rsc_WLAST),
      .revArr_rsc_WSTRB(revArr_rsc_WSTRB),
      .revArr_rsc_WDATA(revArr_rsc_WDATA),
      .revArr_rsc_AWREADY(revArr_rsc_AWREADY),
      .revArr_rsc_AWVALID(revArr_rsc_AWVALID),
      .revArr_rsc_AWUSER(revArr_rsc_AWUSER),
      .revArr_rsc_AWREGION(revArr_rsc_AWREGION),
      .revArr_rsc_AWQOS(revArr_rsc_AWQOS),
      .revArr_rsc_AWPROT(revArr_rsc_AWPROT),
      .revArr_rsc_AWCACHE(revArr_rsc_AWCACHE),
      .revArr_rsc_AWLOCK(revArr_rsc_AWLOCK),
      .revArr_rsc_AWBURST(revArr_rsc_AWBURST),
      .revArr_rsc_AWSIZE(revArr_rsc_AWSIZE),
      .revArr_rsc_AWLEN(revArr_rsc_AWLEN),
      .revArr_rsc_AWADDR(revArr_rsc_AWADDR),
      .revArr_rsc_AWID(revArr_rsc_AWID),
      .revArr_rsc_triosy_lz(revArr_rsc_triosy_lz),
      .tw_rsc_s_tdone(tw_rsc_s_tdone),
      .tw_rsc_tr_write_done(tw_rsc_tr_write_done),
      .tw_rsc_RREADY(tw_rsc_RREADY),
      .tw_rsc_RVALID(tw_rsc_RVALID),
      .tw_rsc_RUSER(tw_rsc_RUSER),
      .tw_rsc_RLAST(tw_rsc_RLAST),
      .tw_rsc_RRESP(tw_rsc_RRESP),
      .tw_rsc_RDATA(tw_rsc_RDATA),
      .tw_rsc_RID(tw_rsc_RID),
      .tw_rsc_ARREADY(tw_rsc_ARREADY),
      .tw_rsc_ARVALID(tw_rsc_ARVALID),
      .tw_rsc_ARUSER(tw_rsc_ARUSER),
      .tw_rsc_ARREGION(tw_rsc_ARREGION),
      .tw_rsc_ARQOS(tw_rsc_ARQOS),
      .tw_rsc_ARPROT(tw_rsc_ARPROT),
      .tw_rsc_ARCACHE(tw_rsc_ARCACHE),
      .tw_rsc_ARLOCK(tw_rsc_ARLOCK),
      .tw_rsc_ARBURST(tw_rsc_ARBURST),
      .tw_rsc_ARSIZE(tw_rsc_ARSIZE),
      .tw_rsc_ARLEN(tw_rsc_ARLEN),
      .tw_rsc_ARADDR(tw_rsc_ARADDR),
      .tw_rsc_ARID(tw_rsc_ARID),
      .tw_rsc_BREADY(tw_rsc_BREADY),
      .tw_rsc_BVALID(tw_rsc_BVALID),
      .tw_rsc_BUSER(tw_rsc_BUSER),
      .tw_rsc_BRESP(tw_rsc_BRESP),
      .tw_rsc_BID(tw_rsc_BID),
      .tw_rsc_WREADY(tw_rsc_WREADY),
      .tw_rsc_WVALID(tw_rsc_WVALID),
      .tw_rsc_WUSER(tw_rsc_WUSER),
      .tw_rsc_WLAST(tw_rsc_WLAST),
      .tw_rsc_WSTRB(tw_rsc_WSTRB),
      .tw_rsc_WDATA(tw_rsc_WDATA),
      .tw_rsc_AWREADY(tw_rsc_AWREADY),
      .tw_rsc_AWVALID(tw_rsc_AWVALID),
      .tw_rsc_AWUSER(tw_rsc_AWUSER),
      .tw_rsc_AWREGION(tw_rsc_AWREGION),
      .tw_rsc_AWQOS(tw_rsc_AWQOS),
      .tw_rsc_AWPROT(tw_rsc_AWPROT),
      .tw_rsc_AWCACHE(tw_rsc_AWCACHE),
      .tw_rsc_AWLOCK(tw_rsc_AWLOCK),
      .tw_rsc_AWBURST(tw_rsc_AWBURST),
      .tw_rsc_AWSIZE(tw_rsc_AWSIZE),
      .tw_rsc_AWLEN(tw_rsc_AWLEN),
      .tw_rsc_AWADDR(tw_rsc_AWADDR),
      .tw_rsc_AWID(tw_rsc_AWID),
      .tw_rsc_triosy_lz(tw_rsc_triosy_lz),
      .tw_h_rsc_s_tdone(tw_h_rsc_s_tdone),
      .tw_h_rsc_tr_write_done(tw_h_rsc_tr_write_done),
      .tw_h_rsc_RREADY(tw_h_rsc_RREADY),
      .tw_h_rsc_RVALID(tw_h_rsc_RVALID),
      .tw_h_rsc_RUSER(tw_h_rsc_RUSER),
      .tw_h_rsc_RLAST(tw_h_rsc_RLAST),
      .tw_h_rsc_RRESP(tw_h_rsc_RRESP),
      .tw_h_rsc_RDATA(tw_h_rsc_RDATA),
      .tw_h_rsc_RID(tw_h_rsc_RID),
      .tw_h_rsc_ARREADY(tw_h_rsc_ARREADY),
      .tw_h_rsc_ARVALID(tw_h_rsc_ARVALID),
      .tw_h_rsc_ARUSER(tw_h_rsc_ARUSER),
      .tw_h_rsc_ARREGION(tw_h_rsc_ARREGION),
      .tw_h_rsc_ARQOS(tw_h_rsc_ARQOS),
      .tw_h_rsc_ARPROT(tw_h_rsc_ARPROT),
      .tw_h_rsc_ARCACHE(tw_h_rsc_ARCACHE),
      .tw_h_rsc_ARLOCK(tw_h_rsc_ARLOCK),
      .tw_h_rsc_ARBURST(tw_h_rsc_ARBURST),
      .tw_h_rsc_ARSIZE(tw_h_rsc_ARSIZE),
      .tw_h_rsc_ARLEN(tw_h_rsc_ARLEN),
      .tw_h_rsc_ARADDR(tw_h_rsc_ARADDR),
      .tw_h_rsc_ARID(tw_h_rsc_ARID),
      .tw_h_rsc_BREADY(tw_h_rsc_BREADY),
      .tw_h_rsc_BVALID(tw_h_rsc_BVALID),
      .tw_h_rsc_BUSER(tw_h_rsc_BUSER),
      .tw_h_rsc_BRESP(tw_h_rsc_BRESP),
      .tw_h_rsc_BID(tw_h_rsc_BID),
      .tw_h_rsc_WREADY(tw_h_rsc_WREADY),
      .tw_h_rsc_WVALID(tw_h_rsc_WVALID),
      .tw_h_rsc_WUSER(tw_h_rsc_WUSER),
      .tw_h_rsc_WLAST(tw_h_rsc_WLAST),
      .tw_h_rsc_WSTRB(tw_h_rsc_WSTRB),
      .tw_h_rsc_WDATA(tw_h_rsc_WDATA),
      .tw_h_rsc_AWREADY(tw_h_rsc_AWREADY),
      .tw_h_rsc_AWVALID(tw_h_rsc_AWVALID),
      .tw_h_rsc_AWUSER(tw_h_rsc_AWUSER),
      .tw_h_rsc_AWREGION(tw_h_rsc_AWREGION),
      .tw_h_rsc_AWQOS(tw_h_rsc_AWQOS),
      .tw_h_rsc_AWPROT(tw_h_rsc_AWPROT),
      .tw_h_rsc_AWCACHE(tw_h_rsc_AWCACHE),
      .tw_h_rsc_AWLOCK(tw_h_rsc_AWLOCK),
      .tw_h_rsc_AWBURST(tw_h_rsc_AWBURST),
      .tw_h_rsc_AWSIZE(tw_h_rsc_AWSIZE),
      .tw_h_rsc_AWLEN(tw_h_rsc_AWLEN),
      .tw_h_rsc_AWADDR(tw_h_rsc_AWADDR),
      .tw_h_rsc_AWID(tw_h_rsc_AWID),
      .tw_h_rsc_triosy_lz(tw_h_rsc_triosy_lz),
      .xx_rsci_clken_d(xx_rsci_clken_d),
      .xx_rsci_d_d(xx_rsci_d_d),
      .xx_rsci_q_d(xx_rsci_q_d),
      .xx_rsci_radr_d(xx_rsci_radr_d),
      .xx_rsci_wadr_d(xx_rsci_wadr_d),
      .xx_rsci_readA_r_ram_ir_internal_RMASK_B_d(xx_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .yy_rsci_clken_d(yy_rsci_clken_d),
      .yy_rsci_d_d(yy_rsci_d_d),
      .yy_rsci_q_d(yy_rsci_q_d),
      .yy_rsci_radr_d(yy_rsci_radr_d),
      .yy_rsci_wadr_d(yy_rsci_wadr_d),
      .yy_rsci_readA_r_ram_ir_internal_RMASK_B_d(yy_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .S34_OUTER_LOOP_for_tf_mul_cmp_a(S34_OUTER_LOOP_for_tf_mul_cmp_a),
      .S34_OUTER_LOOP_for_tf_mul_cmp_b(S34_OUTER_LOOP_for_tf_mul_cmp_b),
      .S34_OUTER_LOOP_for_tf_mul_cmp_z(nl_hybrid_core_inst_S34_OUTER_LOOP_for_tf_mul_cmp_z[9:0]),
      .xx_rsci_we_d_pff(xx_rsci_we_d_iff),
      .yy_rsci_we_d_pff(yy_rsci_we_d_iff)
    );

  function automatic [9:0] conv_u2u_15_10 ;
    input [14:0]  vector ;
  begin
    conv_u2u_15_10 = vector[9:0];
  end
  endfunction

endmodule



