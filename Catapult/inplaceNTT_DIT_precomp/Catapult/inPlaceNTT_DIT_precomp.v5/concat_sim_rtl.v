
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

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Aug 19 16:48:21 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_core_fsm (
  clk, rst, core_wen, fsm_output, COMP_LOOP_C_38_tr0, COMP_LOOP_C_77_tr0, VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input core_wen;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
  input COMP_LOOP_C_38_tr0;
  input COMP_LOOP_C_77_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_precomp_core_core_fsm_1
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
    VEC_LOOP_C_0 = 7'd80,
    STAGE_LOOP_C_1 = 7'd81,
    main_C_1 = 7'd82;

  reg [6:0] state_var;
  reg [6:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIT_precomp_core_core_fsm_1
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
        if ( COMP_LOOP_C_38_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_39;
        end
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
        if ( COMP_LOOP_C_77_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 7'b1010000;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 7'b1010001;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b1010010;
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
    else if ( core_wen ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_staller
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_staller (
  clk, rst, core_wen, core_wten, vec_rsc_0_0_i_wen_comp, vec_rsc_0_0_i_wen_comp_1,
      vec_rsc_0_1_i_wen_comp, vec_rsc_0_1_i_wen_comp_1, twiddle_rsc_0_0_i_wen_comp,
      twiddle_rsc_0_1_i_wen_comp
);
  input clk;
  input rst;
  output core_wen;
  output core_wten;
  reg core_wten;
  input vec_rsc_0_0_i_wen_comp;
  input vec_rsc_0_0_i_wen_comp_1;
  input vec_rsc_0_1_i_wen_comp;
  input vec_rsc_0_1_i_wen_comp_1;
  input twiddle_rsc_0_0_i_wen_comp;
  input twiddle_rsc_0_1_i_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign core_wen = vec_rsc_0_0_i_wen_comp & vec_rsc_0_0_i_wen_comp_1 & vec_rsc_0_1_i_wen_comp
      & vec_rsc_0_1_i_wen_comp_1 & twiddle_rsc_0_0_i_wen_comp & twiddle_rsc_0_1_i_wen_comp;
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_0_obj_iswt0, twiddle_rsc_triosy_0_0_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_0_obj_iswt0;
  output twiddle_rsc_triosy_0_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_0_obj_ld_core_sct = twiddle_rsc_triosy_0_0_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_1_obj_iswt0, twiddle_rsc_triosy_0_1_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_1_obj_iswt0;
  output twiddle_rsc_triosy_0_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_1_obj_ld_core_sct = twiddle_rsc_triosy_0_1_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl (
  core_wten, r_rsc_triosy_obj_iswt0, r_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input r_rsc_triosy_obj_iswt0;
  output r_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign r_rsc_triosy_obj_ld_core_sct = r_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl (
  core_wten, p_rsc_triosy_obj_iswt0, p_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input p_rsc_triosy_obj_iswt0;
  output p_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign p_rsc_triosy_obj_ld_core_sct = p_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_0_obj_iswt0, vec_rsc_triosy_0_0_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_0_obj_iswt0;
  output vec_rsc_triosy_0_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_0_obj_ld_core_sct = vec_rsc_triosy_0_0_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_1_obj_iswt0, vec_rsc_triosy_0_1_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_1_obj_iswt0;
  output vec_rsc_triosy_0_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_1_obj_ld_core_sct = vec_rsc_triosy_0_1_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp (
  clk, rst, twiddle_rsc_0_1_i_oswt, twiddle_rsc_0_1_i_wen_comp, twiddle_rsc_0_1_i_s_raddr_core,
      twiddle_rsc_0_1_i_s_din_mxwt, twiddle_rsc_0_1_i_biwt, twiddle_rsc_0_1_i_bdwt,
      twiddle_rsc_0_1_i_bcwt, twiddle_rsc_0_1_i_s_raddr, twiddle_rsc_0_1_i_s_raddr_core_sct,
      twiddle_rsc_0_1_i_s_din
);
  input clk;
  input rst;
  input twiddle_rsc_0_1_i_oswt;
  output twiddle_rsc_0_1_i_wen_comp;
  input [8:0] twiddle_rsc_0_1_i_s_raddr_core;
  output [63:0] twiddle_rsc_0_1_i_s_din_mxwt;
  input twiddle_rsc_0_1_i_biwt;
  input twiddle_rsc_0_1_i_bdwt;
  output twiddle_rsc_0_1_i_bcwt;
  reg twiddle_rsc_0_1_i_bcwt;
  output [8:0] twiddle_rsc_0_1_i_s_raddr;
  input twiddle_rsc_0_1_i_s_raddr_core_sct;
  input [63:0] twiddle_rsc_0_1_i_s_din;


  // Interconnect Declarations
  reg [63:0] twiddle_rsc_0_1_i_s_din_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_1_i_wen_comp = (~ twiddle_rsc_0_1_i_oswt) | twiddle_rsc_0_1_i_biwt
      | twiddle_rsc_0_1_i_bcwt;
  assign twiddle_rsc_0_1_i_s_raddr = MUX_v_9_2_2(9'b000000000, twiddle_rsc_0_1_i_s_raddr_core,
      twiddle_rsc_0_1_i_s_raddr_core_sct);
  assign twiddle_rsc_0_1_i_s_din_mxwt = MUX_v_64_2_2(twiddle_rsc_0_1_i_s_din, twiddle_rsc_0_1_i_s_din_bfwt,
      twiddle_rsc_0_1_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_1_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_1_i_bcwt <= ~((~(twiddle_rsc_0_1_i_bcwt | twiddle_rsc_0_1_i_biwt))
          | twiddle_rsc_0_1_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_1_i_biwt ) begin
      twiddle_rsc_0_1_i_s_din_bfwt <= twiddle_rsc_0_1_i_s_din;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl (
  core_wen, twiddle_rsc_0_1_i_oswt, twiddle_rsc_0_1_i_biwt, twiddle_rsc_0_1_i_bdwt,
      twiddle_rsc_0_1_i_bcwt, twiddle_rsc_0_1_i_s_re_core_sct, twiddle_rsc_0_1_i_s_rrdy
);
  input core_wen;
  input twiddle_rsc_0_1_i_oswt;
  output twiddle_rsc_0_1_i_biwt;
  output twiddle_rsc_0_1_i_bdwt;
  input twiddle_rsc_0_1_i_bcwt;
  output twiddle_rsc_0_1_i_s_re_core_sct;
  input twiddle_rsc_0_1_i_s_rrdy;


  // Interconnect Declarations
  wire twiddle_rsc_0_1_i_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_1_i_bdwt = twiddle_rsc_0_1_i_oswt & core_wen;
  assign twiddle_rsc_0_1_i_biwt = twiddle_rsc_0_1_i_ogwt & twiddle_rsc_0_1_i_s_rrdy;
  assign twiddle_rsc_0_1_i_ogwt = twiddle_rsc_0_1_i_oswt & (~ twiddle_rsc_0_1_i_bcwt);
  assign twiddle_rsc_0_1_i_s_re_core_sct = twiddle_rsc_0_1_i_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp (
  clk, rst, twiddle_rsc_0_0_i_oswt, twiddle_rsc_0_0_i_wen_comp, twiddle_rsc_0_0_i_s_raddr_core,
      twiddle_rsc_0_0_i_s_din_mxwt, twiddle_rsc_0_0_i_biwt, twiddle_rsc_0_0_i_bdwt,
      twiddle_rsc_0_0_i_bcwt, twiddle_rsc_0_0_i_s_raddr, twiddle_rsc_0_0_i_s_raddr_core_sct,
      twiddle_rsc_0_0_i_s_din
);
  input clk;
  input rst;
  input twiddle_rsc_0_0_i_oswt;
  output twiddle_rsc_0_0_i_wen_comp;
  input [8:0] twiddle_rsc_0_0_i_s_raddr_core;
  output [63:0] twiddle_rsc_0_0_i_s_din_mxwt;
  input twiddle_rsc_0_0_i_biwt;
  input twiddle_rsc_0_0_i_bdwt;
  output twiddle_rsc_0_0_i_bcwt;
  reg twiddle_rsc_0_0_i_bcwt;
  output [8:0] twiddle_rsc_0_0_i_s_raddr;
  input twiddle_rsc_0_0_i_s_raddr_core_sct;
  input [63:0] twiddle_rsc_0_0_i_s_din;


  // Interconnect Declarations
  reg [63:0] twiddle_rsc_0_0_i_s_din_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_0_i_wen_comp = (~ twiddle_rsc_0_0_i_oswt) | twiddle_rsc_0_0_i_biwt
      | twiddle_rsc_0_0_i_bcwt;
  assign twiddle_rsc_0_0_i_s_raddr = MUX_v_9_2_2(9'b000000000, twiddle_rsc_0_0_i_s_raddr_core,
      twiddle_rsc_0_0_i_s_raddr_core_sct);
  assign twiddle_rsc_0_0_i_s_din_mxwt = MUX_v_64_2_2(twiddle_rsc_0_0_i_s_din, twiddle_rsc_0_0_i_s_din_bfwt,
      twiddle_rsc_0_0_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_0_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_0_i_bcwt <= ~((~(twiddle_rsc_0_0_i_bcwt | twiddle_rsc_0_0_i_biwt))
          | twiddle_rsc_0_0_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_0_i_biwt ) begin
      twiddle_rsc_0_0_i_s_din_bfwt <= twiddle_rsc_0_0_i_s_din;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl (
  core_wen, twiddle_rsc_0_0_i_oswt, twiddle_rsc_0_0_i_biwt, twiddle_rsc_0_0_i_bdwt,
      twiddle_rsc_0_0_i_bcwt, twiddle_rsc_0_0_i_s_re_core_sct, twiddle_rsc_0_0_i_s_rrdy
);
  input core_wen;
  input twiddle_rsc_0_0_i_oswt;
  output twiddle_rsc_0_0_i_biwt;
  output twiddle_rsc_0_0_i_bdwt;
  input twiddle_rsc_0_0_i_bcwt;
  output twiddle_rsc_0_0_i_s_re_core_sct;
  input twiddle_rsc_0_0_i_s_rrdy;


  // Interconnect Declarations
  wire twiddle_rsc_0_0_i_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_0_i_bdwt = twiddle_rsc_0_0_i_oswt & core_wen;
  assign twiddle_rsc_0_0_i_biwt = twiddle_rsc_0_0_i_ogwt & twiddle_rsc_0_0_i_s_rrdy;
  assign twiddle_rsc_0_0_i_ogwt = twiddle_rsc_0_0_i_oswt & (~ twiddle_rsc_0_0_i_bcwt);
  assign twiddle_rsc_0_0_i_s_re_core_sct = twiddle_rsc_0_0_i_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp (
  clk, rst, vec_rsc_0_1_i_oswt, vec_rsc_0_1_i_wen_comp, vec_rsc_0_1_i_oswt_1, vec_rsc_0_1_i_wen_comp_1,
      vec_rsc_0_1_i_s_raddr_core, vec_rsc_0_1_i_s_waddr_core, vec_rsc_0_1_i_s_din_mxwt,
      vec_rsc_0_1_i_s_dout_core, vec_rsc_0_1_i_biwt, vec_rsc_0_1_i_bdwt, vec_rsc_0_1_i_bcwt,
      vec_rsc_0_1_i_biwt_1, vec_rsc_0_1_i_bdwt_2, vec_rsc_0_1_i_bcwt_1, vec_rsc_0_1_i_s_raddr,
      vec_rsc_0_1_i_s_raddr_core_sct, vec_rsc_0_1_i_s_waddr, vec_rsc_0_1_i_s_waddr_core_sct,
      vec_rsc_0_1_i_s_din, vec_rsc_0_1_i_s_dout
);
  input clk;
  input rst;
  input vec_rsc_0_1_i_oswt;
  output vec_rsc_0_1_i_wen_comp;
  input vec_rsc_0_1_i_oswt_1;
  output vec_rsc_0_1_i_wen_comp_1;
  input [8:0] vec_rsc_0_1_i_s_raddr_core;
  input [8:0] vec_rsc_0_1_i_s_waddr_core;
  output [63:0] vec_rsc_0_1_i_s_din_mxwt;
  input [63:0] vec_rsc_0_1_i_s_dout_core;
  input vec_rsc_0_1_i_biwt;
  input vec_rsc_0_1_i_bdwt;
  output vec_rsc_0_1_i_bcwt;
  reg vec_rsc_0_1_i_bcwt;
  input vec_rsc_0_1_i_biwt_1;
  input vec_rsc_0_1_i_bdwt_2;
  output vec_rsc_0_1_i_bcwt_1;
  reg vec_rsc_0_1_i_bcwt_1;
  output [8:0] vec_rsc_0_1_i_s_raddr;
  input vec_rsc_0_1_i_s_raddr_core_sct;
  output [8:0] vec_rsc_0_1_i_s_waddr;
  input vec_rsc_0_1_i_s_waddr_core_sct;
  input [63:0] vec_rsc_0_1_i_s_din;
  output [63:0] vec_rsc_0_1_i_s_dout;


  // Interconnect Declarations
  reg [63:0] vec_rsc_0_1_i_s_din_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_1_i_wen_comp = (~ vec_rsc_0_1_i_oswt) | vec_rsc_0_1_i_biwt | vec_rsc_0_1_i_bcwt;
  assign vec_rsc_0_1_i_wen_comp_1 = (~ vec_rsc_0_1_i_oswt_1) | vec_rsc_0_1_i_biwt_1
      | vec_rsc_0_1_i_bcwt_1;
  assign vec_rsc_0_1_i_s_raddr = MUX_v_9_2_2(9'b000000000, vec_rsc_0_1_i_s_raddr_core,
      vec_rsc_0_1_i_s_raddr_core_sct);
  assign vec_rsc_0_1_i_s_waddr = MUX_v_9_2_2(9'b000000000, vec_rsc_0_1_i_s_waddr_core,
      vec_rsc_0_1_i_s_waddr_core_sct);
  assign vec_rsc_0_1_i_s_din_mxwt = MUX_v_64_2_2(vec_rsc_0_1_i_s_din, vec_rsc_0_1_i_s_din_bfwt,
      vec_rsc_0_1_i_bcwt);
  assign vec_rsc_0_1_i_s_dout = MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000000,
      vec_rsc_0_1_i_s_dout_core, vec_rsc_0_1_i_s_waddr_core_sct);
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_1_i_bcwt <= 1'b0;
      vec_rsc_0_1_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_1_i_bcwt <= ~((~(vec_rsc_0_1_i_bcwt | vec_rsc_0_1_i_biwt)) | vec_rsc_0_1_i_bdwt);
      vec_rsc_0_1_i_bcwt_1 <= ~((~(vec_rsc_0_1_i_bcwt_1 | vec_rsc_0_1_i_biwt_1))
          | vec_rsc_0_1_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_1_i_biwt ) begin
      vec_rsc_0_1_i_s_din_bfwt <= vec_rsc_0_1_i_s_din;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl (
  core_wen, vec_rsc_0_1_i_oswt, vec_rsc_0_1_i_oswt_1, vec_rsc_0_1_i_biwt, vec_rsc_0_1_i_bdwt,
      vec_rsc_0_1_i_bcwt, vec_rsc_0_1_i_s_re_core_sct, vec_rsc_0_1_i_biwt_1, vec_rsc_0_1_i_bdwt_2,
      vec_rsc_0_1_i_bcwt_1, vec_rsc_0_1_i_s_we_core_sct, vec_rsc_0_1_i_s_rrdy, vec_rsc_0_1_i_s_wrdy
);
  input core_wen;
  input vec_rsc_0_1_i_oswt;
  input vec_rsc_0_1_i_oswt_1;
  output vec_rsc_0_1_i_biwt;
  output vec_rsc_0_1_i_bdwt;
  input vec_rsc_0_1_i_bcwt;
  output vec_rsc_0_1_i_s_re_core_sct;
  output vec_rsc_0_1_i_biwt_1;
  output vec_rsc_0_1_i_bdwt_2;
  input vec_rsc_0_1_i_bcwt_1;
  output vec_rsc_0_1_i_s_we_core_sct;
  input vec_rsc_0_1_i_s_rrdy;
  input vec_rsc_0_1_i_s_wrdy;


  // Interconnect Declarations
  wire vec_rsc_0_1_i_ogwt;
  wire vec_rsc_0_1_i_ogwt_1;


  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_1_i_bdwt = vec_rsc_0_1_i_oswt & core_wen;
  assign vec_rsc_0_1_i_biwt = vec_rsc_0_1_i_ogwt & vec_rsc_0_1_i_s_rrdy;
  assign vec_rsc_0_1_i_ogwt = vec_rsc_0_1_i_oswt & (~ vec_rsc_0_1_i_bcwt);
  assign vec_rsc_0_1_i_s_re_core_sct = vec_rsc_0_1_i_ogwt;
  assign vec_rsc_0_1_i_bdwt_2 = vec_rsc_0_1_i_oswt_1 & core_wen;
  assign vec_rsc_0_1_i_biwt_1 = vec_rsc_0_1_i_ogwt_1 & vec_rsc_0_1_i_s_wrdy;
  assign vec_rsc_0_1_i_ogwt_1 = vec_rsc_0_1_i_oswt_1 & (~ vec_rsc_0_1_i_bcwt_1);
  assign vec_rsc_0_1_i_s_we_core_sct = vec_rsc_0_1_i_ogwt_1;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp (
  clk, rst, vec_rsc_0_0_i_oswt, vec_rsc_0_0_i_wen_comp, vec_rsc_0_0_i_oswt_1, vec_rsc_0_0_i_wen_comp_1,
      vec_rsc_0_0_i_s_raddr_core, vec_rsc_0_0_i_s_waddr_core, vec_rsc_0_0_i_s_din_mxwt,
      vec_rsc_0_0_i_s_dout_core, vec_rsc_0_0_i_biwt, vec_rsc_0_0_i_bdwt, vec_rsc_0_0_i_bcwt,
      vec_rsc_0_0_i_biwt_1, vec_rsc_0_0_i_bdwt_2, vec_rsc_0_0_i_bcwt_1, vec_rsc_0_0_i_s_raddr,
      vec_rsc_0_0_i_s_raddr_core_sct, vec_rsc_0_0_i_s_waddr, vec_rsc_0_0_i_s_waddr_core_sct,
      vec_rsc_0_0_i_s_din, vec_rsc_0_0_i_s_dout
);
  input clk;
  input rst;
  input vec_rsc_0_0_i_oswt;
  output vec_rsc_0_0_i_wen_comp;
  input vec_rsc_0_0_i_oswt_1;
  output vec_rsc_0_0_i_wen_comp_1;
  input [8:0] vec_rsc_0_0_i_s_raddr_core;
  input [8:0] vec_rsc_0_0_i_s_waddr_core;
  output [63:0] vec_rsc_0_0_i_s_din_mxwt;
  input [63:0] vec_rsc_0_0_i_s_dout_core;
  input vec_rsc_0_0_i_biwt;
  input vec_rsc_0_0_i_bdwt;
  output vec_rsc_0_0_i_bcwt;
  reg vec_rsc_0_0_i_bcwt;
  input vec_rsc_0_0_i_biwt_1;
  input vec_rsc_0_0_i_bdwt_2;
  output vec_rsc_0_0_i_bcwt_1;
  reg vec_rsc_0_0_i_bcwt_1;
  output [8:0] vec_rsc_0_0_i_s_raddr;
  input vec_rsc_0_0_i_s_raddr_core_sct;
  output [8:0] vec_rsc_0_0_i_s_waddr;
  input vec_rsc_0_0_i_s_waddr_core_sct;
  input [63:0] vec_rsc_0_0_i_s_din;
  output [63:0] vec_rsc_0_0_i_s_dout;


  // Interconnect Declarations
  reg [63:0] vec_rsc_0_0_i_s_din_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_0_i_wen_comp = (~ vec_rsc_0_0_i_oswt) | vec_rsc_0_0_i_biwt | vec_rsc_0_0_i_bcwt;
  assign vec_rsc_0_0_i_wen_comp_1 = (~ vec_rsc_0_0_i_oswt_1) | vec_rsc_0_0_i_biwt_1
      | vec_rsc_0_0_i_bcwt_1;
  assign vec_rsc_0_0_i_s_raddr = MUX_v_9_2_2(9'b000000000, vec_rsc_0_0_i_s_raddr_core,
      vec_rsc_0_0_i_s_raddr_core_sct);
  assign vec_rsc_0_0_i_s_waddr = MUX_v_9_2_2(9'b000000000, vec_rsc_0_0_i_s_waddr_core,
      vec_rsc_0_0_i_s_waddr_core_sct);
  assign vec_rsc_0_0_i_s_din_mxwt = MUX_v_64_2_2(vec_rsc_0_0_i_s_din, vec_rsc_0_0_i_s_din_bfwt,
      vec_rsc_0_0_i_bcwt);
  assign vec_rsc_0_0_i_s_dout = MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000000,
      vec_rsc_0_0_i_s_dout_core, vec_rsc_0_0_i_s_waddr_core_sct);
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_0_i_bcwt <= 1'b0;
      vec_rsc_0_0_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_0_i_bcwt <= ~((~(vec_rsc_0_0_i_bcwt | vec_rsc_0_0_i_biwt)) | vec_rsc_0_0_i_bdwt);
      vec_rsc_0_0_i_bcwt_1 <= ~((~(vec_rsc_0_0_i_bcwt_1 | vec_rsc_0_0_i_biwt_1))
          | vec_rsc_0_0_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_0_i_biwt ) begin
      vec_rsc_0_0_i_s_din_bfwt <= vec_rsc_0_0_i_s_din;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl (
  core_wen, vec_rsc_0_0_i_oswt, vec_rsc_0_0_i_oswt_1, vec_rsc_0_0_i_biwt, vec_rsc_0_0_i_bdwt,
      vec_rsc_0_0_i_bcwt, vec_rsc_0_0_i_s_re_core_sct, vec_rsc_0_0_i_biwt_1, vec_rsc_0_0_i_bdwt_2,
      vec_rsc_0_0_i_bcwt_1, vec_rsc_0_0_i_s_we_core_sct, vec_rsc_0_0_i_s_rrdy, vec_rsc_0_0_i_s_wrdy
);
  input core_wen;
  input vec_rsc_0_0_i_oswt;
  input vec_rsc_0_0_i_oswt_1;
  output vec_rsc_0_0_i_biwt;
  output vec_rsc_0_0_i_bdwt;
  input vec_rsc_0_0_i_bcwt;
  output vec_rsc_0_0_i_s_re_core_sct;
  output vec_rsc_0_0_i_biwt_1;
  output vec_rsc_0_0_i_bdwt_2;
  input vec_rsc_0_0_i_bcwt_1;
  output vec_rsc_0_0_i_s_we_core_sct;
  input vec_rsc_0_0_i_s_rrdy;
  input vec_rsc_0_0_i_s_wrdy;


  // Interconnect Declarations
  wire vec_rsc_0_0_i_ogwt;
  wire vec_rsc_0_0_i_ogwt_1;


  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_0_i_bdwt = vec_rsc_0_0_i_oswt & core_wen;
  assign vec_rsc_0_0_i_biwt = vec_rsc_0_0_i_ogwt & vec_rsc_0_0_i_s_rrdy;
  assign vec_rsc_0_0_i_ogwt = vec_rsc_0_0_i_oswt & (~ vec_rsc_0_0_i_bcwt);
  assign vec_rsc_0_0_i_s_re_core_sct = vec_rsc_0_0_i_ogwt;
  assign vec_rsc_0_0_i_bdwt_2 = vec_rsc_0_0_i_oswt_1 & core_wen;
  assign vec_rsc_0_0_i_biwt_1 = vec_rsc_0_0_i_ogwt_1 & vec_rsc_0_0_i_s_wrdy;
  assign vec_rsc_0_0_i_ogwt_1 = vec_rsc_0_0_i_oswt_1 & (~ vec_rsc_0_0_i_bcwt_1);
  assign vec_rsc_0_0_i_s_we_core_sct = vec_rsc_0_0_i_ogwt_1;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj (
  twiddle_rsc_triosy_0_0_lz, core_wten, twiddle_rsc_triosy_0_0_obj_iswt0
);
  output twiddle_rsc_triosy_0_0_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_0_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_0_obj (
      .ld(twiddle_rsc_triosy_0_0_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_0_lz)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
      inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_0_obj_iswt0(twiddle_rsc_triosy_0_0_obj_iswt0),
      .twiddle_rsc_triosy_0_0_obj_ld_core_sct(twiddle_rsc_triosy_0_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj (
  twiddle_rsc_triosy_0_1_lz, core_wten, twiddle_rsc_triosy_0_1_obj_iswt0
);
  output twiddle_rsc_triosy_0_1_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_1_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_1_obj (
      .ld(twiddle_rsc_triosy_0_1_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_1_lz)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
      inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_1_obj_iswt0(twiddle_rsc_triosy_0_1_obj_iswt0),
      .twiddle_rsc_triosy_0_1_obj_ld_core_sct(twiddle_rsc_triosy_0_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj (
  r_rsc_triosy_lz, core_wten, r_rsc_triosy_obj_iswt0
);
  output r_rsc_triosy_lz;
  input core_wten;
  input r_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire r_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(r_rsc_triosy_obj_ld_core_sct),
      .lz(r_rsc_triosy_lz)
    );
  inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .r_rsc_triosy_obj_iswt0(r_rsc_triosy_obj_iswt0),
      .r_rsc_triosy_obj_ld_core_sct(r_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj (
  p_rsc_triosy_lz, core_wten, p_rsc_triosy_obj_iswt0
);
  output p_rsc_triosy_lz;
  input core_wten;
  input p_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire p_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) p_rsc_triosy_obj (
      .ld(p_rsc_triosy_obj_ld_core_sct),
      .lz(p_rsc_triosy_lz)
    );
  inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .p_rsc_triosy_obj_iswt0(p_rsc_triosy_obj_iswt0),
      .p_rsc_triosy_obj_ld_core_sct(p_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj (
  vec_rsc_triosy_0_0_lz, core_wten, vec_rsc_triosy_0_0_obj_iswt0
);
  output vec_rsc_triosy_0_0_lz;
  input core_wten;
  input vec_rsc_triosy_0_0_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_0_obj (
      .ld(vec_rsc_triosy_0_0_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_0_lz)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
      inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_0_obj_iswt0(vec_rsc_triosy_0_0_obj_iswt0),
      .vec_rsc_triosy_0_0_obj_ld_core_sct(vec_rsc_triosy_0_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj (
  vec_rsc_triosy_0_1_lz, core_wten, vec_rsc_triosy_0_1_obj_iswt0
);
  output vec_rsc_triosy_0_1_lz;
  input core_wten;
  input vec_rsc_triosy_0_1_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_1_obj (
      .ld(vec_rsc_triosy_0_1_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_1_lz)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
      inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_1_obj_iswt0(vec_rsc_triosy_0_1_obj_iswt0),
      .vec_rsc_triosy_0_1_obj_ld_core_sct(vec_rsc_triosy_0_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i (
  clk, rst, twiddle_rsc_0_1_s_tdone, twiddle_rsc_0_1_tr_write_done, twiddle_rsc_0_1_RREADY,
      twiddle_rsc_0_1_RVALID, twiddle_rsc_0_1_RUSER, twiddle_rsc_0_1_RLAST, twiddle_rsc_0_1_RRESP,
      twiddle_rsc_0_1_RDATA, twiddle_rsc_0_1_RID, twiddle_rsc_0_1_ARREADY, twiddle_rsc_0_1_ARVALID,
      twiddle_rsc_0_1_ARUSER, twiddle_rsc_0_1_ARREGION, twiddle_rsc_0_1_ARQOS, twiddle_rsc_0_1_ARPROT,
      twiddle_rsc_0_1_ARCACHE, twiddle_rsc_0_1_ARLOCK, twiddle_rsc_0_1_ARBURST, twiddle_rsc_0_1_ARSIZE,
      twiddle_rsc_0_1_ARLEN, twiddle_rsc_0_1_ARADDR, twiddle_rsc_0_1_ARID, twiddle_rsc_0_1_BREADY,
      twiddle_rsc_0_1_BVALID, twiddle_rsc_0_1_BUSER, twiddle_rsc_0_1_BRESP, twiddle_rsc_0_1_BID,
      twiddle_rsc_0_1_WREADY, twiddle_rsc_0_1_WVALID, twiddle_rsc_0_1_WUSER, twiddle_rsc_0_1_WLAST,
      twiddle_rsc_0_1_WSTRB, twiddle_rsc_0_1_WDATA, twiddle_rsc_0_1_AWREADY, twiddle_rsc_0_1_AWVALID,
      twiddle_rsc_0_1_AWUSER, twiddle_rsc_0_1_AWREGION, twiddle_rsc_0_1_AWQOS, twiddle_rsc_0_1_AWPROT,
      twiddle_rsc_0_1_AWCACHE, twiddle_rsc_0_1_AWLOCK, twiddle_rsc_0_1_AWBURST, twiddle_rsc_0_1_AWSIZE,
      twiddle_rsc_0_1_AWLEN, twiddle_rsc_0_1_AWADDR, twiddle_rsc_0_1_AWID, core_wen,
      twiddle_rsc_0_1_i_oswt, twiddle_rsc_0_1_i_wen_comp, twiddle_rsc_0_1_i_s_raddr_core,
      twiddle_rsc_0_1_i_s_din_mxwt
);
  input clk;
  input rst;
  input twiddle_rsc_0_1_s_tdone;
  input twiddle_rsc_0_1_tr_write_done;
  input twiddle_rsc_0_1_RREADY;
  output twiddle_rsc_0_1_RVALID;
  output twiddle_rsc_0_1_RUSER;
  output twiddle_rsc_0_1_RLAST;
  output [1:0] twiddle_rsc_0_1_RRESP;
  output [63:0] twiddle_rsc_0_1_RDATA;
  output twiddle_rsc_0_1_RID;
  output twiddle_rsc_0_1_ARREADY;
  input twiddle_rsc_0_1_ARVALID;
  input twiddle_rsc_0_1_ARUSER;
  input [3:0] twiddle_rsc_0_1_ARREGION;
  input [3:0] twiddle_rsc_0_1_ARQOS;
  input [2:0] twiddle_rsc_0_1_ARPROT;
  input [3:0] twiddle_rsc_0_1_ARCACHE;
  input twiddle_rsc_0_1_ARLOCK;
  input [1:0] twiddle_rsc_0_1_ARBURST;
  input [2:0] twiddle_rsc_0_1_ARSIZE;
  input [7:0] twiddle_rsc_0_1_ARLEN;
  input [11:0] twiddle_rsc_0_1_ARADDR;
  input twiddle_rsc_0_1_ARID;
  input twiddle_rsc_0_1_BREADY;
  output twiddle_rsc_0_1_BVALID;
  output twiddle_rsc_0_1_BUSER;
  output [1:0] twiddle_rsc_0_1_BRESP;
  output twiddle_rsc_0_1_BID;
  output twiddle_rsc_0_1_WREADY;
  input twiddle_rsc_0_1_WVALID;
  input twiddle_rsc_0_1_WUSER;
  input twiddle_rsc_0_1_WLAST;
  input [7:0] twiddle_rsc_0_1_WSTRB;
  input [63:0] twiddle_rsc_0_1_WDATA;
  output twiddle_rsc_0_1_AWREADY;
  input twiddle_rsc_0_1_AWVALID;
  input twiddle_rsc_0_1_AWUSER;
  input [3:0] twiddle_rsc_0_1_AWREGION;
  input [3:0] twiddle_rsc_0_1_AWQOS;
  input [2:0] twiddle_rsc_0_1_AWPROT;
  input [3:0] twiddle_rsc_0_1_AWCACHE;
  input twiddle_rsc_0_1_AWLOCK;
  input [1:0] twiddle_rsc_0_1_AWBURST;
  input [2:0] twiddle_rsc_0_1_AWSIZE;
  input [7:0] twiddle_rsc_0_1_AWLEN;
  input [11:0] twiddle_rsc_0_1_AWADDR;
  input twiddle_rsc_0_1_AWID;
  input core_wen;
  input twiddle_rsc_0_1_i_oswt;
  output twiddle_rsc_0_1_i_wen_comp;
  input [8:0] twiddle_rsc_0_1_i_s_raddr_core;
  output [63:0] twiddle_rsc_0_1_i_s_din_mxwt;


  // Interconnect Declarations
  wire twiddle_rsc_0_1_i_biwt;
  wire twiddle_rsc_0_1_i_bdwt;
  wire twiddle_rsc_0_1_i_bcwt;
  wire twiddle_rsc_0_1_i_s_re_core_sct;
  wire [8:0] twiddle_rsc_0_1_i_s_raddr;
  wire [63:0] twiddle_rsc_0_1_i_s_din;
  wire twiddle_rsc_0_1_i_s_rrdy;
  wire twiddle_rsc_0_1_i_s_wrdy;
  wire twiddle_rsc_0_1_is_idle;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd512),
  .op_width(32'sd64),
  .cwidth(32'sd64),
  .addr_w(32'sd9),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd64),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) twiddle_rsc_0_1_i (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(twiddle_rsc_0_1_AWID),
      .AWADDR(twiddle_rsc_0_1_AWADDR),
      .AWLEN(twiddle_rsc_0_1_AWLEN),
      .AWSIZE(twiddle_rsc_0_1_AWSIZE),
      .AWBURST(twiddle_rsc_0_1_AWBURST),
      .AWLOCK(twiddle_rsc_0_1_AWLOCK),
      .AWCACHE(twiddle_rsc_0_1_AWCACHE),
      .AWPROT(twiddle_rsc_0_1_AWPROT),
      .AWQOS(twiddle_rsc_0_1_AWQOS),
      .AWREGION(twiddle_rsc_0_1_AWREGION),
      .AWUSER(twiddle_rsc_0_1_AWUSER),
      .AWVALID(twiddle_rsc_0_1_AWVALID),
      .AWREADY(twiddle_rsc_0_1_AWREADY),
      .WDATA(twiddle_rsc_0_1_WDATA),
      .WSTRB(twiddle_rsc_0_1_WSTRB),
      .WLAST(twiddle_rsc_0_1_WLAST),
      .WUSER(twiddle_rsc_0_1_WUSER),
      .WVALID(twiddle_rsc_0_1_WVALID),
      .WREADY(twiddle_rsc_0_1_WREADY),
      .BID(twiddle_rsc_0_1_BID),
      .BRESP(twiddle_rsc_0_1_BRESP),
      .BUSER(twiddle_rsc_0_1_BUSER),
      .BVALID(twiddle_rsc_0_1_BVALID),
      .BREADY(twiddle_rsc_0_1_BREADY),
      .ARID(twiddle_rsc_0_1_ARID),
      .ARADDR(twiddle_rsc_0_1_ARADDR),
      .ARLEN(twiddle_rsc_0_1_ARLEN),
      .ARSIZE(twiddle_rsc_0_1_ARSIZE),
      .ARBURST(twiddle_rsc_0_1_ARBURST),
      .ARLOCK(twiddle_rsc_0_1_ARLOCK),
      .ARCACHE(twiddle_rsc_0_1_ARCACHE),
      .ARPROT(twiddle_rsc_0_1_ARPROT),
      .ARQOS(twiddle_rsc_0_1_ARQOS),
      .ARREGION(twiddle_rsc_0_1_ARREGION),
      .ARUSER(twiddle_rsc_0_1_ARUSER),
      .ARVALID(twiddle_rsc_0_1_ARVALID),
      .ARREADY(twiddle_rsc_0_1_ARREADY),
      .RID(twiddle_rsc_0_1_RID),
      .RDATA(twiddle_rsc_0_1_RDATA),
      .RRESP(twiddle_rsc_0_1_RRESP),
      .RLAST(twiddle_rsc_0_1_RLAST),
      .RUSER(twiddle_rsc_0_1_RUSER),
      .RVALID(twiddle_rsc_0_1_RVALID),
      .RREADY(twiddle_rsc_0_1_RREADY),
      .s_re(twiddle_rsc_0_1_i_s_re_core_sct),
      .s_we(1'b0),
      .s_raddr(twiddle_rsc_0_1_i_s_raddr),
      .s_waddr(9'b000000000),
      .s_din(twiddle_rsc_0_1_i_s_din),
      .s_dout(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .s_rrdy(twiddle_rsc_0_1_i_s_rrdy),
      .s_wrdy(twiddle_rsc_0_1_i_s_wrdy),
      .is_idle(twiddle_rsc_0_1_is_idle),
      .tr_write_done(twiddle_rsc_0_1_tr_write_done),
      .s_tdone(twiddle_rsc_0_1_s_tdone)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .twiddle_rsc_0_1_i_oswt(twiddle_rsc_0_1_i_oswt),
      .twiddle_rsc_0_1_i_biwt(twiddle_rsc_0_1_i_biwt),
      .twiddle_rsc_0_1_i_bdwt(twiddle_rsc_0_1_i_bdwt),
      .twiddle_rsc_0_1_i_bcwt(twiddle_rsc_0_1_i_bcwt),
      .twiddle_rsc_0_1_i_s_re_core_sct(twiddle_rsc_0_1_i_s_re_core_sct),
      .twiddle_rsc_0_1_i_s_rrdy(twiddle_rsc_0_1_i_s_rrdy)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_1_i_oswt(twiddle_rsc_0_1_i_oswt),
      .twiddle_rsc_0_1_i_wen_comp(twiddle_rsc_0_1_i_wen_comp),
      .twiddle_rsc_0_1_i_s_raddr_core(twiddle_rsc_0_1_i_s_raddr_core),
      .twiddle_rsc_0_1_i_s_din_mxwt(twiddle_rsc_0_1_i_s_din_mxwt),
      .twiddle_rsc_0_1_i_biwt(twiddle_rsc_0_1_i_biwt),
      .twiddle_rsc_0_1_i_bdwt(twiddle_rsc_0_1_i_bdwt),
      .twiddle_rsc_0_1_i_bcwt(twiddle_rsc_0_1_i_bcwt),
      .twiddle_rsc_0_1_i_s_raddr(twiddle_rsc_0_1_i_s_raddr),
      .twiddle_rsc_0_1_i_s_raddr_core_sct(twiddle_rsc_0_1_i_s_re_core_sct),
      .twiddle_rsc_0_1_i_s_din(twiddle_rsc_0_1_i_s_din)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i (
  clk, rst, twiddle_rsc_0_0_s_tdone, twiddle_rsc_0_0_tr_write_done, twiddle_rsc_0_0_RREADY,
      twiddle_rsc_0_0_RVALID, twiddle_rsc_0_0_RUSER, twiddle_rsc_0_0_RLAST, twiddle_rsc_0_0_RRESP,
      twiddle_rsc_0_0_RDATA, twiddle_rsc_0_0_RID, twiddle_rsc_0_0_ARREADY, twiddle_rsc_0_0_ARVALID,
      twiddle_rsc_0_0_ARUSER, twiddle_rsc_0_0_ARREGION, twiddle_rsc_0_0_ARQOS, twiddle_rsc_0_0_ARPROT,
      twiddle_rsc_0_0_ARCACHE, twiddle_rsc_0_0_ARLOCK, twiddle_rsc_0_0_ARBURST, twiddle_rsc_0_0_ARSIZE,
      twiddle_rsc_0_0_ARLEN, twiddle_rsc_0_0_ARADDR, twiddle_rsc_0_0_ARID, twiddle_rsc_0_0_BREADY,
      twiddle_rsc_0_0_BVALID, twiddle_rsc_0_0_BUSER, twiddle_rsc_0_0_BRESP, twiddle_rsc_0_0_BID,
      twiddle_rsc_0_0_WREADY, twiddle_rsc_0_0_WVALID, twiddle_rsc_0_0_WUSER, twiddle_rsc_0_0_WLAST,
      twiddle_rsc_0_0_WSTRB, twiddle_rsc_0_0_WDATA, twiddle_rsc_0_0_AWREADY, twiddle_rsc_0_0_AWVALID,
      twiddle_rsc_0_0_AWUSER, twiddle_rsc_0_0_AWREGION, twiddle_rsc_0_0_AWQOS, twiddle_rsc_0_0_AWPROT,
      twiddle_rsc_0_0_AWCACHE, twiddle_rsc_0_0_AWLOCK, twiddle_rsc_0_0_AWBURST, twiddle_rsc_0_0_AWSIZE,
      twiddle_rsc_0_0_AWLEN, twiddle_rsc_0_0_AWADDR, twiddle_rsc_0_0_AWID, core_wen,
      twiddle_rsc_0_0_i_oswt, twiddle_rsc_0_0_i_wen_comp, twiddle_rsc_0_0_i_s_raddr_core,
      twiddle_rsc_0_0_i_s_din_mxwt
);
  input clk;
  input rst;
  input twiddle_rsc_0_0_s_tdone;
  input twiddle_rsc_0_0_tr_write_done;
  input twiddle_rsc_0_0_RREADY;
  output twiddle_rsc_0_0_RVALID;
  output twiddle_rsc_0_0_RUSER;
  output twiddle_rsc_0_0_RLAST;
  output [1:0] twiddle_rsc_0_0_RRESP;
  output [63:0] twiddle_rsc_0_0_RDATA;
  output twiddle_rsc_0_0_RID;
  output twiddle_rsc_0_0_ARREADY;
  input twiddle_rsc_0_0_ARVALID;
  input twiddle_rsc_0_0_ARUSER;
  input [3:0] twiddle_rsc_0_0_ARREGION;
  input [3:0] twiddle_rsc_0_0_ARQOS;
  input [2:0] twiddle_rsc_0_0_ARPROT;
  input [3:0] twiddle_rsc_0_0_ARCACHE;
  input twiddle_rsc_0_0_ARLOCK;
  input [1:0] twiddle_rsc_0_0_ARBURST;
  input [2:0] twiddle_rsc_0_0_ARSIZE;
  input [7:0] twiddle_rsc_0_0_ARLEN;
  input [11:0] twiddle_rsc_0_0_ARADDR;
  input twiddle_rsc_0_0_ARID;
  input twiddle_rsc_0_0_BREADY;
  output twiddle_rsc_0_0_BVALID;
  output twiddle_rsc_0_0_BUSER;
  output [1:0] twiddle_rsc_0_0_BRESP;
  output twiddle_rsc_0_0_BID;
  output twiddle_rsc_0_0_WREADY;
  input twiddle_rsc_0_0_WVALID;
  input twiddle_rsc_0_0_WUSER;
  input twiddle_rsc_0_0_WLAST;
  input [7:0] twiddle_rsc_0_0_WSTRB;
  input [63:0] twiddle_rsc_0_0_WDATA;
  output twiddle_rsc_0_0_AWREADY;
  input twiddle_rsc_0_0_AWVALID;
  input twiddle_rsc_0_0_AWUSER;
  input [3:0] twiddle_rsc_0_0_AWREGION;
  input [3:0] twiddle_rsc_0_0_AWQOS;
  input [2:0] twiddle_rsc_0_0_AWPROT;
  input [3:0] twiddle_rsc_0_0_AWCACHE;
  input twiddle_rsc_0_0_AWLOCK;
  input [1:0] twiddle_rsc_0_0_AWBURST;
  input [2:0] twiddle_rsc_0_0_AWSIZE;
  input [7:0] twiddle_rsc_0_0_AWLEN;
  input [11:0] twiddle_rsc_0_0_AWADDR;
  input twiddle_rsc_0_0_AWID;
  input core_wen;
  input twiddle_rsc_0_0_i_oswt;
  output twiddle_rsc_0_0_i_wen_comp;
  input [8:0] twiddle_rsc_0_0_i_s_raddr_core;
  output [63:0] twiddle_rsc_0_0_i_s_din_mxwt;


  // Interconnect Declarations
  wire twiddle_rsc_0_0_i_biwt;
  wire twiddle_rsc_0_0_i_bdwt;
  wire twiddle_rsc_0_0_i_bcwt;
  wire twiddle_rsc_0_0_i_s_re_core_sct;
  wire [8:0] twiddle_rsc_0_0_i_s_raddr;
  wire [63:0] twiddle_rsc_0_0_i_s_din;
  wire twiddle_rsc_0_0_i_s_rrdy;
  wire twiddle_rsc_0_0_i_s_wrdy;
  wire twiddle_rsc_0_0_is_idle;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd512),
  .op_width(32'sd64),
  .cwidth(32'sd64),
  .addr_w(32'sd9),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd64),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) twiddle_rsc_0_0_i (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(twiddle_rsc_0_0_AWID),
      .AWADDR(twiddle_rsc_0_0_AWADDR),
      .AWLEN(twiddle_rsc_0_0_AWLEN),
      .AWSIZE(twiddle_rsc_0_0_AWSIZE),
      .AWBURST(twiddle_rsc_0_0_AWBURST),
      .AWLOCK(twiddle_rsc_0_0_AWLOCK),
      .AWCACHE(twiddle_rsc_0_0_AWCACHE),
      .AWPROT(twiddle_rsc_0_0_AWPROT),
      .AWQOS(twiddle_rsc_0_0_AWQOS),
      .AWREGION(twiddle_rsc_0_0_AWREGION),
      .AWUSER(twiddle_rsc_0_0_AWUSER),
      .AWVALID(twiddle_rsc_0_0_AWVALID),
      .AWREADY(twiddle_rsc_0_0_AWREADY),
      .WDATA(twiddle_rsc_0_0_WDATA),
      .WSTRB(twiddle_rsc_0_0_WSTRB),
      .WLAST(twiddle_rsc_0_0_WLAST),
      .WUSER(twiddle_rsc_0_0_WUSER),
      .WVALID(twiddle_rsc_0_0_WVALID),
      .WREADY(twiddle_rsc_0_0_WREADY),
      .BID(twiddle_rsc_0_0_BID),
      .BRESP(twiddle_rsc_0_0_BRESP),
      .BUSER(twiddle_rsc_0_0_BUSER),
      .BVALID(twiddle_rsc_0_0_BVALID),
      .BREADY(twiddle_rsc_0_0_BREADY),
      .ARID(twiddle_rsc_0_0_ARID),
      .ARADDR(twiddle_rsc_0_0_ARADDR),
      .ARLEN(twiddle_rsc_0_0_ARLEN),
      .ARSIZE(twiddle_rsc_0_0_ARSIZE),
      .ARBURST(twiddle_rsc_0_0_ARBURST),
      .ARLOCK(twiddle_rsc_0_0_ARLOCK),
      .ARCACHE(twiddle_rsc_0_0_ARCACHE),
      .ARPROT(twiddle_rsc_0_0_ARPROT),
      .ARQOS(twiddle_rsc_0_0_ARQOS),
      .ARREGION(twiddle_rsc_0_0_ARREGION),
      .ARUSER(twiddle_rsc_0_0_ARUSER),
      .ARVALID(twiddle_rsc_0_0_ARVALID),
      .ARREADY(twiddle_rsc_0_0_ARREADY),
      .RID(twiddle_rsc_0_0_RID),
      .RDATA(twiddle_rsc_0_0_RDATA),
      .RRESP(twiddle_rsc_0_0_RRESP),
      .RLAST(twiddle_rsc_0_0_RLAST),
      .RUSER(twiddle_rsc_0_0_RUSER),
      .RVALID(twiddle_rsc_0_0_RVALID),
      .RREADY(twiddle_rsc_0_0_RREADY),
      .s_re(twiddle_rsc_0_0_i_s_re_core_sct),
      .s_we(1'b0),
      .s_raddr(twiddle_rsc_0_0_i_s_raddr),
      .s_waddr(9'b000000000),
      .s_din(twiddle_rsc_0_0_i_s_din),
      .s_dout(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .s_rrdy(twiddle_rsc_0_0_i_s_rrdy),
      .s_wrdy(twiddle_rsc_0_0_i_s_wrdy),
      .is_idle(twiddle_rsc_0_0_is_idle),
      .tr_write_done(twiddle_rsc_0_0_tr_write_done),
      .s_tdone(twiddle_rsc_0_0_s_tdone)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .twiddle_rsc_0_0_i_oswt(twiddle_rsc_0_0_i_oswt),
      .twiddle_rsc_0_0_i_biwt(twiddle_rsc_0_0_i_biwt),
      .twiddle_rsc_0_0_i_bdwt(twiddle_rsc_0_0_i_bdwt),
      .twiddle_rsc_0_0_i_bcwt(twiddle_rsc_0_0_i_bcwt),
      .twiddle_rsc_0_0_i_s_re_core_sct(twiddle_rsc_0_0_i_s_re_core_sct),
      .twiddle_rsc_0_0_i_s_rrdy(twiddle_rsc_0_0_i_s_rrdy)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_0_i_oswt(twiddle_rsc_0_0_i_oswt),
      .twiddle_rsc_0_0_i_wen_comp(twiddle_rsc_0_0_i_wen_comp),
      .twiddle_rsc_0_0_i_s_raddr_core(twiddle_rsc_0_0_i_s_raddr_core),
      .twiddle_rsc_0_0_i_s_din_mxwt(twiddle_rsc_0_0_i_s_din_mxwt),
      .twiddle_rsc_0_0_i_biwt(twiddle_rsc_0_0_i_biwt),
      .twiddle_rsc_0_0_i_bdwt(twiddle_rsc_0_0_i_bdwt),
      .twiddle_rsc_0_0_i_bcwt(twiddle_rsc_0_0_i_bcwt),
      .twiddle_rsc_0_0_i_s_raddr(twiddle_rsc_0_0_i_s_raddr),
      .twiddle_rsc_0_0_i_s_raddr_core_sct(twiddle_rsc_0_0_i_s_re_core_sct),
      .twiddle_rsc_0_0_i_s_din(twiddle_rsc_0_0_i_s_din)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i (
  clk, rst, vec_rsc_0_1_s_tdone, vec_rsc_0_1_tr_write_done, vec_rsc_0_1_RREADY, vec_rsc_0_1_RVALID,
      vec_rsc_0_1_RUSER, vec_rsc_0_1_RLAST, vec_rsc_0_1_RRESP, vec_rsc_0_1_RDATA,
      vec_rsc_0_1_RID, vec_rsc_0_1_ARREADY, vec_rsc_0_1_ARVALID, vec_rsc_0_1_ARUSER,
      vec_rsc_0_1_ARREGION, vec_rsc_0_1_ARQOS, vec_rsc_0_1_ARPROT, vec_rsc_0_1_ARCACHE,
      vec_rsc_0_1_ARLOCK, vec_rsc_0_1_ARBURST, vec_rsc_0_1_ARSIZE, vec_rsc_0_1_ARLEN,
      vec_rsc_0_1_ARADDR, vec_rsc_0_1_ARID, vec_rsc_0_1_BREADY, vec_rsc_0_1_BVALID,
      vec_rsc_0_1_BUSER, vec_rsc_0_1_BRESP, vec_rsc_0_1_BID, vec_rsc_0_1_WREADY,
      vec_rsc_0_1_WVALID, vec_rsc_0_1_WUSER, vec_rsc_0_1_WLAST, vec_rsc_0_1_WSTRB,
      vec_rsc_0_1_WDATA, vec_rsc_0_1_AWREADY, vec_rsc_0_1_AWVALID, vec_rsc_0_1_AWUSER,
      vec_rsc_0_1_AWREGION, vec_rsc_0_1_AWQOS, vec_rsc_0_1_AWPROT, vec_rsc_0_1_AWCACHE,
      vec_rsc_0_1_AWLOCK, vec_rsc_0_1_AWBURST, vec_rsc_0_1_AWSIZE, vec_rsc_0_1_AWLEN,
      vec_rsc_0_1_AWADDR, vec_rsc_0_1_AWID, core_wen, vec_rsc_0_1_i_oswt, vec_rsc_0_1_i_wen_comp,
      vec_rsc_0_1_i_oswt_1, vec_rsc_0_1_i_wen_comp_1, vec_rsc_0_1_i_s_raddr_core,
      vec_rsc_0_1_i_s_waddr_core, vec_rsc_0_1_i_s_din_mxwt, vec_rsc_0_1_i_s_dout_core
);
  input clk;
  input rst;
  input vec_rsc_0_1_s_tdone;
  input vec_rsc_0_1_tr_write_done;
  input vec_rsc_0_1_RREADY;
  output vec_rsc_0_1_RVALID;
  output vec_rsc_0_1_RUSER;
  output vec_rsc_0_1_RLAST;
  output [1:0] vec_rsc_0_1_RRESP;
  output [63:0] vec_rsc_0_1_RDATA;
  output vec_rsc_0_1_RID;
  output vec_rsc_0_1_ARREADY;
  input vec_rsc_0_1_ARVALID;
  input vec_rsc_0_1_ARUSER;
  input [3:0] vec_rsc_0_1_ARREGION;
  input [3:0] vec_rsc_0_1_ARQOS;
  input [2:0] vec_rsc_0_1_ARPROT;
  input [3:0] vec_rsc_0_1_ARCACHE;
  input vec_rsc_0_1_ARLOCK;
  input [1:0] vec_rsc_0_1_ARBURST;
  input [2:0] vec_rsc_0_1_ARSIZE;
  input [7:0] vec_rsc_0_1_ARLEN;
  input [11:0] vec_rsc_0_1_ARADDR;
  input vec_rsc_0_1_ARID;
  input vec_rsc_0_1_BREADY;
  output vec_rsc_0_1_BVALID;
  output vec_rsc_0_1_BUSER;
  output [1:0] vec_rsc_0_1_BRESP;
  output vec_rsc_0_1_BID;
  output vec_rsc_0_1_WREADY;
  input vec_rsc_0_1_WVALID;
  input vec_rsc_0_1_WUSER;
  input vec_rsc_0_1_WLAST;
  input [7:0] vec_rsc_0_1_WSTRB;
  input [63:0] vec_rsc_0_1_WDATA;
  output vec_rsc_0_1_AWREADY;
  input vec_rsc_0_1_AWVALID;
  input vec_rsc_0_1_AWUSER;
  input [3:0] vec_rsc_0_1_AWREGION;
  input [3:0] vec_rsc_0_1_AWQOS;
  input [2:0] vec_rsc_0_1_AWPROT;
  input [3:0] vec_rsc_0_1_AWCACHE;
  input vec_rsc_0_1_AWLOCK;
  input [1:0] vec_rsc_0_1_AWBURST;
  input [2:0] vec_rsc_0_1_AWSIZE;
  input [7:0] vec_rsc_0_1_AWLEN;
  input [11:0] vec_rsc_0_1_AWADDR;
  input vec_rsc_0_1_AWID;
  input core_wen;
  input vec_rsc_0_1_i_oswt;
  output vec_rsc_0_1_i_wen_comp;
  input vec_rsc_0_1_i_oswt_1;
  output vec_rsc_0_1_i_wen_comp_1;
  input [8:0] vec_rsc_0_1_i_s_raddr_core;
  input [8:0] vec_rsc_0_1_i_s_waddr_core;
  output [63:0] vec_rsc_0_1_i_s_din_mxwt;
  input [63:0] vec_rsc_0_1_i_s_dout_core;


  // Interconnect Declarations
  wire vec_rsc_0_1_i_biwt;
  wire vec_rsc_0_1_i_bdwt;
  wire vec_rsc_0_1_i_bcwt;
  wire vec_rsc_0_1_i_s_re_core_sct;
  wire vec_rsc_0_1_i_biwt_1;
  wire vec_rsc_0_1_i_bdwt_2;
  wire vec_rsc_0_1_i_bcwt_1;
  wire vec_rsc_0_1_i_s_we_core_sct;
  wire [8:0] vec_rsc_0_1_i_s_raddr;
  wire [8:0] vec_rsc_0_1_i_s_waddr;
  wire [63:0] vec_rsc_0_1_i_s_din;
  wire [63:0] vec_rsc_0_1_i_s_dout;
  wire vec_rsc_0_1_i_s_rrdy;
  wire vec_rsc_0_1_i_s_wrdy;
  wire vec_rsc_0_1_is_idle_1;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd512),
  .op_width(32'sd64),
  .cwidth(32'sd64),
  .addr_w(32'sd9),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd64),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) vec_rsc_0_1_i (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(vec_rsc_0_1_AWID),
      .AWADDR(vec_rsc_0_1_AWADDR),
      .AWLEN(vec_rsc_0_1_AWLEN),
      .AWSIZE(vec_rsc_0_1_AWSIZE),
      .AWBURST(vec_rsc_0_1_AWBURST),
      .AWLOCK(vec_rsc_0_1_AWLOCK),
      .AWCACHE(vec_rsc_0_1_AWCACHE),
      .AWPROT(vec_rsc_0_1_AWPROT),
      .AWQOS(vec_rsc_0_1_AWQOS),
      .AWREGION(vec_rsc_0_1_AWREGION),
      .AWUSER(vec_rsc_0_1_AWUSER),
      .AWVALID(vec_rsc_0_1_AWVALID),
      .AWREADY(vec_rsc_0_1_AWREADY),
      .WDATA(vec_rsc_0_1_WDATA),
      .WSTRB(vec_rsc_0_1_WSTRB),
      .WLAST(vec_rsc_0_1_WLAST),
      .WUSER(vec_rsc_0_1_WUSER),
      .WVALID(vec_rsc_0_1_WVALID),
      .WREADY(vec_rsc_0_1_WREADY),
      .BID(vec_rsc_0_1_BID),
      .BRESP(vec_rsc_0_1_BRESP),
      .BUSER(vec_rsc_0_1_BUSER),
      .BVALID(vec_rsc_0_1_BVALID),
      .BREADY(vec_rsc_0_1_BREADY),
      .ARID(vec_rsc_0_1_ARID),
      .ARADDR(vec_rsc_0_1_ARADDR),
      .ARLEN(vec_rsc_0_1_ARLEN),
      .ARSIZE(vec_rsc_0_1_ARSIZE),
      .ARBURST(vec_rsc_0_1_ARBURST),
      .ARLOCK(vec_rsc_0_1_ARLOCK),
      .ARCACHE(vec_rsc_0_1_ARCACHE),
      .ARPROT(vec_rsc_0_1_ARPROT),
      .ARQOS(vec_rsc_0_1_ARQOS),
      .ARREGION(vec_rsc_0_1_ARREGION),
      .ARUSER(vec_rsc_0_1_ARUSER),
      .ARVALID(vec_rsc_0_1_ARVALID),
      .ARREADY(vec_rsc_0_1_ARREADY),
      .RID(vec_rsc_0_1_RID),
      .RDATA(vec_rsc_0_1_RDATA),
      .RRESP(vec_rsc_0_1_RRESP),
      .RLAST(vec_rsc_0_1_RLAST),
      .RUSER(vec_rsc_0_1_RUSER),
      .RVALID(vec_rsc_0_1_RVALID),
      .RREADY(vec_rsc_0_1_RREADY),
      .s_re(vec_rsc_0_1_i_s_re_core_sct),
      .s_we(vec_rsc_0_1_i_s_we_core_sct),
      .s_raddr(vec_rsc_0_1_i_s_raddr),
      .s_waddr(vec_rsc_0_1_i_s_waddr),
      .s_din(vec_rsc_0_1_i_s_din),
      .s_dout(vec_rsc_0_1_i_s_dout),
      .s_rrdy(vec_rsc_0_1_i_s_rrdy),
      .s_wrdy(vec_rsc_0_1_i_s_wrdy),
      .is_idle(vec_rsc_0_1_is_idle_1),
      .tr_write_done(vec_rsc_0_1_tr_write_done),
      .s_tdone(vec_rsc_0_1_s_tdone)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .vec_rsc_0_1_i_oswt(vec_rsc_0_1_i_oswt),
      .vec_rsc_0_1_i_oswt_1(vec_rsc_0_1_i_oswt_1),
      .vec_rsc_0_1_i_biwt(vec_rsc_0_1_i_biwt),
      .vec_rsc_0_1_i_bdwt(vec_rsc_0_1_i_bdwt),
      .vec_rsc_0_1_i_bcwt(vec_rsc_0_1_i_bcwt),
      .vec_rsc_0_1_i_s_re_core_sct(vec_rsc_0_1_i_s_re_core_sct),
      .vec_rsc_0_1_i_biwt_1(vec_rsc_0_1_i_biwt_1),
      .vec_rsc_0_1_i_bdwt_2(vec_rsc_0_1_i_bdwt_2),
      .vec_rsc_0_1_i_bcwt_1(vec_rsc_0_1_i_bcwt_1),
      .vec_rsc_0_1_i_s_we_core_sct(vec_rsc_0_1_i_s_we_core_sct),
      .vec_rsc_0_1_i_s_rrdy(vec_rsc_0_1_i_s_rrdy),
      .vec_rsc_0_1_i_s_wrdy(vec_rsc_0_1_i_s_wrdy)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_1_i_oswt(vec_rsc_0_1_i_oswt),
      .vec_rsc_0_1_i_wen_comp(vec_rsc_0_1_i_wen_comp),
      .vec_rsc_0_1_i_oswt_1(vec_rsc_0_1_i_oswt_1),
      .vec_rsc_0_1_i_wen_comp_1(vec_rsc_0_1_i_wen_comp_1),
      .vec_rsc_0_1_i_s_raddr_core(vec_rsc_0_1_i_s_raddr_core),
      .vec_rsc_0_1_i_s_waddr_core(vec_rsc_0_1_i_s_waddr_core),
      .vec_rsc_0_1_i_s_din_mxwt(vec_rsc_0_1_i_s_din_mxwt),
      .vec_rsc_0_1_i_s_dout_core(vec_rsc_0_1_i_s_dout_core),
      .vec_rsc_0_1_i_biwt(vec_rsc_0_1_i_biwt),
      .vec_rsc_0_1_i_bdwt(vec_rsc_0_1_i_bdwt),
      .vec_rsc_0_1_i_bcwt(vec_rsc_0_1_i_bcwt),
      .vec_rsc_0_1_i_biwt_1(vec_rsc_0_1_i_biwt_1),
      .vec_rsc_0_1_i_bdwt_2(vec_rsc_0_1_i_bdwt_2),
      .vec_rsc_0_1_i_bcwt_1(vec_rsc_0_1_i_bcwt_1),
      .vec_rsc_0_1_i_s_raddr(vec_rsc_0_1_i_s_raddr),
      .vec_rsc_0_1_i_s_raddr_core_sct(vec_rsc_0_1_i_s_re_core_sct),
      .vec_rsc_0_1_i_s_waddr(vec_rsc_0_1_i_s_waddr),
      .vec_rsc_0_1_i_s_waddr_core_sct(vec_rsc_0_1_i_s_we_core_sct),
      .vec_rsc_0_1_i_s_din(vec_rsc_0_1_i_s_din),
      .vec_rsc_0_1_i_s_dout(vec_rsc_0_1_i_s_dout)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i (
  clk, rst, vec_rsc_0_0_s_tdone, vec_rsc_0_0_tr_write_done, vec_rsc_0_0_RREADY, vec_rsc_0_0_RVALID,
      vec_rsc_0_0_RUSER, vec_rsc_0_0_RLAST, vec_rsc_0_0_RRESP, vec_rsc_0_0_RDATA,
      vec_rsc_0_0_RID, vec_rsc_0_0_ARREADY, vec_rsc_0_0_ARVALID, vec_rsc_0_0_ARUSER,
      vec_rsc_0_0_ARREGION, vec_rsc_0_0_ARQOS, vec_rsc_0_0_ARPROT, vec_rsc_0_0_ARCACHE,
      vec_rsc_0_0_ARLOCK, vec_rsc_0_0_ARBURST, vec_rsc_0_0_ARSIZE, vec_rsc_0_0_ARLEN,
      vec_rsc_0_0_ARADDR, vec_rsc_0_0_ARID, vec_rsc_0_0_BREADY, vec_rsc_0_0_BVALID,
      vec_rsc_0_0_BUSER, vec_rsc_0_0_BRESP, vec_rsc_0_0_BID, vec_rsc_0_0_WREADY,
      vec_rsc_0_0_WVALID, vec_rsc_0_0_WUSER, vec_rsc_0_0_WLAST, vec_rsc_0_0_WSTRB,
      vec_rsc_0_0_WDATA, vec_rsc_0_0_AWREADY, vec_rsc_0_0_AWVALID, vec_rsc_0_0_AWUSER,
      vec_rsc_0_0_AWREGION, vec_rsc_0_0_AWQOS, vec_rsc_0_0_AWPROT, vec_rsc_0_0_AWCACHE,
      vec_rsc_0_0_AWLOCK, vec_rsc_0_0_AWBURST, vec_rsc_0_0_AWSIZE, vec_rsc_0_0_AWLEN,
      vec_rsc_0_0_AWADDR, vec_rsc_0_0_AWID, core_wen, vec_rsc_0_0_i_oswt, vec_rsc_0_0_i_wen_comp,
      vec_rsc_0_0_i_oswt_1, vec_rsc_0_0_i_wen_comp_1, vec_rsc_0_0_i_s_raddr_core,
      vec_rsc_0_0_i_s_waddr_core, vec_rsc_0_0_i_s_din_mxwt, vec_rsc_0_0_i_s_dout_core
);
  input clk;
  input rst;
  input vec_rsc_0_0_s_tdone;
  input vec_rsc_0_0_tr_write_done;
  input vec_rsc_0_0_RREADY;
  output vec_rsc_0_0_RVALID;
  output vec_rsc_0_0_RUSER;
  output vec_rsc_0_0_RLAST;
  output [1:0] vec_rsc_0_0_RRESP;
  output [63:0] vec_rsc_0_0_RDATA;
  output vec_rsc_0_0_RID;
  output vec_rsc_0_0_ARREADY;
  input vec_rsc_0_0_ARVALID;
  input vec_rsc_0_0_ARUSER;
  input [3:0] vec_rsc_0_0_ARREGION;
  input [3:0] vec_rsc_0_0_ARQOS;
  input [2:0] vec_rsc_0_0_ARPROT;
  input [3:0] vec_rsc_0_0_ARCACHE;
  input vec_rsc_0_0_ARLOCK;
  input [1:0] vec_rsc_0_0_ARBURST;
  input [2:0] vec_rsc_0_0_ARSIZE;
  input [7:0] vec_rsc_0_0_ARLEN;
  input [11:0] vec_rsc_0_0_ARADDR;
  input vec_rsc_0_0_ARID;
  input vec_rsc_0_0_BREADY;
  output vec_rsc_0_0_BVALID;
  output vec_rsc_0_0_BUSER;
  output [1:0] vec_rsc_0_0_BRESP;
  output vec_rsc_0_0_BID;
  output vec_rsc_0_0_WREADY;
  input vec_rsc_0_0_WVALID;
  input vec_rsc_0_0_WUSER;
  input vec_rsc_0_0_WLAST;
  input [7:0] vec_rsc_0_0_WSTRB;
  input [63:0] vec_rsc_0_0_WDATA;
  output vec_rsc_0_0_AWREADY;
  input vec_rsc_0_0_AWVALID;
  input vec_rsc_0_0_AWUSER;
  input [3:0] vec_rsc_0_0_AWREGION;
  input [3:0] vec_rsc_0_0_AWQOS;
  input [2:0] vec_rsc_0_0_AWPROT;
  input [3:0] vec_rsc_0_0_AWCACHE;
  input vec_rsc_0_0_AWLOCK;
  input [1:0] vec_rsc_0_0_AWBURST;
  input [2:0] vec_rsc_0_0_AWSIZE;
  input [7:0] vec_rsc_0_0_AWLEN;
  input [11:0] vec_rsc_0_0_AWADDR;
  input vec_rsc_0_0_AWID;
  input core_wen;
  input vec_rsc_0_0_i_oswt;
  output vec_rsc_0_0_i_wen_comp;
  input vec_rsc_0_0_i_oswt_1;
  output vec_rsc_0_0_i_wen_comp_1;
  input [8:0] vec_rsc_0_0_i_s_raddr_core;
  input [8:0] vec_rsc_0_0_i_s_waddr_core;
  output [63:0] vec_rsc_0_0_i_s_din_mxwt;
  input [63:0] vec_rsc_0_0_i_s_dout_core;


  // Interconnect Declarations
  wire vec_rsc_0_0_i_biwt;
  wire vec_rsc_0_0_i_bdwt;
  wire vec_rsc_0_0_i_bcwt;
  wire vec_rsc_0_0_i_s_re_core_sct;
  wire vec_rsc_0_0_i_biwt_1;
  wire vec_rsc_0_0_i_bdwt_2;
  wire vec_rsc_0_0_i_bcwt_1;
  wire vec_rsc_0_0_i_s_we_core_sct;
  wire [8:0] vec_rsc_0_0_i_s_raddr;
  wire [8:0] vec_rsc_0_0_i_s_waddr;
  wire [63:0] vec_rsc_0_0_i_s_din;
  wire [63:0] vec_rsc_0_0_i_s_dout;
  wire vec_rsc_0_0_i_s_rrdy;
  wire vec_rsc_0_0_i_s_wrdy;
  wire vec_rsc_0_0_is_idle_1;


  // Interconnect Declarations for Component Instantiations 
  ccs_axi4_slave_mem #(.rscid(32'sd0),
  .depth(32'sd512),
  .op_width(32'sd64),
  .cwidth(32'sd64),
  .addr_w(32'sd9),
  .nopreload(32'sd0),
  .rst_ph(32'sd0),
  .ADDR_WIDTH(32'sd12),
  .DATA_WIDTH(32'sd64),
  .ID_WIDTH(32'sd1),
  .USER_WIDTH(32'sd1),
  .REGION_MAP_SIZE(32'sd1),
  .wBASE_ADDRESS(32'sd0),
  .rBASE_ADDRESS(32'sd0)) vec_rsc_0_0_i (
      .ACLK(clk),
      .ARESETn(1'b1),
      .AWID(vec_rsc_0_0_AWID),
      .AWADDR(vec_rsc_0_0_AWADDR),
      .AWLEN(vec_rsc_0_0_AWLEN),
      .AWSIZE(vec_rsc_0_0_AWSIZE),
      .AWBURST(vec_rsc_0_0_AWBURST),
      .AWLOCK(vec_rsc_0_0_AWLOCK),
      .AWCACHE(vec_rsc_0_0_AWCACHE),
      .AWPROT(vec_rsc_0_0_AWPROT),
      .AWQOS(vec_rsc_0_0_AWQOS),
      .AWREGION(vec_rsc_0_0_AWREGION),
      .AWUSER(vec_rsc_0_0_AWUSER),
      .AWVALID(vec_rsc_0_0_AWVALID),
      .AWREADY(vec_rsc_0_0_AWREADY),
      .WDATA(vec_rsc_0_0_WDATA),
      .WSTRB(vec_rsc_0_0_WSTRB),
      .WLAST(vec_rsc_0_0_WLAST),
      .WUSER(vec_rsc_0_0_WUSER),
      .WVALID(vec_rsc_0_0_WVALID),
      .WREADY(vec_rsc_0_0_WREADY),
      .BID(vec_rsc_0_0_BID),
      .BRESP(vec_rsc_0_0_BRESP),
      .BUSER(vec_rsc_0_0_BUSER),
      .BVALID(vec_rsc_0_0_BVALID),
      .BREADY(vec_rsc_0_0_BREADY),
      .ARID(vec_rsc_0_0_ARID),
      .ARADDR(vec_rsc_0_0_ARADDR),
      .ARLEN(vec_rsc_0_0_ARLEN),
      .ARSIZE(vec_rsc_0_0_ARSIZE),
      .ARBURST(vec_rsc_0_0_ARBURST),
      .ARLOCK(vec_rsc_0_0_ARLOCK),
      .ARCACHE(vec_rsc_0_0_ARCACHE),
      .ARPROT(vec_rsc_0_0_ARPROT),
      .ARQOS(vec_rsc_0_0_ARQOS),
      .ARREGION(vec_rsc_0_0_ARREGION),
      .ARUSER(vec_rsc_0_0_ARUSER),
      .ARVALID(vec_rsc_0_0_ARVALID),
      .ARREADY(vec_rsc_0_0_ARREADY),
      .RID(vec_rsc_0_0_RID),
      .RDATA(vec_rsc_0_0_RDATA),
      .RRESP(vec_rsc_0_0_RRESP),
      .RLAST(vec_rsc_0_0_RLAST),
      .RUSER(vec_rsc_0_0_RUSER),
      .RVALID(vec_rsc_0_0_RVALID),
      .RREADY(vec_rsc_0_0_RREADY),
      .s_re(vec_rsc_0_0_i_s_re_core_sct),
      .s_we(vec_rsc_0_0_i_s_we_core_sct),
      .s_raddr(vec_rsc_0_0_i_s_raddr),
      .s_waddr(vec_rsc_0_0_i_s_waddr),
      .s_din(vec_rsc_0_0_i_s_din),
      .s_dout(vec_rsc_0_0_i_s_dout),
      .s_rrdy(vec_rsc_0_0_i_s_rrdy),
      .s_wrdy(vec_rsc_0_0_i_s_wrdy),
      .is_idle(vec_rsc_0_0_is_idle_1),
      .tr_write_done(vec_rsc_0_0_tr_write_done),
      .s_tdone(vec_rsc_0_0_s_tdone)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .vec_rsc_0_0_i_oswt(vec_rsc_0_0_i_oswt),
      .vec_rsc_0_0_i_oswt_1(vec_rsc_0_0_i_oswt_1),
      .vec_rsc_0_0_i_biwt(vec_rsc_0_0_i_biwt),
      .vec_rsc_0_0_i_bdwt(vec_rsc_0_0_i_bdwt),
      .vec_rsc_0_0_i_bcwt(vec_rsc_0_0_i_bcwt),
      .vec_rsc_0_0_i_s_re_core_sct(vec_rsc_0_0_i_s_re_core_sct),
      .vec_rsc_0_0_i_biwt_1(vec_rsc_0_0_i_biwt_1),
      .vec_rsc_0_0_i_bdwt_2(vec_rsc_0_0_i_bdwt_2),
      .vec_rsc_0_0_i_bcwt_1(vec_rsc_0_0_i_bcwt_1),
      .vec_rsc_0_0_i_s_we_core_sct(vec_rsc_0_0_i_s_we_core_sct),
      .vec_rsc_0_0_i_s_rrdy(vec_rsc_0_0_i_s_rrdy),
      .vec_rsc_0_0_i_s_wrdy(vec_rsc_0_0_i_s_wrdy)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_0_i_oswt(vec_rsc_0_0_i_oswt),
      .vec_rsc_0_0_i_wen_comp(vec_rsc_0_0_i_wen_comp),
      .vec_rsc_0_0_i_oswt_1(vec_rsc_0_0_i_oswt_1),
      .vec_rsc_0_0_i_wen_comp_1(vec_rsc_0_0_i_wen_comp_1),
      .vec_rsc_0_0_i_s_raddr_core(vec_rsc_0_0_i_s_raddr_core),
      .vec_rsc_0_0_i_s_waddr_core(vec_rsc_0_0_i_s_waddr_core),
      .vec_rsc_0_0_i_s_din_mxwt(vec_rsc_0_0_i_s_din_mxwt),
      .vec_rsc_0_0_i_s_dout_core(vec_rsc_0_0_i_s_dout_core),
      .vec_rsc_0_0_i_biwt(vec_rsc_0_0_i_biwt),
      .vec_rsc_0_0_i_bdwt(vec_rsc_0_0_i_bdwt),
      .vec_rsc_0_0_i_bcwt(vec_rsc_0_0_i_bcwt),
      .vec_rsc_0_0_i_biwt_1(vec_rsc_0_0_i_biwt_1),
      .vec_rsc_0_0_i_bdwt_2(vec_rsc_0_0_i_bdwt_2),
      .vec_rsc_0_0_i_bcwt_1(vec_rsc_0_0_i_bcwt_1),
      .vec_rsc_0_0_i_s_raddr(vec_rsc_0_0_i_s_raddr),
      .vec_rsc_0_0_i_s_raddr_core_sct(vec_rsc_0_0_i_s_re_core_sct),
      .vec_rsc_0_0_i_s_waddr(vec_rsc_0_0_i_s_waddr),
      .vec_rsc_0_0_i_s_waddr_core_sct(vec_rsc_0_0_i_s_we_core_sct),
      .vec_rsc_0_0_i_s_din(vec_rsc_0_0_i_s_din),
      .vec_rsc_0_0_i_s_dout(vec_rsc_0_0_i_s_dout)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core (
  clk, rst, vec_rsc_0_0_s_tdone, vec_rsc_0_0_tr_write_done, vec_rsc_0_0_RREADY, vec_rsc_0_0_RVALID,
      vec_rsc_0_0_RUSER, vec_rsc_0_0_RLAST, vec_rsc_0_0_RRESP, vec_rsc_0_0_RDATA,
      vec_rsc_0_0_RID, vec_rsc_0_0_ARREADY, vec_rsc_0_0_ARVALID, vec_rsc_0_0_ARUSER,
      vec_rsc_0_0_ARREGION, vec_rsc_0_0_ARQOS, vec_rsc_0_0_ARPROT, vec_rsc_0_0_ARCACHE,
      vec_rsc_0_0_ARLOCK, vec_rsc_0_0_ARBURST, vec_rsc_0_0_ARSIZE, vec_rsc_0_0_ARLEN,
      vec_rsc_0_0_ARADDR, vec_rsc_0_0_ARID, vec_rsc_0_0_BREADY, vec_rsc_0_0_BVALID,
      vec_rsc_0_0_BUSER, vec_rsc_0_0_BRESP, vec_rsc_0_0_BID, vec_rsc_0_0_WREADY,
      vec_rsc_0_0_WVALID, vec_rsc_0_0_WUSER, vec_rsc_0_0_WLAST, vec_rsc_0_0_WSTRB,
      vec_rsc_0_0_WDATA, vec_rsc_0_0_AWREADY, vec_rsc_0_0_AWVALID, vec_rsc_0_0_AWUSER,
      vec_rsc_0_0_AWREGION, vec_rsc_0_0_AWQOS, vec_rsc_0_0_AWPROT, vec_rsc_0_0_AWCACHE,
      vec_rsc_0_0_AWLOCK, vec_rsc_0_0_AWBURST, vec_rsc_0_0_AWSIZE, vec_rsc_0_0_AWLEN,
      vec_rsc_0_0_AWADDR, vec_rsc_0_0_AWID, vec_rsc_triosy_0_0_lz, vec_rsc_0_1_s_tdone,
      vec_rsc_0_1_tr_write_done, vec_rsc_0_1_RREADY, vec_rsc_0_1_RVALID, vec_rsc_0_1_RUSER,
      vec_rsc_0_1_RLAST, vec_rsc_0_1_RRESP, vec_rsc_0_1_RDATA, vec_rsc_0_1_RID, vec_rsc_0_1_ARREADY,
      vec_rsc_0_1_ARVALID, vec_rsc_0_1_ARUSER, vec_rsc_0_1_ARREGION, vec_rsc_0_1_ARQOS,
      vec_rsc_0_1_ARPROT, vec_rsc_0_1_ARCACHE, vec_rsc_0_1_ARLOCK, vec_rsc_0_1_ARBURST,
      vec_rsc_0_1_ARSIZE, vec_rsc_0_1_ARLEN, vec_rsc_0_1_ARADDR, vec_rsc_0_1_ARID,
      vec_rsc_0_1_BREADY, vec_rsc_0_1_BVALID, vec_rsc_0_1_BUSER, vec_rsc_0_1_BRESP,
      vec_rsc_0_1_BID, vec_rsc_0_1_WREADY, vec_rsc_0_1_WVALID, vec_rsc_0_1_WUSER,
      vec_rsc_0_1_WLAST, vec_rsc_0_1_WSTRB, vec_rsc_0_1_WDATA, vec_rsc_0_1_AWREADY,
      vec_rsc_0_1_AWVALID, vec_rsc_0_1_AWUSER, vec_rsc_0_1_AWREGION, vec_rsc_0_1_AWQOS,
      vec_rsc_0_1_AWPROT, vec_rsc_0_1_AWCACHE, vec_rsc_0_1_AWLOCK, vec_rsc_0_1_AWBURST,
      vec_rsc_0_1_AWSIZE, vec_rsc_0_1_AWLEN, vec_rsc_0_1_AWADDR, vec_rsc_0_1_AWID,
      vec_rsc_triosy_0_1_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_triosy_lz, twiddle_rsc_0_0_s_tdone,
      twiddle_rsc_0_0_tr_write_done, twiddle_rsc_0_0_RREADY, twiddle_rsc_0_0_RVALID,
      twiddle_rsc_0_0_RUSER, twiddle_rsc_0_0_RLAST, twiddle_rsc_0_0_RRESP, twiddle_rsc_0_0_RDATA,
      twiddle_rsc_0_0_RID, twiddle_rsc_0_0_ARREADY, twiddle_rsc_0_0_ARVALID, twiddle_rsc_0_0_ARUSER,
      twiddle_rsc_0_0_ARREGION, twiddle_rsc_0_0_ARQOS, twiddle_rsc_0_0_ARPROT, twiddle_rsc_0_0_ARCACHE,
      twiddle_rsc_0_0_ARLOCK, twiddle_rsc_0_0_ARBURST, twiddle_rsc_0_0_ARSIZE, twiddle_rsc_0_0_ARLEN,
      twiddle_rsc_0_0_ARADDR, twiddle_rsc_0_0_ARID, twiddle_rsc_0_0_BREADY, twiddle_rsc_0_0_BVALID,
      twiddle_rsc_0_0_BUSER, twiddle_rsc_0_0_BRESP, twiddle_rsc_0_0_BID, twiddle_rsc_0_0_WREADY,
      twiddle_rsc_0_0_WVALID, twiddle_rsc_0_0_WUSER, twiddle_rsc_0_0_WLAST, twiddle_rsc_0_0_WSTRB,
      twiddle_rsc_0_0_WDATA, twiddle_rsc_0_0_AWREADY, twiddle_rsc_0_0_AWVALID, twiddle_rsc_0_0_AWUSER,
      twiddle_rsc_0_0_AWREGION, twiddle_rsc_0_0_AWQOS, twiddle_rsc_0_0_AWPROT, twiddle_rsc_0_0_AWCACHE,
      twiddle_rsc_0_0_AWLOCK, twiddle_rsc_0_0_AWBURST, twiddle_rsc_0_0_AWSIZE, twiddle_rsc_0_0_AWLEN,
      twiddle_rsc_0_0_AWADDR, twiddle_rsc_0_0_AWID, twiddle_rsc_triosy_0_0_lz, twiddle_rsc_0_1_s_tdone,
      twiddle_rsc_0_1_tr_write_done, twiddle_rsc_0_1_RREADY, twiddle_rsc_0_1_RVALID,
      twiddle_rsc_0_1_RUSER, twiddle_rsc_0_1_RLAST, twiddle_rsc_0_1_RRESP, twiddle_rsc_0_1_RDATA,
      twiddle_rsc_0_1_RID, twiddle_rsc_0_1_ARREADY, twiddle_rsc_0_1_ARVALID, twiddle_rsc_0_1_ARUSER,
      twiddle_rsc_0_1_ARREGION, twiddle_rsc_0_1_ARQOS, twiddle_rsc_0_1_ARPROT, twiddle_rsc_0_1_ARCACHE,
      twiddle_rsc_0_1_ARLOCK, twiddle_rsc_0_1_ARBURST, twiddle_rsc_0_1_ARSIZE, twiddle_rsc_0_1_ARLEN,
      twiddle_rsc_0_1_ARADDR, twiddle_rsc_0_1_ARID, twiddle_rsc_0_1_BREADY, twiddle_rsc_0_1_BVALID,
      twiddle_rsc_0_1_BUSER, twiddle_rsc_0_1_BRESP, twiddle_rsc_0_1_BID, twiddle_rsc_0_1_WREADY,
      twiddle_rsc_0_1_WVALID, twiddle_rsc_0_1_WUSER, twiddle_rsc_0_1_WLAST, twiddle_rsc_0_1_WSTRB,
      twiddle_rsc_0_1_WDATA, twiddle_rsc_0_1_AWREADY, twiddle_rsc_0_1_AWVALID, twiddle_rsc_0_1_AWUSER,
      twiddle_rsc_0_1_AWREGION, twiddle_rsc_0_1_AWQOS, twiddle_rsc_0_1_AWPROT, twiddle_rsc_0_1_AWCACHE,
      twiddle_rsc_0_1_AWLOCK, twiddle_rsc_0_1_AWBURST, twiddle_rsc_0_1_AWSIZE, twiddle_rsc_0_1_AWLEN,
      twiddle_rsc_0_1_AWADDR, twiddle_rsc_0_1_AWID, twiddle_rsc_triosy_0_1_lz
);
  input clk;
  input rst;
  input vec_rsc_0_0_s_tdone;
  input vec_rsc_0_0_tr_write_done;
  input vec_rsc_0_0_RREADY;
  output vec_rsc_0_0_RVALID;
  output vec_rsc_0_0_RUSER;
  output vec_rsc_0_0_RLAST;
  output [1:0] vec_rsc_0_0_RRESP;
  output [63:0] vec_rsc_0_0_RDATA;
  output vec_rsc_0_0_RID;
  output vec_rsc_0_0_ARREADY;
  input vec_rsc_0_0_ARVALID;
  input vec_rsc_0_0_ARUSER;
  input [3:0] vec_rsc_0_0_ARREGION;
  input [3:0] vec_rsc_0_0_ARQOS;
  input [2:0] vec_rsc_0_0_ARPROT;
  input [3:0] vec_rsc_0_0_ARCACHE;
  input vec_rsc_0_0_ARLOCK;
  input [1:0] vec_rsc_0_0_ARBURST;
  input [2:0] vec_rsc_0_0_ARSIZE;
  input [7:0] vec_rsc_0_0_ARLEN;
  input [11:0] vec_rsc_0_0_ARADDR;
  input vec_rsc_0_0_ARID;
  input vec_rsc_0_0_BREADY;
  output vec_rsc_0_0_BVALID;
  output vec_rsc_0_0_BUSER;
  output [1:0] vec_rsc_0_0_BRESP;
  output vec_rsc_0_0_BID;
  output vec_rsc_0_0_WREADY;
  input vec_rsc_0_0_WVALID;
  input vec_rsc_0_0_WUSER;
  input vec_rsc_0_0_WLAST;
  input [7:0] vec_rsc_0_0_WSTRB;
  input [63:0] vec_rsc_0_0_WDATA;
  output vec_rsc_0_0_AWREADY;
  input vec_rsc_0_0_AWVALID;
  input vec_rsc_0_0_AWUSER;
  input [3:0] vec_rsc_0_0_AWREGION;
  input [3:0] vec_rsc_0_0_AWQOS;
  input [2:0] vec_rsc_0_0_AWPROT;
  input [3:0] vec_rsc_0_0_AWCACHE;
  input vec_rsc_0_0_AWLOCK;
  input [1:0] vec_rsc_0_0_AWBURST;
  input [2:0] vec_rsc_0_0_AWSIZE;
  input [7:0] vec_rsc_0_0_AWLEN;
  input [11:0] vec_rsc_0_0_AWADDR;
  input vec_rsc_0_0_AWID;
  output vec_rsc_triosy_0_0_lz;
  input vec_rsc_0_1_s_tdone;
  input vec_rsc_0_1_tr_write_done;
  input vec_rsc_0_1_RREADY;
  output vec_rsc_0_1_RVALID;
  output vec_rsc_0_1_RUSER;
  output vec_rsc_0_1_RLAST;
  output [1:0] vec_rsc_0_1_RRESP;
  output [63:0] vec_rsc_0_1_RDATA;
  output vec_rsc_0_1_RID;
  output vec_rsc_0_1_ARREADY;
  input vec_rsc_0_1_ARVALID;
  input vec_rsc_0_1_ARUSER;
  input [3:0] vec_rsc_0_1_ARREGION;
  input [3:0] vec_rsc_0_1_ARQOS;
  input [2:0] vec_rsc_0_1_ARPROT;
  input [3:0] vec_rsc_0_1_ARCACHE;
  input vec_rsc_0_1_ARLOCK;
  input [1:0] vec_rsc_0_1_ARBURST;
  input [2:0] vec_rsc_0_1_ARSIZE;
  input [7:0] vec_rsc_0_1_ARLEN;
  input [11:0] vec_rsc_0_1_ARADDR;
  input vec_rsc_0_1_ARID;
  input vec_rsc_0_1_BREADY;
  output vec_rsc_0_1_BVALID;
  output vec_rsc_0_1_BUSER;
  output [1:0] vec_rsc_0_1_BRESP;
  output vec_rsc_0_1_BID;
  output vec_rsc_0_1_WREADY;
  input vec_rsc_0_1_WVALID;
  input vec_rsc_0_1_WUSER;
  input vec_rsc_0_1_WLAST;
  input [7:0] vec_rsc_0_1_WSTRB;
  input [63:0] vec_rsc_0_1_WDATA;
  output vec_rsc_0_1_AWREADY;
  input vec_rsc_0_1_AWVALID;
  input vec_rsc_0_1_AWUSER;
  input [3:0] vec_rsc_0_1_AWREGION;
  input [3:0] vec_rsc_0_1_AWQOS;
  input [2:0] vec_rsc_0_1_AWPROT;
  input [3:0] vec_rsc_0_1_AWCACHE;
  input vec_rsc_0_1_AWLOCK;
  input [1:0] vec_rsc_0_1_AWBURST;
  input [2:0] vec_rsc_0_1_AWSIZE;
  input [7:0] vec_rsc_0_1_AWLEN;
  input [11:0] vec_rsc_0_1_AWADDR;
  input vec_rsc_0_1_AWID;
  output vec_rsc_triosy_0_1_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  input twiddle_rsc_0_0_s_tdone;
  input twiddle_rsc_0_0_tr_write_done;
  input twiddle_rsc_0_0_RREADY;
  output twiddle_rsc_0_0_RVALID;
  output twiddle_rsc_0_0_RUSER;
  output twiddle_rsc_0_0_RLAST;
  output [1:0] twiddle_rsc_0_0_RRESP;
  output [63:0] twiddle_rsc_0_0_RDATA;
  output twiddle_rsc_0_0_RID;
  output twiddle_rsc_0_0_ARREADY;
  input twiddle_rsc_0_0_ARVALID;
  input twiddle_rsc_0_0_ARUSER;
  input [3:0] twiddle_rsc_0_0_ARREGION;
  input [3:0] twiddle_rsc_0_0_ARQOS;
  input [2:0] twiddle_rsc_0_0_ARPROT;
  input [3:0] twiddle_rsc_0_0_ARCACHE;
  input twiddle_rsc_0_0_ARLOCK;
  input [1:0] twiddle_rsc_0_0_ARBURST;
  input [2:0] twiddle_rsc_0_0_ARSIZE;
  input [7:0] twiddle_rsc_0_0_ARLEN;
  input [11:0] twiddle_rsc_0_0_ARADDR;
  input twiddle_rsc_0_0_ARID;
  input twiddle_rsc_0_0_BREADY;
  output twiddle_rsc_0_0_BVALID;
  output twiddle_rsc_0_0_BUSER;
  output [1:0] twiddle_rsc_0_0_BRESP;
  output twiddle_rsc_0_0_BID;
  output twiddle_rsc_0_0_WREADY;
  input twiddle_rsc_0_0_WVALID;
  input twiddle_rsc_0_0_WUSER;
  input twiddle_rsc_0_0_WLAST;
  input [7:0] twiddle_rsc_0_0_WSTRB;
  input [63:0] twiddle_rsc_0_0_WDATA;
  output twiddle_rsc_0_0_AWREADY;
  input twiddle_rsc_0_0_AWVALID;
  input twiddle_rsc_0_0_AWUSER;
  input [3:0] twiddle_rsc_0_0_AWREGION;
  input [3:0] twiddle_rsc_0_0_AWQOS;
  input [2:0] twiddle_rsc_0_0_AWPROT;
  input [3:0] twiddle_rsc_0_0_AWCACHE;
  input twiddle_rsc_0_0_AWLOCK;
  input [1:0] twiddle_rsc_0_0_AWBURST;
  input [2:0] twiddle_rsc_0_0_AWSIZE;
  input [7:0] twiddle_rsc_0_0_AWLEN;
  input [11:0] twiddle_rsc_0_0_AWADDR;
  input twiddle_rsc_0_0_AWID;
  output twiddle_rsc_triosy_0_0_lz;
  input twiddle_rsc_0_1_s_tdone;
  input twiddle_rsc_0_1_tr_write_done;
  input twiddle_rsc_0_1_RREADY;
  output twiddle_rsc_0_1_RVALID;
  output twiddle_rsc_0_1_RUSER;
  output twiddle_rsc_0_1_RLAST;
  output [1:0] twiddle_rsc_0_1_RRESP;
  output [63:0] twiddle_rsc_0_1_RDATA;
  output twiddle_rsc_0_1_RID;
  output twiddle_rsc_0_1_ARREADY;
  input twiddle_rsc_0_1_ARVALID;
  input twiddle_rsc_0_1_ARUSER;
  input [3:0] twiddle_rsc_0_1_ARREGION;
  input [3:0] twiddle_rsc_0_1_ARQOS;
  input [2:0] twiddle_rsc_0_1_ARPROT;
  input [3:0] twiddle_rsc_0_1_ARCACHE;
  input twiddle_rsc_0_1_ARLOCK;
  input [1:0] twiddle_rsc_0_1_ARBURST;
  input [2:0] twiddle_rsc_0_1_ARSIZE;
  input [7:0] twiddle_rsc_0_1_ARLEN;
  input [11:0] twiddle_rsc_0_1_ARADDR;
  input twiddle_rsc_0_1_ARID;
  input twiddle_rsc_0_1_BREADY;
  output twiddle_rsc_0_1_BVALID;
  output twiddle_rsc_0_1_BUSER;
  output [1:0] twiddle_rsc_0_1_BRESP;
  output twiddle_rsc_0_1_BID;
  output twiddle_rsc_0_1_WREADY;
  input twiddle_rsc_0_1_WVALID;
  input twiddle_rsc_0_1_WUSER;
  input twiddle_rsc_0_1_WLAST;
  input [7:0] twiddle_rsc_0_1_WSTRB;
  input [63:0] twiddle_rsc_0_1_WDATA;
  output twiddle_rsc_0_1_AWREADY;
  input twiddle_rsc_0_1_AWVALID;
  input twiddle_rsc_0_1_AWUSER;
  input [3:0] twiddle_rsc_0_1_AWREGION;
  input [3:0] twiddle_rsc_0_1_AWQOS;
  input [2:0] twiddle_rsc_0_1_AWPROT;
  input [3:0] twiddle_rsc_0_1_AWCACHE;
  input twiddle_rsc_0_1_AWLOCK;
  input [1:0] twiddle_rsc_0_1_AWBURST;
  input [2:0] twiddle_rsc_0_1_AWSIZE;
  input [7:0] twiddle_rsc_0_1_AWLEN;
  input [11:0] twiddle_rsc_0_1_AWADDR;
  input twiddle_rsc_0_1_AWID;
  output twiddle_rsc_triosy_0_1_lz;


  // Interconnect Declarations
  wire core_wen;
  wire [63:0] p_rsci_idat;
  wire core_wten;
  wire vec_rsc_0_0_i_wen_comp;
  wire vec_rsc_0_0_i_wen_comp_1;
  wire [63:0] vec_rsc_0_0_i_s_din_mxwt;
  wire vec_rsc_0_1_i_wen_comp;
  wire vec_rsc_0_1_i_wen_comp_1;
  wire [63:0] vec_rsc_0_1_i_s_din_mxwt;
  wire twiddle_rsc_0_0_i_wen_comp;
  reg [8:0] twiddle_rsc_0_0_i_s_raddr_core;
  wire [63:0] twiddle_rsc_0_0_i_s_din_mxwt;
  wire twiddle_rsc_0_1_i_wen_comp;
  reg [8:0] twiddle_rsc_0_1_i_s_raddr_core;
  wire [63:0] twiddle_rsc_0_1_i_s_din_mxwt;
  wire [64:0] COMP_LOOP_1_modulo_result_rem_cmp_z;
  reg [63:0] COMP_LOOP_1_modulo_result_rem_cmp_a_63_0;
  reg [63:0] COMP_LOOP_1_modulo_result_rem_cmp_b_63_0;
  wire [6:0] fsm_output;
  wire [9:0] COMP_LOOP_1_acc_10_tmp;
  wire [11:0] nl_COMP_LOOP_1_acc_10_tmp;
  wire or_tmp;
  wire nor_tmp_3;
  wire and_dcpl_6;
  wire and_dcpl_7;
  wire and_dcpl_8;
  wire and_dcpl_9;
  wire and_dcpl_10;
  wire and_dcpl_12;
  wire and_dcpl_14;
  wire and_dcpl_15;
  wire and_dcpl_18;
  wire not_tmp_34;
  wire and_dcpl_21;
  wire and_dcpl_22;
  wire and_dcpl_23;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_31;
  wire and_dcpl_35;
  wire and_dcpl_38;
  wire and_dcpl_40;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire or_dcpl_4;
  wire mux_tmp_53;
  wire and_dcpl_67;
  wire or_tmp_59;
  wire mux_tmp_57;
  wire or_tmp_60;
  wire mux_tmp_68;
  wire mux_tmp_69;
  wire or_dcpl_8;
  wire or_dcpl_10;
  wire not_tmp_58;
  wire mux_tmp_77;
  wire or_dcpl_12;
  wire and_dcpl_80;
  reg COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  reg COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm;
  reg [9:0] VEC_LOOP_j_sva_9_0;
  reg [9:0] COMP_LOOP_2_acc_10_idiv_sva;
  wire [11:0] nl_COMP_LOOP_2_acc_10_idiv_sva;
  reg [9:0] COMP_LOOP_acc_1_cse_sva;
  wire [10:0] nl_COMP_LOOP_acc_1_cse_sva;
  reg [9:0] COMP_LOOP_1_slc_31_1_idiv_sva;
  reg [9:0] COMP_LOOP_2_slc_31_1_idiv_sva;
  reg [9:0] COMP_LOOP_2_tmp_lshift_itm;
  reg [9:0] STAGE_LOOP_lshift_psp_sva;
  reg [7:0] COMP_LOOP_k_9_1_sva_7_0;
  reg [7:0] reg_COMP_LOOP_k_9_1_ftd;
  reg reg_vec_rsc_0_0_i_oswt_cse;
  reg reg_vec_rsc_0_0_i_oswt_1_cse;
  reg reg_vec_rsc_0_1_i_oswt_cse;
  reg reg_vec_rsc_0_1_i_oswt_1_cse;
  reg [8:0] reg_vec_rsc_0_0_i_s_raddr_core_cse;
  reg [8:0] reg_vec_rsc_0_0_i_s_waddr_core_cse;
  reg [63:0] reg_vec_rsc_0_0_i_s_dout_core_cse;
  reg reg_twiddle_rsc_0_0_i_oswt_cse;
  reg reg_twiddle_rsc_0_1_i_oswt_cse;
  reg reg_vec_rsc_triosy_0_1_obj_iswt0_cse;
  wire and_98_cse;
  wire COMP_LOOP_and_cse;
  wire COMP_LOOP_and_5_cse;
  wire COMP_LOOP_and_7_cse;
  wire [9:0] z_out;
  wire and_dcpl_111;
  wire [3:0] z_out_1;
  wire [4:0] nl_z_out_1;
  wire and_dcpl_122;
  wire [8:0] z_out_2;
  wire [9:0] nl_z_out_2;
  wire and_dcpl_133;
  wire [10:0] z_out_3;
  wire [11:0] nl_z_out_3;
  wire and_dcpl_135;
  wire and_dcpl_138;
  wire and_dcpl_139;
  wire and_dcpl_142;
  wire and_dcpl_146;
  wire and_dcpl_151;
  wire [63:0] z_out_4;
  wire [127:0] nl_z_out_4;
  reg [63:0] p_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [8:0] COMP_LOOP_acc_psp_sva;
  reg [3:0] COMP_LOOP_1_tmp_acc_cse_sva;
  reg [63:0] tmp_2_lpi_4_dfm;
  reg [63:0] COMP_LOOP_1_acc_8_itm;
  reg [63:0] COMP_LOOP_2_acc_8_itm;
  reg [63:0] COMP_LOOP_1_acc_5_psp;
  reg [63:0] COMP_LOOP_2_acc_5_psp;
  reg [63:0] COMP_LOOP_1_mul_psp;
  reg [63:0] COMP_LOOP_2_mul_psp;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [63:0] vec_rsc_0_0_i_s_dout_core_1;
  wire [63:0] COMP_LOOP_2_acc_5_psp_mx0w2;
  wire [64:0] nl_COMP_LOOP_2_acc_5_psp_mx0w2;
  wire VEC_LOOP_j_sva_9_0_mx0c0;
  wire tmp_2_lpi_4_dfm_mx0c1;
  wire [63:0] COMP_LOOP_1_acc_8_itm_mx0w0;
  wire [64:0] nl_COMP_LOOP_1_acc_8_itm_mx0w0;
  wire or_118_cse;
  wire or_116_cse;

  wire[0:0] mux_34_nl;
  wire[0:0] nor_43_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] or_106_nl;
  wire[0:0] mux_38_nl;
  wire[0:0] mux_37_nl;
  wire[0:0] nor_39_nl;
  wire[0:0] nor_40_nl;
  wire[0:0] mux_36_nl;
  wire[0:0] nor_41_nl;
  wire[0:0] nor_42_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] nor_37_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] or_43_nl;
  wire[0:0] or_42_nl;
  wire[0:0] nor_38_nl;
  wire[0:0] mux_39_nl;
  wire[0:0] or_39_nl;
  wire[0:0] or_37_nl;
  wire[0:0] and_30_nl;
  wire[0:0] and_32_nl;
  wire[0:0] and_34_nl;
  wire[0:0] and_37_nl;
  wire[0:0] and_39_nl;
  wire[0:0] and_42_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] and_99_nl;
  wire[0:0] and_100_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] nor_35_nl;
  wire[0:0] nor_36_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] nor_33_nl;
  wire[0:0] mux_46_nl;
  wire[0:0] or_53_nl;
  wire[0:0] or_52_nl;
  wire[0:0] nor_34_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] or_49_nl;
  wire[0:0] or_48_nl;
  wire[0:0] mux_49_nl;
  wire[0:0] mux_48_nl;
  wire[0:0] or_114_nl;
  wire[0:0] COMP_LOOP_or_2_nl;
  wire[0:0] and_59_nl;
  wire[0:0] mux_51_nl;
  wire[0:0] mux_50_nl;
  wire[0:0] and_62_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] nor_31_nl;
  wire[0:0] nor_32_nl;
  wire[0:0] and_65_nl;
  wire[0:0] nor_55_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] or_64_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] or_61_nl;
  wire[0:0] and_69_nl;
  wire[0:0] mux_62_nl;
  wire[0:0] mux_61_nl;
  wire[0:0] mux_60_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] mux_63_nl;
  wire[0:0] nand_nl;
  wire[0:0] and_71_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] VEC_LOOP_j_not_1_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] or_72_nl;
  wire[0:0] or_115_nl;
  wire[0:0] mux_28_nl;
  wire[0:0] or_111_nl;
  wire[0:0] or_112_nl;
  wire[0:0] mux_94_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] nand_7_nl;
  wire[0:0] mux_nl;
  wire[0:0] nand_8_nl;
  wire[10:0] COMP_LOOP_1_acc_11_nl;
  wire[12:0] nl_COMP_LOOP_1_acc_11_nl;
  wire[9:0] COMP_LOOP_2_acc_nl;
  wire[10:0] nl_COMP_LOOP_2_acc_nl;
  wire[0:0] mux_75_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] or_109_nl;
  wire[10:0] COMP_LOOP_2_acc_11_nl;
  wire[12:0] nl_COMP_LOOP_2_acc_11_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] or_9_nl;
  wire[9:0] COMP_LOOP_1_acc_nl;
  wire[10:0] nl_COMP_LOOP_1_acc_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] or_10_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] nor_28_nl;
  wire[0:0] nor_29_nl;
  wire[0:0] and_85_nl;
  wire[0:0] and_88_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] mux_90_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] and_90_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] or_11_nl;
  wire[63:0] COMP_LOOP_1_modulo_qelse_acc_nl;
  wire[64:0] nl_COMP_LOOP_1_modulo_qelse_acc_nl;
  wire[0:0] or_2_nl;
  wire[0:0] or_62_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] nor_26_nl;
  wire[0:0] nor_27_nl;
  wire[3:0] STAGE_LOOP_mux_3_nl;
  wire[7:0] COMP_LOOP_mux_40_nl;
  wire[9:0] COMP_LOOP_mux_41_nl;
  wire[9:0] COMP_LOOP_mux_42_nl;
  wire[63:0] COMP_LOOP_tmp_mux1h_4_nl;
  wire[63:0] COMP_LOOP_tmp_mux1h_5_nl;
  wire[0:0] COMP_LOOP_tmp_or_2_nl;
  wire[0:0] COMP_LOOP_tmp_or_3_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_COMP_LOOP_1_modulo_result_rem_cmp_a;
  assign nl_COMP_LOOP_1_modulo_result_rem_cmp_a = {{1{COMP_LOOP_1_modulo_result_rem_cmp_a_63_0[63]}},
      COMP_LOOP_1_modulo_result_rem_cmp_a_63_0};
  wire [64:0] nl_COMP_LOOP_1_modulo_result_rem_cmp_b;
  assign nl_COMP_LOOP_1_modulo_result_rem_cmp_b = {1'b0, COMP_LOOP_1_modulo_result_rem_cmp_b_63_0};
  wire[0:0] and_120_nl;
  wire [3:0] nl_COMP_LOOP_1_tmp_lshift_rg_s;
  assign and_120_nl = and_dcpl_8 & and_dcpl_9 & (fsm_output[1]) & (fsm_output[0])
      & (~ (fsm_output[6]));
  assign nl_COMP_LOOP_1_tmp_lshift_rg_s = MUX1HOT_v_4_3_2(z_out_1, STAGE_LOOP_i_3_0_sva,
      COMP_LOOP_1_tmp_acc_cse_sva, {(~ (fsm_output[0])) , (~ (fsm_output[1])) , and_120_nl});
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0 = ~ COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0 = ~ COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out_3[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ (z_out_2[2]);
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) COMP_LOOP_1_modulo_result_rem_cmp (
      .a(nl_COMP_LOOP_1_modulo_result_rem_cmp_a[64:0]),
      .b(nl_COMP_LOOP_1_modulo_result_rem_cmp_b[64:0]),
      .z(COMP_LOOP_1_modulo_result_rem_cmp_z)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_1_tmp_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_1_tmp_lshift_rg_s[3:0]),
      .z(z_out)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_0_s_tdone(vec_rsc_0_0_s_tdone),
      .vec_rsc_0_0_tr_write_done(vec_rsc_0_0_tr_write_done),
      .vec_rsc_0_0_RREADY(vec_rsc_0_0_RREADY),
      .vec_rsc_0_0_RVALID(vec_rsc_0_0_RVALID),
      .vec_rsc_0_0_RUSER(vec_rsc_0_0_RUSER),
      .vec_rsc_0_0_RLAST(vec_rsc_0_0_RLAST),
      .vec_rsc_0_0_RRESP(vec_rsc_0_0_RRESP),
      .vec_rsc_0_0_RDATA(vec_rsc_0_0_RDATA),
      .vec_rsc_0_0_RID(vec_rsc_0_0_RID),
      .vec_rsc_0_0_ARREADY(vec_rsc_0_0_ARREADY),
      .vec_rsc_0_0_ARVALID(vec_rsc_0_0_ARVALID),
      .vec_rsc_0_0_ARUSER(vec_rsc_0_0_ARUSER),
      .vec_rsc_0_0_ARREGION(vec_rsc_0_0_ARREGION),
      .vec_rsc_0_0_ARQOS(vec_rsc_0_0_ARQOS),
      .vec_rsc_0_0_ARPROT(vec_rsc_0_0_ARPROT),
      .vec_rsc_0_0_ARCACHE(vec_rsc_0_0_ARCACHE),
      .vec_rsc_0_0_ARLOCK(vec_rsc_0_0_ARLOCK),
      .vec_rsc_0_0_ARBURST(vec_rsc_0_0_ARBURST),
      .vec_rsc_0_0_ARSIZE(vec_rsc_0_0_ARSIZE),
      .vec_rsc_0_0_ARLEN(vec_rsc_0_0_ARLEN),
      .vec_rsc_0_0_ARADDR(vec_rsc_0_0_ARADDR),
      .vec_rsc_0_0_ARID(vec_rsc_0_0_ARID),
      .vec_rsc_0_0_BREADY(vec_rsc_0_0_BREADY),
      .vec_rsc_0_0_BVALID(vec_rsc_0_0_BVALID),
      .vec_rsc_0_0_BUSER(vec_rsc_0_0_BUSER),
      .vec_rsc_0_0_BRESP(vec_rsc_0_0_BRESP),
      .vec_rsc_0_0_BID(vec_rsc_0_0_BID),
      .vec_rsc_0_0_WREADY(vec_rsc_0_0_WREADY),
      .vec_rsc_0_0_WVALID(vec_rsc_0_0_WVALID),
      .vec_rsc_0_0_WUSER(vec_rsc_0_0_WUSER),
      .vec_rsc_0_0_WLAST(vec_rsc_0_0_WLAST),
      .vec_rsc_0_0_WSTRB(vec_rsc_0_0_WSTRB),
      .vec_rsc_0_0_WDATA(vec_rsc_0_0_WDATA),
      .vec_rsc_0_0_AWREADY(vec_rsc_0_0_AWREADY),
      .vec_rsc_0_0_AWVALID(vec_rsc_0_0_AWVALID),
      .vec_rsc_0_0_AWUSER(vec_rsc_0_0_AWUSER),
      .vec_rsc_0_0_AWREGION(vec_rsc_0_0_AWREGION),
      .vec_rsc_0_0_AWQOS(vec_rsc_0_0_AWQOS),
      .vec_rsc_0_0_AWPROT(vec_rsc_0_0_AWPROT),
      .vec_rsc_0_0_AWCACHE(vec_rsc_0_0_AWCACHE),
      .vec_rsc_0_0_AWLOCK(vec_rsc_0_0_AWLOCK),
      .vec_rsc_0_0_AWBURST(vec_rsc_0_0_AWBURST),
      .vec_rsc_0_0_AWSIZE(vec_rsc_0_0_AWSIZE),
      .vec_rsc_0_0_AWLEN(vec_rsc_0_0_AWLEN),
      .vec_rsc_0_0_AWADDR(vec_rsc_0_0_AWADDR),
      .vec_rsc_0_0_AWID(vec_rsc_0_0_AWID),
      .core_wen(core_wen),
      .vec_rsc_0_0_i_oswt(reg_vec_rsc_0_0_i_oswt_cse),
      .vec_rsc_0_0_i_wen_comp(vec_rsc_0_0_i_wen_comp),
      .vec_rsc_0_0_i_oswt_1(reg_vec_rsc_0_0_i_oswt_1_cse),
      .vec_rsc_0_0_i_wen_comp_1(vec_rsc_0_0_i_wen_comp_1),
      .vec_rsc_0_0_i_s_raddr_core(reg_vec_rsc_0_0_i_s_raddr_core_cse),
      .vec_rsc_0_0_i_s_waddr_core(reg_vec_rsc_0_0_i_s_waddr_core_cse),
      .vec_rsc_0_0_i_s_din_mxwt(vec_rsc_0_0_i_s_din_mxwt),
      .vec_rsc_0_0_i_s_dout_core(reg_vec_rsc_0_0_i_s_dout_core_cse)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_1_s_tdone(vec_rsc_0_1_s_tdone),
      .vec_rsc_0_1_tr_write_done(vec_rsc_0_1_tr_write_done),
      .vec_rsc_0_1_RREADY(vec_rsc_0_1_RREADY),
      .vec_rsc_0_1_RVALID(vec_rsc_0_1_RVALID),
      .vec_rsc_0_1_RUSER(vec_rsc_0_1_RUSER),
      .vec_rsc_0_1_RLAST(vec_rsc_0_1_RLAST),
      .vec_rsc_0_1_RRESP(vec_rsc_0_1_RRESP),
      .vec_rsc_0_1_RDATA(vec_rsc_0_1_RDATA),
      .vec_rsc_0_1_RID(vec_rsc_0_1_RID),
      .vec_rsc_0_1_ARREADY(vec_rsc_0_1_ARREADY),
      .vec_rsc_0_1_ARVALID(vec_rsc_0_1_ARVALID),
      .vec_rsc_0_1_ARUSER(vec_rsc_0_1_ARUSER),
      .vec_rsc_0_1_ARREGION(vec_rsc_0_1_ARREGION),
      .vec_rsc_0_1_ARQOS(vec_rsc_0_1_ARQOS),
      .vec_rsc_0_1_ARPROT(vec_rsc_0_1_ARPROT),
      .vec_rsc_0_1_ARCACHE(vec_rsc_0_1_ARCACHE),
      .vec_rsc_0_1_ARLOCK(vec_rsc_0_1_ARLOCK),
      .vec_rsc_0_1_ARBURST(vec_rsc_0_1_ARBURST),
      .vec_rsc_0_1_ARSIZE(vec_rsc_0_1_ARSIZE),
      .vec_rsc_0_1_ARLEN(vec_rsc_0_1_ARLEN),
      .vec_rsc_0_1_ARADDR(vec_rsc_0_1_ARADDR),
      .vec_rsc_0_1_ARID(vec_rsc_0_1_ARID),
      .vec_rsc_0_1_BREADY(vec_rsc_0_1_BREADY),
      .vec_rsc_0_1_BVALID(vec_rsc_0_1_BVALID),
      .vec_rsc_0_1_BUSER(vec_rsc_0_1_BUSER),
      .vec_rsc_0_1_BRESP(vec_rsc_0_1_BRESP),
      .vec_rsc_0_1_BID(vec_rsc_0_1_BID),
      .vec_rsc_0_1_WREADY(vec_rsc_0_1_WREADY),
      .vec_rsc_0_1_WVALID(vec_rsc_0_1_WVALID),
      .vec_rsc_0_1_WUSER(vec_rsc_0_1_WUSER),
      .vec_rsc_0_1_WLAST(vec_rsc_0_1_WLAST),
      .vec_rsc_0_1_WSTRB(vec_rsc_0_1_WSTRB),
      .vec_rsc_0_1_WDATA(vec_rsc_0_1_WDATA),
      .vec_rsc_0_1_AWREADY(vec_rsc_0_1_AWREADY),
      .vec_rsc_0_1_AWVALID(vec_rsc_0_1_AWVALID),
      .vec_rsc_0_1_AWUSER(vec_rsc_0_1_AWUSER),
      .vec_rsc_0_1_AWREGION(vec_rsc_0_1_AWREGION),
      .vec_rsc_0_1_AWQOS(vec_rsc_0_1_AWQOS),
      .vec_rsc_0_1_AWPROT(vec_rsc_0_1_AWPROT),
      .vec_rsc_0_1_AWCACHE(vec_rsc_0_1_AWCACHE),
      .vec_rsc_0_1_AWLOCK(vec_rsc_0_1_AWLOCK),
      .vec_rsc_0_1_AWBURST(vec_rsc_0_1_AWBURST),
      .vec_rsc_0_1_AWSIZE(vec_rsc_0_1_AWSIZE),
      .vec_rsc_0_1_AWLEN(vec_rsc_0_1_AWLEN),
      .vec_rsc_0_1_AWADDR(vec_rsc_0_1_AWADDR),
      .vec_rsc_0_1_AWID(vec_rsc_0_1_AWID),
      .core_wen(core_wen),
      .vec_rsc_0_1_i_oswt(reg_vec_rsc_0_1_i_oswt_cse),
      .vec_rsc_0_1_i_wen_comp(vec_rsc_0_1_i_wen_comp),
      .vec_rsc_0_1_i_oswt_1(reg_vec_rsc_0_1_i_oswt_1_cse),
      .vec_rsc_0_1_i_wen_comp_1(vec_rsc_0_1_i_wen_comp_1),
      .vec_rsc_0_1_i_s_raddr_core(reg_vec_rsc_0_0_i_s_raddr_core_cse),
      .vec_rsc_0_1_i_s_waddr_core(reg_vec_rsc_0_0_i_s_waddr_core_cse),
      .vec_rsc_0_1_i_s_din_mxwt(vec_rsc_0_1_i_s_din_mxwt),
      .vec_rsc_0_1_i_s_dout_core(reg_vec_rsc_0_0_i_s_dout_core_cse)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_0_s_tdone(twiddle_rsc_0_0_s_tdone),
      .twiddle_rsc_0_0_tr_write_done(twiddle_rsc_0_0_tr_write_done),
      .twiddle_rsc_0_0_RREADY(twiddle_rsc_0_0_RREADY),
      .twiddle_rsc_0_0_RVALID(twiddle_rsc_0_0_RVALID),
      .twiddle_rsc_0_0_RUSER(twiddle_rsc_0_0_RUSER),
      .twiddle_rsc_0_0_RLAST(twiddle_rsc_0_0_RLAST),
      .twiddle_rsc_0_0_RRESP(twiddle_rsc_0_0_RRESP),
      .twiddle_rsc_0_0_RDATA(twiddle_rsc_0_0_RDATA),
      .twiddle_rsc_0_0_RID(twiddle_rsc_0_0_RID),
      .twiddle_rsc_0_0_ARREADY(twiddle_rsc_0_0_ARREADY),
      .twiddle_rsc_0_0_ARVALID(twiddle_rsc_0_0_ARVALID),
      .twiddle_rsc_0_0_ARUSER(twiddle_rsc_0_0_ARUSER),
      .twiddle_rsc_0_0_ARREGION(twiddle_rsc_0_0_ARREGION),
      .twiddle_rsc_0_0_ARQOS(twiddle_rsc_0_0_ARQOS),
      .twiddle_rsc_0_0_ARPROT(twiddle_rsc_0_0_ARPROT),
      .twiddle_rsc_0_0_ARCACHE(twiddle_rsc_0_0_ARCACHE),
      .twiddle_rsc_0_0_ARLOCK(twiddle_rsc_0_0_ARLOCK),
      .twiddle_rsc_0_0_ARBURST(twiddle_rsc_0_0_ARBURST),
      .twiddle_rsc_0_0_ARSIZE(twiddle_rsc_0_0_ARSIZE),
      .twiddle_rsc_0_0_ARLEN(twiddle_rsc_0_0_ARLEN),
      .twiddle_rsc_0_0_ARADDR(twiddle_rsc_0_0_ARADDR),
      .twiddle_rsc_0_0_ARID(twiddle_rsc_0_0_ARID),
      .twiddle_rsc_0_0_BREADY(twiddle_rsc_0_0_BREADY),
      .twiddle_rsc_0_0_BVALID(twiddle_rsc_0_0_BVALID),
      .twiddle_rsc_0_0_BUSER(twiddle_rsc_0_0_BUSER),
      .twiddle_rsc_0_0_BRESP(twiddle_rsc_0_0_BRESP),
      .twiddle_rsc_0_0_BID(twiddle_rsc_0_0_BID),
      .twiddle_rsc_0_0_WREADY(twiddle_rsc_0_0_WREADY),
      .twiddle_rsc_0_0_WVALID(twiddle_rsc_0_0_WVALID),
      .twiddle_rsc_0_0_WUSER(twiddle_rsc_0_0_WUSER),
      .twiddle_rsc_0_0_WLAST(twiddle_rsc_0_0_WLAST),
      .twiddle_rsc_0_0_WSTRB(twiddle_rsc_0_0_WSTRB),
      .twiddle_rsc_0_0_WDATA(twiddle_rsc_0_0_WDATA),
      .twiddle_rsc_0_0_AWREADY(twiddle_rsc_0_0_AWREADY),
      .twiddle_rsc_0_0_AWVALID(twiddle_rsc_0_0_AWVALID),
      .twiddle_rsc_0_0_AWUSER(twiddle_rsc_0_0_AWUSER),
      .twiddle_rsc_0_0_AWREGION(twiddle_rsc_0_0_AWREGION),
      .twiddle_rsc_0_0_AWQOS(twiddle_rsc_0_0_AWQOS),
      .twiddle_rsc_0_0_AWPROT(twiddle_rsc_0_0_AWPROT),
      .twiddle_rsc_0_0_AWCACHE(twiddle_rsc_0_0_AWCACHE),
      .twiddle_rsc_0_0_AWLOCK(twiddle_rsc_0_0_AWLOCK),
      .twiddle_rsc_0_0_AWBURST(twiddle_rsc_0_0_AWBURST),
      .twiddle_rsc_0_0_AWSIZE(twiddle_rsc_0_0_AWSIZE),
      .twiddle_rsc_0_0_AWLEN(twiddle_rsc_0_0_AWLEN),
      .twiddle_rsc_0_0_AWADDR(twiddle_rsc_0_0_AWADDR),
      .twiddle_rsc_0_0_AWID(twiddle_rsc_0_0_AWID),
      .core_wen(core_wen),
      .twiddle_rsc_0_0_i_oswt(reg_twiddle_rsc_0_0_i_oswt_cse),
      .twiddle_rsc_0_0_i_wen_comp(twiddle_rsc_0_0_i_wen_comp),
      .twiddle_rsc_0_0_i_s_raddr_core(twiddle_rsc_0_0_i_s_raddr_core),
      .twiddle_rsc_0_0_i_s_din_mxwt(twiddle_rsc_0_0_i_s_din_mxwt)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_1_s_tdone(twiddle_rsc_0_1_s_tdone),
      .twiddle_rsc_0_1_tr_write_done(twiddle_rsc_0_1_tr_write_done),
      .twiddle_rsc_0_1_RREADY(twiddle_rsc_0_1_RREADY),
      .twiddle_rsc_0_1_RVALID(twiddle_rsc_0_1_RVALID),
      .twiddle_rsc_0_1_RUSER(twiddle_rsc_0_1_RUSER),
      .twiddle_rsc_0_1_RLAST(twiddle_rsc_0_1_RLAST),
      .twiddle_rsc_0_1_RRESP(twiddle_rsc_0_1_RRESP),
      .twiddle_rsc_0_1_RDATA(twiddle_rsc_0_1_RDATA),
      .twiddle_rsc_0_1_RID(twiddle_rsc_0_1_RID),
      .twiddle_rsc_0_1_ARREADY(twiddle_rsc_0_1_ARREADY),
      .twiddle_rsc_0_1_ARVALID(twiddle_rsc_0_1_ARVALID),
      .twiddle_rsc_0_1_ARUSER(twiddle_rsc_0_1_ARUSER),
      .twiddle_rsc_0_1_ARREGION(twiddle_rsc_0_1_ARREGION),
      .twiddle_rsc_0_1_ARQOS(twiddle_rsc_0_1_ARQOS),
      .twiddle_rsc_0_1_ARPROT(twiddle_rsc_0_1_ARPROT),
      .twiddle_rsc_0_1_ARCACHE(twiddle_rsc_0_1_ARCACHE),
      .twiddle_rsc_0_1_ARLOCK(twiddle_rsc_0_1_ARLOCK),
      .twiddle_rsc_0_1_ARBURST(twiddle_rsc_0_1_ARBURST),
      .twiddle_rsc_0_1_ARSIZE(twiddle_rsc_0_1_ARSIZE),
      .twiddle_rsc_0_1_ARLEN(twiddle_rsc_0_1_ARLEN),
      .twiddle_rsc_0_1_ARADDR(twiddle_rsc_0_1_ARADDR),
      .twiddle_rsc_0_1_ARID(twiddle_rsc_0_1_ARID),
      .twiddle_rsc_0_1_BREADY(twiddle_rsc_0_1_BREADY),
      .twiddle_rsc_0_1_BVALID(twiddle_rsc_0_1_BVALID),
      .twiddle_rsc_0_1_BUSER(twiddle_rsc_0_1_BUSER),
      .twiddle_rsc_0_1_BRESP(twiddle_rsc_0_1_BRESP),
      .twiddle_rsc_0_1_BID(twiddle_rsc_0_1_BID),
      .twiddle_rsc_0_1_WREADY(twiddle_rsc_0_1_WREADY),
      .twiddle_rsc_0_1_WVALID(twiddle_rsc_0_1_WVALID),
      .twiddle_rsc_0_1_WUSER(twiddle_rsc_0_1_WUSER),
      .twiddle_rsc_0_1_WLAST(twiddle_rsc_0_1_WLAST),
      .twiddle_rsc_0_1_WSTRB(twiddle_rsc_0_1_WSTRB),
      .twiddle_rsc_0_1_WDATA(twiddle_rsc_0_1_WDATA),
      .twiddle_rsc_0_1_AWREADY(twiddle_rsc_0_1_AWREADY),
      .twiddle_rsc_0_1_AWVALID(twiddle_rsc_0_1_AWVALID),
      .twiddle_rsc_0_1_AWUSER(twiddle_rsc_0_1_AWUSER),
      .twiddle_rsc_0_1_AWREGION(twiddle_rsc_0_1_AWREGION),
      .twiddle_rsc_0_1_AWQOS(twiddle_rsc_0_1_AWQOS),
      .twiddle_rsc_0_1_AWPROT(twiddle_rsc_0_1_AWPROT),
      .twiddle_rsc_0_1_AWCACHE(twiddle_rsc_0_1_AWCACHE),
      .twiddle_rsc_0_1_AWLOCK(twiddle_rsc_0_1_AWLOCK),
      .twiddle_rsc_0_1_AWBURST(twiddle_rsc_0_1_AWBURST),
      .twiddle_rsc_0_1_AWSIZE(twiddle_rsc_0_1_AWSIZE),
      .twiddle_rsc_0_1_AWLEN(twiddle_rsc_0_1_AWLEN),
      .twiddle_rsc_0_1_AWADDR(twiddle_rsc_0_1_AWADDR),
      .twiddle_rsc_0_1_AWID(twiddle_rsc_0_1_AWID),
      .core_wen(core_wen),
      .twiddle_rsc_0_1_i_oswt(reg_twiddle_rsc_0_1_i_oswt_cse),
      .twiddle_rsc_0_1_i_wen_comp(twiddle_rsc_0_1_i_wen_comp),
      .twiddle_rsc_0_1_i_s_raddr_core(twiddle_rsc_0_1_i_s_raddr_core),
      .twiddle_rsc_0_1_i_s_din_mxwt(twiddle_rsc_0_1_i_s_din_mxwt)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_inst
      (
      .vec_rsc_triosy_0_1_lz(vec_rsc_triosy_0_1_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_1_obj_iswt0(reg_vec_rsc_triosy_0_1_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_inst
      (
      .vec_rsc_triosy_0_0_lz(vec_rsc_triosy_0_0_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_0_obj_iswt0(reg_vec_rsc_triosy_0_1_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_inst
      (
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .core_wten(core_wten),
      .p_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_0_1_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_inst
      (
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .core_wten(core_wten),
      .r_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_0_1_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_inst
      (
      .twiddle_rsc_triosy_0_1_lz(twiddle_rsc_triosy_0_1_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_1_obj_iswt0(reg_vec_rsc_triosy_0_1_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_inst
      (
      .twiddle_rsc_triosy_0_0_lz(twiddle_rsc_triosy_0_0_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_0_obj_iswt0(reg_vec_rsc_triosy_0_1_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_staller inPlaceNTT_DIT_precomp_core_staller_inst (
      .clk(clk),
      .rst(rst),
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_0_i_wen_comp(vec_rsc_0_0_i_wen_comp),
      .vec_rsc_0_0_i_wen_comp_1(vec_rsc_0_0_i_wen_comp_1),
      .vec_rsc_0_1_i_wen_comp(vec_rsc_0_1_i_wen_comp),
      .vec_rsc_0_1_i_wen_comp_1(vec_rsc_0_1_i_wen_comp_1),
      .twiddle_rsc_0_0_i_wen_comp(twiddle_rsc_0_0_i_wen_comp),
      .twiddle_rsc_0_1_i_wen_comp(twiddle_rsc_0_1_i_wen_comp)
    );
  inPlaceNTT_DIT_precomp_core_core_fsm inPlaceNTT_DIT_precomp_core_core_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .core_wen(core_wen),
      .fsm_output(fsm_output),
      .COMP_LOOP_C_38_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0[0:0]),
      .COMP_LOOP_C_77_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0[0:0]),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign and_98_cse = (fsm_output[1:0]==2'b11);
  assign or_118_cse = (fsm_output[4:3]!=2'b00);
  assign or_116_cse = (fsm_output[5:4]!=2'b00);
  assign COMP_LOOP_and_cse = core_wen & (~(or_dcpl_10 | or_dcpl_8));
  assign COMP_LOOP_and_5_cse = core_wen & (~(or_116_cse | (fsm_output[3:2]!=2'b11)
      | or_dcpl_12));
  assign COMP_LOOP_and_7_cse = core_wen & (~((~ nor_tmp_3) | (fsm_output[3:2]!=2'b01)
      | or_dcpl_8));
  assign nl_COMP_LOOP_1_modulo_qelse_acc_nl = (COMP_LOOP_1_modulo_result_rem_cmp_z[63:0])
      + p_sva;
  assign COMP_LOOP_1_modulo_qelse_acc_nl = nl_COMP_LOOP_1_modulo_qelse_acc_nl[63:0];
  assign vec_rsc_0_0_i_s_dout_core_1 = MUX_v_64_2_2((COMP_LOOP_1_modulo_result_rem_cmp_z[63:0]),
      COMP_LOOP_1_modulo_qelse_acc_nl, COMP_LOOP_1_modulo_result_rem_cmp_z[63]);
  assign nl_COMP_LOOP_2_acc_5_psp_mx0w2 = tmp_2_lpi_4_dfm + vec_rsc_0_0_i_s_dout_core_1;
  assign COMP_LOOP_2_acc_5_psp_mx0w2 = nl_COMP_LOOP_2_acc_5_psp_mx0w2[63:0];
  assign nl_COMP_LOOP_1_acc_10_tmp = VEC_LOOP_j_sva_9_0 + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , 1'b0}) + conv_u2u_9_10(STAGE_LOOP_lshift_psp_sva[9:1]);
  assign COMP_LOOP_1_acc_10_tmp = nl_COMP_LOOP_1_acc_10_tmp[9:0];
  assign nl_COMP_LOOP_1_acc_8_itm_mx0w0 = tmp_2_lpi_4_dfm - vec_rsc_0_0_i_s_dout_core_1;
  assign COMP_LOOP_1_acc_8_itm_mx0w0 = nl_COMP_LOOP_1_acc_8_itm_mx0w0[63:0];
  assign or_tmp = (fsm_output[5:1]!=5'b00000);
  assign nor_tmp_3 = (fsm_output[5:4]==2'b11);
  assign and_dcpl_6 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_7 = and_dcpl_6 & (~ (fsm_output[6]));
  assign and_dcpl_8 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_9 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_10 = and_dcpl_9 & and_dcpl_8;
  assign and_dcpl_12 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_14 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_15 = and_dcpl_14 & and_dcpl_8;
  assign and_dcpl_18 = ~((fsm_output[4]) | (fsm_output[2]) | (fsm_output[6]));
  assign not_tmp_34 = ~((fsm_output[3]) & (fsm_output[5]));
  assign and_dcpl_21 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_22 = and_dcpl_21 & (~ (fsm_output[6]));
  assign and_dcpl_23 = and_dcpl_10 & and_dcpl_22;
  assign and_dcpl_25 = (fsm_output[0]) & (fsm_output[1]) & (~ (fsm_output[6]));
  assign and_dcpl_26 = and_dcpl_10 & and_dcpl_25;
  assign and_dcpl_27 = (fsm_output[3:2]==2'b10);
  assign and_dcpl_28 = (fsm_output[5:4]==2'b10);
  assign and_dcpl_29 = and_dcpl_28 & and_dcpl_27;
  assign and_dcpl_31 = and_dcpl_12 & (~ (fsm_output[6]));
  assign and_dcpl_35 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_38 = and_dcpl_21 & (fsm_output[6]);
  assign and_dcpl_40 = (fsm_output[3:2]==2'b11);
  assign and_dcpl_50 = and_dcpl_9 & and_dcpl_35;
  assign and_dcpl_51 = and_dcpl_50 & and_dcpl_7;
  assign or_dcpl_4 = ~((fsm_output[1:0]==2'b11));
  assign or_2_nl = (fsm_output[5:4]!=2'b10);
  assign or_62_nl = (fsm_output[5:4]!=2'b01);
  assign mux_tmp_53 = MUX_s_1_2_2(or_2_nl, or_62_nl, fsm_output[3]);
  assign and_dcpl_67 = and_dcpl_29 & and_dcpl_22;
  assign or_tmp_59 = (fsm_output[4:3]!=2'b01);
  assign mux_tmp_57 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[3]);
  assign or_tmp_60 = (fsm_output[4:3]!=2'b10);
  assign mux_tmp_68 = MUX_s_1_2_2(nor_tmp_3, (fsm_output[5]), fsm_output[3]);
  assign mux_tmp_69 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[5]);
  assign or_dcpl_8 = (fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[6]);
  assign or_dcpl_10 = or_116_cse | (fsm_output[3:2]!=2'b00);
  assign not_tmp_58 = ~(and_98_cse | (fsm_output[5:2]!=4'b0000));
  assign mux_tmp_77 = MUX_s_1_2_2(mux_tmp_69, nor_tmp_3, fsm_output[3]);
  assign or_dcpl_12 = or_dcpl_4 | (fsm_output[6]);
  assign and_dcpl_80 = ~((fsm_output[4]) | (fsm_output[1]) | (fsm_output[6]));
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_15 & and_dcpl_12 & (fsm_output[6]);
  assign VEC_LOOP_j_sva_9_0_mx0c0 = and_dcpl_10 & and_dcpl_31;
  assign nor_26_nl = ~((~ (VEC_LOOP_j_sva_9_0[0])) | (~ (fsm_output[2])) | (fsm_output[3])
      | (fsm_output[5]));
  assign nor_27_nl = ~((~ (COMP_LOOP_acc_1_cse_sva[0])) | (fsm_output[2]) | not_tmp_34);
  assign mux_83_nl = MUX_s_1_2_2(nor_26_nl, nor_27_nl, fsm_output[0]);
  assign tmp_2_lpi_4_dfm_mx0c1 = mux_83_nl & and_dcpl_80;
  assign and_dcpl_111 = ~((fsm_output!=7'b0000010));
  assign and_dcpl_122 = (fsm_output[5:4]==2'b01) & and_dcpl_8 & (~ (fsm_output[1]))
      & (fsm_output[0]) & (fsm_output[6]);
  assign and_dcpl_133 = (fsm_output[5:4]==2'b01) & and_dcpl_8 & (~ (fsm_output[1]))
      & (~ (fsm_output[0])) & (fsm_output[6]);
  assign and_dcpl_135 = (fsm_output[1]) & (~ (fsm_output[0])) & (~ (fsm_output[6]));
  assign and_dcpl_138 = and_dcpl_9 & (fsm_output[3:2]==2'b00);
  assign and_dcpl_139 = and_dcpl_138 & and_dcpl_135;
  assign and_dcpl_142 = and_dcpl_138 & (fsm_output[1]) & (fsm_output[0]) & (~ (fsm_output[6]));
  assign and_dcpl_146 = (fsm_output[5:2]==4'b1010) & and_dcpl_135;
  assign and_dcpl_151 = and_dcpl_9 & (~ (fsm_output[3])) & (fsm_output[2]) & (~ (fsm_output[1]))
      & (~ (fsm_output[0])) & (~ (fsm_output[6]));
  always @(posedge clk) begin
    if ( core_wen & mux_34_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((and_dcpl_10 & and_dcpl_7) | STAGE_LOOP_i_3_0_sva_mx0c1) ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, z_out_1, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen ) begin
      reg_vec_rsc_0_0_i_s_raddr_core_cse <= MUX1HOT_v_9_4_2((COMP_LOOP_1_acc_10_tmp[9:1]),
          COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_1_cse_sva[9:1]), (COMP_LOOP_2_acc_10_idiv_sva[9:1]),
          {and_dcpl_23 , and_dcpl_26 , and_30_nl , and_32_nl});
      reg_vec_rsc_0_0_i_s_waddr_core_cse <= MUX1HOT_v_9_4_2(COMP_LOOP_acc_psp_sva,
          (COMP_LOOP_1_slc_31_1_idiv_sva[9:1]), (COMP_LOOP_acc_1_cse_sva[9:1]), (COMP_LOOP_2_slc_31_1_idiv_sva[9:1]),
          {and_34_nl , and_37_nl , and_39_nl , and_42_nl});
      reg_vec_rsc_0_0_i_s_dout_core_cse <= vec_rsc_0_0_i_s_dout_core_1;
      twiddle_rsc_0_0_i_s_raddr_core <= MUX_v_9_2_2((z_out_4[8:0]), (z_out_4[9:1]),
          and_dcpl_51);
      twiddle_rsc_0_1_i_s_raddr_core <= z_out_4[9:1];
      COMP_LOOP_1_modulo_result_rem_cmp_a_63_0 <= MUX1HOT_v_64_8_2(z_out_4, COMP_LOOP_1_mul_psp,
          COMP_LOOP_2_acc_5_psp_mx0w2, COMP_LOOP_1_acc_5_psp, COMP_LOOP_1_acc_8_itm,
          COMP_LOOP_2_mul_psp, COMP_LOOP_2_acc_5_psp, COMP_LOOP_2_acc_8_itm, {COMP_LOOP_or_2_nl
          , and_59_nl , and_62_nl , and_65_nl , nor_55_nl , and_69_nl , (~ mux_63_nl)
          , and_71_nl});
      COMP_LOOP_1_modulo_result_rem_cmp_b_63_0 <= p_sva;
      COMP_LOOP_1_tmp_acc_cse_sva <= z_out_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_0_0_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_0_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_1_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_1_i_oswt_1_cse <= 1'b0;
      reg_twiddle_rsc_0_0_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_1_i_oswt_cse <= 1'b0;
      reg_vec_rsc_triosy_0_1_obj_iswt0_cse <= 1'b0;
      COMP_LOOP_2_tmp_lshift_itm <= 10'b0000000000;
    end
    else if ( core_wen ) begin
      reg_vec_rsc_0_0_i_oswt_cse <= mux_38_nl & and_dcpl_18;
      reg_vec_rsc_0_0_i_oswt_1_cse <= mux_41_nl & (fsm_output[1]);
      reg_vec_rsc_0_1_i_oswt_cse <= mux_44_nl & and_dcpl_18;
      reg_vec_rsc_0_1_i_oswt_1_cse <= mux_47_nl & (fsm_output[1]);
      reg_twiddle_rsc_0_0_i_oswt_cse <= ~(mux_49_nl | (fsm_output[4]) | (fsm_output[5])
          | (fsm_output[3]) | (fsm_output[0]) | (fsm_output[6]));
      reg_twiddle_rsc_0_1_i_oswt_cse <= and_dcpl_50 & and_dcpl_6 & (~ (fsm_output[6]))
          & (z_out_4[0]);
      reg_vec_rsc_triosy_0_1_obj_iswt0_cse <= and_dcpl_15 & and_dcpl_12 & (fsm_output[6])
          & (~ (z_out_2[2]));
      COMP_LOOP_2_tmp_lshift_itm <= MUX1HOT_v_10_3_2(COMP_LOOP_1_acc_10_tmp, z_out,
          (z_out_4[9:0]), {and_dcpl_23 , and_dcpl_26 , and_dcpl_51});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_sva_9_0 <= 10'b0000000000;
    end
    else if ( core_wen & (VEC_LOOP_j_sva_9_0_mx0c0 | (and_dcpl_15 & and_dcpl_6 &
        (fsm_output[6]))) ) begin
      VEC_LOOP_j_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (z_out_3[9:0]), VEC_LOOP_j_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & mux_67_nl ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( mux_94_nl & core_wen ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= MUX_v_8_2_2(8'b00000000, reg_COMP_LOOP_k_9_1_ftd,
          or_115_nl);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_and_cse ) begin
      COMP_LOOP_acc_psp_sva <= z_out_3[8:0];
      COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm <= readslicef_10_1_9(COMP_LOOP_2_acc_nl);
      reg_COMP_LOOP_k_9_1_ftd <= z_out_2[7:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_slc_31_1_idiv_sva <= 10'b0000000000;
    end
    else if ( COMP_LOOP_and_cse ) begin
      COMP_LOOP_1_slc_31_1_idiv_sva <= readslicef_11_10_1(COMP_LOOP_1_acc_11_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_1_cse_sva <= 10'b0000000000;
    end
    else if ( core_wen & mux_75_nl ) begin
      COMP_LOOP_acc_1_cse_sva <= nl_COMP_LOOP_acc_1_cse_sva[9:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_2_acc_10_idiv_sva <= 10'b0000000000;
    end
    else if ( core_wen & (mux_79_nl | (fsm_output[6])) ) begin
      COMP_LOOP_2_acc_10_idiv_sva <= nl_COMP_LOOP_2_acc_10_idiv_sva[9:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_2_slc_31_1_idiv_sva <= 10'b0000000000;
    end
    else if ( core_wen & mux_80_nl ) begin
      COMP_LOOP_2_slc_31_1_idiv_sva <= readslicef_11_10_1(COMP_LOOP_2_acc_11_nl);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & mux_81_nl ) begin
      COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm <= readslicef_10_1_9(COMP_LOOP_1_acc_nl);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (~(or_dcpl_10 | or_dcpl_12)) ) begin
      COMP_LOOP_1_mul_psp <= z_out_4;
    end
  end
  always @(posedge clk) begin
    if ( core_wen & ((mux_82_nl & and_dcpl_80) | tmp_2_lpi_4_dfm_mx0c1) ) begin
      tmp_2_lpi_4_dfm <= MUX_v_64_2_2(vec_rsc_0_0_i_s_din_mxwt, vec_rsc_0_1_i_s_din_mxwt,
          tmp_2_lpi_4_dfm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( core_wen & (mux_91_nl | (fsm_output[6])) ) begin
      COMP_LOOP_2_mul_psp <= MUX1HOT_v_64_3_2(twiddle_rsc_0_0_i_s_din_mxwt, twiddle_rsc_0_1_i_s_din_mxwt,
          z_out_4, {and_85_nl , and_88_nl , and_dcpl_67});
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_and_5_cse ) begin
      COMP_LOOP_1_acc_8_itm <= COMP_LOOP_1_acc_8_itm_mx0w0;
      COMP_LOOP_1_acc_5_psp <= COMP_LOOP_2_acc_5_psp_mx0w2;
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_and_7_cse ) begin
      COMP_LOOP_2_acc_8_itm <= COMP_LOOP_1_acc_8_itm_mx0w0;
      COMP_LOOP_2_acc_5_psp <= COMP_LOOP_2_acc_5_psp_mx0w2;
    end
  end
  assign nor_43_nl = ~((fsm_output[5:0]!=6'b000000));
  assign or_106_nl = (fsm_output[3:1]!=3'b000);
  assign mux_33_nl = MUX_s_1_2_2((fsm_output[5]), or_116_cse, or_106_nl);
  assign mux_34_nl = MUX_s_1_2_2(nor_43_nl, mux_33_nl, fsm_output[6]);
  assign nor_39_nl = ~((~ COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) | (COMP_LOOP_acc_1_cse_sva[0])
      | not_tmp_34);
  assign nor_40_nl = ~((COMP_LOOP_2_acc_10_idiv_sva[0]) | not_tmp_34);
  assign mux_37_nl = MUX_s_1_2_2(nor_39_nl, nor_40_nl, fsm_output[0]);
  assign nor_41_nl = ~((COMP_LOOP_1_acc_10_tmp[0]) | (fsm_output[3]) | (fsm_output[5]));
  assign nor_42_nl = ~((VEC_LOOP_j_sva_9_0[0]) | (fsm_output[3]) | (fsm_output[5]));
  assign mux_36_nl = MUX_s_1_2_2(nor_41_nl, nor_42_nl, fsm_output[0]);
  assign mux_38_nl = MUX_s_1_2_2(mux_37_nl, mux_36_nl, fsm_output[1]);
  assign or_43_nl = (fsm_output[2]) | (COMP_LOOP_acc_1_cse_sva[0]) | (fsm_output[5]);
  assign or_42_nl = (~ (fsm_output[2])) | (COMP_LOOP_2_slc_31_1_idiv_sva[0]) | (fsm_output[5]);
  assign mux_40_nl = MUX_s_1_2_2(or_43_nl, or_42_nl, fsm_output[3]);
  assign nor_37_nl = ~((~ (fsm_output[6])) | (fsm_output[4]) | mux_40_nl);
  assign or_39_nl = (fsm_output[3:2]!=2'b01) | (COMP_LOOP_1_slc_31_1_idiv_sva[0])
      | (~ (fsm_output[5]));
  assign or_37_nl = (fsm_output[3:2]!=2'b10) | (VEC_LOOP_j_sva_9_0[0]) | (fsm_output[5]);
  assign mux_39_nl = MUX_s_1_2_2(or_39_nl, or_37_nl, fsm_output[4]);
  assign nor_38_nl = ~((fsm_output[6]) | mux_39_nl);
  assign mux_41_nl = MUX_s_1_2_2(nor_37_nl, nor_38_nl, fsm_output[0]);
  assign and_30_nl = and_dcpl_29 & and_dcpl_7;
  assign and_32_nl = and_dcpl_29 & and_dcpl_31;
  assign and_34_nl = and_dcpl_14 & and_dcpl_27 & and_dcpl_25;
  assign and_37_nl = and_dcpl_28 & and_dcpl_35 & and_dcpl_25;
  assign and_39_nl = and_dcpl_10 & and_dcpl_38;
  assign and_42_nl = and_dcpl_9 & and_dcpl_40 & and_dcpl_38;
  assign and_99_nl = COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm & (COMP_LOOP_acc_1_cse_sva[0])
      & (fsm_output[3]) & (fsm_output[5]);
  assign and_100_nl = (COMP_LOOP_2_acc_10_idiv_sva[0]) & (fsm_output[3]) & (fsm_output[5]);
  assign mux_43_nl = MUX_s_1_2_2(and_99_nl, and_100_nl, fsm_output[0]);
  assign nor_35_nl = ~((~ (COMP_LOOP_1_acc_10_tmp[0])) | (fsm_output[3]) | (fsm_output[5]));
  assign nor_36_nl = ~((~ (VEC_LOOP_j_sva_9_0[0])) | (fsm_output[3]) | (fsm_output[5]));
  assign mux_42_nl = MUX_s_1_2_2(nor_35_nl, nor_36_nl, fsm_output[0]);
  assign mux_44_nl = MUX_s_1_2_2(mux_43_nl, mux_42_nl, fsm_output[1]);
  assign or_53_nl = (fsm_output[2]) | (~ (COMP_LOOP_acc_1_cse_sva[0])) | (fsm_output[5]);
  assign or_52_nl = (~ (fsm_output[2])) | (~ (COMP_LOOP_2_slc_31_1_idiv_sva[0]))
      | (fsm_output[5]);
  assign mux_46_nl = MUX_s_1_2_2(or_53_nl, or_52_nl, fsm_output[3]);
  assign nor_33_nl = ~((~ (fsm_output[6])) | (fsm_output[4]) | mux_46_nl);
  assign or_49_nl = (fsm_output[3]) | (~((fsm_output[2]) & (COMP_LOOP_1_slc_31_1_idiv_sva[0])
      & (fsm_output[5])));
  assign or_48_nl = (fsm_output[3:2]!=2'b10) | (~ (VEC_LOOP_j_sva_9_0[0])) | (fsm_output[5]);
  assign mux_45_nl = MUX_s_1_2_2(or_49_nl, or_48_nl, fsm_output[4]);
  assign nor_34_nl = ~((fsm_output[6]) | mux_45_nl);
  assign mux_47_nl = MUX_s_1_2_2(nor_33_nl, nor_34_nl, fsm_output[0]);
  assign mux_48_nl = MUX_s_1_2_2((~ (fsm_output[2])), (fsm_output[2]), fsm_output[1]);
  assign or_114_nl = (fsm_output[2:1]!=2'b01);
  assign mux_49_nl = MUX_s_1_2_2(mux_48_nl, or_114_nl, z_out_4[0]);
  assign COMP_LOOP_or_2_nl = and_dcpl_26 | and_dcpl_67;
  assign mux_50_nl = MUX_s_1_2_2((~ (fsm_output[3])), (fsm_output[3]), fsm_output[2]);
  assign mux_51_nl = MUX_s_1_2_2(and_dcpl_8, mux_50_nl, and_98_cse);
  assign and_59_nl = (~ mux_51_nl) & and_dcpl_9 & (~ (fsm_output[6]));
  assign nor_31_nl = ~((fsm_output[3]) | (~ nor_tmp_3));
  assign nor_32_nl = ~((fsm_output[5:3]!=3'b001));
  assign mux_52_nl = MUX_s_1_2_2(nor_31_nl, nor_32_nl, fsm_output[0]);
  assign and_62_nl = mux_52_nl & (fsm_output[2]) & (fsm_output[1]) & (~ (fsm_output[6]));
  assign and_65_nl = (~((~(or_dcpl_4 & (~ (fsm_output[2])))) & (fsm_output[3])))
      & and_dcpl_14 & (~ (fsm_output[6]));
  assign or_64_nl = (fsm_output[5:3]!=3'b100);
  assign mux_55_nl = MUX_s_1_2_2(or_64_nl, mux_tmp_53, fsm_output[2]);
  assign or_61_nl = (fsm_output[5:3]!=3'b011);
  assign mux_54_nl = MUX_s_1_2_2(mux_tmp_53, or_61_nl, fsm_output[2]);
  assign mux_56_nl = MUX_s_1_2_2(mux_55_nl, mux_54_nl, and_98_cse);
  assign nor_55_nl = ~(mux_56_nl | (fsm_output[6]));
  assign mux_61_nl = MUX_s_1_2_2(or_tmp_60, mux_tmp_57, fsm_output[2]);
  assign mux_59_nl = MUX_s_1_2_2(or_tmp_60, or_tmp_59, fsm_output[2]);
  assign mux_58_nl = MUX_s_1_2_2(mux_tmp_57, or_tmp_59, fsm_output[2]);
  assign mux_60_nl = MUX_s_1_2_2(mux_59_nl, mux_58_nl, fsm_output[0]);
  assign mux_62_nl = MUX_s_1_2_2(mux_61_nl, mux_60_nl, fsm_output[1]);
  assign and_69_nl = (~ mux_62_nl) & (fsm_output[6:5]==2'b01);
  assign nand_nl = ~((((fsm_output[2:0]==3'b111)) | (fsm_output[3])) & (fsm_output[5:4]==2'b11));
  assign mux_63_nl = MUX_s_1_2_2(nand_nl, or_tmp, fsm_output[6]);
  assign mux_64_nl = MUX_s_1_2_2(and_dcpl_8, and_dcpl_40, fsm_output[1]);
  assign and_71_nl = (~ mux_64_nl) & and_dcpl_9 & (fsm_output[6]);
  assign VEC_LOOP_j_not_1_nl = ~ VEC_LOOP_j_sva_9_0_mx0c0;
  assign or_72_nl = (fsm_output[3:0]!=4'b0000);
  assign mux_66_nl = MUX_s_1_2_2((fsm_output[5]), or_116_cse, or_72_nl);
  assign mux_67_nl = MUX_s_1_2_2((~ or_tmp), mux_66_nl, fsm_output[6]);
  assign or_111_nl = (~ (fsm_output[0])) | (fsm_output[4]);
  assign or_112_nl = (fsm_output[0]) | (~ (fsm_output[4]));
  assign mux_28_nl = MUX_s_1_2_2(or_111_nl, or_112_nl, fsm_output[6]);
  assign or_115_nl = mux_28_nl | (fsm_output[5]) | (~ and_dcpl_8) | (fsm_output[1]);
  assign nand_7_nl = ~((((fsm_output[0]) & (fsm_output[3])) | (fsm_output[4])) &
      (fsm_output[5]));
  assign mux_nl = MUX_s_1_2_2((fsm_output[5]), (~ (fsm_output[5])), or_118_cse);
  assign mux_92_nl = MUX_s_1_2_2(nand_7_nl, mux_nl, fsm_output[1]);
  assign nand_8_nl = ~(or_118_cse & (fsm_output[5]));
  assign mux_93_nl = MUX_s_1_2_2(mux_92_nl, nand_8_nl, fsm_output[2]);
  assign mux_94_nl = MUX_s_1_2_2(mux_93_nl, or_116_cse, fsm_output[6]);
  assign nl_COMP_LOOP_1_acc_11_nl = conv_u2u_10_11(VEC_LOOP_j_sva_9_0) + conv_u2u_9_11({COMP_LOOP_k_9_1_sva_7_0
      , 1'b0}) + conv_u2u_10_11(STAGE_LOOP_lshift_psp_sva);
  assign COMP_LOOP_1_acc_11_nl = nl_COMP_LOOP_1_acc_11_nl[10:0];
  assign nl_COMP_LOOP_2_acc_nl = ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + conv_u2s_9_10({COMP_LOOP_k_9_1_sva_7_0 , 1'b1}) + 10'b0000000001;
  assign COMP_LOOP_2_acc_nl = nl_COMP_LOOP_2_acc_nl[9:0];
  assign nl_COMP_LOOP_acc_1_cse_sva  = VEC_LOOP_j_sva_9_0 + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , 1'b1});
  assign mux_75_nl = MUX_s_1_2_2(not_tmp_58, or_tmp, fsm_output[6]);
  assign nl_COMP_LOOP_2_acc_10_idiv_sva  = VEC_LOOP_j_sva_9_0 + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , 1'b1}) + conv_u2u_9_10(STAGE_LOOP_lshift_psp_sva[9:1]);
  assign mux_78_nl = MUX_s_1_2_2(mux_tmp_77, mux_tmp_68, fsm_output[2]);
  assign mux_70_nl = MUX_s_1_2_2(mux_tmp_69, (fsm_output[5]), fsm_output[3]);
  assign or_109_nl = (fsm_output[0]) | (fsm_output[2]);
  assign mux_76_nl = MUX_s_1_2_2(mux_70_nl, mux_tmp_68, or_109_nl);
  assign mux_79_nl = MUX_s_1_2_2(mux_78_nl, mux_76_nl, fsm_output[1]);
  assign nl_COMP_LOOP_2_acc_11_nl = conv_u2u_10_11(VEC_LOOP_j_sva_9_0) + conv_u2u_9_11({COMP_LOOP_k_9_1_sva_7_0
      , 1'b1}) + conv_u2u_10_11(STAGE_LOOP_lshift_psp_sva);
  assign COMP_LOOP_2_acc_11_nl = nl_COMP_LOOP_2_acc_11_nl[10:0];
  assign or_9_nl = ((fsm_output[3:1]==3'b111)) | (fsm_output[5:4]!=2'b00);
  assign mux_80_nl = MUX_s_1_2_2(not_tmp_58, or_9_nl, fsm_output[6]);
  assign nl_COMP_LOOP_1_acc_nl = ({z_out_2 , 1'b0}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + 10'b0000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[9:0];
  assign or_10_nl = ((fsm_output[3:0]==4'b1111)) | (fsm_output[5:4]!=2'b00);
  assign mux_81_nl = MUX_s_1_2_2(not_tmp_58, or_10_nl, fsm_output[6]);
  assign nor_28_nl = ~((VEC_LOOP_j_sva_9_0[0]) | (~ (fsm_output[2])) | (fsm_output[3])
      | (fsm_output[5]));
  assign nor_29_nl = ~((COMP_LOOP_acc_1_cse_sva[0]) | (fsm_output[2]) | not_tmp_34);
  assign mux_82_nl = MUX_s_1_2_2(nor_28_nl, nor_29_nl, fsm_output[0]);
  assign and_85_nl = and_dcpl_50 & and_dcpl_12 & (~ (fsm_output[6])) & (~ (COMP_LOOP_2_tmp_lshift_itm[0]));
  assign and_88_nl = and_dcpl_50 & and_dcpl_12 & (~ (fsm_output[6])) & (COMP_LOOP_2_tmp_lshift_itm[0]);
  assign mux_89_nl = MUX_s_1_2_2(and_dcpl_9, nor_tmp_3, fsm_output[3]);
  assign and_90_nl = (fsm_output[0]) & (fsm_output[2]);
  assign mux_90_nl = MUX_s_1_2_2(mux_89_nl, mux_tmp_77, and_90_nl);
  assign mux_86_nl = MUX_s_1_2_2(and_dcpl_9, (fsm_output[5]), fsm_output[3]);
  assign mux_87_nl = MUX_s_1_2_2(mux_86_nl, nor_tmp_3, fsm_output[2]);
  assign or_11_nl = (fsm_output[3:2]!=2'b00);
  assign mux_85_nl = MUX_s_1_2_2(and_dcpl_9, nor_tmp_3, or_11_nl);
  assign mux_88_nl = MUX_s_1_2_2(mux_87_nl, mux_85_nl, fsm_output[0]);
  assign mux_91_nl = MUX_s_1_2_2(mux_90_nl, mux_88_nl, fsm_output[1]);
  assign STAGE_LOOP_mux_3_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (~ STAGE_LOOP_i_3_0_sva),
      and_dcpl_111);
  assign nl_z_out_1 = STAGE_LOOP_mux_3_nl + ({and_dcpl_111 , 1'b0 , and_dcpl_111
      , 1'b1});
  assign z_out_1 = nl_z_out_1[3:0];
  assign COMP_LOOP_mux_40_nl = MUX_v_8_2_2(COMP_LOOP_k_9_1_sva_7_0, ({5'b00000 ,
      (z_out_1[3:1])}), and_dcpl_122);
  assign nl_z_out_2 = conv_u2u_8_9(COMP_LOOP_mux_40_nl) + conv_u2u_2_9({and_dcpl_122
      , 1'b1});
  assign z_out_2 = nl_z_out_2[8:0];
  assign COMP_LOOP_mux_41_nl = MUX_v_10_2_2(({1'b0 , (VEC_LOOP_j_sva_9_0[9:1])}),
      VEC_LOOP_j_sva_9_0, and_dcpl_133);
  assign COMP_LOOP_mux_42_nl = MUX_v_10_2_2(({2'b00 , COMP_LOOP_k_9_1_sva_7_0}),
      STAGE_LOOP_lshift_psp_sva, and_dcpl_133);
  assign nl_z_out_3 = conv_u2u_10_11(COMP_LOOP_mux_41_nl) + conv_u2u_10_11(COMP_LOOP_mux_42_nl);
  assign z_out_3 = nl_z_out_3[10:0];
  assign COMP_LOOP_tmp_mux1h_4_nl = MUX1HOT_v_64_4_2(({55'b0000000000000000000000000000000000000000000000000000000
      , (z_out[8:0])}), twiddle_rsc_0_0_i_s_din_mxwt, COMP_LOOP_2_mul_psp, ({54'b000000000000000000000000000000000000000000000000000000
      , COMP_LOOP_2_tmp_lshift_itm}), {and_dcpl_139 , and_dcpl_142 , and_dcpl_146
      , and_dcpl_151});
  assign COMP_LOOP_tmp_or_2_nl = ((~ (COMP_LOOP_2_tmp_lshift_itm[0])) & and_dcpl_142)
      | ((~ (COMP_LOOP_2_acc_10_idiv_sva[0])) & and_dcpl_146);
  assign COMP_LOOP_tmp_or_3_nl = ((COMP_LOOP_2_tmp_lshift_itm[0]) & and_dcpl_142)
      | ((COMP_LOOP_2_acc_10_idiv_sva[0]) & and_dcpl_146);
  assign COMP_LOOP_tmp_mux1h_5_nl = MUX1HOT_v_64_4_2(({56'b00000000000000000000000000000000000000000000000000000000
      , COMP_LOOP_k_9_1_sva_7_0}), vec_rsc_0_0_i_s_din_mxwt, vec_rsc_0_1_i_s_din_mxwt,
      ({55'b0000000000000000000000000000000000000000000000000000000 , COMP_LOOP_k_9_1_sva_7_0
      , 1'b1}), {and_dcpl_139 , COMP_LOOP_tmp_or_2_nl , COMP_LOOP_tmp_or_3_nl , and_dcpl_151});
  assign nl_z_out_4 = COMP_LOOP_tmp_mux1h_4_nl * COMP_LOOP_tmp_mux1h_5_nl;
  assign z_out_4 = nl_z_out_4[63:0];

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


  function automatic [3:0] MUX1HOT_v_4_3_2;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [2:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | ( input_1 & {4{sel[1]}});
    result = result | ( input_2 & {4{sel[2]}});
    MUX1HOT_v_4_3_2 = result;
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


  function automatic [63:0] MUX1HOT_v_64_8_2;
    input [63:0] input_7;
    input [63:0] input_6;
    input [63:0] input_5;
    input [63:0] input_4;
    input [63:0] input_3;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [7:0] sel;
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
    MUX1HOT_v_64_8_2 = result;
  end
  endfunction


  function automatic [8:0] MUX1HOT_v_9_4_2;
    input [8:0] input_3;
    input [8:0] input_2;
    input [8:0] input_1;
    input [8:0] input_0;
    input [3:0] sel;
    reg [8:0] result;
  begin
    result = input_0 & {9{sel[0]}};
    result = result | ( input_1 & {9{sel[1]}});
    result = result | ( input_2 & {9{sel[2]}});
    result = result | ( input_3 & {9{sel[3]}});
    MUX1HOT_v_9_4_2 = result;
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


  function automatic [0:0] readslicef_10_1_9;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 9;
    readslicef_10_1_9 = tmp[0:0];
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


  function automatic [9:0] conv_u2s_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2s_9_10 =  {1'b0, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_2_9 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_9 = {{7{1'b0}}, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_9_11 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_11 = {{2{1'b0}}, vector};
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
//  Design Unit:    inPlaceNTT_DIT_precomp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp (
  clk, rst, vec_rsc_0_0_s_tdone, vec_rsc_0_0_tr_write_done, vec_rsc_0_0_RREADY, vec_rsc_0_0_RVALID,
      vec_rsc_0_0_RUSER, vec_rsc_0_0_RLAST, vec_rsc_0_0_RRESP, vec_rsc_0_0_RDATA,
      vec_rsc_0_0_RID, vec_rsc_0_0_ARREADY, vec_rsc_0_0_ARVALID, vec_rsc_0_0_ARUSER,
      vec_rsc_0_0_ARREGION, vec_rsc_0_0_ARQOS, vec_rsc_0_0_ARPROT, vec_rsc_0_0_ARCACHE,
      vec_rsc_0_0_ARLOCK, vec_rsc_0_0_ARBURST, vec_rsc_0_0_ARSIZE, vec_rsc_0_0_ARLEN,
      vec_rsc_0_0_ARADDR, vec_rsc_0_0_ARID, vec_rsc_0_0_BREADY, vec_rsc_0_0_BVALID,
      vec_rsc_0_0_BUSER, vec_rsc_0_0_BRESP, vec_rsc_0_0_BID, vec_rsc_0_0_WREADY,
      vec_rsc_0_0_WVALID, vec_rsc_0_0_WUSER, vec_rsc_0_0_WLAST, vec_rsc_0_0_WSTRB,
      vec_rsc_0_0_WDATA, vec_rsc_0_0_AWREADY, vec_rsc_0_0_AWVALID, vec_rsc_0_0_AWUSER,
      vec_rsc_0_0_AWREGION, vec_rsc_0_0_AWQOS, vec_rsc_0_0_AWPROT, vec_rsc_0_0_AWCACHE,
      vec_rsc_0_0_AWLOCK, vec_rsc_0_0_AWBURST, vec_rsc_0_0_AWSIZE, vec_rsc_0_0_AWLEN,
      vec_rsc_0_0_AWADDR, vec_rsc_0_0_AWID, vec_rsc_triosy_0_0_lz, vec_rsc_0_1_s_tdone,
      vec_rsc_0_1_tr_write_done, vec_rsc_0_1_RREADY, vec_rsc_0_1_RVALID, vec_rsc_0_1_RUSER,
      vec_rsc_0_1_RLAST, vec_rsc_0_1_RRESP, vec_rsc_0_1_RDATA, vec_rsc_0_1_RID, vec_rsc_0_1_ARREADY,
      vec_rsc_0_1_ARVALID, vec_rsc_0_1_ARUSER, vec_rsc_0_1_ARREGION, vec_rsc_0_1_ARQOS,
      vec_rsc_0_1_ARPROT, vec_rsc_0_1_ARCACHE, vec_rsc_0_1_ARLOCK, vec_rsc_0_1_ARBURST,
      vec_rsc_0_1_ARSIZE, vec_rsc_0_1_ARLEN, vec_rsc_0_1_ARADDR, vec_rsc_0_1_ARID,
      vec_rsc_0_1_BREADY, vec_rsc_0_1_BVALID, vec_rsc_0_1_BUSER, vec_rsc_0_1_BRESP,
      vec_rsc_0_1_BID, vec_rsc_0_1_WREADY, vec_rsc_0_1_WVALID, vec_rsc_0_1_WUSER,
      vec_rsc_0_1_WLAST, vec_rsc_0_1_WSTRB, vec_rsc_0_1_WDATA, vec_rsc_0_1_AWREADY,
      vec_rsc_0_1_AWVALID, vec_rsc_0_1_AWUSER, vec_rsc_0_1_AWREGION, vec_rsc_0_1_AWQOS,
      vec_rsc_0_1_AWPROT, vec_rsc_0_1_AWCACHE, vec_rsc_0_1_AWLOCK, vec_rsc_0_1_AWBURST,
      vec_rsc_0_1_AWSIZE, vec_rsc_0_1_AWLEN, vec_rsc_0_1_AWADDR, vec_rsc_0_1_AWID,
      vec_rsc_triosy_0_1_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz,
      twiddle_rsc_0_0_s_tdone, twiddle_rsc_0_0_tr_write_done, twiddle_rsc_0_0_RREADY,
      twiddle_rsc_0_0_RVALID, twiddle_rsc_0_0_RUSER, twiddle_rsc_0_0_RLAST, twiddle_rsc_0_0_RRESP,
      twiddle_rsc_0_0_RDATA, twiddle_rsc_0_0_RID, twiddle_rsc_0_0_ARREADY, twiddle_rsc_0_0_ARVALID,
      twiddle_rsc_0_0_ARUSER, twiddle_rsc_0_0_ARREGION, twiddle_rsc_0_0_ARQOS, twiddle_rsc_0_0_ARPROT,
      twiddle_rsc_0_0_ARCACHE, twiddle_rsc_0_0_ARLOCK, twiddle_rsc_0_0_ARBURST, twiddle_rsc_0_0_ARSIZE,
      twiddle_rsc_0_0_ARLEN, twiddle_rsc_0_0_ARADDR, twiddle_rsc_0_0_ARID, twiddle_rsc_0_0_BREADY,
      twiddle_rsc_0_0_BVALID, twiddle_rsc_0_0_BUSER, twiddle_rsc_0_0_BRESP, twiddle_rsc_0_0_BID,
      twiddle_rsc_0_0_WREADY, twiddle_rsc_0_0_WVALID, twiddle_rsc_0_0_WUSER, twiddle_rsc_0_0_WLAST,
      twiddle_rsc_0_0_WSTRB, twiddle_rsc_0_0_WDATA, twiddle_rsc_0_0_AWREADY, twiddle_rsc_0_0_AWVALID,
      twiddle_rsc_0_0_AWUSER, twiddle_rsc_0_0_AWREGION, twiddle_rsc_0_0_AWQOS, twiddle_rsc_0_0_AWPROT,
      twiddle_rsc_0_0_AWCACHE, twiddle_rsc_0_0_AWLOCK, twiddle_rsc_0_0_AWBURST, twiddle_rsc_0_0_AWSIZE,
      twiddle_rsc_0_0_AWLEN, twiddle_rsc_0_0_AWADDR, twiddle_rsc_0_0_AWID, twiddle_rsc_triosy_0_0_lz,
      twiddle_rsc_0_1_s_tdone, twiddle_rsc_0_1_tr_write_done, twiddle_rsc_0_1_RREADY,
      twiddle_rsc_0_1_RVALID, twiddle_rsc_0_1_RUSER, twiddle_rsc_0_1_RLAST, twiddle_rsc_0_1_RRESP,
      twiddle_rsc_0_1_RDATA, twiddle_rsc_0_1_RID, twiddle_rsc_0_1_ARREADY, twiddle_rsc_0_1_ARVALID,
      twiddle_rsc_0_1_ARUSER, twiddle_rsc_0_1_ARREGION, twiddle_rsc_0_1_ARQOS, twiddle_rsc_0_1_ARPROT,
      twiddle_rsc_0_1_ARCACHE, twiddle_rsc_0_1_ARLOCK, twiddle_rsc_0_1_ARBURST, twiddle_rsc_0_1_ARSIZE,
      twiddle_rsc_0_1_ARLEN, twiddle_rsc_0_1_ARADDR, twiddle_rsc_0_1_ARID, twiddle_rsc_0_1_BREADY,
      twiddle_rsc_0_1_BVALID, twiddle_rsc_0_1_BUSER, twiddle_rsc_0_1_BRESP, twiddle_rsc_0_1_BID,
      twiddle_rsc_0_1_WREADY, twiddle_rsc_0_1_WVALID, twiddle_rsc_0_1_WUSER, twiddle_rsc_0_1_WLAST,
      twiddle_rsc_0_1_WSTRB, twiddle_rsc_0_1_WDATA, twiddle_rsc_0_1_AWREADY, twiddle_rsc_0_1_AWVALID,
      twiddle_rsc_0_1_AWUSER, twiddle_rsc_0_1_AWREGION, twiddle_rsc_0_1_AWQOS, twiddle_rsc_0_1_AWPROT,
      twiddle_rsc_0_1_AWCACHE, twiddle_rsc_0_1_AWLOCK, twiddle_rsc_0_1_AWBURST, twiddle_rsc_0_1_AWSIZE,
      twiddle_rsc_0_1_AWLEN, twiddle_rsc_0_1_AWADDR, twiddle_rsc_0_1_AWID, twiddle_rsc_triosy_0_1_lz
);
  input clk;
  input rst;
  input vec_rsc_0_0_s_tdone;
  input vec_rsc_0_0_tr_write_done;
  input vec_rsc_0_0_RREADY;
  output vec_rsc_0_0_RVALID;
  output vec_rsc_0_0_RUSER;
  output vec_rsc_0_0_RLAST;
  output [1:0] vec_rsc_0_0_RRESP;
  output [63:0] vec_rsc_0_0_RDATA;
  output vec_rsc_0_0_RID;
  output vec_rsc_0_0_ARREADY;
  input vec_rsc_0_0_ARVALID;
  input vec_rsc_0_0_ARUSER;
  input [3:0] vec_rsc_0_0_ARREGION;
  input [3:0] vec_rsc_0_0_ARQOS;
  input [2:0] vec_rsc_0_0_ARPROT;
  input [3:0] vec_rsc_0_0_ARCACHE;
  input vec_rsc_0_0_ARLOCK;
  input [1:0] vec_rsc_0_0_ARBURST;
  input [2:0] vec_rsc_0_0_ARSIZE;
  input [7:0] vec_rsc_0_0_ARLEN;
  input [11:0] vec_rsc_0_0_ARADDR;
  input vec_rsc_0_0_ARID;
  input vec_rsc_0_0_BREADY;
  output vec_rsc_0_0_BVALID;
  output vec_rsc_0_0_BUSER;
  output [1:0] vec_rsc_0_0_BRESP;
  output vec_rsc_0_0_BID;
  output vec_rsc_0_0_WREADY;
  input vec_rsc_0_0_WVALID;
  input vec_rsc_0_0_WUSER;
  input vec_rsc_0_0_WLAST;
  input [7:0] vec_rsc_0_0_WSTRB;
  input [63:0] vec_rsc_0_0_WDATA;
  output vec_rsc_0_0_AWREADY;
  input vec_rsc_0_0_AWVALID;
  input vec_rsc_0_0_AWUSER;
  input [3:0] vec_rsc_0_0_AWREGION;
  input [3:0] vec_rsc_0_0_AWQOS;
  input [2:0] vec_rsc_0_0_AWPROT;
  input [3:0] vec_rsc_0_0_AWCACHE;
  input vec_rsc_0_0_AWLOCK;
  input [1:0] vec_rsc_0_0_AWBURST;
  input [2:0] vec_rsc_0_0_AWSIZE;
  input [7:0] vec_rsc_0_0_AWLEN;
  input [11:0] vec_rsc_0_0_AWADDR;
  input vec_rsc_0_0_AWID;
  output vec_rsc_triosy_0_0_lz;
  input vec_rsc_0_1_s_tdone;
  input vec_rsc_0_1_tr_write_done;
  input vec_rsc_0_1_RREADY;
  output vec_rsc_0_1_RVALID;
  output vec_rsc_0_1_RUSER;
  output vec_rsc_0_1_RLAST;
  output [1:0] vec_rsc_0_1_RRESP;
  output [63:0] vec_rsc_0_1_RDATA;
  output vec_rsc_0_1_RID;
  output vec_rsc_0_1_ARREADY;
  input vec_rsc_0_1_ARVALID;
  input vec_rsc_0_1_ARUSER;
  input [3:0] vec_rsc_0_1_ARREGION;
  input [3:0] vec_rsc_0_1_ARQOS;
  input [2:0] vec_rsc_0_1_ARPROT;
  input [3:0] vec_rsc_0_1_ARCACHE;
  input vec_rsc_0_1_ARLOCK;
  input [1:0] vec_rsc_0_1_ARBURST;
  input [2:0] vec_rsc_0_1_ARSIZE;
  input [7:0] vec_rsc_0_1_ARLEN;
  input [11:0] vec_rsc_0_1_ARADDR;
  input vec_rsc_0_1_ARID;
  input vec_rsc_0_1_BREADY;
  output vec_rsc_0_1_BVALID;
  output vec_rsc_0_1_BUSER;
  output [1:0] vec_rsc_0_1_BRESP;
  output vec_rsc_0_1_BID;
  output vec_rsc_0_1_WREADY;
  input vec_rsc_0_1_WVALID;
  input vec_rsc_0_1_WUSER;
  input vec_rsc_0_1_WLAST;
  input [7:0] vec_rsc_0_1_WSTRB;
  input [63:0] vec_rsc_0_1_WDATA;
  output vec_rsc_0_1_AWREADY;
  input vec_rsc_0_1_AWVALID;
  input vec_rsc_0_1_AWUSER;
  input [3:0] vec_rsc_0_1_AWREGION;
  input [3:0] vec_rsc_0_1_AWQOS;
  input [2:0] vec_rsc_0_1_AWPROT;
  input [3:0] vec_rsc_0_1_AWCACHE;
  input vec_rsc_0_1_AWLOCK;
  input [1:0] vec_rsc_0_1_AWBURST;
  input [2:0] vec_rsc_0_1_AWSIZE;
  input [7:0] vec_rsc_0_1_AWLEN;
  input [11:0] vec_rsc_0_1_AWADDR;
  input vec_rsc_0_1_AWID;
  output vec_rsc_triosy_0_1_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  input twiddle_rsc_0_0_s_tdone;
  input twiddle_rsc_0_0_tr_write_done;
  input twiddle_rsc_0_0_RREADY;
  output twiddle_rsc_0_0_RVALID;
  output twiddle_rsc_0_0_RUSER;
  output twiddle_rsc_0_0_RLAST;
  output [1:0] twiddle_rsc_0_0_RRESP;
  output [63:0] twiddle_rsc_0_0_RDATA;
  output twiddle_rsc_0_0_RID;
  output twiddle_rsc_0_0_ARREADY;
  input twiddle_rsc_0_0_ARVALID;
  input twiddle_rsc_0_0_ARUSER;
  input [3:0] twiddle_rsc_0_0_ARREGION;
  input [3:0] twiddle_rsc_0_0_ARQOS;
  input [2:0] twiddle_rsc_0_0_ARPROT;
  input [3:0] twiddle_rsc_0_0_ARCACHE;
  input twiddle_rsc_0_0_ARLOCK;
  input [1:0] twiddle_rsc_0_0_ARBURST;
  input [2:0] twiddle_rsc_0_0_ARSIZE;
  input [7:0] twiddle_rsc_0_0_ARLEN;
  input [11:0] twiddle_rsc_0_0_ARADDR;
  input twiddle_rsc_0_0_ARID;
  input twiddle_rsc_0_0_BREADY;
  output twiddle_rsc_0_0_BVALID;
  output twiddle_rsc_0_0_BUSER;
  output [1:0] twiddle_rsc_0_0_BRESP;
  output twiddle_rsc_0_0_BID;
  output twiddle_rsc_0_0_WREADY;
  input twiddle_rsc_0_0_WVALID;
  input twiddle_rsc_0_0_WUSER;
  input twiddle_rsc_0_0_WLAST;
  input [7:0] twiddle_rsc_0_0_WSTRB;
  input [63:0] twiddle_rsc_0_0_WDATA;
  output twiddle_rsc_0_0_AWREADY;
  input twiddle_rsc_0_0_AWVALID;
  input twiddle_rsc_0_0_AWUSER;
  input [3:0] twiddle_rsc_0_0_AWREGION;
  input [3:0] twiddle_rsc_0_0_AWQOS;
  input [2:0] twiddle_rsc_0_0_AWPROT;
  input [3:0] twiddle_rsc_0_0_AWCACHE;
  input twiddle_rsc_0_0_AWLOCK;
  input [1:0] twiddle_rsc_0_0_AWBURST;
  input [2:0] twiddle_rsc_0_0_AWSIZE;
  input [7:0] twiddle_rsc_0_0_AWLEN;
  input [11:0] twiddle_rsc_0_0_AWADDR;
  input twiddle_rsc_0_0_AWID;
  output twiddle_rsc_triosy_0_0_lz;
  input twiddle_rsc_0_1_s_tdone;
  input twiddle_rsc_0_1_tr_write_done;
  input twiddle_rsc_0_1_RREADY;
  output twiddle_rsc_0_1_RVALID;
  output twiddle_rsc_0_1_RUSER;
  output twiddle_rsc_0_1_RLAST;
  output [1:0] twiddle_rsc_0_1_RRESP;
  output [63:0] twiddle_rsc_0_1_RDATA;
  output twiddle_rsc_0_1_RID;
  output twiddle_rsc_0_1_ARREADY;
  input twiddle_rsc_0_1_ARVALID;
  input twiddle_rsc_0_1_ARUSER;
  input [3:0] twiddle_rsc_0_1_ARREGION;
  input [3:0] twiddle_rsc_0_1_ARQOS;
  input [2:0] twiddle_rsc_0_1_ARPROT;
  input [3:0] twiddle_rsc_0_1_ARCACHE;
  input twiddle_rsc_0_1_ARLOCK;
  input [1:0] twiddle_rsc_0_1_ARBURST;
  input [2:0] twiddle_rsc_0_1_ARSIZE;
  input [7:0] twiddle_rsc_0_1_ARLEN;
  input [11:0] twiddle_rsc_0_1_ARADDR;
  input twiddle_rsc_0_1_ARID;
  input twiddle_rsc_0_1_BREADY;
  output twiddle_rsc_0_1_BVALID;
  output twiddle_rsc_0_1_BUSER;
  output [1:0] twiddle_rsc_0_1_BRESP;
  output twiddle_rsc_0_1_BID;
  output twiddle_rsc_0_1_WREADY;
  input twiddle_rsc_0_1_WVALID;
  input twiddle_rsc_0_1_WUSER;
  input twiddle_rsc_0_1_WLAST;
  input [7:0] twiddle_rsc_0_1_WSTRB;
  input [63:0] twiddle_rsc_0_1_WDATA;
  output twiddle_rsc_0_1_AWREADY;
  input twiddle_rsc_0_1_AWVALID;
  input twiddle_rsc_0_1_AWUSER;
  input [3:0] twiddle_rsc_0_1_AWREGION;
  input [3:0] twiddle_rsc_0_1_AWQOS;
  input [2:0] twiddle_rsc_0_1_AWPROT;
  input [3:0] twiddle_rsc_0_1_AWCACHE;
  input twiddle_rsc_0_1_AWLOCK;
  input [1:0] twiddle_rsc_0_1_AWBURST;
  input [2:0] twiddle_rsc_0_1_AWSIZE;
  input [7:0] twiddle_rsc_0_1_AWLEN;
  input [11:0] twiddle_rsc_0_1_AWADDR;
  input twiddle_rsc_0_1_AWID;
  output twiddle_rsc_triosy_0_1_lz;



  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIT_precomp_core inPlaceNTT_DIT_precomp_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_0_s_tdone(vec_rsc_0_0_s_tdone),
      .vec_rsc_0_0_tr_write_done(vec_rsc_0_0_tr_write_done),
      .vec_rsc_0_0_RREADY(vec_rsc_0_0_RREADY),
      .vec_rsc_0_0_RVALID(vec_rsc_0_0_RVALID),
      .vec_rsc_0_0_RUSER(vec_rsc_0_0_RUSER),
      .vec_rsc_0_0_RLAST(vec_rsc_0_0_RLAST),
      .vec_rsc_0_0_RRESP(vec_rsc_0_0_RRESP),
      .vec_rsc_0_0_RDATA(vec_rsc_0_0_RDATA),
      .vec_rsc_0_0_RID(vec_rsc_0_0_RID),
      .vec_rsc_0_0_ARREADY(vec_rsc_0_0_ARREADY),
      .vec_rsc_0_0_ARVALID(vec_rsc_0_0_ARVALID),
      .vec_rsc_0_0_ARUSER(vec_rsc_0_0_ARUSER),
      .vec_rsc_0_0_ARREGION(vec_rsc_0_0_ARREGION),
      .vec_rsc_0_0_ARQOS(vec_rsc_0_0_ARQOS),
      .vec_rsc_0_0_ARPROT(vec_rsc_0_0_ARPROT),
      .vec_rsc_0_0_ARCACHE(vec_rsc_0_0_ARCACHE),
      .vec_rsc_0_0_ARLOCK(vec_rsc_0_0_ARLOCK),
      .vec_rsc_0_0_ARBURST(vec_rsc_0_0_ARBURST),
      .vec_rsc_0_0_ARSIZE(vec_rsc_0_0_ARSIZE),
      .vec_rsc_0_0_ARLEN(vec_rsc_0_0_ARLEN),
      .vec_rsc_0_0_ARADDR(vec_rsc_0_0_ARADDR),
      .vec_rsc_0_0_ARID(vec_rsc_0_0_ARID),
      .vec_rsc_0_0_BREADY(vec_rsc_0_0_BREADY),
      .vec_rsc_0_0_BVALID(vec_rsc_0_0_BVALID),
      .vec_rsc_0_0_BUSER(vec_rsc_0_0_BUSER),
      .vec_rsc_0_0_BRESP(vec_rsc_0_0_BRESP),
      .vec_rsc_0_0_BID(vec_rsc_0_0_BID),
      .vec_rsc_0_0_WREADY(vec_rsc_0_0_WREADY),
      .vec_rsc_0_0_WVALID(vec_rsc_0_0_WVALID),
      .vec_rsc_0_0_WUSER(vec_rsc_0_0_WUSER),
      .vec_rsc_0_0_WLAST(vec_rsc_0_0_WLAST),
      .vec_rsc_0_0_WSTRB(vec_rsc_0_0_WSTRB),
      .vec_rsc_0_0_WDATA(vec_rsc_0_0_WDATA),
      .vec_rsc_0_0_AWREADY(vec_rsc_0_0_AWREADY),
      .vec_rsc_0_0_AWVALID(vec_rsc_0_0_AWVALID),
      .vec_rsc_0_0_AWUSER(vec_rsc_0_0_AWUSER),
      .vec_rsc_0_0_AWREGION(vec_rsc_0_0_AWREGION),
      .vec_rsc_0_0_AWQOS(vec_rsc_0_0_AWQOS),
      .vec_rsc_0_0_AWPROT(vec_rsc_0_0_AWPROT),
      .vec_rsc_0_0_AWCACHE(vec_rsc_0_0_AWCACHE),
      .vec_rsc_0_0_AWLOCK(vec_rsc_0_0_AWLOCK),
      .vec_rsc_0_0_AWBURST(vec_rsc_0_0_AWBURST),
      .vec_rsc_0_0_AWSIZE(vec_rsc_0_0_AWSIZE),
      .vec_rsc_0_0_AWLEN(vec_rsc_0_0_AWLEN),
      .vec_rsc_0_0_AWADDR(vec_rsc_0_0_AWADDR),
      .vec_rsc_0_0_AWID(vec_rsc_0_0_AWID),
      .vec_rsc_triosy_0_0_lz(vec_rsc_triosy_0_0_lz),
      .vec_rsc_0_1_s_tdone(vec_rsc_0_1_s_tdone),
      .vec_rsc_0_1_tr_write_done(vec_rsc_0_1_tr_write_done),
      .vec_rsc_0_1_RREADY(vec_rsc_0_1_RREADY),
      .vec_rsc_0_1_RVALID(vec_rsc_0_1_RVALID),
      .vec_rsc_0_1_RUSER(vec_rsc_0_1_RUSER),
      .vec_rsc_0_1_RLAST(vec_rsc_0_1_RLAST),
      .vec_rsc_0_1_RRESP(vec_rsc_0_1_RRESP),
      .vec_rsc_0_1_RDATA(vec_rsc_0_1_RDATA),
      .vec_rsc_0_1_RID(vec_rsc_0_1_RID),
      .vec_rsc_0_1_ARREADY(vec_rsc_0_1_ARREADY),
      .vec_rsc_0_1_ARVALID(vec_rsc_0_1_ARVALID),
      .vec_rsc_0_1_ARUSER(vec_rsc_0_1_ARUSER),
      .vec_rsc_0_1_ARREGION(vec_rsc_0_1_ARREGION),
      .vec_rsc_0_1_ARQOS(vec_rsc_0_1_ARQOS),
      .vec_rsc_0_1_ARPROT(vec_rsc_0_1_ARPROT),
      .vec_rsc_0_1_ARCACHE(vec_rsc_0_1_ARCACHE),
      .vec_rsc_0_1_ARLOCK(vec_rsc_0_1_ARLOCK),
      .vec_rsc_0_1_ARBURST(vec_rsc_0_1_ARBURST),
      .vec_rsc_0_1_ARSIZE(vec_rsc_0_1_ARSIZE),
      .vec_rsc_0_1_ARLEN(vec_rsc_0_1_ARLEN),
      .vec_rsc_0_1_ARADDR(vec_rsc_0_1_ARADDR),
      .vec_rsc_0_1_ARID(vec_rsc_0_1_ARID),
      .vec_rsc_0_1_BREADY(vec_rsc_0_1_BREADY),
      .vec_rsc_0_1_BVALID(vec_rsc_0_1_BVALID),
      .vec_rsc_0_1_BUSER(vec_rsc_0_1_BUSER),
      .vec_rsc_0_1_BRESP(vec_rsc_0_1_BRESP),
      .vec_rsc_0_1_BID(vec_rsc_0_1_BID),
      .vec_rsc_0_1_WREADY(vec_rsc_0_1_WREADY),
      .vec_rsc_0_1_WVALID(vec_rsc_0_1_WVALID),
      .vec_rsc_0_1_WUSER(vec_rsc_0_1_WUSER),
      .vec_rsc_0_1_WLAST(vec_rsc_0_1_WLAST),
      .vec_rsc_0_1_WSTRB(vec_rsc_0_1_WSTRB),
      .vec_rsc_0_1_WDATA(vec_rsc_0_1_WDATA),
      .vec_rsc_0_1_AWREADY(vec_rsc_0_1_AWREADY),
      .vec_rsc_0_1_AWVALID(vec_rsc_0_1_AWVALID),
      .vec_rsc_0_1_AWUSER(vec_rsc_0_1_AWUSER),
      .vec_rsc_0_1_AWREGION(vec_rsc_0_1_AWREGION),
      .vec_rsc_0_1_AWQOS(vec_rsc_0_1_AWQOS),
      .vec_rsc_0_1_AWPROT(vec_rsc_0_1_AWPROT),
      .vec_rsc_0_1_AWCACHE(vec_rsc_0_1_AWCACHE),
      .vec_rsc_0_1_AWLOCK(vec_rsc_0_1_AWLOCK),
      .vec_rsc_0_1_AWBURST(vec_rsc_0_1_AWBURST),
      .vec_rsc_0_1_AWSIZE(vec_rsc_0_1_AWSIZE),
      .vec_rsc_0_1_AWLEN(vec_rsc_0_1_AWLEN),
      .vec_rsc_0_1_AWADDR(vec_rsc_0_1_AWADDR),
      .vec_rsc_0_1_AWID(vec_rsc_0_1_AWID),
      .vec_rsc_triosy_0_1_lz(vec_rsc_triosy_0_1_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_0_0_s_tdone(twiddle_rsc_0_0_s_tdone),
      .twiddle_rsc_0_0_tr_write_done(twiddle_rsc_0_0_tr_write_done),
      .twiddle_rsc_0_0_RREADY(twiddle_rsc_0_0_RREADY),
      .twiddle_rsc_0_0_RVALID(twiddle_rsc_0_0_RVALID),
      .twiddle_rsc_0_0_RUSER(twiddle_rsc_0_0_RUSER),
      .twiddle_rsc_0_0_RLAST(twiddle_rsc_0_0_RLAST),
      .twiddle_rsc_0_0_RRESP(twiddle_rsc_0_0_RRESP),
      .twiddle_rsc_0_0_RDATA(twiddle_rsc_0_0_RDATA),
      .twiddle_rsc_0_0_RID(twiddle_rsc_0_0_RID),
      .twiddle_rsc_0_0_ARREADY(twiddle_rsc_0_0_ARREADY),
      .twiddle_rsc_0_0_ARVALID(twiddle_rsc_0_0_ARVALID),
      .twiddle_rsc_0_0_ARUSER(twiddle_rsc_0_0_ARUSER),
      .twiddle_rsc_0_0_ARREGION(twiddle_rsc_0_0_ARREGION),
      .twiddle_rsc_0_0_ARQOS(twiddle_rsc_0_0_ARQOS),
      .twiddle_rsc_0_0_ARPROT(twiddle_rsc_0_0_ARPROT),
      .twiddle_rsc_0_0_ARCACHE(twiddle_rsc_0_0_ARCACHE),
      .twiddle_rsc_0_0_ARLOCK(twiddle_rsc_0_0_ARLOCK),
      .twiddle_rsc_0_0_ARBURST(twiddle_rsc_0_0_ARBURST),
      .twiddle_rsc_0_0_ARSIZE(twiddle_rsc_0_0_ARSIZE),
      .twiddle_rsc_0_0_ARLEN(twiddle_rsc_0_0_ARLEN),
      .twiddle_rsc_0_0_ARADDR(twiddle_rsc_0_0_ARADDR),
      .twiddle_rsc_0_0_ARID(twiddle_rsc_0_0_ARID),
      .twiddle_rsc_0_0_BREADY(twiddle_rsc_0_0_BREADY),
      .twiddle_rsc_0_0_BVALID(twiddle_rsc_0_0_BVALID),
      .twiddle_rsc_0_0_BUSER(twiddle_rsc_0_0_BUSER),
      .twiddle_rsc_0_0_BRESP(twiddle_rsc_0_0_BRESP),
      .twiddle_rsc_0_0_BID(twiddle_rsc_0_0_BID),
      .twiddle_rsc_0_0_WREADY(twiddle_rsc_0_0_WREADY),
      .twiddle_rsc_0_0_WVALID(twiddle_rsc_0_0_WVALID),
      .twiddle_rsc_0_0_WUSER(twiddle_rsc_0_0_WUSER),
      .twiddle_rsc_0_0_WLAST(twiddle_rsc_0_0_WLAST),
      .twiddle_rsc_0_0_WSTRB(twiddle_rsc_0_0_WSTRB),
      .twiddle_rsc_0_0_WDATA(twiddle_rsc_0_0_WDATA),
      .twiddle_rsc_0_0_AWREADY(twiddle_rsc_0_0_AWREADY),
      .twiddle_rsc_0_0_AWVALID(twiddle_rsc_0_0_AWVALID),
      .twiddle_rsc_0_0_AWUSER(twiddle_rsc_0_0_AWUSER),
      .twiddle_rsc_0_0_AWREGION(twiddle_rsc_0_0_AWREGION),
      .twiddle_rsc_0_0_AWQOS(twiddle_rsc_0_0_AWQOS),
      .twiddle_rsc_0_0_AWPROT(twiddle_rsc_0_0_AWPROT),
      .twiddle_rsc_0_0_AWCACHE(twiddle_rsc_0_0_AWCACHE),
      .twiddle_rsc_0_0_AWLOCK(twiddle_rsc_0_0_AWLOCK),
      .twiddle_rsc_0_0_AWBURST(twiddle_rsc_0_0_AWBURST),
      .twiddle_rsc_0_0_AWSIZE(twiddle_rsc_0_0_AWSIZE),
      .twiddle_rsc_0_0_AWLEN(twiddle_rsc_0_0_AWLEN),
      .twiddle_rsc_0_0_AWADDR(twiddle_rsc_0_0_AWADDR),
      .twiddle_rsc_0_0_AWID(twiddle_rsc_0_0_AWID),
      .twiddle_rsc_triosy_0_0_lz(twiddle_rsc_triosy_0_0_lz),
      .twiddle_rsc_0_1_s_tdone(twiddle_rsc_0_1_s_tdone),
      .twiddle_rsc_0_1_tr_write_done(twiddle_rsc_0_1_tr_write_done),
      .twiddle_rsc_0_1_RREADY(twiddle_rsc_0_1_RREADY),
      .twiddle_rsc_0_1_RVALID(twiddle_rsc_0_1_RVALID),
      .twiddle_rsc_0_1_RUSER(twiddle_rsc_0_1_RUSER),
      .twiddle_rsc_0_1_RLAST(twiddle_rsc_0_1_RLAST),
      .twiddle_rsc_0_1_RRESP(twiddle_rsc_0_1_RRESP),
      .twiddle_rsc_0_1_RDATA(twiddle_rsc_0_1_RDATA),
      .twiddle_rsc_0_1_RID(twiddle_rsc_0_1_RID),
      .twiddle_rsc_0_1_ARREADY(twiddle_rsc_0_1_ARREADY),
      .twiddle_rsc_0_1_ARVALID(twiddle_rsc_0_1_ARVALID),
      .twiddle_rsc_0_1_ARUSER(twiddle_rsc_0_1_ARUSER),
      .twiddle_rsc_0_1_ARREGION(twiddle_rsc_0_1_ARREGION),
      .twiddle_rsc_0_1_ARQOS(twiddle_rsc_0_1_ARQOS),
      .twiddle_rsc_0_1_ARPROT(twiddle_rsc_0_1_ARPROT),
      .twiddle_rsc_0_1_ARCACHE(twiddle_rsc_0_1_ARCACHE),
      .twiddle_rsc_0_1_ARLOCK(twiddle_rsc_0_1_ARLOCK),
      .twiddle_rsc_0_1_ARBURST(twiddle_rsc_0_1_ARBURST),
      .twiddle_rsc_0_1_ARSIZE(twiddle_rsc_0_1_ARSIZE),
      .twiddle_rsc_0_1_ARLEN(twiddle_rsc_0_1_ARLEN),
      .twiddle_rsc_0_1_ARADDR(twiddle_rsc_0_1_ARADDR),
      .twiddle_rsc_0_1_ARID(twiddle_rsc_0_1_ARID),
      .twiddle_rsc_0_1_BREADY(twiddle_rsc_0_1_BREADY),
      .twiddle_rsc_0_1_BVALID(twiddle_rsc_0_1_BVALID),
      .twiddle_rsc_0_1_BUSER(twiddle_rsc_0_1_BUSER),
      .twiddle_rsc_0_1_BRESP(twiddle_rsc_0_1_BRESP),
      .twiddle_rsc_0_1_BID(twiddle_rsc_0_1_BID),
      .twiddle_rsc_0_1_WREADY(twiddle_rsc_0_1_WREADY),
      .twiddle_rsc_0_1_WVALID(twiddle_rsc_0_1_WVALID),
      .twiddle_rsc_0_1_WUSER(twiddle_rsc_0_1_WUSER),
      .twiddle_rsc_0_1_WLAST(twiddle_rsc_0_1_WLAST),
      .twiddle_rsc_0_1_WSTRB(twiddle_rsc_0_1_WSTRB),
      .twiddle_rsc_0_1_WDATA(twiddle_rsc_0_1_WDATA),
      .twiddle_rsc_0_1_AWREADY(twiddle_rsc_0_1_AWREADY),
      .twiddle_rsc_0_1_AWVALID(twiddle_rsc_0_1_AWVALID),
      .twiddle_rsc_0_1_AWUSER(twiddle_rsc_0_1_AWUSER),
      .twiddle_rsc_0_1_AWREGION(twiddle_rsc_0_1_AWREGION),
      .twiddle_rsc_0_1_AWQOS(twiddle_rsc_0_1_AWQOS),
      .twiddle_rsc_0_1_AWPROT(twiddle_rsc_0_1_AWPROT),
      .twiddle_rsc_0_1_AWCACHE(twiddle_rsc_0_1_AWCACHE),
      .twiddle_rsc_0_1_AWLOCK(twiddle_rsc_0_1_AWLOCK),
      .twiddle_rsc_0_1_AWBURST(twiddle_rsc_0_1_AWBURST),
      .twiddle_rsc_0_1_AWSIZE(twiddle_rsc_0_1_AWSIZE),
      .twiddle_rsc_0_1_AWLEN(twiddle_rsc_0_1_AWLEN),
      .twiddle_rsc_0_1_AWADDR(twiddle_rsc_0_1_AWADDR),
      .twiddle_rsc_0_1_AWID(twiddle_rsc_0_1_AWID),
      .twiddle_rsc_triosy_0_1_lz(twiddle_rsc_triosy_0_1_lz)
    );
endmodule



