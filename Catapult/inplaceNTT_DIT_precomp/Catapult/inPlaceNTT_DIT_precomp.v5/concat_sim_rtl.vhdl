
--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/ccs_libs/interfaces/amba/amba_comps.vhd 
--//////////////////////////////////////////////////////////////////////////////
-- Catapult Synthesis - Custom Interfaces
--
-- Copyright (c) 2016 Mentor Graphics Corp.
--       All Rights Reserved
-- 
-- This document contains information that is proprietary to Mentor Graphics
-- Corp. The original recipient of this document may duplicate this  
-- document in whole or in part for internal business purposes only, provided  
-- that this entire notice appears in all copies. In duplicating any part of  
-- this document, the recipient agrees to make every reasonable effort to  
-- prevent the unauthorized use and distribution of the proprietary information.
-- 
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in prepartion for creating
-- their own custom interfaces. This design does not present a complete
-- implementation of the named protocol or standard.
--
-- NO WARRANTY.
-- MENTOR GRAPHICS CORP. EXPRESSLY DISCLAIMS ALL WARRANTY
-- FOR THE SOFTWARE. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE
-- LAW, THE SOFTWARE AND ANY RELATED DOCUMENTATION IS PROVIDED "AS IS"
-- AND WITH ALL FAULTS AND WITHOUT WARRANTIES OR CONDITIONS OF ANY
-- KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
-- PURPOSE, OR NONINFRINGEMENT. THE ENTIRE RISK ARISING OUT OF USE OR
-- DISTRIBUTION OF THE SOFTWARE REMAINS WITH YOU.
-- 
--//////////////////////////////////////////////////////////////////////////////

-- --------------------------------------------------------------------------
-- LIBRARY: amba
--
-- CONTENTS:
--    axi4stream_w_wire, axi4stream_r_wire, axi4svideo_w_wire, axi4svideo_r_wire
--      Catapult AXI-4 Stream bus definitions
--    ccs_axi4stream_in
--      AXI4-Streaming input interface
--    ccs_axi4stream_out
--      AXI4-Streaming output interface
--    ccs_axi4stream_pipe
--      AXI4-Streaming FIFO interconnect component
--    ccs_axi4svideo_in
--      AXI4-Streaming video input interface
--    ccs_axi4svideo_out
--      AXI4-Streaming video output interface
--    ccs_axi4svideo_pipe
--      AXI4-Streaming video FIFO interconnect component
--
--    axi4_busdef
--      Catapult AXI-4 bus definition
--
--    ccs_axi4_slave_mem
--      Catapult AXI-4 slave memory
---
--    ccs_axi4_master
--      Catapult AXI4 master interface for read/write data
--
--    apb_busdef
--      Catapult APB bus definition
--    apb_slave_mem
--      APB Slave Memory interface
--
-- CHANGE LOG:
--
--  10/01/16 - dgb - Initial implementation
--
-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- PACKAGE:     amba_comps
--
-- DESCRIPTION:
--   Contains component declarations for all design units in this file.
--
-- CHANGE LOG:
--
--  10/01/16 - dgb - Initial implementation
--
-- --------------------------------------------------------------------------

LIBRARY ieee;

   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_arith.all;
   USE ieee.std_logic_unsigned.all;

PACKAGE amba_comps IS

  -- ==============================================================
  -- AXI-4 Stream Components
  -- ------------------------------ TSTRB/TKEEP controls --------------------
  --    TKEEP   TSTRB   Data Type         Description
  --    high    high    Data byte         Valid data byte (supported in these models)
  --    high    low     Position byte     Byte is position not data/null (not supported)
  --    low     low     Null byte         Byte is null (not supported)
  --    low     high    Reserved          Do not use (not supported)

  COMPONENT axi4stream_w_wire -- slave interface pin direction
    GENERIC(
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 16;           -- AXI4 Bus width
      AXI4_USER_WIDTH  : INTEGER RANGE 1 TO 8 := 1                -- AXI4 User data width
    );
    PORT(
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : IN   std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : OUT  std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : IN   std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TLAST     : IN   std_logic;                                        -- M->S      Indicates boundary of a packet
      TUSER     : IN   std_logic_vector(AXI4_USER_WIDTH-1 downto 0)      -- M->S      Optional user-defined sideband data
    );
  END COMPONENT;

  COMPONENT axi4stream_r_wire -- master interface pin direction
    GENERIC(
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 16;           -- AXI4 Bus width
      AXI4_USER_WIDTH  : INTEGER RANGE 1 TO 8 := 1                -- AXI4 User data width
    );
    PORT(
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : OUT  std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : IN   std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : OUT  std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TLAST     : OUT  std_logic;                                        -- M->S      Indicates boundary of a packet
      TUSER     : OUT  std_logic_vector(AXI4_USER_WIDTH-1 downto 0)      -- M->S      Optional user-defined sideband data
    );
  END COMPONENT;

  COMPONENT axi4svideo_w_wire -- slave interface pin direction
    GENERIC(
      width            : INTEGER RANGE 3 TO 1024 := 33;           -- Catapult read/write operator width
      AXI4_DATA_WIDTH  : INTEGER                 := 16            -- AXI4 Bus width
    );
    PORT(
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : IN   std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : OUT  std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : IN   std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TUSER     : IN   std_logic;                                        -- M->S      Start of Frame
      TLAST     : IN   std_logic                                         -- M->S      End of Line
    );
  END COMPONENT;

  COMPONENT axi4svideo_r_wire -- master interface pin direction
    GENERIC(
      width            : INTEGER RANGE 3 TO 1024 := 33;           -- Catapult read/write operator width
      AXI4_DATA_WIDTH  : INTEGER                 := 16            -- AXI4 Bus width
    );
    PORT(
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : OUT  std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : IN   std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : OUT  std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TUSER     : OUT  std_logic;                                        -- M->S      Start of Frame
      TLAST     : OUT  std_logic                                         -- M->S      End of Line
    );
  END COMPONENT;

  COMPONENT ccs_axi4stream_in
    GENERIC(
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 32;           -- AXI4 Bus width
      AXI4_USER_WIDTH  : INTEGER RANGE 1 TO 8 := 1                -- AXI4 User data width
    );
    PORT(
      -- AXI-4 Master Clock/Reset
      ACLK      : IN   std_logic;                                        -- clk src   Rising edge clock
      ARESETn   : IN   std_logic;                                        -- rst src   Active LOW synchronous reset
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : IN   std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : OUT  std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : IN   std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TLAST     : IN   std_logic;                                        -- M->S      Indicates boundary of a packet
      TUSER     : IN   std_logic_vector(AXI4_USER_WIDTH-1 downto 0);     -- M->S      Optional user-defined sideband data
      -- Catapult interface (equiv to mgc_in_wire_wait)
      d         : OUT  std_logic_vector(width-1 downto 0);               -- d  - msb TLAST TUSER(...) TDATA(...) lsb
      vd        : OUT  std_logic;                                        -- vd - TVALID
      ld        : IN   std_logic                                         -- ld - TREADY
    );
  END COMPONENT;

  COMPONENT ccs_axi4stream_out
    GENERIC(
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 32;           -- AXI4 Bus width
      AXI4_USER_WIDTH  : INTEGER RANGE 1 TO 8 := 1                -- AXI4 User data width
    );
    PORT(
      -- AXI-4 Master Clock/Reset
      ACLK      : IN   std_logic;                                        -- clk src   Rising edge clock
      ARESETn   : IN   std_logic;                                        -- rst src   Active LOW synchronous reset
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : OUT  std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : IN   std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : OUT  std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TLAST     : OUT  std_logic;                                        -- M->S      Indicates boundary of a packet
      TUSER     : OUT  std_logic_vector(AXI4_USER_WIDTH-1 downto 0);     -- M->S      Optional user-defined sideband data
      -- Catapult interface (equiv to mgc_out_stdreg_wait)
      d         : IN   std_logic_vector(width-1 downto 0);               -- d  - msb TLAST TUSER(...) TDATA(...) lsb
      vd        : OUT  std_logic;                                        -- vd - TREADY
      ld        : IN   std_logic                                         -- ld - TVALID
    );
  END COMPONENT;

  -- This implementation currently does not work - the 'width' parameter is not configured properly
  COMPONENT ccs_axi4stream_pipe
    GENERIC(
      rscid            : INTEGER := 1;                            -- Resource ID from Catapult
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      fifo_sz          : INTEGER RANGE 0 TO 128 := 0;            -- Fifo size
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 32;           -- AXI4 Bus width
      AXI4_USER_WIDTH  : INTEGER RANGE 1 TO 8 := 1                -- AXI4 User data width
    );
    PORT(
      -- AXI-4 Master Clock/Reset
      ACLK      : IN   std_logic;                                          -- clk src   Rising edge clock
      ARESETn   : IN   std_logic;                                          -- rst src   Active LOW asynchronous reset
      -- AXI-4 Stream interface input                                      -- Src->Dst  Description
      sTVALID   : IN   std_logic;                                          -- M->S      Indicates master is driving a valid transfer
      sTREADY   : OUT  std_logic;                                          -- S->M      Indicates slave can accept a transfer
      sTDATA    : IN   std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);       -- M->S      Primary payload (width-1 must be multiple of 8)
      sTSTRB    : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 indicates data byte, 0 indicates position byte
      sTKEEP    : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 valid byte, 0 indicates null byte
      sTLAST    : IN   std_logic;                                          -- M->S      Indicates boundary of a packet
      sTUSER    : IN   std_logic_vector(AXI4_USER_WIDTH-1 downto 0);       -- M->S      Optional user-defined sideband data
      -- AXI-4 Stream interface output                                     -- Src->Dst  Description
      mTVALID   : OUT  std_logic;                                          -- M->S      Indicates master is driving a valid transfer
      mTREADY   : IN   std_logic;                                          -- S->M      Indicates slave can accept a transfer
      mTDATA    : OUT  std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);       -- M->S      Primary payload (width-1 must be multiple of 8)
      mTSTRB    : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 indicates data byte, 0 indicates position byte
      mTKEEP    : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 valid byte, 0 indicates null byte
      mTLAST    : OUT  std_logic;                                          -- M->S      Indicates boundary of a packet
      mTUSER    : OUT  std_logic_vector(AXI4_USER_WIDTH-1 downto 0)        -- M->S      Optional user-defined sideband data
    );
  END COMPONENT;

  COMPONENT ccs_axi4svideo_in
    GENERIC(
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 32            -- AXI4 Bus width
    );
    PORT(
      -- AXI-4 Master Clock/Reset
      ACLK      : IN   std_logic;                                        -- clk src   Rising edge clock
      ARESETn   : IN   std_logic;                                        -- rst src   Active LOW asynchronous reset
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : IN   std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : OUT  std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : IN   std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TLAST     : IN   std_logic;                                        -- M->S      End-of-line
      TUSER     : IN   std_logic;                                        -- M->S      Start-of-frame
      -- Catapult interface (equiv to mgc_in_wire_wait)
      d         : OUT  std_logic_vector(width-1 downto 0);               -- d  - msb TLAST TUSER TDATA(...) lsb
      vd        : OUT  std_logic;                                        -- vd - TVALID
      ld        : IN   std_logic                                         -- ld - TREADY
    );
  END COMPONENT;

  COMPONENT ccs_axi4svideo_out
    GENERIC(
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 32            -- AXI4 Bus width
    );
    PORT(
      -- AXI-4 Master Clock/Reset
      ACLK      : IN   std_logic;                                        -- clk src   Rising edge clock
      ARESETn   : IN   std_logic;                                        -- rst src   Active LOW asynchronous reset
      -- AXI-4 Stream interface                                          -- Src->Dst  Description
      TVALID    : OUT  std_logic;                                        -- M->S      Indicates master is driving a valid transfer
      TREADY    : IN   std_logic;                                        -- S->M      Indicates slave can accept a transfer
      TDATA     : OUT  std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);     -- M->S      Primary payload (width-1 must be multiple of 8)
      TSTRB     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 indicates data byte, 0 indicates position byte
      TKEEP     : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0); -- M->S      1 valid byte, 0 indicates null byte
      TLAST     : OUT  std_logic;                                        -- M->S      End-of-line
      TUSER     : OUT  std_logic;                                        -- M->S      Start-of-frame
      -- Catapult interface (equiv to mgc_out_stdreg_wait)
      d         : IN   std_logic_vector(width-1 downto 0);               -- d  - msb TLAST TUSER TDATA(...) lsb
      vd        : OUT  std_logic;                                        -- vd - TREADY
      ld        : IN   std_logic                                         -- ld - TVALID
    );
  END COMPONENT;

  COMPONENT ccs_axi4svideo_pipe
    GENERIC(
      rscid            : INTEGER := 1;                                 -- Resource ID from Catapult
      width            : INTEGER RANGE 3 TO 1026 := 33;           -- Catapult read/write operator width (includes data,last and user bits)
      fifo_sz          : INTEGER RANGE 0 TO 128 := 0;            -- Fifo size
      AXI4_DATA_WIDTH  : INTEGER RANGE 8 TO 1024 := 32            -- AXI4 Bus width
    );
    PORT(
      -- AXI-4 Master Clock/Reset
      ACLK      : IN   std_logic;                                          -- clk src   Rising edge clock
      ARESETn   : IN   std_logic;                                          -- rst src   Active LOW asynchronous reset
      -- AXI-4 Stream interface input                                      -- Src->Dst  Description
      sTVALID   : IN   std_logic;                                          -- M->S      Indicates master is driving a valid transfer
      sTREADY   : OUT  std_logic;                                          -- S->M      Indicates slave can accept a transfer
      sTDATA    : IN   std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);       -- M->S      Primary payload (width-1 must be multiple of 8)
      sTSTRB    : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 indicates data byte, 0 indicates position byte
      sTKEEP    : IN   std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 valid byte, 0 indicates null byte
      sTLAST    : IN   std_logic;                                          -- M->S      End-of-line
      sTUSER    : IN   std_logic;                                          -- M->S      Start-of-frame
      -- AXI-4 Stream interface output                                     -- Src->Dst  Description
      mTVALID   : OUT  std_logic;                                          -- M->S      Indicates master is driving a valid transfer
      mTREADY   : IN   std_logic;                                          -- S->M      Indicates slave can accept a transfer
      mTDATA    : OUT  std_logic_vector(AXI4_DATA_WIDTH-1 downto 0);       -- M->S      Primary payload (width-1 must be multiple of 8)
      mTSTRB    : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 indicates data byte, 0 indicates position byte
      mTKEEP    : OUT  std_logic_vector((AXI4_DATA_WIDTH/8)-1 downto 0);   -- M->S      1 valid byte, 0 indicates null byte
      mTLAST    : OUT  std_logic;                                          -- M->S      End-of-line
      mTUSER    : OUT  std_logic                                           -- M->S      Start-of-frame
    );
  END COMPONENT;

  -- ==============================================================
  -- AXI-4 Bus Components

  -- Used to define the AXI-4 bus definition (direction of signals is from the slave's perspective)
    -- Pin directions are based on the usage of this busdef as a "master" driving an input slave.
    -- To use the bus in the reverse direction set the interface to "slave".
  COMPONENT axi4_busdef -- 
    GENERIC(   
      host_tidw      : INTEGER RANGE 1 TO 11 := 4;            -- Width of transaction ID fields
      host_userw     : INTEGER RANGE 1 TO 16 := 4;            -- Width of user-defined signals
      ADDR_WIDTH     : INTEGER RANGE 1 TO 64 := 32;           -- Host address width
      DATA_WIDTH     : INTEGER RANGE 8 TO 64 := 8             -- Host data width
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                 -- Rising edge clock
      ARESETn    : IN   std_logic;                                 -- Active LOW synchronous reset

      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(host_tidw-1 downto 0);    -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);      -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);              -- Write burst length    - must always be 0 in AXI4-Lite
      AWSIZE     : OUT  std_logic_vector(1 downto 0);              -- Write burst size      - must equal host_dw_bytes-2
      AWBURST    : OUT  std_logic_vector(1 downto 0);              -- Write burst mode      - must always be 0 (fixed mode) in AXI4-Lite
      AWLOCK     : OUT  std_logic;                                 -- Lock type             - must always be 0 (Normal access) in AXI4-Lite
      AWCACHE    : OUT  std_logic_vector(3 downto 0);              -- Memory type           - must always be 0 (Non-modifiable, Non-bufferable) in AXI4-Lite
      AWPROT     : OUT  std_logic_vector(2 downto 0);              -- Protection Type       - ignored in this model
      AWQOS      : OUT  std_logic_vector(3 downto 0);              -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);              -- Region identifier
      AWUSER     : OUT  std_logic_vector(host_userw-1 downto 0);   -- User signal
      AWVALID    : OUT  std_logic;                                 -- Write address valid
      AWREADY    : IN   std_logic;                                 -- Write address ready (slave is ready to accept AWADDR)
      
      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0); -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise) - ignored in AXI-4 Lite
      WLAST      : OUT  std_logic;                                        -- Write last
      WUSER      : OUT  std_logic_vector(host_userw-1 downto 0);          -- User signal
      WVALID     : OUT  std_logic;                                        -- Write data is valid
      WREADY     : IN   std_logic;                                        -- Write ready (slave is ready to accept WDATA)
      
      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(host_tidw-1 downto 0);    -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);              -- Write response (of slave) - only OKAY, SLVERR, DECERR supported in AXI-4 Lite
      BUSER      : IN   std_logic_vector(host_userw-1 downto 0);   -- User signal
      BVALID     : IN   std_logic;                                 -- Write response valid (slave accepted WDATA)
      BREADY     : OUT  std_logic;                                 -- Response ready (master can accept slave's write response)
      
      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(host_tidw-1 downto 0);    -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);      -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);              -- Read burst length     - must always be 0 in AXI4-Lite
      ARSIZE     : OUT  std_logic_vector(1 downto 0);              -- Read burst size       - must equal host_dw_bytes-2
      ARBURST    : OUT  std_logic_vector(1 downto 0);              -- Read burst mode       - must always be 0 (fixed mode) in AXI4-Lite
      ARLOCK     : OUT  std_logic;                                 -- Lock type             - must always be 0 (Normal access) in AXI4-Lite
      ARCACHE    : OUT  std_logic_vector(3 downto 0);              -- Memory type           - must always be 0 (Non-modifiable, Non-bufferable) in AXI4-Lite
      ARPROT     : OUT  std_logic_vector(2 downto 0);              -- Protection Type       - ignored in this model
      ARQOS      : OUT  std_logic_vector(3 downto 0);              -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);              -- Region identifier
      ARUSER     : OUT  std_logic_vector(host_userw-1 downto 0);   -- User signal
      ARVALID    : OUT  std_logic;                                 -- Read address valid
      ARREADY    : IN   std_logic;                                 -- Read address ready (slave is ready to accept ARADDR)
      
      -- ============== AXI4 Read Data Channel Signals
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0); -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                      -- Read response (of slave) - only OKAY, SLVERR, DECERR supported in AXI-4 Lite
      RVALID     : IN   std_logic;                                         -- Read valid (slave providing RDATA)
      RREADY     : OUT  std_logic;                                         -- Read ready (master ready to receive RDATA)
      RID        : OUT  std_logic_vector(host_tidw-1 downto 0);            -- Read ID tag
      RLAST      : IN   std_logic;                                         -- Read last
      RUSER      : IN   std_logic_vector(host_userw-1 downto 0)            -- User signal
    );
  END COMPONENT;

  -- AXI4 Lite GPIO with CDC
  COMPONENT ccs_axi4_lite_slave_cdc
    GENERIC(
      rscid          : INTEGER               := 1;            -- Required resource ID parameter
      op_width       : INTEGER RANGE 1 TO 64 := 1;            -- Operator width (dummy parameter)
      cwidth         : INTEGER RANGE 1 TO 256 := 32;          -- Internal register width
      nopreload      : INTEGER RANGE 0 TO 1 := 0;             -- 1=disable required preload before Catapult can read
      ADDR_WIDTH     : INTEGER RANGE 12 TO 32 := 32;          -- AXI4-Lite host address width
      DATA_WIDTH     : INTEGER RANGE 32 TO 64 := 32           -- AXI4-Lite host data width (must be 32 or 64)
    );
    PORT(
      -- AXI-4 Lite Interface
      ACLK       : IN   std_logic;                                 -- AXI-4 Bus Clock - Rising edge
      ARESETn    : IN   std_logic;                                 -- Active LOW synchronous reset
      -- ============== AXI4-Lite Write Address Channel Signals
      AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);               -- Write address
      AWVALID    : IN   std_logic;                                          -- Write address valid
      AWREADY    : OUT  std_logic;                                          -- Write address ready (slave is ready to accept AWADDR)
      -- ============== AXI4-Lite Write Data Channel
      WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0); -- Write data
      WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise) - ignored in AXI-4 Lite
      WVALID     : IN   std_logic;                                          -- Write data is valid
      WREADY     : OUT  std_logic;                                          -- Write ready (slave is ready to accept WDATA)
      -- ============== AXI4-Lite Write Response Channel Signals
      BRESP      : OUT  std_logic_vector(1 downto 0);                       -- Write response (of slave) - only OKAY, SLVERR, DECERR supported in AXI-4 Lite
      BVALID     : OUT  std_logic;                                          -- Write response valid (slave accepted WDATA)
      BREADY     : IN   std_logic;                                          -- Response ready (master can accept slave's write response)
      -- ============== AXI4-Lite Read Address Channel Signals
      ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);               -- Read address
      ARVALID    : IN   std_logic;                                          -- Read address valid
      ARREADY    : OUT  std_logic;                                          -- Read address ready (slave is ready to accept ARADDR)
      -- ============== AXI4-Lite Read Data Channel Signals
      RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0); -- Read data
      RRESP      : OUT  std_logic_vector(1 downto 0);                       -- Read response (of slave) - only OKAY, SLVERR, DECERR supported in AXI-4 Lite
      RVALID     : OUT  std_logic;                                          -- Read valid (slave providing RDATA)
      RREADY     : IN   std_logic;                                          -- Read ready (master ready to receive RDATA)

      -- Catapult interface assuming sidebyside packing 
      clk        : IN   std_logic;                                     -- Catapult Clock
      arst_n     : IN   std_logic;                                     -- Reset
--    d_from_ccs : IN   std_logic_vector(cwidth-1 downto 0);           -- Data out of Catapult block
--    d_from_vld : IN   std_logic;                                     -- Data out is valid
      d_to_ccs   : OUT  std_logic_vector(cwidth-1 downto 0)            -- Data into Catapult bloc
    );
  END COMPONENT;

  
  -- AXI4 Lite Slave Output
  COMPONENT ccs_axi4_lite_slave_out
    GENERIC(
      rscid          : INTEGER               := 1;            -- Required resource ID parameter
      op_width       : INTEGER RANGE 1 TO 64 := 1;            -- Operator width (dummy parameter)
      cwidth         : INTEGER RANGE 1 TO 256 := 32;          -- Internal register width
      nopreload      : INTEGER RANGE 0 TO 1 := 0;             -- 1=disable required preload before Catapult can read
      ADDR_WIDTH     : INTEGER RANGE 12 TO 32 := 32;          -- AXI4-Lite host address width
      DATA_WIDTH     : INTEGER RANGE 32 TO 64 := 32           -- AXI4-Lite host data width (must be 32 or 64)
    );
    PORT(
      -- AXI-4 Lite Interface
      ACLK       : IN   std_logic;                                     -- AXI-4 Bus Clock - Rising edge
      ARESETn    : IN   std_logic;                                     -- Active LOW synchronous reset
      -- ============== AXI4-Lite Write Address Channel Signals
      AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Write address
      AWVALID    : IN   std_logic;                                     -- Write address valid
      AWREADY    : OUT  std_logic;                                     -- Write address ready (slave is ready to accept AWADDR)
      --AWLEN      : IN   std_logic_vector(7 downto 0);                -- Write burst length    - must always be 0 in AXI4-Lite
      --AWSIZE     : IN   std_logic_vector(1 downto 0);                -- Write burst size      - must equal host_dw_bytes-2
      --AWBURST    : IN   std_logic_vector(1 downto 0);                -- Write burst mode      - must always be 0 (fixed mode) in AXI4-Lite
      --AWLOCK     : IN   std_logic;                                   -- Lock type             - must always be 0 (Normal access) in AXI4-Lite
      --AWCACHE    : IN   std_logic_vector(3 downto 0);                -- Memory type           - must always be 0 (Non-modifiable, Non-bufferable) in AXI4-Lite
      --AWPROT     : IN   std_logic_vector(2 downto 0);                -- Protection Type       - ignored in this model
      -- ============== AXI4-Lite Write Data Channel
      WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);       -- Write data
      WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise) - ignored in AXI-4 Lite
      WVALID     : IN   std_logic;                                     -- Write data is valid
      WREADY     : OUT  std_logic;                                     -- Write ready (slave is ready to accept WDATA)
      -- ============== AXI4-Lite Write Response Channel Signals
      BRESP      : OUT  std_logic_vector(1 downto 0);                  -- Write response (of slave) - only OKAY, SLVERR, DECERR supported in AXI-4 Lite
      BVALID     : OUT  std_logic;                                     -- Write response valid (slave accepted WDATA)
      BREADY     : IN   std_logic;                                     -- Response ready (master can accept slave's write response)
      -- ============== AXI4-Lite Read Address Channel Signals
      ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Read address
      ARVALID    : IN   std_logic;                                     -- Read address valid
      ARREADY    : OUT  std_logic;                                     -- Read address ready (slave is ready to accept ARADDR)
      --ARLEN      : IN   std_logic_vector(7 downto 0);                -- Read burst length     - must always be 0 in AXI4-Lite
      --ARSIZE     : IN   std_logic_vector(1 downto 0);                -- Read burst size       - must equal host_dw_bytes-2
      --ARBURST    : IN   std_logic_vector(1 downto 0);                -- Read burst mode       - must always be 0 (fixed mode) in AXI4-Lite
      --ARLOCK     : IN   std_logic;                                   -- Lock type             - must always be 0 (Normal access) in AXI4-Lite
      --ARCACHE    : IN   std_logic_vector(3 downto 0);                -- Memory type           - must always be 0 (Non-modifiable, Non-bufferable) in AXI4-Lite
      --ARPROT     : IN   std_logic_vector(2 downto 0);                -- Protection Type       - ignored in this model
      -- ============== AXI4-Lite Read Data Channel Signals
      RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);       -- Read data
      RRESP      : OUT  std_logic_vector(1 downto 0);                  -- Read response (of slave) - only OKAY, SLVERR, DECERR supported in AXI-4 Lite
      RVALID     : OUT  std_logic;                                     -- Read valid (slave providing RDATA)
      RREADY     : IN   std_logic;                                     -- Read ready (master ready to receive RDATA)

      -- Catapult interface assuming sidebyside packing 
      d_from_ccs : IN   std_logic_vector(cwidth-1 downto 0);           -- Data out of Catapult block
      d_from_vld : IN   std_logic                                      -- Data out is valid
--    d_to_ccs   : OUT  std_logic_vector(cwidth-1 downto 0)            -- Data into Catapult bloc
    );
  END COMPONENT;

  COMPONENT ccs_axi4_slave_mem
    GENERIC(
      rscid           : integer                 := 1;    -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;   -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;    -- dummy parameter for cwidth calculation
      cwidth          : integer range 1 to 1024 := 8;    -- Internal memory data width
      addr_w          : integer range 1 to 64   := 4;    -- Catapult address bus widths
      nopreload       : integer range 0 to 1    := 0;    -- 1= no preload before Catapult can read
      rst_ph          : integer range 0 to 1    := 0;    -- Reset phase.  1= Positive edge. Default is AXI negative edge
      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;   -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;   -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;    -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;    -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;    -- AXI4 Region Map (ignored in this model)
      wBASE_ADDRESS   : integer                 := 0;    -- AXI4 write channel base address alignment based on data bus width
      rBASE_ADDRESS   : integer                 := 0     -- AXI4 read channel base address alignment based on data bus width
     );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                     -- Rising edge clock
      ARESETn    : IN   std_logic;                                     -- Active LOW asynchronous reset

      -- ============== AXI4 Write Address Channel Signals
      AWID       : IN   std_logic_vector(ID_WIDTH-1 downto 0);         -- Write address ID
      AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Write address
      AWLEN      : IN   std_logic_vector(7 downto 0);                  -- Write burst length
      AWSIZE     : IN   std_logic_vector(2 downto 0);                  -- Write burst size
      AWBURST    : IN   std_logic_vector(1 downto 0);                  -- Write burst mode
      AWLOCK     : IN   std_logic;                                     -- Lock type
      AWCACHE    : IN   std_logic_vector(3 downto 0);                  -- Memory type
      AWPROT     : IN   std_logic_vector(2 downto 0);                  -- Protection Type
      AWQOS      : IN   std_logic_vector(3 downto 0);                  -- Quality of Service
      AWREGION   : IN   std_logic_vector(3 downto 0);                  -- Region identifier
      AWUSER     : IN   std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
      AWVALID    : IN   std_logic;                                     -- Write address valid
      AWREADY    : OUT  std_logic;                                     -- Write address ready (slave is ready to accept AWADDR)

      -- ============== AXI4 Write Data Channel
      WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);       -- Write data
      WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise)
      WLAST      : IN   std_logic;                                     -- Write last
      WUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
      WVALID     : IN   std_logic;                                     -- Write data is valid
      WREADY     : OUT  std_logic;                                     -- Write ready (slave is ready to accept WDATA)
      
      -- ============== AXI4 Write Response Channel Signals
      BID        : OUT  std_logic_vector(ID_WIDTH-1 downto 0);         -- Response ID tag
      BRESP      : OUT  std_logic_vector(1 downto 0);                  -- Write response (of slave)
      BUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
      BVALID     : OUT  std_logic;                                     -- Write response valid (slave accepted WDATA)
      BREADY     : IN   std_logic;                                     -- Response ready (master can accept slave's write response)
      
      -- ============== AXI4 Read Address Channel Signals
      ARID       : IN   std_logic_vector(ID_WIDTH-1 downto 0);         -- Read address ID
      ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Read address
      ARLEN      : IN   std_logic_vector(7 downto 0);                  -- Read burst length
      ARSIZE     : IN   std_logic_vector(2 downto 0);                  -- Read burst size
      ARBURST    : IN   std_logic_vector(1 downto 0);                  -- Read burst mode
      ARLOCK     : IN   std_logic;                                     -- Lock type
      ARCACHE    : IN   std_logic_vector(3 downto 0);                  -- Memory type
      ARPROT     : IN   std_logic_vector(2 downto 0);                  -- Protection Type
      ARQOS      : IN   std_logic_vector(3 downto 0);                  -- Quality of Service
      ARREGION   : IN   std_logic_vector(3 downto 0);                  -- Region identifier
      ARUSER     : IN   std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
      ARVALID    : IN   std_logic;                                     -- Read address valid
      ARREADY    : OUT  std_logic;                                     -- Read address ready (slave is ready to accept ARADDR)
      
      -- ============== AXI4 Read Data Channel Signals
      RID        : OUT  std_logic_vector(ID_WIDTH-1 downto 0);         -- Read ID tag
      RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);       -- Read data
      RRESP      : OUT  std_logic_vector(1 downto 0);                  -- Read response (of slave)
      RLAST      : OUT  std_logic;                                     -- Read last
      RUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
      RVALID     : OUT  std_logic;                                     -- Read valid (slave providing RDATA)
      RREADY     : IN   std_logic;                                     -- Read ready (master ready to receive RDATA)
      
      -- Catapult interface
      s_re      : IN   std_logic;                                      -- Catapult attempting read of slave memory
      s_we      : IN   std_logic;                                      -- Catapult attempting write to slave memory
      s_raddr   : IN   std_logic_vector(addr_w-1 downto 0);            -- Catapult addressing into memory (axi_addr = base_addr + s_raddr)
      s_waddr   : IN   std_logic_vector(addr_w-1 downto 0);            -- Catapult addressing into memory (axi_addr = base_addr + s_waddr)
      s_din     : OUT  std_logic_vector(cwidth-1 downto 0);            -- Data into catapult block through this interface
      s_dout    : IN   std_logic_vector(cwidth-1 downto 0);            -- Data out to slave from catapult
      s_rrdy    : OUT  std_logic;                                      -- Read data is valid
      s_wrdy    : OUT  std_logic;                                      -- Slave memory ready for write by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                      -- component is idle - clock can be suppressed
      tr_write_done : IN std_logic;                                    -- transactor resource preload write done
      s_tdone   : IN   std_logic                                       -- Transaction_done in scverify
    );  
  END COMPONENT;

  COMPONENT ccs_axi4_master_read_core
    GENERIC(
      rscid           : integer                 := 1;      -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;     -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 1 to 64   := 4;      -- Catapult address bus width
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      xburstsize      : integer                 := 0;      -- Burst size for scverify transactor
      xBASE_ADDRESS   : integer                 := 0;      -- Base address for scverify transactor
      xBASE_ADDRESSU  : integer                 := 0       -- Upper word for 64-bit Base address for scverify transactor
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset
      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready
      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- Configuration interface
      cfgBaseAddress : IN  std_logic_vector(ADDR_WIDTH-1 downto 0);  
      cfgBurstSize   : IN  std_logic_vector(31 downto 0);            
      cfgTimeout     : IN  std_logic_vector(31 downto 0);            

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_raddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for read request (axi_addr = base_addr + m_raddr)
      m_rburst  : IN   std_logic_vector(31 downto 0);                   -- Read Burst length (constant rburstsize for now, future enhancement driven by operator)
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic                                        -- The component is idle. The next clk can be suppressed
    );
  END COMPONENT;
  
  COMPONENT ccs_axi4_master_read
    GENERIC(
      rscid           : integer                 := 1;      -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;     -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 1 to 64   := 4;      -- Catapult address bus width
      burstsize       : integer                 := 0;      -- Catapult configuration option for Read burst size
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      timeout         : integer                 := 0;      --  #cycles timeout for burst stall

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      BASE_ADDRESS    : integer                 := 0;      -- Base address 
      BASE_ADDRESSU   : integer                 := 0       -- Upper word for 64-bit Base address 
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset
      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready
      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_raddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for read request (axi_addr = base_addr + m_raddr)
      m_rburst  : IN   std_logic_vector(31 downto 0);                   -- Read Burst length (constant rburstsize for now, future enhancement driven by operator)
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic                                        -- The component is idle. The next clk can be suppressed
    );
  END COMPONENT;
  
  COMPONENT ccs_axi4_master_write_core
    GENERIC(
      rscid           : integer                 := 1;      -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;     -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 1 to 64   := 4;      -- Catapult address bus width
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      xburstsize      : integer                 := 0;      -- Burst size for scverify transactor
      xBASE_ADDRESS   : integer                 := 0;      -- Base address for scverify transactor
      xBASE_ADDRESSU  : integer                 := 0       -- Upper word for 64-bit Base address for scverify transactor
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset

      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);                   -- Write burst length
      AWSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Write burst size
      AWBURST    : OUT  std_logic_vector(1 downto 0);                   -- Write burst mode
      AWLOCK     : OUT  std_logic;                                      -- Lock type
      AWCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      AWPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      AWQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      AWUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      AWVALID    : OUT  std_logic;                                      -- Write address valid
      AWREADY    : IN   std_logic;                                      -- Write address ready

      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);        -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);    -- Write strobe (bytewise)
      WLAST      : OUT  std_logic;                                      -- Write last
      WUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      WVALID     : OUT  std_logic;                                      -- Write data is valid
      WREADY     : IN   std_logic;                                      -- Write ready

      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);                   -- Write response
      BUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      BVALID     : IN   std_logic;                                      -- Write response valid
      BREADY     : OUT  std_logic;                                      -- Response ready

      -- Configuration interface
      cfgBaseAddress : IN  std_logic_vector(ADDR_WIDTH-1 downto 0);  
      cfgBurstSize   : IN  std_logic_vector(31 downto 0);            
      cfgTimeout     : IN  std_logic_vector(31 downto 0);            

      -- Catapult interface
      m_we      : IN   std_logic;                                       -- Catapult attempting write to memory over bus
      m_waddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for write request (axi_addr = base_addr + m_waddr)
      m_wburst  : IN   std_logic_vector(31 downto 0);                   -- Write Burst length (constant wburstsize for now, future enhancement driven by operator)
      m_dout    : IN   std_logic_vector(cwidth-1 downto 0);             -- Data out to bus from catapult (write request)
      m_wrdy    : OUT  std_logic;                                       -- Bus memory ready for write access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      -- Transactor resource interface (for SCVerify simulation only)
      m_wCaughtUp : OUT  std_logic;                                     -- wburst_in == wburst_out
      m_wstate    : OUT  std_logic_vector(2 downto 0)                   -- write_state of master
    );
  END COMPONENT;
  
  COMPONENT ccs_axi4_master_write
    GENERIC(
      rscid           : integer                 := 1;      -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;     -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 1 to 64   := 4;      -- Catapult address bus width
      burstsize       : integer                 := 0;      -- Catapult configuration option for write burst size
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      timeout         : integer                 := 0;      --  #cycles timeout for burst stall

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      BASE_ADDRESS    : integer                 := 0;      -- Base address
      BASE_ADDRESSU   : integer                 := 0       -- Upper word for 64-bit Base address
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset

      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);                   -- Write burst length
      AWSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Write burst size
      AWBURST    : OUT  std_logic_vector(1 downto 0);                   -- Write burst mode
      AWLOCK     : OUT  std_logic;                                      -- Lock type
      AWCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      AWPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      AWQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      AWUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      AWVALID    : OUT  std_logic;                                      -- Write address valid
      AWREADY    : IN   std_logic;                                      -- Write address ready

      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);        -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);    -- Write strobe (bytewise)
      WLAST      : OUT  std_logic;                                      -- Write last
      WUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      WVALID     : OUT  std_logic;                                      -- Write data is valid
      WREADY     : IN   std_logic;                                      -- Write ready

      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);                   -- Write response
      BUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      BVALID     : IN   std_logic;                                      -- Write response valid
      BREADY     : OUT  std_logic;                                      -- Response ready

      -- Catapult interface
      m_we      : IN   std_logic;                                       -- Catapult attempting write to memory over bus
      m_waddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for write request (axi_addr = base_addr + m_waddr)
      m_wburst  : IN   std_logic_vector(31 downto 0);                   -- Write Burst length (constant wburstsize for now, future enhancement driven by operator)
      m_dout    : IN   std_logic_vector(cwidth-1 downto 0);             -- Data out to bus from catapult (write request)
      m_wrdy    : OUT  std_logic;                                       -- Bus memory ready for write access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      -- Transactor resource interface (for SCVerify simulation only)
      m_wCaughtUp : OUT  std_logic;                                     -- wburst_in == wburst_out
      m_wstate    : OUT  std_logic_vector(2 downto 0)                   -- write_state of master
    );
  END COMPONENT;
  
  COMPONENT ccs_axi4_master_core
    GENERIC(
      rscid           : integer                 := 1;      -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;     -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 1 to 64   := 4;      -- Catapult address bus width
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      xwburstsize     : integer                 := 0;      -- wBurst size for scverify transactor
      xrburstsize     : integer                 := 0;      -- rBurst size for scverify transactor
      xwBASE_ADDRESS  : integer                 := 0;      -- wBase address for scverify transactor
      xrBASE_ADDRESS  : integer                 := 0;      -- rBase address for scverify transactor
      xwBASE_ADDRESSU : integer                 := 0;      -- Upper word for 64-bit wBase address for scverify transactor
      xrBASE_ADDRESSU : integer                 := 0       -- Upper word for 64-bit rBase address for scverify transactor
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset
      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);                   -- Write burst length
      AWSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Write burst size
      AWBURST    : OUT  std_logic_vector(1 downto 0);                   -- Write burst mode
      AWLOCK     : OUT  std_logic;                                      -- Lock type
      AWCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      AWPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      AWQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      AWUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      AWVALID    : OUT  std_logic;                                      -- Write address valid
      AWREADY    : IN   std_logic;                                      -- Write address ready
      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);        -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);    -- Write strobe (bytewise)
      WLAST      : OUT  std_logic;                                      -- Write last
      WUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      WVALID     : OUT  std_logic;                                      -- Write data is valid
      WREADY     : IN   std_logic;                                      -- Write ready
      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);                   -- Write response
      BUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      BVALID     : IN   std_logic;                                      -- Write response valid
      BREADY     : OUT  std_logic;                                      -- Response ready
      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready
      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- Configuration interface
      cfgwBaseAddress : IN  std_logic_vector(ADDR_WIDTH-1 downto 0);  
      cfgrBaseAddress : IN  std_logic_vector(ADDR_WIDTH-1 downto 0);  
      cfgwBurstSize  : IN  std_logic_vector(31 downto 0);            
      cfgrBurstSize  : IN  std_logic_vector(31 downto 0);            
      cfgTimeout     : IN  std_logic_vector(31 downto 0);

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_we      : IN   std_logic;                                       -- Catapult attempting write to memory over bus
      m_waddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for write request (axi_addr = base_addr + m_waddr)
      m_raddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for read request (axi_addr = base_addr + m_raddr)
      m_wburst  : IN   std_logic_vector(31 downto 0);                   -- Write Burst length (constant wburstsize for now, future enhancement driven by operator)
      m_rburst  : IN   std_logic_vector(31 downto 0);                   -- Read Burst length (constant rburstsize for now, future enhancement driven by operator)
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_dout    : IN   std_logic_vector(cwidth-1 downto 0);             -- Data out to bus from catapult (write request)
      m_wrdy    : OUT  std_logic;                                       -- Bus memory ready for write access by Catapult (1=ready)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      -- Transactor resource interface (for SCVerify simulation only)
      m_wCaughtUp : OUT  std_logic;                                     -- wburst_in == wburst_out
      m_wstate    : OUT  std_logic_vector(2 downto 0)                   -- write_state of master
    );
  END COMPONENT;

  COMPONENT ccs_axi4_master_cfg
    GENERIC(
      rscid           : integer                 := 1;      -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;     -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 1 to 64   := 4;      -- Catapult address bus width
      cburst_mode     : integer range 0 to 2    := 0;      -- Burst mode (0==use w/rburstsize, 1==configuration port)
      wburstsize      : integer                 := 0;      -- Catapult configuration option for Write burst size
      rburstsize      : integer                 := 0;      -- Catapult configuration option for Read burst size
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      use_go          : integer range 0 to 1    := 0;      -- Use the cfgBus stop/go mechanism.  Default not.

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      base_addr_mode  : integer range 0 to 2    := 0;      -- Where base address is specified (0=param, 1=cfg, 2=port)
      wBASE_ADDRESS   : integer                 := 0;      -- AXI4 write channel base address
      rBASE_ADDRESS   : integer                 := 0;      -- AXI4 read channel base address
      wBASE_ADDRESSU  : integer                 := 0;      -- Upper word of 64-bit AXI4 write channel base address
      rBASE_ADDRESSU  : integer                 := 0       -- Upper word of 64-bit AXI4 read channel base address
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset
      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);                   -- Write burst length
      AWSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Write burst size
      AWBURST    : OUT  std_logic_vector(1 downto 0);                   -- Write burst mode
      AWLOCK     : OUT  std_logic;                                      -- Lock type
      AWCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      AWPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      AWQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      AWUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      AWVALID    : OUT  std_logic;                                      -- Write address valid
      AWREADY    : IN   std_logic;                                      -- Write address ready
      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);        -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);    -- Write strobe (bytewise)
      WLAST      : OUT  std_logic;                                      -- Write last
      WUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      WVALID     : OUT  std_logic;                                      -- Write data is valid
      WREADY     : IN   std_logic;                                      -- Write ready
      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);                   -- Write response
      BUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      BVALID     : IN   std_logic;                                      -- Write response valid
      BREADY     : OUT  std_logic;                                      -- Response ready
      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready
      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- AXI-lite slave interface to program base_addr - address 0, 1, 2
      cfgAWADDR  : IN  std_logic_vector(31 downto 0);
      cfgAWVALID : IN  std_logic;
      cfgAWREADY : OUT std_logic;
      cfgWDATA   : IN  std_logic_vector(31 downto 0);
      cfgWSTRB   : IN  std_logic_vector(3 downto 0);
      cfgWVALID  : IN  std_logic;
      cfgWREADY  : OUT std_logic;
      cfgBRESP   : OUT std_logic_vector(1 downto 0);
      cfgBVALID  : OUT std_logic;
      cfgBREADY  : IN  std_logic;
      cfgARADDR  : IN  std_logic_vector(31 downto 0);
      cfgARVALID : IN  std_logic;
      cfgARREADY : OUT std_logic;
      cfgRDATA   : OUT std_logic_vector(31 downto 0);
      cfgRRESP   : OUT std_logic_vector(1 downto 0);
      cfgRVALID  : OUT std_logic;
      cfgRREADY  : IN  std_logic;

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_we      : IN   std_logic;                                       -- Catapult attempting write to memory over bus
      m_waddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for write request (axi_addr = base_addr + m_waddr)
      m_raddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for read request (axi_addr = base_addr + m_raddr)
      m_wburst  : IN   std_logic_vector(31 downto 0);                   -- Write Burst length (constant wburstsize for now, future enhancement driven by operator)
      m_rburst  : IN   std_logic_vector(31 downto 0);                   -- Read Burst length (constant rburstsize for now, future enhancement driven by operator)
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_dout    : IN   std_logic_vector(cwidth-1 downto 0);             -- Data out to bus from catapult (write request)
      m_wrdy    : OUT  std_logic;                                       -- Bus memory ready for write access by Catapult (1=ready)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      -- Transactor resource interface (for SCVerify simulation only)
      m_wCaughtUp : OUT  std_logic;                                     -- wburst_in == wburst_out
      m_wstate    : OUT  std_logic_vector(2 downto 0)                   -- write_state of master
    );
  END COMPONENT;

  COMPONENT ccs_axi4_master
    GENERIC(
      rscid           : integer                 := 1;      -- Resource ID
      -- Catapult Bus Configuration generics
      depth           : integer                 := 16;     -- Number of addressable elements (up to 20bit address)
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 1 to 64   := 4;      -- Catapult address bus width
      wburstsize      : integer                 := 0;      -- Catapult configuration option for Write burst size
      rburstsize      : integer                 := 0;      -- Catapult configuration option for Read burst size
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      timeout         : integer                 := 0;      --  #cycles timeout for burst stall

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      wBASE_ADDRESS    : integer                := 0;      -- AXI4 write channel base address
      rBASE_ADDRESS    : integer                := 0;      -- AXI4 read channel base address
      wBASE_ADDRESSU   : integer                := 0;      -- Upper word for 64-bit AXI4 write channel base address
      rBASE_ADDRESSU   : integer                := 0       -- Upper word for 64-bit AXI4 read channel base addressable
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset
      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);                   -- Write burst length
      AWSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Write burst size
      AWBURST    : OUT  std_logic_vector(1 downto 0);                   -- Write burst mode
      AWLOCK     : OUT  std_logic;                                      -- Lock type
      AWCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      AWPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      AWQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      AWUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      AWVALID    : OUT  std_logic;                                      -- Write address valid
      AWREADY    : IN   std_logic;                                      -- Write address ready
      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);        -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);    -- Write strobe (bytewise)
      WLAST      : OUT  std_logic;                                      -- Write last
      WUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      WVALID     : OUT  std_logic;                                      -- Write data is valid
      WREADY     : IN   std_logic;                                      -- Write ready
      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);                   -- Write response
      BUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      BVALID     : IN   std_logic;                                      -- Write response valid
      BREADY     : OUT  std_logic;                                      -- Response ready
      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready
      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_we      : IN   std_logic;                                       -- Catapult attempting write to memory over bus
      m_waddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for write request (axi_addr = base_addr + m_waddr)
      m_raddr   : IN   std_logic_vector(addr_w    -1 downto 0);         -- Address for read request (axi_addr = base_addr + m_raddr)
      m_wburst  : IN   std_logic_vector(31 downto 0);                   -- Write Burst length (constant wburstsize for now, future enhancement driven by operator)
      m_rburst  : IN   std_logic_vector(31 downto 0);                   -- Read Burst length (constant rburstsize for now, future enhancement driven by operator)
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_dout    : IN   std_logic_vector(cwidth-1 downto 0);             -- Data out to bus from catapult (write request)
      m_wrdy    : OUT  std_logic;                                       -- Bus memory ready for write access by Catapult (1=ready)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      -- Transactor resource interface (for SCVerify simulation only)
      m_wCaughtUp : OUT  std_logic;                                     -- wburst_in == wburst_out
      m_wstate    : OUT  std_logic_vector(2 downto 0)                   -- write_state of master
    );
  END COMPONENT;

COMPONENT ccs_axi4_master_instream_core
    GENERIC(
      rscid           : integer                 := 1;     -- Resource ID
      -- Catapult Bus Configuration generics
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 0 to 64   := 4;      -- Catapult address bus width
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      fpga            : integer range 0 to 1    := 0;      -- Choose the fpga better-route version
      
      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      xburstsize      : integer                 := 0;      -- Burst size for scverify transactor
      xframe_size      : integer                := 16;     -- Number of elements in the frame to be streamed
      xBASE_ADDRESS   : integer                 := 0;      -- Base address for scverify transactor
      xBASE_ADDRESSU  : integer                 := 0       -- Upper word for 64-bit Base address for scverify transactor
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset

      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready

      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- Configuration interface
      cfgBaseAddress : IN  std_logic_vector(ADDR_WIDTH-1 downto 0);  
      cfgBurstSize   : IN  std_logic_vector(31 downto 0);            
      cfgTimeout     : IN  std_logic_vector(31 downto 0);            
      cfgFrameSize   : IN  std_logic_vector(31 downto 0);            

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      rdy       : OUT  std_logic                                        -- For transactor
    );

END COMPONENT;

COMPONENT ccs_axi4_master_outstream_core
    GENERIC(
      rscid           : integer;                           -- Resource ID
      -- Catapult Bus Configuration generics
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 0 to 64   := 4;      -- Catapult address bus width
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16   := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      xburstsize       : integer                := 0;      -- Burst size for scverify transactor
      xframe_size      : integer                := 16;     -- Number of elements in the frame to be streamed
      xBASE_ADDRESS    : integer                := 0;      -- Base addess  for scverify transactor
      xBASE_ADDRESSU   : integer                := 0       -- Upper word for 64-bit Base addess  for scverify transactor
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset

      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);                   -- Write burst length
      AWSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Write burst size
      AWBURST    : OUT  std_logic_vector(1 downto 0);                   -- Write burst mode
      AWLOCK     : OUT  std_logic;                                      -- Lock type
      AWCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      AWPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      AWQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      AWUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      AWVALID    : OUT  std_logic;                                      -- Write address valid
      AWREADY    : IN   std_logic;                                      -- Write address ready

      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);        -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);    -- Write strobe (bytewise)
      WLAST      : OUT  std_logic;                                      -- Write last
      WUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      WVALID     : OUT  std_logic;                                      -- Write data is valid
      WREADY     : IN   std_logic;                                      -- Write ready

      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);                   -- Write response
      BUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      BVALID     : IN   std_logic;                                      -- Write response valid
      BREADY     : OUT  std_logic;                                      -- Response ready

      -- Catapult interface
      -- Configuration interface
      cfgBaseAddress : IN  std_logic_vector(ADDR_WIDTH-1 downto 0);  
      cfgBurstSize   : IN  std_logic_vector(31 downto 0);            
      cfgTimeout     : IN  std_logic_vector(31 downto 0);            
      cfgFrameSize   : IN  std_logic_vector(31 downto 0);            

      m_we      : IN   std_logic;                                       -- Catapult attempting write to memory over bus
      m_dout    : IN   std_logic_vector(cwidth-1 downto 0);             -- Data out to bus from catapult (write request)
      m_wrdy    : OUT  std_logic;                                       -- Bus memory ready for write access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      vld       : OUT  std_logic                                        -- Core produced data.  Written into transactor "row"
    );

END COMPONENT;

COMPONENT ccs_axi4_master_instream
    GENERIC(
      rscid           : integer                 := 1;     -- Resource ID
      -- Catapult Bus Configuration generics
      frame_size      : integer                 := 16;     -- Number of elements in the frame to be streamed
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 0 to 64   := 4;      -- Catapult address bus width
      burstsize       : integer                 := 0;      -- Catapult configuration option for Read burst size
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      fpga            : integer range 0 to 1    := 0;      -- Choose the fpga better-route version
      timeout         : integer                 := 0;      --  #cycles timeout for burst stall
      
      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      BASE_ADDRESS    : integer                 := 0;      -- Base address 
      BASE_ADDRESSU   : integer                 := 0       -- Upper word for 64-bit Base address 
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset

      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready

      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      rdy       : OUT  std_logic                                        -- For transactor
    );

END COMPONENT;

COMPONENT ccs_axi4_master_outstream
    GENERIC(
      rscid           : integer;                           -- Resource ID
      -- Catapult Bus Configuration generics
      frame_size      : integer                 := 16;     -- Number of elements in the frame to be streamed
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 0 to 64   := 4;      -- Catapult address bus width
      burstsize       : integer                 := 0;      -- Catapult configuration option for Write burst size
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      timeout         : integer                 := 0;      --  #cycles timeout for burst stall

      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16   := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;     -- AXI4 Region Map (ignored in this model)
      BASE_ADDRESS    : integer                := 0;      -- AXI4 write channel base address
      BASE_ADDRESSU   : integer                := 0       -- Upper word for 64-bit AXI4 write channel base address
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset

      -- ============== AXI4 Write Address Channel Signals
      AWID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Write address ID
      AWADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Write address
      AWLEN      : OUT  std_logic_vector(7 downto 0);                   -- Write burst length
      AWSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Write burst size
      AWBURST    : OUT  std_logic_vector(1 downto 0);                   -- Write burst mode
      AWLOCK     : OUT  std_logic;                                      -- Lock type
      AWCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      AWPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      AWQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      AWREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      AWUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      AWVALID    : OUT  std_logic;                                      -- Write address valid
      AWREADY    : IN   std_logic;                                      -- Write address ready

      -- ============== AXI4 Write Data Channel
      WDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);        -- Write data
      WSTRB      : OUT  std_logic_vector((DATA_WIDTH/8)-1 downto 0);    -- Write strobe (bytewise)
      WLAST      : OUT  std_logic;                                      -- Write last
      WUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      WVALID     : OUT  std_logic;                                      -- Write data is valid
      WREADY     : IN   std_logic;                                      -- Write ready

      -- ============== AXI4 Write Response Channel Signals
      BID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Response ID tag
      BRESP      : IN   std_logic_vector(1 downto 0);                   -- Write response
      BUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      BVALID     : IN   std_logic;                                      -- Write response valid
      BREADY     : OUT  std_logic;                                      -- Response ready

      -- Catapult interface
      m_we      : IN   std_logic;                                       -- Catapult attempting write to memory over bus
      m_dout    : IN   std_logic_vector(cwidth-1 downto 0);             -- Data out to bus from catapult (write request)
      m_wrdy    : OUT  std_logic;                                       -- Bus memory ready for write access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      vld       : OUT  std_logic                                        -- Core produced data.  Written into transactor "row"
    );

END COMPONENT;

COMPONENT ccs_axi4_lite_slave_outreg
  GENERIC(
    rscid           : integer                 := 1;    -- Resource ID
    -- Catapult Bus Configuration generics
    op_width        : integer range 1 to 1024 := 1;    -- dummy parameter for cwidth calculation
    cwidth          : integer range 1 to 1024 := 8;    -- Internal memory data width
    rst_ph          : integer range 0 to 1    := 0;    -- Reset phase.  1= Positive edge. Default is AXI negative edge
    -- AXI-4 Bus Configuration generics
    ADDR_WIDTH      : integer range 12 to 64  := 32;   -- AXI4 bus address width
    DATA_WIDTH      : integer range 8 to 1024 := 32;   -- AXI4 read&write data bus width
    BASE_ADDRESS   : integer                  := 0     -- AXI4 Address that the register is seen at
    );
  PORT(
    -- AXI-4 Interface
    ACLK       : IN   std_logic;                                     -- Rising edge clock
    ARESETn    : IN   std_logic;                                     -- Active LOW asynchronous reset
    
    -- ============== AXI4 Read Address Channel Signals
    ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Read address
    ARVALID    : IN   std_logic;                                     -- Read address valid
    ARREADY    : OUT  std_logic;                                     -- Read address ready (slave is ready to accept ARADDR)
    
    -- ============== AXI4 Read Data Channel Signals
    RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);       -- Read data
    RRESP      : OUT  std_logic_vector(1 downto 0);                  -- Read response (of slave)
    RVALID     : OUT  std_logic;                                     -- Read valid (slave providing RDATA)
    RREADY     : IN   std_logic;                                     -- Read ready (master ready to receive RDATA)
    
    -- Catapult interface
    ivld      : IN   std_logic;                                      -- Catapult data ready
    idat      : in   std_logic_vector(cwidth-1 downto 0);            -- Data from catapult

    -- External valid flag
    vld       : OUT  std_logic                                       -- Data valid for AXI read
    );

END COMPONENT;

COMPONENT ccs_axi4_lite_slave_inreg 
  GENERIC(
    rscid           : integer                 := 1;    -- Resource ID
    -- Catapult Bus Configuration generics
    op_width        : integer range 1 to 1024 := 1;    -- dummy parameter for cwidth calculation
    cwidth          : integer range 1 to 1024 := 8;    -- Internal memory data width
    rst_ph          : integer range 0 to 1    := 0;    -- Reset phase.  1= Positive edge. Default is AXI negative edge
    disable_vld     : integer range 0 to 1    := 0;    -- Disable use of vld signal to stall I/O
    -- AXI-4 Bus Configuration generics
    ADDR_WIDTH      : integer range 12 to 64  := 32;   -- AXI4 bus address width
    DATA_WIDTH      : integer range 8 to 1024 := 32;   -- AXI4 read&write data bus width
    BASE_ADDRESS    : integer                 := 0     -- AXI4 Address that the register is seen at
    );
  PORT(
    -- AXI-4 Interface
    ACLK       : IN   std_logic;                                     -- Rising edge clock
    ARESETn    : IN   std_logic;                                     -- Active LOW asynchronous reset
    -- ============== AXI4 Write Address Channel Signals
    AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Write address
    AWVALID    : IN   std_logic;                                     -- Write address valid
    AWREADY    : OUT  std_logic;                                     -- Write address ready (slave is ready to accept AWADDR)
    -- ============== AXI4 Write Data Channel
    WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);       -- Write data
    WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise)
    WVALID     : IN   std_logic;                                     -- Write data is valid
    WREADY     : OUT  std_logic;                                     -- Write ready (slave is ready to accept WDATA)
    
    -- ============== AXI4 Write Response Channel Signals
    BRESP      : OUT  std_logic_vector(1 downto 0);                  -- Write response (of slave)
    BVALID     : OUT  std_logic;                                     -- Write response valid (slave accepted WDATA)
    BREADY     : IN   std_logic;                                     -- Response ready (master can accept slave's write response)
    
    -- Catapult interface
    ivld      : OUT   std_logic;                                      -- Data valid.  Duration 1 cycle
    idat      : OUT   std_logic_vector(cwidth-1 downto 0)             -- Data into catapult block through this interface
    );
END COMPONENT;

COMPONENT ccs_axi4_lite_slave_indirect
  GENERIC(
    rscid           : integer                 := 1;    -- Resource ID
    -- Catapult Bus Configuration generics
    op_width        : integer range 1 to 1024 := 1;    -- dummy parameter for cwidth calculation
    cwidth          : integer range 1 to 1024 := 8;    -- Internal memory data width
    rst_ph          : integer range 0 to 1    := 0;    -- Reset phase.  1= Positive edge. Default is AXI negative edge
    -- AXI-4 Bus Configuration generics
    ADDR_WIDTH      : integer range 12 to 64  := 32;   -- AXI4 bus address width
    DATA_WIDTH      : integer range 8 to 1024 := 32;   -- AXI4 read&write data bus width
    BASE_ADDRESS    : integer                 := 0     -- AXI4 Address that the register is seen at
    );
  PORT(
    -- AXI-4 Interface
    ACLK       : IN   std_logic;                                     -- Rising edge clock
    ARESETn    : IN   std_logic;                                     -- Active LOW asynchronous reset
    -- ============== AXI4 Write Address Channel Signals
    AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Write address
    AWVALID    : IN   std_logic;                                     -- Write address valid
    AWREADY    : OUT  std_logic;                                     -- Write address ready (slave is ready to accept AWADDR)
    -- ============== AXI4 Write Data Channel
    WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);       -- Write data
    WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise)
    WVALID     : IN   std_logic;                                     -- Write data is valid
    WREADY     : OUT  std_logic;                                     -- Write ready (slave is ready to accept WDATA)
    
    -- ============== AXI4 Write Response Channel Signals
    BRESP      : OUT  std_logic_vector(1 downto 0);                  -- Write response (of slave)
    BVALID     : OUT  std_logic;                                     -- Write response valid (slave accepted WDATA)
    BREADY     : IN   std_logic;                                     -- Response ready (master can accept slave's write response)
    
    -- ============== AXI4 Read Address Channel Signals
    ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Read address
    ARVALID    : IN   std_logic;                                     -- Read address valid
    ARREADY    : OUT  std_logic;                                     -- Read address ready (slave is ready to accept ARADDR)
    
    -- ============== AXI4 Read Data Channel Signals
    RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);       -- Read data
    RRESP      : OUT  std_logic_vector(1 downto 0);                  -- Read response (of slave)
    RVALID     : OUT  std_logic;                                     -- Read valid (slave providing RDATA)
    RREADY     : IN   std_logic;                                     -- Read ready (master ready to receive RDATA)
    
    -- Catapult interface
    idat      : OUT   std_logic_vector(cwidth-1 downto 0)             -- Data into catapult block through this interface
    );
END COMPONENT;

COMPONENT ccs_axi4_lite_slave_outsync
  GENERIC(
    rscid           : integer                 := 1;    -- Resource ID
    -- Catapult Bus Configuration generics
    rst_ph          : integer range 0 to 1    := 0;    -- Reset phase.  1= Positive edge. Default is AXI negative edge
    -- AXI-4 Bus Configuration generics
    ADDR_WIDTH      : integer range 12 to 32  := 32;   -- AXI4 bus address width
    DATA_WIDTH      : integer range 32 to 64  := 32;   -- AXI4 read&write data bus width
    BASE_ADDRESS   : integer                  := 0     -- AXI4 Address that the register is seen at
    );
  PORT(
    -- AXI-4 Interface
    ACLK       : IN   std_logic;                                     -- Rising edge clock
    ARESETn    : IN   std_logic;                                     -- Active LOW asynchronous reset
    
    -- ============== AXI4 Write Address Channel Signals
    AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Write address
    AWVALID    : IN   std_logic;                                     -- Write address valid
    AWREADY    : OUT  std_logic;                                     -- Write address ready (slave is ready to accept AWADDR)

    -- ============== AXI4 Write Data Channel
    WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);       -- Write data
    WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe - not used in LITE
    WVALID     : IN   std_logic;                                     -- Write data is valid
    WREADY     : OUT  std_logic;                                     -- Write ready (slave is ready to accept WDATA)
    
    -- ============== AXI4 Write Response Channel Signals
    BRESP      : OUT  std_logic_vector(1 downto 0);                  -- Write response (of slave)
    BVALID     : OUT  std_logic;                                     -- Write response valid (slave accepted WDATA)
    BREADY     : IN   std_logic;                                     -- Response ready (master can accept slave's write response)
    
    -- ============== AXI4 Read Address Channel Signals
    ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Read address
    ARVALID    : IN   std_logic;                                     -- Read address valid
    ARREADY    : OUT  std_logic;                                     -- Read address ready (slave is ready to accept ARADDR)
    
    -- ============== AXI4 Read Data Channel Signals
    RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);       -- Read data
    RRESP      : OUT  std_logic_vector(1 downto 0);                  -- Read response (of slave)
    RVALID     : OUT  std_logic;                                     -- Read valid (slave providing RDATA)
    RREADY     : IN   std_logic;                                     -- Read ready (master ready to receive RDATA)
    
    -- Catapult interface
    irdy      : OUT  std_logic;                                      -- Catapult data ready
    ivld      : IN   std_logic;                                      -- Catapult data ready
    triosy    : OUT  std_logic                                       -- Data from catapult
    );

END COMPONENT;

COMPONENT ccs_axi4_lite_slave_insync
  GENERIC(
    rscid           : integer                 := 1;    -- Resource ID
    -- Catapult Bus Configuration generics
    rst_ph          : integer range 0 to 1    := 0;    -- Reset phase.  1= Positive edge. Default is AXI negative edge
    -- AXI-4 Bus Configuration generics
    ADDR_WIDTH      : integer range 12 to 32  := 32;   -- AXI4 bus address width
    DATA_WIDTH      : integer range 32 to 64  := 32;   -- AXI4 read&write data bus width
    BASE_ADDRESS    : integer                 := 0     -- AXI4 Address that the register is seen at
    );
  PORT(
    -- AXI-4 Interface
    ACLK       : IN   std_logic;                                     -- Rising edge clock
    ARESETn    : IN   std_logic;                                     -- Active LOW asynchronous reset
    -- ============== AXI4 Write Address Channel Signals
    AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Write address
    AWVALID    : IN   std_logic;                                     -- Write address valid
    AWREADY    : OUT  std_logic;                                     -- Write address ready (slave is ready to accept AWADDR)
    -- ============== AXI4 Write Data Channel
    WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);       -- Write data
    WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise)
    WVALID     : IN   std_logic;                                     -- Write data is valid
    WREADY     : OUT  std_logic;                                     -- Write ready (slave is ready to accept WDATA)
    
    -- ============== AXI4 Write Response Channel Signals
    BRESP      : OUT  std_logic_vector(1 downto 0);                  -- Write response (of slave)
    BVALID     : OUT  std_logic;                                     -- Write response valid (slave accepted WDATA)
    BREADY     : IN   std_logic;                                     -- Response ready (master can accept slave's write response)
    
    -- ============== AXI4 Read Address Channel Signals
    ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Read address
    ARVALID    : IN   std_logic;                                     -- Read address valid
    ARREADY    : OUT  std_logic;                                     -- Read address ready (slave is ready to accept ARADDR)
    
    -- ============== AXI4 Read Data Channel Signals
    RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);       -- Read data
    RRESP      : OUT  std_logic_vector(1 downto 0);                  -- Read response (of slave)
    RVALID     : OUT  std_logic;                                     -- Read valid (slave providing RDATA)
    RREADY     : IN   std_logic;                                     -- Read ready (master ready to receive RDATA)

    -- Catapult interface
    irdy      : IN    std_logic;
    ivld      : OUT   std_logic;
    triosy    : OUT   std_logic                                       -- // transactor uses 
    );
END COMPONENT;


  -- ==============================================================
  -- APB Components

  -- Used to define the APB bus definition (direction of signals is from the slave's perspective)
  COMPONENT apb_busdef
    GENERIC(
      width        : INTEGER RANGE 1 TO 32 := 32;           -- Number of bits in an element
      addr_width   : INTEGER RANGE 1 TO 32 := 1             -- Number of address bits to address 'words' elements
    );
    PORT(
      -- APB interface
      PCLK      : IN   std_logic;                           -- Rising edge clock
      PRESETn   : IN   std_logic;                           -- Active LOW synchronous reset
      PADDR     : IN   std_logic_vector(addr_width-1 downto 0);  -- APB Bridge driven address bus (32 bit max)
      PSELx     : IN   std_logic;                           -- APB Bridge driven select for this slave
      PWRITE    : IN   std_logic;                           -- APB Bridge driven read/write signal (0=read)
      PENABLE   : IN   std_logic;                           -- APB Bridge driven enable signal
      PWDATA    : IN   std_logic_vector(width-1 downto 0);  -- APB Bridge driven data to write to slave (32 bit max)
      PRDATA    : OUT  std_logic_vector(width-1 downto 0);  -- Slave driven data back to APB Bridge (32 bit max)
      PREADY    : OUT  std_logic;                           -- Slave driven signal to extend transfer cycles (1=ready)
      PSLVERR   : OUT  std_logic                            -- Slave driven signal indicating transfer failed (1=fail)
    );
  END COMPONENT;

  COMPONENT apb_master
    GENERIC(
      words        : INTEGER RANGE 1 TO 256 := 1;           -- Number of addressable elements
      width        : INTEGER RANGE 1 TO 32 := 32;           -- Number of bits in an element
      addr_width   : INTEGER RANGE 1 TO 32 := 1             -- Number of address bits to address 'words' elements
    );
    PORT(
      -- APB interface
      PCLK      : IN   std_logic;                           -- Rising edge clock
      PRESETn   : IN   std_logic;                           -- Active LOW synchronous reset
      PADDR     : OUT  std_logic_vector(30 downto 0);       -- APB Bridge driven address bus (32 bit max)
      PSELx     : OUT  std_logic;                           -- APB Bridge driven select for this slave
      PWRITE    : OUT  std_logic;                           -- APB Bridge driven read/write signal (0=read)
      PENABLE   : OUT  std_logic;                           -- APB Bridge driven enable signal
      PWDATA    : OUT  std_logic_vector(width-1 downto 0);  -- APB Bridge driven data to write to slave (32 bit max)
      PRDATA    : IN   std_logic_vector(width-1 downto 0);  -- Slave driven data back to APB Bridge (32 bit max)
      PREADY    : IN   std_logic;                           -- Slave driven signal to extend transfer cycles (1=ready)
      PSLVERR   : IN   std_logic;                           -- Slave driven signal indicating transfer failed (1=fail)
      -- Catapult interface
      m_rw      : IN   std_logic;                           -- read/write
      m_strobe  : IN   std_logic;                           -- initiate a bus transfer
      m_adr     : IN   std_logic_vector(addr_width-1 downto 0); -- target address
      m_din     : OUT  std_logic_vector(width-1 downto 0);  -- data in from slave
      m_dout    : IN   std_logic_vector(width-1 downto 0);  -- data out to slave
      m_rdy     : OUT  std_logic                            -- ready for transfer (1=ready)
    );
  END COMPONENT;

  -- APB slave memory
  COMPONENT apb_slave_mem
    GENERIC(
      words          : INTEGER RANGE 1 TO 256 := 1;            -- Number of addressable elements
      width          : INTEGER RANGE 1 TO 32 := 32;           -- Number of bits in an element
      addr_width     : INTEGER RANGE 1 TO 32 := 1;            -- Number of address bits to address 'words' elements
      num_rwports    : INTEGER RANGE 1 TO 100 := 1;           -- Number of register file "ports"
      nopreload      : INTEGER RANGE 0 TO 1 := 0              -- 1=disable required preload before Catapult can read
    );
    PORT(
      -- APB interface
      PCLK      : IN   std_logic;                           -- Rising edge clock
      PRESETn   : IN   std_logic;                           -- Active LOW synchronous reset
      PADDR     : IN   std_logic_vector(30 downto 0);       -- APB Bridge driven address bus (32 bit max)
      PSELx     : IN   std_logic;                           -- APB Bridge driven select for this slave
      PWRITE    : IN   std_logic;                           -- APB Bridge driven read/write signal (0=read)
      PENABLE   : IN   std_logic;                           -- APB Bridge driven enable signal
      PWDATA    : IN   std_logic_vector(width-1 downto 0);  -- APB Bridge driven data to write to slave (32 bit max)
      PRDATA    : OUT  std_logic_vector(width-1 downto 0);  -- Slave driven data back to APB Bridge (32 bit max)
      PREADY    : OUT  std_logic;                           -- Slave driven signal to extend transfer cycles (1=ready)
      PSLVERR   : OUT  std_logic;                           -- Slave driven signal indicating transfer failed (1=fail)
      -- Catapult interface
      s_rw      : IN   std_logic_vector(num_rwports-1 downto 0);            -- read/write
      s_strobe  : IN   std_logic_vector(num_rwports-1 downto 0);            -- Catapult attempting read of slave
      s_adr     : IN   std_logic_vector(num_rwports*addr_width-1 downto 0); -- Catapult addressing into memory
      s_din     : OUT  std_logic_vector(num_rwports*width-1 downto 0);      -- Data into catapult block through this interface
      s_dout    : IN   std_logic_vector(num_rwports*width-1 downto 0);      -- Data out to slave from catapult
      s_rdy     : OUT  std_logic_vector(num_rwports-1 downto 0)             -- Slave memory ready for read (1=ready)
    );
  END COMPONENT;

  -- ==============================================================
  -- Internally referenced components

  COMPONENT amba_generic_reg
    GENERIC (
      width    : INTEGER := 1;
      ph_en    : INTEGER RANGE 0 TO 1 := 1;
      has_en   : INTEGER RANGE 0 TO 1 := 1
    );
    PORT (
      clk     : IN  std_logic;
      en      : IN  std_logic;
      arst    : IN  std_logic;
      srst    : IN  std_logic;
      d       : IN  std_logic_vector(width-1 DOWNTO 0);
      z       : OUT std_logic_vector(width-1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT amba_pipe_ctrl
    GENERIC (
      rscid    : INTEGER := 0;
      width    : INTEGER := 8;
      sz_width : INTEGER := 8;
      fifo_sz  : INTEGER RANGE 0 TO 128 := 8;
      ph_en    : INTEGER RANGE 0 TO 1 := 1
    );
    PORT (
      clk      : IN  std_logic;
      en       : IN  std_logic;
      arst     : IN  std_logic;
      srst     : IN  std_logic;
      din_vld  : IN  std_logic;
      din_rdy  : OUT std_logic;
      din      : IN  std_logic_vector(width-1 DOWNTO 0);
      dout_vld : OUT std_logic;
      dout_rdy : IN  std_logic;
      dout     : OUT std_logic_vector(width-1 DOWNTO 0);
      sd       : OUT std_logic_vector(sz_width-1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT amba_pipe
    GENERIC (
      rscid    : INTEGER := 0;
      width    : INTEGER := 8;
      sz_width : INTEGER := 8;
      fifo_sz  : INTEGER RANGE 0 TO 128 := 8;
      ph_en    : INTEGER RANGE 0 TO 1 := 1
    );
    PORT (
      -- clock
      clk      : IN  std_logic;
      en       : IN  std_logic;
      arst     : IN  std_logic;
      srst     : IN  std_logic;
      -- writer
      din_rdy  : OUT std_logic;
      din_vld  : IN  std_logic;
      din      : IN  std_logic_vector(width-1 DOWNTO 0);
      -- reader
      dout_rdy : IN  std_logic;
      dout_vld : OUT std_logic;
      dout     : OUT std_logic_vector(width-1 DOWNTO 0);
      -- size
      sz       : OUT std_logic_vector(sz_width-1 DOWNTO 0);
      sz_req   : in  std_logic
    );
  END COMPONENT;

  COMPONENT amba_ctrl_in_buf_wait
    GENERIC (
      width    : INTEGER := 8
    );
    PORT (
      clk      : IN  std_logic;
      arst     : IN  std_logic;
      irdy   : IN  std_logic;
      ivld   : OUT std_logic;
      idat   : OUT std_logic_vector(width-1 DOWNTO 0);
      rdy    : OUT std_logic;
      vld    : IN  std_logic;
      dat    : IN  std_logic_vector(width-1 DOWNTO 0);
      is_idle : out std_logic
    );
  END COMPONENT;

  COMPONENT ML_amba_ctrl_in_buf_wait
    GENERIC (
      width    : INTEGER := 8
    );
    PORT (
      clk      : IN  std_logic;
      arst     : IN  std_logic;
      irdy   : IN  std_logic;
      ivld   : OUT std_logic;
      idat   : OUT std_logic_vector(width-1 DOWNTO 0);
      rdy    : OUT std_logic;
      vld    : IN  std_logic;
      dat    : IN  std_logic_vector(width-1 DOWNTO 0);
      is_idle : out std_logic
    );
  END COMPONENT;

COMPONENT ML_ccs_axi4_master_fpga_instream_core
    GENERIC(
      rscid           : integer                 := 1;     -- Resource ID
      -- Catapult Bus Configuration generics
      frame_size      : integer                 := 16;     -- Number of elements in the frame to be streamed
      op_width        : integer range 1 to 1024 := 1;      -- dummy parameter for cwidth calculation
      cwidth          : integer range 8 to 1024 := 32;     -- Catapult data bus width (multiples of 8)
      addr_w          : integer range 0 to 64   := 4;      -- Catapult address bus width
      rst_ph          : integer range 0 to 1    := 0;      -- Reset phase - negative default
      
      -- AXI-4 Bus Configuration generics
      ADDR_WIDTH      : integer range 12 to 64  := 32;     -- AXI4 bus address width
      DATA_WIDTH      : integer range 8 to 1024 := 32;     -- AXI4 read&write data bus width
      ID_WIDTH        : integer range 1 to 16    := 1;      -- AXI4 ID field width (ignored in this model)
      USER_WIDTH      : integer range 1 to 32   := 1;      -- AXI4 User field width (ignored in this model)
      REGION_MAP_SIZE : integer range 1 to 15   := 1;      -- AXI4 Region Map (ignored in this model)
      xburstsize      : integer                 := 0;      -- Burst size for scverify transactor
      xBASE_ADDRESS   : integer                 := 0;      -- Base address for scverify transactor
      xBASE_ADDRESSU  : integer                 := 0       -- Upper word for 64-bit Base address for scverify transactor
    );
    PORT(
      -- AXI-4 Interface
      ACLK       : IN   std_logic;                                      -- Rising edge clock
      ARESETn    : IN   std_logic;                                      -- Active LOW asynchronous reset

      -- ============== AXI4 Read Address Channel Signals
      ARID       : OUT  std_logic_vector(ID_WIDTH-1 downto 0);          -- Read address ID
      ARADDR     : OUT  std_logic_vector(ADDR_WIDTH-1 downto 0);        -- Read address
      ARLEN      : OUT  std_logic_vector(7 downto 0);                   -- Read burst length
      ARSIZE     : OUT  std_logic_vector(2 downto 0);                   -- Read burst size
      ARBURST    : OUT  std_logic_vector(1 downto 0);                   -- Read burst mode
      ARLOCK     : OUT  std_logic;                                      -- Lock type
      ARCACHE    : OUT  std_logic_vector(3 downto 0);                   -- Memory type
      ARPROT     : OUT  std_logic_vector(2 downto 0);                   -- Protection Type
      ARQOS      : OUT  std_logic_vector(3 downto 0);                   -- Quality of Service
      ARREGION   : OUT  std_logic_vector(3 downto 0);                   -- Region identifier
      ARUSER     : OUT  std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      ARVALID    : OUT  std_logic;                                      -- Read address valid
      ARREADY    : IN   std_logic;                                      -- Read address ready

      -- ============== AXI4 Read Data Channel Signals
      RID        : IN   std_logic_vector(ID_WIDTH-1 downto 0);          -- Read ID tag
      RDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);        -- Read data
      RRESP      : IN   std_logic_vector(1 downto 0);                   -- Read response
      RLAST      : IN   std_logic;                                      -- Read last
      RUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);        -- User signal
      RVALID     : IN   std_logic;                                      -- Read valid
      RREADY     : OUT  std_logic;                                      -- Read ready

      -- Configuration interface
      cfgBaseAddress : IN  std_logic_vector(ADDR_WIDTH-1 downto 0);  
      cfgBurstSize   : IN  std_logic_vector(31 downto 0);            
      cfgTimeout     : IN  std_logic_vector(31 downto 0);            

      -- Catapult interface
      m_re      : IN   std_logic;                                       -- Catapult attempting read of memory over bus
      m_din     : OUT  std_logic_vector(cwidth-1 downto 0);             -- Data into catapult block through this interface (read request)
      m_rrdy    : OUT  std_logic;                                       -- Bus memory ready for read access by Catapult (1=ready)
      is_idle   : OUT  std_logic;                                       -- The component is idle. The next clk can be suppressed
      rdy       : OUT  std_logic                                        -- For transactor
    );
END COMPONENT;

  
  -- ==============================================================
  -- AMBA Protocol Constants

  -- AxBURST modes
  CONSTANT AXI4_AxBURST_FIXED    : std_logic_vector(1 downto 0) := "00";
  CONSTANT AXI4_AxBURST_INCR     : std_logic_vector(1 downto 0) := "01";
  CONSTANT AXI4_AxBURST_WRAP     : std_logic_vector(1 downto 0) := "10";
  CONSTANT AXI4_AxBURST_RESERVED : std_logic_vector(1 downto 0) := "11";
  -- AxLOCK modes
  CONSTANT AXI4_AxLOCK_NORMAL    : std_logic                    := '0';
  CONSTANT AXI4_AxLOCK_EXCLUSIVE : std_logic                    := '1';
  -- Memory types W and R mostly the xame
  CONSTANT AXI4_AWCACHE_NB        : std_logic_vector(3 downto 0) := "0000";
  CONSTANT AXI4_AWCACHE_B         : std_logic_vector(3 downto 0) := "0001";
  CONSTANT AXI4_AWCACHE_NORM_NCNB : std_logic_vector(3 downto 0) := "0010"; --
  CONSTANT AXI4_AWCACHE_NORM_NCB  : std_logic_vector(3 downto 0) := "0011" ;
  CONSTANT AXI4_AWCACHE_WTNA      : std_logic_vector(3 downto 0) := "0110";
  CONSTANT AXI4_AWCACHE_WTRA      : std_logic_vector(3 downto 0) := "0110";
  CONSTANT AXI4_AWCACHE_WTWA      : std_logic_vector(3 downto 0) := "1110";
  CONSTANT AXI4_AWCACHE_WTRWA     : std_logic_vector(3 downto 0) := "1110";
  CONSTANT AXI4_AWCACHE_WBNA      : std_logic_vector(3 downto 0) := "0111";
  CONSTANT AXI4_AWCACHE_WBRA      : std_logic_vector(3 downto 0) := "0111";
  CONSTANT AXI4_WACACHE_WBWA      : std_logic_vector(3 downto 0) := "1111";
  CONSTANT AXI4_AWCACHE_WBRWA     : std_logic_vector(3 downto 0) := "1111";
  CONSTANT AXI4_ARCACHE_NB        : std_logic_vector(3 downto 0) := "0000";
  CONSTANT AXI4_ARCACHE_B         : std_logic_vector(3 downto 0) := "0001";
  CONSTANT AXI4_ARCACHE_NORM_NCNB : std_logic_vector(3 downto 0) := "0010"; --
  CONSTANT AXI4_ARCACHE_NORM_NCB  : std_logic_vector(3 downto 0) := "0011" ;
  CONSTANT AXI4_ARCACHE_WTNA      : std_logic_vector(3 downto 0) := "1010";
  CONSTANT AXI4_ARCACHE_WTRA      : std_logic_vector(3 downto 0) := "1110";
  CONSTANT AXI4_ARCACHE_WTWA      : std_logic_vector(3 downto 0) := "1010";
  CONSTANT AXI4_ARCACHE_WTRWA     : std_logic_vector(3 downto 0) := "1110";
  CONSTANT AXI4_ARCACHE_WBNA      : std_logic_vector(3 downto 0) := "1011";
  CONSTANT AXI4_ARCACHE_WBRA      : std_logic_vector(3 downto 0) := "1111";
  CONSTANT AXI4_ARCACHE_WBWA      : std_logic_vector(3 downto 0) := "1011";
  CONSTANT AXI4_ARCACHE_WBRWA     : std_logic_vector(3 downto 0) := "1111";
  -- QOS pre-defines
  CONSTANT AXI4_AxQOS_NONE        : std_logic_vector(3 downto 0) := "0000";
  -- AxSIZE byte sizes
  CONSTANT AXI4_AxSIZE_001_BYTE  : std_logic_vector(2 downto 0) := "000";
  CONSTANT AXI4_AxSIZE_002_BYTE  : std_logic_vector(2 downto 0) := "001";
  CONSTANT AXI4_AxSIZE_004_BYTE  : std_logic_vector(2 downto 0) := "010";
  CONSTANT AXI4_AxSIZE_008_BYTE  : std_logic_vector(2 downto 0) := "011";
  CONSTANT AXI4_AxSIZE_016_BYTE  : std_logic_vector(2 downto 0) := "100";
  CONSTANT AXI4_AxSIZE_032_BYTE  : std_logic_vector(2 downto 0) := "101";
  CONSTANT AXI4_AxSIZE_064_BYTE  : std_logic_vector(2 downto 0) := "110";
  CONSTANT AXI4_AxSIZE_128_BYTE  : std_logic_vector(2 downto 0) := "111";
  -- AxPROT bit fields
  CONSTANT AXI4_AxPROT_b0_UNPRIV   : std_logic := '0';
  CONSTANT AXI4_AxPROT_b0_PRIV     : std_logic := '1';
  CONSTANT AXI4_AxPROT_b1_SECURE   : std_logic := '0';
  CONSTANT AXI4_AxPROT_b1_UNSECURE : std_logic := '1';
  CONSTANT AXI4_AxPROT_b2_DATA     : std_logic := '0';
  CONSTANT AXI4_AxPROT_b2_INSTR    : std_logic := '1';
  -- xRESP response codes
  CONSTANT AXI4_xRESP_OKAY         : std_logic_vector(1 downto 0) := "00";
  CONSTANT AXI4_xRESP_EXOKAY       : std_logic_vector(1 downto 0) := "01";
  CONSTANT AXI4_xRESP_SLVERR       : std_logic_vector(1 downto 0) := "10";
  CONSTANT AXI4_xRESP_DECERR       : std_logic_vector(1 downto 0) := "11";

  -- Utility function(s) to support debug needs
  FUNCTION bits ( size : INTEGER) RETURN INTEGER;
  FUNCTION slv2bin(vec: std_logic_vector) RETURN string;
  FUNCTION slv2hex(vec: std_logic_vector) RETURN string;

END PACKAGE amba_comps;

PACKAGE BODY amba_comps IS

   -- Find the number of bits required to represent an unsigned
   -- number less than size
  FUNCTION bits (size : integer) RETURN INTEGER IS
  BEGIN
    IF (size < 0) THEN RETURN 0;
    ELSIF (size = 0) THEN RETURN 1;
    ELSE
      FOR i IN 1 TO size LOOP
        IF (2**i >= size) THEN
          RETURN i;
        END IF;
      END LOOP;
      RETURN 0;
    END IF;
  END;

   -- Convert an std_logic_vector to a (hex)string for printing
   -- vec needs to be a multiple of 4 in size
  FUNCTION slv2hex(vec: std_logic_vector) RETURN string IS
      variable quad : std_logic_vector(3 downto 0);
      constant ne: integer := vec'length/4;
      variable s: string(1 to ne);
   BEGIN
      if vec'length mod 4 /= 0 then
         assert false
         report "slv2hex called with slv lenght that is not a multiple of 4";
         return s;
      end if;
      for i in 0 to ne-1 loop
         quad := vec(4*i+3 downto 4*i);
         case quad is
            when x"0" => s(ne-i) := '0';
            when x"1" => s(ne-i) := '1';
            when x"2" => s(ne-i) := '2';
            when x"3" => s(ne-i) := '3';
            when x"4" => s(ne-i) := '4';
            when x"5" => s(ne-i) := '5';
            when x"6" => s(ne-i) := '6';
            when x"7" => s(ne-i) := '7';
            when x"8" => s(ne-i) := '8';
            when x"9" => s(ne-i) := '9';
            when x"A" => s(ne-i) := 'A';
            when x"B" => s(ne-i) := 'B';
            when x"C" => s(ne-i) := 'C';
            when x"D" => s(ne-i) := 'D';
            when x"E" => s(ne-i) := 'E';
            when x"F" => s(ne-i) := 'F';
            when others => s(ne-i) := '-';
         end case;
      end loop;
      return s;
   END;

   -- Convert an std_logic_vector to a (binary)string for printing
   FUNCTION slv2bin(vec: std_logic_vector) RETURN string IS
      VARIABLE stmp: string(vec'left+1 downto 1);
   BEGIN
      FOR i in vec'reverse_range LOOP
         IF (vec(i) = 'U') THEN
            stmp(i+1) := 'U';
         ELSIF (vec(i) = 'X') THEN
            stmp(i+1) := 'X';
         ELSIF (vec(i) = '0') THEN
            stmp(i+1) := '0';
         ELSIF (vec(i) = '1') THEN
            stmp(i+1) := '1';
         ELSIF (vec(i) = 'Z') THEN
            stmp(i+1) := 'Z';
         ELSIF (vec(i) = 'W') THEN
            stmp(i+1) := 'W';
         ELSIF (vec(i) = 'L') THEN
            stmp(i+1) := 'L';
         ELSIF (vec(i) = 'H') THEN
            stmp(i+1) := 'H';
         ELSE
            stmp(i+1) := '-';
         END IF;
      END LOOP;
      RETURN stmp;
   END;

END amba_comps;


--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/ccs_libs/interfaces/amba/ccs_axi4_slave_mem.vhd 

-- --------------------------------------------------------------------------
-- DESIGN UNIT:        ccs_axi4_slave_mem
--
-- DESCRIPTION:
--   This model implements an AXI-4 Slave memory interface for use in 
--   Interface Synthesis in Catapult. The component details are described in the datasheet.
--
--   AXI/Catapult read/write to the same address in the same cycle is non-determinant
--
-- Notes:
--  1. This model implements a local memory of size {cwidth x depth}.
--     If the Catapult operation requires a memory width cwidth <= AXI bus width
--     this model will zero-pad the high end bits as necessary.
-- CHANGE LOG:
--  01/29/19 - Add reset phase and separate base address for read/write channels
--  11/26/18 - Add burst and other tweaks
--  02/28/18 - Initial implementation
--
-- -------------------------------------------------------------------------------
--  Memory Organization
--   This model is designed to provide storage for only the bits/elements that
--   the Catapult core actually interacts with.
--   The user supplies a base address for the AXI memory store via BASE_ADDRESS
--   parameter.  
-- Example:
--   C++ array declared as "ac_int<7,false>  coeffs[4];"
--   results in a Catapult operator width (op_width) of 7,
--   and cwidth=7 and addr_w=2 (addressing 4 element locations).
--   The library forces DATA_WIDTH to be big enough to hold
--   cwidth bits, rounded up to power-of-2 as needed.
--
--   The AXI address scheme addresses bytes and so increments
--   by number-of-bytes per data transaction, plus the BASE_ADDRESS. 
--   The top and left describe the AXI view of the memory. 
--   The bottom and right describe the Catapult view of the memory.
--
--      AXI-4 SIGNALS
--      ADDR_WIDTH=4        DATA_WIDTH=32
--        AxADDR               xDATA
--                    31                       0
--                    +------------+-----------+
--      BA+0000       |            |           |
--                    +------------+-----------+
--      BA+0000       |            |           |
--                    +------------+===========+
--      BA+1100       |            |  elem3    |    11
--                    +------------+===========+
--      BA+1000       |            |  elem2    |    10
--                    +------------+===========+
--      BA+0100       |            |  elem1    |    01
--                    +------------+===========+
--      BA+0000       |            |  elem0    |    00
--                    +------------+===========+
--                                 6           0
--                                   s_din/out     s_addr
--                                   cwidth=7      addr_w=2
--                                         CATAPULT SIGNALS
--
-- -------------------------------------------------------------------------------

LIBRARY ieee;

  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;       
  USE std.textio.all;
  USE ieee.std_logic_textio.all;
  USE ieee.math_real.all;


USE work.amba_comps.all;

ENTITY ccs_axi4_slave_mem IS
  GENERIC(
    rscid           : integer                 := 1;    -- Resource ID
    -- Catapult Bus Configuration generics
    depth           : integer                 := 16;   -- Number of addressable elements (up to 20bit address)
    op_width        : integer range 1 to 1024 := 1;    -- dummy parameter for cwidth calculation
    cwidth          : integer range 1 to 1024 := 8;    -- Internal memory data width
    addr_w          : integer range 1 to 64   := 4;    -- Catapult address bus widths
    nopreload       : integer range 0 to 1    := 0;    -- 1= no preload before Catapult can read
    rst_ph          : integer range 0 to 1    := 0;    -- Reset phase.  1= Positive edge. Default is AXI negative edge
    -- AXI-4 Bus Configuration generics
    ADDR_WIDTH      : integer range 12 to 64  := 32;   -- AXI4 bus address width
    DATA_WIDTH      : integer range 8 to 1024 := 32;   -- AXI4 read&write data bus width
    ID_WIDTH        : integer range 1 to 16   := 1;    -- AXI4 ID field width (ignored in this model)
    USER_WIDTH      : integer range 1 to 32   := 1;    -- AXI4 User field width (ignored in this model)
    REGION_MAP_SIZE : integer range 1 to 15   := 1;    -- AXI4 Region Map (ignored in this model)
    wBASE_ADDRESS   : integer                 := 0;    -- AXI4 write channel base address alignment based on data bus width
    rBASE_ADDRESS   : integer                 := 0     -- AXI4 read channel base address alignment based on data bus width
    );
  PORT(
    -- AXI-4 Interface
    ACLK       : IN   std_logic;                                     -- Rising edge clock
    ARESETn    : IN   std_logic;                                     -- Active LOW asynchronous reset
    -- ============== AXI4 Write Address Channel Signals
    AWID       : IN   std_logic_vector(ID_WIDTH-1 downto 0);         -- Write address ID
    AWADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Write address
    AWLEN      : IN   std_logic_vector(7 downto 0);                  -- Write burst length
    AWSIZE     : IN   std_logic_vector(2 downto 0);                  -- Write burst size
    AWBURST    : IN   std_logic_vector(1 downto 0);                  -- Write burst mode
    AWLOCK     : IN   std_logic;                                     -- Lock type
    AWCACHE    : IN   std_logic_vector(3 downto 0);                  -- Memory type
    AWPROT     : IN   std_logic_vector(2 downto 0);                  -- Protection Type
    AWQOS      : IN   std_logic_vector(3 downto 0);                  -- Quality of Service
    AWREGION   : IN   std_logic_vector(3 downto 0);                  -- Region identifier
    AWUSER     : IN   std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
    AWVALID    : IN   std_logic;                                     -- Write address valid
    AWREADY    : OUT  std_logic;                                     -- Write address ready (slave is ready to accept AWADDR)
    -- ============== AXI4 Write Data Channel
    WDATA      : IN   std_logic_vector(DATA_WIDTH-1 downto 0);       -- Write data
    WSTRB      : IN   std_logic_vector((DATA_WIDTH/8)-1 downto 0);   -- Write strobe (bytewise)
    WLAST      : IN   std_logic;                                     -- Write last
    WUSER      : IN   std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
    WVALID     : IN   std_logic;                                     -- Write data is valid
    WREADY     : OUT  std_logic;                                     -- Write ready (slave is ready to accept WDATA)
    
    -- ============== AXI4 Write Response Channel Signals
    BID        : OUT  std_logic_vector(ID_WIDTH-1 downto 0);         -- Response ID tag
    BRESP      : OUT  std_logic_vector(1 downto 0);                  -- Write response (of slave)
    BUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
    BVALID     : OUT  std_logic;                                     -- Write response valid (slave accepted WDATA)
    BREADY     : IN   std_logic;                                     -- Response ready (master can accept slave's write response)
    
    -- ============== AXI4 Read Address Channel Signals
    ARID       : IN   std_logic_vector(ID_WIDTH-1 downto 0);         -- Read address ID
    ARADDR     : IN   std_logic_vector(ADDR_WIDTH-1 downto 0);       -- Read address
    ARLEN      : IN   std_logic_vector(7 downto 0);                  -- Read burst length
    ARSIZE     : IN   std_logic_vector(2 downto 0);                  -- Read burst size
    ARBURST    : IN   std_logic_vector(1 downto 0);                  -- Read burst mode
    ARLOCK     : IN   std_logic;                                     -- Lock type
    ARCACHE    : IN   std_logic_vector(3 downto 0);                  -- Memory type
    ARPROT     : IN   std_logic_vector(2 downto 0);                  -- Protection Type
    ARQOS      : IN   std_logic_vector(3 downto 0);                  -- Quality of Service
    ARREGION   : IN   std_logic_vector(3 downto 0);                  -- Region identifier
    ARUSER     : IN   std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
    ARVALID    : IN   std_logic;                                     -- Read address valid
    ARREADY    : OUT  std_logic;                                     -- Read address ready (slave is ready to accept ARADDR)
    
    -- ============== AXI4 Read Data Channel Signals
    RID        : OUT  std_logic_vector(ID_WIDTH-1 downto 0);         -- Read ID tag
    RDATA      : OUT  std_logic_vector(DATA_WIDTH-1 downto 0);       -- Read data
    RRESP      : OUT  std_logic_vector(1 downto 0);                  -- Read response (of slave)
    RLAST      : OUT  std_logic;                                     -- Read last
    RUSER      : OUT  std_logic_vector(USER_WIDTH-1 downto 0);       -- User signal
    RVALID     : OUT  std_logic;                                     -- Read valid (slave providing RDATA)
    RREADY     : IN   std_logic;                                     -- Read ready (master ready to receive RDATA)
    
    -- Catapult interface
    s_re      : IN   std_logic;                                      -- Catapult attempting read of slave memory
    s_we      : IN   std_logic;                                      -- Catapult attempting write to slave memory
    s_raddr   : IN   std_logic_vector(addr_w-1 downto 0);            -- Catapult addressing into memory (axi_addr = base_addr + s_raddr)
    s_waddr   : IN   std_logic_vector(addr_w-1 downto 0);            -- Catapult addressing into memory (axi_addr = base_addr + s_waddr)
    s_din     : OUT  std_logic_vector(cwidth-1 downto 0);            -- Data into catapult block through this interface
    s_dout    : IN   std_logic_vector(cwidth-1 downto 0);            -- Data out to slave from catapult
    s_rrdy    : OUT  std_logic;                                      -- Read data is valid
    s_wrdy    : OUT  std_logic;                                      -- Slave memory ready for write by Catapult (1=ready)
    is_idle   : OUT  std_logic;                                      -- component is idle - clock can be suppressed
    -- Transactor/scverify support
    tr_write_done : IN std_logic;                                    -- transactor resource preload write done
    s_tdone       : IN std_logic                                     -- Transaction_done in scverify
    );
  

    -- Always rule for checking component parameter values
    --  addr_w == bits(depth)
    --    used to ensure that the width of the address bus on the Catapult side
    --    is capable of addressing 'depth' number of elements. 'depth' will be
    --    determined by the array size operator parameter 'size'
    --    (see the PROP_MAP_size attribute)
    --  ADDR_WIDTH >= addr_w
    --    used to ensure that the address width of the Catapult side is
    --    large enough to accommodate the address width of the AXI-4 bus.
    --    (may need some work to align byte addresses)
    --  ADDR_WIDTH >= 32
    --    ensure that the minimum address space is 4k (AXI requirement)
    --  cwidth == 8 + (op_width>8)*8 + (op_width>16)*16 + (op_width>32)*32 + 
    --                (op_width>64)*64 + (op_width>128)*128 + (op_width>256)*256 +
    --                (op_width>512)*512
    --    used to "round up" the operator width 'op_width' to the next power
    --    of two value (8, 16, 32, 64, 128, 256, 512, 1024)
    --    (see the PROP_MAP_width attribute)
    --  DATA_WIDTH >= cwidth
    --    used to ensure that the Catapult data width is large enough to
    --    accommodate the data width of the AXI-4 bus.
    --    - must be power-of-2 bytes.
    --    - #bits must be some positive integer number of bytes.
    --     Note: user can override DATA_WIDTH from the MAP_TO_MODULE
    --     directive during interface synthesis. No checking is done
    --     to ensure that the override value is a power-of-2 bytes.

END ccs_axi4_slave_mem;

ARCHITECTURE rtl of ccs_axi4_slave_mem IS

  -- Signals for current and next state values
  TYPE   read_state_t IS (axi4r_idle, axi4r_read);
  TYPE   write_state_t IS (axi4w_idle, axi4w_write, axi4w_write_done,  axi4w_catwrite, axi4w_catwrite_done);
  SIGNAL read_state       : read_state_t;
  SIGNAL write_state      : write_state_t;

  -- Memory embedded in this slave
  TYPE   mem_type IS ARRAY (depth-1 downto 0) of std_logic_vector(cwidth-1 downto 0);
  SIGNAL mem                : mem_type;


  -- In/out connections and constant outputs  
  SIGNAL AWREADY_reg : std_logic;
  SIGNAL AWID_reg    : std_logic_vector(ID_WIDTH-1 downto 0);
  SIGNAL WREADY_reg  : std_logic;
  SIGNAL BRESP_reg   : std_logic_vector(1 downto 0);
  SIGNAL BVALID_reg  : std_logic;
  SIGNAL ARREADY_reg : std_logic;
  SIGNAL ARID_reg    : std_logic_vector(ID_WIDTH-1 downto 0);
  SIGNAL RDATA_reg   : std_logic_vector(DATA_WIDTH-1 downto 0);
  SIGNAL RRESP_reg   : std_logic_vector(1 downto 0);
  SIGNAL RLAST_reg   : std_logic;
  SIGNAL RVALID_reg  : std_logic;
  SIGNAL s_din_reg   : std_logic_vector(cwidth-1 downto 0);
  SIGNAL s_rrdy_reg  : std_logic;
  SIGNAL s_wrdy_reg  : std_logic;

  SIGNAL rCatOutOfOrder : std_logic;
  SIGNAL catIsReading   : std_logic;
  SIGNAL next_raddr     : integer;
  
  SIGNAL readBurstCnt: std_logic_vector(7 downto 0);   -- how many are left
  SIGNAL wbase_addr   : std_logic_vector(ADDR_WIDTH-1 downto 0);
  SIGNAL rbase_addr   : std_logic_vector(ADDR_WIDTH-1 downto 0);
  SIGNAL address     : std_logic_vector(ADDR_WIDTH-1 downto 0);
  SIGNAL addrShift : integer;
  SIGNAL readAddr : integer;
  SIGNAL writeAddr : integer;
  SIGNAL int_ARESETn : std_logic;
  
-- catapult address sizes are smaller and cause problems used with axi address sizes
  function extCatAddr(catAddr : std_logic_vector(addr_w -1 downto 0))
    return std_logic_vector is
  
    variable axiAddr : std_logic_vector(ADDR_WIDTH-1 downto 0);
  
  begin
    axiAddr := (others => '0');
    axiAddr(addr_w -1 downto 0) := catAddr;
    return axiAddr;
  end function extCatAddr;

BEGIN
  
  int_ARESETn <= ARESETn when (rst_ph = 0) else (not ARESETn);

  addrShift <= 0 when (DATA_WIDTH/8 <= 1)   else 
               1 when (DATA_WIDTH/8 <= 2)   else
               2 when (DATA_WIDTH/8 <= 4)   else
               3 when (DATA_WIDTH/8 <= 8)   else
               4 when (DATA_WIDTH/8 <= 16)  else
               5 when (DATA_WIDTH/8 <= 32)  else
               6 when (DATA_WIDTH/8 <= 64)  else
               7 when (DATA_WIDTH/8 <= 128) else
               0;

  -- unused outputs
  BUSER   <= (others => '0');
  RUSER   <= (others => '0');
  is_idle <= '0';
  
  AWREADY <= AWREADY_reg;
  WREADY  <= WREADY_reg ;
  BID     <= AWID_reg;
  BRESP   <= BRESP_reg  ;
  BVALID  <= BVALID_reg ;
  ARREADY <= ARREADY_reg;
  RID     <= ARID_reg;
  RDATA   <= RDATA_reg  ;
  RRESP   <= RRESP_reg  ;
  RLAST   <= RLAST_reg  ;
  RVALID  <= RVALID_reg ;
  s_din   <= s_din_reg  ;
  s_wrdy  <= s_wrdy_reg and (not s_tdone);
  s_rrdy  <= s_rrdy_reg and (not rCatOutOfOrder);

  wbase_addr <= std_logic_vector(to_unsigned(wBASE_ADDRESS, wbase_addr'length));
  rbase_addr <= std_logic_vector(to_unsigned(rBASE_ADDRESS, rbase_addr'length));
  
  -- pragma translate_off
  -- error checks.  Keep consistent with axi4_master.v/vhd
  -- all data widths the same
  errChk: process
    variable nBytes : std_logic_vector(31 downto 0);
    variable nBytes2 : std_logic_vector(31 downto 0);
  begin  -- process errChk
    nBytes := std_logic_vector(to_unsigned(DATA_WIDTH/8, 32));
    if (cwidth > DATA_WIDTH) then
      report  "Catapult(cwidth=" & integer'image(cwidth) & ") cannot be greater than AXI(DATA_BUS="
        & integer'image(DATA_WIDTH) & ")."
        severity error;
    end if;
    if ( (DATA_WIDTH mod 8) /= 0) then
      report  "Data bus width(DATA_WIDTH=" & integer'image(DATA_WIDTH) & ") not a discrete number of bytes."
        severity error;
    end if;
    if (to_integer(unsigned(nBytes)) = 0) then 
      report  "Data bus width(DATA_WIDTH=" & integer'image(DATA_WIDTH) & ") must be at least 1 byte."
        severity error;
    end if;
    nBytes2 := std_logic_vector(to_unsigned((DATA_WIDTH/8) - 1, 32));
    nBytes2 := nBytes  and nBytes2;
    if ( to_integer(unsigned(nBytes2)) /= 0) then
      report  "Data bus width must be power-of-2 number of bytes(DATA_WIDTH/8=" & integer'image(DATA_WIDTH/8) & ")"
        severity error;
    end if;
    if (ADDR_WIDTH < 12) then
      report  "AXI bus address width(ADDR_WIDTH=" & integer'image(ADDR_WIDTH) & ") must be at least 12 to address 4K memory space."
        severity error;
    end if;
    wait;
  end process errChk;
  -- pragma translate_on
  
  -- AXI4 Bus Read processing
  axiRead: process(ACLK, int_ARESETn)
    -- pragma translate_off
    variable buf : line;
    -- pragma translate_on
    variable useAddr : std_logic_vector(ADDR_WIDTH-1 downto 0);
    variable useAddr2 : std_logic_vector(ADDR_WIDTH-1 downto 0);
  begin
    if (int_ARESETn = '0') then
      read_state <= axi4r_idle;
      ARREADY_reg <= '1';
      ARID_reg <= (others => '0');
      RDATA_reg <= (others => '0');
      RRESP_reg <= AXI4_xRESP_OKAY;
      RLAST_reg <= '0';
      RVALID_reg <= '0';
      readAddr <= 0;
      readBurstCnt <= (others => '0');
    elsif rising_edge(ACLK) then
      if ((read_state = axi4r_idle) and (ARVALID = '1')) then
        useAddr := std_logic_vector(shift_right(unsigned(ARADDR) - unsigned(rbase_addr), addrShift));
        -- Protect from out of range addressing
        if (unsigned(useAddr) < depth) then
          if (cwidth < DATA_WIDTH) then
            RDATA_reg(DATA_WIDTH-1 downto cwidth) <= (others => '0');
            RDATA_reg(cwidth-1 downto 0) <= mem(to_integer(unsigned(useAddr)));
          else
            RDATA_reg <= mem(to_integer(unsigned(useAddr)));
          end if;
          --write(buf, string'("Slave AXI1 read:mem[0x"));
          --write(buf,  slv2hex(useAddr));
          --write(buf, string'("]=0x"));
          --write(buf,  slv2hex(mem(to_integer(unsigned(useAddr)))));
          --write(buf, string'(" at T="));
          --write(buf, now);
          --writeline(output, buf);
        else
          -- pragma translate_off
          write(buf, string'("Error:  Out-of-range AXI memory read access:0x"));
          write(buf,  slv2hex(ARADDR));
          write(buf, string'(" at T="));
          write(buf, now);
          writeline(output, buf);
          -- pragma translate_on
        end if;
        RRESP_reg <= AXI4_xRESP_OKAY;
        readAddr <= to_integer(unsigned(useAddr));
        readBurstCnt <= ARLEN;
        if (unsigned(ARLEN) = 0) then
          ARREADY_reg <= '0';
          RLAST_reg <= '1';
        end if;
        RVALID_reg <= '1';
        ARID_reg <= ARID;
        read_state <= axi4r_read;
      elsif (read_state = axi4r_read) then
        if (RREADY = '1') then
          if (unsigned(readBurstCnt) = 0) then
            -- we already sent the last data
            ARREADY_reg <= '1';
            RRESP_reg <= AXI4_xRESP_OKAY;
            RLAST_reg <= '0';
            RVALID_reg <= '0';
            read_state <= axi4r_idle;               
          else
            useAddr2 := std_logic_vector(to_unsigned(readAddr + 1, useAddr2'length));
            readAddr <= readAddr + 1;
            -- Protect from out of range addressing
            if (unsigned(useAddr2) < depth) then
              if (cwidth < DATA_WIDTH) then
                RDATA_reg(DATA_WIDTH-1 downto cwidth) <= (others => '0');
                RDATA_reg(cwidth-1 downto 0) <=  mem(to_integer(unsigned(useAddr2)));
              else
                RDATA_reg <=  mem(to_integer(unsigned(useAddr2)));
              end if;
              --write(buf, string'("Slave AXI2 read:mem[0x"));
              --write(buf,  slv2hex(useAddr2));
              --write(buf, string'("]=0x"));
              --write(buf,  slv2hex(mem(to_integer(unsigned(useAddr2)))));
              --write(buf, string'(" at T="));
              --write(buf, now);
              --writeline(output, buf);
            else
              -- We bursted right off the end of the array
              -- pragma translate_off
              write(buf, string'("Error:  Out-of-range AXI memory read access:0x"));
              write(buf,  slv2hex(ARADDR));
              write(buf, string'(" at T="));
              write(buf, now);
              writeline(output, buf);
              -- pragma translate_on
            end if;
            readBurstCnt <= std_logic_vector(unsigned(readBurstCnt) - 1);
            if ((unsigned(readBurstCnt) - 1) = 0) then
              ARREADY_reg <= '0';        
              RRESP_reg <= AXI4_xRESP_OKAY;
              RLAST_reg <= '1';
            end if;
            RVALID_reg <= '1';
          end if;
        end if;
      end if;
    end if;
  end process;  -- axiRead process

   -- AXI and catapult write processing.
   -- Catapult write is one-cycle long so basically a write can happen
   -- in any axi state.  AXI has precedence in that catapult write is processed
   -- first at each cycle
  axiWrite: process(ACLK, int_ARESETn)
    -- pragma translate_off
    variable buf : line;
    -- pragma translate_on
    variable i : integer;
    variable useAddr : std_logic_vector(ADDR_WIDTH-1 downto 0);
    variable useAddr2 : std_logic_vector(ADDR_WIDTH-1 downto 0);
  begin
    if (int_ARESETn = '0') then
      AWREADY_reg <= '1';
      AWID_reg <= (others => '0');
      WREADY_reg <= '1';
      BRESP_reg <= AXI4_xRESP_OKAY;
      BVALID_reg <= '0';
      write_state <= axi4w_idle;
      writeAddr <= 0;
      s_wrdy_reg <= '0';
      -- pragma translate_off
      for i in 0 to depth-1 loop 
        mem(i) <= (others => '0');
      end loop;
      -- pragma translate_on
    elsif rising_edge(ACLK) then
      -- When in idle state, catapult and AXI can both initiate writes.
      -- If to the same address, then AXI wins... in this implementation
      if ((s_we = '1') and (write_state = axi4w_idle) and (s_tdone = '0')) then
        mem(to_integer(unsigned(s_waddr))) <= s_dout;
        --write(buf, string'("Slave CAT1 write:mem[0x"));
        --write(buf,  slv2hex(s_waddr));
        --write(buf, string'("]=0x"));
        --write(buf,  slv2hex(s_dout));
        --write(buf, string'(" at T="));
        --write(buf, now);
        --writeline(output, buf);
      end if;
      if ((write_state = axi4w_idle) and (AWVALID = '1')) then
        s_wrdy_reg <= '0';
        AWREADY_reg <= '0';
        AWID_reg <= AWID;
        useAddr := std_logic_vector(shift_right(unsigned(AWADDR) - unsigned(wbase_addr), addrShift));
        -- $display("AWADDR=%d base_address=%d addrShift=%d useAddr=%d at T=%t",
        -- AWADDR, base_address, addrShift, useAddr, $time);
        if (WVALID = '1') then
          -- allow for address and data to be presented in one cycle
          -- Check for the write to be masked
          if (unsigned(WSTRB) /= 0) then -- a byte at a time.  Watch for cwidth much less than DATA_WIDTH
            if (unsigned(useAddr) < depth) then
              for i in 0 to (DATA_WIDTH/8)-1 loop 
                if (WSTRB(i) = '1') then
                  if ((8*i) < cwidth) then
                    if (8*(i+1) <= cwidth) then
                      mem(to_integer(unsigned(useAddr))) (8*(i+1)-1 downto (8*i)) <= WDATA(8*(i+1)-1 downto (8*i));
                    else
                      mem(to_integer(unsigned(useAddr))) (cwidth-1 downto (8*i)) <= WDATA(cwidth-1 downto (8*i));
                    end if;
                  end if;
                end if;
              end loop;
              
              --write(buf, string'("Slave AXI1 write:mem[0x"));
              --write(buf,  slv2hex(useAddr));
              --write(buf, string'("]=0x"));
              --write(buf,  slv2hex(WDATA));
              --write(buf, string'(" at T="));
              --write(buf, now);
              --writeline(output, buf);
            else
              -- pragma translate_off
              write(buf, string'("Error:  Out-of-range AXI memory write access:0x"));
              write(buf,  slv2hex(AWADDR));
              write(buf, string'(" at T="));
              write(buf, now);
              writeline(output, buf);
              -- pragma translate_on
            end if;
          end if;
        end if;
        writeAddr <= to_integer(unsigned(useAddr));
        if ((WLAST = '1') and (WVALID = '1')) then
          write_state <= axi4w_write_done;
          WREADY_reg <= '0';
          BRESP_reg <= AXI4_xRESP_OKAY;
          BVALID_reg <= '1';
        else
          write_state <= axi4w_write;
        end if;
      elsif (write_state = axi4w_write) then
        if (WVALID = '1') then
          useAddr2 := std_logic_vector(to_unsigned(writeAddr+1, useAddr2'length));
          if (unsigned(WSTRB) /= 0) then
            if (unsigned(useAddr2) < depth) then
              for i in 0 to (DATA_WIDTH/8)-1 loop 
                if (WSTRB(i) = '1') then
                  if ((8*i) < cwidth) then
                    if (8*(i+1) <= cwidth) then
                      mem(to_integer(unsigned(useAddr2))) (8*(i+1)-1 downto (8*i)) <= WDATA(8*(i+1)-1 downto (8*i));
                    else
                      mem(to_integer(unsigned(useAddr2))) (cwidth-1 downto (8*i)) <= WDATA(cwidth-1 downto (8*i));
                    end if;
                  end if;
                end if;
              end loop;
              --write(buf, string'("Slave AXI2 write:mem[0x"));
              --write(buf,  slv2hex(useAddr2));
              --write(buf, string'("]=0x"));
              --write(buf,  slv2hex(WDATA));
              --write(buf, string'(" at T="));
              --write(buf, now);
              --writeline(output, buf);
            else 
              -- pragma translate_off
              write(buf, string'("Error:  Out-of-range AXI memory write access:0x"));
              write(buf,  slv2hex(AWADDR));
              write(buf, string'(" at T="));
              write(buf, now);
              writeline(output, buf);
              -- pragma translate_on
            end if;
          end if;
          writeAddr <= to_integer(unsigned(useAddr2));
          if (WLAST = '1') then
            write_state <= axi4w_write_done;
            WREADY_reg <= '0';
            BRESP_reg <= AXI4_xRESP_OKAY;
            BVALID_reg <= '1';
          end if;
        end if;
      elsif (write_state = axi4w_write_done) then
        if (BREADY = '1') then
          AWREADY_reg <= '1';
          WREADY_reg <= '1';
          BRESP_reg <= AXI4_xRESP_OKAY;
          BVALID_reg <= '0';
          write_state <= axi4w_idle;
          s_wrdy_reg <= '1';
        end if;
      else
        s_wrdy_reg <= '1';
      end if;
    end if;
  end process; -- axiWrite

  rCatOutOfOrder <= '1' when (s_re = '1') and
                             (s_rrdy_reg = '1') and
                             (catIsReading = '1') and
                             (next_raddr /= to_integer(unsigned(extCatAddr(s_raddr)))+1)
                  else '0';
  
  -- Catapult read processing
  catRead : process(ACLK, int_ARESETn)
    -- pragma translate_off
    variable buf : line;
    -- pragma translate_on
  begin
    if (int_ARESETn = '0') then
      s_din_reg <= (others => '0');
      s_rrdy_reg <= '0';
      catIsReading <= '0';
      next_raddr <= 0;
    elsif rising_edge(ACLK) then
      -- Catapult has read access to memory
      if (tr_write_done = '1') then
        if ( s_re = '1') then
          --$display("Slave CAT read.  Addr=%x Data=%d T=%t", s_raddr, mem[s_raddr], $time);
          --write(buf, string'("Slave CAT read.  Addr=0x"));
          --write(buf,  slv2hex(s_raddr));
          --write(buf, string'(" Data=0x"));
          --write(buf,  slv2hex(mem(to_integer(unsigned(s_raddr)))));
          --write(buf, string'(" T="));
          --write(buf, now);
          --writeline(output, buf);
          if ((catIsReading = '1') and (rCatOutOfOrder /= '1')) then
            -- Make sure next_addr hasnt incremented off the end
            if (next_raddr < depth) then 
              s_din_reg <= mem(next_raddr);
              next_raddr <= next_raddr+1;
            else
              s_rrdy_reg <= '0';
              catIsReading <= '0';
              next_raddr <= 0;                  
            end if;
          else
            s_din_reg <= mem(to_integer(unsigned(s_raddr)));
            s_rrdy_reg <= '1';
            next_raddr <= to_integer(unsigned(extCatAddr(s_raddr)))+1;
            if ((catIsReading = '1') and (rCatOutOfOrder = '1')) then
              catIsReading <= '0';
            else
              catIsReading <= '1';
            end if;
          end if;
        else
          s_rrdy_reg <= '0';
          catIsReading <= '0';
          next_raddr <= 0;
        end if;
      else
        s_rrdy_reg <= '0';
        catIsReading <= '0';
        next_raddr <= 0;
      end if;
    end if;
  end process;    -- catRead 
  
END rtl;

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
PACKAGE mgc_io_sync_pkg_v2 IS

COMPONENT mgc_io_sync_v2
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END COMPONENT;

END mgc_io_sync_pkg_v2;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY mgc_io_sync_v2 IS
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END mgc_io_sync_v2;

ARCHITECTURE beh OF mgc_io_sync_v2 IS
BEGIN

  lz <= ld;

END beh;


--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_in_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_in_pkg_v1 IS

COMPONENT ccs_in_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    idat   : OUT std_logic_vector(width-1 DOWNTO 0);
    dat    : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

END ccs_in_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_in_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    idat  : OUT std_logic_vector(width-1 DOWNTO 0);
    dat   : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END ccs_in_v1;

ARCHITECTURE beh OF ccs_in_v1 IS
BEGIN

  idat <= dat;

END beh;


--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/src/funcs.vhd 

-- a package of attributes that give verification tools a hint about
-- the function being implemented
PACKAGE attributes IS
  ATTRIBUTE CALYPTO_FUNC : string;
  ATTRIBUTE CALYPTO_DATA_ORDER : string;
end attributes;

-----------------------------------------------------------------------
-- Package that declares synthesizable functions needed for RTL output
-----------------------------------------------------------------------

LIBRARY ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

   FUNCTION maximum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION minimum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER;
   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2 : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
   
-----------------------------------------------------------------
-- logic functions
-----------------------------------------------------------------

   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION or_v (inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- mux functions
-----------------------------------------------------------------

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC_VECTOR;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- latch functions
-----------------------------------------------------------------
   FUNCTION lat_s(dinput: STD_LOGIC       ; clk: STD_LOGIC; doutput: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- tristate functions
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC       ; control: STD_LOGIC) RETURN STD_LOGIC;
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: SIGNED  ) RETURN STD_LOGIC;

   -- RETURN 2 bits (left => lt, right => eq)
   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED;
 
   FUNCTION fabs(arg1: SIGNED  ) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "**" (l, r: UNSIGNED) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "**" (l, r: SIGNED  ) RETURN SIGNED  ;

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-- *_stdar functions use shift functions from std_logic_arith
-----------------------------------------------------------------

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;

   -----------------------------------------------------------------
   -- *_stdar functions use shift functions from std_logic_arith
   -----------------------------------------------------------------
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC;
   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE;
   --FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR ;

   FUNCTION ceil_log2(size : NATURAL) return NATURAL;
   FUNCTION bits(size : NATURAL) return NATURAL;    

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   
END funcs;


--------------------------- B O D Y ----------------------------


PACKAGE BODY funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC IS
     BEGIN IF arg1 THEN RETURN '1'; ELSE RETURN '0'; END IF; END;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
--     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;

   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
     VARIABLE result: STD_LOGIC_VECTOR(0 DOWNTO 0);
   BEGIN
     result := (0 => arg1);
     RETURN result;
   END;

   FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 > arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION minimum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 < arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 = arg2) THEN
       RETURN(seleq) ;
     ELSE
       RETURN(selne) ;
     END IF;
   END;

   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := input1'LENGTH;
     ALIAS input1a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input1;
     ALIAS input2a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input2;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     --synopsys translate_off
     FOR i IN len-1 DOWNTO 0 LOOP
       result(i) := resolved(input1a(i) & input2a(i));
     END LOOP;
     --synopsys translate_on
     RETURN result;
   END;

   FUNCTION resolve_unsigned(input1: UNSIGNED; input2: UNSIGNED) RETURN UNSIGNED IS
   BEGIN RETURN UNSIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

   FUNCTION resolve_signed(input1: SIGNED; input2: SIGNED) RETURN SIGNED IS
   BEGIN RETURN SIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

-----------------------------------------------------------------
-- Logic Functions
-----------------------------------------------------------------

   FUNCTION "not"(arg1: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN UNSIGNED(not STD_LOGIC_VECTOR(arg1)); END;
   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(and_v(inputs, 1)); END;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(or_v(inputs, 1)); END;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(xor_v(inputs, 1)); END;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result AND inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

   FUNCTION or_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     -- this if is added as a quick fix for a bug in catapult evaluating the loop even if inputs'LENGTH==1
     -- see dts0100971279
     IF icnt2 > 1 THEN
       FOR i IN icnt2-1 DOWNTO 1 LOOP
         inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
         result := result OR inputsx(olenM1 DOWNTO 0);
       END LOOP;
     END IF;
     RETURN result;
   END;

   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result XOR inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

-----------------------------------------------------------------
-- Muxes
-----------------------------------------------------------------
   
   FUNCTION mux_sel2_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(1 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 4;
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector( size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "01" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "10" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "11" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel3_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(2 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 8;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "001" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "010" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "011" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN "100" =>
       result := inputs0(5*size-1 DOWNTO 4*size);
     WHEN "101" =>
       result := inputs0(6*size-1 DOWNTO 5*size);
     WHEN "110" =>
       result := inputs0(7*size-1 DOWNTO 6*size);
     WHEN "111" =>
       result := inputs0(8*size-1 DOWNTO 7*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel4_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(3 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 16;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "0000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "0001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "0010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "0011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "0100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "0101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "0110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "0111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "1000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "1001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "1010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "1011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "1100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "1101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "1110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "1111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel5_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(4 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 32;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0 );
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "00001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "00010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "00011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "00100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "00101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "00110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "00111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "01000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "01001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "01010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "01011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "01100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "01101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "01110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "01111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "10000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "10001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "10010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "10011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "10100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "10101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "10110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "10111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "11000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "11001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "11010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "11011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "11100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "11101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "11110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "11111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel6_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(5 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 64;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "000001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "000010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "000011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "000100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "000101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "000110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "000111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "001000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "001001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "001010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "001011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "001100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "001101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "001110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "001111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "010000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "010001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "010010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "010011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "010100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "010101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "010110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "010111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "011000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "011001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "011010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "011011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "011100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "011101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "011110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "011111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN "100000" =>
       result := inputs0( 33*size-1 DOWNTO 32*size);
     WHEN "100001" =>
       result := inputs0( 34*size-1 DOWNTO 33*size);
     WHEN "100010" =>
       result := inputs0( 35*size-1 DOWNTO 34*size);
     WHEN "100011" =>
       result := inputs0( 36*size-1 DOWNTO 35*size);
     WHEN "100100" =>
       result := inputs0( 37*size-1 DOWNTO 36*size);
     WHEN "100101" =>
       result := inputs0( 38*size-1 DOWNTO 37*size);
     WHEN "100110" =>
       result := inputs0( 39*size-1 DOWNTO 38*size);
     WHEN "100111" =>
       result := inputs0( 40*size-1 DOWNTO 39*size);
     WHEN "101000" =>
       result := inputs0( 41*size-1 DOWNTO 40*size);
     WHEN "101001" =>
       result := inputs0( 42*size-1 DOWNTO 41*size);
     WHEN "101010" =>
       result := inputs0( 43*size-1 DOWNTO 42*size);
     WHEN "101011" =>
       result := inputs0( 44*size-1 DOWNTO 43*size);
     WHEN "101100" =>
       result := inputs0( 45*size-1 DOWNTO 44*size);
     WHEN "101101" =>
       result := inputs0( 46*size-1 DOWNTO 45*size);
     WHEN "101110" =>
       result := inputs0( 47*size-1 DOWNTO 46*size);
     WHEN "101111" =>
       result := inputs0( 48*size-1 DOWNTO 47*size);
     WHEN "110000" =>
       result := inputs0( 49*size-1 DOWNTO 48*size);
     WHEN "110001" =>
       result := inputs0( 50*size-1 DOWNTO 49*size);
     WHEN "110010" =>
       result := inputs0( 51*size-1 DOWNTO 50*size);
     WHEN "110011" =>
       result := inputs0( 52*size-1 DOWNTO 51*size);
     WHEN "110100" =>
       result := inputs0( 53*size-1 DOWNTO 52*size);
     WHEN "110101" =>
       result := inputs0( 54*size-1 DOWNTO 53*size);
     WHEN "110110" =>
       result := inputs0( 55*size-1 DOWNTO 54*size);
     WHEN "110111" =>
       result := inputs0( 56*size-1 DOWNTO 55*size);
     WHEN "111000" =>
       result := inputs0( 57*size-1 DOWNTO 56*size);
     WHEN "111001" =>
       result := inputs0( 58*size-1 DOWNTO 57*size);
     WHEN "111010" =>
       result := inputs0( 59*size-1 DOWNTO 58*size);
     WHEN "111011" =>
       result := inputs0( 60*size-1 DOWNTO 59*size);
     WHEN "111100" =>
       result := inputs0( 61*size-1 DOWNTO 60*size);
     WHEN "111101" =>
       result := inputs0( 62*size-1 DOWNTO 61*size);
     WHEN "111110" =>
       result := inputs0( 63*size-1 DOWNTO 62*size);
     WHEN "111111" =>
       result := inputs0( 64*size-1 DOWNTO 63*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS  --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2 SEVERITY FAILURE;
     --synopsys translate_on
       CASE sel IS
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0( size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1  DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0(size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
       RETURN result;
   END;
--   BEGIN RETURN mux_v(inputs, TO_STDLOGICVECTOR(sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     ALIAS    sel0   : STD_LOGIC_VECTOR( sel'LENGTH-1 DOWNTO 0 ) IS sel;

     VARIABLE sellen : INTEGER RANGE 2-sel'LENGTH TO sel'LENGTH;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2**sel'LENGTH;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
     TYPE inputs_array_type is array(natural range <>) of std_logic_vector( olen - 1 DOWNTO 0);
     VARIABLE inputs_array : inputs_array_type( 2**sel'LENGTH - 1 DOWNTO 0);
   BEGIN
     sellen := sel'LENGTH;
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2**sellen SEVERITY FAILURE;
     sellen := 2-sellen;
     --synopsys translate_on
     CASE sellen IS
     WHEN 1 =>
       CASE sel0(0) IS

       WHEN '1' 
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0(  size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1 DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0( size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
     WHEN 2 =>
       result := mux_sel2_v(inputs, not sel);
     WHEN 3 =>
       result := mux_sel3_v(inputs, not sel);
     WHEN 4 =>
       result := mux_sel4_v(inputs, not sel);
     WHEN 5 =>
       result := mux_sel5_v(inputs, not sel);
     WHEN 6 =>
       result := mux_sel6_v(inputs, not sel);
     WHEN others =>
       -- synopsys translate_off
       IF(Is_X(sel0)) THEN
         result := (others => 'X');
       ELSE
       -- synopsys translate_on
         FOR i in 0 to 2**sel'LENGTH - 1 LOOP
           inputs_array(i) := inputs0( ((i + 1) * olen) - 1  DOWNTO i*olen);
         END LOOP;
         result := inputs_array(CONV_INTEGER( (UNSIGNED(NOT sel0)) ));
       -- synopsys translate_off
       END IF;
       -- synopsys translate_on
     END CASE;
     RETURN result;
   END;

 
-----------------------------------------------------------------
-- Latches
-----------------------------------------------------------------

   FUNCTION lat_s(dinput: STD_LOGIC; clk: STD_LOGIC; doutput: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN mux_s(STD_LOGIC_VECTOR'(doutput & dinput), clk); END;

   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR ; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     --synopsys translate_off
     ASSERT dinput'LENGTH = doutput'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN mux_v(doutput & dinput, clk);
   END;

-----------------------------------------------------------------
-- Tri-States
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC; control: STD_LOGIC) RETURN STD_LOGIC IS
--   BEGIN RETURN TO_STDLOGIC(tri_v(TO_STDLOGICVECTOR(dinput), control)); END;
--
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR ; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
--     VARIABLE result: STD_LOGIC_VECTOR(dinput'range);
--   BEGIN
--     CASE control IS
--     WHEN '0' | 'L' =>
--       result := (others => 'Z');
--     WHEN '1' | 'H' =>
--       FOR i IN dinput'range LOOP
--         result(i) := to_UX01(dinput(i));
--       END LOOP;
--     WHEN others =>
--       -- synopsys translate_off
--       result := (others => 'X');
--       -- synopsys translate_on
--     END CASE;
--     RETURN result;
--   END;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;

   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     VARIABLE diff: UNSIGNED(l'LENGTH DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     diff := ('0'&l) - ('0'&r);
     RETURN diff(l'LENGTH);
   END;
   FUNCTION "<"(l, r: SIGNED  ) RETURN STD_LOGIC IS
   BEGIN
     RETURN (UNSIGNED(l) < UNSIGNED(r)) xor (l(l'LEFT) xor r(r'LEFT));
   END;

   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION "<=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">"(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;
   FUNCTION ">=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;

   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN not or_s(l xor r);
   END;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   --some functions to placate spyglass
   FUNCTION mult_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a*b;
   END mult_natural;

   FUNCTION div_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a/b;
   END div_natural;

   FUNCTION mod_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a mod b;
   END mod_natural;

   FUNCTION add_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a+b;
   END add_unsigned;

   FUNCTION sub_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a-b;
   END sub_unsigned;

   FUNCTION sub_int(a,b : INTEGER) RETURN INTEGER IS
   BEGIN
     return a-b;
   END sub_int;

   FUNCTION concat_0(b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return '0' & b;
   END concat_0;

   FUNCTION concat_uns(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a&b;
   END concat_uns;

   FUNCTION concat_vect(a,b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     return a&b;
   END concat_vect;





   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED IS
     CONSTANT ninps : NATURAL := arg'LENGTH / width;
     ALIAS    arg0  : UNSIGNED(arg'LENGTH-1 DOWNTO 0) IS arg;
     VARIABLE result: UNSIGNED(width-1 DOWNTO 0);
     VARIABLE from  : INTEGER;
     VARIABLE dto   : INTEGER;
   BEGIN
     --synopsys translate_off
     ASSERT arg'LENGTH = width * ninps SEVERITY FAILURE;
     --synopsys translate_on
     result := (OTHERS => '0');
     FOR i IN ninps-1 DOWNTO 0 LOOP
       --result := result + arg0((i+1)*width-1 DOWNTO i*width);
       from := mult_natural((i+1), width)-1; --2.1.6.3
       dto  := mult_natural(i,width); --2.1.6.3
       result := add_unsigned(result , arg0(from DOWNTO dto) );
     END LOOP;
     RETURN result;
   END faccu;

   FUNCTION  fabs (arg1: SIGNED) RETURN UNSIGNED IS
   BEGIN
     CASE arg1(arg1'LEFT) IS
     WHEN '1'
     --synopsys translate_off
          | 'H'
     --synopsys translate_on
       =>
       RETURN UNSIGNED'("0") - UNSIGNED(arg1);
     WHEN '0'
     --synopsys translate_off
          | 'L'
     --synopsys translate_on
       =>
       RETURN UNSIGNED(arg1);
     WHEN others =>
       RETURN resolve_unsigned(UNSIGNED(arg1), UNSIGNED'("0") - UNSIGNED(arg1));
     END CASE;
   END;

   PROCEDURE divmod(l, r: UNSIGNED; rdiv, rmod: OUT UNSIGNED) IS
     CONSTANT llen: INTEGER := l'LENGTH;
     CONSTANT rlen: INTEGER := r'LENGTH;
     CONSTANT llen_plus_rlen: INTEGER := llen + rlen;
     VARIABLE lbuf: UNSIGNED(llen+rlen-1 DOWNTO 0);
     VARIABLE diff: UNSIGNED(rlen DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT rdiv'LENGTH = llen AND rmod'LENGTH = rlen SEVERITY FAILURE;
     --synopsys translate_on
     lbuf := (others => '0');
     lbuf(llen-1 DOWNTO 0) := l;
     FOR i IN rdiv'range LOOP
       diff := sub_unsigned(lbuf(llen_plus_rlen-1 DOWNTO llen-1) ,(concat_0(r)));
       rdiv(i) := not diff(rlen);
       IF diff(rlen) = '0' THEN
         lbuf(llen_plus_rlen-1 DOWNTO llen-1) := diff;
       END IF;
       lbuf(llen_plus_rlen-1 DOWNTO 1) := lbuf(llen_plus_rlen-2 DOWNTO 0);
     END LOOP;
     rmod := lbuf(llen_plus_rlen-1 DOWNTO llen);
   END divmod;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rdiv;
   END "/";

   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rmod;
   END;

   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN l MOD r; END;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rdiv := UNSIGNED'("0") - rdiv;
     END IF;
     RETURN SIGNED(rdiv); -- overflow problem "1000" / "11"
   END "/";

   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
     CONSTANT rnul: UNSIGNED(r'LENGTH-1 DOWNTO 0) := (others => '0');
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     IF rmod /= rnul AND to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rmod := UNSIGNED(r) + rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "MOD";

   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "REM";

   FUNCTION mult_unsigned(l,r : UNSIGNED) return UNSIGNED is
   BEGIN
     return l*r; 
   END mult_unsigned;

   FUNCTION "**" (l, r : UNSIGNED) RETURN UNSIGNED IS
     CONSTANT llen  : NATURAL := l'LENGTH;
     VARIABLE result: UNSIGNED(llen-1 DOWNTO 0);
     VARIABLE fak   : UNSIGNED(llen-1 DOWNTO 0);
   BEGIN
     fak := l;
     result := (others => '0'); result(0) := '1';
     FOR i IN r'reverse_range LOOP
       --was:result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(result & (result*fak)), r(i)));
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR( concat_uns(result , mult_unsigned(result,fak) )), r(i)));

       fak := mult_unsigned(fak , fak);
     END LOOP;
     RETURN result;
   END "**";

   FUNCTION "**" (l, r : SIGNED) RETURN SIGNED IS
     CONSTANT rlen  : NATURAL := r'LENGTH;
     ALIAS    r0    : SIGNED(0 TO r'LENGTH-1) IS r;
     VARIABLE result: SIGNED(l'range);
   BEGIN
     CASE r(r'LEFT) IS
     WHEN '0'
   --synopsys translate_off
          | 'L'
   --synopsys translate_on
     =>
       result := SIGNED(UNSIGNED(l) ** UNSIGNED(r0(1 TO r'LENGTH-1)));
     WHEN '1'
   --synopsys translate_off
          | 'H'
   --synopsys translate_on
     =>
       result := (others => '0');
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END "**";

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-----------------------------------------------------------------

   FUNCTION add_nat(arg1 : NATURAL; arg2 : NATURAL ) RETURN NATURAL IS
   BEGIN
     return (arg1 + arg2);
   END;
   
--   FUNCTION UNSIGNED_2_BIT_VECTOR(arg1 : NATURAL; arg2 : NATURAL ) RETURN BIT_VECTOR IS
--   BEGIN
--     return (arg1 + arg2);
--   END;
   
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(SIGNED(result), arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: SIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: SIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
        =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
        =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;


   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     --SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: NATURAL range 1 TO len;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => '0');
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         --was:temp(i2+sw) := result(i2);
         temp_idx := add_nat(i2,sw);
         temp(temp_idx) := result(i2);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: sw_range;
     VARIABLE result_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => sbit);
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         -- was: temp(i2) := result(i2+sw);
         result_idx := add_nat(i2,sw);
         temp(i2) := result(result_idx);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;


   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := arg1'LENGTH;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     VARIABLE temp: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     SUBTYPE sw_range IS NATURAL range 0 TO len-1;
     VARIABLE sw: sw_range;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     result := (others=>'0');
     result := arg1;
     sw := sdir MOD len;
     FOR i IN arg2'reverse_range LOOP
       EXIT WHEN sw = 0;
       IF signd2 AND i = arg2'LEFT THEN 
         sw := sub_int(len,sw); 
       END IF;
       -- temp := result(len-sw-1 DOWNTO 0) & result(len-1 DOWNTO len-sw)
       FOR i2 IN len-1 DOWNTO 0 LOOP
         --was: temp((i2+sw) MOD len) := result(i2);
         temp_idx := add_nat(i2,sw) MOD len;
         temp(temp_idx) := result(i2);
       END LOOP;
       result := mux_v(STD_LOGIC_VECTOR(concat_vect(result,temp)), arg2(i));
       sw := mod_natural(mult_natural(sw,2), len);
     END LOOP;
     RETURN result;
   END frot;

   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, -1); END;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, -1); END;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC IS
     CONSTANT len : INTEGER := vec'LENGTH;
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
   BEGIN
     IF index >= len OR index < 0 THEN
       RETURN 'X';
     END IF;
     RETURN vec0(index);
   END;

   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     CONSTANT indexPwidthM1 : INTEGER := index+width-1; --2.1.6.3
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
     CONSTANT xxx : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (others => 'X');
   BEGIN
     IF index+width > len OR index < 0 THEN
       RETURN xxx;
     END IF;
     RETURN vec0(indexPwidthM1 DOWNTO index);
   END;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     VARIABLE vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     CONSTANT xxx : STD_LOGIC_VECTOR(len-1 DOWNTO 0) := (others => 'X');
   BEGIN
     vec0 := vec;
     IF index >= len OR index < 0 THEN
       RETURN xxx;
     END IF;
     vec0(index) := dinput;
     RETURN vec0;
   END;

   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE IS
     VARIABLE n_b : POSITIVE;
     VARIABLE p_v : NATURAL;
   BEGIN
     p_v := p;
     FOR i IN 1 TO 32 LOOP
       p_v := div_natural(p_v,2);
       n_b := i;
       EXIT WHEN (p_v = 0);
     END LOOP;
     RETURN n_b;
   END;


--   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
--
--     CONSTANT vlen: INTEGER := vec'LENGTH;
--     CONSTANT ilen: INTEGER := dinput'LENGTH;
--     CONSTANT max_shift: INTEGER := vlen-ilen;
--     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
--     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
--     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
--     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
--     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
--     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
--   BEGIN
--     inp := (others => '0');
--     mask := (others => '0');
--
--     IF index > max_shift OR index < 0 THEN
--       RETURN xxx;
--     END IF;
--
--     shift := CONV_UNSIGNED(index, shift'LENGTH);
--     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
--     mask(ilen-1 DOWNTO 0) := ones;
--     inp := fshl(inp, shift, vlen);
--     mask := fshl(mask, shift, vlen);
--     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
--     RETURN vec0;
--   END;

   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR IS

     type enable_matrix is array (0 to enable'LENGTH-1 ) of std_logic_vector(byte_width-1 downto 0);
     CONSTANT vlen: INTEGER := vec'LENGTH;
     CONSTANT ilen: INTEGER := dinput'LENGTH;
     CONSTANT max_shift: INTEGER := vlen-ilen;
     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask2: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE enables: enable_matrix;
     VARIABLE cat_enables: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0 );
     VARIABLE lsbi : INTEGER;
     VARIABLE msbi : INTEGER;

   BEGIN
     cat_enables := (others => '0');
     lsbi := 0;
     msbi := byte_width-1;
     inp := (others => '0');
     mask := (others => '0');

     IF index > max_shift OR index < 0 THEN
       RETURN xxx;
     END IF;

     --initialize enables
     for i in 0 TO (enable'LENGTH-1) loop
       enables(i)  := (others => enable(i));
       cat_enables(msbi downto lsbi) := enables(i) ;
       lsbi := msbi+1;
       msbi := msbi+byte_width;
     end loop;


     shift := CONV_UNSIGNED(index, shift'LENGTH);
     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
     mask(ilen-1 DOWNTO 0) := UNSIGNED((STD_LOGIC_VECTOR(ones) AND cat_enables));
     inp := fshl(inp, shift, vlen);
     mask := fshl(mask, shift, vlen);
     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
     RETURN vec0;
   END;


   FUNCTION ceil_log2(size : NATURAL) return NATURAL is
     VARIABLE cnt : NATURAL;
     VARIABLE res : NATURAL;
   begin
     cnt := 1;
     res := 0;
     while (cnt < size) loop
       res := res + 1;
       cnt := 2 * cnt;
     end loop;
     return res;
   END;
   
   FUNCTION bits(size : NATURAL) return NATURAL is
   begin
     return ceil_log2(size);
   END;

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH) xor conv_std_logic_vector(c, s'LENGTH);
     cout := ( (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH)) or (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) or (conv_std_logic_vector(b, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) );
   END PROCEDURE csa;

   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH);
     cout := (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH));
   END PROCEDURE csha;

END funcs;

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_comps.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;

PACKAGE mgc_comps IS
 
FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER;
FUNCTION ceil_log2(size : NATURAL) return NATURAL;
 

COMPONENT mgc_not
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_and
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nand
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_or
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xnor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux
  GENERIC (
    width  :  NATURAL;
    ctrlw  :  NATURAL;
    p2ctrlw : NATURAL := 0
  );
  PORT (
    a: in  std_logic_vector(width*(2**ctrlw) - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw            - 1 DOWNTO 0);
    z: out std_logic_vector(width            - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux1hot
  GENERIC (
    width  : NATURAL;
    ctrlw  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ctrlw - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw       - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_reg_pos
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;  -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL  -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_reg_neg
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;   -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_generic_reg
  GENERIC(
   width: natural := 8;
   ph_clk: integer range 0 to 1 := 1; -- clock polarity, 1=rising_edge
   ph_en: integer range 0 to 1 := 1;
   ph_a_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   ph_s_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   a_rst_used: integer range 0 to 1 := 1;
   s_rst_used: integer range 0 to 1 := 0;
   en_used: integer range 0 to 1 := 1
  );
  PORT(
   d: std_logic_vector(width-1 downto 0);
   clk: in std_logic;
   en: in std_logic;
   a_rst: in std_logic;
   s_rst: in std_logic;
   q: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_equal
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a : in  std_logic_vector(width-1 DOWNTO 0);
    b : in  std_logic_vector(width-1 DOWNTO 0);
    eq: out std_logic;
    ne: out std_logic
  );
END COMPONENT;

COMPONENT mgc_shift_l
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_r
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_bl
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_br
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rot
  GENERIC (
    width  : NATURAL;
    width_s: NATURAL;
    signd_s: NATURAL;      -- 0:unsigned 1:signed
    sleft  : NATURAL;      -- 0:right 1:left;
    log2w  : NATURAL := 0; -- LOG2(width)
    l2wp2  : NATURAL := 0  --2**LOG2(width)
  );
  PORT (
    a : in  std_logic_vector(width  -1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width  -1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_sub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_ci
  GENERIC (
    width_a : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width_a, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width_a, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width_a,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width_a,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_addc
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add3
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_c : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_c : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(ifeqsel(width_c,0,width,width_c)-1 DOWNTO 0);
    d: in  std_logic_vector(0 DOWNTO 0);
    e: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_sub_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addc_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     c: in std_logic_vector(0 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addsub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    add: in  std_logic;
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_accu
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_abs
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_fast
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_pipe
  GENERIC (
    width_a       : NATURAL;
    signd_a       : NATURAL;
    width_b       : NATURAL;
    signd_b       : NATURAL;
    width_z       : NATURAL; -- <= width_a + width_b
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 

  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;
    s_rst : in  std_logic;
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2add1
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    isadd   : NATURAL;
    add_b2  : NATURAL;
    add_d2  : NATURAL
  );
  PORT (
    a   : in  std_logic_vector(width_a-1 DOWNTO 0);
    b   : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2  : in  std_logic_vector(width_b2-1 DOWNTO 0);
    c   : in  std_logic_vector(width_c-1 DOWNTO 0);
    d   : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2  : in  std_logic_vector(width_d2-1 DOWNTO 0);
    cst : in  std_logic_vector(width_e-1 DOWNTO 0);
    z   : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2add1_pipe
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c + width_d)+1
    isadd   : NATURAL;
    add_b2   : NATURAL;
    add_d2   : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2     : in  std_logic_vector(width_b2-1 DOWNTO 0);
    c     : in  std_logic_vector(width_c-1 DOWNTO 0);
    d     : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2     : in  std_logic_vector(width_d2-1 DOWNTO 0);
    cst   : in  std_logic_vector(width_e-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;
    s_rst : in  std_logic;
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_muladd1
  -- operation is z = a * (b + d) + c + cst
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_cst : NATURAL;
    signd_cst : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c, width_cst)+1
    add_axb : NATURAL;
    add_c   : NATURAL;
    add_d   : NATURAL
  );
  PORT (
    a:   in  std_logic_vector(width_a-1 DOWNTO 0);
    b:   in  std_logic_vector(width_b-1 DOWNTO 0);
    c:   in  std_logic_vector(width_c-1 DOWNTO 0);
    cst: in  std_logic_vector(width_cst-1 DOWNTO 0);
    d:   in  std_logic_vector(width_d-1 DOWNTO 0);
    z:   out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_muladd1_pipe
  -- operation is z = a * (b + d) + c + cst
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_cst : NATURAL;
    signd_cst : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c, width_cst)+1
    add_axb : NATURAL;
    add_c   : NATURAL;
    add_d   : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    c     : in  std_logic_vector(width_c-1 DOWNTO 0);
    cst   : in  std_logic_vector(width_cst-1 DOWNTO 0);
    d     : in  std_logic_vector(width_d-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;
    s_rst : in  std_logic;
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mulacc_pipe
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a         : in  std_logic_vector(width_a-1 DOWNTO 0);
    b         : in  std_logic_vector(width_b-1 DOWNTO 0);
    c         : in  std_logic_vector(width_c-1 DOWNTO 0);
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic;
    s_rst     : in  std_logic;
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2acc_pipe
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    add_cxd : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a         : in  std_logic_vector(width_a-1 DOWNTO 0);
    b         : in  std_logic_vector(width_b-1 DOWNTO 0);
    c         : in  std_logic_vector(width_c-1 DOWNTO 0);
    d         : in  std_logic_vector(width_d-1 DOWNTO 0);
    e         : in  std_logic_vector(width_e-1 DOWNTO 0);
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic;
    s_rst     : in  std_logic;
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_div
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_a-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mod
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rem
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_csa
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     c: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_csha
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_rom
    GENERIC (
      rom_id : natural := 1;
      size : natural := 33;
      width : natural := 32
      );
    PORT (
      data_in : std_logic_vector((size*width)-1 downto 0);
      addr : std_logic_vector(ceil_log2(size)-1 downto 0);
      data_out : out std_logic_vector(width-1 downto 0)
    );
END COMPONENT;

END mgc_comps;

PACKAGE BODY mgc_comps IS
 
   FUNCTION ceil_log2(size : NATURAL) return NATURAL is
     VARIABLE cnt : NATURAL;
     VARIABLE res : NATURAL;
   begin
     cnt := 1;
     res := 0;
     while (cnt < size) loop
       res := res + 1;
       cnt := 2 * cnt;
     end loop;
     return res;
   END;

   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 = arg2) THEN
       RETURN(seleq) ;
     ELSE
       RETURN(selne) ;
     END IF;
   END;
 
END mgc_comps;

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_rem_beh.vhd 

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_rem IS
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END mgc_rem;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

USE work.funcs.all;

ARCHITECTURE beh OF mgc_rem IS
BEGIN
  z <= std_logic_vector(unsigned(a) rem unsigned(b)) WHEN signd = 0 ELSE
       std_logic_vector(  signed(a) rem   signed(b));
END beh;

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_shift_comps_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;

PACKAGE mgc_shift_comps_v5 IS

COMPONENT mgc_shift_l_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_r_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_bl_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_br_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

END mgc_shift_comps_v5;

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_shift_l_v5 IS
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END mgc_shift_l_v5;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

ARCHITECTURE beh OF mgc_shift_l_v5 IS

  FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1 > arg2) THEN
      RETURN(arg1) ;
    ELSE
      RETURN(arg2) ;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: SIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(SIGNED(result), arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE)
  RETURN UNSIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, '0', olen);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE)
  RETURN SIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen);
  END;

BEGIN
UNSGNED:  IF signd_a = 0 GENERATE
    z <= std_logic_vector(fshl_stdar(unsigned(a), unsigned(s), width_z));
  END GENERATE;
SGNED:  IF signd_a /= 0 GENERATE
    z <= std_logic_vector(fshl_stdar(  signed(a), unsigned(s), width_z));
  END GENERATE;
END beh;

--------> ./rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.5c/896140 Production Release
--  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
-- 
--  Generated by:   yl7897@newnano.poly.edu
--  Generated date: Thu Aug 19 16:48:15 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    COMP_LOOP_C_38_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_77_tr0 : IN STD_LOGIC;
    VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
    STAGE_LOOP_C_1_tr0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_core_fsm;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for inPlaceNTT_DIT_precomp_core_core_fsm_1
  TYPE inPlaceNTT_DIT_precomp_core_core_fsm_1_ST IS (main_C_0, STAGE_LOOP_C_0, COMP_LOOP_C_0,
      COMP_LOOP_C_1, COMP_LOOP_C_2, COMP_LOOP_C_3, COMP_LOOP_C_4, COMP_LOOP_C_5,
      COMP_LOOP_C_6, COMP_LOOP_C_7, COMP_LOOP_C_8, COMP_LOOP_C_9, COMP_LOOP_C_10,
      COMP_LOOP_C_11, COMP_LOOP_C_12, COMP_LOOP_C_13, COMP_LOOP_C_14, COMP_LOOP_C_15,
      COMP_LOOP_C_16, COMP_LOOP_C_17, COMP_LOOP_C_18, COMP_LOOP_C_19, COMP_LOOP_C_20,
      COMP_LOOP_C_21, COMP_LOOP_C_22, COMP_LOOP_C_23, COMP_LOOP_C_24, COMP_LOOP_C_25,
      COMP_LOOP_C_26, COMP_LOOP_C_27, COMP_LOOP_C_28, COMP_LOOP_C_29, COMP_LOOP_C_30,
      COMP_LOOP_C_31, COMP_LOOP_C_32, COMP_LOOP_C_33, COMP_LOOP_C_34, COMP_LOOP_C_35,
      COMP_LOOP_C_36, COMP_LOOP_C_37, COMP_LOOP_C_38, COMP_LOOP_C_39, COMP_LOOP_C_40,
      COMP_LOOP_C_41, COMP_LOOP_C_42, COMP_LOOP_C_43, COMP_LOOP_C_44, COMP_LOOP_C_45,
      COMP_LOOP_C_46, COMP_LOOP_C_47, COMP_LOOP_C_48, COMP_LOOP_C_49, COMP_LOOP_C_50,
      COMP_LOOP_C_51, COMP_LOOP_C_52, COMP_LOOP_C_53, COMP_LOOP_C_54, COMP_LOOP_C_55,
      COMP_LOOP_C_56, COMP_LOOP_C_57, COMP_LOOP_C_58, COMP_LOOP_C_59, COMP_LOOP_C_60,
      COMP_LOOP_C_61, COMP_LOOP_C_62, COMP_LOOP_C_63, COMP_LOOP_C_64, COMP_LOOP_C_65,
      COMP_LOOP_C_66, COMP_LOOP_C_67, COMP_LOOP_C_68, COMP_LOOP_C_69, COMP_LOOP_C_70,
      COMP_LOOP_C_71, COMP_LOOP_C_72, COMP_LOOP_C_73, COMP_LOOP_C_74, COMP_LOOP_C_75,
      COMP_LOOP_C_76, COMP_LOOP_C_77, VEC_LOOP_C_0, STAGE_LOOP_C_1, main_C_1);

  SIGNAL state_var : inPlaceNTT_DIT_precomp_core_core_fsm_1_ST;
  SIGNAL state_var_NS : inPlaceNTT_DIT_precomp_core_core_fsm_1_ST;

BEGIN
  inPlaceNTT_DIT_precomp_core_core_fsm_1 : PROCESS (COMP_LOOP_C_38_tr0, COMP_LOOP_C_77_tr0,
      VEC_LOOP_C_0_tr0, STAGE_LOOP_C_1_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN STAGE_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001");
        state_var_NS <= COMP_LOOP_C_0;
      WHEN COMP_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010");
        state_var_NS <= COMP_LOOP_C_1;
      WHEN COMP_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011");
        state_var_NS <= COMP_LOOP_C_2;
      WHEN COMP_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100");
        state_var_NS <= COMP_LOOP_C_3;
      WHEN COMP_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101");
        state_var_NS <= COMP_LOOP_C_4;
      WHEN COMP_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110");
        state_var_NS <= COMP_LOOP_C_5;
      WHEN COMP_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111");
        state_var_NS <= COMP_LOOP_C_6;
      WHEN COMP_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000");
        state_var_NS <= COMP_LOOP_C_7;
      WHEN COMP_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001");
        state_var_NS <= COMP_LOOP_C_8;
      WHEN COMP_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010");
        state_var_NS <= COMP_LOOP_C_9;
      WHEN COMP_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011");
        state_var_NS <= COMP_LOOP_C_10;
      WHEN COMP_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100");
        state_var_NS <= COMP_LOOP_C_11;
      WHEN COMP_LOOP_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101");
        state_var_NS <= COMP_LOOP_C_12;
      WHEN COMP_LOOP_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110");
        state_var_NS <= COMP_LOOP_C_13;
      WHEN COMP_LOOP_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111");
        state_var_NS <= COMP_LOOP_C_14;
      WHEN COMP_LOOP_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000");
        state_var_NS <= COMP_LOOP_C_15;
      WHEN COMP_LOOP_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001");
        state_var_NS <= COMP_LOOP_C_16;
      WHEN COMP_LOOP_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010");
        state_var_NS <= COMP_LOOP_C_17;
      WHEN COMP_LOOP_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011");
        state_var_NS <= COMP_LOOP_C_18;
      WHEN COMP_LOOP_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100");
        state_var_NS <= COMP_LOOP_C_19;
      WHEN COMP_LOOP_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101");
        state_var_NS <= COMP_LOOP_C_20;
      WHEN COMP_LOOP_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110");
        state_var_NS <= COMP_LOOP_C_21;
      WHEN COMP_LOOP_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111");
        state_var_NS <= COMP_LOOP_C_22;
      WHEN COMP_LOOP_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000");
        state_var_NS <= COMP_LOOP_C_23;
      WHEN COMP_LOOP_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001");
        state_var_NS <= COMP_LOOP_C_24;
      WHEN COMP_LOOP_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010");
        state_var_NS <= COMP_LOOP_C_25;
      WHEN COMP_LOOP_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011");
        state_var_NS <= COMP_LOOP_C_26;
      WHEN COMP_LOOP_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100");
        state_var_NS <= COMP_LOOP_C_27;
      WHEN COMP_LOOP_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101");
        state_var_NS <= COMP_LOOP_C_28;
      WHEN COMP_LOOP_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110");
        state_var_NS <= COMP_LOOP_C_29;
      WHEN COMP_LOOP_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111");
        state_var_NS <= COMP_LOOP_C_30;
      WHEN COMP_LOOP_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000");
        state_var_NS <= COMP_LOOP_C_31;
      WHEN COMP_LOOP_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001");
        state_var_NS <= COMP_LOOP_C_32;
      WHEN COMP_LOOP_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010");
        state_var_NS <= COMP_LOOP_C_33;
      WHEN COMP_LOOP_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011");
        state_var_NS <= COMP_LOOP_C_34;
      WHEN COMP_LOOP_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100");
        state_var_NS <= COMP_LOOP_C_35;
      WHEN COMP_LOOP_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101");
        state_var_NS <= COMP_LOOP_C_36;
      WHEN COMP_LOOP_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110");
        state_var_NS <= COMP_LOOP_C_37;
      WHEN COMP_LOOP_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111");
        state_var_NS <= COMP_LOOP_C_38;
      WHEN COMP_LOOP_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000");
        IF ( COMP_LOOP_C_38_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_39;
        END IF;
      WHEN COMP_LOOP_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001");
        state_var_NS <= COMP_LOOP_C_40;
      WHEN COMP_LOOP_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010");
        state_var_NS <= COMP_LOOP_C_41;
      WHEN COMP_LOOP_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011");
        state_var_NS <= COMP_LOOP_C_42;
      WHEN COMP_LOOP_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100");
        state_var_NS <= COMP_LOOP_C_43;
      WHEN COMP_LOOP_C_43 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101");
        state_var_NS <= COMP_LOOP_C_44;
      WHEN COMP_LOOP_C_44 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110");
        state_var_NS <= COMP_LOOP_C_45;
      WHEN COMP_LOOP_C_45 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111");
        state_var_NS <= COMP_LOOP_C_46;
      WHEN COMP_LOOP_C_46 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000");
        state_var_NS <= COMP_LOOP_C_47;
      WHEN COMP_LOOP_C_47 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001");
        state_var_NS <= COMP_LOOP_C_48;
      WHEN COMP_LOOP_C_48 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010");
        state_var_NS <= COMP_LOOP_C_49;
      WHEN COMP_LOOP_C_49 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011");
        state_var_NS <= COMP_LOOP_C_50;
      WHEN COMP_LOOP_C_50 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100");
        state_var_NS <= COMP_LOOP_C_51;
      WHEN COMP_LOOP_C_51 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101");
        state_var_NS <= COMP_LOOP_C_52;
      WHEN COMP_LOOP_C_52 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110");
        state_var_NS <= COMP_LOOP_C_53;
      WHEN COMP_LOOP_C_53 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111");
        state_var_NS <= COMP_LOOP_C_54;
      WHEN COMP_LOOP_C_54 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000");
        state_var_NS <= COMP_LOOP_C_55;
      WHEN COMP_LOOP_C_55 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001");
        state_var_NS <= COMP_LOOP_C_56;
      WHEN COMP_LOOP_C_56 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010");
        state_var_NS <= COMP_LOOP_C_57;
      WHEN COMP_LOOP_C_57 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011");
        state_var_NS <= COMP_LOOP_C_58;
      WHEN COMP_LOOP_C_58 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100");
        state_var_NS <= COMP_LOOP_C_59;
      WHEN COMP_LOOP_C_59 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101");
        state_var_NS <= COMP_LOOP_C_60;
      WHEN COMP_LOOP_C_60 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110");
        state_var_NS <= COMP_LOOP_C_61;
      WHEN COMP_LOOP_C_61 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111");
        state_var_NS <= COMP_LOOP_C_62;
      WHEN COMP_LOOP_C_62 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000");
        state_var_NS <= COMP_LOOP_C_63;
      WHEN COMP_LOOP_C_63 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001");
        state_var_NS <= COMP_LOOP_C_64;
      WHEN COMP_LOOP_C_64 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010");
        state_var_NS <= COMP_LOOP_C_65;
      WHEN COMP_LOOP_C_65 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011");
        state_var_NS <= COMP_LOOP_C_66;
      WHEN COMP_LOOP_C_66 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100");
        state_var_NS <= COMP_LOOP_C_67;
      WHEN COMP_LOOP_C_67 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101");
        state_var_NS <= COMP_LOOP_C_68;
      WHEN COMP_LOOP_C_68 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110");
        state_var_NS <= COMP_LOOP_C_69;
      WHEN COMP_LOOP_C_69 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111");
        state_var_NS <= COMP_LOOP_C_70;
      WHEN COMP_LOOP_C_70 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000");
        state_var_NS <= COMP_LOOP_C_71;
      WHEN COMP_LOOP_C_71 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001");
        state_var_NS <= COMP_LOOP_C_72;
      WHEN COMP_LOOP_C_72 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010");
        state_var_NS <= COMP_LOOP_C_73;
      WHEN COMP_LOOP_C_73 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011");
        state_var_NS <= COMP_LOOP_C_74;
      WHEN COMP_LOOP_C_74 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100");
        state_var_NS <= COMP_LOOP_C_75;
      WHEN COMP_LOOP_C_75 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101");
        state_var_NS <= COMP_LOOP_C_76;
      WHEN COMP_LOOP_C_76 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110");
        state_var_NS <= COMP_LOOP_C_77;
      WHEN COMP_LOOP_C_77 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111");
        IF ( COMP_LOOP_C_77_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN VEC_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000");
        IF ( VEC_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= STAGE_LOOP_C_1;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN STAGE_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001");
        IF ( STAGE_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= STAGE_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010");
        state_var_NS <= main_C_0;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000");
        state_var_NS <= STAGE_LOOP_C_0;
    END CASE;
  END PROCESS inPlaceNTT_DIT_precomp_core_core_fsm_1;

  inPlaceNTT_DIT_precomp_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= main_C_0;
      ELSE
        IF ( core_wen = '1' ) THEN
          state_var <= state_var_NS;
        END IF;
      END IF;
    END IF;
  END PROCESS inPlaceNTT_DIT_precomp_core_core_fsm_1_REG;

END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_staller
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_staller IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    core_wen : OUT STD_LOGIC;
    core_wten : OUT STD_LOGIC;
    vec_rsc_0_0_i_wen_comp : IN STD_LOGIC;
    vec_rsc_0_0_i_wen_comp_1 : IN STD_LOGIC;
    vec_rsc_0_1_i_wen_comp : IN STD_LOGIC;
    vec_rsc_0_1_i_wen_comp_1 : IN STD_LOGIC;
    twiddle_rsc_0_0_i_wen_comp : IN STD_LOGIC;
    twiddle_rsc_0_1_i_wen_comp : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_staller;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_staller IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL core_wen_drv : STD_LOGIC;

BEGIN
  -- Output Reader Assignments
  core_wen <= core_wen_drv;

  core_wen_drv <= vec_rsc_0_0_i_wen_comp AND vec_rsc_0_0_i_wen_comp_1 AND vec_rsc_0_1_i_wen_comp
      AND vec_rsc_0_1_i_wen_comp_1 AND twiddle_rsc_0_0_i_wen_comp AND twiddle_rsc_0_1_i_wen_comp;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        core_wten <= '0';
      ELSE
        core_wten <= NOT core_wen_drv;
      END IF;
    END IF;
  END PROCESS;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
    IS
  PORT(
    core_wten : IN STD_LOGIC;
    twiddle_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC;
    twiddle_rsc_triosy_0_0_obj_ld_core_sct : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
    IS
  -- Default Constants

BEGIN
  twiddle_rsc_triosy_0_0_obj_ld_core_sct <= twiddle_rsc_triosy_0_0_obj_iswt0 AND
      (NOT core_wten);
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
    IS
  PORT(
    core_wten : IN STD_LOGIC;
    twiddle_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC;
    twiddle_rsc_triosy_0_1_obj_ld_core_sct : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
    IS
  -- Default Constants

BEGIN
  twiddle_rsc_triosy_0_1_obj_ld_core_sct <= twiddle_rsc_triosy_0_1_obj_iswt0 AND
      (NOT core_wten);
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl IS
  PORT(
    core_wten : IN STD_LOGIC;
    r_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
    r_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl
    IS
  -- Default Constants

BEGIN
  r_rsc_triosy_obj_ld_core_sct <= r_rsc_triosy_obj_iswt0 AND (NOT core_wten);
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl IS
  PORT(
    core_wten : IN STD_LOGIC;
    p_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
    p_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl
    IS
  -- Default Constants

BEGIN
  p_rsc_triosy_obj_ld_core_sct <= p_rsc_triosy_obj_iswt0 AND (NOT core_wten);
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
    IS
  PORT(
    core_wten : IN STD_LOGIC;
    vec_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC;
    vec_rsc_triosy_0_0_obj_ld_core_sct : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
    IS
  -- Default Constants

BEGIN
  vec_rsc_triosy_0_0_obj_ld_core_sct <= vec_rsc_triosy_0_0_obj_iswt0 AND (NOT core_wten);
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
    IS
  PORT(
    core_wten : IN STD_LOGIC;
    vec_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC;
    vec_rsc_triosy_0_1_obj_ld_core_sct : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
    IS
  -- Default Constants

BEGIN
  vec_rsc_triosy_0_1_obj_ld_core_sct <= vec_rsc_triosy_0_1_obj_iswt0 AND (NOT core_wten);
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    twiddle_rsc_0_1_i_oswt : IN STD_LOGIC;
    twiddle_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
    twiddle_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    twiddle_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_i_biwt : IN STD_LOGIC;
    twiddle_rsc_0_1_i_bdwt : IN STD_LOGIC;
    twiddle_rsc_0_1_i_bcwt : OUT STD_LOGIC;
    twiddle_rsc_0_1_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    twiddle_rsc_0_1_i_s_raddr_core_sct : IN STD_LOGIC;
    twiddle_rsc_0_1_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp
    IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL twiddle_rsc_0_1_i_bcwt_drv : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_0_1_i_s_din_bfwt : STD_LOGIC_VECTOR (63 DOWNTO 0);

  FUNCTION MUX_v_64_2_2(input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_9_2_2(input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Output Reader Assignments
  twiddle_rsc_0_1_i_bcwt <= twiddle_rsc_0_1_i_bcwt_drv;

  twiddle_rsc_0_1_i_wen_comp <= (NOT twiddle_rsc_0_1_i_oswt) OR twiddle_rsc_0_1_i_biwt
      OR twiddle_rsc_0_1_i_bcwt_drv;
  twiddle_rsc_0_1_i_s_raddr <= MUX_v_9_2_2(STD_LOGIC_VECTOR'("000000000"), twiddle_rsc_0_1_i_s_raddr_core,
      twiddle_rsc_0_1_i_s_raddr_core_sct);
  twiddle_rsc_0_1_i_s_din_mxwt <= MUX_v_64_2_2(twiddle_rsc_0_1_i_s_din, twiddle_rsc_0_1_i_s_din_bfwt,
      twiddle_rsc_0_1_i_bcwt_drv);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        twiddle_rsc_0_1_i_bcwt_drv <= '0';
      ELSE
        twiddle_rsc_0_1_i_bcwt_drv <= NOT((NOT(twiddle_rsc_0_1_i_bcwt_drv OR twiddle_rsc_0_1_i_biwt))
            OR twiddle_rsc_0_1_i_bdwt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( twiddle_rsc_0_1_i_biwt = '1' ) THEN
        twiddle_rsc_0_1_i_s_din_bfwt <= twiddle_rsc_0_1_i_s_din;
      END IF;
    END IF;
  END PROCESS;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    twiddle_rsc_0_1_i_oswt : IN STD_LOGIC;
    twiddle_rsc_0_1_i_biwt : OUT STD_LOGIC;
    twiddle_rsc_0_1_i_bdwt : OUT STD_LOGIC;
    twiddle_rsc_0_1_i_bcwt : IN STD_LOGIC;
    twiddle_rsc_0_1_i_s_re_core_sct : OUT STD_LOGIC;
    twiddle_rsc_0_1_i_s_rrdy : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl
    IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_0_1_i_ogwt : STD_LOGIC;

BEGIN
  twiddle_rsc_0_1_i_bdwt <= twiddle_rsc_0_1_i_oswt AND core_wen;
  twiddle_rsc_0_1_i_biwt <= twiddle_rsc_0_1_i_ogwt AND twiddle_rsc_0_1_i_s_rrdy;
  twiddle_rsc_0_1_i_ogwt <= twiddle_rsc_0_1_i_oswt AND (NOT twiddle_rsc_0_1_i_bcwt);
  twiddle_rsc_0_1_i_s_re_core_sct <= twiddle_rsc_0_1_i_ogwt;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    twiddle_rsc_0_0_i_oswt : IN STD_LOGIC;
    twiddle_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
    twiddle_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    twiddle_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_i_biwt : IN STD_LOGIC;
    twiddle_rsc_0_0_i_bdwt : IN STD_LOGIC;
    twiddle_rsc_0_0_i_bcwt : OUT STD_LOGIC;
    twiddle_rsc_0_0_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    twiddle_rsc_0_0_i_s_raddr_core_sct : IN STD_LOGIC;
    twiddle_rsc_0_0_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp
    IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL twiddle_rsc_0_0_i_bcwt_drv : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_0_0_i_s_din_bfwt : STD_LOGIC_VECTOR (63 DOWNTO 0);

  FUNCTION MUX_v_64_2_2(input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_9_2_2(input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Output Reader Assignments
  twiddle_rsc_0_0_i_bcwt <= twiddle_rsc_0_0_i_bcwt_drv;

  twiddle_rsc_0_0_i_wen_comp <= (NOT twiddle_rsc_0_0_i_oswt) OR twiddle_rsc_0_0_i_biwt
      OR twiddle_rsc_0_0_i_bcwt_drv;
  twiddle_rsc_0_0_i_s_raddr <= MUX_v_9_2_2(STD_LOGIC_VECTOR'("000000000"), twiddle_rsc_0_0_i_s_raddr_core,
      twiddle_rsc_0_0_i_s_raddr_core_sct);
  twiddle_rsc_0_0_i_s_din_mxwt <= MUX_v_64_2_2(twiddle_rsc_0_0_i_s_din, twiddle_rsc_0_0_i_s_din_bfwt,
      twiddle_rsc_0_0_i_bcwt_drv);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        twiddle_rsc_0_0_i_bcwt_drv <= '0';
      ELSE
        twiddle_rsc_0_0_i_bcwt_drv <= NOT((NOT(twiddle_rsc_0_0_i_bcwt_drv OR twiddle_rsc_0_0_i_biwt))
            OR twiddle_rsc_0_0_i_bdwt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( twiddle_rsc_0_0_i_biwt = '1' ) THEN
        twiddle_rsc_0_0_i_s_din_bfwt <= twiddle_rsc_0_0_i_s_din;
      END IF;
    END IF;
  END PROCESS;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    twiddle_rsc_0_0_i_oswt : IN STD_LOGIC;
    twiddle_rsc_0_0_i_biwt : OUT STD_LOGIC;
    twiddle_rsc_0_0_i_bdwt : OUT STD_LOGIC;
    twiddle_rsc_0_0_i_bcwt : IN STD_LOGIC;
    twiddle_rsc_0_0_i_s_re_core_sct : OUT STD_LOGIC;
    twiddle_rsc_0_0_i_s_rrdy : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl
    IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_0_0_i_ogwt : STD_LOGIC;

BEGIN
  twiddle_rsc_0_0_i_bdwt <= twiddle_rsc_0_0_i_oswt AND core_wen;
  twiddle_rsc_0_0_i_biwt <= twiddle_rsc_0_0_i_ogwt AND twiddle_rsc_0_0_i_s_rrdy;
  twiddle_rsc_0_0_i_ogwt <= twiddle_rsc_0_0_i_oswt AND (NOT twiddle_rsc_0_0_i_bcwt);
  twiddle_rsc_0_0_i_s_re_core_sct <= twiddle_rsc_0_0_i_ogwt;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_1_i_oswt : IN STD_LOGIC;
    vec_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
    vec_rsc_0_1_i_oswt_1 : IN STD_LOGIC;
    vec_rsc_0_1_i_wen_comp_1 : OUT STD_LOGIC;
    vec_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_1_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_biwt : IN STD_LOGIC;
    vec_rsc_0_1_i_bdwt : IN STD_LOGIC;
    vec_rsc_0_1_i_bcwt : OUT STD_LOGIC;
    vec_rsc_0_1_i_biwt_1 : IN STD_LOGIC;
    vec_rsc_0_1_i_bdwt_2 : IN STD_LOGIC;
    vec_rsc_0_1_i_bcwt_1 : OUT STD_LOGIC;
    vec_rsc_0_1_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_1_i_s_raddr_core_sct : IN STD_LOGIC;
    vec_rsc_0_1_i_s_waddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_1_i_s_waddr_core_sct : IN STD_LOGIC;
    vec_rsc_0_1_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_s_dout : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp
    IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL vec_rsc_0_1_i_bcwt_drv : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_bcwt_1_drv : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_1_i_s_din_bfwt : STD_LOGIC_VECTOR (63 DOWNTO 0);

  FUNCTION MUX_v_64_2_2(input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_9_2_2(input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Output Reader Assignments
  vec_rsc_0_1_i_bcwt <= vec_rsc_0_1_i_bcwt_drv;
  vec_rsc_0_1_i_bcwt_1 <= vec_rsc_0_1_i_bcwt_1_drv;

  vec_rsc_0_1_i_wen_comp <= (NOT vec_rsc_0_1_i_oswt) OR vec_rsc_0_1_i_biwt OR vec_rsc_0_1_i_bcwt_drv;
  vec_rsc_0_1_i_wen_comp_1 <= (NOT vec_rsc_0_1_i_oswt_1) OR vec_rsc_0_1_i_biwt_1
      OR vec_rsc_0_1_i_bcwt_1_drv;
  vec_rsc_0_1_i_s_raddr <= MUX_v_9_2_2(STD_LOGIC_VECTOR'("000000000"), vec_rsc_0_1_i_s_raddr_core,
      vec_rsc_0_1_i_s_raddr_core_sct);
  vec_rsc_0_1_i_s_waddr <= MUX_v_9_2_2(STD_LOGIC_VECTOR'("000000000"), vec_rsc_0_1_i_s_waddr_core,
      vec_rsc_0_1_i_s_waddr_core_sct);
  vec_rsc_0_1_i_s_din_mxwt <= MUX_v_64_2_2(vec_rsc_0_1_i_s_din, vec_rsc_0_1_i_s_din_bfwt,
      vec_rsc_0_1_i_bcwt_drv);
  vec_rsc_0_1_i_s_dout <= MUX_v_64_2_2(STD_LOGIC_VECTOR'("0000000000000000000000000000000000000000000000000000000000000000"),
      vec_rsc_0_1_i_s_dout_core, vec_rsc_0_1_i_s_waddr_core_sct);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        vec_rsc_0_1_i_bcwt_drv <= '0';
        vec_rsc_0_1_i_bcwt_1_drv <= '0';
      ELSE
        vec_rsc_0_1_i_bcwt_drv <= NOT((NOT(vec_rsc_0_1_i_bcwt_drv OR vec_rsc_0_1_i_biwt))
            OR vec_rsc_0_1_i_bdwt);
        vec_rsc_0_1_i_bcwt_1_drv <= NOT((NOT(vec_rsc_0_1_i_bcwt_1_drv OR vec_rsc_0_1_i_biwt_1))
            OR vec_rsc_0_1_i_bdwt_2);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( vec_rsc_0_1_i_biwt = '1' ) THEN
        vec_rsc_0_1_i_s_din_bfwt <= vec_rsc_0_1_i_s_din;
      END IF;
    END IF;
  END PROCESS;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    vec_rsc_0_1_i_oswt : IN STD_LOGIC;
    vec_rsc_0_1_i_oswt_1 : IN STD_LOGIC;
    vec_rsc_0_1_i_biwt : OUT STD_LOGIC;
    vec_rsc_0_1_i_bdwt : OUT STD_LOGIC;
    vec_rsc_0_1_i_bcwt : IN STD_LOGIC;
    vec_rsc_0_1_i_s_re_core_sct : OUT STD_LOGIC;
    vec_rsc_0_1_i_biwt_1 : OUT STD_LOGIC;
    vec_rsc_0_1_i_bdwt_2 : OUT STD_LOGIC;
    vec_rsc_0_1_i_bcwt_1 : IN STD_LOGIC;
    vec_rsc_0_1_i_s_we_core_sct : OUT STD_LOGIC;
    vec_rsc_0_1_i_s_rrdy : IN STD_LOGIC;
    vec_rsc_0_1_i_s_wrdy : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl
    IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_1_i_ogwt : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_ogwt_1 : STD_LOGIC;

BEGIN
  vec_rsc_0_1_i_bdwt <= vec_rsc_0_1_i_oswt AND core_wen;
  vec_rsc_0_1_i_biwt <= vec_rsc_0_1_i_ogwt AND vec_rsc_0_1_i_s_rrdy;
  vec_rsc_0_1_i_ogwt <= vec_rsc_0_1_i_oswt AND (NOT vec_rsc_0_1_i_bcwt);
  vec_rsc_0_1_i_s_re_core_sct <= vec_rsc_0_1_i_ogwt;
  vec_rsc_0_1_i_bdwt_2 <= vec_rsc_0_1_i_oswt_1 AND core_wen;
  vec_rsc_0_1_i_biwt_1 <= vec_rsc_0_1_i_ogwt_1 AND vec_rsc_0_1_i_s_wrdy;
  vec_rsc_0_1_i_ogwt_1 <= vec_rsc_0_1_i_oswt_1 AND (NOT vec_rsc_0_1_i_bcwt_1);
  vec_rsc_0_1_i_s_we_core_sct <= vec_rsc_0_1_i_ogwt_1;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_0_i_oswt : IN STD_LOGIC;
    vec_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
    vec_rsc_0_0_i_oswt_1 : IN STD_LOGIC;
    vec_rsc_0_0_i_wen_comp_1 : OUT STD_LOGIC;
    vec_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_biwt : IN STD_LOGIC;
    vec_rsc_0_0_i_bdwt : IN STD_LOGIC;
    vec_rsc_0_0_i_bcwt : OUT STD_LOGIC;
    vec_rsc_0_0_i_biwt_1 : IN STD_LOGIC;
    vec_rsc_0_0_i_bdwt_2 : IN STD_LOGIC;
    vec_rsc_0_0_i_bcwt_1 : OUT STD_LOGIC;
    vec_rsc_0_0_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_i_s_raddr_core_sct : IN STD_LOGIC;
    vec_rsc_0_0_i_s_waddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_i_s_waddr_core_sct : IN STD_LOGIC;
    vec_rsc_0_0_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_s_dout : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp
    IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL vec_rsc_0_0_i_bcwt_drv : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_bcwt_1_drv : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_0_i_s_din_bfwt : STD_LOGIC_VECTOR (63 DOWNTO 0);

  FUNCTION MUX_v_64_2_2(input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_9_2_2(input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Output Reader Assignments
  vec_rsc_0_0_i_bcwt <= vec_rsc_0_0_i_bcwt_drv;
  vec_rsc_0_0_i_bcwt_1 <= vec_rsc_0_0_i_bcwt_1_drv;

  vec_rsc_0_0_i_wen_comp <= (NOT vec_rsc_0_0_i_oswt) OR vec_rsc_0_0_i_biwt OR vec_rsc_0_0_i_bcwt_drv;
  vec_rsc_0_0_i_wen_comp_1 <= (NOT vec_rsc_0_0_i_oswt_1) OR vec_rsc_0_0_i_biwt_1
      OR vec_rsc_0_0_i_bcwt_1_drv;
  vec_rsc_0_0_i_s_raddr <= MUX_v_9_2_2(STD_LOGIC_VECTOR'("000000000"), vec_rsc_0_0_i_s_raddr_core,
      vec_rsc_0_0_i_s_raddr_core_sct);
  vec_rsc_0_0_i_s_waddr <= MUX_v_9_2_2(STD_LOGIC_VECTOR'("000000000"), vec_rsc_0_0_i_s_waddr_core,
      vec_rsc_0_0_i_s_waddr_core_sct);
  vec_rsc_0_0_i_s_din_mxwt <= MUX_v_64_2_2(vec_rsc_0_0_i_s_din, vec_rsc_0_0_i_s_din_bfwt,
      vec_rsc_0_0_i_bcwt_drv);
  vec_rsc_0_0_i_s_dout <= MUX_v_64_2_2(STD_LOGIC_VECTOR'("0000000000000000000000000000000000000000000000000000000000000000"),
      vec_rsc_0_0_i_s_dout_core, vec_rsc_0_0_i_s_waddr_core_sct);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        vec_rsc_0_0_i_bcwt_drv <= '0';
        vec_rsc_0_0_i_bcwt_1_drv <= '0';
      ELSE
        vec_rsc_0_0_i_bcwt_drv <= NOT((NOT(vec_rsc_0_0_i_bcwt_drv OR vec_rsc_0_0_i_biwt))
            OR vec_rsc_0_0_i_bdwt);
        vec_rsc_0_0_i_bcwt_1_drv <= NOT((NOT(vec_rsc_0_0_i_bcwt_1_drv OR vec_rsc_0_0_i_biwt_1))
            OR vec_rsc_0_0_i_bdwt_2);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( vec_rsc_0_0_i_biwt = '1' ) THEN
        vec_rsc_0_0_i_s_din_bfwt <= vec_rsc_0_0_i_s_din;
      END IF;
    END IF;
  END PROCESS;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    vec_rsc_0_0_i_oswt : IN STD_LOGIC;
    vec_rsc_0_0_i_oswt_1 : IN STD_LOGIC;
    vec_rsc_0_0_i_biwt : OUT STD_LOGIC;
    vec_rsc_0_0_i_bdwt : OUT STD_LOGIC;
    vec_rsc_0_0_i_bcwt : IN STD_LOGIC;
    vec_rsc_0_0_i_s_re_core_sct : OUT STD_LOGIC;
    vec_rsc_0_0_i_biwt_1 : OUT STD_LOGIC;
    vec_rsc_0_0_i_bdwt_2 : OUT STD_LOGIC;
    vec_rsc_0_0_i_bcwt_1 : IN STD_LOGIC;
    vec_rsc_0_0_i_s_we_core_sct : OUT STD_LOGIC;
    vec_rsc_0_0_i_s_rrdy : IN STD_LOGIC;
    vec_rsc_0_0_i_s_wrdy : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl
    IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_0_i_ogwt : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_ogwt_1 : STD_LOGIC;

BEGIN
  vec_rsc_0_0_i_bdwt <= vec_rsc_0_0_i_oswt AND core_wen;
  vec_rsc_0_0_i_biwt <= vec_rsc_0_0_i_ogwt AND vec_rsc_0_0_i_s_rrdy;
  vec_rsc_0_0_i_ogwt <= vec_rsc_0_0_i_oswt AND (NOT vec_rsc_0_0_i_bcwt);
  vec_rsc_0_0_i_s_re_core_sct <= vec_rsc_0_0_i_ogwt;
  vec_rsc_0_0_i_bdwt_2 <= vec_rsc_0_0_i_oswt_1 AND core_wen;
  vec_rsc_0_0_i_biwt_1 <= vec_rsc_0_0_i_ogwt_1 AND vec_rsc_0_0_i_s_wrdy;
  vec_rsc_0_0_i_ogwt_1 <= vec_rsc_0_0_i_oswt_1 AND (NOT vec_rsc_0_0_i_bcwt_1);
  vec_rsc_0_0_i_s_we_core_sct <= vec_rsc_0_0_i_ogwt_1;
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj IS
  PORT(
    twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    twiddle_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_triosy_0_0_obj_ld_core_sct : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      twiddle_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC;
      twiddle_rsc_triosy_0_0_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  twiddle_rsc_triosy_0_0_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => twiddle_rsc_triosy_0_0_obj_ld_core_sct,
      lz => twiddle_rsc_triosy_0_0_lz
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl_inst
      : inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      twiddle_rsc_triosy_0_0_obj_iswt0 => twiddle_rsc_triosy_0_0_obj_iswt0,
      twiddle_rsc_triosy_0_0_obj_ld_core_sct => twiddle_rsc_triosy_0_0_obj_ld_core_sct
    );
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj IS
  PORT(
    twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    twiddle_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_triosy_0_1_obj_ld_core_sct : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      twiddle_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC;
      twiddle_rsc_triosy_0_1_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  twiddle_rsc_triosy_0_1_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => twiddle_rsc_triosy_0_1_obj_ld_core_sct,
      lz => twiddle_rsc_triosy_0_1_lz
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl_inst
      : inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      twiddle_rsc_triosy_0_1_obj_iswt0 => twiddle_rsc_triosy_0_1_obj_iswt0,
      twiddle_rsc_triosy_0_1_obj_ld_core_sct => twiddle_rsc_triosy_0_1_obj_ld_core_sct
    );
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj IS
  PORT(
    r_rsc_triosy_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    r_rsc_triosy_obj_iswt0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL r_rsc_triosy_obj_ld_core_sct : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      r_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
      r_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  r_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => r_rsc_triosy_obj_ld_core_sct,
      lz => r_rsc_triosy_lz
    );
  inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl_inst : inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      r_rsc_triosy_obj_iswt0 => r_rsc_triosy_obj_iswt0,
      r_rsc_triosy_obj_ld_core_sct => r_rsc_triosy_obj_ld_core_sct
    );
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj IS
  PORT(
    p_rsc_triosy_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    p_rsc_triosy_obj_iswt0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL p_rsc_triosy_obj_ld_core_sct : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      p_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
      p_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  p_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => p_rsc_triosy_obj_ld_core_sct,
      lz => p_rsc_triosy_lz
    );
  inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl_inst : inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      p_rsc_triosy_obj_iswt0 => p_rsc_triosy_obj_iswt0,
      p_rsc_triosy_obj_ld_core_sct => p_rsc_triosy_obj_ld_core_sct
    );
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj IS
  PORT(
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    vec_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL vec_rsc_triosy_0_0_obj_ld_core_sct : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      vec_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC;
      vec_rsc_triosy_0_0_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  vec_rsc_triosy_0_0_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => vec_rsc_triosy_0_0_obj_ld_core_sct,
      lz => vec_rsc_triosy_0_0_lz
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl_inst
      : inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      vec_rsc_triosy_0_0_obj_iswt0 => vec_rsc_triosy_0_0_obj_iswt0,
      vec_rsc_triosy_0_0_obj_ld_core_sct => vec_rsc_triosy_0_0_obj_ld_core_sct
    );
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj IS
  PORT(
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    vec_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL vec_rsc_triosy_0_1_obj_ld_core_sct : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      vec_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC;
      vec_rsc_triosy_0_1_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  vec_rsc_triosy_0_1_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => vec_rsc_triosy_0_1_obj_ld_core_sct,
      lz => vec_rsc_triosy_0_1_lz
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl_inst
      : inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      vec_rsc_triosy_0_1_obj_iswt0 => vec_rsc_triosy_0_1_obj_iswt0,
      vec_rsc_triosy_0_1_obj_ld_core_sct => vec_rsc_triosy_0_1_obj_ld_core_sct
    );
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    twiddle_rsc_0_1_s_tdone : IN STD_LOGIC;
    twiddle_rsc_0_1_tr_write_done : IN STD_LOGIC;
    twiddle_rsc_0_1_RREADY : IN STD_LOGIC;
    twiddle_rsc_0_1_RVALID : OUT STD_LOGIC;
    twiddle_rsc_0_1_RUSER : OUT STD_LOGIC;
    twiddle_rsc_0_1_RLAST : OUT STD_LOGIC;
    twiddle_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_RID : OUT STD_LOGIC;
    twiddle_rsc_0_1_ARREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_ARVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_ARUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARLOCK : IN STD_LOGIC;
    twiddle_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_1_ARID : IN STD_LOGIC;
    twiddle_rsc_0_1_BREADY : IN STD_LOGIC;
    twiddle_rsc_0_1_BVALID : OUT STD_LOGIC;
    twiddle_rsc_0_1_BUSER : OUT STD_LOGIC;
    twiddle_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_BID : OUT STD_LOGIC;
    twiddle_rsc_0_1_WREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_WVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_WUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_WLAST : IN STD_LOGIC;
    twiddle_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_AWREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_AWVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_AWUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWLOCK : IN STD_LOGIC;
    twiddle_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_1_AWID : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    twiddle_rsc_0_1_i_oswt : IN STD_LOGIC;
    twiddle_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
    twiddle_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    twiddle_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';
  CONSTANT GND : STD_LOGIC := '0';

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_0_1_i_biwt : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_i_bdwt : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_i_bcwt : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_i_s_re_core_sct : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_i_s_raddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_s_din : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_s_rrdy : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_i_s_wrdy : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_is_idle : STD_LOGIC;

  SIGNAL twiddle_rsc_0_1_i_AWID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_AWUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_WDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_WSTRB : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_WUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_BID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_BRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_BUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_ARUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_RID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_RDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_RRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_RUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_s_raddr_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_s_waddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_s_din_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_s_dout : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      twiddle_rsc_0_1_i_oswt : IN STD_LOGIC;
      twiddle_rsc_0_1_i_biwt : OUT STD_LOGIC;
      twiddle_rsc_0_1_i_bdwt : OUT STD_LOGIC;
      twiddle_rsc_0_1_i_bcwt : IN STD_LOGIC;
      twiddle_rsc_0_1_i_s_re_core_sct : OUT STD_LOGIC;
      twiddle_rsc_0_1_i_s_rrdy : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      twiddle_rsc_0_1_i_oswt : IN STD_LOGIC;
      twiddle_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
      twiddle_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      twiddle_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_1_i_biwt : IN STD_LOGIC;
      twiddle_rsc_0_1_i_bdwt : IN STD_LOGIC;
      twiddle_rsc_0_1_i_bcwt : OUT STD_LOGIC;
      twiddle_rsc_0_1_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      twiddle_rsc_0_1_i_s_raddr_core_sct : IN STD_LOGIC;
      twiddle_rsc_0_1_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_raddr
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_din
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
  twiddle_rsc_0_1_i : work.amba_comps.ccs_axi4_slave_mem
    GENERIC MAP(
      rscid => 0,
      depth => 512,
      op_width => 64,
      cwidth => 64,
      addr_w => 9,
      nopreload => 0,
      rst_ph => 0,
      ADDR_WIDTH => 12,
      DATA_WIDTH => 64,
      ID_WIDTH => 1,
      USER_WIDTH => 1,
      REGION_MAP_SIZE => 1,
      wBASE_ADDRESS => 0,
      rBASE_ADDRESS => 0
      )
    PORT MAP(
      ACLK => clk,
      ARESETn => '1',
      AWID => twiddle_rsc_0_1_i_AWID,
      AWADDR => twiddle_rsc_0_1_i_AWADDR,
      AWLEN => twiddle_rsc_0_1_i_AWLEN,
      AWSIZE => twiddle_rsc_0_1_i_AWSIZE,
      AWBURST => twiddle_rsc_0_1_i_AWBURST,
      AWLOCK => twiddle_rsc_0_1_AWLOCK,
      AWCACHE => twiddle_rsc_0_1_i_AWCACHE,
      AWPROT => twiddle_rsc_0_1_i_AWPROT,
      AWQOS => twiddle_rsc_0_1_i_AWQOS,
      AWREGION => twiddle_rsc_0_1_i_AWREGION,
      AWUSER => twiddle_rsc_0_1_i_AWUSER,
      AWVALID => twiddle_rsc_0_1_AWVALID,
      AWREADY => twiddle_rsc_0_1_AWREADY,
      WDATA => twiddle_rsc_0_1_i_WDATA,
      WSTRB => twiddle_rsc_0_1_i_WSTRB,
      WLAST => twiddle_rsc_0_1_WLAST,
      WUSER => twiddle_rsc_0_1_i_WUSER,
      WVALID => twiddle_rsc_0_1_WVALID,
      WREADY => twiddle_rsc_0_1_WREADY,
      BID => twiddle_rsc_0_1_i_BID,
      BRESP => twiddle_rsc_0_1_i_BRESP,
      BUSER => twiddle_rsc_0_1_i_BUSER,
      BVALID => twiddle_rsc_0_1_BVALID,
      BREADY => twiddle_rsc_0_1_BREADY,
      ARID => twiddle_rsc_0_1_i_ARID,
      ARADDR => twiddle_rsc_0_1_i_ARADDR,
      ARLEN => twiddle_rsc_0_1_i_ARLEN,
      ARSIZE => twiddle_rsc_0_1_i_ARSIZE,
      ARBURST => twiddle_rsc_0_1_i_ARBURST,
      ARLOCK => twiddle_rsc_0_1_ARLOCK,
      ARCACHE => twiddle_rsc_0_1_i_ARCACHE,
      ARPROT => twiddle_rsc_0_1_i_ARPROT,
      ARQOS => twiddle_rsc_0_1_i_ARQOS,
      ARREGION => twiddle_rsc_0_1_i_ARREGION,
      ARUSER => twiddle_rsc_0_1_i_ARUSER,
      ARVALID => twiddle_rsc_0_1_ARVALID,
      ARREADY => twiddle_rsc_0_1_ARREADY,
      RID => twiddle_rsc_0_1_i_RID,
      RDATA => twiddle_rsc_0_1_i_RDATA,
      RRESP => twiddle_rsc_0_1_i_RRESP,
      RLAST => twiddle_rsc_0_1_RLAST,
      RUSER => twiddle_rsc_0_1_i_RUSER,
      RVALID => twiddle_rsc_0_1_RVALID,
      RREADY => twiddle_rsc_0_1_RREADY,
      s_re => twiddle_rsc_0_1_i_s_re_core_sct,
      s_we => '0',
      s_raddr => twiddle_rsc_0_1_i_s_raddr_1,
      s_waddr => twiddle_rsc_0_1_i_s_waddr,
      s_din => twiddle_rsc_0_1_i_s_din_1,
      s_dout => twiddle_rsc_0_1_i_s_dout,
      s_rrdy => twiddle_rsc_0_1_i_s_rrdy,
      s_wrdy => twiddle_rsc_0_1_i_s_wrdy,
      is_idle => twiddle_rsc_0_1_is_idle,
      tr_write_done => twiddle_rsc_0_1_tr_write_done,
      s_tdone => twiddle_rsc_0_1_s_tdone
    );
  twiddle_rsc_0_1_i_AWID(0) <= twiddle_rsc_0_1_AWID;
  twiddle_rsc_0_1_i_AWADDR <= twiddle_rsc_0_1_AWADDR;
  twiddle_rsc_0_1_i_AWLEN <= twiddle_rsc_0_1_AWLEN;
  twiddle_rsc_0_1_i_AWSIZE <= twiddle_rsc_0_1_AWSIZE;
  twiddle_rsc_0_1_i_AWBURST <= twiddle_rsc_0_1_AWBURST;
  twiddle_rsc_0_1_i_AWCACHE <= twiddle_rsc_0_1_AWCACHE;
  twiddle_rsc_0_1_i_AWPROT <= twiddle_rsc_0_1_AWPROT;
  twiddle_rsc_0_1_i_AWQOS <= twiddle_rsc_0_1_AWQOS;
  twiddle_rsc_0_1_i_AWREGION <= twiddle_rsc_0_1_AWREGION;
  twiddle_rsc_0_1_i_AWUSER(0) <= twiddle_rsc_0_1_AWUSER;
  twiddle_rsc_0_1_i_WDATA <= twiddle_rsc_0_1_WDATA;
  twiddle_rsc_0_1_i_WSTRB <= twiddle_rsc_0_1_WSTRB;
  twiddle_rsc_0_1_i_WUSER(0) <= twiddle_rsc_0_1_WUSER;
  twiddle_rsc_0_1_BID <= twiddle_rsc_0_1_i_BID(0);
  twiddle_rsc_0_1_BRESP <= twiddle_rsc_0_1_i_BRESP;
  twiddle_rsc_0_1_BUSER <= twiddle_rsc_0_1_i_BUSER(0);
  twiddle_rsc_0_1_i_ARID(0) <= twiddle_rsc_0_1_ARID;
  twiddle_rsc_0_1_i_ARADDR <= twiddle_rsc_0_1_ARADDR;
  twiddle_rsc_0_1_i_ARLEN <= twiddle_rsc_0_1_ARLEN;
  twiddle_rsc_0_1_i_ARSIZE <= twiddle_rsc_0_1_ARSIZE;
  twiddle_rsc_0_1_i_ARBURST <= twiddle_rsc_0_1_ARBURST;
  twiddle_rsc_0_1_i_ARCACHE <= twiddle_rsc_0_1_ARCACHE;
  twiddle_rsc_0_1_i_ARPROT <= twiddle_rsc_0_1_ARPROT;
  twiddle_rsc_0_1_i_ARQOS <= twiddle_rsc_0_1_ARQOS;
  twiddle_rsc_0_1_i_ARREGION <= twiddle_rsc_0_1_ARREGION;
  twiddle_rsc_0_1_i_ARUSER(0) <= twiddle_rsc_0_1_ARUSER;
  twiddle_rsc_0_1_RID <= twiddle_rsc_0_1_i_RID(0);
  twiddle_rsc_0_1_RDATA <= twiddle_rsc_0_1_i_RDATA;
  twiddle_rsc_0_1_RRESP <= twiddle_rsc_0_1_i_RRESP;
  twiddle_rsc_0_1_RUSER <= twiddle_rsc_0_1_i_RUSER(0);
  twiddle_rsc_0_1_i_s_raddr_1 <= twiddle_rsc_0_1_i_s_raddr;
  twiddle_rsc_0_1_i_s_waddr <= STD_LOGIC_VECTOR'( "000000000");
  twiddle_rsc_0_1_i_s_din <= twiddle_rsc_0_1_i_s_din_1;
  twiddle_rsc_0_1_i_s_dout <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");

  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl_inst :
      inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      twiddle_rsc_0_1_i_oswt => twiddle_rsc_0_1_i_oswt,
      twiddle_rsc_0_1_i_biwt => twiddle_rsc_0_1_i_biwt,
      twiddle_rsc_0_1_i_bdwt => twiddle_rsc_0_1_i_bdwt,
      twiddle_rsc_0_1_i_bcwt => twiddle_rsc_0_1_i_bcwt,
      twiddle_rsc_0_1_i_s_re_core_sct => twiddle_rsc_0_1_i_s_re_core_sct,
      twiddle_rsc_0_1_i_s_rrdy => twiddle_rsc_0_1_i_s_rrdy
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst : inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      twiddle_rsc_0_1_i_oswt => twiddle_rsc_0_1_i_oswt,
      twiddle_rsc_0_1_i_wen_comp => twiddle_rsc_0_1_i_wen_comp,
      twiddle_rsc_0_1_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_raddr_core,
      twiddle_rsc_0_1_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_din_mxwt,
      twiddle_rsc_0_1_i_biwt => twiddle_rsc_0_1_i_biwt,
      twiddle_rsc_0_1_i_bdwt => twiddle_rsc_0_1_i_bdwt,
      twiddle_rsc_0_1_i_bcwt => twiddle_rsc_0_1_i_bcwt,
      twiddle_rsc_0_1_i_s_raddr => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_raddr,
      twiddle_rsc_0_1_i_s_raddr_core_sct => twiddle_rsc_0_1_i_s_re_core_sct,
      twiddle_rsc_0_1_i_s_din => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_din
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_raddr_core
      <= twiddle_rsc_0_1_i_s_raddr_core;
  twiddle_rsc_0_1_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_din_mxwt;
  twiddle_rsc_0_1_i_s_raddr <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_raddr;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_twiddle_rsc_0_1_wait_dp_inst_twiddle_rsc_0_1_i_s_din
      <= twiddle_rsc_0_1_i_s_din;

END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    twiddle_rsc_0_0_s_tdone : IN STD_LOGIC;
    twiddle_rsc_0_0_tr_write_done : IN STD_LOGIC;
    twiddle_rsc_0_0_RREADY : IN STD_LOGIC;
    twiddle_rsc_0_0_RVALID : OUT STD_LOGIC;
    twiddle_rsc_0_0_RUSER : OUT STD_LOGIC;
    twiddle_rsc_0_0_RLAST : OUT STD_LOGIC;
    twiddle_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_RID : OUT STD_LOGIC;
    twiddle_rsc_0_0_ARREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_ARVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_ARUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARLOCK : IN STD_LOGIC;
    twiddle_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_0_ARID : IN STD_LOGIC;
    twiddle_rsc_0_0_BREADY : IN STD_LOGIC;
    twiddle_rsc_0_0_BVALID : OUT STD_LOGIC;
    twiddle_rsc_0_0_BUSER : OUT STD_LOGIC;
    twiddle_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_BID : OUT STD_LOGIC;
    twiddle_rsc_0_0_WREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_WVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_WUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_WLAST : IN STD_LOGIC;
    twiddle_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_AWREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_AWVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_AWUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWLOCK : IN STD_LOGIC;
    twiddle_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_0_AWID : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    twiddle_rsc_0_0_i_oswt : IN STD_LOGIC;
    twiddle_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
    twiddle_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    twiddle_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';
  CONSTANT GND : STD_LOGIC := '0';

  -- Interconnect Declarations
  SIGNAL twiddle_rsc_0_0_i_biwt : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_i_bdwt : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_i_bcwt : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_i_s_re_core_sct : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_i_s_raddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_s_din : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_s_rrdy : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_i_s_wrdy : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_is_idle : STD_LOGIC;

  SIGNAL twiddle_rsc_0_0_i_AWID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_AWUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_WDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_WSTRB : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_WUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_BID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_BRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_BUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_ARUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_RID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_RDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_RRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_RUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_s_raddr_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_s_waddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_s_din_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_s_dout : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      twiddle_rsc_0_0_i_oswt : IN STD_LOGIC;
      twiddle_rsc_0_0_i_biwt : OUT STD_LOGIC;
      twiddle_rsc_0_0_i_bdwt : OUT STD_LOGIC;
      twiddle_rsc_0_0_i_bcwt : IN STD_LOGIC;
      twiddle_rsc_0_0_i_s_re_core_sct : OUT STD_LOGIC;
      twiddle_rsc_0_0_i_s_rrdy : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      twiddle_rsc_0_0_i_oswt : IN STD_LOGIC;
      twiddle_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
      twiddle_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      twiddle_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_0_i_biwt : IN STD_LOGIC;
      twiddle_rsc_0_0_i_bdwt : IN STD_LOGIC;
      twiddle_rsc_0_0_i_bcwt : OUT STD_LOGIC;
      twiddle_rsc_0_0_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      twiddle_rsc_0_0_i_s_raddr_core_sct : IN STD_LOGIC;
      twiddle_rsc_0_0_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_raddr
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_din
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
  twiddle_rsc_0_0_i : work.amba_comps.ccs_axi4_slave_mem
    GENERIC MAP(
      rscid => 0,
      depth => 512,
      op_width => 64,
      cwidth => 64,
      addr_w => 9,
      nopreload => 0,
      rst_ph => 0,
      ADDR_WIDTH => 12,
      DATA_WIDTH => 64,
      ID_WIDTH => 1,
      USER_WIDTH => 1,
      REGION_MAP_SIZE => 1,
      wBASE_ADDRESS => 0,
      rBASE_ADDRESS => 0
      )
    PORT MAP(
      ACLK => clk,
      ARESETn => '1',
      AWID => twiddle_rsc_0_0_i_AWID,
      AWADDR => twiddle_rsc_0_0_i_AWADDR,
      AWLEN => twiddle_rsc_0_0_i_AWLEN,
      AWSIZE => twiddle_rsc_0_0_i_AWSIZE,
      AWBURST => twiddle_rsc_0_0_i_AWBURST,
      AWLOCK => twiddle_rsc_0_0_AWLOCK,
      AWCACHE => twiddle_rsc_0_0_i_AWCACHE,
      AWPROT => twiddle_rsc_0_0_i_AWPROT,
      AWQOS => twiddle_rsc_0_0_i_AWQOS,
      AWREGION => twiddle_rsc_0_0_i_AWREGION,
      AWUSER => twiddle_rsc_0_0_i_AWUSER,
      AWVALID => twiddle_rsc_0_0_AWVALID,
      AWREADY => twiddle_rsc_0_0_AWREADY,
      WDATA => twiddle_rsc_0_0_i_WDATA,
      WSTRB => twiddle_rsc_0_0_i_WSTRB,
      WLAST => twiddle_rsc_0_0_WLAST,
      WUSER => twiddle_rsc_0_0_i_WUSER,
      WVALID => twiddle_rsc_0_0_WVALID,
      WREADY => twiddle_rsc_0_0_WREADY,
      BID => twiddle_rsc_0_0_i_BID,
      BRESP => twiddle_rsc_0_0_i_BRESP,
      BUSER => twiddle_rsc_0_0_i_BUSER,
      BVALID => twiddle_rsc_0_0_BVALID,
      BREADY => twiddle_rsc_0_0_BREADY,
      ARID => twiddle_rsc_0_0_i_ARID,
      ARADDR => twiddle_rsc_0_0_i_ARADDR,
      ARLEN => twiddle_rsc_0_0_i_ARLEN,
      ARSIZE => twiddle_rsc_0_0_i_ARSIZE,
      ARBURST => twiddle_rsc_0_0_i_ARBURST,
      ARLOCK => twiddle_rsc_0_0_ARLOCK,
      ARCACHE => twiddle_rsc_0_0_i_ARCACHE,
      ARPROT => twiddle_rsc_0_0_i_ARPROT,
      ARQOS => twiddle_rsc_0_0_i_ARQOS,
      ARREGION => twiddle_rsc_0_0_i_ARREGION,
      ARUSER => twiddle_rsc_0_0_i_ARUSER,
      ARVALID => twiddle_rsc_0_0_ARVALID,
      ARREADY => twiddle_rsc_0_0_ARREADY,
      RID => twiddle_rsc_0_0_i_RID,
      RDATA => twiddle_rsc_0_0_i_RDATA,
      RRESP => twiddle_rsc_0_0_i_RRESP,
      RLAST => twiddle_rsc_0_0_RLAST,
      RUSER => twiddle_rsc_0_0_i_RUSER,
      RVALID => twiddle_rsc_0_0_RVALID,
      RREADY => twiddle_rsc_0_0_RREADY,
      s_re => twiddle_rsc_0_0_i_s_re_core_sct,
      s_we => '0',
      s_raddr => twiddle_rsc_0_0_i_s_raddr_1,
      s_waddr => twiddle_rsc_0_0_i_s_waddr,
      s_din => twiddle_rsc_0_0_i_s_din_1,
      s_dout => twiddle_rsc_0_0_i_s_dout,
      s_rrdy => twiddle_rsc_0_0_i_s_rrdy,
      s_wrdy => twiddle_rsc_0_0_i_s_wrdy,
      is_idle => twiddle_rsc_0_0_is_idle,
      tr_write_done => twiddle_rsc_0_0_tr_write_done,
      s_tdone => twiddle_rsc_0_0_s_tdone
    );
  twiddle_rsc_0_0_i_AWID(0) <= twiddle_rsc_0_0_AWID;
  twiddle_rsc_0_0_i_AWADDR <= twiddle_rsc_0_0_AWADDR;
  twiddle_rsc_0_0_i_AWLEN <= twiddle_rsc_0_0_AWLEN;
  twiddle_rsc_0_0_i_AWSIZE <= twiddle_rsc_0_0_AWSIZE;
  twiddle_rsc_0_0_i_AWBURST <= twiddle_rsc_0_0_AWBURST;
  twiddle_rsc_0_0_i_AWCACHE <= twiddle_rsc_0_0_AWCACHE;
  twiddle_rsc_0_0_i_AWPROT <= twiddle_rsc_0_0_AWPROT;
  twiddle_rsc_0_0_i_AWQOS <= twiddle_rsc_0_0_AWQOS;
  twiddle_rsc_0_0_i_AWREGION <= twiddle_rsc_0_0_AWREGION;
  twiddle_rsc_0_0_i_AWUSER(0) <= twiddle_rsc_0_0_AWUSER;
  twiddle_rsc_0_0_i_WDATA <= twiddle_rsc_0_0_WDATA;
  twiddle_rsc_0_0_i_WSTRB <= twiddle_rsc_0_0_WSTRB;
  twiddle_rsc_0_0_i_WUSER(0) <= twiddle_rsc_0_0_WUSER;
  twiddle_rsc_0_0_BID <= twiddle_rsc_0_0_i_BID(0);
  twiddle_rsc_0_0_BRESP <= twiddle_rsc_0_0_i_BRESP;
  twiddle_rsc_0_0_BUSER <= twiddle_rsc_0_0_i_BUSER(0);
  twiddle_rsc_0_0_i_ARID(0) <= twiddle_rsc_0_0_ARID;
  twiddle_rsc_0_0_i_ARADDR <= twiddle_rsc_0_0_ARADDR;
  twiddle_rsc_0_0_i_ARLEN <= twiddle_rsc_0_0_ARLEN;
  twiddle_rsc_0_0_i_ARSIZE <= twiddle_rsc_0_0_ARSIZE;
  twiddle_rsc_0_0_i_ARBURST <= twiddle_rsc_0_0_ARBURST;
  twiddle_rsc_0_0_i_ARCACHE <= twiddle_rsc_0_0_ARCACHE;
  twiddle_rsc_0_0_i_ARPROT <= twiddle_rsc_0_0_ARPROT;
  twiddle_rsc_0_0_i_ARQOS <= twiddle_rsc_0_0_ARQOS;
  twiddle_rsc_0_0_i_ARREGION <= twiddle_rsc_0_0_ARREGION;
  twiddle_rsc_0_0_i_ARUSER(0) <= twiddle_rsc_0_0_ARUSER;
  twiddle_rsc_0_0_RID <= twiddle_rsc_0_0_i_RID(0);
  twiddle_rsc_0_0_RDATA <= twiddle_rsc_0_0_i_RDATA;
  twiddle_rsc_0_0_RRESP <= twiddle_rsc_0_0_i_RRESP;
  twiddle_rsc_0_0_RUSER <= twiddle_rsc_0_0_i_RUSER(0);
  twiddle_rsc_0_0_i_s_raddr_1 <= twiddle_rsc_0_0_i_s_raddr;
  twiddle_rsc_0_0_i_s_waddr <= STD_LOGIC_VECTOR'( "000000000");
  twiddle_rsc_0_0_i_s_din <= twiddle_rsc_0_0_i_s_din_1;
  twiddle_rsc_0_0_i_s_dout <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");

  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl_inst :
      inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      twiddle_rsc_0_0_i_oswt => twiddle_rsc_0_0_i_oswt,
      twiddle_rsc_0_0_i_biwt => twiddle_rsc_0_0_i_biwt,
      twiddle_rsc_0_0_i_bdwt => twiddle_rsc_0_0_i_bdwt,
      twiddle_rsc_0_0_i_bcwt => twiddle_rsc_0_0_i_bcwt,
      twiddle_rsc_0_0_i_s_re_core_sct => twiddle_rsc_0_0_i_s_re_core_sct,
      twiddle_rsc_0_0_i_s_rrdy => twiddle_rsc_0_0_i_s_rrdy
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst : inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      twiddle_rsc_0_0_i_oswt => twiddle_rsc_0_0_i_oswt,
      twiddle_rsc_0_0_i_wen_comp => twiddle_rsc_0_0_i_wen_comp,
      twiddle_rsc_0_0_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_raddr_core,
      twiddle_rsc_0_0_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_din_mxwt,
      twiddle_rsc_0_0_i_biwt => twiddle_rsc_0_0_i_biwt,
      twiddle_rsc_0_0_i_bdwt => twiddle_rsc_0_0_i_bdwt,
      twiddle_rsc_0_0_i_bcwt => twiddle_rsc_0_0_i_bcwt,
      twiddle_rsc_0_0_i_s_raddr => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_raddr,
      twiddle_rsc_0_0_i_s_raddr_core_sct => twiddle_rsc_0_0_i_s_re_core_sct,
      twiddle_rsc_0_0_i_s_din => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_din
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_raddr_core
      <= twiddle_rsc_0_0_i_s_raddr_core;
  twiddle_rsc_0_0_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_din_mxwt;
  twiddle_rsc_0_0_i_s_raddr <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_raddr;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_twiddle_rsc_0_0_wait_dp_inst_twiddle_rsc_0_0_i_s_din
      <= twiddle_rsc_0_0_i_s_din;

END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_1_s_tdone : IN STD_LOGIC;
    vec_rsc_0_1_tr_write_done : IN STD_LOGIC;
    vec_rsc_0_1_RREADY : IN STD_LOGIC;
    vec_rsc_0_1_RVALID : OUT STD_LOGIC;
    vec_rsc_0_1_RUSER : OUT STD_LOGIC;
    vec_rsc_0_1_RLAST : OUT STD_LOGIC;
    vec_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_RID : OUT STD_LOGIC;
    vec_rsc_0_1_ARREADY : OUT STD_LOGIC;
    vec_rsc_0_1_ARVALID : IN STD_LOGIC;
    vec_rsc_0_1_ARUSER : IN STD_LOGIC;
    vec_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARLOCK : IN STD_LOGIC;
    vec_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_1_ARID : IN STD_LOGIC;
    vec_rsc_0_1_BREADY : IN STD_LOGIC;
    vec_rsc_0_1_BVALID : OUT STD_LOGIC;
    vec_rsc_0_1_BUSER : OUT STD_LOGIC;
    vec_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_BID : OUT STD_LOGIC;
    vec_rsc_0_1_WREADY : OUT STD_LOGIC;
    vec_rsc_0_1_WVALID : IN STD_LOGIC;
    vec_rsc_0_1_WUSER : IN STD_LOGIC;
    vec_rsc_0_1_WLAST : IN STD_LOGIC;
    vec_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_AWREADY : OUT STD_LOGIC;
    vec_rsc_0_1_AWVALID : IN STD_LOGIC;
    vec_rsc_0_1_AWUSER : IN STD_LOGIC;
    vec_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWLOCK : IN STD_LOGIC;
    vec_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_1_AWID : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    vec_rsc_0_1_i_oswt : IN STD_LOGIC;
    vec_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
    vec_rsc_0_1_i_oswt_1 : IN STD_LOGIC;
    vec_rsc_0_1_i_wen_comp_1 : OUT STD_LOGIC;
    vec_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_1_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';
  CONSTANT GND : STD_LOGIC := '0';

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_1_i_biwt : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_bdwt : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_bcwt : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_s_re_core_sct : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_biwt_1 : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_bdwt_2 : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_bcwt_1 : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_s_we_core_sct : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_s_raddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_waddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_din : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_dout : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_rrdy : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_s_wrdy : STD_LOGIC;
  SIGNAL vec_rsc_0_1_is_idle_1 : STD_LOGIC;

  SIGNAL vec_rsc_0_1_i_AWID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_AWUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_WDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_WSTRB : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_WUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_BID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_BRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_BUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_ARUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_RID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_RDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_RRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_RUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_raddr_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_waddr_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_din_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_s_dout_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      vec_rsc_0_1_i_oswt : IN STD_LOGIC;
      vec_rsc_0_1_i_oswt_1 : IN STD_LOGIC;
      vec_rsc_0_1_i_biwt : OUT STD_LOGIC;
      vec_rsc_0_1_i_bdwt : OUT STD_LOGIC;
      vec_rsc_0_1_i_bcwt : IN STD_LOGIC;
      vec_rsc_0_1_i_s_re_core_sct : OUT STD_LOGIC;
      vec_rsc_0_1_i_biwt_1 : OUT STD_LOGIC;
      vec_rsc_0_1_i_bdwt_2 : OUT STD_LOGIC;
      vec_rsc_0_1_i_bcwt_1 : IN STD_LOGIC;
      vec_rsc_0_1_i_s_we_core_sct : OUT STD_LOGIC;
      vec_rsc_0_1_i_s_rrdy : IN STD_LOGIC;
      vec_rsc_0_1_i_s_wrdy : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_0_1_i_oswt : IN STD_LOGIC;
      vec_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
      vec_rsc_0_1_i_oswt_1 : IN STD_LOGIC;
      vec_rsc_0_1_i_wen_comp_1 : OUT STD_LOGIC;
      vec_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_1_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_biwt : IN STD_LOGIC;
      vec_rsc_0_1_i_bdwt : IN STD_LOGIC;
      vec_rsc_0_1_i_bcwt : OUT STD_LOGIC;
      vec_rsc_0_1_i_biwt_1 : IN STD_LOGIC;
      vec_rsc_0_1_i_bdwt_2 : IN STD_LOGIC;
      vec_rsc_0_1_i_bcwt_1 : OUT STD_LOGIC;
      vec_rsc_0_1_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_1_i_s_raddr_core_sct : IN STD_LOGIC;
      vec_rsc_0_1_i_s_waddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_1_i_s_waddr_core_sct : IN STD_LOGIC;
      vec_rsc_0_1_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_s_dout : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_waddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_dout_core
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_raddr
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_waddr
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_din
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_dout
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
  vec_rsc_0_1_i : work.amba_comps.ccs_axi4_slave_mem
    GENERIC MAP(
      rscid => 0,
      depth => 512,
      op_width => 64,
      cwidth => 64,
      addr_w => 9,
      nopreload => 0,
      rst_ph => 0,
      ADDR_WIDTH => 12,
      DATA_WIDTH => 64,
      ID_WIDTH => 1,
      USER_WIDTH => 1,
      REGION_MAP_SIZE => 1,
      wBASE_ADDRESS => 0,
      rBASE_ADDRESS => 0
      )
    PORT MAP(
      ACLK => clk,
      ARESETn => '1',
      AWID => vec_rsc_0_1_i_AWID,
      AWADDR => vec_rsc_0_1_i_AWADDR,
      AWLEN => vec_rsc_0_1_i_AWLEN,
      AWSIZE => vec_rsc_0_1_i_AWSIZE,
      AWBURST => vec_rsc_0_1_i_AWBURST,
      AWLOCK => vec_rsc_0_1_AWLOCK,
      AWCACHE => vec_rsc_0_1_i_AWCACHE,
      AWPROT => vec_rsc_0_1_i_AWPROT,
      AWQOS => vec_rsc_0_1_i_AWQOS,
      AWREGION => vec_rsc_0_1_i_AWREGION,
      AWUSER => vec_rsc_0_1_i_AWUSER,
      AWVALID => vec_rsc_0_1_AWVALID,
      AWREADY => vec_rsc_0_1_AWREADY,
      WDATA => vec_rsc_0_1_i_WDATA,
      WSTRB => vec_rsc_0_1_i_WSTRB,
      WLAST => vec_rsc_0_1_WLAST,
      WUSER => vec_rsc_0_1_i_WUSER,
      WVALID => vec_rsc_0_1_WVALID,
      WREADY => vec_rsc_0_1_WREADY,
      BID => vec_rsc_0_1_i_BID,
      BRESP => vec_rsc_0_1_i_BRESP,
      BUSER => vec_rsc_0_1_i_BUSER,
      BVALID => vec_rsc_0_1_BVALID,
      BREADY => vec_rsc_0_1_BREADY,
      ARID => vec_rsc_0_1_i_ARID,
      ARADDR => vec_rsc_0_1_i_ARADDR,
      ARLEN => vec_rsc_0_1_i_ARLEN,
      ARSIZE => vec_rsc_0_1_i_ARSIZE,
      ARBURST => vec_rsc_0_1_i_ARBURST,
      ARLOCK => vec_rsc_0_1_ARLOCK,
      ARCACHE => vec_rsc_0_1_i_ARCACHE,
      ARPROT => vec_rsc_0_1_i_ARPROT,
      ARQOS => vec_rsc_0_1_i_ARQOS,
      ARREGION => vec_rsc_0_1_i_ARREGION,
      ARUSER => vec_rsc_0_1_i_ARUSER,
      ARVALID => vec_rsc_0_1_ARVALID,
      ARREADY => vec_rsc_0_1_ARREADY,
      RID => vec_rsc_0_1_i_RID,
      RDATA => vec_rsc_0_1_i_RDATA,
      RRESP => vec_rsc_0_1_i_RRESP,
      RLAST => vec_rsc_0_1_RLAST,
      RUSER => vec_rsc_0_1_i_RUSER,
      RVALID => vec_rsc_0_1_RVALID,
      RREADY => vec_rsc_0_1_RREADY,
      s_re => vec_rsc_0_1_i_s_re_core_sct,
      s_we => vec_rsc_0_1_i_s_we_core_sct,
      s_raddr => vec_rsc_0_1_i_s_raddr_1,
      s_waddr => vec_rsc_0_1_i_s_waddr_1,
      s_din => vec_rsc_0_1_i_s_din_1,
      s_dout => vec_rsc_0_1_i_s_dout_1,
      s_rrdy => vec_rsc_0_1_i_s_rrdy,
      s_wrdy => vec_rsc_0_1_i_s_wrdy,
      is_idle => vec_rsc_0_1_is_idle_1,
      tr_write_done => vec_rsc_0_1_tr_write_done,
      s_tdone => vec_rsc_0_1_s_tdone
    );
  vec_rsc_0_1_i_AWID(0) <= vec_rsc_0_1_AWID;
  vec_rsc_0_1_i_AWADDR <= vec_rsc_0_1_AWADDR;
  vec_rsc_0_1_i_AWLEN <= vec_rsc_0_1_AWLEN;
  vec_rsc_0_1_i_AWSIZE <= vec_rsc_0_1_AWSIZE;
  vec_rsc_0_1_i_AWBURST <= vec_rsc_0_1_AWBURST;
  vec_rsc_0_1_i_AWCACHE <= vec_rsc_0_1_AWCACHE;
  vec_rsc_0_1_i_AWPROT <= vec_rsc_0_1_AWPROT;
  vec_rsc_0_1_i_AWQOS <= vec_rsc_0_1_AWQOS;
  vec_rsc_0_1_i_AWREGION <= vec_rsc_0_1_AWREGION;
  vec_rsc_0_1_i_AWUSER(0) <= vec_rsc_0_1_AWUSER;
  vec_rsc_0_1_i_WDATA <= vec_rsc_0_1_WDATA;
  vec_rsc_0_1_i_WSTRB <= vec_rsc_0_1_WSTRB;
  vec_rsc_0_1_i_WUSER(0) <= vec_rsc_0_1_WUSER;
  vec_rsc_0_1_BID <= vec_rsc_0_1_i_BID(0);
  vec_rsc_0_1_BRESP <= vec_rsc_0_1_i_BRESP;
  vec_rsc_0_1_BUSER <= vec_rsc_0_1_i_BUSER(0);
  vec_rsc_0_1_i_ARID(0) <= vec_rsc_0_1_ARID;
  vec_rsc_0_1_i_ARADDR <= vec_rsc_0_1_ARADDR;
  vec_rsc_0_1_i_ARLEN <= vec_rsc_0_1_ARLEN;
  vec_rsc_0_1_i_ARSIZE <= vec_rsc_0_1_ARSIZE;
  vec_rsc_0_1_i_ARBURST <= vec_rsc_0_1_ARBURST;
  vec_rsc_0_1_i_ARCACHE <= vec_rsc_0_1_ARCACHE;
  vec_rsc_0_1_i_ARPROT <= vec_rsc_0_1_ARPROT;
  vec_rsc_0_1_i_ARQOS <= vec_rsc_0_1_ARQOS;
  vec_rsc_0_1_i_ARREGION <= vec_rsc_0_1_ARREGION;
  vec_rsc_0_1_i_ARUSER(0) <= vec_rsc_0_1_ARUSER;
  vec_rsc_0_1_RID <= vec_rsc_0_1_i_RID(0);
  vec_rsc_0_1_RDATA <= vec_rsc_0_1_i_RDATA;
  vec_rsc_0_1_RRESP <= vec_rsc_0_1_i_RRESP;
  vec_rsc_0_1_RUSER <= vec_rsc_0_1_i_RUSER(0);
  vec_rsc_0_1_i_s_raddr_1 <= vec_rsc_0_1_i_s_raddr;
  vec_rsc_0_1_i_s_waddr_1 <= vec_rsc_0_1_i_s_waddr;
  vec_rsc_0_1_i_s_din <= vec_rsc_0_1_i_s_din_1;
  vec_rsc_0_1_i_s_dout_1 <= vec_rsc_0_1_i_s_dout;

  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      vec_rsc_0_1_i_oswt => vec_rsc_0_1_i_oswt,
      vec_rsc_0_1_i_oswt_1 => vec_rsc_0_1_i_oswt_1,
      vec_rsc_0_1_i_biwt => vec_rsc_0_1_i_biwt,
      vec_rsc_0_1_i_bdwt => vec_rsc_0_1_i_bdwt,
      vec_rsc_0_1_i_bcwt => vec_rsc_0_1_i_bcwt,
      vec_rsc_0_1_i_s_re_core_sct => vec_rsc_0_1_i_s_re_core_sct,
      vec_rsc_0_1_i_biwt_1 => vec_rsc_0_1_i_biwt_1,
      vec_rsc_0_1_i_bdwt_2 => vec_rsc_0_1_i_bdwt_2,
      vec_rsc_0_1_i_bcwt_1 => vec_rsc_0_1_i_bcwt_1,
      vec_rsc_0_1_i_s_we_core_sct => vec_rsc_0_1_i_s_we_core_sct,
      vec_rsc_0_1_i_s_rrdy => vec_rsc_0_1_i_s_rrdy,
      vec_rsc_0_1_i_s_wrdy => vec_rsc_0_1_i_s_wrdy
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_0_1_i_oswt => vec_rsc_0_1_i_oswt,
      vec_rsc_0_1_i_wen_comp => vec_rsc_0_1_i_wen_comp,
      vec_rsc_0_1_i_oswt_1 => vec_rsc_0_1_i_oswt_1,
      vec_rsc_0_1_i_wen_comp_1 => vec_rsc_0_1_i_wen_comp_1,
      vec_rsc_0_1_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_raddr_core,
      vec_rsc_0_1_i_s_waddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_waddr_core,
      vec_rsc_0_1_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_din_mxwt,
      vec_rsc_0_1_i_s_dout_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_dout_core,
      vec_rsc_0_1_i_biwt => vec_rsc_0_1_i_biwt,
      vec_rsc_0_1_i_bdwt => vec_rsc_0_1_i_bdwt,
      vec_rsc_0_1_i_bcwt => vec_rsc_0_1_i_bcwt,
      vec_rsc_0_1_i_biwt_1 => vec_rsc_0_1_i_biwt_1,
      vec_rsc_0_1_i_bdwt_2 => vec_rsc_0_1_i_bdwt_2,
      vec_rsc_0_1_i_bcwt_1 => vec_rsc_0_1_i_bcwt_1,
      vec_rsc_0_1_i_s_raddr => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_raddr,
      vec_rsc_0_1_i_s_raddr_core_sct => vec_rsc_0_1_i_s_re_core_sct,
      vec_rsc_0_1_i_s_waddr => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_waddr,
      vec_rsc_0_1_i_s_waddr_core_sct => vec_rsc_0_1_i_s_we_core_sct,
      vec_rsc_0_1_i_s_din => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_din,
      vec_rsc_0_1_i_s_dout => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_dout
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_raddr_core
      <= vec_rsc_0_1_i_s_raddr_core;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_waddr_core
      <= vec_rsc_0_1_i_s_waddr_core;
  vec_rsc_0_1_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_din_mxwt;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_dout_core
      <= vec_rsc_0_1_i_s_dout_core;
  vec_rsc_0_1_i_s_raddr <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_raddr;
  vec_rsc_0_1_i_s_waddr <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_waddr;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_din
      <= vec_rsc_0_1_i_s_din;
  vec_rsc_0_1_i_s_dout <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_s_dout;

END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_0_s_tdone : IN STD_LOGIC;
    vec_rsc_0_0_tr_write_done : IN STD_LOGIC;
    vec_rsc_0_0_RREADY : IN STD_LOGIC;
    vec_rsc_0_0_RVALID : OUT STD_LOGIC;
    vec_rsc_0_0_RUSER : OUT STD_LOGIC;
    vec_rsc_0_0_RLAST : OUT STD_LOGIC;
    vec_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_RID : OUT STD_LOGIC;
    vec_rsc_0_0_ARREADY : OUT STD_LOGIC;
    vec_rsc_0_0_ARVALID : IN STD_LOGIC;
    vec_rsc_0_0_ARUSER : IN STD_LOGIC;
    vec_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARLOCK : IN STD_LOGIC;
    vec_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_0_ARID : IN STD_LOGIC;
    vec_rsc_0_0_BREADY : IN STD_LOGIC;
    vec_rsc_0_0_BVALID : OUT STD_LOGIC;
    vec_rsc_0_0_BUSER : OUT STD_LOGIC;
    vec_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_BID : OUT STD_LOGIC;
    vec_rsc_0_0_WREADY : OUT STD_LOGIC;
    vec_rsc_0_0_WVALID : IN STD_LOGIC;
    vec_rsc_0_0_WUSER : IN STD_LOGIC;
    vec_rsc_0_0_WLAST : IN STD_LOGIC;
    vec_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_AWREADY : OUT STD_LOGIC;
    vec_rsc_0_0_AWVALID : IN STD_LOGIC;
    vec_rsc_0_0_AWUSER : IN STD_LOGIC;
    vec_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWLOCK : IN STD_LOGIC;
    vec_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_0_AWID : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    vec_rsc_0_0_i_oswt : IN STD_LOGIC;
    vec_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
    vec_rsc_0_0_i_oswt_1 : IN STD_LOGIC;
    vec_rsc_0_0_i_wen_comp_1 : OUT STD_LOGIC;
    vec_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
  );
END inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';
  CONSTANT GND : STD_LOGIC := '0';

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_0_i_biwt : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_bdwt : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_bcwt : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_s_re_core_sct : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_biwt_1 : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_bdwt_2 : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_bcwt_1 : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_s_we_core_sct : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_s_raddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_waddr : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_din : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_dout : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_rrdy : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_s_wrdy : STD_LOGIC;
  SIGNAL vec_rsc_0_0_is_idle_1 : STD_LOGIC;

  SIGNAL vec_rsc_0_0_i_AWID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_AWUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_WDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_WSTRB : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_WUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_BID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_BRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_BUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARADDR : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARLEN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARSIZE : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARBURST : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARCACHE : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARPROT : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARQOS : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARREGION : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_ARUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_RID : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_RDATA : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_RRESP : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_RUSER : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_raddr_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_waddr_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_din_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_s_dout_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      vec_rsc_0_0_i_oswt : IN STD_LOGIC;
      vec_rsc_0_0_i_oswt_1 : IN STD_LOGIC;
      vec_rsc_0_0_i_biwt : OUT STD_LOGIC;
      vec_rsc_0_0_i_bdwt : OUT STD_LOGIC;
      vec_rsc_0_0_i_bcwt : IN STD_LOGIC;
      vec_rsc_0_0_i_s_re_core_sct : OUT STD_LOGIC;
      vec_rsc_0_0_i_biwt_1 : OUT STD_LOGIC;
      vec_rsc_0_0_i_bdwt_2 : OUT STD_LOGIC;
      vec_rsc_0_0_i_bcwt_1 : IN STD_LOGIC;
      vec_rsc_0_0_i_s_we_core_sct : OUT STD_LOGIC;
      vec_rsc_0_0_i_s_rrdy : IN STD_LOGIC;
      vec_rsc_0_0_i_s_wrdy : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_0_0_i_oswt : IN STD_LOGIC;
      vec_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
      vec_rsc_0_0_i_oswt_1 : IN STD_LOGIC;
      vec_rsc_0_0_i_wen_comp_1 : OUT STD_LOGIC;
      vec_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_0_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_biwt : IN STD_LOGIC;
      vec_rsc_0_0_i_bdwt : IN STD_LOGIC;
      vec_rsc_0_0_i_bcwt : OUT STD_LOGIC;
      vec_rsc_0_0_i_biwt_1 : IN STD_LOGIC;
      vec_rsc_0_0_i_bdwt_2 : IN STD_LOGIC;
      vec_rsc_0_0_i_bcwt_1 : OUT STD_LOGIC;
      vec_rsc_0_0_i_s_raddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_0_i_s_raddr_core_sct : IN STD_LOGIC;
      vec_rsc_0_0_i_s_waddr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_0_i_s_waddr_core_sct : IN STD_LOGIC;
      vec_rsc_0_0_i_s_din : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_s_dout : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_waddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_dout_core
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_raddr
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_waddr
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_din
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_dout
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
  vec_rsc_0_0_i : work.amba_comps.ccs_axi4_slave_mem
    GENERIC MAP(
      rscid => 0,
      depth => 512,
      op_width => 64,
      cwidth => 64,
      addr_w => 9,
      nopreload => 0,
      rst_ph => 0,
      ADDR_WIDTH => 12,
      DATA_WIDTH => 64,
      ID_WIDTH => 1,
      USER_WIDTH => 1,
      REGION_MAP_SIZE => 1,
      wBASE_ADDRESS => 0,
      rBASE_ADDRESS => 0
      )
    PORT MAP(
      ACLK => clk,
      ARESETn => '1',
      AWID => vec_rsc_0_0_i_AWID,
      AWADDR => vec_rsc_0_0_i_AWADDR,
      AWLEN => vec_rsc_0_0_i_AWLEN,
      AWSIZE => vec_rsc_0_0_i_AWSIZE,
      AWBURST => vec_rsc_0_0_i_AWBURST,
      AWLOCK => vec_rsc_0_0_AWLOCK,
      AWCACHE => vec_rsc_0_0_i_AWCACHE,
      AWPROT => vec_rsc_0_0_i_AWPROT,
      AWQOS => vec_rsc_0_0_i_AWQOS,
      AWREGION => vec_rsc_0_0_i_AWREGION,
      AWUSER => vec_rsc_0_0_i_AWUSER,
      AWVALID => vec_rsc_0_0_AWVALID,
      AWREADY => vec_rsc_0_0_AWREADY,
      WDATA => vec_rsc_0_0_i_WDATA,
      WSTRB => vec_rsc_0_0_i_WSTRB,
      WLAST => vec_rsc_0_0_WLAST,
      WUSER => vec_rsc_0_0_i_WUSER,
      WVALID => vec_rsc_0_0_WVALID,
      WREADY => vec_rsc_0_0_WREADY,
      BID => vec_rsc_0_0_i_BID,
      BRESP => vec_rsc_0_0_i_BRESP,
      BUSER => vec_rsc_0_0_i_BUSER,
      BVALID => vec_rsc_0_0_BVALID,
      BREADY => vec_rsc_0_0_BREADY,
      ARID => vec_rsc_0_0_i_ARID,
      ARADDR => vec_rsc_0_0_i_ARADDR,
      ARLEN => vec_rsc_0_0_i_ARLEN,
      ARSIZE => vec_rsc_0_0_i_ARSIZE,
      ARBURST => vec_rsc_0_0_i_ARBURST,
      ARLOCK => vec_rsc_0_0_ARLOCK,
      ARCACHE => vec_rsc_0_0_i_ARCACHE,
      ARPROT => vec_rsc_0_0_i_ARPROT,
      ARQOS => vec_rsc_0_0_i_ARQOS,
      ARREGION => vec_rsc_0_0_i_ARREGION,
      ARUSER => vec_rsc_0_0_i_ARUSER,
      ARVALID => vec_rsc_0_0_ARVALID,
      ARREADY => vec_rsc_0_0_ARREADY,
      RID => vec_rsc_0_0_i_RID,
      RDATA => vec_rsc_0_0_i_RDATA,
      RRESP => vec_rsc_0_0_i_RRESP,
      RLAST => vec_rsc_0_0_RLAST,
      RUSER => vec_rsc_0_0_i_RUSER,
      RVALID => vec_rsc_0_0_RVALID,
      RREADY => vec_rsc_0_0_RREADY,
      s_re => vec_rsc_0_0_i_s_re_core_sct,
      s_we => vec_rsc_0_0_i_s_we_core_sct,
      s_raddr => vec_rsc_0_0_i_s_raddr_1,
      s_waddr => vec_rsc_0_0_i_s_waddr_1,
      s_din => vec_rsc_0_0_i_s_din_1,
      s_dout => vec_rsc_0_0_i_s_dout_1,
      s_rrdy => vec_rsc_0_0_i_s_rrdy,
      s_wrdy => vec_rsc_0_0_i_s_wrdy,
      is_idle => vec_rsc_0_0_is_idle_1,
      tr_write_done => vec_rsc_0_0_tr_write_done,
      s_tdone => vec_rsc_0_0_s_tdone
    );
  vec_rsc_0_0_i_AWID(0) <= vec_rsc_0_0_AWID;
  vec_rsc_0_0_i_AWADDR <= vec_rsc_0_0_AWADDR;
  vec_rsc_0_0_i_AWLEN <= vec_rsc_0_0_AWLEN;
  vec_rsc_0_0_i_AWSIZE <= vec_rsc_0_0_AWSIZE;
  vec_rsc_0_0_i_AWBURST <= vec_rsc_0_0_AWBURST;
  vec_rsc_0_0_i_AWCACHE <= vec_rsc_0_0_AWCACHE;
  vec_rsc_0_0_i_AWPROT <= vec_rsc_0_0_AWPROT;
  vec_rsc_0_0_i_AWQOS <= vec_rsc_0_0_AWQOS;
  vec_rsc_0_0_i_AWREGION <= vec_rsc_0_0_AWREGION;
  vec_rsc_0_0_i_AWUSER(0) <= vec_rsc_0_0_AWUSER;
  vec_rsc_0_0_i_WDATA <= vec_rsc_0_0_WDATA;
  vec_rsc_0_0_i_WSTRB <= vec_rsc_0_0_WSTRB;
  vec_rsc_0_0_i_WUSER(0) <= vec_rsc_0_0_WUSER;
  vec_rsc_0_0_BID <= vec_rsc_0_0_i_BID(0);
  vec_rsc_0_0_BRESP <= vec_rsc_0_0_i_BRESP;
  vec_rsc_0_0_BUSER <= vec_rsc_0_0_i_BUSER(0);
  vec_rsc_0_0_i_ARID(0) <= vec_rsc_0_0_ARID;
  vec_rsc_0_0_i_ARADDR <= vec_rsc_0_0_ARADDR;
  vec_rsc_0_0_i_ARLEN <= vec_rsc_0_0_ARLEN;
  vec_rsc_0_0_i_ARSIZE <= vec_rsc_0_0_ARSIZE;
  vec_rsc_0_0_i_ARBURST <= vec_rsc_0_0_ARBURST;
  vec_rsc_0_0_i_ARCACHE <= vec_rsc_0_0_ARCACHE;
  vec_rsc_0_0_i_ARPROT <= vec_rsc_0_0_ARPROT;
  vec_rsc_0_0_i_ARQOS <= vec_rsc_0_0_ARQOS;
  vec_rsc_0_0_i_ARREGION <= vec_rsc_0_0_ARREGION;
  vec_rsc_0_0_i_ARUSER(0) <= vec_rsc_0_0_ARUSER;
  vec_rsc_0_0_RID <= vec_rsc_0_0_i_RID(0);
  vec_rsc_0_0_RDATA <= vec_rsc_0_0_i_RDATA;
  vec_rsc_0_0_RRESP <= vec_rsc_0_0_i_RRESP;
  vec_rsc_0_0_RUSER <= vec_rsc_0_0_i_RUSER(0);
  vec_rsc_0_0_i_s_raddr_1 <= vec_rsc_0_0_i_s_raddr;
  vec_rsc_0_0_i_s_waddr_1 <= vec_rsc_0_0_i_s_waddr;
  vec_rsc_0_0_i_s_din <= vec_rsc_0_0_i_s_din_1;
  vec_rsc_0_0_i_s_dout_1 <= vec_rsc_0_0_i_s_dout;

  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      vec_rsc_0_0_i_oswt => vec_rsc_0_0_i_oswt,
      vec_rsc_0_0_i_oswt_1 => vec_rsc_0_0_i_oswt_1,
      vec_rsc_0_0_i_biwt => vec_rsc_0_0_i_biwt,
      vec_rsc_0_0_i_bdwt => vec_rsc_0_0_i_bdwt,
      vec_rsc_0_0_i_bcwt => vec_rsc_0_0_i_bcwt,
      vec_rsc_0_0_i_s_re_core_sct => vec_rsc_0_0_i_s_re_core_sct,
      vec_rsc_0_0_i_biwt_1 => vec_rsc_0_0_i_biwt_1,
      vec_rsc_0_0_i_bdwt_2 => vec_rsc_0_0_i_bdwt_2,
      vec_rsc_0_0_i_bcwt_1 => vec_rsc_0_0_i_bcwt_1,
      vec_rsc_0_0_i_s_we_core_sct => vec_rsc_0_0_i_s_we_core_sct,
      vec_rsc_0_0_i_s_rrdy => vec_rsc_0_0_i_s_rrdy,
      vec_rsc_0_0_i_s_wrdy => vec_rsc_0_0_i_s_wrdy
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_0_0_i_oswt => vec_rsc_0_0_i_oswt,
      vec_rsc_0_0_i_wen_comp => vec_rsc_0_0_i_wen_comp,
      vec_rsc_0_0_i_oswt_1 => vec_rsc_0_0_i_oswt_1,
      vec_rsc_0_0_i_wen_comp_1 => vec_rsc_0_0_i_wen_comp_1,
      vec_rsc_0_0_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_raddr_core,
      vec_rsc_0_0_i_s_waddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_waddr_core,
      vec_rsc_0_0_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_din_mxwt,
      vec_rsc_0_0_i_s_dout_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_dout_core,
      vec_rsc_0_0_i_biwt => vec_rsc_0_0_i_biwt,
      vec_rsc_0_0_i_bdwt => vec_rsc_0_0_i_bdwt,
      vec_rsc_0_0_i_bcwt => vec_rsc_0_0_i_bcwt,
      vec_rsc_0_0_i_biwt_1 => vec_rsc_0_0_i_biwt_1,
      vec_rsc_0_0_i_bdwt_2 => vec_rsc_0_0_i_bdwt_2,
      vec_rsc_0_0_i_bcwt_1 => vec_rsc_0_0_i_bcwt_1,
      vec_rsc_0_0_i_s_raddr => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_raddr,
      vec_rsc_0_0_i_s_raddr_core_sct => vec_rsc_0_0_i_s_re_core_sct,
      vec_rsc_0_0_i_s_waddr => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_waddr,
      vec_rsc_0_0_i_s_waddr_core_sct => vec_rsc_0_0_i_s_we_core_sct,
      vec_rsc_0_0_i_s_din => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_din,
      vec_rsc_0_0_i_s_dout => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_dout
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_raddr_core
      <= vec_rsc_0_0_i_s_raddr_core;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_waddr_core
      <= vec_rsc_0_0_i_s_waddr_core;
  vec_rsc_0_0_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_din_mxwt;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_dout_core
      <= vec_rsc_0_0_i_s_dout_core;
  vec_rsc_0_0_i_s_raddr <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_raddr;
  vec_rsc_0_0_i_s_waddr <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_waddr;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_din
      <= vec_rsc_0_0_i_s_din;
  vec_rsc_0_0_i_s_dout <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_s_dout;

END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_0_s_tdone : IN STD_LOGIC;
    vec_rsc_0_0_tr_write_done : IN STD_LOGIC;
    vec_rsc_0_0_RREADY : IN STD_LOGIC;
    vec_rsc_0_0_RVALID : OUT STD_LOGIC;
    vec_rsc_0_0_RUSER : OUT STD_LOGIC;
    vec_rsc_0_0_RLAST : OUT STD_LOGIC;
    vec_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_RID : OUT STD_LOGIC;
    vec_rsc_0_0_ARREADY : OUT STD_LOGIC;
    vec_rsc_0_0_ARVALID : IN STD_LOGIC;
    vec_rsc_0_0_ARUSER : IN STD_LOGIC;
    vec_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARLOCK : IN STD_LOGIC;
    vec_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_0_ARID : IN STD_LOGIC;
    vec_rsc_0_0_BREADY : IN STD_LOGIC;
    vec_rsc_0_0_BVALID : OUT STD_LOGIC;
    vec_rsc_0_0_BUSER : OUT STD_LOGIC;
    vec_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_BID : OUT STD_LOGIC;
    vec_rsc_0_0_WREADY : OUT STD_LOGIC;
    vec_rsc_0_0_WVALID : IN STD_LOGIC;
    vec_rsc_0_0_WUSER : IN STD_LOGIC;
    vec_rsc_0_0_WLAST : IN STD_LOGIC;
    vec_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_AWREADY : OUT STD_LOGIC;
    vec_rsc_0_0_AWVALID : IN STD_LOGIC;
    vec_rsc_0_0_AWUSER : IN STD_LOGIC;
    vec_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWLOCK : IN STD_LOGIC;
    vec_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_0_AWID : IN STD_LOGIC;
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    vec_rsc_0_1_s_tdone : IN STD_LOGIC;
    vec_rsc_0_1_tr_write_done : IN STD_LOGIC;
    vec_rsc_0_1_RREADY : IN STD_LOGIC;
    vec_rsc_0_1_RVALID : OUT STD_LOGIC;
    vec_rsc_0_1_RUSER : OUT STD_LOGIC;
    vec_rsc_0_1_RLAST : OUT STD_LOGIC;
    vec_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_RID : OUT STD_LOGIC;
    vec_rsc_0_1_ARREADY : OUT STD_LOGIC;
    vec_rsc_0_1_ARVALID : IN STD_LOGIC;
    vec_rsc_0_1_ARUSER : IN STD_LOGIC;
    vec_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARLOCK : IN STD_LOGIC;
    vec_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_1_ARID : IN STD_LOGIC;
    vec_rsc_0_1_BREADY : IN STD_LOGIC;
    vec_rsc_0_1_BVALID : OUT STD_LOGIC;
    vec_rsc_0_1_BUSER : OUT STD_LOGIC;
    vec_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_BID : OUT STD_LOGIC;
    vec_rsc_0_1_WREADY : OUT STD_LOGIC;
    vec_rsc_0_1_WVALID : IN STD_LOGIC;
    vec_rsc_0_1_WUSER : IN STD_LOGIC;
    vec_rsc_0_1_WLAST : IN STD_LOGIC;
    vec_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_AWREADY : OUT STD_LOGIC;
    vec_rsc_0_1_AWVALID : IN STD_LOGIC;
    vec_rsc_0_1_AWUSER : IN STD_LOGIC;
    vec_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWLOCK : IN STD_LOGIC;
    vec_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_1_AWID : IN STD_LOGIC;
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_triosy_lz : OUT STD_LOGIC;
    twiddle_rsc_0_0_s_tdone : IN STD_LOGIC;
    twiddle_rsc_0_0_tr_write_done : IN STD_LOGIC;
    twiddle_rsc_0_0_RREADY : IN STD_LOGIC;
    twiddle_rsc_0_0_RVALID : OUT STD_LOGIC;
    twiddle_rsc_0_0_RUSER : OUT STD_LOGIC;
    twiddle_rsc_0_0_RLAST : OUT STD_LOGIC;
    twiddle_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_RID : OUT STD_LOGIC;
    twiddle_rsc_0_0_ARREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_ARVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_ARUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARLOCK : IN STD_LOGIC;
    twiddle_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_0_ARID : IN STD_LOGIC;
    twiddle_rsc_0_0_BREADY : IN STD_LOGIC;
    twiddle_rsc_0_0_BVALID : OUT STD_LOGIC;
    twiddle_rsc_0_0_BUSER : OUT STD_LOGIC;
    twiddle_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_BID : OUT STD_LOGIC;
    twiddle_rsc_0_0_WREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_WVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_WUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_WLAST : IN STD_LOGIC;
    twiddle_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_AWREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_AWVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_AWUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWLOCK : IN STD_LOGIC;
    twiddle_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_0_AWID : IN STD_LOGIC;
    twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    twiddle_rsc_0_1_s_tdone : IN STD_LOGIC;
    twiddle_rsc_0_1_tr_write_done : IN STD_LOGIC;
    twiddle_rsc_0_1_RREADY : IN STD_LOGIC;
    twiddle_rsc_0_1_RVALID : OUT STD_LOGIC;
    twiddle_rsc_0_1_RUSER : OUT STD_LOGIC;
    twiddle_rsc_0_1_RLAST : OUT STD_LOGIC;
    twiddle_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_RID : OUT STD_LOGIC;
    twiddle_rsc_0_1_ARREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_ARVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_ARUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARLOCK : IN STD_LOGIC;
    twiddle_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_1_ARID : IN STD_LOGIC;
    twiddle_rsc_0_1_BREADY : IN STD_LOGIC;
    twiddle_rsc_0_1_BVALID : OUT STD_LOGIC;
    twiddle_rsc_0_1_BUSER : OUT STD_LOGIC;
    twiddle_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_BID : OUT STD_LOGIC;
    twiddle_rsc_0_1_WREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_WVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_WUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_WLAST : IN STD_LOGIC;
    twiddle_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_AWREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_AWVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_AWUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWLOCK : IN STD_LOGIC;
    twiddle_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_1_AWID : IN STD_LOGIC;
    twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp_core;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp_core IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';
  CONSTANT GND : STD_LOGIC := '0';

  -- Interconnect Declarations
  SIGNAL core_wen : STD_LOGIC;
  SIGNAL p_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL core_wten : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_wen_comp : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_wen_comp_1 : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_s_din_mxwt : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_wen_comp : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_wen_comp_1 : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_s_din_mxwt : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_wen_comp : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_i_s_raddr_core : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_s_din_mxwt : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_wen_comp : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_i_s_raddr_core : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_s_din_mxwt : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_modulo_result_rem_cmp_z : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL COMP_LOOP_1_modulo_result_rem_cmp_a_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_modulo_result_rem_cmp_b_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL fsm_output : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL COMP_LOOP_1_acc_10_tmp : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL or_tmp : STD_LOGIC;
  SIGNAL nor_tmp_3 : STD_LOGIC;
  SIGNAL and_dcpl_6 : STD_LOGIC;
  SIGNAL and_dcpl_7 : STD_LOGIC;
  SIGNAL and_dcpl_8 : STD_LOGIC;
  SIGNAL and_dcpl_9 : STD_LOGIC;
  SIGNAL and_dcpl_10 : STD_LOGIC;
  SIGNAL and_dcpl_12 : STD_LOGIC;
  SIGNAL and_dcpl_14 : STD_LOGIC;
  SIGNAL and_dcpl_15 : STD_LOGIC;
  SIGNAL and_dcpl_18 : STD_LOGIC;
  SIGNAL not_tmp_34 : STD_LOGIC;
  SIGNAL and_dcpl_21 : STD_LOGIC;
  SIGNAL and_dcpl_22 : STD_LOGIC;
  SIGNAL and_dcpl_23 : STD_LOGIC;
  SIGNAL and_dcpl_25 : STD_LOGIC;
  SIGNAL and_dcpl_26 : STD_LOGIC;
  SIGNAL and_dcpl_27 : STD_LOGIC;
  SIGNAL and_dcpl_28 : STD_LOGIC;
  SIGNAL and_dcpl_29 : STD_LOGIC;
  SIGNAL and_dcpl_31 : STD_LOGIC;
  SIGNAL and_dcpl_35 : STD_LOGIC;
  SIGNAL and_dcpl_38 : STD_LOGIC;
  SIGNAL and_dcpl_40 : STD_LOGIC;
  SIGNAL and_dcpl_50 : STD_LOGIC;
  SIGNAL and_dcpl_51 : STD_LOGIC;
  SIGNAL or_dcpl_4 : STD_LOGIC;
  SIGNAL mux_tmp_53 : STD_LOGIC;
  SIGNAL and_dcpl_67 : STD_LOGIC;
  SIGNAL or_tmp_59 : STD_LOGIC;
  SIGNAL mux_tmp_57 : STD_LOGIC;
  SIGNAL or_tmp_60 : STD_LOGIC;
  SIGNAL mux_tmp_68 : STD_LOGIC;
  SIGNAL mux_tmp_69 : STD_LOGIC;
  SIGNAL or_dcpl_8 : STD_LOGIC;
  SIGNAL or_dcpl_10 : STD_LOGIC;
  SIGNAL not_tmp_58 : STD_LOGIC;
  SIGNAL mux_tmp_77 : STD_LOGIC;
  SIGNAL or_dcpl_12 : STD_LOGIC;
  SIGNAL and_dcpl_80 : STD_LOGIC;
  SIGNAL COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm : STD_LOGIC;
  SIGNAL VEC_LOOP_j_sva_9_0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_2_acc_10_idiv_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_1_slc_31_1_idiv_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_2_slc_31_1_idiv_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_2_tmp_lshift_itm : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_psp_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_k_9_1_sva_7_0 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_COMP_LOOP_k_9_1_ftd : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_vec_rsc_0_0_i_oswt_cse : STD_LOGIC;
  SIGNAL reg_vec_rsc_0_0_i_oswt_1_cse : STD_LOGIC;
  SIGNAL reg_vec_rsc_0_1_i_oswt_cse : STD_LOGIC;
  SIGNAL reg_vec_rsc_0_1_i_oswt_1_cse : STD_LOGIC;
  SIGNAL reg_vec_rsc_0_0_i_s_raddr_core_cse : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL reg_vec_rsc_0_0_i_s_waddr_core_cse : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL reg_vec_rsc_0_0_i_s_dout_core_cse : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL reg_twiddle_rsc_0_0_i_oswt_cse : STD_LOGIC;
  SIGNAL reg_twiddle_rsc_0_1_i_oswt_cse : STD_LOGIC;
  SIGNAL reg_vec_rsc_triosy_0_1_obj_iswt0_cse : STD_LOGIC;
  SIGNAL and_98_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_and_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_and_5_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_and_7_cse : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_dcpl_111 : STD_LOGIC;
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL and_dcpl_122 : STD_LOGIC;
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL and_dcpl_133 : STD_LOGIC;
  SIGNAL z_out_3 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL and_dcpl_135 : STD_LOGIC;
  SIGNAL and_dcpl_138 : STD_LOGIC;
  SIGNAL and_dcpl_139 : STD_LOGIC;
  SIGNAL and_dcpl_142 : STD_LOGIC;
  SIGNAL and_dcpl_146 : STD_LOGIC;
  SIGNAL and_dcpl_151 : STD_LOGIC;
  SIGNAL z_out_4 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_psp_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL COMP_LOOP_1_tmp_acc_cse_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL tmp_2_lpi_4_dfm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_acc_8_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_2_acc_8_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_acc_5_psp : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_2_acc_5_psp : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_mul_psp : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_2_mul_psp : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva_mx0c1 : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_s_dout_core_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_2_acc_5_psp_mx0w2 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL VEC_LOOP_j_sva_9_0_mx0c0 : STD_LOGIC;
  SIGNAL tmp_2_lpi_4_dfm_mx0c1 : STD_LOGIC;
  SIGNAL COMP_LOOP_1_acc_8_itm_mx0w0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL or_118_cse : STD_LOGIC;
  SIGNAL or_116_cse : STD_LOGIC;

  SIGNAL mux_34_nl : STD_LOGIC;
  SIGNAL nor_43_nl : STD_LOGIC;
  SIGNAL mux_33_nl : STD_LOGIC;
  SIGNAL or_106_nl : STD_LOGIC;
  SIGNAL mux_38_nl : STD_LOGIC;
  SIGNAL mux_37_nl : STD_LOGIC;
  SIGNAL nor_39_nl : STD_LOGIC;
  SIGNAL nor_40_nl : STD_LOGIC;
  SIGNAL mux_36_nl : STD_LOGIC;
  SIGNAL nor_41_nl : STD_LOGIC;
  SIGNAL nor_42_nl : STD_LOGIC;
  SIGNAL mux_41_nl : STD_LOGIC;
  SIGNAL nor_37_nl : STD_LOGIC;
  SIGNAL mux_40_nl : STD_LOGIC;
  SIGNAL or_43_nl : STD_LOGIC;
  SIGNAL or_42_nl : STD_LOGIC;
  SIGNAL nor_38_nl : STD_LOGIC;
  SIGNAL mux_39_nl : STD_LOGIC;
  SIGNAL or_39_nl : STD_LOGIC;
  SIGNAL or_37_nl : STD_LOGIC;
  SIGNAL and_30_nl : STD_LOGIC;
  SIGNAL and_32_nl : STD_LOGIC;
  SIGNAL and_34_nl : STD_LOGIC;
  SIGNAL and_37_nl : STD_LOGIC;
  SIGNAL and_39_nl : STD_LOGIC;
  SIGNAL and_42_nl : STD_LOGIC;
  SIGNAL mux_44_nl : STD_LOGIC;
  SIGNAL mux_43_nl : STD_LOGIC;
  SIGNAL and_99_nl : STD_LOGIC;
  SIGNAL and_100_nl : STD_LOGIC;
  SIGNAL mux_42_nl : STD_LOGIC;
  SIGNAL nor_35_nl : STD_LOGIC;
  SIGNAL nor_36_nl : STD_LOGIC;
  SIGNAL mux_47_nl : STD_LOGIC;
  SIGNAL nor_33_nl : STD_LOGIC;
  SIGNAL mux_46_nl : STD_LOGIC;
  SIGNAL or_53_nl : STD_LOGIC;
  SIGNAL or_52_nl : STD_LOGIC;
  SIGNAL nor_34_nl : STD_LOGIC;
  SIGNAL mux_45_nl : STD_LOGIC;
  SIGNAL or_49_nl : STD_LOGIC;
  SIGNAL or_48_nl : STD_LOGIC;
  SIGNAL mux_49_nl : STD_LOGIC;
  SIGNAL mux_48_nl : STD_LOGIC;
  SIGNAL or_114_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_2_nl : STD_LOGIC;
  SIGNAL and_59_nl : STD_LOGIC;
  SIGNAL mux_51_nl : STD_LOGIC;
  SIGNAL mux_50_nl : STD_LOGIC;
  SIGNAL and_62_nl : STD_LOGIC;
  SIGNAL mux_52_nl : STD_LOGIC;
  SIGNAL nor_31_nl : STD_LOGIC;
  SIGNAL nor_32_nl : STD_LOGIC;
  SIGNAL and_65_nl : STD_LOGIC;
  SIGNAL nor_55_nl : STD_LOGIC;
  SIGNAL mux_56_nl : STD_LOGIC;
  SIGNAL mux_55_nl : STD_LOGIC;
  SIGNAL or_64_nl : STD_LOGIC;
  SIGNAL mux_54_nl : STD_LOGIC;
  SIGNAL or_61_nl : STD_LOGIC;
  SIGNAL and_69_nl : STD_LOGIC;
  SIGNAL mux_62_nl : STD_LOGIC;
  SIGNAL mux_61_nl : STD_LOGIC;
  SIGNAL mux_60_nl : STD_LOGIC;
  SIGNAL mux_59_nl : STD_LOGIC;
  SIGNAL mux_58_nl : STD_LOGIC;
  SIGNAL mux_63_nl : STD_LOGIC;
  SIGNAL nand_nl : STD_LOGIC;
  SIGNAL and_71_nl : STD_LOGIC;
  SIGNAL mux_64_nl : STD_LOGIC;
  SIGNAL VEC_LOOP_j_not_1_nl : STD_LOGIC;
  SIGNAL mux_67_nl : STD_LOGIC;
  SIGNAL mux_66_nl : STD_LOGIC;
  SIGNAL or_72_nl : STD_LOGIC;
  SIGNAL or_115_nl : STD_LOGIC;
  SIGNAL mux_28_nl : STD_LOGIC;
  SIGNAL or_111_nl : STD_LOGIC;
  SIGNAL or_112_nl : STD_LOGIC;
  SIGNAL mux_94_nl : STD_LOGIC;
  SIGNAL mux_93_nl : STD_LOGIC;
  SIGNAL mux_92_nl : STD_LOGIC;
  SIGNAL nand_7_nl : STD_LOGIC;
  SIGNAL mux_nl : STD_LOGIC;
  SIGNAL nand_8_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_1_acc_11_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_2_acc_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL mux_75_nl : STD_LOGIC;
  SIGNAL mux_79_nl : STD_LOGIC;
  SIGNAL mux_78_nl : STD_LOGIC;
  SIGNAL mux_76_nl : STD_LOGIC;
  SIGNAL mux_70_nl : STD_LOGIC;
  SIGNAL or_109_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_2_acc_11_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL mux_80_nl : STD_LOGIC;
  SIGNAL or_9_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_1_acc_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL mux_81_nl : STD_LOGIC;
  SIGNAL or_10_nl : STD_LOGIC;
  SIGNAL mux_82_nl : STD_LOGIC;
  SIGNAL nor_28_nl : STD_LOGIC;
  SIGNAL nor_29_nl : STD_LOGIC;
  SIGNAL and_85_nl : STD_LOGIC;
  SIGNAL and_88_nl : STD_LOGIC;
  SIGNAL mux_91_nl : STD_LOGIC;
  SIGNAL mux_90_nl : STD_LOGIC;
  SIGNAL mux_89_nl : STD_LOGIC;
  SIGNAL and_90_nl : STD_LOGIC;
  SIGNAL mux_88_nl : STD_LOGIC;
  SIGNAL mux_87_nl : STD_LOGIC;
  SIGNAL mux_86_nl : STD_LOGIC;
  SIGNAL mux_85_nl : STD_LOGIC;
  SIGNAL or_11_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_1_modulo_qelse_acc_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL or_2_nl : STD_LOGIC;
  SIGNAL or_62_nl : STD_LOGIC;
  SIGNAL mux_83_nl : STD_LOGIC;
  SIGNAL nor_26_nl : STD_LOGIC;
  SIGNAL nor_27_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_3_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_40_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_41_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_42_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_tmp_mux1h_4_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_tmp_mux1h_5_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_tmp_or_2_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_tmp_or_3_nl : STD_LOGIC;
  SIGNAL p_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL COMP_LOOP_1_modulo_result_rem_cmp_a : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL COMP_LOOP_1_modulo_result_rem_cmp_b : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL COMP_LOOP_1_modulo_result_rem_cmp_z_1 : STD_LOGIC_VECTOR (64 DOWNTO 0);

  SIGNAL COMP_LOOP_1_tmp_lshift_rg_a : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL COMP_LOOP_1_tmp_lshift_rg_s : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL COMP_LOOP_1_tmp_lshift_rg_z : STD_LOGIC_VECTOR (9 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_0_0_s_tdone : IN STD_LOGIC;
      vec_rsc_0_0_tr_write_done : IN STD_LOGIC;
      vec_rsc_0_0_RREADY : IN STD_LOGIC;
      vec_rsc_0_0_RVALID : OUT STD_LOGIC;
      vec_rsc_0_0_RUSER : OUT STD_LOGIC;
      vec_rsc_0_0_RLAST : OUT STD_LOGIC;
      vec_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_RID : OUT STD_LOGIC;
      vec_rsc_0_0_ARREADY : OUT STD_LOGIC;
      vec_rsc_0_0_ARVALID : IN STD_LOGIC;
      vec_rsc_0_0_ARUSER : IN STD_LOGIC;
      vec_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_ARLOCK : IN STD_LOGIC;
      vec_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_0_ARID : IN STD_LOGIC;
      vec_rsc_0_0_BREADY : IN STD_LOGIC;
      vec_rsc_0_0_BVALID : OUT STD_LOGIC;
      vec_rsc_0_0_BUSER : OUT STD_LOGIC;
      vec_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_BID : OUT STD_LOGIC;
      vec_rsc_0_0_WREADY : OUT STD_LOGIC;
      vec_rsc_0_0_WVALID : IN STD_LOGIC;
      vec_rsc_0_0_WUSER : IN STD_LOGIC;
      vec_rsc_0_0_WLAST : IN STD_LOGIC;
      vec_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_AWREADY : OUT STD_LOGIC;
      vec_rsc_0_0_AWVALID : IN STD_LOGIC;
      vec_rsc_0_0_AWUSER : IN STD_LOGIC;
      vec_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_AWLOCK : IN STD_LOGIC;
      vec_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_0_AWID : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      vec_rsc_0_0_i_oswt : IN STD_LOGIC;
      vec_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
      vec_rsc_0_0_i_oswt_1 : IN STD_LOGIC;
      vec_rsc_0_0_i_wen_comp_1 : OUT STD_LOGIC;
      vec_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_0_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_RRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_RDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_BRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_WSTRB : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_WDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_waddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_dout_core
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_0_1_s_tdone : IN STD_LOGIC;
      vec_rsc_0_1_tr_write_done : IN STD_LOGIC;
      vec_rsc_0_1_RREADY : IN STD_LOGIC;
      vec_rsc_0_1_RVALID : OUT STD_LOGIC;
      vec_rsc_0_1_RUSER : OUT STD_LOGIC;
      vec_rsc_0_1_RLAST : OUT STD_LOGIC;
      vec_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_RID : OUT STD_LOGIC;
      vec_rsc_0_1_ARREADY : OUT STD_LOGIC;
      vec_rsc_0_1_ARVALID : IN STD_LOGIC;
      vec_rsc_0_1_ARUSER : IN STD_LOGIC;
      vec_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_ARLOCK : IN STD_LOGIC;
      vec_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_1_ARID : IN STD_LOGIC;
      vec_rsc_0_1_BREADY : IN STD_LOGIC;
      vec_rsc_0_1_BVALID : OUT STD_LOGIC;
      vec_rsc_0_1_BUSER : OUT STD_LOGIC;
      vec_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_BID : OUT STD_LOGIC;
      vec_rsc_0_1_WREADY : OUT STD_LOGIC;
      vec_rsc_0_1_WVALID : IN STD_LOGIC;
      vec_rsc_0_1_WUSER : IN STD_LOGIC;
      vec_rsc_0_1_WLAST : IN STD_LOGIC;
      vec_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_AWREADY : OUT STD_LOGIC;
      vec_rsc_0_1_AWVALID : IN STD_LOGIC;
      vec_rsc_0_1_AWUSER : IN STD_LOGIC;
      vec_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_AWLOCK : IN STD_LOGIC;
      vec_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_1_AWID : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      vec_rsc_0_1_i_oswt : IN STD_LOGIC;
      vec_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
      vec_rsc_0_1_i_oswt_1 : IN STD_LOGIC;
      vec_rsc_0_1_i_wen_comp_1 : OUT STD_LOGIC;
      vec_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_1_i_s_waddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_s_dout_core : IN STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_RRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_RDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_BRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_WSTRB : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_WDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_waddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_dout_core
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      twiddle_rsc_0_0_s_tdone : IN STD_LOGIC;
      twiddle_rsc_0_0_tr_write_done : IN STD_LOGIC;
      twiddle_rsc_0_0_RREADY : IN STD_LOGIC;
      twiddle_rsc_0_0_RVALID : OUT STD_LOGIC;
      twiddle_rsc_0_0_RUSER : OUT STD_LOGIC;
      twiddle_rsc_0_0_RLAST : OUT STD_LOGIC;
      twiddle_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_0_RID : OUT STD_LOGIC;
      twiddle_rsc_0_0_ARREADY : OUT STD_LOGIC;
      twiddle_rsc_0_0_ARVALID : IN STD_LOGIC;
      twiddle_rsc_0_0_ARUSER : IN STD_LOGIC;
      twiddle_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_ARLOCK : IN STD_LOGIC;
      twiddle_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_0_ARID : IN STD_LOGIC;
      twiddle_rsc_0_0_BREADY : IN STD_LOGIC;
      twiddle_rsc_0_0_BVALID : OUT STD_LOGIC;
      twiddle_rsc_0_0_BUSER : OUT STD_LOGIC;
      twiddle_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_BID : OUT STD_LOGIC;
      twiddle_rsc_0_0_WREADY : OUT STD_LOGIC;
      twiddle_rsc_0_0_WVALID : IN STD_LOGIC;
      twiddle_rsc_0_0_WUSER : IN STD_LOGIC;
      twiddle_rsc_0_0_WLAST : IN STD_LOGIC;
      twiddle_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_0_AWREADY : OUT STD_LOGIC;
      twiddle_rsc_0_0_AWVALID : IN STD_LOGIC;
      twiddle_rsc_0_0_AWUSER : IN STD_LOGIC;
      twiddle_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_AWLOCK : IN STD_LOGIC;
      twiddle_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_0_AWID : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      twiddle_rsc_0_0_i_oswt : IN STD_LOGIC;
      twiddle_rsc_0_0_i_wen_comp : OUT STD_LOGIC;
      twiddle_rsc_0_0_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      twiddle_rsc_0_0_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_RRESP
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_RDATA
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARREGION
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARQOS
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARPROT
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARCACHE
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARBURST
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARSIZE
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARLEN
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARADDR
      : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_BRESP
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_WSTRB
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_WDATA
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWREGION
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWQOS
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWPROT
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWCACHE
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWBURST
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWSIZE
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWLEN
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWADDR
      : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      twiddle_rsc_0_1_s_tdone : IN STD_LOGIC;
      twiddle_rsc_0_1_tr_write_done : IN STD_LOGIC;
      twiddle_rsc_0_1_RREADY : IN STD_LOGIC;
      twiddle_rsc_0_1_RVALID : OUT STD_LOGIC;
      twiddle_rsc_0_1_RUSER : OUT STD_LOGIC;
      twiddle_rsc_0_1_RLAST : OUT STD_LOGIC;
      twiddle_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_1_RID : OUT STD_LOGIC;
      twiddle_rsc_0_1_ARREADY : OUT STD_LOGIC;
      twiddle_rsc_0_1_ARVALID : IN STD_LOGIC;
      twiddle_rsc_0_1_ARUSER : IN STD_LOGIC;
      twiddle_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_ARLOCK : IN STD_LOGIC;
      twiddle_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_1_ARID : IN STD_LOGIC;
      twiddle_rsc_0_1_BREADY : IN STD_LOGIC;
      twiddle_rsc_0_1_BVALID : OUT STD_LOGIC;
      twiddle_rsc_0_1_BUSER : OUT STD_LOGIC;
      twiddle_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_BID : OUT STD_LOGIC;
      twiddle_rsc_0_1_WREADY : OUT STD_LOGIC;
      twiddle_rsc_0_1_WVALID : IN STD_LOGIC;
      twiddle_rsc_0_1_WUSER : IN STD_LOGIC;
      twiddle_rsc_0_1_WLAST : IN STD_LOGIC;
      twiddle_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_1_AWREADY : OUT STD_LOGIC;
      twiddle_rsc_0_1_AWVALID : IN STD_LOGIC;
      twiddle_rsc_0_1_AWUSER : IN STD_LOGIC;
      twiddle_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_AWLOCK : IN STD_LOGIC;
      twiddle_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_1_AWID : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      twiddle_rsc_0_1_i_oswt : IN STD_LOGIC;
      twiddle_rsc_0_1_i_wen_comp : OUT STD_LOGIC;
      twiddle_rsc_0_1_i_s_raddr_core : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      twiddle_rsc_0_1_i_s_din_mxwt : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_RRESP
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_RDATA
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARREGION
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARQOS
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARPROT
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARCACHE
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARBURST
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARSIZE
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARLEN
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARADDR
      : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_BRESP
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_WSTRB
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_WDATA
      : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWREGION
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWQOS
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWPROT
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWCACHE
      : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWBURST
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWSIZE
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWLEN
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWADDR
      : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_i_s_raddr_core
      : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_i_s_din_mxwt
      : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj
    PORT(
      vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      vec_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj
    PORT(
      vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      vec_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj
    PORT(
      p_rsc_triosy_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      p_rsc_triosy_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj
    PORT(
      r_rsc_triosy_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      r_rsc_triosy_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj
    PORT(
      twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      twiddle_rsc_triosy_0_1_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj
    PORT(
      twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      twiddle_rsc_triosy_0_0_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_staller
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      core_wen : OUT STD_LOGIC;
      core_wten : OUT STD_LOGIC;
      vec_rsc_0_0_i_wen_comp : IN STD_LOGIC;
      vec_rsc_0_0_i_wen_comp_1 : IN STD_LOGIC;
      vec_rsc_0_1_i_wen_comp : IN STD_LOGIC;
      vec_rsc_0_1_i_wen_comp_1 : IN STD_LOGIC;
      twiddle_rsc_0_0_i_wen_comp : IN STD_LOGIC;
      twiddle_rsc_0_1_i_wen_comp : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIT_precomp_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      COMP_LOOP_C_38_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_77_tr0 : IN STD_LOGIC;
      VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
      STAGE_LOOP_C_1_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR
      (6 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 : STD_LOGIC;

  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

  FUNCTION MUX1HOT_v_10_3_2(input_2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(9 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(9 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_4_3_2(input_2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(3 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(3 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_64_3_2(input_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_64_4_2(input_3 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_64_8_2(input_7 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(7 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
      tmp := (OTHERS=>sel( 5));
      result := result or ( input_5 and tmp);
      tmp := (OTHERS=>sel( 6));
      result := result or ( input_6 and tmp);
      tmp := (OTHERS=>sel( 7));
      result := result or ( input_7 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_9_4_2(input_3 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX_s_1_2_2(input_0 : STD_LOGIC;
  input_1 : STD_LOGIC;
  sel : STD_LOGIC)
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_10_2_2(input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(9 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_4_2_2(input_0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(3 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_64_2_2(input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_8_2_2(input_0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(7 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_9_2_2(input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  p_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 2,
      width => 64
      )
    PORT MAP(
      dat => p_rsci_dat,
      idat => p_rsci_idat_1
    );
  p_rsci_dat <= p_rsc_dat;
  p_rsci_idat <= p_rsci_idat_1;

  COMP_LOOP_1_modulo_result_rem_cmp : work.mgc_comps.mgc_rem
    GENERIC MAP(
      width_a => 65,
      width_b => 65,
      signd => 1
      )
    PORT MAP(
      a => COMP_LOOP_1_modulo_result_rem_cmp_a,
      b => COMP_LOOP_1_modulo_result_rem_cmp_b,
      z => COMP_LOOP_1_modulo_result_rem_cmp_z_1
    );
  COMP_LOOP_1_modulo_result_rem_cmp_a <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(COMP_LOOP_1_modulo_result_rem_cmp_a_63_0),65));
  COMP_LOOP_1_modulo_result_rem_cmp_b <= STD_LOGIC_VECTOR(UNSIGNED'( "0") & UNSIGNED(COMP_LOOP_1_modulo_result_rem_cmp_b_63_0));
  COMP_LOOP_1_modulo_result_rem_cmp_z <= COMP_LOOP_1_modulo_result_rem_cmp_z_1;

  COMP_LOOP_1_tmp_lshift_rg : work.mgc_shift_comps_v5.mgc_shift_l_v5
    GENERIC MAP(
      width_a => 1,
      signd_a => 0,
      width_s => 4,
      width_z => 10
      )
    PORT MAP(
      a => COMP_LOOP_1_tmp_lshift_rg_a,
      s => COMP_LOOP_1_tmp_lshift_rg_s,
      z => COMP_LOOP_1_tmp_lshift_rg_z
    );
  COMP_LOOP_1_tmp_lshift_rg_a(0) <= '1';
  COMP_LOOP_1_tmp_lshift_rg_s <= MUX1HOT_v_4_3_2(z_out_1, STAGE_LOOP_i_3_0_sva, COMP_LOOP_1_tmp_acc_cse_sva,
      STD_LOGIC_VECTOR'( (NOT (fsm_output(0))) & (NOT (fsm_output(1))) & (and_dcpl_8
      AND and_dcpl_9 AND (fsm_output(1)) AND (fsm_output(0)) AND (NOT (fsm_output(6))))));
  z_out <= COMP_LOOP_1_tmp_lshift_rg_z;

  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_0_0_s_tdone => vec_rsc_0_0_s_tdone,
      vec_rsc_0_0_tr_write_done => vec_rsc_0_0_tr_write_done,
      vec_rsc_0_0_RREADY => vec_rsc_0_0_RREADY,
      vec_rsc_0_0_RVALID => vec_rsc_0_0_RVALID,
      vec_rsc_0_0_RUSER => vec_rsc_0_0_RUSER,
      vec_rsc_0_0_RLAST => vec_rsc_0_0_RLAST,
      vec_rsc_0_0_RRESP => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_RRESP,
      vec_rsc_0_0_RDATA => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_RDATA,
      vec_rsc_0_0_RID => vec_rsc_0_0_RID,
      vec_rsc_0_0_ARREADY => vec_rsc_0_0_ARREADY,
      vec_rsc_0_0_ARVALID => vec_rsc_0_0_ARVALID,
      vec_rsc_0_0_ARUSER => vec_rsc_0_0_ARUSER,
      vec_rsc_0_0_ARREGION => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARREGION,
      vec_rsc_0_0_ARQOS => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARQOS,
      vec_rsc_0_0_ARPROT => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARPROT,
      vec_rsc_0_0_ARCACHE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARCACHE,
      vec_rsc_0_0_ARLOCK => vec_rsc_0_0_ARLOCK,
      vec_rsc_0_0_ARBURST => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARBURST,
      vec_rsc_0_0_ARSIZE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARSIZE,
      vec_rsc_0_0_ARLEN => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARLEN,
      vec_rsc_0_0_ARADDR => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARADDR,
      vec_rsc_0_0_ARID => vec_rsc_0_0_ARID,
      vec_rsc_0_0_BREADY => vec_rsc_0_0_BREADY,
      vec_rsc_0_0_BVALID => vec_rsc_0_0_BVALID,
      vec_rsc_0_0_BUSER => vec_rsc_0_0_BUSER,
      vec_rsc_0_0_BRESP => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_BRESP,
      vec_rsc_0_0_BID => vec_rsc_0_0_BID,
      vec_rsc_0_0_WREADY => vec_rsc_0_0_WREADY,
      vec_rsc_0_0_WVALID => vec_rsc_0_0_WVALID,
      vec_rsc_0_0_WUSER => vec_rsc_0_0_WUSER,
      vec_rsc_0_0_WLAST => vec_rsc_0_0_WLAST,
      vec_rsc_0_0_WSTRB => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_WSTRB,
      vec_rsc_0_0_WDATA => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_WDATA,
      vec_rsc_0_0_AWREADY => vec_rsc_0_0_AWREADY,
      vec_rsc_0_0_AWVALID => vec_rsc_0_0_AWVALID,
      vec_rsc_0_0_AWUSER => vec_rsc_0_0_AWUSER,
      vec_rsc_0_0_AWREGION => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWREGION,
      vec_rsc_0_0_AWQOS => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWQOS,
      vec_rsc_0_0_AWPROT => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWPROT,
      vec_rsc_0_0_AWCACHE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWCACHE,
      vec_rsc_0_0_AWLOCK => vec_rsc_0_0_AWLOCK,
      vec_rsc_0_0_AWBURST => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWBURST,
      vec_rsc_0_0_AWSIZE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWSIZE,
      vec_rsc_0_0_AWLEN => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWLEN,
      vec_rsc_0_0_AWADDR => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWADDR,
      vec_rsc_0_0_AWID => vec_rsc_0_0_AWID,
      core_wen => core_wen,
      vec_rsc_0_0_i_oswt => reg_vec_rsc_0_0_i_oswt_cse,
      vec_rsc_0_0_i_wen_comp => vec_rsc_0_0_i_wen_comp,
      vec_rsc_0_0_i_oswt_1 => reg_vec_rsc_0_0_i_oswt_1_cse,
      vec_rsc_0_0_i_wen_comp_1 => vec_rsc_0_0_i_wen_comp_1,
      vec_rsc_0_0_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_raddr_core,
      vec_rsc_0_0_i_s_waddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_waddr_core,
      vec_rsc_0_0_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_din_mxwt,
      vec_rsc_0_0_i_s_dout_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_dout_core
    );
  vec_rsc_0_0_RRESP <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_RRESP;
  vec_rsc_0_0_RDATA <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_RDATA;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARREGION <= vec_rsc_0_0_ARREGION;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARQOS <= vec_rsc_0_0_ARQOS;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARPROT <= vec_rsc_0_0_ARPROT;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARCACHE <= vec_rsc_0_0_ARCACHE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARBURST <= vec_rsc_0_0_ARBURST;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARSIZE <= vec_rsc_0_0_ARSIZE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARLEN <= vec_rsc_0_0_ARLEN;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_ARADDR <= vec_rsc_0_0_ARADDR;
  vec_rsc_0_0_BRESP <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_BRESP;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_WSTRB <= vec_rsc_0_0_WSTRB;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_WDATA <= vec_rsc_0_0_WDATA;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWREGION <= vec_rsc_0_0_AWREGION;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWQOS <= vec_rsc_0_0_AWQOS;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWPROT <= vec_rsc_0_0_AWPROT;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWCACHE <= vec_rsc_0_0_AWCACHE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWBURST <= vec_rsc_0_0_AWBURST;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWSIZE <= vec_rsc_0_0_AWSIZE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWLEN <= vec_rsc_0_0_AWLEN;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_AWADDR <= vec_rsc_0_0_AWADDR;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_raddr_core <= reg_vec_rsc_0_0_i_s_raddr_core_cse;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_waddr_core <= reg_vec_rsc_0_0_i_s_waddr_core_cse;
  vec_rsc_0_0_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_din_mxwt;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_0_i_inst_vec_rsc_0_0_i_s_dout_core <= reg_vec_rsc_0_0_i_s_dout_core_cse;

  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_0_1_s_tdone => vec_rsc_0_1_s_tdone,
      vec_rsc_0_1_tr_write_done => vec_rsc_0_1_tr_write_done,
      vec_rsc_0_1_RREADY => vec_rsc_0_1_RREADY,
      vec_rsc_0_1_RVALID => vec_rsc_0_1_RVALID,
      vec_rsc_0_1_RUSER => vec_rsc_0_1_RUSER,
      vec_rsc_0_1_RLAST => vec_rsc_0_1_RLAST,
      vec_rsc_0_1_RRESP => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_RRESP,
      vec_rsc_0_1_RDATA => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_RDATA,
      vec_rsc_0_1_RID => vec_rsc_0_1_RID,
      vec_rsc_0_1_ARREADY => vec_rsc_0_1_ARREADY,
      vec_rsc_0_1_ARVALID => vec_rsc_0_1_ARVALID,
      vec_rsc_0_1_ARUSER => vec_rsc_0_1_ARUSER,
      vec_rsc_0_1_ARREGION => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARREGION,
      vec_rsc_0_1_ARQOS => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARQOS,
      vec_rsc_0_1_ARPROT => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARPROT,
      vec_rsc_0_1_ARCACHE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARCACHE,
      vec_rsc_0_1_ARLOCK => vec_rsc_0_1_ARLOCK,
      vec_rsc_0_1_ARBURST => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARBURST,
      vec_rsc_0_1_ARSIZE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARSIZE,
      vec_rsc_0_1_ARLEN => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARLEN,
      vec_rsc_0_1_ARADDR => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARADDR,
      vec_rsc_0_1_ARID => vec_rsc_0_1_ARID,
      vec_rsc_0_1_BREADY => vec_rsc_0_1_BREADY,
      vec_rsc_0_1_BVALID => vec_rsc_0_1_BVALID,
      vec_rsc_0_1_BUSER => vec_rsc_0_1_BUSER,
      vec_rsc_0_1_BRESP => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_BRESP,
      vec_rsc_0_1_BID => vec_rsc_0_1_BID,
      vec_rsc_0_1_WREADY => vec_rsc_0_1_WREADY,
      vec_rsc_0_1_WVALID => vec_rsc_0_1_WVALID,
      vec_rsc_0_1_WUSER => vec_rsc_0_1_WUSER,
      vec_rsc_0_1_WLAST => vec_rsc_0_1_WLAST,
      vec_rsc_0_1_WSTRB => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_WSTRB,
      vec_rsc_0_1_WDATA => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_WDATA,
      vec_rsc_0_1_AWREADY => vec_rsc_0_1_AWREADY,
      vec_rsc_0_1_AWVALID => vec_rsc_0_1_AWVALID,
      vec_rsc_0_1_AWUSER => vec_rsc_0_1_AWUSER,
      vec_rsc_0_1_AWREGION => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWREGION,
      vec_rsc_0_1_AWQOS => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWQOS,
      vec_rsc_0_1_AWPROT => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWPROT,
      vec_rsc_0_1_AWCACHE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWCACHE,
      vec_rsc_0_1_AWLOCK => vec_rsc_0_1_AWLOCK,
      vec_rsc_0_1_AWBURST => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWBURST,
      vec_rsc_0_1_AWSIZE => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWSIZE,
      vec_rsc_0_1_AWLEN => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWLEN,
      vec_rsc_0_1_AWADDR => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWADDR,
      vec_rsc_0_1_AWID => vec_rsc_0_1_AWID,
      core_wen => core_wen,
      vec_rsc_0_1_i_oswt => reg_vec_rsc_0_1_i_oswt_cse,
      vec_rsc_0_1_i_wen_comp => vec_rsc_0_1_i_wen_comp,
      vec_rsc_0_1_i_oswt_1 => reg_vec_rsc_0_1_i_oswt_1_cse,
      vec_rsc_0_1_i_wen_comp_1 => vec_rsc_0_1_i_wen_comp_1,
      vec_rsc_0_1_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_raddr_core,
      vec_rsc_0_1_i_s_waddr_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_waddr_core,
      vec_rsc_0_1_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_din_mxwt,
      vec_rsc_0_1_i_s_dout_core => inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_dout_core
    );
  vec_rsc_0_1_RRESP <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_RRESP;
  vec_rsc_0_1_RDATA <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_RDATA;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARREGION <= vec_rsc_0_1_ARREGION;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARQOS <= vec_rsc_0_1_ARQOS;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARPROT <= vec_rsc_0_1_ARPROT;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARCACHE <= vec_rsc_0_1_ARCACHE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARBURST <= vec_rsc_0_1_ARBURST;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARSIZE <= vec_rsc_0_1_ARSIZE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARLEN <= vec_rsc_0_1_ARLEN;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_ARADDR <= vec_rsc_0_1_ARADDR;
  vec_rsc_0_1_BRESP <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_BRESP;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_WSTRB <= vec_rsc_0_1_WSTRB;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_WDATA <= vec_rsc_0_1_WDATA;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWREGION <= vec_rsc_0_1_AWREGION;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWQOS <= vec_rsc_0_1_AWQOS;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWPROT <= vec_rsc_0_1_AWPROT;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWCACHE <= vec_rsc_0_1_AWCACHE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWBURST <= vec_rsc_0_1_AWBURST;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWSIZE <= vec_rsc_0_1_AWSIZE;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWLEN <= vec_rsc_0_1_AWLEN;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_AWADDR <= vec_rsc_0_1_AWADDR;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_raddr_core <= reg_vec_rsc_0_0_i_s_raddr_core_cse;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_waddr_core <= reg_vec_rsc_0_0_i_s_waddr_core_cse;
  vec_rsc_0_1_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_din_mxwt;
  inPlaceNTT_DIT_precomp_core_vec_rsc_0_1_i_inst_vec_rsc_0_1_i_s_dout_core <= reg_vec_rsc_0_0_i_s_dout_core_cse;

  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst : inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i
    PORT MAP(
      clk => clk,
      rst => rst,
      twiddle_rsc_0_0_s_tdone => twiddle_rsc_0_0_s_tdone,
      twiddle_rsc_0_0_tr_write_done => twiddle_rsc_0_0_tr_write_done,
      twiddle_rsc_0_0_RREADY => twiddle_rsc_0_0_RREADY,
      twiddle_rsc_0_0_RVALID => twiddle_rsc_0_0_RVALID,
      twiddle_rsc_0_0_RUSER => twiddle_rsc_0_0_RUSER,
      twiddle_rsc_0_0_RLAST => twiddle_rsc_0_0_RLAST,
      twiddle_rsc_0_0_RRESP => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_RRESP,
      twiddle_rsc_0_0_RDATA => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_RDATA,
      twiddle_rsc_0_0_RID => twiddle_rsc_0_0_RID,
      twiddle_rsc_0_0_ARREADY => twiddle_rsc_0_0_ARREADY,
      twiddle_rsc_0_0_ARVALID => twiddle_rsc_0_0_ARVALID,
      twiddle_rsc_0_0_ARUSER => twiddle_rsc_0_0_ARUSER,
      twiddle_rsc_0_0_ARREGION => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARREGION,
      twiddle_rsc_0_0_ARQOS => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARQOS,
      twiddle_rsc_0_0_ARPROT => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARPROT,
      twiddle_rsc_0_0_ARCACHE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARCACHE,
      twiddle_rsc_0_0_ARLOCK => twiddle_rsc_0_0_ARLOCK,
      twiddle_rsc_0_0_ARBURST => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARBURST,
      twiddle_rsc_0_0_ARSIZE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARSIZE,
      twiddle_rsc_0_0_ARLEN => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARLEN,
      twiddle_rsc_0_0_ARADDR => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARADDR,
      twiddle_rsc_0_0_ARID => twiddle_rsc_0_0_ARID,
      twiddle_rsc_0_0_BREADY => twiddle_rsc_0_0_BREADY,
      twiddle_rsc_0_0_BVALID => twiddle_rsc_0_0_BVALID,
      twiddle_rsc_0_0_BUSER => twiddle_rsc_0_0_BUSER,
      twiddle_rsc_0_0_BRESP => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_BRESP,
      twiddle_rsc_0_0_BID => twiddle_rsc_0_0_BID,
      twiddle_rsc_0_0_WREADY => twiddle_rsc_0_0_WREADY,
      twiddle_rsc_0_0_WVALID => twiddle_rsc_0_0_WVALID,
      twiddle_rsc_0_0_WUSER => twiddle_rsc_0_0_WUSER,
      twiddle_rsc_0_0_WLAST => twiddle_rsc_0_0_WLAST,
      twiddle_rsc_0_0_WSTRB => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_WSTRB,
      twiddle_rsc_0_0_WDATA => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_WDATA,
      twiddle_rsc_0_0_AWREADY => twiddle_rsc_0_0_AWREADY,
      twiddle_rsc_0_0_AWVALID => twiddle_rsc_0_0_AWVALID,
      twiddle_rsc_0_0_AWUSER => twiddle_rsc_0_0_AWUSER,
      twiddle_rsc_0_0_AWREGION => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWREGION,
      twiddle_rsc_0_0_AWQOS => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWQOS,
      twiddle_rsc_0_0_AWPROT => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWPROT,
      twiddle_rsc_0_0_AWCACHE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWCACHE,
      twiddle_rsc_0_0_AWLOCK => twiddle_rsc_0_0_AWLOCK,
      twiddle_rsc_0_0_AWBURST => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWBURST,
      twiddle_rsc_0_0_AWSIZE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWSIZE,
      twiddle_rsc_0_0_AWLEN => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWLEN,
      twiddle_rsc_0_0_AWADDR => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWADDR,
      twiddle_rsc_0_0_AWID => twiddle_rsc_0_0_AWID,
      core_wen => core_wen,
      twiddle_rsc_0_0_i_oswt => reg_twiddle_rsc_0_0_i_oswt_cse,
      twiddle_rsc_0_0_i_wen_comp => twiddle_rsc_0_0_i_wen_comp,
      twiddle_rsc_0_0_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_i_s_raddr_core,
      twiddle_rsc_0_0_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_i_s_din_mxwt
    );
  twiddle_rsc_0_0_RRESP <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_RRESP;
  twiddle_rsc_0_0_RDATA <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_RDATA;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARREGION <=
      twiddle_rsc_0_0_ARREGION;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARQOS <= twiddle_rsc_0_0_ARQOS;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARPROT <= twiddle_rsc_0_0_ARPROT;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARCACHE <= twiddle_rsc_0_0_ARCACHE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARBURST <= twiddle_rsc_0_0_ARBURST;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARSIZE <= twiddle_rsc_0_0_ARSIZE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARLEN <= twiddle_rsc_0_0_ARLEN;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_ARADDR <= twiddle_rsc_0_0_ARADDR;
  twiddle_rsc_0_0_BRESP <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_BRESP;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_WSTRB <= twiddle_rsc_0_0_WSTRB;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_WDATA <= twiddle_rsc_0_0_WDATA;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWREGION <=
      twiddle_rsc_0_0_AWREGION;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWQOS <= twiddle_rsc_0_0_AWQOS;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWPROT <= twiddle_rsc_0_0_AWPROT;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWCACHE <= twiddle_rsc_0_0_AWCACHE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWBURST <= twiddle_rsc_0_0_AWBURST;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWSIZE <= twiddle_rsc_0_0_AWSIZE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWLEN <= twiddle_rsc_0_0_AWLEN;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_AWADDR <= twiddle_rsc_0_0_AWADDR;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_i_s_raddr_core
      <= twiddle_rsc_0_0_i_s_raddr_core;
  twiddle_rsc_0_0_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_0_i_inst_twiddle_rsc_0_0_i_s_din_mxwt;

  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst : inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i
    PORT MAP(
      clk => clk,
      rst => rst,
      twiddle_rsc_0_1_s_tdone => twiddle_rsc_0_1_s_tdone,
      twiddle_rsc_0_1_tr_write_done => twiddle_rsc_0_1_tr_write_done,
      twiddle_rsc_0_1_RREADY => twiddle_rsc_0_1_RREADY,
      twiddle_rsc_0_1_RVALID => twiddle_rsc_0_1_RVALID,
      twiddle_rsc_0_1_RUSER => twiddle_rsc_0_1_RUSER,
      twiddle_rsc_0_1_RLAST => twiddle_rsc_0_1_RLAST,
      twiddle_rsc_0_1_RRESP => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_RRESP,
      twiddle_rsc_0_1_RDATA => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_RDATA,
      twiddle_rsc_0_1_RID => twiddle_rsc_0_1_RID,
      twiddle_rsc_0_1_ARREADY => twiddle_rsc_0_1_ARREADY,
      twiddle_rsc_0_1_ARVALID => twiddle_rsc_0_1_ARVALID,
      twiddle_rsc_0_1_ARUSER => twiddle_rsc_0_1_ARUSER,
      twiddle_rsc_0_1_ARREGION => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARREGION,
      twiddle_rsc_0_1_ARQOS => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARQOS,
      twiddle_rsc_0_1_ARPROT => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARPROT,
      twiddle_rsc_0_1_ARCACHE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARCACHE,
      twiddle_rsc_0_1_ARLOCK => twiddle_rsc_0_1_ARLOCK,
      twiddle_rsc_0_1_ARBURST => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARBURST,
      twiddle_rsc_0_1_ARSIZE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARSIZE,
      twiddle_rsc_0_1_ARLEN => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARLEN,
      twiddle_rsc_0_1_ARADDR => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARADDR,
      twiddle_rsc_0_1_ARID => twiddle_rsc_0_1_ARID,
      twiddle_rsc_0_1_BREADY => twiddle_rsc_0_1_BREADY,
      twiddle_rsc_0_1_BVALID => twiddle_rsc_0_1_BVALID,
      twiddle_rsc_0_1_BUSER => twiddle_rsc_0_1_BUSER,
      twiddle_rsc_0_1_BRESP => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_BRESP,
      twiddle_rsc_0_1_BID => twiddle_rsc_0_1_BID,
      twiddle_rsc_0_1_WREADY => twiddle_rsc_0_1_WREADY,
      twiddle_rsc_0_1_WVALID => twiddle_rsc_0_1_WVALID,
      twiddle_rsc_0_1_WUSER => twiddle_rsc_0_1_WUSER,
      twiddle_rsc_0_1_WLAST => twiddle_rsc_0_1_WLAST,
      twiddle_rsc_0_1_WSTRB => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_WSTRB,
      twiddle_rsc_0_1_WDATA => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_WDATA,
      twiddle_rsc_0_1_AWREADY => twiddle_rsc_0_1_AWREADY,
      twiddle_rsc_0_1_AWVALID => twiddle_rsc_0_1_AWVALID,
      twiddle_rsc_0_1_AWUSER => twiddle_rsc_0_1_AWUSER,
      twiddle_rsc_0_1_AWREGION => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWREGION,
      twiddle_rsc_0_1_AWQOS => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWQOS,
      twiddle_rsc_0_1_AWPROT => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWPROT,
      twiddle_rsc_0_1_AWCACHE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWCACHE,
      twiddle_rsc_0_1_AWLOCK => twiddle_rsc_0_1_AWLOCK,
      twiddle_rsc_0_1_AWBURST => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWBURST,
      twiddle_rsc_0_1_AWSIZE => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWSIZE,
      twiddle_rsc_0_1_AWLEN => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWLEN,
      twiddle_rsc_0_1_AWADDR => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWADDR,
      twiddle_rsc_0_1_AWID => twiddle_rsc_0_1_AWID,
      core_wen => core_wen,
      twiddle_rsc_0_1_i_oswt => reg_twiddle_rsc_0_1_i_oswt_cse,
      twiddle_rsc_0_1_i_wen_comp => twiddle_rsc_0_1_i_wen_comp,
      twiddle_rsc_0_1_i_s_raddr_core => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_i_s_raddr_core,
      twiddle_rsc_0_1_i_s_din_mxwt => inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_i_s_din_mxwt
    );
  twiddle_rsc_0_1_RRESP <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_RRESP;
  twiddle_rsc_0_1_RDATA <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_RDATA;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARREGION <=
      twiddle_rsc_0_1_ARREGION;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARQOS <= twiddle_rsc_0_1_ARQOS;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARPROT <= twiddle_rsc_0_1_ARPROT;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARCACHE <= twiddle_rsc_0_1_ARCACHE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARBURST <= twiddle_rsc_0_1_ARBURST;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARSIZE <= twiddle_rsc_0_1_ARSIZE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARLEN <= twiddle_rsc_0_1_ARLEN;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_ARADDR <= twiddle_rsc_0_1_ARADDR;
  twiddle_rsc_0_1_BRESP <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_BRESP;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_WSTRB <= twiddle_rsc_0_1_WSTRB;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_WDATA <= twiddle_rsc_0_1_WDATA;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWREGION <=
      twiddle_rsc_0_1_AWREGION;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWQOS <= twiddle_rsc_0_1_AWQOS;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWPROT <= twiddle_rsc_0_1_AWPROT;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWCACHE <= twiddle_rsc_0_1_AWCACHE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWBURST <= twiddle_rsc_0_1_AWBURST;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWSIZE <= twiddle_rsc_0_1_AWSIZE;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWLEN <= twiddle_rsc_0_1_AWLEN;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_AWADDR <= twiddle_rsc_0_1_AWADDR;
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_i_s_raddr_core
      <= twiddle_rsc_0_1_i_s_raddr_core;
  twiddle_rsc_0_1_i_s_din_mxwt <= inPlaceNTT_DIT_precomp_core_twiddle_rsc_0_1_i_inst_twiddle_rsc_0_1_i_s_din_mxwt;

  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_1_obj
    PORT MAP(
      vec_rsc_triosy_0_1_lz => vec_rsc_triosy_0_1_lz,
      core_wten => core_wten,
      vec_rsc_triosy_0_1_obj_iswt0 => reg_vec_rsc_triosy_0_1_obj_iswt0_cse
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj_inst : inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_0_0_obj
    PORT MAP(
      vec_rsc_triosy_0_0_lz => vec_rsc_triosy_0_0_lz,
      core_wten => core_wten,
      vec_rsc_triosy_0_0_obj_iswt0 => reg_vec_rsc_triosy_0_1_obj_iswt0_cse
    );
  inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_inst : inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj
    PORT MAP(
      p_rsc_triosy_lz => p_rsc_triosy_lz,
      core_wten => core_wten,
      p_rsc_triosy_obj_iswt0 => reg_vec_rsc_triosy_0_1_obj_iswt0_cse
    );
  inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_inst : inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj
    PORT MAP(
      r_rsc_triosy_lz => r_rsc_triosy_lz,
      core_wten => core_wten,
      r_rsc_triosy_obj_iswt0 => reg_vec_rsc_triosy_0_1_obj_iswt0_cse
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj_inst : inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_1_obj
    PORT MAP(
      twiddle_rsc_triosy_0_1_lz => twiddle_rsc_triosy_0_1_lz,
      core_wten => core_wten,
      twiddle_rsc_triosy_0_1_obj_iswt0 => reg_vec_rsc_triosy_0_1_obj_iswt0_cse
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj_inst : inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_0_0_obj
    PORT MAP(
      twiddle_rsc_triosy_0_0_lz => twiddle_rsc_triosy_0_0_lz,
      core_wten => core_wten,
      twiddle_rsc_triosy_0_0_obj_iswt0 => reg_vec_rsc_triosy_0_1_obj_iswt0_cse
    );
  inPlaceNTT_DIT_precomp_core_staller_inst : inPlaceNTT_DIT_precomp_core_staller
    PORT MAP(
      clk => clk,
      rst => rst,
      core_wen => core_wen,
      core_wten => core_wten,
      vec_rsc_0_0_i_wen_comp => vec_rsc_0_0_i_wen_comp,
      vec_rsc_0_0_i_wen_comp_1 => vec_rsc_0_0_i_wen_comp_1,
      vec_rsc_0_1_i_wen_comp => vec_rsc_0_1_i_wen_comp,
      vec_rsc_0_1_i_wen_comp_1 => vec_rsc_0_1_i_wen_comp_1,
      twiddle_rsc_0_0_i_wen_comp => twiddle_rsc_0_0_i_wen_comp,
      twiddle_rsc_0_1_i_wen_comp => twiddle_rsc_0_1_i_wen_comp
    );
  inPlaceNTT_DIT_precomp_core_core_fsm_inst : inPlaceNTT_DIT_precomp_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      core_wen => core_wen,
      fsm_output => inPlaceNTT_DIT_precomp_core_core_fsm_inst_fsm_output,
      COMP_LOOP_C_38_tr0 => inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0,
      COMP_LOOP_C_77_tr0 => inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0,
      VEC_LOOP_C_0_tr0 => inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_1_tr0 => inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0
    );
  fsm_output <= inPlaceNTT_DIT_precomp_core_core_fsm_inst_fsm_output;
  inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0 <= NOT COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0 <= z_out_3(10);
  inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 <= NOT (z_out_2(2));

  and_98_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  or_118_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_116_cse <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00"));
  COMP_LOOP_and_cse <= core_wen AND (NOT(or_dcpl_10 OR or_dcpl_8));
  COMP_LOOP_and_5_cse <= core_wen AND (NOT(or_116_cse OR CONV_SL_1_1(fsm_output(3
      DOWNTO 2)/=STD_LOGIC_VECTOR'("11")) OR or_dcpl_12));
  COMP_LOOP_and_7_cse <= core_wen AND (NOT((NOT nor_tmp_3) OR CONV_SL_1_1(fsm_output(3
      DOWNTO 2)/=STD_LOGIC_VECTOR'("01")) OR or_dcpl_8));
  COMP_LOOP_1_modulo_qelse_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_1_modulo_result_rem_cmp_z(63
      DOWNTO 0)) + UNSIGNED(p_sva), 64));
  vec_rsc_0_0_i_s_dout_core_1 <= MUX_v_64_2_2((COMP_LOOP_1_modulo_result_rem_cmp_z(63
      DOWNTO 0)), STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_1_modulo_qelse_acc_nl),
      64)), COMP_LOOP_1_modulo_result_rem_cmp_z(63));
  COMP_LOOP_2_acc_5_psp_mx0w2 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(tmp_2_lpi_4_dfm)
      + SIGNED(vec_rsc_0_0_i_s_dout_core_1), 64));
  COMP_LOOP_1_acc_10_tmp <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_9_0)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0 & '0'), 9),
      10) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva(9 DOWNTO
      1)), 9), 10), 10));
  COMP_LOOP_1_acc_8_itm_mx0w0 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(tmp_2_lpi_4_dfm)
      - SIGNED(vec_rsc_0_0_i_s_dout_core_1), 64));
  or_tmp <= CONV_SL_1_1(fsm_output(5 DOWNTO 1)/=STD_LOGIC_VECTOR'("00000"));
  nor_tmp_3 <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("11"));
  and_dcpl_6 <= NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_7 <= and_dcpl_6 AND (NOT (fsm_output(6)));
  and_dcpl_8 <= NOT(CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_9 <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_10 <= and_dcpl_9 AND and_dcpl_8;
  and_dcpl_12 <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_14 <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_15 <= and_dcpl_14 AND and_dcpl_8;
  and_dcpl_18 <= NOT((fsm_output(4)) OR (fsm_output(2)) OR (fsm_output(6)));
  not_tmp_34 <= NOT((fsm_output(3)) AND (fsm_output(5)));
  and_dcpl_21 <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_22 <= and_dcpl_21 AND (NOT (fsm_output(6)));
  and_dcpl_23 <= and_dcpl_10 AND and_dcpl_22;
  and_dcpl_25 <= (fsm_output(0)) AND (fsm_output(1)) AND (NOT (fsm_output(6)));
  and_dcpl_26 <= and_dcpl_10 AND and_dcpl_25;
  and_dcpl_27 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_28 <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_29 <= and_dcpl_28 AND and_dcpl_27;
  and_dcpl_31 <= and_dcpl_12 AND (NOT (fsm_output(6)));
  and_dcpl_35 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_38 <= and_dcpl_21 AND (fsm_output(6));
  and_dcpl_40 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("11"));
  and_dcpl_50 <= and_dcpl_9 AND and_dcpl_35;
  and_dcpl_51 <= and_dcpl_50 AND and_dcpl_7;
  or_dcpl_4 <= NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11")));
  or_2_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("10"));
  or_62_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("01"));
  mux_tmp_53 <= MUX_s_1_2_2(or_2_nl, or_62_nl, fsm_output(3));
  and_dcpl_67 <= and_dcpl_29 AND and_dcpl_22;
  or_tmp_59 <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("01"));
  mux_tmp_57 <= MUX_s_1_2_2((NOT (fsm_output(4))), (fsm_output(4)), fsm_output(3));
  or_tmp_60 <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("10"));
  mux_tmp_68 <= MUX_s_1_2_2(nor_tmp_3, (fsm_output(5)), fsm_output(3));
  mux_tmp_69 <= MUX_s_1_2_2((NOT (fsm_output(4))), (fsm_output(4)), fsm_output(5));
  or_dcpl_8 <= (fsm_output(0)) OR (NOT (fsm_output(1))) OR (fsm_output(6));
  or_dcpl_10 <= or_116_cse OR CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00"));
  not_tmp_58 <= NOT(and_98_cse OR CONV_SL_1_1(fsm_output(5 DOWNTO 2)/=STD_LOGIC_VECTOR'("0000")));
  mux_tmp_77 <= MUX_s_1_2_2(mux_tmp_69, nor_tmp_3, fsm_output(3));
  or_dcpl_12 <= or_dcpl_4 OR (fsm_output(6));
  and_dcpl_80 <= NOT((fsm_output(4)) OR (fsm_output(1)) OR (fsm_output(6)));
  STAGE_LOOP_i_3_0_sva_mx0c1 <= and_dcpl_15 AND and_dcpl_12 AND (fsm_output(6));
  VEC_LOOP_j_sva_9_0_mx0c0 <= and_dcpl_10 AND and_dcpl_31;
  nor_26_nl <= NOT((NOT (VEC_LOOP_j_sva_9_0(0))) OR (NOT (fsm_output(2))) OR (fsm_output(3))
      OR (fsm_output(5)));
  nor_27_nl <= NOT((NOT (COMP_LOOP_acc_1_cse_sva(0))) OR (fsm_output(2)) OR not_tmp_34);
  mux_83_nl <= MUX_s_1_2_2(nor_26_nl, nor_27_nl, fsm_output(0));
  tmp_2_lpi_4_dfm_mx0c1 <= mux_83_nl AND and_dcpl_80;
  and_dcpl_111 <= NOT(CONV_SL_1_1(fsm_output/=STD_LOGIC_VECTOR'("0000010")));
  and_dcpl_122 <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("01")) AND
      and_dcpl_8 AND (NOT (fsm_output(1))) AND (fsm_output(0)) AND (fsm_output(6));
  and_dcpl_133 <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("01")) AND
      and_dcpl_8 AND (NOT (fsm_output(1))) AND (NOT (fsm_output(0))) AND (fsm_output(6));
  and_dcpl_135 <= (fsm_output(1)) AND (NOT (fsm_output(0))) AND (NOT (fsm_output(6)));
  and_dcpl_138 <= and_dcpl_9 AND CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("00"));
  and_dcpl_139 <= and_dcpl_138 AND and_dcpl_135;
  and_dcpl_142 <= and_dcpl_138 AND (fsm_output(1)) AND (fsm_output(0)) AND (NOT (fsm_output(6)));
  and_dcpl_146 <= CONV_SL_1_1(fsm_output(5 DOWNTO 2)=STD_LOGIC_VECTOR'("1010")) AND
      and_dcpl_135;
  and_dcpl_151 <= and_dcpl_9 AND (NOT (fsm_output(3))) AND (fsm_output(2)) AND (NOT
      (fsm_output(1))) AND (NOT (fsm_output(0))) AND (NOT (fsm_output(6)));
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (core_wen AND mux_34_nl) = '1' ) THEN
        p_sva <= p_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (core_wen AND ((and_dcpl_10 AND and_dcpl_7) OR STAGE_LOOP_i_3_0_sva_mx0c1))
          = '1' ) THEN
        STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(STD_LOGIC_VECTOR'( "0001"), z_out_1,
            STAGE_LOOP_i_3_0_sva_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( core_wen = '1' ) THEN
        reg_vec_rsc_0_0_i_s_raddr_core_cse <= MUX1HOT_v_9_4_2((COMP_LOOP_1_acc_10_tmp(9
            DOWNTO 1)), COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_1_cse_sva(9 DOWNTO
            1)), (COMP_LOOP_2_acc_10_idiv_sva(9 DOWNTO 1)), STD_LOGIC_VECTOR'( and_dcpl_23
            & and_dcpl_26 & and_30_nl & and_32_nl));
        reg_vec_rsc_0_0_i_s_waddr_core_cse <= MUX1HOT_v_9_4_2(COMP_LOOP_acc_psp_sva,
            (COMP_LOOP_1_slc_31_1_idiv_sva(9 DOWNTO 1)), (COMP_LOOP_acc_1_cse_sva(9
            DOWNTO 1)), (COMP_LOOP_2_slc_31_1_idiv_sva(9 DOWNTO 1)), STD_LOGIC_VECTOR'(
            and_34_nl & and_37_nl & and_39_nl & and_42_nl));
        reg_vec_rsc_0_0_i_s_dout_core_cse <= vec_rsc_0_0_i_s_dout_core_1;
        twiddle_rsc_0_0_i_s_raddr_core <= MUX_v_9_2_2((z_out_4(8 DOWNTO 0)), (z_out_4(9
            DOWNTO 1)), and_dcpl_51);
        twiddle_rsc_0_1_i_s_raddr_core <= z_out_4(9 DOWNTO 1);
        COMP_LOOP_1_modulo_result_rem_cmp_a_63_0 <= MUX1HOT_v_64_8_2(z_out_4, COMP_LOOP_1_mul_psp,
            COMP_LOOP_2_acc_5_psp_mx0w2, COMP_LOOP_1_acc_5_psp, COMP_LOOP_1_acc_8_itm,
            COMP_LOOP_2_mul_psp, COMP_LOOP_2_acc_5_psp, COMP_LOOP_2_acc_8_itm, STD_LOGIC_VECTOR'(
            COMP_LOOP_or_2_nl & and_59_nl & and_62_nl & and_65_nl & nor_55_nl & and_69_nl
            & (NOT mux_63_nl) & and_71_nl));
        COMP_LOOP_1_modulo_result_rem_cmp_b_63_0 <= p_sva;
        COMP_LOOP_1_tmp_acc_cse_sva <= z_out_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_vec_rsc_0_0_i_oswt_cse <= '0';
        reg_vec_rsc_0_0_i_oswt_1_cse <= '0';
        reg_vec_rsc_0_1_i_oswt_cse <= '0';
        reg_vec_rsc_0_1_i_oswt_1_cse <= '0';
        reg_twiddle_rsc_0_0_i_oswt_cse <= '0';
        reg_twiddle_rsc_0_1_i_oswt_cse <= '0';
        reg_vec_rsc_triosy_0_1_obj_iswt0_cse <= '0';
        COMP_LOOP_2_tmp_lshift_itm <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( core_wen = '1' ) THEN
        reg_vec_rsc_0_0_i_oswt_cse <= mux_38_nl AND and_dcpl_18;
        reg_vec_rsc_0_0_i_oswt_1_cse <= mux_41_nl AND (fsm_output(1));
        reg_vec_rsc_0_1_i_oswt_cse <= mux_44_nl AND and_dcpl_18;
        reg_vec_rsc_0_1_i_oswt_1_cse <= mux_47_nl AND (fsm_output(1));
        reg_twiddle_rsc_0_0_i_oswt_cse <= NOT(mux_49_nl OR (fsm_output(4)) OR (fsm_output(5))
            OR (fsm_output(3)) OR (fsm_output(0)) OR (fsm_output(6)));
        reg_twiddle_rsc_0_1_i_oswt_cse <= and_dcpl_50 AND and_dcpl_6 AND (NOT (fsm_output(6)))
            AND (z_out_4(0));
        reg_vec_rsc_triosy_0_1_obj_iswt0_cse <= and_dcpl_15 AND and_dcpl_12 AND (fsm_output(6))
            AND (NOT (z_out_2(2)));
        COMP_LOOP_2_tmp_lshift_itm <= MUX1HOT_v_10_3_2(COMP_LOOP_1_acc_10_tmp, z_out,
            (z_out_4(9 DOWNTO 0)), STD_LOGIC_VECTOR'( and_dcpl_23 & and_dcpl_26 &
            and_dcpl_51));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        VEC_LOOP_j_sva_9_0 <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (core_wen AND (VEC_LOOP_j_sva_9_0_mx0c0 OR (and_dcpl_15 AND and_dcpl_6
          AND (fsm_output(6))))) = '1' ) THEN
        VEC_LOOP_j_sva_9_0 <= MUX_v_10_2_2(STD_LOGIC_VECTOR'("0000000000"), (z_out_3(9
            DOWNTO 0)), VEC_LOOP_j_not_1_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (core_wen AND mux_67_nl) = '1' ) THEN
        STAGE_LOOP_lshift_psp_sva <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (mux_94_nl AND core_wen) = '1' ) THEN
        COMP_LOOP_k_9_1_sva_7_0 <= MUX_v_8_2_2(STD_LOGIC_VECTOR'("00000000"), reg_COMP_LOOP_k_9_1_ftd,
            or_115_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( COMP_LOOP_and_cse = '1' ) THEN
        COMP_LOOP_acc_psp_sva <= z_out_3(8 DOWNTO 0);
        COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm <= COMP_LOOP_2_acc_nl(9);
        reg_COMP_LOOP_k_9_1_ftd <= z_out_2(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_1_slc_31_1_idiv_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( COMP_LOOP_and_cse = '1' ) THEN
        COMP_LOOP_1_slc_31_1_idiv_sva <= COMP_LOOP_1_acc_11_nl(10 DOWNTO 1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (core_wen AND mux_75_nl) = '1' ) THEN
        COMP_LOOP_acc_1_cse_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_9_0)
            + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0 & '1'),
            9), 10), 10));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_2_acc_10_idiv_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (core_wen AND (mux_79_nl OR (fsm_output(6)))) = '1' ) THEN
        COMP_LOOP_2_acc_10_idiv_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_9_0)
            + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0 & '1'),
            9), 10) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva(9
            DOWNTO 1)), 9), 10), 10));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_2_slc_31_1_idiv_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (core_wen AND mux_80_nl) = '1' ) THEN
        COMP_LOOP_2_slc_31_1_idiv_sva <= COMP_LOOP_2_acc_11_nl(10 DOWNTO 1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (core_wen AND mux_81_nl) = '1' ) THEN
        COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm <= COMP_LOOP_1_acc_nl(9);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (core_wen AND (NOT(or_dcpl_10 OR or_dcpl_12))) = '1' ) THEN
        COMP_LOOP_1_mul_psp <= z_out_4;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (core_wen AND ((mux_82_nl AND and_dcpl_80) OR tmp_2_lpi_4_dfm_mx0c1))
          = '1' ) THEN
        tmp_2_lpi_4_dfm <= MUX_v_64_2_2(vec_rsc_0_0_i_s_din_mxwt, vec_rsc_0_1_i_s_din_mxwt,
            tmp_2_lpi_4_dfm_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (core_wen AND (mux_91_nl OR (fsm_output(6)))) = '1' ) THEN
        COMP_LOOP_2_mul_psp <= MUX1HOT_v_64_3_2(twiddle_rsc_0_0_i_s_din_mxwt, twiddle_rsc_0_1_i_s_din_mxwt,
            z_out_4, STD_LOGIC_VECTOR'( and_85_nl & and_88_nl & and_dcpl_67));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( COMP_LOOP_and_5_cse = '1' ) THEN
        COMP_LOOP_1_acc_8_itm <= COMP_LOOP_1_acc_8_itm_mx0w0;
        COMP_LOOP_1_acc_5_psp <= COMP_LOOP_2_acc_5_psp_mx0w2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( COMP_LOOP_and_7_cse = '1' ) THEN
        COMP_LOOP_2_acc_8_itm <= COMP_LOOP_1_acc_8_itm_mx0w0;
        COMP_LOOP_2_acc_5_psp <= COMP_LOOP_2_acc_5_psp_mx0w2;
      END IF;
    END IF;
  END PROCESS;
  nor_43_nl <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 0)/=STD_LOGIC_VECTOR'("000000")));
  or_106_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 1)/=STD_LOGIC_VECTOR'("000"));
  mux_33_nl <= MUX_s_1_2_2((fsm_output(5)), or_116_cse, or_106_nl);
  mux_34_nl <= MUX_s_1_2_2(nor_43_nl, mux_33_nl, fsm_output(6));
  nor_39_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR (COMP_LOOP_acc_1_cse_sva(0))
      OR not_tmp_34);
  nor_40_nl <= NOT((COMP_LOOP_2_acc_10_idiv_sva(0)) OR not_tmp_34);
  mux_37_nl <= MUX_s_1_2_2(nor_39_nl, nor_40_nl, fsm_output(0));
  nor_41_nl <= NOT((COMP_LOOP_1_acc_10_tmp(0)) OR (fsm_output(3)) OR (fsm_output(5)));
  nor_42_nl <= NOT((VEC_LOOP_j_sva_9_0(0)) OR (fsm_output(3)) OR (fsm_output(5)));
  mux_36_nl <= MUX_s_1_2_2(nor_41_nl, nor_42_nl, fsm_output(0));
  mux_38_nl <= MUX_s_1_2_2(mux_37_nl, mux_36_nl, fsm_output(1));
  or_43_nl <= (fsm_output(2)) OR (COMP_LOOP_acc_1_cse_sva(0)) OR (fsm_output(5));
  or_42_nl <= (NOT (fsm_output(2))) OR (COMP_LOOP_2_slc_31_1_idiv_sva(0)) OR (fsm_output(5));
  mux_40_nl <= MUX_s_1_2_2(or_43_nl, or_42_nl, fsm_output(3));
  nor_37_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(4)) OR mux_40_nl);
  or_39_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("01")) OR (COMP_LOOP_1_slc_31_1_idiv_sva(0))
      OR (NOT (fsm_output(5)));
  or_37_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("10")) OR (VEC_LOOP_j_sva_9_0(0))
      OR (fsm_output(5));
  mux_39_nl <= MUX_s_1_2_2(or_39_nl, or_37_nl, fsm_output(4));
  nor_38_nl <= NOT((fsm_output(6)) OR mux_39_nl);
  mux_41_nl <= MUX_s_1_2_2(nor_37_nl, nor_38_nl, fsm_output(0));
  and_30_nl <= and_dcpl_29 AND and_dcpl_7;
  and_32_nl <= and_dcpl_29 AND and_dcpl_31;
  and_34_nl <= and_dcpl_14 AND and_dcpl_27 AND and_dcpl_25;
  and_37_nl <= and_dcpl_28 AND and_dcpl_35 AND and_dcpl_25;
  and_39_nl <= and_dcpl_10 AND and_dcpl_38;
  and_42_nl <= and_dcpl_9 AND and_dcpl_40 AND and_dcpl_38;
  and_99_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND (COMP_LOOP_acc_1_cse_sva(0))
      AND (fsm_output(3)) AND (fsm_output(5));
  and_100_nl <= (COMP_LOOP_2_acc_10_idiv_sva(0)) AND (fsm_output(3)) AND (fsm_output(5));
  mux_43_nl <= MUX_s_1_2_2(and_99_nl, and_100_nl, fsm_output(0));
  nor_35_nl <= NOT((NOT (COMP_LOOP_1_acc_10_tmp(0))) OR (fsm_output(3)) OR (fsm_output(5)));
  nor_36_nl <= NOT((NOT (VEC_LOOP_j_sva_9_0(0))) OR (fsm_output(3)) OR (fsm_output(5)));
  mux_42_nl <= MUX_s_1_2_2(nor_35_nl, nor_36_nl, fsm_output(0));
  mux_44_nl <= MUX_s_1_2_2(mux_43_nl, mux_42_nl, fsm_output(1));
  or_53_nl <= (fsm_output(2)) OR (NOT (COMP_LOOP_acc_1_cse_sva(0))) OR (fsm_output(5));
  or_52_nl <= (NOT (fsm_output(2))) OR (NOT (COMP_LOOP_2_slc_31_1_idiv_sva(0))) OR
      (fsm_output(5));
  mux_46_nl <= MUX_s_1_2_2(or_53_nl, or_52_nl, fsm_output(3));
  nor_33_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(4)) OR mux_46_nl);
  or_49_nl <= (fsm_output(3)) OR (NOT((fsm_output(2)) AND (COMP_LOOP_1_slc_31_1_idiv_sva(0))
      AND (fsm_output(5))));
  or_48_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("10")) OR (NOT
      (VEC_LOOP_j_sva_9_0(0))) OR (fsm_output(5));
  mux_45_nl <= MUX_s_1_2_2(or_49_nl, or_48_nl, fsm_output(4));
  nor_34_nl <= NOT((fsm_output(6)) OR mux_45_nl);
  mux_47_nl <= MUX_s_1_2_2(nor_33_nl, nor_34_nl, fsm_output(0));
  mux_48_nl <= MUX_s_1_2_2((NOT (fsm_output(2))), (fsm_output(2)), fsm_output(1));
  or_114_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01"));
  mux_49_nl <= MUX_s_1_2_2(mux_48_nl, or_114_nl, z_out_4(0));
  COMP_LOOP_or_2_nl <= and_dcpl_26 OR and_dcpl_67;
  mux_50_nl <= MUX_s_1_2_2((NOT (fsm_output(3))), (fsm_output(3)), fsm_output(2));
  mux_51_nl <= MUX_s_1_2_2(and_dcpl_8, mux_50_nl, and_98_cse);
  and_59_nl <= (NOT mux_51_nl) AND and_dcpl_9 AND (NOT (fsm_output(6)));
  nor_31_nl <= NOT((fsm_output(3)) OR (NOT nor_tmp_3));
  nor_32_nl <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 3)/=STD_LOGIC_VECTOR'("001")));
  mux_52_nl <= MUX_s_1_2_2(nor_31_nl, nor_32_nl, fsm_output(0));
  and_62_nl <= mux_52_nl AND (fsm_output(2)) AND (fsm_output(1)) AND (NOT (fsm_output(6)));
  and_65_nl <= (NOT((NOT(or_dcpl_4 AND (NOT (fsm_output(2))))) AND (fsm_output(3))))
      AND and_dcpl_14 AND (NOT (fsm_output(6)));
  or_64_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 3)/=STD_LOGIC_VECTOR'("100"));
  mux_55_nl <= MUX_s_1_2_2(or_64_nl, mux_tmp_53, fsm_output(2));
  or_61_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 3)/=STD_LOGIC_VECTOR'("011"));
  mux_54_nl <= MUX_s_1_2_2(mux_tmp_53, or_61_nl, fsm_output(2));
  mux_56_nl <= MUX_s_1_2_2(mux_55_nl, mux_54_nl, and_98_cse);
  nor_55_nl <= NOT(mux_56_nl OR (fsm_output(6)));
  mux_61_nl <= MUX_s_1_2_2(or_tmp_60, mux_tmp_57, fsm_output(2));
  mux_59_nl <= MUX_s_1_2_2(or_tmp_60, or_tmp_59, fsm_output(2));
  mux_58_nl <= MUX_s_1_2_2(mux_tmp_57, or_tmp_59, fsm_output(2));
  mux_60_nl <= MUX_s_1_2_2(mux_59_nl, mux_58_nl, fsm_output(0));
  mux_62_nl <= MUX_s_1_2_2(mux_61_nl, mux_60_nl, fsm_output(1));
  and_69_nl <= (NOT mux_62_nl) AND CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("01"));
  nand_nl <= NOT(((CONV_SL_1_1(fsm_output(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111")))
      OR (fsm_output(3))) AND CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("11")));
  mux_63_nl <= MUX_s_1_2_2(nand_nl, or_tmp, fsm_output(6));
  mux_64_nl <= MUX_s_1_2_2(and_dcpl_8, and_dcpl_40, fsm_output(1));
  and_71_nl <= (NOT mux_64_nl) AND and_dcpl_9 AND (fsm_output(6));
  VEC_LOOP_j_not_1_nl <= NOT VEC_LOOP_j_sva_9_0_mx0c0;
  or_72_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 0)/=STD_LOGIC_VECTOR'("0000"));
  mux_66_nl <= MUX_s_1_2_2((fsm_output(5)), or_116_cse, or_72_nl);
  mux_67_nl <= MUX_s_1_2_2((NOT or_tmp), mux_66_nl, fsm_output(6));
  or_111_nl <= (NOT (fsm_output(0))) OR (fsm_output(4));
  or_112_nl <= (fsm_output(0)) OR (NOT (fsm_output(4)));
  mux_28_nl <= MUX_s_1_2_2(or_111_nl, or_112_nl, fsm_output(6));
  or_115_nl <= mux_28_nl OR (fsm_output(5)) OR (NOT and_dcpl_8) OR (fsm_output(1));
  nand_7_nl <= NOT((((fsm_output(0)) AND (fsm_output(3))) OR (fsm_output(4))) AND
      (fsm_output(5)));
  mux_nl <= MUX_s_1_2_2((fsm_output(5)), (NOT (fsm_output(5))), or_118_cse);
  mux_92_nl <= MUX_s_1_2_2(nand_7_nl, mux_nl, fsm_output(1));
  nand_8_nl <= NOT(or_118_cse AND (fsm_output(5)));
  mux_93_nl <= MUX_s_1_2_2(mux_92_nl, nand_8_nl, fsm_output(2));
  mux_94_nl <= MUX_s_1_2_2(mux_93_nl, or_116_cse, fsm_output(6));
  COMP_LOOP_1_acc_11_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_9_0),
      10), 11) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0 & '0'),
      9), 11) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva),
      10), 11), 11));
  COMP_LOOP_2_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT (STAGE_LOOP_lshift_psp_sva(9
      DOWNTO 1)))) + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0 &
      '1'), 9), 10) + SIGNED'( "0000000001"), 10));
  mux_75_nl <= MUX_s_1_2_2(not_tmp_58, or_tmp, fsm_output(6));
  mux_78_nl <= MUX_s_1_2_2(mux_tmp_77, mux_tmp_68, fsm_output(2));
  mux_70_nl <= MUX_s_1_2_2(mux_tmp_69, (fsm_output(5)), fsm_output(3));
  or_109_nl <= (fsm_output(0)) OR (fsm_output(2));
  mux_76_nl <= MUX_s_1_2_2(mux_70_nl, mux_tmp_68, or_109_nl);
  mux_79_nl <= MUX_s_1_2_2(mux_78_nl, mux_76_nl, fsm_output(1));
  COMP_LOOP_2_acc_11_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_9_0),
      10), 11) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0 & '1'),
      9), 11) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva),
      10), 11), 11));
  or_9_nl <= (CONV_SL_1_1(fsm_output(3 DOWNTO 1)=STD_LOGIC_VECTOR'("111"))) OR CONV_SL_1_1(fsm_output(5
      DOWNTO 4)/=STD_LOGIC_VECTOR'("00"));
  mux_80_nl <= MUX_s_1_2_2(not_tmp_58, or_9_nl, fsm_output(6));
  COMP_LOOP_1_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(z_out_2 & '0') + SIGNED('1'
      & (NOT (STAGE_LOOP_lshift_psp_sva(9 DOWNTO 1)))) + SIGNED'( "0000000001"),
      10));
  or_10_nl <= (CONV_SL_1_1(fsm_output(3 DOWNTO 0)=STD_LOGIC_VECTOR'("1111"))) OR
      CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00"));
  mux_81_nl <= MUX_s_1_2_2(not_tmp_58, or_10_nl, fsm_output(6));
  nor_28_nl <= NOT((VEC_LOOP_j_sva_9_0(0)) OR (NOT (fsm_output(2))) OR (fsm_output(3))
      OR (fsm_output(5)));
  nor_29_nl <= NOT((COMP_LOOP_acc_1_cse_sva(0)) OR (fsm_output(2)) OR not_tmp_34);
  mux_82_nl <= MUX_s_1_2_2(nor_28_nl, nor_29_nl, fsm_output(0));
  and_85_nl <= and_dcpl_50 AND and_dcpl_12 AND (NOT (fsm_output(6))) AND (NOT (COMP_LOOP_2_tmp_lshift_itm(0)));
  and_88_nl <= and_dcpl_50 AND and_dcpl_12 AND (NOT (fsm_output(6))) AND (COMP_LOOP_2_tmp_lshift_itm(0));
  mux_89_nl <= MUX_s_1_2_2(and_dcpl_9, nor_tmp_3, fsm_output(3));
  and_90_nl <= (fsm_output(0)) AND (fsm_output(2));
  mux_90_nl <= MUX_s_1_2_2(mux_89_nl, mux_tmp_77, and_90_nl);
  mux_86_nl <= MUX_s_1_2_2(and_dcpl_9, (fsm_output(5)), fsm_output(3));
  mux_87_nl <= MUX_s_1_2_2(mux_86_nl, nor_tmp_3, fsm_output(2));
  or_11_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00"));
  mux_85_nl <= MUX_s_1_2_2(and_dcpl_9, nor_tmp_3, or_11_nl);
  mux_88_nl <= MUX_s_1_2_2(mux_87_nl, mux_85_nl, fsm_output(0));
  mux_91_nl <= MUX_s_1_2_2(mux_90_nl, mux_88_nl, fsm_output(1));
  STAGE_LOOP_mux_3_nl <= MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (NOT STAGE_LOOP_i_3_0_sva),
      and_dcpl_111);
  z_out_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_mux_3_nl) + UNSIGNED'(
      and_dcpl_111 & '0' & and_dcpl_111 & '1'), 4));
  COMP_LOOP_mux_40_nl <= MUX_v_8_2_2(COMP_LOOP_k_9_1_sva_7_0, (STD_LOGIC_VECTOR'(
      "00000") & (z_out_1(3 DOWNTO 1))), and_dcpl_122);
  z_out_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux_40_nl),
      9) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED'( and_dcpl_122 & '1'), 2), 9), 9));
  COMP_LOOP_mux_41_nl <= MUX_v_10_2_2(('0' & (VEC_LOOP_j_sva_9_0(9 DOWNTO 1))), VEC_LOOP_j_sva_9_0,
      and_dcpl_133);
  COMP_LOOP_mux_42_nl <= MUX_v_10_2_2((STD_LOGIC_VECTOR'( "00") & COMP_LOOP_k_9_1_sva_7_0),
      STAGE_LOOP_lshift_psp_sva, and_dcpl_133);
  z_out_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux_41_nl),
      11) + CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux_42_nl), 11), 11));
  COMP_LOOP_tmp_mux1h_4_nl <= MUX1HOT_v_64_4_2((STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000")
      & (z_out(8 DOWNTO 0))), twiddle_rsc_0_0_i_s_din_mxwt, COMP_LOOP_2_mul_psp,
      (STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000")
      & COMP_LOOP_2_tmp_lshift_itm), STD_LOGIC_VECTOR'( and_dcpl_139 & and_dcpl_142
      & and_dcpl_146 & and_dcpl_151));
  COMP_LOOP_tmp_or_2_nl <= ((NOT (COMP_LOOP_2_tmp_lshift_itm(0))) AND and_dcpl_142)
      OR ((NOT (COMP_LOOP_2_acc_10_idiv_sva(0))) AND and_dcpl_146);
  COMP_LOOP_tmp_or_3_nl <= ((COMP_LOOP_2_tmp_lshift_itm(0)) AND and_dcpl_142) OR
      ((COMP_LOOP_2_acc_10_idiv_sva(0)) AND and_dcpl_146);
  COMP_LOOP_tmp_mux1h_5_nl <= MUX1HOT_v_64_4_2((STD_LOGIC_VECTOR'( "00000000000000000000000000000000000000000000000000000000")
      & COMP_LOOP_k_9_1_sva_7_0), vec_rsc_0_0_i_s_din_mxwt, vec_rsc_0_1_i_s_din_mxwt,
      (STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000")
      & COMP_LOOP_k_9_1_sva_7_0 & '1'), STD_LOGIC_VECTOR'( and_dcpl_139 & COMP_LOOP_tmp_or_2_nl
      & COMP_LOOP_tmp_or_3_nl & and_dcpl_151));
  z_out_4 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(COMP_LOOP_tmp_mux1h_4_nl)
      * UNSIGNED(COMP_LOOP_tmp_mux1h_5_nl)), 64));
END v5;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_precomp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.amba_comps.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_precomp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_0_s_tdone : IN STD_LOGIC;
    vec_rsc_0_0_tr_write_done : IN STD_LOGIC;
    vec_rsc_0_0_RREADY : IN STD_LOGIC;
    vec_rsc_0_0_RVALID : OUT STD_LOGIC;
    vec_rsc_0_0_RUSER : OUT STD_LOGIC;
    vec_rsc_0_0_RLAST : OUT STD_LOGIC;
    vec_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_RID : OUT STD_LOGIC;
    vec_rsc_0_0_ARREADY : OUT STD_LOGIC;
    vec_rsc_0_0_ARVALID : IN STD_LOGIC;
    vec_rsc_0_0_ARUSER : IN STD_LOGIC;
    vec_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_ARLOCK : IN STD_LOGIC;
    vec_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_0_ARID : IN STD_LOGIC;
    vec_rsc_0_0_BREADY : IN STD_LOGIC;
    vec_rsc_0_0_BVALID : OUT STD_LOGIC;
    vec_rsc_0_0_BUSER : OUT STD_LOGIC;
    vec_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_BID : OUT STD_LOGIC;
    vec_rsc_0_0_WREADY : OUT STD_LOGIC;
    vec_rsc_0_0_WVALID : IN STD_LOGIC;
    vec_rsc_0_0_WUSER : IN STD_LOGIC;
    vec_rsc_0_0_WLAST : IN STD_LOGIC;
    vec_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_AWREADY : OUT STD_LOGIC;
    vec_rsc_0_0_AWVALID : IN STD_LOGIC;
    vec_rsc_0_0_AWUSER : IN STD_LOGIC;
    vec_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_0_AWLOCK : IN STD_LOGIC;
    vec_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_0_AWID : IN STD_LOGIC;
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    vec_rsc_0_1_s_tdone : IN STD_LOGIC;
    vec_rsc_0_1_tr_write_done : IN STD_LOGIC;
    vec_rsc_0_1_RREADY : IN STD_LOGIC;
    vec_rsc_0_1_RVALID : OUT STD_LOGIC;
    vec_rsc_0_1_RUSER : OUT STD_LOGIC;
    vec_rsc_0_1_RLAST : OUT STD_LOGIC;
    vec_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_RID : OUT STD_LOGIC;
    vec_rsc_0_1_ARREADY : OUT STD_LOGIC;
    vec_rsc_0_1_ARVALID : IN STD_LOGIC;
    vec_rsc_0_1_ARUSER : IN STD_LOGIC;
    vec_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_ARLOCK : IN STD_LOGIC;
    vec_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_1_ARID : IN STD_LOGIC;
    vec_rsc_0_1_BREADY : IN STD_LOGIC;
    vec_rsc_0_1_BVALID : OUT STD_LOGIC;
    vec_rsc_0_1_BUSER : OUT STD_LOGIC;
    vec_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_BID : OUT STD_LOGIC;
    vec_rsc_0_1_WREADY : OUT STD_LOGIC;
    vec_rsc_0_1_WVALID : IN STD_LOGIC;
    vec_rsc_0_1_WUSER : IN STD_LOGIC;
    vec_rsc_0_1_WLAST : IN STD_LOGIC;
    vec_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_AWREADY : OUT STD_LOGIC;
    vec_rsc_0_1_AWVALID : IN STD_LOGIC;
    vec_rsc_0_1_AWUSER : IN STD_LOGIC;
    vec_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    vec_rsc_0_1_AWLOCK : IN STD_LOGIC;
    vec_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    vec_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    vec_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    vec_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    vec_rsc_0_1_AWID : IN STD_LOGIC;
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC;
    twiddle_rsc_0_0_s_tdone : IN STD_LOGIC;
    twiddle_rsc_0_0_tr_write_done : IN STD_LOGIC;
    twiddle_rsc_0_0_RREADY : IN STD_LOGIC;
    twiddle_rsc_0_0_RVALID : OUT STD_LOGIC;
    twiddle_rsc_0_0_RUSER : OUT STD_LOGIC;
    twiddle_rsc_0_0_RLAST : OUT STD_LOGIC;
    twiddle_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_RID : OUT STD_LOGIC;
    twiddle_rsc_0_0_ARREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_ARVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_ARUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_ARLOCK : IN STD_LOGIC;
    twiddle_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_0_ARID : IN STD_LOGIC;
    twiddle_rsc_0_0_BREADY : IN STD_LOGIC;
    twiddle_rsc_0_0_BVALID : OUT STD_LOGIC;
    twiddle_rsc_0_0_BUSER : OUT STD_LOGIC;
    twiddle_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_BID : OUT STD_LOGIC;
    twiddle_rsc_0_0_WREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_WVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_WUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_WLAST : IN STD_LOGIC;
    twiddle_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_AWREADY : OUT STD_LOGIC;
    twiddle_rsc_0_0_AWVALID : IN STD_LOGIC;
    twiddle_rsc_0_0_AWUSER : IN STD_LOGIC;
    twiddle_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_0_AWLOCK : IN STD_LOGIC;
    twiddle_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_0_AWID : IN STD_LOGIC;
    twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    twiddle_rsc_0_1_s_tdone : IN STD_LOGIC;
    twiddle_rsc_0_1_tr_write_done : IN STD_LOGIC;
    twiddle_rsc_0_1_RREADY : IN STD_LOGIC;
    twiddle_rsc_0_1_RVALID : OUT STD_LOGIC;
    twiddle_rsc_0_1_RUSER : OUT STD_LOGIC;
    twiddle_rsc_0_1_RLAST : OUT STD_LOGIC;
    twiddle_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_RID : OUT STD_LOGIC;
    twiddle_rsc_0_1_ARREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_ARVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_ARUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_ARLOCK : IN STD_LOGIC;
    twiddle_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_1_ARID : IN STD_LOGIC;
    twiddle_rsc_0_1_BREADY : IN STD_LOGIC;
    twiddle_rsc_0_1_BVALID : OUT STD_LOGIC;
    twiddle_rsc_0_1_BUSER : OUT STD_LOGIC;
    twiddle_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_BID : OUT STD_LOGIC;
    twiddle_rsc_0_1_WREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_WVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_WUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_WLAST : IN STD_LOGIC;
    twiddle_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_AWREADY : OUT STD_LOGIC;
    twiddle_rsc_0_1_AWVALID : IN STD_LOGIC;
    twiddle_rsc_0_1_AWUSER : IN STD_LOGIC;
    twiddle_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    twiddle_rsc_0_1_AWLOCK : IN STD_LOGIC;
    twiddle_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    twiddle_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    twiddle_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    twiddle_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    twiddle_rsc_0_1_AWID : IN STD_LOGIC;
    twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_precomp;

ARCHITECTURE v5 OF inPlaceNTT_DIT_precomp IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';
  CONSTANT GND : STD_LOGIC := '0';

  COMPONENT inPlaceNTT_DIT_precomp_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_0_0_s_tdone : IN STD_LOGIC;
      vec_rsc_0_0_tr_write_done : IN STD_LOGIC;
      vec_rsc_0_0_RREADY : IN STD_LOGIC;
      vec_rsc_0_0_RVALID : OUT STD_LOGIC;
      vec_rsc_0_0_RUSER : OUT STD_LOGIC;
      vec_rsc_0_0_RLAST : OUT STD_LOGIC;
      vec_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_RID : OUT STD_LOGIC;
      vec_rsc_0_0_ARREADY : OUT STD_LOGIC;
      vec_rsc_0_0_ARVALID : IN STD_LOGIC;
      vec_rsc_0_0_ARUSER : IN STD_LOGIC;
      vec_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_ARLOCK : IN STD_LOGIC;
      vec_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_0_ARID : IN STD_LOGIC;
      vec_rsc_0_0_BREADY : IN STD_LOGIC;
      vec_rsc_0_0_BVALID : OUT STD_LOGIC;
      vec_rsc_0_0_BUSER : OUT STD_LOGIC;
      vec_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_BID : OUT STD_LOGIC;
      vec_rsc_0_0_WREADY : OUT STD_LOGIC;
      vec_rsc_0_0_WVALID : IN STD_LOGIC;
      vec_rsc_0_0_WUSER : IN STD_LOGIC;
      vec_rsc_0_0_WLAST : IN STD_LOGIC;
      vec_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_AWREADY : OUT STD_LOGIC;
      vec_rsc_0_0_AWVALID : IN STD_LOGIC;
      vec_rsc_0_0_AWUSER : IN STD_LOGIC;
      vec_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_0_AWLOCK : IN STD_LOGIC;
      vec_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_0_AWID : IN STD_LOGIC;
      vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      vec_rsc_0_1_s_tdone : IN STD_LOGIC;
      vec_rsc_0_1_tr_write_done : IN STD_LOGIC;
      vec_rsc_0_1_RREADY : IN STD_LOGIC;
      vec_rsc_0_1_RVALID : OUT STD_LOGIC;
      vec_rsc_0_1_RUSER : OUT STD_LOGIC;
      vec_rsc_0_1_RLAST : OUT STD_LOGIC;
      vec_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_RID : OUT STD_LOGIC;
      vec_rsc_0_1_ARREADY : OUT STD_LOGIC;
      vec_rsc_0_1_ARVALID : IN STD_LOGIC;
      vec_rsc_0_1_ARUSER : IN STD_LOGIC;
      vec_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_ARLOCK : IN STD_LOGIC;
      vec_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_1_ARID : IN STD_LOGIC;
      vec_rsc_0_1_BREADY : IN STD_LOGIC;
      vec_rsc_0_1_BVALID : OUT STD_LOGIC;
      vec_rsc_0_1_BUSER : OUT STD_LOGIC;
      vec_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_BID : OUT STD_LOGIC;
      vec_rsc_0_1_WREADY : OUT STD_LOGIC;
      vec_rsc_0_1_WVALID : IN STD_LOGIC;
      vec_rsc_0_1_WUSER : IN STD_LOGIC;
      vec_rsc_0_1_WLAST : IN STD_LOGIC;
      vec_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_AWREADY : OUT STD_LOGIC;
      vec_rsc_0_1_AWVALID : IN STD_LOGIC;
      vec_rsc_0_1_AWUSER : IN STD_LOGIC;
      vec_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      vec_rsc_0_1_AWLOCK : IN STD_LOGIC;
      vec_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      vec_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      vec_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      vec_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      vec_rsc_0_1_AWID : IN STD_LOGIC;
      vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
      p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      p_rsc_triosy_lz : OUT STD_LOGIC;
      r_rsc_triosy_lz : OUT STD_LOGIC;
      twiddle_rsc_0_0_s_tdone : IN STD_LOGIC;
      twiddle_rsc_0_0_tr_write_done : IN STD_LOGIC;
      twiddle_rsc_0_0_RREADY : IN STD_LOGIC;
      twiddle_rsc_0_0_RVALID : OUT STD_LOGIC;
      twiddle_rsc_0_0_RUSER : OUT STD_LOGIC;
      twiddle_rsc_0_0_RLAST : OUT STD_LOGIC;
      twiddle_rsc_0_0_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_0_RID : OUT STD_LOGIC;
      twiddle_rsc_0_0_ARREADY : OUT STD_LOGIC;
      twiddle_rsc_0_0_ARVALID : IN STD_LOGIC;
      twiddle_rsc_0_0_ARUSER : IN STD_LOGIC;
      twiddle_rsc_0_0_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_ARLOCK : IN STD_LOGIC;
      twiddle_rsc_0_0_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_0_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_0_ARID : IN STD_LOGIC;
      twiddle_rsc_0_0_BREADY : IN STD_LOGIC;
      twiddle_rsc_0_0_BVALID : OUT STD_LOGIC;
      twiddle_rsc_0_0_BUSER : OUT STD_LOGIC;
      twiddle_rsc_0_0_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_BID : OUT STD_LOGIC;
      twiddle_rsc_0_0_WREADY : OUT STD_LOGIC;
      twiddle_rsc_0_0_WVALID : IN STD_LOGIC;
      twiddle_rsc_0_0_WUSER : IN STD_LOGIC;
      twiddle_rsc_0_0_WLAST : IN STD_LOGIC;
      twiddle_rsc_0_0_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_0_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_0_AWREADY : OUT STD_LOGIC;
      twiddle_rsc_0_0_AWVALID : IN STD_LOGIC;
      twiddle_rsc_0_0_AWUSER : IN STD_LOGIC;
      twiddle_rsc_0_0_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_0_AWLOCK : IN STD_LOGIC;
      twiddle_rsc_0_0_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_0_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_0_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_0_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_0_AWID : IN STD_LOGIC;
      twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      twiddle_rsc_0_1_s_tdone : IN STD_LOGIC;
      twiddle_rsc_0_1_tr_write_done : IN STD_LOGIC;
      twiddle_rsc_0_1_RREADY : IN STD_LOGIC;
      twiddle_rsc_0_1_RVALID : OUT STD_LOGIC;
      twiddle_rsc_0_1_RUSER : OUT STD_LOGIC;
      twiddle_rsc_0_1_RLAST : OUT STD_LOGIC;
      twiddle_rsc_0_1_RRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_RDATA : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_1_RID : OUT STD_LOGIC;
      twiddle_rsc_0_1_ARREADY : OUT STD_LOGIC;
      twiddle_rsc_0_1_ARVALID : IN STD_LOGIC;
      twiddle_rsc_0_1_ARUSER : IN STD_LOGIC;
      twiddle_rsc_0_1_ARREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_ARQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_ARPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_ARCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_ARLOCK : IN STD_LOGIC;
      twiddle_rsc_0_1_ARBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_ARSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_ARLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_1_ARADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_1_ARID : IN STD_LOGIC;
      twiddle_rsc_0_1_BREADY : IN STD_LOGIC;
      twiddle_rsc_0_1_BVALID : OUT STD_LOGIC;
      twiddle_rsc_0_1_BUSER : OUT STD_LOGIC;
      twiddle_rsc_0_1_BRESP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_BID : OUT STD_LOGIC;
      twiddle_rsc_0_1_WREADY : OUT STD_LOGIC;
      twiddle_rsc_0_1_WVALID : IN STD_LOGIC;
      twiddle_rsc_0_1_WUSER : IN STD_LOGIC;
      twiddle_rsc_0_1_WLAST : IN STD_LOGIC;
      twiddle_rsc_0_1_WSTRB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_1_WDATA : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_1_AWREADY : OUT STD_LOGIC;
      twiddle_rsc_0_1_AWVALID : IN STD_LOGIC;
      twiddle_rsc_0_1_AWUSER : IN STD_LOGIC;
      twiddle_rsc_0_1_AWREGION : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_AWQOS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_AWPROT : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_AWCACHE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      twiddle_rsc_0_1_AWLOCK : IN STD_LOGIC;
      twiddle_rsc_0_1_AWBURST : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      twiddle_rsc_0_1_AWSIZE : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      twiddle_rsc_0_1_AWLEN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      twiddle_rsc_0_1_AWADDR : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      twiddle_rsc_0_1_AWID : IN STD_LOGIC;
      twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_RRESP : STD_LOGIC_VECTOR (1
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_RDATA : STD_LOGIC_VECTOR (63
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARQOS : STD_LOGIC_VECTOR (3
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARPROT : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARSIZE : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARLEN : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARADDR : STD_LOGIC_VECTOR (11
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_BRESP : STD_LOGIC_VECTOR (1
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_WSTRB : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_WDATA : STD_LOGIC_VECTOR (63
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWQOS : STD_LOGIC_VECTOR (3
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWPROT : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWSIZE : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWLEN : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWADDR : STD_LOGIC_VECTOR (11
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_RRESP : STD_LOGIC_VECTOR (1
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_RDATA : STD_LOGIC_VECTOR (63
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARQOS : STD_LOGIC_VECTOR (3
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARPROT : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARSIZE : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARLEN : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARADDR : STD_LOGIC_VECTOR (11
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_BRESP : STD_LOGIC_VECTOR (1
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_WSTRB : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_WDATA : STD_LOGIC_VECTOR (63
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWQOS : STD_LOGIC_VECTOR (3
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWPROT : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWSIZE : STD_LOGIC_VECTOR (2
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWLEN : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWADDR : STD_LOGIC_VECTOR (11
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_p_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_RRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_RDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_BRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_WSTRB : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_WDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_RRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_RDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_BRESP : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_WSTRB : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_WDATA : STD_LOGIC_VECTOR
      (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWREGION : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWQOS : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWPROT : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWCACHE : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWBURST : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWSIZE : STD_LOGIC_VECTOR
      (2 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWLEN : STD_LOGIC_VECTOR
      (7 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWADDR : STD_LOGIC_VECTOR
      (11 DOWNTO 0);

BEGIN
  inPlaceNTT_DIT_precomp_core_inst : inPlaceNTT_DIT_precomp_core
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_0_0_s_tdone => vec_rsc_0_0_s_tdone,
      vec_rsc_0_0_tr_write_done => vec_rsc_0_0_tr_write_done,
      vec_rsc_0_0_RREADY => vec_rsc_0_0_RREADY,
      vec_rsc_0_0_RVALID => vec_rsc_0_0_RVALID,
      vec_rsc_0_0_RUSER => vec_rsc_0_0_RUSER,
      vec_rsc_0_0_RLAST => vec_rsc_0_0_RLAST,
      vec_rsc_0_0_RRESP => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_RRESP,
      vec_rsc_0_0_RDATA => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_RDATA,
      vec_rsc_0_0_RID => vec_rsc_0_0_RID,
      vec_rsc_0_0_ARREADY => vec_rsc_0_0_ARREADY,
      vec_rsc_0_0_ARVALID => vec_rsc_0_0_ARVALID,
      vec_rsc_0_0_ARUSER => vec_rsc_0_0_ARUSER,
      vec_rsc_0_0_ARREGION => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARREGION,
      vec_rsc_0_0_ARQOS => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARQOS,
      vec_rsc_0_0_ARPROT => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARPROT,
      vec_rsc_0_0_ARCACHE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARCACHE,
      vec_rsc_0_0_ARLOCK => vec_rsc_0_0_ARLOCK,
      vec_rsc_0_0_ARBURST => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARBURST,
      vec_rsc_0_0_ARSIZE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARSIZE,
      vec_rsc_0_0_ARLEN => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARLEN,
      vec_rsc_0_0_ARADDR => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARADDR,
      vec_rsc_0_0_ARID => vec_rsc_0_0_ARID,
      vec_rsc_0_0_BREADY => vec_rsc_0_0_BREADY,
      vec_rsc_0_0_BVALID => vec_rsc_0_0_BVALID,
      vec_rsc_0_0_BUSER => vec_rsc_0_0_BUSER,
      vec_rsc_0_0_BRESP => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_BRESP,
      vec_rsc_0_0_BID => vec_rsc_0_0_BID,
      vec_rsc_0_0_WREADY => vec_rsc_0_0_WREADY,
      vec_rsc_0_0_WVALID => vec_rsc_0_0_WVALID,
      vec_rsc_0_0_WUSER => vec_rsc_0_0_WUSER,
      vec_rsc_0_0_WLAST => vec_rsc_0_0_WLAST,
      vec_rsc_0_0_WSTRB => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_WSTRB,
      vec_rsc_0_0_WDATA => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_WDATA,
      vec_rsc_0_0_AWREADY => vec_rsc_0_0_AWREADY,
      vec_rsc_0_0_AWVALID => vec_rsc_0_0_AWVALID,
      vec_rsc_0_0_AWUSER => vec_rsc_0_0_AWUSER,
      vec_rsc_0_0_AWREGION => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWREGION,
      vec_rsc_0_0_AWQOS => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWQOS,
      vec_rsc_0_0_AWPROT => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWPROT,
      vec_rsc_0_0_AWCACHE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWCACHE,
      vec_rsc_0_0_AWLOCK => vec_rsc_0_0_AWLOCK,
      vec_rsc_0_0_AWBURST => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWBURST,
      vec_rsc_0_0_AWSIZE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWSIZE,
      vec_rsc_0_0_AWLEN => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWLEN,
      vec_rsc_0_0_AWADDR => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWADDR,
      vec_rsc_0_0_AWID => vec_rsc_0_0_AWID,
      vec_rsc_triosy_0_0_lz => vec_rsc_triosy_0_0_lz,
      vec_rsc_0_1_s_tdone => vec_rsc_0_1_s_tdone,
      vec_rsc_0_1_tr_write_done => vec_rsc_0_1_tr_write_done,
      vec_rsc_0_1_RREADY => vec_rsc_0_1_RREADY,
      vec_rsc_0_1_RVALID => vec_rsc_0_1_RVALID,
      vec_rsc_0_1_RUSER => vec_rsc_0_1_RUSER,
      vec_rsc_0_1_RLAST => vec_rsc_0_1_RLAST,
      vec_rsc_0_1_RRESP => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_RRESP,
      vec_rsc_0_1_RDATA => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_RDATA,
      vec_rsc_0_1_RID => vec_rsc_0_1_RID,
      vec_rsc_0_1_ARREADY => vec_rsc_0_1_ARREADY,
      vec_rsc_0_1_ARVALID => vec_rsc_0_1_ARVALID,
      vec_rsc_0_1_ARUSER => vec_rsc_0_1_ARUSER,
      vec_rsc_0_1_ARREGION => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARREGION,
      vec_rsc_0_1_ARQOS => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARQOS,
      vec_rsc_0_1_ARPROT => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARPROT,
      vec_rsc_0_1_ARCACHE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARCACHE,
      vec_rsc_0_1_ARLOCK => vec_rsc_0_1_ARLOCK,
      vec_rsc_0_1_ARBURST => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARBURST,
      vec_rsc_0_1_ARSIZE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARSIZE,
      vec_rsc_0_1_ARLEN => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARLEN,
      vec_rsc_0_1_ARADDR => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARADDR,
      vec_rsc_0_1_ARID => vec_rsc_0_1_ARID,
      vec_rsc_0_1_BREADY => vec_rsc_0_1_BREADY,
      vec_rsc_0_1_BVALID => vec_rsc_0_1_BVALID,
      vec_rsc_0_1_BUSER => vec_rsc_0_1_BUSER,
      vec_rsc_0_1_BRESP => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_BRESP,
      vec_rsc_0_1_BID => vec_rsc_0_1_BID,
      vec_rsc_0_1_WREADY => vec_rsc_0_1_WREADY,
      vec_rsc_0_1_WVALID => vec_rsc_0_1_WVALID,
      vec_rsc_0_1_WUSER => vec_rsc_0_1_WUSER,
      vec_rsc_0_1_WLAST => vec_rsc_0_1_WLAST,
      vec_rsc_0_1_WSTRB => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_WSTRB,
      vec_rsc_0_1_WDATA => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_WDATA,
      vec_rsc_0_1_AWREADY => vec_rsc_0_1_AWREADY,
      vec_rsc_0_1_AWVALID => vec_rsc_0_1_AWVALID,
      vec_rsc_0_1_AWUSER => vec_rsc_0_1_AWUSER,
      vec_rsc_0_1_AWREGION => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWREGION,
      vec_rsc_0_1_AWQOS => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWQOS,
      vec_rsc_0_1_AWPROT => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWPROT,
      vec_rsc_0_1_AWCACHE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWCACHE,
      vec_rsc_0_1_AWLOCK => vec_rsc_0_1_AWLOCK,
      vec_rsc_0_1_AWBURST => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWBURST,
      vec_rsc_0_1_AWSIZE => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWSIZE,
      vec_rsc_0_1_AWLEN => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWLEN,
      vec_rsc_0_1_AWADDR => inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWADDR,
      vec_rsc_0_1_AWID => vec_rsc_0_1_AWID,
      vec_rsc_triosy_0_1_lz => vec_rsc_triosy_0_1_lz,
      p_rsc_dat => inPlaceNTT_DIT_precomp_core_inst_p_rsc_dat,
      p_rsc_triosy_lz => p_rsc_triosy_lz,
      r_rsc_triosy_lz => r_rsc_triosy_lz,
      twiddle_rsc_0_0_s_tdone => twiddle_rsc_0_0_s_tdone,
      twiddle_rsc_0_0_tr_write_done => twiddle_rsc_0_0_tr_write_done,
      twiddle_rsc_0_0_RREADY => twiddle_rsc_0_0_RREADY,
      twiddle_rsc_0_0_RVALID => twiddle_rsc_0_0_RVALID,
      twiddle_rsc_0_0_RUSER => twiddle_rsc_0_0_RUSER,
      twiddle_rsc_0_0_RLAST => twiddle_rsc_0_0_RLAST,
      twiddle_rsc_0_0_RRESP => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_RRESP,
      twiddle_rsc_0_0_RDATA => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_RDATA,
      twiddle_rsc_0_0_RID => twiddle_rsc_0_0_RID,
      twiddle_rsc_0_0_ARREADY => twiddle_rsc_0_0_ARREADY,
      twiddle_rsc_0_0_ARVALID => twiddle_rsc_0_0_ARVALID,
      twiddle_rsc_0_0_ARUSER => twiddle_rsc_0_0_ARUSER,
      twiddle_rsc_0_0_ARREGION => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARREGION,
      twiddle_rsc_0_0_ARQOS => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARQOS,
      twiddle_rsc_0_0_ARPROT => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARPROT,
      twiddle_rsc_0_0_ARCACHE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARCACHE,
      twiddle_rsc_0_0_ARLOCK => twiddle_rsc_0_0_ARLOCK,
      twiddle_rsc_0_0_ARBURST => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARBURST,
      twiddle_rsc_0_0_ARSIZE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARSIZE,
      twiddle_rsc_0_0_ARLEN => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARLEN,
      twiddle_rsc_0_0_ARADDR => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARADDR,
      twiddle_rsc_0_0_ARID => twiddle_rsc_0_0_ARID,
      twiddle_rsc_0_0_BREADY => twiddle_rsc_0_0_BREADY,
      twiddle_rsc_0_0_BVALID => twiddle_rsc_0_0_BVALID,
      twiddle_rsc_0_0_BUSER => twiddle_rsc_0_0_BUSER,
      twiddle_rsc_0_0_BRESP => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_BRESP,
      twiddle_rsc_0_0_BID => twiddle_rsc_0_0_BID,
      twiddle_rsc_0_0_WREADY => twiddle_rsc_0_0_WREADY,
      twiddle_rsc_0_0_WVALID => twiddle_rsc_0_0_WVALID,
      twiddle_rsc_0_0_WUSER => twiddle_rsc_0_0_WUSER,
      twiddle_rsc_0_0_WLAST => twiddle_rsc_0_0_WLAST,
      twiddle_rsc_0_0_WSTRB => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_WSTRB,
      twiddle_rsc_0_0_WDATA => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_WDATA,
      twiddle_rsc_0_0_AWREADY => twiddle_rsc_0_0_AWREADY,
      twiddle_rsc_0_0_AWVALID => twiddle_rsc_0_0_AWVALID,
      twiddle_rsc_0_0_AWUSER => twiddle_rsc_0_0_AWUSER,
      twiddle_rsc_0_0_AWREGION => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWREGION,
      twiddle_rsc_0_0_AWQOS => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWQOS,
      twiddle_rsc_0_0_AWPROT => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWPROT,
      twiddle_rsc_0_0_AWCACHE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWCACHE,
      twiddle_rsc_0_0_AWLOCK => twiddle_rsc_0_0_AWLOCK,
      twiddle_rsc_0_0_AWBURST => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWBURST,
      twiddle_rsc_0_0_AWSIZE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWSIZE,
      twiddle_rsc_0_0_AWLEN => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWLEN,
      twiddle_rsc_0_0_AWADDR => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWADDR,
      twiddle_rsc_0_0_AWID => twiddle_rsc_0_0_AWID,
      twiddle_rsc_triosy_0_0_lz => twiddle_rsc_triosy_0_0_lz,
      twiddle_rsc_0_1_s_tdone => twiddle_rsc_0_1_s_tdone,
      twiddle_rsc_0_1_tr_write_done => twiddle_rsc_0_1_tr_write_done,
      twiddle_rsc_0_1_RREADY => twiddle_rsc_0_1_RREADY,
      twiddle_rsc_0_1_RVALID => twiddle_rsc_0_1_RVALID,
      twiddle_rsc_0_1_RUSER => twiddle_rsc_0_1_RUSER,
      twiddle_rsc_0_1_RLAST => twiddle_rsc_0_1_RLAST,
      twiddle_rsc_0_1_RRESP => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_RRESP,
      twiddle_rsc_0_1_RDATA => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_RDATA,
      twiddle_rsc_0_1_RID => twiddle_rsc_0_1_RID,
      twiddle_rsc_0_1_ARREADY => twiddle_rsc_0_1_ARREADY,
      twiddle_rsc_0_1_ARVALID => twiddle_rsc_0_1_ARVALID,
      twiddle_rsc_0_1_ARUSER => twiddle_rsc_0_1_ARUSER,
      twiddle_rsc_0_1_ARREGION => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARREGION,
      twiddle_rsc_0_1_ARQOS => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARQOS,
      twiddle_rsc_0_1_ARPROT => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARPROT,
      twiddle_rsc_0_1_ARCACHE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARCACHE,
      twiddle_rsc_0_1_ARLOCK => twiddle_rsc_0_1_ARLOCK,
      twiddle_rsc_0_1_ARBURST => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARBURST,
      twiddle_rsc_0_1_ARSIZE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARSIZE,
      twiddle_rsc_0_1_ARLEN => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARLEN,
      twiddle_rsc_0_1_ARADDR => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARADDR,
      twiddle_rsc_0_1_ARID => twiddle_rsc_0_1_ARID,
      twiddle_rsc_0_1_BREADY => twiddle_rsc_0_1_BREADY,
      twiddle_rsc_0_1_BVALID => twiddle_rsc_0_1_BVALID,
      twiddle_rsc_0_1_BUSER => twiddle_rsc_0_1_BUSER,
      twiddle_rsc_0_1_BRESP => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_BRESP,
      twiddle_rsc_0_1_BID => twiddle_rsc_0_1_BID,
      twiddle_rsc_0_1_WREADY => twiddle_rsc_0_1_WREADY,
      twiddle_rsc_0_1_WVALID => twiddle_rsc_0_1_WVALID,
      twiddle_rsc_0_1_WUSER => twiddle_rsc_0_1_WUSER,
      twiddle_rsc_0_1_WLAST => twiddle_rsc_0_1_WLAST,
      twiddle_rsc_0_1_WSTRB => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_WSTRB,
      twiddle_rsc_0_1_WDATA => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_WDATA,
      twiddle_rsc_0_1_AWREADY => twiddle_rsc_0_1_AWREADY,
      twiddle_rsc_0_1_AWVALID => twiddle_rsc_0_1_AWVALID,
      twiddle_rsc_0_1_AWUSER => twiddle_rsc_0_1_AWUSER,
      twiddle_rsc_0_1_AWREGION => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWREGION,
      twiddle_rsc_0_1_AWQOS => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWQOS,
      twiddle_rsc_0_1_AWPROT => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWPROT,
      twiddle_rsc_0_1_AWCACHE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWCACHE,
      twiddle_rsc_0_1_AWLOCK => twiddle_rsc_0_1_AWLOCK,
      twiddle_rsc_0_1_AWBURST => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWBURST,
      twiddle_rsc_0_1_AWSIZE => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWSIZE,
      twiddle_rsc_0_1_AWLEN => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWLEN,
      twiddle_rsc_0_1_AWADDR => inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWADDR,
      twiddle_rsc_0_1_AWID => twiddle_rsc_0_1_AWID,
      twiddle_rsc_triosy_0_1_lz => twiddle_rsc_triosy_0_1_lz
    );
  vec_rsc_0_0_RRESP <= inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_RRESP;
  vec_rsc_0_0_RDATA <= inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_RDATA;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARREGION <= vec_rsc_0_0_ARREGION;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARQOS <= vec_rsc_0_0_ARQOS;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARPROT <= vec_rsc_0_0_ARPROT;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARCACHE <= vec_rsc_0_0_ARCACHE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARBURST <= vec_rsc_0_0_ARBURST;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARSIZE <= vec_rsc_0_0_ARSIZE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARLEN <= vec_rsc_0_0_ARLEN;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_ARADDR <= vec_rsc_0_0_ARADDR;
  vec_rsc_0_0_BRESP <= inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_BRESP;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_WSTRB <= vec_rsc_0_0_WSTRB;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_WDATA <= vec_rsc_0_0_WDATA;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWREGION <= vec_rsc_0_0_AWREGION;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWQOS <= vec_rsc_0_0_AWQOS;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWPROT <= vec_rsc_0_0_AWPROT;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWCACHE <= vec_rsc_0_0_AWCACHE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWBURST <= vec_rsc_0_0_AWBURST;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWSIZE <= vec_rsc_0_0_AWSIZE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWLEN <= vec_rsc_0_0_AWLEN;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_0_AWADDR <= vec_rsc_0_0_AWADDR;
  vec_rsc_0_1_RRESP <= inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_RRESP;
  vec_rsc_0_1_RDATA <= inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_RDATA;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARREGION <= vec_rsc_0_1_ARREGION;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARQOS <= vec_rsc_0_1_ARQOS;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARPROT <= vec_rsc_0_1_ARPROT;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARCACHE <= vec_rsc_0_1_ARCACHE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARBURST <= vec_rsc_0_1_ARBURST;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARSIZE <= vec_rsc_0_1_ARSIZE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARLEN <= vec_rsc_0_1_ARLEN;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_ARADDR <= vec_rsc_0_1_ARADDR;
  vec_rsc_0_1_BRESP <= inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_BRESP;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_WSTRB <= vec_rsc_0_1_WSTRB;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_WDATA <= vec_rsc_0_1_WDATA;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWREGION <= vec_rsc_0_1_AWREGION;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWQOS <= vec_rsc_0_1_AWQOS;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWPROT <= vec_rsc_0_1_AWPROT;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWCACHE <= vec_rsc_0_1_AWCACHE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWBURST <= vec_rsc_0_1_AWBURST;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWSIZE <= vec_rsc_0_1_AWSIZE;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWLEN <= vec_rsc_0_1_AWLEN;
  inPlaceNTT_DIT_precomp_core_inst_vec_rsc_0_1_AWADDR <= vec_rsc_0_1_AWADDR;
  inPlaceNTT_DIT_precomp_core_inst_p_rsc_dat <= p_rsc_dat;
  twiddle_rsc_0_0_RRESP <= inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_RRESP;
  twiddle_rsc_0_0_RDATA <= inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_RDATA;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARREGION <= twiddle_rsc_0_0_ARREGION;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARQOS <= twiddle_rsc_0_0_ARQOS;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARPROT <= twiddle_rsc_0_0_ARPROT;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARCACHE <= twiddle_rsc_0_0_ARCACHE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARBURST <= twiddle_rsc_0_0_ARBURST;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARSIZE <= twiddle_rsc_0_0_ARSIZE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARLEN <= twiddle_rsc_0_0_ARLEN;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_ARADDR <= twiddle_rsc_0_0_ARADDR;
  twiddle_rsc_0_0_BRESP <= inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_BRESP;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_WSTRB <= twiddle_rsc_0_0_WSTRB;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_WDATA <= twiddle_rsc_0_0_WDATA;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWREGION <= twiddle_rsc_0_0_AWREGION;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWQOS <= twiddle_rsc_0_0_AWQOS;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWPROT <= twiddle_rsc_0_0_AWPROT;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWCACHE <= twiddle_rsc_0_0_AWCACHE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWBURST <= twiddle_rsc_0_0_AWBURST;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWSIZE <= twiddle_rsc_0_0_AWSIZE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWLEN <= twiddle_rsc_0_0_AWLEN;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_0_AWADDR <= twiddle_rsc_0_0_AWADDR;
  twiddle_rsc_0_1_RRESP <= inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_RRESP;
  twiddle_rsc_0_1_RDATA <= inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_RDATA;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARREGION <= twiddle_rsc_0_1_ARREGION;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARQOS <= twiddle_rsc_0_1_ARQOS;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARPROT <= twiddle_rsc_0_1_ARPROT;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARCACHE <= twiddle_rsc_0_1_ARCACHE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARBURST <= twiddle_rsc_0_1_ARBURST;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARSIZE <= twiddle_rsc_0_1_ARSIZE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARLEN <= twiddle_rsc_0_1_ARLEN;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_ARADDR <= twiddle_rsc_0_1_ARADDR;
  twiddle_rsc_0_1_BRESP <= inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_BRESP;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_WSTRB <= twiddle_rsc_0_1_WSTRB;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_WDATA <= twiddle_rsc_0_1_WDATA;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWREGION <= twiddle_rsc_0_1_AWREGION;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWQOS <= twiddle_rsc_0_1_AWQOS;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWPROT <= twiddle_rsc_0_1_AWPROT;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWCACHE <= twiddle_rsc_0_1_AWCACHE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWBURST <= twiddle_rsc_0_1_AWBURST;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWSIZE <= twiddle_rsc_0_1_AWSIZE;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWLEN <= twiddle_rsc_0_1_AWLEN;
  inPlaceNTT_DIT_precomp_core_inst_twiddle_rsc_0_1_AWADDR <= twiddle_rsc_0_1_AWADDR;

END v5;



