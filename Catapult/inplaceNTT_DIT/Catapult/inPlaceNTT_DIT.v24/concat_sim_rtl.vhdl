
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

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.vhd 

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_div IS
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
END mgc_div;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

USE work.funcs.all;

ARCHITECTURE beh OF mgc_div IS
BEGIN
  z <= std_logic_vector(unsigned(a) / unsigned(b)) WHEN signd = 0 ELSE
       std_logic_vector(  signed(a) /   signed(b));
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
--  Generated date: Wed May 19 22:44:00 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_10_64_1024_1024_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_10_64_1024_1024_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_10_64_1024_1024_64_1_gen;

ARCHITECTURE v24 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_10_64_1024_1024_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v24;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_10_64_1024_1024_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_10_64_1024_1024_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_10_64_1024_1024_64_1_gen;

ARCHITECTURE v24 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_10_64_1024_1024_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v24;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_10_64_1024_1024_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_10_64_1024_1024_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_10_64_1024_1024_64_1_gen;

ARCHITECTURE v24 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_10_64_1024_1024_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v24;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_10_64_1024_1024_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_10_64_1024_1024_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_10_64_1024_1024_64_1_gen;

ARCHITECTURE v24 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_10_64_1024_1024_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v24;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    STAGE_LOOP_C_5_tr0 : IN STD_LOGIC;
    modExp_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_C_40_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_C_80_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_C_120_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_1_COMP_LOOP_C_160_tr0 : IN STD_LOGIC;
    VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_C_40_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_C_80_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_C_120_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
    VEC_LOOP_2_COMP_LOOP_C_160_tr0 : IN STD_LOGIC;
    VEC_LOOP_C_1_tr0 : IN STD_LOGIC;
    STAGE_LOOP_C_6_tr0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_core_core_fsm;

ARCHITECTURE v24 OF inPlaceNTT_DIT_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for inPlaceNTT_DIT_core_core_fsm_1
  TYPE inPlaceNTT_DIT_core_core_fsm_1_ST IS (main_C_0, STAGE_LOOP_C_0, STAGE_LOOP_C_1,
      STAGE_LOOP_C_2, STAGE_LOOP_C_3, STAGE_LOOP_C_4, STAGE_LOOP_C_5, modExp_while_C_0,
      modExp_while_C_1, modExp_while_C_2, modExp_while_C_3, modExp_while_C_4, modExp_while_C_5,
      modExp_while_C_6, modExp_while_C_7, modExp_while_C_8, modExp_while_C_9, modExp_while_C_10,
      modExp_while_C_11, modExp_while_C_12, modExp_while_C_13, modExp_while_C_14,
      modExp_while_C_15, modExp_while_C_16, modExp_while_C_17, modExp_while_C_18,
      modExp_while_C_19, modExp_while_C_20, modExp_while_C_21, modExp_while_C_22,
      modExp_while_C_23, modExp_while_C_24, VEC_LOOP_1_COMP_LOOP_C_0, VEC_LOOP_1_COMP_LOOP_C_1,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_1,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_2, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_3,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_4, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_5,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_6, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_7,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_8, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_9,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_10, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_11,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_12, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_13,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_14, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_15,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_16, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_17,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_18, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_19,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_20, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_21,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_22, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_23,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24, VEC_LOOP_1_COMP_LOOP_C_2, VEC_LOOP_1_COMP_LOOP_C_3,
      VEC_LOOP_1_COMP_LOOP_C_4, VEC_LOOP_1_COMP_LOOP_C_5, VEC_LOOP_1_COMP_LOOP_C_6,
      VEC_LOOP_1_COMP_LOOP_C_7, VEC_LOOP_1_COMP_LOOP_C_8, VEC_LOOP_1_COMP_LOOP_C_9,
      VEC_LOOP_1_COMP_LOOP_C_10, VEC_LOOP_1_COMP_LOOP_C_11, VEC_LOOP_1_COMP_LOOP_C_12,
      VEC_LOOP_1_COMP_LOOP_C_13, VEC_LOOP_1_COMP_LOOP_C_14, VEC_LOOP_1_COMP_LOOP_C_15,
      VEC_LOOP_1_COMP_LOOP_C_16, VEC_LOOP_1_COMP_LOOP_C_17, VEC_LOOP_1_COMP_LOOP_C_18,
      VEC_LOOP_1_COMP_LOOP_C_19, VEC_LOOP_1_COMP_LOOP_C_20, VEC_LOOP_1_COMP_LOOP_C_21,
      VEC_LOOP_1_COMP_LOOP_C_22, VEC_LOOP_1_COMP_LOOP_C_23, VEC_LOOP_1_COMP_LOOP_C_24,
      VEC_LOOP_1_COMP_LOOP_C_25, VEC_LOOP_1_COMP_LOOP_C_26, VEC_LOOP_1_COMP_LOOP_C_27,
      VEC_LOOP_1_COMP_LOOP_C_28, VEC_LOOP_1_COMP_LOOP_C_29, VEC_LOOP_1_COMP_LOOP_C_30,
      VEC_LOOP_1_COMP_LOOP_C_31, VEC_LOOP_1_COMP_LOOP_C_32, VEC_LOOP_1_COMP_LOOP_C_33,
      VEC_LOOP_1_COMP_LOOP_C_34, VEC_LOOP_1_COMP_LOOP_C_35, VEC_LOOP_1_COMP_LOOP_C_36,
      VEC_LOOP_1_COMP_LOOP_C_37, VEC_LOOP_1_COMP_LOOP_C_38, VEC_LOOP_1_COMP_LOOP_C_39,
      VEC_LOOP_1_COMP_LOOP_C_40, VEC_LOOP_1_COMP_LOOP_C_41, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_1, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_2,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_3, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_4,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_5, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_6,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_7, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_8,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_9, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_10,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_11, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_12,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_13, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_14,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_15, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_16,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_17, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_18,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_19, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_20,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_21, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_22,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_23, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24,
      VEC_LOOP_1_COMP_LOOP_C_42, VEC_LOOP_1_COMP_LOOP_C_43, VEC_LOOP_1_COMP_LOOP_C_44,
      VEC_LOOP_1_COMP_LOOP_C_45, VEC_LOOP_1_COMP_LOOP_C_46, VEC_LOOP_1_COMP_LOOP_C_47,
      VEC_LOOP_1_COMP_LOOP_C_48, VEC_LOOP_1_COMP_LOOP_C_49, VEC_LOOP_1_COMP_LOOP_C_50,
      VEC_LOOP_1_COMP_LOOP_C_51, VEC_LOOP_1_COMP_LOOP_C_52, VEC_LOOP_1_COMP_LOOP_C_53,
      VEC_LOOP_1_COMP_LOOP_C_54, VEC_LOOP_1_COMP_LOOP_C_55, VEC_LOOP_1_COMP_LOOP_C_56,
      VEC_LOOP_1_COMP_LOOP_C_57, VEC_LOOP_1_COMP_LOOP_C_58, VEC_LOOP_1_COMP_LOOP_C_59,
      VEC_LOOP_1_COMP_LOOP_C_60, VEC_LOOP_1_COMP_LOOP_C_61, VEC_LOOP_1_COMP_LOOP_C_62,
      VEC_LOOP_1_COMP_LOOP_C_63, VEC_LOOP_1_COMP_LOOP_C_64, VEC_LOOP_1_COMP_LOOP_C_65,
      VEC_LOOP_1_COMP_LOOP_C_66, VEC_LOOP_1_COMP_LOOP_C_67, VEC_LOOP_1_COMP_LOOP_C_68,
      VEC_LOOP_1_COMP_LOOP_C_69, VEC_LOOP_1_COMP_LOOP_C_70, VEC_LOOP_1_COMP_LOOP_C_71,
      VEC_LOOP_1_COMP_LOOP_C_72, VEC_LOOP_1_COMP_LOOP_C_73, VEC_LOOP_1_COMP_LOOP_C_74,
      VEC_LOOP_1_COMP_LOOP_C_75, VEC_LOOP_1_COMP_LOOP_C_76, VEC_LOOP_1_COMP_LOOP_C_77,
      VEC_LOOP_1_COMP_LOOP_C_78, VEC_LOOP_1_COMP_LOOP_C_79, VEC_LOOP_1_COMP_LOOP_C_80,
      VEC_LOOP_1_COMP_LOOP_C_81, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_0, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_1,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_2, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_3,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_4, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_5,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_6, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_7,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_8, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_9,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_10, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_11,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_12, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_13,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_14, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_15,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_16, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_17,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_18, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_19,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_20, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_21,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_22, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_23,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24, VEC_LOOP_1_COMP_LOOP_C_82, VEC_LOOP_1_COMP_LOOP_C_83,
      VEC_LOOP_1_COMP_LOOP_C_84, VEC_LOOP_1_COMP_LOOP_C_85, VEC_LOOP_1_COMP_LOOP_C_86,
      VEC_LOOP_1_COMP_LOOP_C_87, VEC_LOOP_1_COMP_LOOP_C_88, VEC_LOOP_1_COMP_LOOP_C_89,
      VEC_LOOP_1_COMP_LOOP_C_90, VEC_LOOP_1_COMP_LOOP_C_91, VEC_LOOP_1_COMP_LOOP_C_92,
      VEC_LOOP_1_COMP_LOOP_C_93, VEC_LOOP_1_COMP_LOOP_C_94, VEC_LOOP_1_COMP_LOOP_C_95,
      VEC_LOOP_1_COMP_LOOP_C_96, VEC_LOOP_1_COMP_LOOP_C_97, VEC_LOOP_1_COMP_LOOP_C_98,
      VEC_LOOP_1_COMP_LOOP_C_99, VEC_LOOP_1_COMP_LOOP_C_100, VEC_LOOP_1_COMP_LOOP_C_101,
      VEC_LOOP_1_COMP_LOOP_C_102, VEC_LOOP_1_COMP_LOOP_C_103, VEC_LOOP_1_COMP_LOOP_C_104,
      VEC_LOOP_1_COMP_LOOP_C_105, VEC_LOOP_1_COMP_LOOP_C_106, VEC_LOOP_1_COMP_LOOP_C_107,
      VEC_LOOP_1_COMP_LOOP_C_108, VEC_LOOP_1_COMP_LOOP_C_109, VEC_LOOP_1_COMP_LOOP_C_110,
      VEC_LOOP_1_COMP_LOOP_C_111, VEC_LOOP_1_COMP_LOOP_C_112, VEC_LOOP_1_COMP_LOOP_C_113,
      VEC_LOOP_1_COMP_LOOP_C_114, VEC_LOOP_1_COMP_LOOP_C_115, VEC_LOOP_1_COMP_LOOP_C_116,
      VEC_LOOP_1_COMP_LOOP_C_117, VEC_LOOP_1_COMP_LOOP_C_118, VEC_LOOP_1_COMP_LOOP_C_119,
      VEC_LOOP_1_COMP_LOOP_C_120, VEC_LOOP_1_COMP_LOOP_C_121, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_0,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_1, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_2,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_3, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_4,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_5, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_6,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_7, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_8,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_9, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_10,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_11, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_12,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_13, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_14,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_15, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_16,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_17, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_18,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_19, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_20,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_21, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_22,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_23, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24,
      VEC_LOOP_1_COMP_LOOP_C_122, VEC_LOOP_1_COMP_LOOP_C_123, VEC_LOOP_1_COMP_LOOP_C_124,
      VEC_LOOP_1_COMP_LOOP_C_125, VEC_LOOP_1_COMP_LOOP_C_126, VEC_LOOP_1_COMP_LOOP_C_127,
      VEC_LOOP_1_COMP_LOOP_C_128, VEC_LOOP_1_COMP_LOOP_C_129, VEC_LOOP_1_COMP_LOOP_C_130,
      VEC_LOOP_1_COMP_LOOP_C_131, VEC_LOOP_1_COMP_LOOP_C_132, VEC_LOOP_1_COMP_LOOP_C_133,
      VEC_LOOP_1_COMP_LOOP_C_134, VEC_LOOP_1_COMP_LOOP_C_135, VEC_LOOP_1_COMP_LOOP_C_136,
      VEC_LOOP_1_COMP_LOOP_C_137, VEC_LOOP_1_COMP_LOOP_C_138, VEC_LOOP_1_COMP_LOOP_C_139,
      VEC_LOOP_1_COMP_LOOP_C_140, VEC_LOOP_1_COMP_LOOP_C_141, VEC_LOOP_1_COMP_LOOP_C_142,
      VEC_LOOP_1_COMP_LOOP_C_143, VEC_LOOP_1_COMP_LOOP_C_144, VEC_LOOP_1_COMP_LOOP_C_145,
      VEC_LOOP_1_COMP_LOOP_C_146, VEC_LOOP_1_COMP_LOOP_C_147, VEC_LOOP_1_COMP_LOOP_C_148,
      VEC_LOOP_1_COMP_LOOP_C_149, VEC_LOOP_1_COMP_LOOP_C_150, VEC_LOOP_1_COMP_LOOP_C_151,
      VEC_LOOP_1_COMP_LOOP_C_152, VEC_LOOP_1_COMP_LOOP_C_153, VEC_LOOP_1_COMP_LOOP_C_154,
      VEC_LOOP_1_COMP_LOOP_C_155, VEC_LOOP_1_COMP_LOOP_C_156, VEC_LOOP_1_COMP_LOOP_C_157,
      VEC_LOOP_1_COMP_LOOP_C_158, VEC_LOOP_1_COMP_LOOP_C_159, VEC_LOOP_1_COMP_LOOP_C_160,
      VEC_LOOP_C_0, VEC_LOOP_2_COMP_LOOP_C_0, VEC_LOOP_2_COMP_LOOP_C_1, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_1, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_2,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_3, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_4,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_5, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_6,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_7, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_8,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_9, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_10,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_11, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_12,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_13, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_14,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_15, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_16,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_17, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_18,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_19, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_20,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_21, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_22,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_23, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24,
      VEC_LOOP_2_COMP_LOOP_C_2, VEC_LOOP_2_COMP_LOOP_C_3, VEC_LOOP_2_COMP_LOOP_C_4,
      VEC_LOOP_2_COMP_LOOP_C_5, VEC_LOOP_2_COMP_LOOP_C_6, VEC_LOOP_2_COMP_LOOP_C_7,
      VEC_LOOP_2_COMP_LOOP_C_8, VEC_LOOP_2_COMP_LOOP_C_9, VEC_LOOP_2_COMP_LOOP_C_10,
      VEC_LOOP_2_COMP_LOOP_C_11, VEC_LOOP_2_COMP_LOOP_C_12, VEC_LOOP_2_COMP_LOOP_C_13,
      VEC_LOOP_2_COMP_LOOP_C_14, VEC_LOOP_2_COMP_LOOP_C_15, VEC_LOOP_2_COMP_LOOP_C_16,
      VEC_LOOP_2_COMP_LOOP_C_17, VEC_LOOP_2_COMP_LOOP_C_18, VEC_LOOP_2_COMP_LOOP_C_19,
      VEC_LOOP_2_COMP_LOOP_C_20, VEC_LOOP_2_COMP_LOOP_C_21, VEC_LOOP_2_COMP_LOOP_C_22,
      VEC_LOOP_2_COMP_LOOP_C_23, VEC_LOOP_2_COMP_LOOP_C_24, VEC_LOOP_2_COMP_LOOP_C_25,
      VEC_LOOP_2_COMP_LOOP_C_26, VEC_LOOP_2_COMP_LOOP_C_27, VEC_LOOP_2_COMP_LOOP_C_28,
      VEC_LOOP_2_COMP_LOOP_C_29, VEC_LOOP_2_COMP_LOOP_C_30, VEC_LOOP_2_COMP_LOOP_C_31,
      VEC_LOOP_2_COMP_LOOP_C_32, VEC_LOOP_2_COMP_LOOP_C_33, VEC_LOOP_2_COMP_LOOP_C_34,
      VEC_LOOP_2_COMP_LOOP_C_35, VEC_LOOP_2_COMP_LOOP_C_36, VEC_LOOP_2_COMP_LOOP_C_37,
      VEC_LOOP_2_COMP_LOOP_C_38, VEC_LOOP_2_COMP_LOOP_C_39, VEC_LOOP_2_COMP_LOOP_C_40,
      VEC_LOOP_2_COMP_LOOP_C_41, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_1,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_2, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_3,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_4, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_5,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_6, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_7,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_8, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_9,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_10, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_11,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_12, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_13,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_14, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_15,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_16, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_17,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_18, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_19,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_20, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_21,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_22, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_23,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24, VEC_LOOP_2_COMP_LOOP_C_42, VEC_LOOP_2_COMP_LOOP_C_43,
      VEC_LOOP_2_COMP_LOOP_C_44, VEC_LOOP_2_COMP_LOOP_C_45, VEC_LOOP_2_COMP_LOOP_C_46,
      VEC_LOOP_2_COMP_LOOP_C_47, VEC_LOOP_2_COMP_LOOP_C_48, VEC_LOOP_2_COMP_LOOP_C_49,
      VEC_LOOP_2_COMP_LOOP_C_50, VEC_LOOP_2_COMP_LOOP_C_51, VEC_LOOP_2_COMP_LOOP_C_52,
      VEC_LOOP_2_COMP_LOOP_C_53, VEC_LOOP_2_COMP_LOOP_C_54, VEC_LOOP_2_COMP_LOOP_C_55,
      VEC_LOOP_2_COMP_LOOP_C_56, VEC_LOOP_2_COMP_LOOP_C_57, VEC_LOOP_2_COMP_LOOP_C_58,
      VEC_LOOP_2_COMP_LOOP_C_59, VEC_LOOP_2_COMP_LOOP_C_60, VEC_LOOP_2_COMP_LOOP_C_61,
      VEC_LOOP_2_COMP_LOOP_C_62, VEC_LOOP_2_COMP_LOOP_C_63, VEC_LOOP_2_COMP_LOOP_C_64,
      VEC_LOOP_2_COMP_LOOP_C_65, VEC_LOOP_2_COMP_LOOP_C_66, VEC_LOOP_2_COMP_LOOP_C_67,
      VEC_LOOP_2_COMP_LOOP_C_68, VEC_LOOP_2_COMP_LOOP_C_69, VEC_LOOP_2_COMP_LOOP_C_70,
      VEC_LOOP_2_COMP_LOOP_C_71, VEC_LOOP_2_COMP_LOOP_C_72, VEC_LOOP_2_COMP_LOOP_C_73,
      VEC_LOOP_2_COMP_LOOP_C_74, VEC_LOOP_2_COMP_LOOP_C_75, VEC_LOOP_2_COMP_LOOP_C_76,
      VEC_LOOP_2_COMP_LOOP_C_77, VEC_LOOP_2_COMP_LOOP_C_78, VEC_LOOP_2_COMP_LOOP_C_79,
      VEC_LOOP_2_COMP_LOOP_C_80, VEC_LOOP_2_COMP_LOOP_C_81, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_0,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_1, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_2,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_3, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_4,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_5, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_6,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_7, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_8,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_9, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_10,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_11, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_12,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_13, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_14,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_15, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_16,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_17, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_18,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_19, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_20,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_21, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_22,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_23, VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24,
      VEC_LOOP_2_COMP_LOOP_C_82, VEC_LOOP_2_COMP_LOOP_C_83, VEC_LOOP_2_COMP_LOOP_C_84,
      VEC_LOOP_2_COMP_LOOP_C_85, VEC_LOOP_2_COMP_LOOP_C_86, VEC_LOOP_2_COMP_LOOP_C_87,
      VEC_LOOP_2_COMP_LOOP_C_88, VEC_LOOP_2_COMP_LOOP_C_89, VEC_LOOP_2_COMP_LOOP_C_90,
      VEC_LOOP_2_COMP_LOOP_C_91, VEC_LOOP_2_COMP_LOOP_C_92, VEC_LOOP_2_COMP_LOOP_C_93,
      VEC_LOOP_2_COMP_LOOP_C_94, VEC_LOOP_2_COMP_LOOP_C_95, VEC_LOOP_2_COMP_LOOP_C_96,
      VEC_LOOP_2_COMP_LOOP_C_97, VEC_LOOP_2_COMP_LOOP_C_98, VEC_LOOP_2_COMP_LOOP_C_99,
      VEC_LOOP_2_COMP_LOOP_C_100, VEC_LOOP_2_COMP_LOOP_C_101, VEC_LOOP_2_COMP_LOOP_C_102,
      VEC_LOOP_2_COMP_LOOP_C_103, VEC_LOOP_2_COMP_LOOP_C_104, VEC_LOOP_2_COMP_LOOP_C_105,
      VEC_LOOP_2_COMP_LOOP_C_106, VEC_LOOP_2_COMP_LOOP_C_107, VEC_LOOP_2_COMP_LOOP_C_108,
      VEC_LOOP_2_COMP_LOOP_C_109, VEC_LOOP_2_COMP_LOOP_C_110, VEC_LOOP_2_COMP_LOOP_C_111,
      VEC_LOOP_2_COMP_LOOP_C_112, VEC_LOOP_2_COMP_LOOP_C_113, VEC_LOOP_2_COMP_LOOP_C_114,
      VEC_LOOP_2_COMP_LOOP_C_115, VEC_LOOP_2_COMP_LOOP_C_116, VEC_LOOP_2_COMP_LOOP_C_117,
      VEC_LOOP_2_COMP_LOOP_C_118, VEC_LOOP_2_COMP_LOOP_C_119, VEC_LOOP_2_COMP_LOOP_C_120,
      VEC_LOOP_2_COMP_LOOP_C_121, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_0, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_1,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_2, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_3,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_4, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_5,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_6, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_7,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_8, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_9,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_10, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_11,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_12, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_13,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_14, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_15,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_16, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_17,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_18, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_19,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_20, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_21,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_22, VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_23,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24, VEC_LOOP_2_COMP_LOOP_C_122, VEC_LOOP_2_COMP_LOOP_C_123,
      VEC_LOOP_2_COMP_LOOP_C_124, VEC_LOOP_2_COMP_LOOP_C_125, VEC_LOOP_2_COMP_LOOP_C_126,
      VEC_LOOP_2_COMP_LOOP_C_127, VEC_LOOP_2_COMP_LOOP_C_128, VEC_LOOP_2_COMP_LOOP_C_129,
      VEC_LOOP_2_COMP_LOOP_C_130, VEC_LOOP_2_COMP_LOOP_C_131, VEC_LOOP_2_COMP_LOOP_C_132,
      VEC_LOOP_2_COMP_LOOP_C_133, VEC_LOOP_2_COMP_LOOP_C_134, VEC_LOOP_2_COMP_LOOP_C_135,
      VEC_LOOP_2_COMP_LOOP_C_136, VEC_LOOP_2_COMP_LOOP_C_137, VEC_LOOP_2_COMP_LOOP_C_138,
      VEC_LOOP_2_COMP_LOOP_C_139, VEC_LOOP_2_COMP_LOOP_C_140, VEC_LOOP_2_COMP_LOOP_C_141,
      VEC_LOOP_2_COMP_LOOP_C_142, VEC_LOOP_2_COMP_LOOP_C_143, VEC_LOOP_2_COMP_LOOP_C_144,
      VEC_LOOP_2_COMP_LOOP_C_145, VEC_LOOP_2_COMP_LOOP_C_146, VEC_LOOP_2_COMP_LOOP_C_147,
      VEC_LOOP_2_COMP_LOOP_C_148, VEC_LOOP_2_COMP_LOOP_C_149, VEC_LOOP_2_COMP_LOOP_C_150,
      VEC_LOOP_2_COMP_LOOP_C_151, VEC_LOOP_2_COMP_LOOP_C_152, VEC_LOOP_2_COMP_LOOP_C_153,
      VEC_LOOP_2_COMP_LOOP_C_154, VEC_LOOP_2_COMP_LOOP_C_155, VEC_LOOP_2_COMP_LOOP_C_156,
      VEC_LOOP_2_COMP_LOOP_C_157, VEC_LOOP_2_COMP_LOOP_C_158, VEC_LOOP_2_COMP_LOOP_C_159,
      VEC_LOOP_2_COMP_LOOP_C_160, VEC_LOOP_C_1, STAGE_LOOP_C_6, main_C_1);

  SIGNAL state_var : inPlaceNTT_DIT_core_core_fsm_1_ST;
  SIGNAL state_var_NS : inPlaceNTT_DIT_core_core_fsm_1_ST;

BEGIN
  inPlaceNTT_DIT_core_core_fsm_1 : PROCESS (STAGE_LOOP_C_5_tr0, modExp_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_1_tr0, VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_40_tr0, VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_80_tr0, VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_120_tr0, VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_160_tr0, VEC_LOOP_C_0_tr0, VEC_LOOP_2_COMP_LOOP_C_1_tr0,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0, VEC_LOOP_2_COMP_LOOP_C_40_tr0,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0, VEC_LOOP_2_COMP_LOOP_C_80_tr0,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0, VEC_LOOP_2_COMP_LOOP_C_120_tr0,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0, VEC_LOOP_2_COMP_LOOP_C_160_tr0,
      VEC_LOOP_C_1_tr0, STAGE_LOOP_C_6_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN STAGE_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000001");
        state_var_NS <= STAGE_LOOP_C_1;
      WHEN STAGE_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000010");
        state_var_NS <= STAGE_LOOP_C_2;
      WHEN STAGE_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000011");
        state_var_NS <= STAGE_LOOP_C_3;
      WHEN STAGE_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000100");
        state_var_NS <= STAGE_LOOP_C_4;
      WHEN STAGE_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000101");
        state_var_NS <= STAGE_LOOP_C_5;
      WHEN STAGE_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000110");
        IF ( STAGE_LOOP_C_5_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_0;
        ELSE
          state_var_NS <= modExp_while_C_0;
        END IF;
      WHEN modExp_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000111");
        state_var_NS <= modExp_while_C_1;
      WHEN modExp_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001000");
        state_var_NS <= modExp_while_C_2;
      WHEN modExp_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001001");
        state_var_NS <= modExp_while_C_3;
      WHEN modExp_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001010");
        state_var_NS <= modExp_while_C_4;
      WHEN modExp_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001011");
        state_var_NS <= modExp_while_C_5;
      WHEN modExp_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001100");
        state_var_NS <= modExp_while_C_6;
      WHEN modExp_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001101");
        state_var_NS <= modExp_while_C_7;
      WHEN modExp_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001110");
        state_var_NS <= modExp_while_C_8;
      WHEN modExp_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001111");
        state_var_NS <= modExp_while_C_9;
      WHEN modExp_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010000");
        state_var_NS <= modExp_while_C_10;
      WHEN modExp_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010001");
        state_var_NS <= modExp_while_C_11;
      WHEN modExp_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010010");
        state_var_NS <= modExp_while_C_12;
      WHEN modExp_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010011");
        state_var_NS <= modExp_while_C_13;
      WHEN modExp_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010100");
        state_var_NS <= modExp_while_C_14;
      WHEN modExp_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010101");
        state_var_NS <= modExp_while_C_15;
      WHEN modExp_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010110");
        state_var_NS <= modExp_while_C_16;
      WHEN modExp_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010111");
        state_var_NS <= modExp_while_C_17;
      WHEN modExp_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011000");
        state_var_NS <= modExp_while_C_18;
      WHEN modExp_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011001");
        state_var_NS <= modExp_while_C_19;
      WHEN modExp_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011010");
        state_var_NS <= modExp_while_C_20;
      WHEN modExp_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011011");
        state_var_NS <= modExp_while_C_21;
      WHEN modExp_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011100");
        state_var_NS <= modExp_while_C_22;
      WHEN modExp_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011101");
        state_var_NS <= modExp_while_C_23;
      WHEN modExp_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011110");
        state_var_NS <= modExp_while_C_24;
      WHEN modExp_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011111");
        IF ( modExp_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_0;
        ELSE
          state_var_NS <= modExp_while_C_0;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_1;
      WHEN VEC_LOOP_1_COMP_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100001");
        IF ( VEC_LOOP_1_COMP_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_2;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_1;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_2;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_3;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_4;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_5;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_6;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_7;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_8;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_9;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_10;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_11;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_12;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_13;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_14;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_15;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_16;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_17;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_18;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_19;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_20;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_21;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_22;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_23;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24;
      WHEN VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111010");
        IF ( VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_2;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_3;
      WHEN VEC_LOOP_1_COMP_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_4;
      WHEN VEC_LOOP_1_COMP_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_5;
      WHEN VEC_LOOP_1_COMP_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_6;
      WHEN VEC_LOOP_1_COMP_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_7;
      WHEN VEC_LOOP_1_COMP_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_8;
      WHEN VEC_LOOP_1_COMP_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_9;
      WHEN VEC_LOOP_1_COMP_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_10;
      WHEN VEC_LOOP_1_COMP_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_11;
      WHEN VEC_LOOP_1_COMP_LOOP_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_12;
      WHEN VEC_LOOP_1_COMP_LOOP_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_13;
      WHEN VEC_LOOP_1_COMP_LOOP_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_14;
      WHEN VEC_LOOP_1_COMP_LOOP_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_15;
      WHEN VEC_LOOP_1_COMP_LOOP_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_16;
      WHEN VEC_LOOP_1_COMP_LOOP_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_17;
      WHEN VEC_LOOP_1_COMP_LOOP_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_18;
      WHEN VEC_LOOP_1_COMP_LOOP_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_19;
      WHEN VEC_LOOP_1_COMP_LOOP_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_20;
      WHEN VEC_LOOP_1_COMP_LOOP_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_21;
      WHEN VEC_LOOP_1_COMP_LOOP_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_22;
      WHEN VEC_LOOP_1_COMP_LOOP_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_23;
      WHEN VEC_LOOP_1_COMP_LOOP_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_24;
      WHEN VEC_LOOP_1_COMP_LOOP_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_25;
      WHEN VEC_LOOP_1_COMP_LOOP_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_26;
      WHEN VEC_LOOP_1_COMP_LOOP_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_27;
      WHEN VEC_LOOP_1_COMP_LOOP_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_28;
      WHEN VEC_LOOP_1_COMP_LOOP_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_29;
      WHEN VEC_LOOP_1_COMP_LOOP_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_30;
      WHEN VEC_LOOP_1_COMP_LOOP_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_31;
      WHEN VEC_LOOP_1_COMP_LOOP_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_32;
      WHEN VEC_LOOP_1_COMP_LOOP_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_33;
      WHEN VEC_LOOP_1_COMP_LOOP_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_34;
      WHEN VEC_LOOP_1_COMP_LOOP_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_35;
      WHEN VEC_LOOP_1_COMP_LOOP_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_36;
      WHEN VEC_LOOP_1_COMP_LOOP_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_37;
      WHEN VEC_LOOP_1_COMP_LOOP_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_38;
      WHEN VEC_LOOP_1_COMP_LOOP_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_39;
      WHEN VEC_LOOP_1_COMP_LOOP_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_40;
      WHEN VEC_LOOP_1_COMP_LOOP_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100001");
        IF ( VEC_LOOP_1_COMP_LOOP_C_40_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_41;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_1;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_2;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_3;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_4;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_5;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_6;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_7;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_8;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_9;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_10;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_11;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_12;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_13;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_14;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_15;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_16;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_17;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_18;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_19;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_20;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_21;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_22;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_23;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24;
      WHEN VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111011");
        IF ( VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_42;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_43;
      WHEN VEC_LOOP_1_COMP_LOOP_C_43 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_44;
      WHEN VEC_LOOP_1_COMP_LOOP_C_44 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_45;
      WHEN VEC_LOOP_1_COMP_LOOP_C_45 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_46;
      WHEN VEC_LOOP_1_COMP_LOOP_C_46 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_47;
      WHEN VEC_LOOP_1_COMP_LOOP_C_47 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_48;
      WHEN VEC_LOOP_1_COMP_LOOP_C_48 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_49;
      WHEN VEC_LOOP_1_COMP_LOOP_C_49 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_50;
      WHEN VEC_LOOP_1_COMP_LOOP_C_50 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_51;
      WHEN VEC_LOOP_1_COMP_LOOP_C_51 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_52;
      WHEN VEC_LOOP_1_COMP_LOOP_C_52 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_53;
      WHEN VEC_LOOP_1_COMP_LOOP_C_53 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_54;
      WHEN VEC_LOOP_1_COMP_LOOP_C_54 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_55;
      WHEN VEC_LOOP_1_COMP_LOOP_C_55 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_56;
      WHEN VEC_LOOP_1_COMP_LOOP_C_56 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_57;
      WHEN VEC_LOOP_1_COMP_LOOP_C_57 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_58;
      WHEN VEC_LOOP_1_COMP_LOOP_C_58 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_59;
      WHEN VEC_LOOP_1_COMP_LOOP_C_59 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_60;
      WHEN VEC_LOOP_1_COMP_LOOP_C_60 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_61;
      WHEN VEC_LOOP_1_COMP_LOOP_C_61 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_62;
      WHEN VEC_LOOP_1_COMP_LOOP_C_62 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_63;
      WHEN VEC_LOOP_1_COMP_LOOP_C_63 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_64;
      WHEN VEC_LOOP_1_COMP_LOOP_C_64 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_65;
      WHEN VEC_LOOP_1_COMP_LOOP_C_65 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_66;
      WHEN VEC_LOOP_1_COMP_LOOP_C_66 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_67;
      WHEN VEC_LOOP_1_COMP_LOOP_C_67 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_68;
      WHEN VEC_LOOP_1_COMP_LOOP_C_68 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_69;
      WHEN VEC_LOOP_1_COMP_LOOP_C_69 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_70;
      WHEN VEC_LOOP_1_COMP_LOOP_C_70 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_71;
      WHEN VEC_LOOP_1_COMP_LOOP_C_71 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_72;
      WHEN VEC_LOOP_1_COMP_LOOP_C_72 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_73;
      WHEN VEC_LOOP_1_COMP_LOOP_C_73 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_74;
      WHEN VEC_LOOP_1_COMP_LOOP_C_74 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_75;
      WHEN VEC_LOOP_1_COMP_LOOP_C_75 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_76;
      WHEN VEC_LOOP_1_COMP_LOOP_C_76 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_77;
      WHEN VEC_LOOP_1_COMP_LOOP_C_77 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_78;
      WHEN VEC_LOOP_1_COMP_LOOP_C_78 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_79;
      WHEN VEC_LOOP_1_COMP_LOOP_C_79 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_80;
      WHEN VEC_LOOP_1_COMP_LOOP_C_80 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100010");
        IF ( VEC_LOOP_1_COMP_LOOP_C_80_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_81;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_81 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_0;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_1;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_2;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_3;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_4;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_5;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_6;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_7;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_8;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_9;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_10;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_11;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_12;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_13;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_14;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_15;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_16;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_17;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_18;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_19;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_20;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_21;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_22;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_23;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24;
      WHEN VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111100");
        IF ( VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_82;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_82 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_83;
      WHEN VEC_LOOP_1_COMP_LOOP_C_83 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_84;
      WHEN VEC_LOOP_1_COMP_LOOP_C_84 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_85;
      WHEN VEC_LOOP_1_COMP_LOOP_C_85 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_86;
      WHEN VEC_LOOP_1_COMP_LOOP_C_86 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_87;
      WHEN VEC_LOOP_1_COMP_LOOP_C_87 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_88;
      WHEN VEC_LOOP_1_COMP_LOOP_C_88 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_89;
      WHEN VEC_LOOP_1_COMP_LOOP_C_89 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_90;
      WHEN VEC_LOOP_1_COMP_LOOP_C_90 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_91;
      WHEN VEC_LOOP_1_COMP_LOOP_C_91 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_92;
      WHEN VEC_LOOP_1_COMP_LOOP_C_92 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_93;
      WHEN VEC_LOOP_1_COMP_LOOP_C_93 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_94;
      WHEN VEC_LOOP_1_COMP_LOOP_C_94 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_95;
      WHEN VEC_LOOP_1_COMP_LOOP_C_95 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_96;
      WHEN VEC_LOOP_1_COMP_LOOP_C_96 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_97;
      WHEN VEC_LOOP_1_COMP_LOOP_C_97 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_98;
      WHEN VEC_LOOP_1_COMP_LOOP_C_98 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_99;
      WHEN VEC_LOOP_1_COMP_LOOP_C_99 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_100;
      WHEN VEC_LOOP_1_COMP_LOOP_C_100 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_101;
      WHEN VEC_LOOP_1_COMP_LOOP_C_101 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_102;
      WHEN VEC_LOOP_1_COMP_LOOP_C_102 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_103;
      WHEN VEC_LOOP_1_COMP_LOOP_C_103 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_104;
      WHEN VEC_LOOP_1_COMP_LOOP_C_104 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_105;
      WHEN VEC_LOOP_1_COMP_LOOP_C_105 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_106;
      WHEN VEC_LOOP_1_COMP_LOOP_C_106 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_107;
      WHEN VEC_LOOP_1_COMP_LOOP_C_107 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_108;
      WHEN VEC_LOOP_1_COMP_LOOP_C_108 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_109;
      WHEN VEC_LOOP_1_COMP_LOOP_C_109 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_110;
      WHEN VEC_LOOP_1_COMP_LOOP_C_110 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_111;
      WHEN VEC_LOOP_1_COMP_LOOP_C_111 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_112;
      WHEN VEC_LOOP_1_COMP_LOOP_C_112 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_113;
      WHEN VEC_LOOP_1_COMP_LOOP_C_113 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_114;
      WHEN VEC_LOOP_1_COMP_LOOP_C_114 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_115;
      WHEN VEC_LOOP_1_COMP_LOOP_C_115 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_116;
      WHEN VEC_LOOP_1_COMP_LOOP_C_116 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_117;
      WHEN VEC_LOOP_1_COMP_LOOP_C_117 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_118;
      WHEN VEC_LOOP_1_COMP_LOOP_C_118 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_119;
      WHEN VEC_LOOP_1_COMP_LOOP_C_119 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_120;
      WHEN VEC_LOOP_1_COMP_LOOP_C_120 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100011");
        IF ( VEC_LOOP_1_COMP_LOOP_C_120_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_121;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_121 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_0;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_1;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_2;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_3;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_4;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_5;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_6;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_7;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_8;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_9;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_10;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_11;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_12;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_13;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_14;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_15;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_16;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_17;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_18;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_19;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_20;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_21;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_22;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_23;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24;
      WHEN VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111101");
        IF ( VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_122;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_1_COMP_LOOP_C_122 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_123;
      WHEN VEC_LOOP_1_COMP_LOOP_C_123 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_124;
      WHEN VEC_LOOP_1_COMP_LOOP_C_124 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_125;
      WHEN VEC_LOOP_1_COMP_LOOP_C_125 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_126;
      WHEN VEC_LOOP_1_COMP_LOOP_C_126 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_127;
      WHEN VEC_LOOP_1_COMP_LOOP_C_127 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_128;
      WHEN VEC_LOOP_1_COMP_LOOP_C_128 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_129;
      WHEN VEC_LOOP_1_COMP_LOOP_C_129 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_130;
      WHEN VEC_LOOP_1_COMP_LOOP_C_130 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_131;
      WHEN VEC_LOOP_1_COMP_LOOP_C_131 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_132;
      WHEN VEC_LOOP_1_COMP_LOOP_C_132 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_133;
      WHEN VEC_LOOP_1_COMP_LOOP_C_133 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_134;
      WHEN VEC_LOOP_1_COMP_LOOP_C_134 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_135;
      WHEN VEC_LOOP_1_COMP_LOOP_C_135 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_136;
      WHEN VEC_LOOP_1_COMP_LOOP_C_136 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_137;
      WHEN VEC_LOOP_1_COMP_LOOP_C_137 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_138;
      WHEN VEC_LOOP_1_COMP_LOOP_C_138 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_139;
      WHEN VEC_LOOP_1_COMP_LOOP_C_139 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_140;
      WHEN VEC_LOOP_1_COMP_LOOP_C_140 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_141;
      WHEN VEC_LOOP_1_COMP_LOOP_C_141 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_142;
      WHEN VEC_LOOP_1_COMP_LOOP_C_142 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_143;
      WHEN VEC_LOOP_1_COMP_LOOP_C_143 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_144;
      WHEN VEC_LOOP_1_COMP_LOOP_C_144 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_145;
      WHEN VEC_LOOP_1_COMP_LOOP_C_145 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_146;
      WHEN VEC_LOOP_1_COMP_LOOP_C_146 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_147;
      WHEN VEC_LOOP_1_COMP_LOOP_C_147 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_148;
      WHEN VEC_LOOP_1_COMP_LOOP_C_148 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_149;
      WHEN VEC_LOOP_1_COMP_LOOP_C_149 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_150;
      WHEN VEC_LOOP_1_COMP_LOOP_C_150 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_151;
      WHEN VEC_LOOP_1_COMP_LOOP_C_151 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_152;
      WHEN VEC_LOOP_1_COMP_LOOP_C_152 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011100");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_153;
      WHEN VEC_LOOP_1_COMP_LOOP_C_153 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011101");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_154;
      WHEN VEC_LOOP_1_COMP_LOOP_C_154 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011110");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_155;
      WHEN VEC_LOOP_1_COMP_LOOP_C_155 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011111");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_156;
      WHEN VEC_LOOP_1_COMP_LOOP_C_156 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100000");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_157;
      WHEN VEC_LOOP_1_COMP_LOOP_C_157 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100001");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_158;
      WHEN VEC_LOOP_1_COMP_LOOP_C_158 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100010");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_159;
      WHEN VEC_LOOP_1_COMP_LOOP_C_159 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100011");
        state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_160;
      WHEN VEC_LOOP_1_COMP_LOOP_C_160 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100100");
        IF ( VEC_LOOP_1_COMP_LOOP_C_160_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_0;
        END IF;
      WHEN VEC_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100101");
        IF ( VEC_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= STAGE_LOOP_C_6;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_0;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_1;
      WHEN VEC_LOOP_2_COMP_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100111");
        IF ( VEC_LOOP_2_COMP_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_2;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_1;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_2;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_3;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_4;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_5;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_6;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_7;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_8;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_9;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_10;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_11;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_12;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_13;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_14;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_15;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_16;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_17;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_18;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_19;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_20;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_21;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_22;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_23;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24;
      WHEN VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000000");
        IF ( VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_2;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_3;
      WHEN VEC_LOOP_2_COMP_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_4;
      WHEN VEC_LOOP_2_COMP_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_5;
      WHEN VEC_LOOP_2_COMP_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_6;
      WHEN VEC_LOOP_2_COMP_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_7;
      WHEN VEC_LOOP_2_COMP_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_8;
      WHEN VEC_LOOP_2_COMP_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_9;
      WHEN VEC_LOOP_2_COMP_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_10;
      WHEN VEC_LOOP_2_COMP_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_11;
      WHEN VEC_LOOP_2_COMP_LOOP_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_12;
      WHEN VEC_LOOP_2_COMP_LOOP_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_13;
      WHEN VEC_LOOP_2_COMP_LOOP_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_14;
      WHEN VEC_LOOP_2_COMP_LOOP_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_15;
      WHEN VEC_LOOP_2_COMP_LOOP_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_16;
      WHEN VEC_LOOP_2_COMP_LOOP_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_17;
      WHEN VEC_LOOP_2_COMP_LOOP_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_18;
      WHEN VEC_LOOP_2_COMP_LOOP_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_19;
      WHEN VEC_LOOP_2_COMP_LOOP_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_20;
      WHEN VEC_LOOP_2_COMP_LOOP_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_21;
      WHEN VEC_LOOP_2_COMP_LOOP_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_22;
      WHEN VEC_LOOP_2_COMP_LOOP_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_23;
      WHEN VEC_LOOP_2_COMP_LOOP_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_24;
      WHEN VEC_LOOP_2_COMP_LOOP_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_25;
      WHEN VEC_LOOP_2_COMP_LOOP_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_26;
      WHEN VEC_LOOP_2_COMP_LOOP_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_27;
      WHEN VEC_LOOP_2_COMP_LOOP_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_28;
      WHEN VEC_LOOP_2_COMP_LOOP_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_29;
      WHEN VEC_LOOP_2_COMP_LOOP_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_30;
      WHEN VEC_LOOP_2_COMP_LOOP_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_31;
      WHEN VEC_LOOP_2_COMP_LOOP_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_32;
      WHEN VEC_LOOP_2_COMP_LOOP_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_33;
      WHEN VEC_LOOP_2_COMP_LOOP_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_34;
      WHEN VEC_LOOP_2_COMP_LOOP_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_35;
      WHEN VEC_LOOP_2_COMP_LOOP_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_36;
      WHEN VEC_LOOP_2_COMP_LOOP_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_37;
      WHEN VEC_LOOP_2_COMP_LOOP_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_38;
      WHEN VEC_LOOP_2_COMP_LOOP_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_39;
      WHEN VEC_LOOP_2_COMP_LOOP_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_40;
      WHEN VEC_LOOP_2_COMP_LOOP_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100111");
        IF ( VEC_LOOP_2_COMP_LOOP_C_40_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_1;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_41;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_1;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_2;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_3;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_4;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_5;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_6;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_7;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_8;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_9;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_10;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_11;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_12;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_13;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_14;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_15;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_16;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_17;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_18;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_19;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_20;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_21;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_22;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_23;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24;
      WHEN VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000001");
        IF ( VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_42;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_43;
      WHEN VEC_LOOP_2_COMP_LOOP_C_43 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_44;
      WHEN VEC_LOOP_2_COMP_LOOP_C_44 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_45;
      WHEN VEC_LOOP_2_COMP_LOOP_C_45 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_46;
      WHEN VEC_LOOP_2_COMP_LOOP_C_46 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_47;
      WHEN VEC_LOOP_2_COMP_LOOP_C_47 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_48;
      WHEN VEC_LOOP_2_COMP_LOOP_C_48 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_49;
      WHEN VEC_LOOP_2_COMP_LOOP_C_49 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_50;
      WHEN VEC_LOOP_2_COMP_LOOP_C_50 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_51;
      WHEN VEC_LOOP_2_COMP_LOOP_C_51 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_52;
      WHEN VEC_LOOP_2_COMP_LOOP_C_52 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_53;
      WHEN VEC_LOOP_2_COMP_LOOP_C_53 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_54;
      WHEN VEC_LOOP_2_COMP_LOOP_C_54 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_55;
      WHEN VEC_LOOP_2_COMP_LOOP_C_55 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_56;
      WHEN VEC_LOOP_2_COMP_LOOP_C_56 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_57;
      WHEN VEC_LOOP_2_COMP_LOOP_C_57 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_58;
      WHEN VEC_LOOP_2_COMP_LOOP_C_58 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_59;
      WHEN VEC_LOOP_2_COMP_LOOP_C_59 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_60;
      WHEN VEC_LOOP_2_COMP_LOOP_C_60 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_61;
      WHEN VEC_LOOP_2_COMP_LOOP_C_61 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_62;
      WHEN VEC_LOOP_2_COMP_LOOP_C_62 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_63;
      WHEN VEC_LOOP_2_COMP_LOOP_C_63 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_64;
      WHEN VEC_LOOP_2_COMP_LOOP_C_64 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_65;
      WHEN VEC_LOOP_2_COMP_LOOP_C_65 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_66;
      WHEN VEC_LOOP_2_COMP_LOOP_C_66 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_67;
      WHEN VEC_LOOP_2_COMP_LOOP_C_67 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_68;
      WHEN VEC_LOOP_2_COMP_LOOP_C_68 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_69;
      WHEN VEC_LOOP_2_COMP_LOOP_C_69 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_70;
      WHEN VEC_LOOP_2_COMP_LOOP_C_70 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_71;
      WHEN VEC_LOOP_2_COMP_LOOP_C_71 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_72;
      WHEN VEC_LOOP_2_COMP_LOOP_C_72 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_73;
      WHEN VEC_LOOP_2_COMP_LOOP_C_73 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_74;
      WHEN VEC_LOOP_2_COMP_LOOP_C_74 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_75;
      WHEN VEC_LOOP_2_COMP_LOOP_C_75 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_76;
      WHEN VEC_LOOP_2_COMP_LOOP_C_76 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_77;
      WHEN VEC_LOOP_2_COMP_LOOP_C_77 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_78;
      WHEN VEC_LOOP_2_COMP_LOOP_C_78 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_79;
      WHEN VEC_LOOP_2_COMP_LOOP_C_79 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_80;
      WHEN VEC_LOOP_2_COMP_LOOP_C_80 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101000");
        IF ( VEC_LOOP_2_COMP_LOOP_C_80_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_1;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_81;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_81 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_0;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_1;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_2;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_3;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_4;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_5;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_6;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_7;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_8;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_9;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_10;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_11;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_12;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_13;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_14;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_15;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_16;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_17;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_18;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_19;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_20;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_21;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_22;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_23;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24;
      WHEN VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000010");
        IF ( VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_82;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_82 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_83;
      WHEN VEC_LOOP_2_COMP_LOOP_C_83 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_84;
      WHEN VEC_LOOP_2_COMP_LOOP_C_84 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_85;
      WHEN VEC_LOOP_2_COMP_LOOP_C_85 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_86;
      WHEN VEC_LOOP_2_COMP_LOOP_C_86 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_87;
      WHEN VEC_LOOP_2_COMP_LOOP_C_87 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_88;
      WHEN VEC_LOOP_2_COMP_LOOP_C_88 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_89;
      WHEN VEC_LOOP_2_COMP_LOOP_C_89 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_90;
      WHEN VEC_LOOP_2_COMP_LOOP_C_90 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_91;
      WHEN VEC_LOOP_2_COMP_LOOP_C_91 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_92;
      WHEN VEC_LOOP_2_COMP_LOOP_C_92 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_93;
      WHEN VEC_LOOP_2_COMP_LOOP_C_93 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_94;
      WHEN VEC_LOOP_2_COMP_LOOP_C_94 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_95;
      WHEN VEC_LOOP_2_COMP_LOOP_C_95 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_96;
      WHEN VEC_LOOP_2_COMP_LOOP_C_96 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_97;
      WHEN VEC_LOOP_2_COMP_LOOP_C_97 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_98;
      WHEN VEC_LOOP_2_COMP_LOOP_C_98 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_99;
      WHEN VEC_LOOP_2_COMP_LOOP_C_99 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_100;
      WHEN VEC_LOOP_2_COMP_LOOP_C_100 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_101;
      WHEN VEC_LOOP_2_COMP_LOOP_C_101 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_102;
      WHEN VEC_LOOP_2_COMP_LOOP_C_102 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_103;
      WHEN VEC_LOOP_2_COMP_LOOP_C_103 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_104;
      WHEN VEC_LOOP_2_COMP_LOOP_C_104 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_105;
      WHEN VEC_LOOP_2_COMP_LOOP_C_105 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_106;
      WHEN VEC_LOOP_2_COMP_LOOP_C_106 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_107;
      WHEN VEC_LOOP_2_COMP_LOOP_C_107 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_108;
      WHEN VEC_LOOP_2_COMP_LOOP_C_108 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_109;
      WHEN VEC_LOOP_2_COMP_LOOP_C_109 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_110;
      WHEN VEC_LOOP_2_COMP_LOOP_C_110 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_111;
      WHEN VEC_LOOP_2_COMP_LOOP_C_111 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_112;
      WHEN VEC_LOOP_2_COMP_LOOP_C_112 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_113;
      WHEN VEC_LOOP_2_COMP_LOOP_C_113 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_114;
      WHEN VEC_LOOP_2_COMP_LOOP_C_114 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_115;
      WHEN VEC_LOOP_2_COMP_LOOP_C_115 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_116;
      WHEN VEC_LOOP_2_COMP_LOOP_C_116 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_117;
      WHEN VEC_LOOP_2_COMP_LOOP_C_117 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_118;
      WHEN VEC_LOOP_2_COMP_LOOP_C_118 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_119;
      WHEN VEC_LOOP_2_COMP_LOOP_C_119 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_120;
      WHEN VEC_LOOP_2_COMP_LOOP_C_120 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101001");
        IF ( VEC_LOOP_2_COMP_LOOP_C_120_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_1;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_121;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_121 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_0;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_1;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_2;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_3;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_4;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_5;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_6;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_7;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_8;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_9;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_10;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_11;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_12;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_13;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_14;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_15;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_16;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_17;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_18;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_19;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_20;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_21;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_22;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_23;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24;
      WHEN VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000011");
        IF ( VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_122;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_0;
        END IF;
      WHEN VEC_LOOP_2_COMP_LOOP_C_122 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_123;
      WHEN VEC_LOOP_2_COMP_LOOP_C_123 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_124;
      WHEN VEC_LOOP_2_COMP_LOOP_C_124 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_125;
      WHEN VEC_LOOP_2_COMP_LOOP_C_125 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_126;
      WHEN VEC_LOOP_2_COMP_LOOP_C_126 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_127;
      WHEN VEC_LOOP_2_COMP_LOOP_C_127 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_128;
      WHEN VEC_LOOP_2_COMP_LOOP_C_128 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_129;
      WHEN VEC_LOOP_2_COMP_LOOP_C_129 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_130;
      WHEN VEC_LOOP_2_COMP_LOOP_C_130 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_131;
      WHEN VEC_LOOP_2_COMP_LOOP_C_131 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_132;
      WHEN VEC_LOOP_2_COMP_LOOP_C_132 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_133;
      WHEN VEC_LOOP_2_COMP_LOOP_C_133 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_134;
      WHEN VEC_LOOP_2_COMP_LOOP_C_134 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_135;
      WHEN VEC_LOOP_2_COMP_LOOP_C_135 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_136;
      WHEN VEC_LOOP_2_COMP_LOOP_C_136 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_137;
      WHEN VEC_LOOP_2_COMP_LOOP_C_137 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_138;
      WHEN VEC_LOOP_2_COMP_LOOP_C_138 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_139;
      WHEN VEC_LOOP_2_COMP_LOOP_C_139 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_140;
      WHEN VEC_LOOP_2_COMP_LOOP_C_140 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_141;
      WHEN VEC_LOOP_2_COMP_LOOP_C_141 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_142;
      WHEN VEC_LOOP_2_COMP_LOOP_C_142 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_143;
      WHEN VEC_LOOP_2_COMP_LOOP_C_143 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_144;
      WHEN VEC_LOOP_2_COMP_LOOP_C_144 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_145;
      WHEN VEC_LOOP_2_COMP_LOOP_C_145 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_146;
      WHEN VEC_LOOP_2_COMP_LOOP_C_146 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_147;
      WHEN VEC_LOOP_2_COMP_LOOP_C_147 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_148;
      WHEN VEC_LOOP_2_COMP_LOOP_C_148 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_149;
      WHEN VEC_LOOP_2_COMP_LOOP_C_149 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_150;
      WHEN VEC_LOOP_2_COMP_LOOP_C_150 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_151;
      WHEN VEC_LOOP_2_COMP_LOOP_C_151 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_152;
      WHEN VEC_LOOP_2_COMP_LOOP_C_152 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100010");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_153;
      WHEN VEC_LOOP_2_COMP_LOOP_C_153 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100011");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_154;
      WHEN VEC_LOOP_2_COMP_LOOP_C_154 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100100");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_155;
      WHEN VEC_LOOP_2_COMP_LOOP_C_155 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100101");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_156;
      WHEN VEC_LOOP_2_COMP_LOOP_C_156 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100110");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_157;
      WHEN VEC_LOOP_2_COMP_LOOP_C_157 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100111");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_158;
      WHEN VEC_LOOP_2_COMP_LOOP_C_158 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101000");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_159;
      WHEN VEC_LOOP_2_COMP_LOOP_C_159 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101001");
        state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_160;
      WHEN VEC_LOOP_2_COMP_LOOP_C_160 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101010");
        IF ( VEC_LOOP_2_COMP_LOOP_C_160_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_1;
        ELSE
          state_var_NS <= VEC_LOOP_2_COMP_LOOP_C_0;
        END IF;
      WHEN VEC_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101011");
        IF ( VEC_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= STAGE_LOOP_C_6;
        ELSE
          state_var_NS <= VEC_LOOP_1_COMP_LOOP_C_0;
        END IF;
      WHEN STAGE_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101100");
        IF ( STAGE_LOOP_C_6_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= STAGE_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101101");
        state_var_NS <= main_C_0;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000");
        state_var_NS <= STAGE_LOOP_C_0;
    END CASE;
  END PROCESS inPlaceNTT_DIT_core_core_fsm_1;

  inPlaceNTT_DIT_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= main_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS inPlaceNTT_DIT_core_core_fsm_1_REG;

END v24;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    vec_rsc_triosy_0_2_lz : OUT STD_LOGIC;
    vec_rsc_triosy_0_3_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC;
    vec_rsc_0_0_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_1_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_2_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_3_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_0_i_adra_d_pff : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsc_0_0_i_da_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_1_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_2_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_3_i_wea_d_pff : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_core;

ARCHITECTURE v24 OF inPlaceNTT_DIT_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL p_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL r_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_result_rem_cmp_a : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_result_rem_cmp_b : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_result_rem_cmp_z : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL operator_66_true_div_cmp_a : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL operator_66_true_div_cmp_z : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL operator_66_true_div_cmp_b_9_0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL fsm_output : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL or_tmp_29 : STD_LOGIC;
  SIGNAL or_tmp_31 : STD_LOGIC;
  SIGNAL or_tmp_51 : STD_LOGIC;
  SIGNAL or_tmp_61 : STD_LOGIC;
  SIGNAL or_tmp_71 : STD_LOGIC;
  SIGNAL or_tmp_72 : STD_LOGIC;
  SIGNAL mux_tmp_72 : STD_LOGIC;
  SIGNAL or_tmp_77 : STD_LOGIC;
  SIGNAL or_tmp_79 : STD_LOGIC;
  SIGNAL mux_tmp_84 : STD_LOGIC;
  SIGNAL mux_tmp_86 : STD_LOGIC;
  SIGNAL mux_tmp_92 : STD_LOGIC;
  SIGNAL and_dcpl_13 : STD_LOGIC;
  SIGNAL nor_tmp_34 : STD_LOGIC;
  SIGNAL not_tmp_77 : STD_LOGIC;
  SIGNAL and_dcpl_28 : STD_LOGIC;
  SIGNAL and_dcpl_29 : STD_LOGIC;
  SIGNAL and_dcpl_31 : STD_LOGIC;
  SIGNAL and_dcpl_32 : STD_LOGIC;
  SIGNAL and_dcpl_33 : STD_LOGIC;
  SIGNAL and_dcpl_38 : STD_LOGIC;
  SIGNAL and_dcpl_40 : STD_LOGIC;
  SIGNAL and_dcpl_41 : STD_LOGIC;
  SIGNAL and_dcpl_43 : STD_LOGIC;
  SIGNAL and_dcpl_44 : STD_LOGIC;
  SIGNAL and_dcpl_45 : STD_LOGIC;
  SIGNAL and_dcpl_46 : STD_LOGIC;
  SIGNAL and_dcpl_47 : STD_LOGIC;
  SIGNAL and_dcpl_48 : STD_LOGIC;
  SIGNAL and_dcpl_49 : STD_LOGIC;
  SIGNAL and_dcpl_51 : STD_LOGIC;
  SIGNAL and_dcpl_52 : STD_LOGIC;
  SIGNAL nor_tmp_40 : STD_LOGIC;
  SIGNAL not_tmp_91 : STD_LOGIC;
  SIGNAL mux_tmp_162 : STD_LOGIC;
  SIGNAL or_tmp_148 : STD_LOGIC;
  SIGNAL and_dcpl_60 : STD_LOGIC;
  SIGNAL and_dcpl_65 : STD_LOGIC;
  SIGNAL and_dcpl_66 : STD_LOGIC;
  SIGNAL and_dcpl_72 : STD_LOGIC;
  SIGNAL and_dcpl_73 : STD_LOGIC;
  SIGNAL and_dcpl_76 : STD_LOGIC;
  SIGNAL and_dcpl_82 : STD_LOGIC;
  SIGNAL and_dcpl_86 : STD_LOGIC;
  SIGNAL and_dcpl_87 : STD_LOGIC;
  SIGNAL not_tmp_108 : STD_LOGIC;
  SIGNAL or_tmp_264 : STD_LOGIC;
  SIGNAL or_tmp_278 : STD_LOGIC;
  SIGNAL or_tmp_321 : STD_LOGIC;
  SIGNAL or_tmp_334 : STD_LOGIC;
  SIGNAL or_tmp_374 : STD_LOGIC;
  SIGNAL or_tmp_387 : STD_LOGIC;
  SIGNAL and_dcpl_101 : STD_LOGIC;
  SIGNAL and_dcpl_102 : STD_LOGIC;
  SIGNAL and_dcpl_103 : STD_LOGIC;
  SIGNAL and_dcpl_104 : STD_LOGIC;
  SIGNAL mux_tmp_317 : STD_LOGIC;
  SIGNAL mux_tmp_318 : STD_LOGIC;
  SIGNAL or_tmp_404 : STD_LOGIC;
  SIGNAL mux_tmp_319 : STD_LOGIC;
  SIGNAL nor_tmp_63 : STD_LOGIC;
  SIGNAL nor_tmp_64 : STD_LOGIC;
  SIGNAL or_tmp_415 : STD_LOGIC;
  SIGNAL mux_tmp_325 : STD_LOGIC;
  SIGNAL mux_tmp_329 : STD_LOGIC;
  SIGNAL mux_tmp_335 : STD_LOGIC;
  SIGNAL mux_tmp_337 : STD_LOGIC;
  SIGNAL mux_tmp_338 : STD_LOGIC;
  SIGNAL mux_tmp_340 : STD_LOGIC;
  SIGNAL or_tmp_416 : STD_LOGIC;
  SIGNAL mux_tmp_345 : STD_LOGIC;
  SIGNAL mux_tmp_350 : STD_LOGIC;
  SIGNAL mux_tmp_373 : STD_LOGIC;
  SIGNAL or_tmp_421 : STD_LOGIC;
  SIGNAL or_tmp_423 : STD_LOGIC;
  SIGNAL or_tmp_426 : STD_LOGIC;
  SIGNAL mux_tmp_375 : STD_LOGIC;
  SIGNAL mux_tmp_378 : STD_LOGIC;
  SIGNAL mux_tmp_379 : STD_LOGIC;
  SIGNAL mux_tmp_380 : STD_LOGIC;
  SIGNAL mux_tmp_382 : STD_LOGIC;
  SIGNAL or_tmp_436 : STD_LOGIC;
  SIGNAL or_tmp_437 : STD_LOGIC;
  SIGNAL or_tmp_438 : STD_LOGIC;
  SIGNAL mux_tmp_393 : STD_LOGIC;
  SIGNAL not_tmp_170 : STD_LOGIC;
  SIGNAL mux_tmp_398 : STD_LOGIC;
  SIGNAL and_dcpl_105 : STD_LOGIC;
  SIGNAL and_dcpl_107 : STD_LOGIC;
  SIGNAL not_tmp_173 : STD_LOGIC;
  SIGNAL or_tmp_449 : STD_LOGIC;
  SIGNAL or_tmp_451 : STD_LOGIC;
  SIGNAL or_tmp_455 : STD_LOGIC;
  SIGNAL and_dcpl_108 : STD_LOGIC;
  SIGNAL and_dcpl_109 : STD_LOGIC;
  SIGNAL and_dcpl_110 : STD_LOGIC;
  SIGNAL mux_tmp_431 : STD_LOGIC;
  SIGNAL and_tmp_6 : STD_LOGIC;
  SIGNAL or_tmp_470 : STD_LOGIC;
  SIGNAL nand_tmp_42 : STD_LOGIC;
  SIGNAL and_dcpl_111 : STD_LOGIC;
  SIGNAL and_dcpl_117 : STD_LOGIC;
  SIGNAL or_tmp_476 : STD_LOGIC;
  SIGNAL and_tmp_7 : STD_LOGIC;
  SIGNAL and_dcpl_119 : STD_LOGIC;
  SIGNAL and_dcpl_123 : STD_LOGIC;
  SIGNAL or_tmp_483 : STD_LOGIC;
  SIGNAL mux_tmp_440 : STD_LOGIC;
  SIGNAL or_tmp_484 : STD_LOGIC;
  SIGNAL and_tmp_8 : STD_LOGIC;
  SIGNAL mux_tmp_448 : STD_LOGIC;
  SIGNAL mux_tmp_455 : STD_LOGIC;
  SIGNAL and_dcpl_129 : STD_LOGIC;
  SIGNAL and_dcpl_130 : STD_LOGIC;
  SIGNAL and_dcpl_134 : STD_LOGIC;
  SIGNAL mux_tmp_504 : STD_LOGIC;
  SIGNAL and_dcpl_138 : STD_LOGIC;
  SIGNAL nor_tmp_81 : STD_LOGIC;
  SIGNAL mux_tmp_506 : STD_LOGIC;
  SIGNAL nor_tmp_83 : STD_LOGIC;
  SIGNAL mux_tmp_509 : STD_LOGIC;
  SIGNAL or_tmp_539 : STD_LOGIC;
  SIGNAL nor_tmp_86 : STD_LOGIC;
  SIGNAL mux_tmp_522 : STD_LOGIC;
  SIGNAL or_tmp_548 : STD_LOGIC;
  SIGNAL mux_tmp_530 : STD_LOGIC;
  SIGNAL not_tmp_231 : STD_LOGIC;
  SIGNAL or_tmp_562 : STD_LOGIC;
  SIGNAL mux_tmp_537 : STD_LOGIC;
  SIGNAL or_tmp_567 : STD_LOGIC;
  SIGNAL mux_tmp_546 : STD_LOGIC;
  SIGNAL mux_tmp_549 : STD_LOGIC;
  SIGNAL or_tmp_573 : STD_LOGIC;
  SIGNAL and_dcpl_147 : STD_LOGIC;
  SIGNAL mux_tmp_579 : STD_LOGIC;
  SIGNAL and_dcpl_154 : STD_LOGIC;
  SIGNAL not_tmp_260 : STD_LOGIC;
  SIGNAL or_tmp_621 : STD_LOGIC;
  SIGNAL or_tmp_623 : STD_LOGIC;
  SIGNAL mux_tmp_588 : STD_LOGIC;
  SIGNAL mux_tmp_589 : STD_LOGIC;
  SIGNAL mux_tmp_594 : STD_LOGIC;
  SIGNAL mux_tmp_599 : STD_LOGIC;
  SIGNAL or_tmp_635 : STD_LOGIC;
  SIGNAL or_tmp_637 : STD_LOGIC;
  SIGNAL nor_tmp_103 : STD_LOGIC;
  SIGNAL mux_tmp_624 : STD_LOGIC;
  SIGNAL or_tmp_654 : STD_LOGIC;
  SIGNAL or_tmp_656 : STD_LOGIC;
  SIGNAL mux_tmp_637 : STD_LOGIC;
  SIGNAL or_tmp_670 : STD_LOGIC;
  SIGNAL mux_tmp_668 : STD_LOGIC;
  SIGNAL mux_tmp_711 : STD_LOGIC;
  SIGNAL mux_tmp_722 : STD_LOGIC;
  SIGNAL or_tmp_716 : STD_LOGIC;
  SIGNAL mux_tmp_723 : STD_LOGIC;
  SIGNAL and_tmp_14 : STD_LOGIC;
  SIGNAL and_dcpl_175 : STD_LOGIC;
  SIGNAL not_tmp_321 : STD_LOGIC;
  SIGNAL or_tmp_760 : STD_LOGIC;
  SIGNAL mux_tmp_760 : STD_LOGIC;
  SIGNAL or_tmp_762 : STD_LOGIC;
  SIGNAL or_tmp_769 : STD_LOGIC;
  SIGNAL mux_tmp_763 : STD_LOGIC;
  SIGNAL mux_tmp_771 : STD_LOGIC;
  SIGNAL and_dcpl_176 : STD_LOGIC;
  SIGNAL not_tmp_324 : STD_LOGIC;
  SIGNAL and_dcpl_179 : STD_LOGIC;
  SIGNAL mux_tmp_787 : STD_LOGIC;
  SIGNAL exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva : STD_LOGIC;
  SIGNAL VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm : STD_LOGIC;
  SIGNAL VEC_LOOP_j_1_12_0_sva_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_lshift_psp_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_5_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_2_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_11_psp_1_sva : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_10_cse_12_1_1_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_k_9_2_1_sva_6_0 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL tmp_10_lpi_4_dfm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL reg_VEC_LOOP_1_acc_1_psp_ftd_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL and_160_m1c : STD_LOGIC;
  SIGNAL and_163_m1c : STD_LOGIC;
  SIGNAL and_141_m1c : STD_LOGIC;
  SIGNAL nor_359_m1c : STD_LOGIC;
  SIGNAL nand_95_cse : STD_LOGIC;
  SIGNAL or_304_cse : STD_LOGIC;
  SIGNAL nor_269_cse : STD_LOGIC;
  SIGNAL or_315_cse : STD_LOGIC;
  SIGNAL and_270_cse : STD_LOGIC;
  SIGNAL reg_vec_rsc_triosy_0_3_obj_ld_cse : STD_LOGIC;
  SIGNAL nor_70_cse : STD_LOGIC;
  SIGNAL and_256_cse : STD_LOGIC;
  SIGNAL or_590_cse : STD_LOGIC;
  SIGNAL and_300_cse : STD_LOGIC;
  SIGNAL or_94_cse : STD_LOGIC;
  SIGNAL and_205_cse : STD_LOGIC;
  SIGNAL or_814_cse : STD_LOGIC;
  SIGNAL or_913_cse : STD_LOGIC;
  SIGNAL nor_236_cse : STD_LOGIC;
  SIGNAL or_596_cse : STD_LOGIC;
  SIGNAL or_369_cse : STD_LOGIC;
  SIGNAL nor_268_cse : STD_LOGIC;
  SIGNAL or_370_cse : STD_LOGIC;
  SIGNAL nor_241_cse : STD_LOGIC;
  SIGNAL and_303_cse : STD_LOGIC;
  SIGNAL or_756_cse : STD_LOGIC;
  SIGNAL nand_119_cse : STD_LOGIC;
  SIGNAL or_55_cse : STD_LOGIC;
  SIGNAL or_826_cse : STD_LOGIC;
  SIGNAL or_899_cse : STD_LOGIC;
  SIGNAL and_213_cse : STD_LOGIC;
  SIGNAL nor_330_cse : STD_LOGIC;
  SIGNAL or_154_cse : STD_LOGIC;
  SIGNAL or_54_cse : STD_LOGIC;
  SIGNAL nor_312_cse : STD_LOGIC;
  SIGNAL mux_190_cse : STD_LOGIC;
  SIGNAL mux_189_cse : STD_LOGIC;
  SIGNAL mux_186_cse : STD_LOGIC;
  SIGNAL mux_561_cse : STD_LOGIC;
  SIGNAL mux_560_cse : STD_LOGIC;
  SIGNAL mux_749_cse : STD_LOGIC;
  SIGNAL modExp_result_and_rgt : STD_LOGIC;
  SIGNAL modExp_result_and_1_rgt : STD_LOGIC;
  SIGNAL mux_258_cse : STD_LOGIC;
  SIGNAL mux_748_cse : STD_LOGIC;
  SIGNAL mux_745_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_psp_1_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL modExp_base_1_sva_mx1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_while_and_3 : STD_LOGIC;
  SIGNAL modExp_while_and_5 : STD_LOGIC;
  SIGNAL mux_423_itm : STD_LOGIC;
  SIGNAL mux_433_itm : STD_LOGIC;
  SIGNAL mux_801_itm : STD_LOGIC;
  SIGNAL and_dcpl_196 : STD_LOGIC;
  SIGNAL or_tmp_841 : STD_LOGIC;
  SIGNAL mux_tmp_824 : STD_LOGIC;
  SIGNAL and_dcpl_199 : STD_LOGIC;
  SIGNAL and_dcpl_200 : STD_LOGIC;
  SIGNAL and_dcpl_204 : STD_LOGIC;
  SIGNAL and_dcpl_208 : STD_LOGIC;
  SIGNAL and_dcpl_215 : STD_LOGIC;
  SIGNAL and_dcpl_221 : STD_LOGIC;
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_dcpl_230 : STD_LOGIC;
  SIGNAL and_dcpl_242 : STD_LOGIC;
  SIGNAL and_dcpl_244 : STD_LOGIC;
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL and_dcpl_253 : STD_LOGIC;
  SIGNAL z_out_3 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL or_tmp_858 : STD_LOGIC;
  SIGNAL mux_tmp_833 : STD_LOGIC;
  SIGNAL and_dcpl_283 : STD_LOGIC;
  SIGNAL and_dcpl_288 : STD_LOGIC;
  SIGNAL and_dcpl_292 : STD_LOGIC;
  SIGNAL and_dcpl_302 : STD_LOGIC;
  SIGNAL and_dcpl_310 : STD_LOGIC;
  SIGNAL z_out_5 : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL and_dcpl_314 : STD_LOGIC;
  SIGNAL and_dcpl_315 : STD_LOGIC;
  SIGNAL and_dcpl_316 : STD_LOGIC;
  SIGNAL and_dcpl_319 : STD_LOGIC;
  SIGNAL not_tmp_415 : STD_LOGIC;
  SIGNAL mux_tmp_843 : STD_LOGIC;
  SIGNAL mux_tmp_844 : STD_LOGIC;
  SIGNAL mux_tmp_845 : STD_LOGIC;
  SIGNAL mux_tmp_849 : STD_LOGIC;
  SIGNAL and_dcpl_321 : STD_LOGIC;
  SIGNAL and_dcpl_323 : STD_LOGIC;
  SIGNAL and_dcpl_325 : STD_LOGIC;
  SIGNAL and_dcpl_326 : STD_LOGIC;
  SIGNAL and_dcpl_327 : STD_LOGIC;
  SIGNAL and_dcpl_331 : STD_LOGIC;
  SIGNAL and_dcpl_333 : STD_LOGIC;
  SIGNAL and_dcpl_334 : STD_LOGIC;
  SIGNAL and_dcpl_338 : STD_LOGIC;
  SIGNAL and_dcpl_339 : STD_LOGIC;
  SIGNAL and_dcpl_342 : STD_LOGIC;
  SIGNAL and_dcpl_343 : STD_LOGIC;
  SIGNAL and_dcpl_345 : STD_LOGIC;
  SIGNAL and_dcpl_346 : STD_LOGIC;
  SIGNAL and_dcpl_349 : STD_LOGIC;
  SIGNAL and_dcpl_351 : STD_LOGIC;
  SIGNAL and_dcpl_352 : STD_LOGIC;
  SIGNAL and_dcpl_354 : STD_LOGIC;
  SIGNAL and_dcpl_356 : STD_LOGIC;
  SIGNAL and_dcpl_357 : STD_LOGIC;
  SIGNAL and_dcpl_361 : STD_LOGIC;
  SIGNAL and_dcpl_367 : STD_LOGIC;
  SIGNAL z_out_6 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL mux_tmp_860 : STD_LOGIC;
  SIGNAL or_tmp_890 : STD_LOGIC;
  SIGNAL mux_tmp_866 : STD_LOGIC;
  SIGNAL z_out_7 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL r_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL modExp_result_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_exp_1_7_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_6_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_5_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_4_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_3_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_2_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_1_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_0_1_sva_1 : STD_LOGIC;
  SIGNAL modExp_base_1_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL VEC_LOOP_1_COMP_LOOP_1_acc_8_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva_mx0c1 : STD_LOGIC;
  SIGNAL STAGE_LOOP_lshift_psp_sva_mx0w0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL VEC_LOOP_j_1_12_0_sva_11_0_mx0c1 : STD_LOGIC;
  SIGNAL modExp_result_sva_mx0c0 : STD_LOGIC;
  SIGNAL operator_64_false_slc_modExp_exp_63_1_3 : STD_LOGIC_VECTOR (62 DOWNTO 0);
  SIGNAL COMP_LOOP_or_1_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_or_3_cse : STD_LOGIC;
  SIGNAL or_254_cse : STD_LOGIC;
  SIGNAL or_614_cse : STD_LOGIC;
  SIGNAL or_611_cse : STD_LOGIC;
  SIGNAL mux_680_cse : STD_LOGIC;
  SIGNAL nor_332_cse : STD_LOGIC;
  SIGNAL STAGE_LOOP_or_ssc : STD_LOGIC;
  SIGNAL and_365_cse : STD_LOGIC;
  SIGNAL and_392_cse : STD_LOGIC;
  SIGNAL mux_165_cse : STD_LOGIC;
  SIGNAL mux_163_cse : STD_LOGIC;
  SIGNAL or_tmp_911 : STD_LOGIC;
  SIGNAL mux_tmp_877 : STD_LOGIC;
  SIGNAL or_tmp_917 : STD_LOGIC;
  SIGNAL or_tmp_923 : STD_LOGIC;
  SIGNAL mux_tmp_886 : STD_LOGIC;
  SIGNAL or_tmp_942 : STD_LOGIC;
  SIGNAL mux_tmp_907 : STD_LOGIC;
  SIGNAL mux_tmp_910 : STD_LOGIC;
  SIGNAL or_tmp_948 : STD_LOGIC;
  SIGNAL or_tmp_949 : STD_LOGIC;
  SIGNAL or_tmp_952 : STD_LOGIC;
  SIGNAL mux_tmp_915 : STD_LOGIC;
  SIGNAL or_tmp_953 : STD_LOGIC;
  SIGNAL mux_tmp_916 : STD_LOGIC;
  SIGNAL mux_tmp_919 : STD_LOGIC;
  SIGNAL mux_tmp_921 : STD_LOGIC;
  SIGNAL or_tmp_960 : STD_LOGIC;
  SIGNAL operator_64_false_mux1h_2_rgt : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL or_tmp_971 : STD_LOGIC;
  SIGNAL operator_64_false_acc_mut_64 : STD_LOGIC;
  SIGNAL operator_64_false_acc_mut_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_524_cse : STD_LOGIC;
  SIGNAL or_1038_cse : STD_LOGIC;
  SIGNAL or_1047_cse : STD_LOGIC;
  SIGNAL or_462_cse : STD_LOGIC;
  SIGNAL mux_894_cse : STD_LOGIC;
  SIGNAL mux_860_itm : STD_LOGIC;
  SIGNAL mux_866_itm : STD_LOGIC;
  SIGNAL operator_64_false_1_or_2_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_or_27_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_nor_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_nor_53_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_or_1_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_or_2_itm : STD_LOGIC;
  SIGNAL mux_826_cse : STD_LOGIC;

  SIGNAL mux_188_nl : STD_LOGIC;
  SIGNAL mux_187_nl : STD_LOGIC;
  SIGNAL or_237_nl : STD_LOGIC;
  SIGNAL or_236_nl : STD_LOGIC;
  SIGNAL mux_185_nl : STD_LOGIC;
  SIGNAL mux_184_nl : STD_LOGIC;
  SIGNAL or_231_nl : STD_LOGIC;
  SIGNAL or_228_nl : STD_LOGIC;
  SIGNAL nand_12_nl : STD_LOGIC;
  SIGNAL or_234_nl : STD_LOGIC;
  SIGNAL and_275_nl : STD_LOGIC;
  SIGNAL nor_260_nl : STD_LOGIC;
  SIGNAL modulo_result_or_nl : STD_LOGIC;
  SIGNAL mux_372_nl : STD_LOGIC;
  SIGNAL mux_371_nl : STD_LOGIC;
  SIGNAL mux_370_nl : STD_LOGIC;
  SIGNAL mux_369_nl : STD_LOGIC;
  SIGNAL mux_368_nl : STD_LOGIC;
  SIGNAL mux_367_nl : STD_LOGIC;
  SIGNAL mux_366_nl : STD_LOGIC;
  SIGNAL or_452_nl : STD_LOGIC;
  SIGNAL mux_365_nl : STD_LOGIC;
  SIGNAL mux_364_nl : STD_LOGIC;
  SIGNAL mux_363_nl : STD_LOGIC;
  SIGNAL mux_362_nl : STD_LOGIC;
  SIGNAL mux_361_nl : STD_LOGIC;
  SIGNAL mux_360_nl : STD_LOGIC;
  SIGNAL mux_359_nl : STD_LOGIC;
  SIGNAL mux_358_nl : STD_LOGIC;
  SIGNAL mux_357_nl : STD_LOGIC;
  SIGNAL mux_356_nl : STD_LOGIC;
  SIGNAL mux_355_nl : STD_LOGIC;
  SIGNAL mux_354_nl : STD_LOGIC;
  SIGNAL mux_353_nl : STD_LOGIC;
  SIGNAL mux_352_nl : STD_LOGIC;
  SIGNAL mux_351_nl : STD_LOGIC;
  SIGNAL mux_349_nl : STD_LOGIC;
  SIGNAL mux_348_nl : STD_LOGIC;
  SIGNAL mux_347_nl : STD_LOGIC;
  SIGNAL mux_346_nl : STD_LOGIC;
  SIGNAL mux_344_nl : STD_LOGIC;
  SIGNAL mux_343_nl : STD_LOGIC;
  SIGNAL mux_342_nl : STD_LOGIC;
  SIGNAL mux_341_nl : STD_LOGIC;
  SIGNAL mux_339_nl : STD_LOGIC;
  SIGNAL mux_322_nl : STD_LOGIC;
  SIGNAL nor_237_nl : STD_LOGIC;
  SIGNAL mux_321_nl : STD_LOGIC;
  SIGNAL or_446_nl : STD_LOGIC;
  SIGNAL or_443_nl : STD_LOGIC;
  SIGNAL nor_239_nl : STD_LOGIC;
  SIGNAL mux_320_nl : STD_LOGIC;
  SIGNAL or_439_nl : STD_LOGIC;
  SIGNAL or_436_nl : STD_LOGIC;
  SIGNAL mux_415_nl : STD_LOGIC;
  SIGNAL mux_414_nl : STD_LOGIC;
  SIGNAL mux_413_nl : STD_LOGIC;
  SIGNAL mux_412_nl : STD_LOGIC;
  SIGNAL mux_411_nl : STD_LOGIC;
  SIGNAL mux_410_nl : STD_LOGIC;
  SIGNAL mux_409_nl : STD_LOGIC;
  SIGNAL mux_408_nl : STD_LOGIC;
  SIGNAL mux_407_nl : STD_LOGIC;
  SIGNAL mux_406_nl : STD_LOGIC;
  SIGNAL mux_405_nl : STD_LOGIC;
  SIGNAL mux_404_nl : STD_LOGIC;
  SIGNAL mux_403_nl : STD_LOGIC;
  SIGNAL or_477_nl : STD_LOGIC;
  SIGNAL mux_402_nl : STD_LOGIC;
  SIGNAL mux_401_nl : STD_LOGIC;
  SIGNAL mux_400_nl : STD_LOGIC;
  SIGNAL mux_399_nl : STD_LOGIC;
  SIGNAL mux_394_nl : STD_LOGIC;
  SIGNAL or_474_nl : STD_LOGIC;
  SIGNAL mux_392_nl : STD_LOGIC;
  SIGNAL mux_391_nl : STD_LOGIC;
  SIGNAL mux_390_nl : STD_LOGIC;
  SIGNAL mux_389_nl : STD_LOGIC;
  SIGNAL mux_388_nl : STD_LOGIC;
  SIGNAL mux_387_nl : STD_LOGIC;
  SIGNAL mux_386_nl : STD_LOGIC;
  SIGNAL mux_385_nl : STD_LOGIC;
  SIGNAL mux_384_nl : STD_LOGIC;
  SIGNAL or_469_nl : STD_LOGIC;
  SIGNAL mux_383_nl : STD_LOGIC;
  SIGNAL mux_436_nl : STD_LOGIC;
  SIGNAL nor_228_nl : STD_LOGIC;
  SIGNAL mux1h_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL or_994_nl : STD_LOGIC;
  SIGNAL mux_672_nl : STD_LOGIC;
  SIGNAL nor_178_nl : STD_LOGIC;
  SIGNAL mux_671_nl : STD_LOGIC;
  SIGNAL mux_670_nl : STD_LOGIC;
  SIGNAL or_709_nl : STD_LOGIC;
  SIGNAL and_225_nl : STD_LOGIC;
  SIGNAL mux_669_nl : STD_LOGIC;
  SIGNAL mux_667_nl : STD_LOGIC;
  SIGNAL or_705_nl : STD_LOGIC;
  SIGNAL or_703_nl : STD_LOGIC;
  SIGNAL mux_950_nl : STD_LOGIC;
  SIGNAL mux_664_nl : STD_LOGIC;
  SIGNAL mux_661_nl : STD_LOGIC;
  SIGNAL mux_660_nl : STD_LOGIC;
  SIGNAL mux_659_nl : STD_LOGIC;
  SIGNAL mux_658_nl : STD_LOGIC;
  SIGNAL or_702_nl : STD_LOGIC;
  SIGNAL mux_657_nl : STD_LOGIC;
  SIGNAL mux_656_nl : STD_LOGIC;
  SIGNAL or_701_nl : STD_LOGIC;
  SIGNAL mux_650_nl : STD_LOGIC;
  SIGNAL mux_649_nl : STD_LOGIC;
  SIGNAL or_699_nl : STD_LOGIC;
  SIGNAL mux_648_nl : STD_LOGIC;
  SIGNAL mux_647_nl : STD_LOGIC;
  SIGNAL mux_639_nl : STD_LOGIC;
  SIGNAL mux_638_nl : STD_LOGIC;
  SIGNAL or_695_nl : STD_LOGIC;
  SIGNAL mux_628_nl : STD_LOGIC;
  SIGNAL mux_627_nl : STD_LOGIC;
  SIGNAL mux_626_nl : STD_LOGIC;
  SIGNAL mux_625_nl : STD_LOGIC;
  SIGNAL modExp_while_if_and_1_nl : STD_LOGIC;
  SIGNAL modExp_while_if_and_2_nl : STD_LOGIC;
  SIGNAL and_126_nl : STD_LOGIC;
  SIGNAL mux_463_nl : STD_LOGIC;
  SIGNAL mux_462_nl : STD_LOGIC;
  SIGNAL mux_461_nl : STD_LOGIC;
  SIGNAL mux_460_nl : STD_LOGIC;
  SIGNAL nor_222_nl : STD_LOGIC;
  SIGNAL mux_459_nl : STD_LOGIC;
  SIGNAL mux_458_nl : STD_LOGIC;
  SIGNAL mux_457_nl : STD_LOGIC;
  SIGNAL or_533_nl : STD_LOGIC;
  SIGNAL mux_456_nl : STD_LOGIC;
  SIGNAL nor_223_nl : STD_LOGIC;
  SIGNAL mux_454_nl : STD_LOGIC;
  SIGNAL nor_224_nl : STD_LOGIC;
  SIGNAL mux_453_nl : STD_LOGIC;
  SIGNAL mux_452_nl : STD_LOGIC;
  SIGNAL mux_451_nl : STD_LOGIC;
  SIGNAL mux_450_nl : STD_LOGIC;
  SIGNAL nor_225_nl : STD_LOGIC;
  SIGNAL or_527_nl : STD_LOGIC;
  SIGNAL mux_449_nl : STD_LOGIC;
  SIGNAL mux_446_nl : STD_LOGIC;
  SIGNAL mux_445_nl : STD_LOGIC;
  SIGNAL or_526_nl : STD_LOGIC;
  SIGNAL mux_444_nl : STD_LOGIC;
  SIGNAL mux_443_nl : STD_LOGIC;
  SIGNAL or_524_nl : STD_LOGIC;
  SIGNAL or_523_nl : STD_LOGIC;
  SIGNAL or_522_nl : STD_LOGIC;
  SIGNAL mux_442_nl : STD_LOGIC;
  SIGNAL or_520_nl : STD_LOGIC;
  SIGNAL mux_441_nl : STD_LOGIC;
  SIGNAL or_519_nl : STD_LOGIC;
  SIGNAL or_1035_nl : STD_LOGIC;
  SIGNAL mux_908_nl : STD_LOGIC;
  SIGNAL mux_907_nl : STD_LOGIC;
  SIGNAL mux_906_nl : STD_LOGIC;
  SIGNAL mux_905_nl : STD_LOGIC;
  SIGNAL mux_904_nl : STD_LOGIC;
  SIGNAL mux_903_nl : STD_LOGIC;
  SIGNAL mux_902_nl : STD_LOGIC;
  SIGNAL mux_901_nl : STD_LOGIC;
  SIGNAL mux_900_nl : STD_LOGIC;
  SIGNAL or_1037_nl : STD_LOGIC;
  SIGNAL mux_899_nl : STD_LOGIC;
  SIGNAL or_1036_nl : STD_LOGIC;
  SIGNAL mux_898_nl : STD_LOGIC;
  SIGNAL mux_897_nl : STD_LOGIC;
  SIGNAL mux_896_nl : STD_LOGIC;
  SIGNAL mux_895_nl : STD_LOGIC;
  SIGNAL nor_429_nl : STD_LOGIC;
  SIGNAL mux_893_nl : STD_LOGIC;
  SIGNAL mux_892_nl : STD_LOGIC;
  SIGNAL mux_891_nl : STD_LOGIC;
  SIGNAL mux_890_nl : STD_LOGIC;
  SIGNAL mux_889_nl : STD_LOGIC;
  SIGNAL mux_887_nl : STD_LOGIC;
  SIGNAL mux_886_nl : STD_LOGIC;
  SIGNAL and_525_nl : STD_LOGIC;
  SIGNAL or_1032_nl : STD_LOGIC;
  SIGNAL or_1028_nl : STD_LOGIC;
  SIGNAL mux_885_nl : STD_LOGIC;
  SIGNAL mux_884_nl : STD_LOGIC;
  SIGNAL or_1025_nl : STD_LOGIC;
  SIGNAL mux_883_nl : STD_LOGIC;
  SIGNAL mux_882_nl : STD_LOGIC;
  SIGNAL or_1021_nl : STD_LOGIC;
  SIGNAL or_1018_nl : STD_LOGIC;
  SIGNAL mux_881_nl : STD_LOGIC;
  SIGNAL mux_880_nl : STD_LOGIC;
  SIGNAL or_1011_nl : STD_LOGIC;
  SIGNAL mux_944_nl : STD_LOGIC;
  SIGNAL mux_943_nl : STD_LOGIC;
  SIGNAL mux_942_nl : STD_LOGIC;
  SIGNAL mux_941_nl : STD_LOGIC;
  SIGNAL mux_940_nl : STD_LOGIC;
  SIGNAL mux_939_nl : STD_LOGIC;
  SIGNAL or_1063_nl : STD_LOGIC;
  SIGNAL mux_938_nl : STD_LOGIC;
  SIGNAL nand_nl : STD_LOGIC;
  SIGNAL or_1061_nl : STD_LOGIC;
  SIGNAL mux_937_nl : STD_LOGIC;
  SIGNAL mux_936_nl : STD_LOGIC;
  SIGNAL mux_935_nl : STD_LOGIC;
  SIGNAL or_1059_nl : STD_LOGIC;
  SIGNAL mux_934_nl : STD_LOGIC;
  SIGNAL mux_933_nl : STD_LOGIC;
  SIGNAL mux_932_nl : STD_LOGIC;
  SIGNAL mux_931_nl : STD_LOGIC;
  SIGNAL mux_930_nl : STD_LOGIC;
  SIGNAL or_1055_nl : STD_LOGIC;
  SIGNAL mux_929_nl : STD_LOGIC;
  SIGNAL nand_145_nl : STD_LOGIC;
  SIGNAL mux_928_nl : STD_LOGIC;
  SIGNAL or_1054_nl : STD_LOGIC;
  SIGNAL mux_927_nl : STD_LOGIC;
  SIGNAL mux_926_nl : STD_LOGIC;
  SIGNAL mux_925_nl : STD_LOGIC;
  SIGNAL mux_924_nl : STD_LOGIC;
  SIGNAL mux_922_nl : STD_LOGIC;
  SIGNAL or_1052_nl : STD_LOGIC;
  SIGNAL mux_920_nl : STD_LOGIC;
  SIGNAL mux_919_nl : STD_LOGIC;
  SIGNAL or_1051_nl : STD_LOGIC;
  SIGNAL mux_915_nl : STD_LOGIC;
  SIGNAL mux_914_nl : STD_LOGIC;
  SIGNAL mux_913_nl : STD_LOGIC;
  SIGNAL or_1042_nl : STD_LOGIC;
  SIGNAL mux_911_nl : STD_LOGIC;
  SIGNAL mux_910_nl : STD_LOGIC;
  SIGNAL or_1041_nl : STD_LOGIC;
  SIGNAL or_992_nl : STD_LOGIC;
  SIGNAL mux_478_nl : STD_LOGIC;
  SIGNAL nand_117_nl : STD_LOGIC;
  SIGNAL or_912_nl : STD_LOGIC;
  SIGNAL mux_477_nl : STD_LOGIC;
  SIGNAL mux_476_nl : STD_LOGIC;
  SIGNAL or_548_nl : STD_LOGIC;
  SIGNAL nand_85_nl : STD_LOGIC;
  SIGNAL or_546_nl : STD_LOGIC;
  SIGNAL mux_949_nl : STD_LOGIC;
  SIGNAL mux_948_nl : STD_LOGIC;
  SIGNAL mux_947_nl : STD_LOGIC;
  SIGNAL or_1069_nl : STD_LOGIC;
  SIGNAL mux_946_nl : STD_LOGIC;
  SIGNAL or_1067_nl : STD_LOGIC;
  SIGNAL nand_143_nl : STD_LOGIC;
  SIGNAL mux_945_nl : STD_LOGIC;
  SIGNAL nor_434_nl : STD_LOGIC;
  SIGNAL nor_435_nl : STD_LOGIC;
  SIGNAL mux_500_nl : STD_LOGIC;
  SIGNAL or_897_nl : STD_LOGIC;
  SIGNAL mux_499_nl : STD_LOGIC;
  SIGNAL or_563_nl : STD_LOGIC;
  SIGNAL or_562_nl : STD_LOGIC;
  SIGNAL mux_498_nl : STD_LOGIC;
  SIGNAL nor_216_nl : STD_LOGIC;
  SIGNAL and_144_nl : STD_LOGIC;
  SIGNAL r_or_nl : STD_LOGIC;
  SIGNAL r_or_1_nl : STD_LOGIC;
  SIGNAL mux_529_nl : STD_LOGIC;
  SIGNAL mux_528_nl : STD_LOGIC;
  SIGNAL mux_527_nl : STD_LOGIC;
  SIGNAL mux_526_nl : STD_LOGIC;
  SIGNAL and_240_nl : STD_LOGIC;
  SIGNAL mux_525_nl : STD_LOGIC;
  SIGNAL mux_524_nl : STD_LOGIC;
  SIGNAL mux_523_nl : STD_LOGIC;
  SIGNAL mux_521_nl : STD_LOGIC;
  SIGNAL mux_520_nl : STD_LOGIC;
  SIGNAL mux_519_nl : STD_LOGIC;
  SIGNAL nor_209_nl : STD_LOGIC;
  SIGNAL and_149_nl : STD_LOGIC;
  SIGNAL mux_518_nl : STD_LOGIC;
  SIGNAL mux_517_nl : STD_LOGIC;
  SIGNAL mux_516_nl : STD_LOGIC;
  SIGNAL mux_515_nl : STD_LOGIC;
  SIGNAL or_581_nl : STD_LOGIC;
  SIGNAL mux_514_nl : STD_LOGIC;
  SIGNAL or_579_nl : STD_LOGIC;
  SIGNAL mux_513_nl : STD_LOGIC;
  SIGNAL or_577_nl : STD_LOGIC;
  SIGNAL mux_512_nl : STD_LOGIC;
  SIGNAL and_148_nl : STD_LOGIC;
  SIGNAL mux_511_nl : STD_LOGIC;
  SIGNAL mux_510_nl : STD_LOGIC;
  SIGNAL mux_507_nl : STD_LOGIC;
  SIGNAL nor_325_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_6_nl : STD_LOGIC;
  SIGNAL mux_563_nl : STD_LOGIC;
  SIGNAL and_235_nl : STD_LOGIC;
  SIGNAL mux_562_nl : STD_LOGIC;
  SIGNAL nor_203_nl : STD_LOGIC;
  SIGNAL nor_204_nl : STD_LOGIC;
  SIGNAL nor_205_nl : STD_LOGIC;
  SIGNAL mux_559_nl : STD_LOGIC;
  SIGNAL or_607_nl : STD_LOGIC;
  SIGNAL or_606_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_7_nl : STD_LOGIC;
  SIGNAL mux_568_nl : STD_LOGIC;
  SIGNAL and_234_nl : STD_LOGIC;
  SIGNAL mux_567_nl : STD_LOGIC;
  SIGNAL nor_200_nl : STD_LOGIC;
  SIGNAL nor_201_nl : STD_LOGIC;
  SIGNAL nor_202_nl : STD_LOGIC;
  SIGNAL mux_564_nl : STD_LOGIC;
  SIGNAL or_618_nl : STD_LOGIC;
  SIGNAL or_617_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_8_nl : STD_LOGIC;
  SIGNAL mux_573_nl : STD_LOGIC;
  SIGNAL and_233_nl : STD_LOGIC;
  SIGNAL mux_572_nl : STD_LOGIC;
  SIGNAL nor_197_nl : STD_LOGIC;
  SIGNAL nor_198_nl : STD_LOGIC;
  SIGNAL nor_199_nl : STD_LOGIC;
  SIGNAL mux_569_nl : STD_LOGIC;
  SIGNAL or_629_nl : STD_LOGIC;
  SIGNAL or_628_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_9_nl : STD_LOGIC;
  SIGNAL mux_578_nl : STD_LOGIC;
  SIGNAL and_230_nl : STD_LOGIC;
  SIGNAL mux_577_nl : STD_LOGIC;
  SIGNAL and_231_nl : STD_LOGIC;
  SIGNAL and_232_nl : STD_LOGIC;
  SIGNAL nor_196_nl : STD_LOGIC;
  SIGNAL mux_574_nl : STD_LOGIC;
  SIGNAL or_636_nl : STD_LOGIC;
  SIGNAL or_635_nl : STD_LOGIC;
  SIGNAL mux_557_nl : STD_LOGIC;
  SIGNAL mux_556_nl : STD_LOGIC;
  SIGNAL mux_555_nl : STD_LOGIC;
  SIGNAL mux_554_nl : STD_LOGIC;
  SIGNAL mux_553_nl : STD_LOGIC;
  SIGNAL mux_552_nl : STD_LOGIC;
  SIGNAL mux_551_nl : STD_LOGIC;
  SIGNAL mux_550_nl : STD_LOGIC;
  SIGNAL mux_548_nl : STD_LOGIC;
  SIGNAL mux_547_nl : STD_LOGIC;
  SIGNAL mux_545_nl : STD_LOGIC;
  SIGNAL mux_544_nl : STD_LOGIC;
  SIGNAL mux_543_nl : STD_LOGIC;
  SIGNAL mux_542_nl : STD_LOGIC;
  SIGNAL mux_541_nl : STD_LOGIC;
  SIGNAL mux_540_nl : STD_LOGIC;
  SIGNAL mux_539_nl : STD_LOGIC;
  SIGNAL or_603_nl : STD_LOGIC;
  SIGNAL or_601_nl : STD_LOGIC;
  SIGNAL mux_538_nl : STD_LOGIC;
  SIGNAL mux_536_nl : STD_LOGIC;
  SIGNAL or_598_nl : STD_LOGIC;
  SIGNAL or_1002_nl : STD_LOGIC;
  SIGNAL mux_535_nl : STD_LOGIC;
  SIGNAL or_594_nl : STD_LOGIC;
  SIGNAL mux_534_nl : STD_LOGIC;
  SIGNAL or_593_nl : STD_LOGIC;
  SIGNAL or_592_nl : STD_LOGIC;
  SIGNAL or_591_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_15_nl : STD_LOGIC;
  SIGNAL acc_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL operator_64_false_1_mux_3_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL operator_64_false_1_or_5_nl : STD_LOGIC;
  SIGNAL mux_952_nl : STD_LOGIC;
  SIGNAL nor_456_nl : STD_LOGIC;
  SIGNAL and_531_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_4_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL COMP_LOOP_and_11_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_11_nl : STD_LOGIC;
  SIGNAL mux_616_nl : STD_LOGIC;
  SIGNAL nor_184_nl : STD_LOGIC;
  SIGNAL nor_185_nl : STD_LOGIC;
  SIGNAL mux_615_nl : STD_LOGIC;
  SIGNAL mux_614_nl : STD_LOGIC;
  SIGNAL mux_613_nl : STD_LOGIC;
  SIGNAL mux_612_nl : STD_LOGIC;
  SIGNAL mux_611_nl : STD_LOGIC;
  SIGNAL mux_610_nl : STD_LOGIC;
  SIGNAL mux_609_nl : STD_LOGIC;
  SIGNAL mux_608_nl : STD_LOGIC;
  SIGNAL or_673_nl : STD_LOGIC;
  SIGNAL mux_607_nl : STD_LOGIC;
  SIGNAL mux_606_nl : STD_LOGIC;
  SIGNAL mux_605_nl : STD_LOGIC;
  SIGNAL mux_604_nl : STD_LOGIC;
  SIGNAL mux_603_nl : STD_LOGIC;
  SIGNAL or_671_nl : STD_LOGIC;
  SIGNAL mux_602_nl : STD_LOGIC;
  SIGNAL mux_601_nl : STD_LOGIC;
  SIGNAL mux_600_nl : STD_LOGIC;
  SIGNAL mux_597_nl : STD_LOGIC;
  SIGNAL mux_596_nl : STD_LOGIC;
  SIGNAL mux_595_nl : STD_LOGIC;
  SIGNAL or_665_nl : STD_LOGIC;
  SIGNAL mux_593_nl : STD_LOGIC;
  SIGNAL or_71_nl : STD_LOGIC;
  SIGNAL mux_592_nl : STD_LOGIC;
  SIGNAL mux_591_nl : STD_LOGIC;
  SIGNAL or_662_nl : STD_LOGIC;
  SIGNAL nand_55_nl : STD_LOGIC;
  SIGNAL mux_590_nl : STD_LOGIC;
  SIGNAL or_661_nl : STD_LOGIC;
  SIGNAL nor_186_nl : STD_LOGIC;
  SIGNAL mux_587_nl : STD_LOGIC;
  SIGNAL or_656_nl : STD_LOGIC;
  SIGNAL or_655_nl : STD_LOGIC;
  SIGNAL VEC_LOOP_1_COMP_LOOP_1_acc_11_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_221_nl : STD_LOGIC;
  SIGNAL nor_174_nl : STD_LOGIC;
  SIGNAL VEC_LOOP_1_COMP_LOOP_1_acc_8_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL mux_682_nl : STD_LOGIC;
  SIGNAL nor_173_nl : STD_LOGIC;
  SIGNAL mux_681_nl : STD_LOGIC;
  SIGNAL or_721_nl : STD_LOGIC;
  SIGNAL nand_58_nl : STD_LOGIC;
  SIGNAL mux_679_nl : STD_LOGIC;
  SIGNAL and_222_nl : STD_LOGIC;
  SIGNAL mux_678_nl : STD_LOGIC;
  SIGNAL nor_175_nl : STD_LOGIC;
  SIGNAL and_223_nl : STD_LOGIC;
  SIGNAL and_224_nl : STD_LOGIC;
  SIGNAL mux_677_nl : STD_LOGIC;
  SIGNAL nor_176_nl : STD_LOGIC;
  SIGNAL nor_177_nl : STD_LOGIC;
  SIGNAL mux_709_nl : STD_LOGIC;
  SIGNAL mux_89_nl : STD_LOGIC;
  SIGNAL mux_88_nl : STD_LOGIC;
  SIGNAL mux_87_nl : STD_LOGIC;
  SIGNAL mux_85_nl : STD_LOGIC;
  SIGNAL and_297_nl : STD_LOGIC;
  SIGNAL mux_702_nl : STD_LOGIC;
  SIGNAL mux_701_nl : STD_LOGIC;
  SIGNAL mux_700_nl : STD_LOGIC;
  SIGNAL mux_699_nl : STD_LOGIC;
  SIGNAL mux_79_nl : STD_LOGIC;
  SIGNAL mux_78_nl : STD_LOGIC;
  SIGNAL or_93_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux_42_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL mux_721_nl : STD_LOGIC;
  SIGNAL mux_720_nl : STD_LOGIC;
  SIGNAL mux_719_nl : STD_LOGIC;
  SIGNAL mux_718_nl : STD_LOGIC;
  SIGNAL mux_717_nl : STD_LOGIC;
  SIGNAL mux_716_nl : STD_LOGIC;
  SIGNAL or_758_nl : STD_LOGIC;
  SIGNAL mux_715_nl : STD_LOGIC;
  SIGNAL mux_714_nl : STD_LOGIC;
  SIGNAL mux_713_nl : STD_LOGIC;
  SIGNAL or_757_nl : STD_LOGIC;
  SIGNAL mux_712_nl : STD_LOGIC;
  SIGNAL and_217_nl : STD_LOGIC;
  SIGNAL mux_731_nl : STD_LOGIC;
  SIGNAL nor_171_nl : STD_LOGIC;
  SIGNAL mux_730_nl : STD_LOGIC;
  SIGNAL or_763_nl : STD_LOGIC;
  SIGNAL or_762_nl : STD_LOGIC;
  SIGNAL or_761_nl : STD_LOGIC;
  SIGNAL mux_729_nl : STD_LOGIC;
  SIGNAL mux_728_nl : STD_LOGIC;
  SIGNAL mux_727_nl : STD_LOGIC;
  SIGNAL mux_726_nl : STD_LOGIC;
  SIGNAL mux_725_nl : STD_LOGIC;
  SIGNAL mux_724_nl : STD_LOGIC;
  SIGNAL or_787_nl : STD_LOGIC;
  SIGNAL mux_747_nl : STD_LOGIC;
  SIGNAL mux_746_nl : STD_LOGIC;
  SIGNAL or_786_nl : STD_LOGIC;
  SIGNAL or_785_nl : STD_LOGIC;
  SIGNAL or_780_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux_39_nl : STD_LOGIC;
  SIGNAL mux_751_nl : STD_LOGIC;
  SIGNAL mux_750_nl : STD_LOGIC;
  SIGNAL or_890_nl : STD_LOGIC;
  SIGNAL mux_732_nl : STD_LOGIC;
  SIGNAL and_212_nl : STD_LOGIC;
  SIGNAL nor_170_nl : STD_LOGIC;
  SIGNAL mux_752_nl : STD_LOGIC;
  SIGNAL and_210_nl : STD_LOGIC;
  SIGNAL nor_165_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_27_nl : STD_LOGIC;
  SIGNAL mux_782_nl : STD_LOGIC;
  SIGNAL mux_781_nl : STD_LOGIC;
  SIGNAL mux_780_nl : STD_LOGIC;
  SIGNAL mux_779_nl : STD_LOGIC;
  SIGNAL mux_778_nl : STD_LOGIC;
  SIGNAL mux_777_nl : STD_LOGIC;
  SIGNAL mux_776_nl : STD_LOGIC;
  SIGNAL mux_775_nl : STD_LOGIC;
  SIGNAL mux_774_nl : STD_LOGIC;
  SIGNAL mux_773_nl : STD_LOGIC;
  SIGNAL mux_772_nl : STD_LOGIC;
  SIGNAL mux_769_nl : STD_LOGIC;
  SIGNAL mux_768_nl : STD_LOGIC;
  SIGNAL or_824_nl : STD_LOGIC;
  SIGNAL or_820_nl : STD_LOGIC;
  SIGNAL mux_767_nl : STD_LOGIC;
  SIGNAL mux_766_nl : STD_LOGIC;
  SIGNAL mux_765_nl : STD_LOGIC;
  SIGNAL mux_764_nl : STD_LOGIC;
  SIGNAL mux_762_nl : STD_LOGIC;
  SIGNAL mux_761_nl : STD_LOGIC;
  SIGNAL or_810_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_44_nl : STD_LOGIC;
  SIGNAL mux_806_nl : STD_LOGIC;
  SIGNAL mux_805_nl : STD_LOGIC;
  SIGNAL or_nl : STD_LOGIC;
  SIGNAL mux_804_nl : STD_LOGIC;
  SIGNAL or_989_nl : STD_LOGIC;
  SIGNAL or_990_nl : STD_LOGIC;
  SIGNAL or_991_nl : STD_LOGIC;
  SIGNAL mux_803_nl : STD_LOGIC;
  SIGNAL or_852_nl : STD_LOGIC;
  SIGNAL mux_802_nl : STD_LOGIC;
  SIGNAL or_851_nl : STD_LOGIC;
  SIGNAL or_850_nl : STD_LOGIC;
  SIGNAL mux_807_nl : STD_LOGIC;
  SIGNAL nor_142_nl : STD_LOGIC;
  SIGNAL nor_143_nl : STD_LOGIC;
  SIGNAL or_91_nl : STD_LOGIC;
  SIGNAL or_103_nl : STD_LOGIC;
  SIGNAL or_102_nl : STD_LOGIC;
  SIGNAL mux_158_nl : STD_LOGIC;
  SIGNAL mux_157_nl : STD_LOGIC;
  SIGNAL or_901_nl : STD_LOGIC;
  SIGNAL nand_100_nl : STD_LOGIC;
  SIGNAL nand_101_nl : STD_LOGIC;
  SIGNAL nor_310_nl : STD_LOGIC;
  SIGNAL nor_311_nl : STD_LOGIC;
  SIGNAL mux_324_nl : STD_LOGIC;
  SIGNAL mux_323_nl : STD_LOGIC;
  SIGNAL mux_328_nl : STD_LOGIC;
  SIGNAL mux_327_nl : STD_LOGIC;
  SIGNAL mux_326_nl : STD_LOGIC;
  SIGNAL mux_336_nl : STD_LOGIC;
  SIGNAL mux_334_nl : STD_LOGIC;
  SIGNAL mux_333_nl : STD_LOGIC;
  SIGNAL mux_332_nl : STD_LOGIC;
  SIGNAL mux_331_nl : STD_LOGIC;
  SIGNAL mux_330_nl : STD_LOGIC;
  SIGNAL mux_374_nl : STD_LOGIC;
  SIGNAL mux_377_nl : STD_LOGIC;
  SIGNAL mux_376_nl : STD_LOGIC;
  SIGNAL or_467_nl : STD_LOGIC;
  SIGNAL mux_381_nl : STD_LOGIC;
  SIGNAL or_465_nl : STD_LOGIC;
  SIGNAL mux_397_nl : STD_LOGIC;
  SIGNAL mux_396_nl : STD_LOGIC;
  SIGNAL mux_395_nl : STD_LOGIC;
  SIGNAL or_475_nl : STD_LOGIC;
  SIGNAL mux_416_nl : STD_LOGIC;
  SIGNAL nor_232_nl : STD_LOGIC;
  SIGNAL nor_233_nl : STD_LOGIC;
  SIGNAL nand_40_nl : STD_LOGIC;
  SIGNAL mux_419_nl : STD_LOGIC;
  SIGNAL nand_39_nl : STD_LOGIC;
  SIGNAL mux_430_nl : STD_LOGIC;
  SIGNAL or_909_nl : STD_LOGIC;
  SIGNAL mux_429_nl : STD_LOGIC;
  SIGNAL mux_428_nl : STD_LOGIC;
  SIGNAL mux_427_nl : STD_LOGIC;
  SIGNAL nand_87_nl : STD_LOGIC;
  SIGNAL or_498_nl : STD_LOGIC;
  SIGNAL or_496_nl : STD_LOGIC;
  SIGNAL mux_426_nl : STD_LOGIC;
  SIGNAL mux_425_nl : STD_LOGIC;
  SIGNAL or_910_nl : STD_LOGIC;
  SIGNAL or_911_nl : STD_LOGIC;
  SIGNAL nand_113_nl : STD_LOGIC;
  SIGNAL mux_424_nl : STD_LOGIC;
  SIGNAL or_491_nl : STD_LOGIC;
  SIGNAL mux_432_nl : STD_LOGIC;
  SIGNAL or_503_nl : STD_LOGIC;
  SIGNAL or_501_nl : STD_LOGIC;
  SIGNAL mux_435_nl : STD_LOGIC;
  SIGNAL or_508_nl : STD_LOGIC;
  SIGNAL mux_434_nl : STD_LOGIC;
  SIGNAL or_507_nl : STD_LOGIC;
  SIGNAL or_505_nl : STD_LOGIC;
  SIGNAL mux_438_nl : STD_LOGIC;
  SIGNAL nor_227_nl : STD_LOGIC;
  SIGNAL and_253_nl : STD_LOGIC;
  SIGNAL mux_439_nl : STD_LOGIC;
  SIGNAL mux_447_nl : STD_LOGIC;
  SIGNAL or_531_nl : STD_LOGIC;
  SIGNAL mux_673_nl : STD_LOGIC;
  SIGNAL nor_362_nl : STD_LOGIC;
  SIGNAL nor_363_nl : STD_LOGIC;
  SIGNAL mux_503_nl : STD_LOGIC;
  SIGNAL or_571_nl : STD_LOGIC;
  SIGNAL or_570_nl : STD_LOGIC;
  SIGNAL mux_505_nl : STD_LOGIC;
  SIGNAL or_572_nl : STD_LOGIC;
  SIGNAL and_306_nl : STD_LOGIC;
  SIGNAL mux_508_nl : STD_LOGIC;
  SIGNAL nor_211_nl : STD_LOGIC;
  SIGNAL or_587_nl : STD_LOGIC;
  SIGNAL nor_208_nl : STD_LOGIC;
  SIGNAL and_239_nl : STD_LOGIC;
  SIGNAL mux_532_nl : STD_LOGIC;
  SIGNAL mux_531_nl : STD_LOGIC;
  SIGNAL or_588_nl : STD_LOGIC;
  SIGNAL or_600_nl : STD_LOGIC;
  SIGNAL nor_nl : STD_LOGIC;
  SIGNAL mux_585_nl : STD_LOGIC;
  SIGNAL mux_584_nl : STD_LOGIC;
  SIGNAL nor_189_nl : STD_LOGIC;
  SIGNAL nor_190_nl : STD_LOGIC;
  SIGNAL mux_583_nl : STD_LOGIC;
  SIGNAL nor_191_nl : STD_LOGIC;
  SIGNAL nor_192_nl : STD_LOGIC;
  SIGNAL mux_582_nl : STD_LOGIC;
  SIGNAL and_229_nl : STD_LOGIC;
  SIGNAL mux_581_nl : STD_LOGIC;
  SIGNAL nor_193_nl : STD_LOGIC;
  SIGNAL nor_194_nl : STD_LOGIC;
  SIGNAL nor_195_nl : STD_LOGIC;
  SIGNAL mux_580_nl : STD_LOGIC;
  SIGNAL or_643_nl : STD_LOGIC;
  SIGNAL or_642_nl : STD_LOGIC;
  SIGNAL or_659_nl : STD_LOGIC;
  SIGNAL mux_598_nl : STD_LOGIC;
  SIGNAL or_669_nl : STD_LOGIC;
  SIGNAL mux_623_nl : STD_LOGIC;
  SIGNAL or_73_nl : STD_LOGIC;
  SIGNAL mux_54_nl : STD_LOGIC;
  SIGNAL or_694_nl : STD_LOGIC;
  SIGNAL mux_636_nl : STD_LOGIC;
  SIGNAL or_708_nl : STD_LOGIC;
  SIGNAL mux_758_nl : STD_LOGIC;
  SIGNAL mux_757_nl : STD_LOGIC;
  SIGNAL nor_158_nl : STD_LOGIC;
  SIGNAL mux_756_nl : STD_LOGIC;
  SIGNAL nand_74_nl : STD_LOGIC;
  SIGNAL or_797_nl : STD_LOGIC;
  SIGNAL nor_159_nl : STD_LOGIC;
  SIGNAL and_208_nl : STD_LOGIC;
  SIGNAL mux_755_nl : STD_LOGIC;
  SIGNAL nor_160_nl : STD_LOGIC;
  SIGNAL mux_754_nl : STD_LOGIC;
  SIGNAL nor_161_nl : STD_LOGIC;
  SIGNAL and_209_nl : STD_LOGIC;
  SIGNAL mux_753_nl : STD_LOGIC;
  SIGNAL nor_162_nl : STD_LOGIC;
  SIGNAL nor_163_nl : STD_LOGIC;
  SIGNAL nor_164_nl : STD_LOGIC;
  SIGNAL or_801_nl : STD_LOGIC;
  SIGNAL and_292_nl : STD_LOGIC;
  SIGNAL nor_150_nl : STD_LOGIC;
  SIGNAL nor_151_nl : STD_LOGIC;
  SIGNAL mux_785_nl : STD_LOGIC;
  SIGNAL or_832_nl : STD_LOGIC;
  SIGNAL mux_784_nl : STD_LOGIC;
  SIGNAL or_831_nl : STD_LOGIC;
  SIGNAL or_27_nl : STD_LOGIC;
  SIGNAL mux_800_nl : STD_LOGIC;
  SIGNAL mux_799_nl : STD_LOGIC;
  SIGNAL mux_798_nl : STD_LOGIC;
  SIGNAL mux_797_nl : STD_LOGIC;
  SIGNAL mux_796_nl : STD_LOGIC;
  SIGNAL mux_795_nl : STD_LOGIC;
  SIGNAL nor_132_nl : STD_LOGIC;
  SIGNAL mux_794_nl : STD_LOGIC;
  SIGNAL mux_793_nl : STD_LOGIC;
  SIGNAL mux_792_nl : STD_LOGIC;
  SIGNAL mux_791_nl : STD_LOGIC;
  SIGNAL mux_790_nl : STD_LOGIC;
  SIGNAL mux_39_nl : STD_LOGIC;
  SIGNAL or_843_nl : STD_LOGIC;
  SIGNAL mux_788_nl : STD_LOGIC;
  SIGNAL mux_496_nl : STD_LOGIC;
  SIGNAL nor_217_nl : STD_LOGIC;
  SIGNAL mux_495_nl : STD_LOGIC;
  SIGNAL or_9_nl : STD_LOGIC;
  SIGNAL or_556_nl : STD_LOGIC;
  SIGNAL mux_502_nl : STD_LOGIC;
  SIGNAL mux_501_nl : STD_LOGIC;
  SIGNAL or_914_nl : STD_LOGIC;
  SIGNAL or_915_nl : STD_LOGIC;
  SIGNAL or_916_nl : STD_LOGIC;
  SIGNAL or_184_nl : STD_LOGIC;
  SIGNAL or_180_nl : STD_LOGIC;
  SIGNAL and_61_nl : STD_LOGIC;
  SIGNAL and_63_nl : STD_LOGIC;
  SIGNAL mux_167_nl : STD_LOGIC;
  SIGNAL nor_307_nl : STD_LOGIC;
  SIGNAL mux_166_nl : STD_LOGIC;
  SIGNAL or_186_nl : STD_LOGIC;
  SIGNAL mux_164_nl : STD_LOGIC;
  SIGNAL nor_308_nl : STD_LOGIC;
  SIGNAL nor_309_nl : STD_LOGIC;
  SIGNAL and_65_nl : STD_LOGIC;
  SIGNAL mux_170_nl : STD_LOGIC;
  SIGNAL and_283_nl : STD_LOGIC;
  SIGNAL mux_169_nl : STD_LOGIC;
  SIGNAL nor_304_nl : STD_LOGIC;
  SIGNAL nor_305_nl : STD_LOGIC;
  SIGNAL nor_306_nl : STD_LOGIC;
  SIGNAL mux_168_nl : STD_LOGIC;
  SIGNAL or_190_nl : STD_LOGIC;
  SIGNAL or_189_nl : STD_LOGIC;
  SIGNAL and_70_nl : STD_LOGIC;
  SIGNAL mux_173_nl : STD_LOGIC;
  SIGNAL and_282_nl : STD_LOGIC;
  SIGNAL mux_172_nl : STD_LOGIC;
  SIGNAL nor_301_nl : STD_LOGIC;
  SIGNAL nor_302_nl : STD_LOGIC;
  SIGNAL nor_303_nl : STD_LOGIC;
  SIGNAL and_77_nl : STD_LOGIC;
  SIGNAL mux_176_nl : STD_LOGIC;
  SIGNAL nor_299_nl : STD_LOGIC;
  SIGNAL mux_175_nl : STD_LOGIC;
  SIGNAL or_209_nl : STD_LOGIC;
  SIGNAL or_208_nl : STD_LOGIC;
  SIGNAL nor_300_nl : STD_LOGIC;
  SIGNAL mux_174_nl : STD_LOGIC;
  SIGNAL or_205_nl : STD_LOGIC;
  SIGNAL or_204_nl : STD_LOGIC;
  SIGNAL nor_292_nl : STD_LOGIC;
  SIGNAL nor_293_nl : STD_LOGIC;
  SIGNAL mux_183_nl : STD_LOGIC;
  SIGNAL nand_11_nl : STD_LOGIC;
  SIGNAL mux_182_nl : STD_LOGIC;
  SIGNAL nor_294_nl : STD_LOGIC;
  SIGNAL mux_181_nl : STD_LOGIC;
  SIGNAL or_224_nl : STD_LOGIC;
  SIGNAL or_223_nl : STD_LOGIC;
  SIGNAL mux_180_nl : STD_LOGIC;
  SIGNAL nor_295_nl : STD_LOGIC;
  SIGNAL nor_296_nl : STD_LOGIC;
  SIGNAL or_217_nl : STD_LOGIC;
  SIGNAL mux_179_nl : STD_LOGIC;
  SIGNAL nand_10_nl : STD_LOGIC;
  SIGNAL mux_178_nl : STD_LOGIC;
  SIGNAL nor_297_nl : STD_LOGIC;
  SIGNAL nor_298_nl : STD_LOGIC;
  SIGNAL mux_177_nl : STD_LOGIC;
  SIGNAL or_213_nl : STD_LOGIC;
  SIGNAL or_211_nl : STD_LOGIC;
  SIGNAL mux_207_nl : STD_LOGIC;
  SIGNAL nor_282_nl : STD_LOGIC;
  SIGNAL mux_206_nl : STD_LOGIC;
  SIGNAL mux_205_nl : STD_LOGIC;
  SIGNAL or_267_nl : STD_LOGIC;
  SIGNAL mux_204_nl : STD_LOGIC;
  SIGNAL or_266_nl : STD_LOGIC;
  SIGNAL or_264_nl : STD_LOGIC;
  SIGNAL or_263_nl : STD_LOGIC;
  SIGNAL or_261_nl : STD_LOGIC;
  SIGNAL mux_203_nl : STD_LOGIC;
  SIGNAL mux_202_nl : STD_LOGIC;
  SIGNAL or_260_nl : STD_LOGIC;
  SIGNAL mux_201_nl : STD_LOGIC;
  SIGNAL or_259_nl : STD_LOGIC;
  SIGNAL or_258_nl : STD_LOGIC;
  SIGNAL or_257_nl : STD_LOGIC;
  SIGNAL or_256_nl : STD_LOGIC;
  SIGNAL nor_283_nl : STD_LOGIC;
  SIGNAL mux_200_nl : STD_LOGIC;
  SIGNAL or_253_nl : STD_LOGIC;
  SIGNAL mux_199_nl : STD_LOGIC;
  SIGNAL and_280_nl : STD_LOGIC;
  SIGNAL mux_198_nl : STD_LOGIC;
  SIGNAL and_281_nl : STD_LOGIC;
  SIGNAL mux_197_nl : STD_LOGIC;
  SIGNAL nor_284_nl : STD_LOGIC;
  SIGNAL nor_285_nl : STD_LOGIC;
  SIGNAL mux_196_nl : STD_LOGIC;
  SIGNAL mux_195_nl : STD_LOGIC;
  SIGNAL mux_194_nl : STD_LOGIC;
  SIGNAL mux_193_nl : STD_LOGIC;
  SIGNAL nor_286_nl : STD_LOGIC;
  SIGNAL nor_287_nl : STD_LOGIC;
  SIGNAL nor_288_nl : STD_LOGIC;
  SIGNAL or_246_nl : STD_LOGIC;
  SIGNAL nor_289_nl : STD_LOGIC;
  SIGNAL nor_290_nl : STD_LOGIC;
  SIGNAL nor_291_nl : STD_LOGIC;
  SIGNAL mux_192_nl : STD_LOGIC;
  SIGNAL or_242_nl : STD_LOGIC;
  SIGNAL nor_274_nl : STD_LOGIC;
  SIGNAL nor_275_nl : STD_LOGIC;
  SIGNAL mux_215_nl : STD_LOGIC;
  SIGNAL nand_17_nl : STD_LOGIC;
  SIGNAL mux_214_nl : STD_LOGIC;
  SIGNAL and_279_nl : STD_LOGIC;
  SIGNAL mux_213_nl : STD_LOGIC;
  SIGNAL nor_277_nl : STD_LOGIC;
  SIGNAL mux_212_nl : STD_LOGIC;
  SIGNAL nor_278_nl : STD_LOGIC;
  SIGNAL nor_279_nl : STD_LOGIC;
  SIGNAL or_275_nl : STD_LOGIC;
  SIGNAL mux_211_nl : STD_LOGIC;
  SIGNAL nand_15_nl : STD_LOGIC;
  SIGNAL mux_210_nl : STD_LOGIC;
  SIGNAL nor_280_nl : STD_LOGIC;
  SIGNAL nor_281_nl : STD_LOGIC;
  SIGNAL mux_209_nl : STD_LOGIC;
  SIGNAL or_271_nl : STD_LOGIC;
  SIGNAL or_269_nl : STD_LOGIC;
  SIGNAL mux_243_nl : STD_LOGIC;
  SIGNAL nor_267_nl : STD_LOGIC;
  SIGNAL mux_242_nl : STD_LOGIC;
  SIGNAL mux_241_nl : STD_LOGIC;
  SIGNAL or_324_nl : STD_LOGIC;
  SIGNAL mux_240_nl : STD_LOGIC;
  SIGNAL or_322_nl : STD_LOGIC;
  SIGNAL or_320_nl : STD_LOGIC;
  SIGNAL or_318_nl : STD_LOGIC;
  SIGNAL mux_239_nl : STD_LOGIC;
  SIGNAL mux_238_nl : STD_LOGIC;
  SIGNAL mux_237_nl : STD_LOGIC;
  SIGNAL nand_22_nl : STD_LOGIC;
  SIGNAL mux_236_nl : STD_LOGIC;
  SIGNAL or_314_nl : STD_LOGIC;
  SIGNAL mux_235_nl : STD_LOGIC;
  SIGNAL or_313_nl : STD_LOGIC;
  SIGNAL or_311_nl : STD_LOGIC;
  SIGNAL and_276_nl : STD_LOGIC;
  SIGNAL mux_234_nl : STD_LOGIC;
  SIGNAL nor_270_nl : STD_LOGIC;
  SIGNAL nor_271_nl : STD_LOGIC;
  SIGNAL mux_233_nl : STD_LOGIC;
  SIGNAL and_277_nl : STD_LOGIC;
  SIGNAL mux_232_nl : STD_LOGIC;
  SIGNAL or_308_nl : STD_LOGIC;
  SIGNAL mux_231_nl : STD_LOGIC;
  SIGNAL or_307_nl : STD_LOGIC;
  SIGNAL or_306_nl : STD_LOGIC;
  SIGNAL mux_230_nl : STD_LOGIC;
  SIGNAL mux_225_nl : STD_LOGIC;
  SIGNAL or_299_nl : STD_LOGIC;
  SIGNAL mux_229_nl : STD_LOGIC;
  SIGNAL mux_228_nl : STD_LOGIC;
  SIGNAL mux_227_nl : STD_LOGIC;
  SIGNAL mux_226_nl : STD_LOGIC;
  SIGNAL or_303_nl : STD_LOGIC;
  SIGNAL or_302_nl : STD_LOGIC;
  SIGNAL or_301_nl : STD_LOGIC;
  SIGNAL or_300_nl : STD_LOGIC;
  SIGNAL and_278_nl : STD_LOGIC;
  SIGNAL mux_224_nl : STD_LOGIC;
  SIGNAL nor_272_nl : STD_LOGIC;
  SIGNAL nor_273_nl : STD_LOGIC;
  SIGNAL and_274_nl : STD_LOGIC;
  SIGNAL nor_261_nl : STD_LOGIC;
  SIGNAL mux_251_nl : STD_LOGIC;
  SIGNAL nand_24_nl : STD_LOGIC;
  SIGNAL mux_250_nl : STD_LOGIC;
  SIGNAL nor_262_nl : STD_LOGIC;
  SIGNAL mux_249_nl : STD_LOGIC;
  SIGNAL or_338_nl : STD_LOGIC;
  SIGNAL mux_248_nl : STD_LOGIC;
  SIGNAL nor_263_nl : STD_LOGIC;
  SIGNAL nor_264_nl : STD_LOGIC;
  SIGNAL or_332_nl : STD_LOGIC;
  SIGNAL mux_247_nl : STD_LOGIC;
  SIGNAL nand_23_nl : STD_LOGIC;
  SIGNAL mux_246_nl : STD_LOGIC;
  SIGNAL nor_265_nl : STD_LOGIC;
  SIGNAL nor_266_nl : STD_LOGIC;
  SIGNAL mux_245_nl : STD_LOGIC;
  SIGNAL or_328_nl : STD_LOGIC;
  SIGNAL or_326_nl : STD_LOGIC;
  SIGNAL mux_279_nl : STD_LOGIC;
  SIGNAL nor_255_nl : STD_LOGIC;
  SIGNAL mux_278_nl : STD_LOGIC;
  SIGNAL mux_277_nl : STD_LOGIC;
  SIGNAL or_379_nl : STD_LOGIC;
  SIGNAL or_377_nl : STD_LOGIC;
  SIGNAL mux_276_nl : STD_LOGIC;
  SIGNAL or_375_nl : STD_LOGIC;
  SIGNAL nor_54_nl : STD_LOGIC;
  SIGNAL mux_275_nl : STD_LOGIC;
  SIGNAL or_373_nl : STD_LOGIC;
  SIGNAL mux_274_nl : STD_LOGIC;
  SIGNAL or_372_nl : STD_LOGIC;
  SIGNAL mux_273_nl : STD_LOGIC;
  SIGNAL mux_272_nl : STD_LOGIC;
  SIGNAL or_371_nl : STD_LOGIC;
  SIGNAL mux_271_nl : STD_LOGIC;
  SIGNAL or_367_nl : STD_LOGIC;
  SIGNAL and_271_nl : STD_LOGIC;
  SIGNAL mux_270_nl : STD_LOGIC;
  SIGNAL nor_256_nl : STD_LOGIC;
  SIGNAL nor_257_nl : STD_LOGIC;
  SIGNAL mux_269_nl : STD_LOGIC;
  SIGNAL and_272_nl : STD_LOGIC;
  SIGNAL mux_268_nl : STD_LOGIC;
  SIGNAL or_364_nl : STD_LOGIC;
  SIGNAL mux_267_nl : STD_LOGIC;
  SIGNAL or_363_nl : STD_LOGIC;
  SIGNAL or_362_nl : STD_LOGIC;
  SIGNAL mux_266_nl : STD_LOGIC;
  SIGNAL mux_261_nl : STD_LOGIC;
  SIGNAL or_356_nl : STD_LOGIC;
  SIGNAL mux_265_nl : STD_LOGIC;
  SIGNAL mux_264_nl : STD_LOGIC;
  SIGNAL mux_263_nl : STD_LOGIC;
  SIGNAL or_360_nl : STD_LOGIC;
  SIGNAL mux_262_nl : STD_LOGIC;
  SIGNAL or_358_nl : STD_LOGIC;
  SIGNAL nor_51_nl : STD_LOGIC;
  SIGNAL or_357_nl : STD_LOGIC;
  SIGNAL and_273_nl : STD_LOGIC;
  SIGNAL mux_260_nl : STD_LOGIC;
  SIGNAL nor_258_nl : STD_LOGIC;
  SIGNAL nor_259_nl : STD_LOGIC;
  SIGNAL and_267_nl : STD_LOGIC;
  SIGNAL nor_248_nl : STD_LOGIC;
  SIGNAL mux_287_nl : STD_LOGIC;
  SIGNAL nand_32_nl : STD_LOGIC;
  SIGNAL mux_286_nl : STD_LOGIC;
  SIGNAL and_269_nl : STD_LOGIC;
  SIGNAL mux_285_nl : STD_LOGIC;
  SIGNAL nor_250_nl : STD_LOGIC;
  SIGNAL mux_284_nl : STD_LOGIC;
  SIGNAL nor_251_nl : STD_LOGIC;
  SIGNAL nor_252_nl : STD_LOGIC;
  SIGNAL or_387_nl : STD_LOGIC;
  SIGNAL mux_283_nl : STD_LOGIC;
  SIGNAL nand_30_nl : STD_LOGIC;
  SIGNAL mux_282_nl : STD_LOGIC;
  SIGNAL nor_253_nl : STD_LOGIC;
  SIGNAL nor_254_nl : STD_LOGIC;
  SIGNAL mux_281_nl : STD_LOGIC;
  SIGNAL nand_112_nl : STD_LOGIC;
  SIGNAL or_381_nl : STD_LOGIC;
  SIGNAL mux_315_nl : STD_LOGIC;
  SIGNAL nor_240_nl : STD_LOGIC;
  SIGNAL mux_314_nl : STD_LOGIC;
  SIGNAL mux_313_nl : STD_LOGIC;
  SIGNAL or_431_nl : STD_LOGIC;
  SIGNAL or_429_nl : STD_LOGIC;
  SIGNAL mux_312_nl : STD_LOGIC;
  SIGNAL or_427_nl : STD_LOGIC;
  SIGNAL and_261_nl : STD_LOGIC;
  SIGNAL mux_311_nl : STD_LOGIC;
  SIGNAL or_425_nl : STD_LOGIC;
  SIGNAL mux_310_nl : STD_LOGIC;
  SIGNAL or_424_nl : STD_LOGIC;
  SIGNAL mux_309_nl : STD_LOGIC;
  SIGNAL mux_308_nl : STD_LOGIC;
  SIGNAL nand_38_nl : STD_LOGIC;
  SIGNAL mux_307_nl : STD_LOGIC;
  SIGNAL and_263_nl : STD_LOGIC;
  SIGNAL mux_306_nl : STD_LOGIC;
  SIGNAL nor_243_nl : STD_LOGIC;
  SIGNAL nor_244_nl : STD_LOGIC;
  SIGNAL mux_305_nl : STD_LOGIC;
  SIGNAL and_264_nl : STD_LOGIC;
  SIGNAL mux_304_nl : STD_LOGIC;
  SIGNAL or_417_nl : STD_LOGIC;
  SIGNAL mux_303_nl : STD_LOGIC;
  SIGNAL or_416_nl : STD_LOGIC;
  SIGNAL nand_91_nl : STD_LOGIC;
  SIGNAL mux_302_nl : STD_LOGIC;
  SIGNAL mux_297_nl : STD_LOGIC;
  SIGNAL or_409_nl : STD_LOGIC;
  SIGNAL mux_301_nl : STD_LOGIC;
  SIGNAL mux_300_nl : STD_LOGIC;
  SIGNAL mux_299_nl : STD_LOGIC;
  SIGNAL nand_92_nl : STD_LOGIC;
  SIGNAL mux_298_nl : STD_LOGIC;
  SIGNAL or_411_nl : STD_LOGIC;
  SIGNAL and_265_nl : STD_LOGIC;
  SIGNAL or_410_nl : STD_LOGIC;
  SIGNAL and_266_nl : STD_LOGIC;
  SIGNAL mux_296_nl : STD_LOGIC;
  SIGNAL nor_245_nl : STD_LOGIC;
  SIGNAL nor_246_nl : STD_LOGIC;
  SIGNAL mux_824_nl : STD_LOGIC;
  SIGNAL nor_394_nl : STD_LOGIC;
  SIGNAL nor_395_nl : STD_LOGIC;
  SIGNAL mux_828_nl : STD_LOGIC;
  SIGNAL nor_393_nl : STD_LOGIC;
  SIGNAL and_522_nl : STD_LOGIC;
  SIGNAL mux_827_nl : STD_LOGIC;
  SIGNAL mux_830_nl : STD_LOGIC;
  SIGNAL or_999_nl : STD_LOGIC;
  SIGNAL or_1000_nl : STD_LOGIC;
  SIGNAL mux_831_nl : STD_LOGIC;
  SIGNAL or_997_nl : STD_LOGIC;
  SIGNAL or_998_nl : STD_LOGIC;
  SIGNAL mux_833_nl : STD_LOGIC;
  SIGNAL nor_382_nl : STD_LOGIC;
  SIGNAL nor_383_nl : STD_LOGIC;
  SIGNAL or_938_nl : STD_LOGIC;
  SIGNAL mux_839_nl : STD_LOGIC;
  SIGNAL nand_140_nl : STD_LOGIC;
  SIGNAL mux_838_nl : STD_LOGIC;
  SIGNAL mux_837_nl : STD_LOGIC;
  SIGNAL or_945_nl : STD_LOGIC;
  SIGNAL or_993_nl : STD_LOGIC;
  SIGNAL mux_836_nl : STD_LOGIC;
  SIGNAL mux_835_nl : STD_LOGIC;
  SIGNAL or_942_nl : STD_LOGIC;
  SIGNAL or_940_nl : STD_LOGIC;
  SIGNAL mux_843_nl : STD_LOGIC;
  SIGNAL or_951_nl : STD_LOGIC;
  SIGNAL or_950_nl : STD_LOGIC;
  SIGNAL or_959_nl : STD_LOGIC;
  SIGNAL or_957_nl : STD_LOGIC;
  SIGNAL nand_125_nl : STD_LOGIC;
  SIGNAL or_956_nl : STD_LOGIC;
  SIGNAL or_965_nl : STD_LOGIC;
  SIGNAL mux_859_nl : STD_LOGIC;
  SIGNAL mux_858_nl : STD_LOGIC;
  SIGNAL mux_857_nl : STD_LOGIC;
  SIGNAL mux_856_nl : STD_LOGIC;
  SIGNAL nand_127_nl : STD_LOGIC;
  SIGNAL mux_855_nl : STD_LOGIC;
  SIGNAL mux_854_nl : STD_LOGIC;
  SIGNAL or_966_nl : STD_LOGIC;
  SIGNAL mux_853_nl : STD_LOGIC;
  SIGNAL mux_852_nl : STD_LOGIC;
  SIGNAL nand_126_nl : STD_LOGIC;
  SIGNAL mux_851_nl : STD_LOGIC;
  SIGNAL mux_848_nl : STD_LOGIC;
  SIGNAL or_963_nl : STD_LOGIC;
  SIGNAL or_961_nl : STD_LOGIC;
  SIGNAL mux_847_nl : STD_LOGIC;
  SIGNAL or_970_nl : STD_LOGIC;
  SIGNAL or_968_nl : STD_LOGIC;
  SIGNAL mux_865_nl : STD_LOGIC;
  SIGNAL mux_864_nl : STD_LOGIC;
  SIGNAL or_973_nl : STD_LOGIC;
  SIGNAL mux_863_nl : STD_LOGIC;
  SIGNAL mux_862_nl : STD_LOGIC;
  SIGNAL or_972_nl : STD_LOGIC;
  SIGNAL or_976_nl : STD_LOGIC;
  SIGNAL or_975_nl : STD_LOGIC;
  SIGNAL mux_878_nl : STD_LOGIC;
  SIGNAL or_1007_nl : STD_LOGIC;
  SIGNAL or_1005_nl : STD_LOGIC;
  SIGNAL nand_147_nl : STD_LOGIC;
  SIGNAL or_1044_nl : STD_LOGIC;
  SIGNAL mux_916_nl : STD_LOGIC;
  SIGNAL or_1053_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_operator_64_false_1_or_1_nl : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL operator_64_false_1_mux_5_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL operator_64_false_1_mux1h_9_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_10_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_11_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_12_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_13_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_14_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_15_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_16_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_operator_64_false_1_mux_1_nl : STD_LOGIC_VECTOR (6 DOWNTO
      0);
  SIGNAL operator_64_false_1_or_6_nl : STD_LOGIC;
  SIGNAL acc_2_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL COMP_LOOP_mux1h_83_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL COMP_LOOP_mux1h_84_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL COMP_LOOP_or_34_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_or_3_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_41_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL COMP_LOOP_mux1h_85_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL and_532_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_35_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_or_4_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_or_5_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_86_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_or_36_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_mux1h_87_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_or_37_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_or_1_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_103_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_55_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_104_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_56_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_105_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_57_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_106_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_58_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_107_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_59_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_108_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_60_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_109_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_61_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_110_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_62_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_111_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_63_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_112_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_64_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_113_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_65_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_114_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_66_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_115_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_67_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_116_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_68_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_117_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_69_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_118_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_70_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_119_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_71_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_120_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_72_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_121_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_73_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_122_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_74_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_123_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_75_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_124_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_76_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_125_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_77_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_126_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_78_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_127_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_79_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_128_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_80_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_129_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_81_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_130_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_82_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_131_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_83_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_132_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_84_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_133_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_85_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_134_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_86_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_135_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_87_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_136_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_88_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_137_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_89_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_138_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_90_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_139_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_91_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_140_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_92_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_141_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_93_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_142_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_94_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_143_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_95_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_144_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_96_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_145_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_97_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_146_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_98_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_147_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_99_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_148_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_100_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_149_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_101_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_150_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_102_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_151_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_103_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_152_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_104_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_153_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux_105_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_and_4_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL STAGE_LOOP_mux1h_6_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL STAGE_LOOP_nor_106_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux1h_7_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_61_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_62_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL STAGE_LOOP_or_10_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_or_11_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux1h_8_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_or_12_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_154_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_155_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_156_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_157_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_158_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_159_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_160_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_161_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_162_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_163_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_164_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_165_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_166_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_167_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_168_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_169_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_170_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_171_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_172_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_173_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_174_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_175_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_176_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_177_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_178_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_179_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_180_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_181_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_182_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_183_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_184_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_185_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_186_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_187_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_188_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_189_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_190_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_191_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_192_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_193_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_194_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_195_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_196_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_197_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_198_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_199_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_200_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_201_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_202_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_203_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_204_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_STAGE_LOOP_and_205_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_and_5_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL STAGE_LOOP_mux1h_9_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL STAGE_LOOP_nor_107_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_mux1h_10_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL STAGE_LOOP_or_13_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_or_14_nl : STD_LOGIC;
  SIGNAL modExp_while_if_mux1h_1_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_533_nl : STD_LOGIC;
  SIGNAL modExp_while_if_modExp_while_if_nand_1_nl : STD_LOGIC;
  SIGNAL mux_953_nl : STD_LOGIC;
  SIGNAL mux_954_nl : STD_LOGIC;
  SIGNAL or_1078_nl : STD_LOGIC;
  SIGNAL mux_956_nl : STD_LOGIC;
  SIGNAL mux_957_nl : STD_LOGIC;
  SIGNAL nand_149_nl : STD_LOGIC;
  SIGNAL or_1080_nl : STD_LOGIC;
  SIGNAL and_534_nl : STD_LOGIC;
  SIGNAL mux_958_nl : STD_LOGIC;
  SIGNAL nor_461_nl : STD_LOGIC;
  SIGNAL mux_959_nl : STD_LOGIC;
  SIGNAL and_535_nl : STD_LOGIC;
  SIGNAL mux_960_nl : STD_LOGIC;
  SIGNAL nor_462_nl : STD_LOGIC;
  SIGNAL nor_463_nl : STD_LOGIC;
  SIGNAL mux_961_nl : STD_LOGIC;
  SIGNAL nor_464_nl : STD_LOGIC;
  SIGNAL and_536_nl : STD_LOGIC;
  SIGNAL modExp_while_if_modExp_while_if_mux1h_1_nl : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL modExp_while_if_modExp_while_if_nor_1_nl : STD_LOGIC;
  SIGNAL modExp_while_if_and_6_nl : STD_LOGIC;
  SIGNAL modExp_while_if_and_7_nl : STD_LOGIC;
  SIGNAL modExp_while_if_and_8_nl : STD_LOGIC;
  SIGNAL p_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL r_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL r_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL modulo_result_rem_cmp_a_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_result_rem_cmp_b_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_result_rem_cmp_z_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL operator_66_true_div_cmp_a_1 : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL operator_66_true_div_cmp_b : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL operator_66_true_div_cmp_z_1 : STD_LOGIC_VECTOR (64 DOWNTO 0);

  SIGNAL STAGE_LOOP_lshift_rg_a : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_rg_s : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_rg_z : STD_LOGIC_VECTOR (9 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      STAGE_LOOP_C_5_tr0 : IN STD_LOGIC;
      modExp_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_C_40_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_C_80_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_C_120_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_1_COMP_LOOP_C_160_tr0 : IN STD_LOGIC;
      VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_C_40_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_C_80_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_C_120_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0 : IN STD_LOGIC;
      VEC_LOOP_2_COMP_LOOP_C_160_tr0 : IN STD_LOGIC;
      VEC_LOOP_C_1_tr0 : IN STD_LOGIC;
      STAGE_LOOP_C_6_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (9 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_5_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_1_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_40_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0
      : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_80_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0
      : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_120_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0
      : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_1_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_40_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0
      : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_80_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0
      : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_120_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0
      : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_1_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_6_tr0 : STD_LOGIC;

  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

  FUNCTION MUX1HOT_s_1_3_2(input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_s_1_4_2(input_3 : STD_LOGIC;
  input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
      tmp := sel(3);
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_s_1_5_2(input_4 : STD_LOGIC;
  input_3 : STD_LOGIC;
  input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
      tmp := sel(3);
      result := result or ( input_3 and tmp);
      tmp := sel(4);
      result := result or ( input_4 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_s_1_7_2(input_6 : STD_LOGIC;
  input_5 : STD_LOGIC;
  input_4 : STD_LOGIC;
  input_3 : STD_LOGIC;
  input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(6 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
      tmp := sel(3);
      result := result or ( input_3 and tmp);
      tmp := sel(4);
      result := result or ( input_4 and tmp);
      tmp := sel(5);
      result := result or ( input_5 and tmp);
      tmp := sel(6);
      result := result or ( input_6 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_10_5_2(input_4 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_10_7_2(input_6 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(6 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
      tmp := (OTHERS=>sel( 5));
      result := result or ( input_5 and tmp);
      tmp := (OTHERS=>sel( 6));
      result := result or ( input_6 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_12_3_2(input_2 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_2_3_2(input_2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(1 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(1 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_2_4_2(input_3 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(1 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(1 DOWNTO 0);

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

  FUNCTION MUX1HOT_v_3_3_2(input_2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(2 DOWNTO 0);

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

  FUNCTION MUX1HOT_v_64_5_2(input_4 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
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
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_65_3_2(input_2 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(64 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(64 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_9_3_2(input_2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
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
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_9_8_2(input_7 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(7 DOWNTO 0))
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

  FUNCTION MUX_v_11_2_2(input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_12_2_2(input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_2_2_2(input_0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(1 DOWNTO 0);

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

  FUNCTION MUX_v_63_2_2(input_0 : STD_LOGIC_VECTOR(62 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(62 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(62 DOWNTO 0);

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

  FUNCTION MUX_v_65_2_2(input_0 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(64 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_7_2_2(input_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);

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

  r_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 3,
      width => 64
      )
    PORT MAP(
      dat => r_rsci_dat,
      idat => r_rsci_idat_1
    );
  r_rsci_dat <= r_rsc_dat;
  r_rsci_idat <= r_rsci_idat_1;

  vec_rsc_triosy_0_3_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_3_obj_ld_cse,
      lz => vec_rsc_triosy_0_3_lz
    );
  vec_rsc_triosy_0_2_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_3_obj_ld_cse,
      lz => vec_rsc_triosy_0_2_lz
    );
  vec_rsc_triosy_0_1_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_3_obj_ld_cse,
      lz => vec_rsc_triosy_0_1_lz
    );
  vec_rsc_triosy_0_0_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_3_obj_ld_cse,
      lz => vec_rsc_triosy_0_0_lz
    );
  p_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_3_obj_ld_cse,
      lz => p_rsc_triosy_lz
    );
  r_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_3_obj_ld_cse,
      lz => r_rsc_triosy_lz
    );
  modulo_result_rem_cmp : work.mgc_comps.mgc_rem
    GENERIC MAP(
      width_a => 64,
      width_b => 64,
      signd => 1
      )
    PORT MAP(
      a => modulo_result_rem_cmp_a_1,
      b => modulo_result_rem_cmp_b_1,
      z => modulo_result_rem_cmp_z_1
    );
  modulo_result_rem_cmp_a_1 <= modulo_result_rem_cmp_a;
  modulo_result_rem_cmp_b_1 <= modulo_result_rem_cmp_b;
  modulo_result_rem_cmp_z <= modulo_result_rem_cmp_z_1;

  operator_66_true_div_cmp : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 65,
      width_b => 11,
      signd => 1
      )
    PORT MAP(
      a => operator_66_true_div_cmp_a_1,
      b => operator_66_true_div_cmp_b,
      z => operator_66_true_div_cmp_z_1
    );
  operator_66_true_div_cmp_a_1 <= operator_66_true_div_cmp_a;
  operator_66_true_div_cmp_b <= STD_LOGIC_VECTOR(UNSIGNED'( "0") & UNSIGNED(operator_66_true_div_cmp_b_9_0));
  operator_66_true_div_cmp_z <= operator_66_true_div_cmp_z_1;

  STAGE_LOOP_lshift_rg : work.mgc_shift_comps_v5.mgc_shift_l_v5
    GENERIC MAP(
      width_a => 1,
      signd_a => 0,
      width_s => 4,
      width_z => 10
      )
    PORT MAP(
      a => STAGE_LOOP_lshift_rg_a,
      s => STAGE_LOOP_lshift_rg_s,
      z => STAGE_LOOP_lshift_rg_z
    );
  STAGE_LOOP_lshift_rg_a(0) <= '1';
  STAGE_LOOP_lshift_rg_s <= STAGE_LOOP_i_3_0_sva;
  STAGE_LOOP_lshift_psp_sva_mx0w0 <= STAGE_LOOP_lshift_rg_z;

  inPlaceNTT_DIT_core_core_fsm_inst : inPlaceNTT_DIT_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => inPlaceNTT_DIT_core_core_fsm_inst_fsm_output,
      STAGE_LOOP_C_5_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_5_tr0,
      modExp_while_C_24_tr0 => exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva,
      VEC_LOOP_1_COMP_LOOP_C_1_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_1_tr0,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0 => exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva,
      VEC_LOOP_1_COMP_LOOP_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_40_tr0,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_80_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_80_tr0,
      VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_120_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_120_tr0,
      VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0,
      VEC_LOOP_1_COMP_LOOP_C_160_tr0 => exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva,
      VEC_LOOP_C_0_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0,
      VEC_LOOP_2_COMP_LOOP_C_1_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_1_tr0,
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0 => exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva,
      VEC_LOOP_2_COMP_LOOP_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_40_tr0,
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0,
      VEC_LOOP_2_COMP_LOOP_C_80_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_80_tr0,
      VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0,
      VEC_LOOP_2_COMP_LOOP_C_120_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_120_tr0,
      VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0,
      VEC_LOOP_2_COMP_LOOP_C_160_tr0 => exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva,
      VEC_LOOP_C_1_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_1_tr0,
      STAGE_LOOP_C_6_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_6_tr0
    );
  fsm_output <= inPlaceNTT_DIT_core_core_fsm_inst_fsm_output;
  inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_5_tr0 <= NOT (z_out_5(64));
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_1_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_40_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0
      <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_80_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_3_modExp_1_while_C_24_tr0
      <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_120_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_4_modExp_1_while_C_24_tr0
      <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 <= z_out_6(12);
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_1_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_40_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0
      <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_80_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_3_modExp_1_while_C_24_tr0
      <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_120_tr0 <= NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_4_modExp_1_while_C_24_tr0
      <= NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_1_tr0 <= z_out_6(12);
  inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_6_tr0 <= NOT (z_out_5(2));

  mux_187_nl <= MUX_s_1_2_2(or_304_cse, or_369_cse, fsm_output(1));
  or_237_nl <= (NOT (fsm_output(1))) OR (NOT (fsm_output(8))) OR (fsm_output(9))
      OR (fsm_output(7));
  mux_188_nl <= MUX_s_1_2_2(mux_187_nl, or_237_nl, fsm_output(2));
  or_236_nl <= (fsm_output(2)) OR (fsm_output(1)) OR (NOT (fsm_output(8))) OR (fsm_output(9))
      OR (NOT (fsm_output(7)));
  mux_189_cse <= MUX_s_1_2_2(mux_188_nl, or_236_nl, fsm_output(3));
  or_231_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010"));
  mux_184_nl <= MUX_s_1_2_2(or_369_cse, or_231_nl, fsm_output(1));
  mux_185_nl <= MUX_s_1_2_2(mux_184_nl, nand_95_cse, fsm_output(2));
  or_228_nl <= (fsm_output(2)) OR (fsm_output(1)) OR (fsm_output(8)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7));
  mux_186_cse <= MUX_s_1_2_2(mux_185_nl, or_228_nl, fsm_output(3));
  nand_12_nl <= NOT((fsm_output(6)) AND (NOT mux_189_cse));
  or_234_nl <= (fsm_output(6)) OR mux_186_cse;
  mux_190_cse <= MUX_s_1_2_2(nand_12_nl, or_234_nl, fsm_output(0));
  nand_95_cse <= NOT((fsm_output(1)) AND (fsm_output(7)) AND (fsm_output(8)) AND
      (NOT (fsm_output(9))));
  or_304_cse <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000"));
  nor_269_cse <= NOT(CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  or_315_cse <= (fsm_output(2)) OR (NOT (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0))) OR (fsm_output(1))
      OR (NOT (fsm_output(7))) OR (NOT (fsm_output(8))) OR (fsm_output(9));
  nor_268_cse <= NOT((VEC_LOOP_j_1_12_0_sva_11_0(1)) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("000")));
  and_275_nl <= (fsm_output(6)) AND (NOT mux_189_cse);
  nor_260_nl <= NOT((fsm_output(6)) OR mux_186_cse);
  mux_258_cse <= MUX_s_1_2_2(and_275_nl, nor_260_nl, fsm_output(0));
  and_270_cse <= VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND (COMP_LOOP_acc_11_psp_1_sva(0));
  or_369_cse <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  or_370_cse <= (NOT (VEC_LOOP_j_1_12_0_sva_11_0(1))) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("000"));
  nor_241_cse <= NOT((NOT (VEC_LOOP_j_1_12_0_sva_11_0(1))) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("000")));
  nor_70_cse <= NOT((fsm_output(8)) OR (NOT (fsm_output(2))));
  and_256_cse <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("11"));
  nor_236_cse <= NOT(CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")));
  or_154_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  or_709_nl <= (NOT (fsm_output(2))) OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_670_nl <= MUX_s_1_2_2(or_tmp_670, or_709_nl, fsm_output(7));
  mux_671_nl <= MUX_s_1_2_2(mux_670_nl, mux_tmp_668, fsm_output(1));
  nor_178_nl <= NOT((fsm_output(8)) OR mux_671_nl);
  or_705_nl <= (fsm_output(2)) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  or_703_nl <= (fsm_output(2)) OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_667_nl <= MUX_s_1_2_2(or_705_nl, or_703_nl, fsm_output(7));
  mux_669_nl <= MUX_s_1_2_2(mux_tmp_668, mux_667_nl, fsm_output(1));
  and_225_nl <= (fsm_output(8)) AND (NOT mux_669_nl);
  mux_672_nl <= MUX_s_1_2_2(nor_178_nl, and_225_nl, fsm_output(3));
  or_702_nl <= (NOT (fsm_output(2))) OR (fsm_output(4));
  mux_658_nl <= MUX_s_1_2_2((NOT nor_tmp_103), or_702_nl, fsm_output(1));
  mux_659_nl <= MUX_s_1_2_2(or_tmp_654, mux_658_nl, fsm_output(3));
  mux_656_nl <= MUX_s_1_2_2((NOT or_tmp_61), (fsm_output(4)), fsm_output(1));
  or_701_nl <= (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (fsm_output(1))
      OR (fsm_output(2)) OR (fsm_output(4));
  mux_657_nl <= MUX_s_1_2_2(mux_656_nl, or_701_nl, fsm_output(3));
  mux_660_nl <= MUX_s_1_2_2(mux_659_nl, mux_657_nl, fsm_output(8));
  mux_661_nl <= MUX_s_1_2_2(mux_660_nl, mux_tmp_624, fsm_output(7));
  or_699_nl <= (fsm_output(3)) OR (NOT(VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm
      OR CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11")))) OR (fsm_output(4));
  mux_648_nl <= MUX_s_1_2_2((fsm_output(4)), or_tmp_656, fsm_output(3));
  mux_649_nl <= MUX_s_1_2_2(or_699_nl, mux_648_nl, fsm_output(8));
  mux_650_nl <= MUX_s_1_2_2(mux_tmp_637, mux_649_nl, fsm_output(7));
  mux_664_nl <= MUX_s_1_2_2(mux_661_nl, mux_650_nl, fsm_output(6));
  or_695_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 1)/=STD_LOGIC_VECTOR'("0000"));
  mux_638_nl <= MUX_s_1_2_2(or_695_nl, or_756_cse, fsm_output(8));
  mux_639_nl <= MUX_s_1_2_2(mux_638_nl, mux_tmp_637, fsm_output(7));
  mux_625_nl <= MUX_s_1_2_2((NOT nor_tmp_103), or_tmp_61, fsm_output(1));
  mux_626_nl <= MUX_s_1_2_2(or_tmp_51, mux_625_nl, fsm_output(3));
  mux_627_nl <= MUX_s_1_2_2(mux_626_nl, or_756_cse, fsm_output(8));
  mux_628_nl <= MUX_s_1_2_2(mux_627_nl, mux_tmp_624, fsm_output(7));
  mux_647_nl <= MUX_s_1_2_2(mux_639_nl, mux_628_nl, fsm_output(6));
  mux_950_nl <= MUX_s_1_2_2(mux_664_nl, mux_647_nl, fsm_output(0));
  or_994_nl <= and_dcpl_104 OR (mux_672_nl AND and_dcpl_109 AND (fsm_output(5)) AND
      (NOT((not_tmp_260 AND (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm))
      OR (mux_950_nl AND (NOT (fsm_output(9))))))) OR (NOT mux_423_itm);
  modExp_while_if_and_1_nl <= modExp_while_and_3 AND not_tmp_260;
  modExp_while_if_and_2_nl <= modExp_while_and_5 AND not_tmp_260;
  mux1h_nl <= MUX1HOT_v_64_5_2(z_out_7, STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000001"),
      modulo_result_rem_cmp_z, z_out_6, (z_out_5(63 DOWNTO 0)), STD_LOGIC_VECTOR'(
      or_994_nl & and_dcpl_138 & modExp_while_if_and_1_nl & modExp_while_if_and_2_nl
      & and_dcpl_108));
  and_126_nl <= and_dcpl_33 AND and_dcpl_102;
  or_533_nl <= (fsm_output(1)) OR (NOT (fsm_output(7)));
  mux_457_nl <= MUX_s_1_2_2(or_533_nl, or_tmp_484, fsm_output(8));
  mux_458_nl <= MUX_s_1_2_2(mux_457_nl, (NOT and_dcpl_86), fsm_output(2));
  mux_459_nl <= MUX_s_1_2_2(or_826_cse, mux_458_nl, fsm_output(3));
  nor_222_nl <= NOT((fsm_output(6)) OR mux_459_nl);
  nor_223_nl <= NOT((fsm_output(3)) OR mux_tmp_455);
  nor_224_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(1)))
      OR (fsm_output(7)));
  mux_453_nl <= MUX_s_1_2_2(and_dcpl_66, and_tmp_6, fsm_output(2));
  mux_454_nl <= MUX_s_1_2_2(nor_224_nl, mux_453_nl, fsm_output(3));
  mux_456_nl <= MUX_s_1_2_2(nor_223_nl, mux_454_nl, fsm_output(6));
  mux_460_nl <= MUX_s_1_2_2(nor_222_nl, mux_456_nl, fsm_output(0));
  nor_225_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(8)) OR and_dcpl_65);
  or_527_nl <= (fsm_output(2)) OR (NOT and_tmp_8);
  mux_450_nl <= MUX_s_1_2_2(nor_225_nl, or_527_nl, fsm_output(3));
  mux_451_nl <= MUX_s_1_2_2(mux_tmp_448, mux_450_nl, fsm_output(6));
  mux_449_nl <= MUX_s_1_2_2(mux_tmp_448, mux_tmp_440, fsm_output(6));
  mux_452_nl <= MUX_s_1_2_2(mux_451_nl, mux_449_nl, fsm_output(0));
  mux_461_nl <= MUX_s_1_2_2(mux_460_nl, mux_452_nl, fsm_output(4));
  mux_443_nl <= MUX_s_1_2_2(or_tmp_470, or_826_cse, fsm_output(2));
  or_524_nl <= (fsm_output(2)) OR (fsm_output(8)) OR (fsm_output(7));
  mux_444_nl <= MUX_s_1_2_2(mux_443_nl, or_524_nl, fsm_output(3));
  or_526_nl <= (fsm_output(6)) OR mux_444_nl;
  or_523_nl <= (fsm_output(6)) OR or_tmp_476;
  mux_445_nl <= MUX_s_1_2_2(or_526_nl, or_523_nl, fsm_output(0));
  mux_446_nl <= MUX_s_1_2_2(or_814_cse, mux_445_nl, fsm_output(4));
  mux_462_nl <= MUX_s_1_2_2(mux_461_nl, mux_446_nl, fsm_output(9));
  or_519_nl <= (fsm_output(8)) OR and_dcpl_65;
  mux_441_nl <= MUX_s_1_2_2(or_519_nl, and_tmp_8, fsm_output(2));
  or_520_nl <= (fsm_output(3)) OR (NOT mux_441_nl);
  mux_442_nl <= MUX_s_1_2_2(or_520_nl, mux_tmp_440, or_913_cse);
  or_522_nl <= (fsm_output(9)) OR (NOT((fsm_output(4)) OR mux_442_nl));
  mux_463_nl <= MUX_s_1_2_2(mux_462_nl, or_522_nl, fsm_output(5));
  operator_64_false_mux1h_2_rgt <= MUX1HOT_v_65_3_2(z_out_5, (STD_LOGIC_VECTOR'(
      "00") & operator_64_false_slc_modExp_exp_63_1_3), ('0' & mux1h_nl), STD_LOGIC_VECTOR'(
      and_126_nl & and_dcpl_123 & (NOT mux_463_nl)));
  and_524_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  or_1038_cse <= (fsm_output(5)) OR (NOT (fsm_output(9)));
  or_1035_nl <= (fsm_output(5)) OR (fsm_output(9));
  mux_894_cse <= MUX_s_1_2_2(or_1035_nl, or_55_cse, fsm_output(4));
  or_1047_cse <= (NOT (fsm_output(4))) OR (fsm_output(5)) OR (fsm_output(9));
  and_141_m1c <= and_dcpl_48 AND nor_236_cse AND and_dcpl_130;
  modExp_result_and_rgt <= (NOT modExp_while_and_5) AND and_141_m1c;
  modExp_result_and_1_rgt <= modExp_while_and_5 AND and_141_m1c;
  or_590_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  or_913_cse <= (NOT (fsm_output(0))) OR (fsm_output(6));
  or_596_cse <= (NOT (fsm_output(6))) OR (fsm_output(0));
  nand_119_cse <= NOT(CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("11")));
  or_614_cse <= (NOT (fsm_output(2))) OR (fsm_output(3)) OR (fsm_output(8));
  mux_561_cse <= MUX_s_1_2_2(or_tmp_573, or_614_cse, fsm_output(7));
  or_611_cse <= (fsm_output(2)) OR (fsm_output(3)) OR (fsm_output(8));
  mux_560_cse <= MUX_s_1_2_2(or_611_cse, or_tmp_573, fsm_output(7));
  and_300_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11"));
  nor_330_cse <= NOT((NOT (fsm_output(8))) OR (fsm_output(3)) OR (fsm_output(0))
      OR (fsm_output(1)) OR (fsm_output(2)) OR (fsm_output(4)));
  and_221_nl <= (fsm_output(8)) AND (fsm_output(3));
  nor_174_nl <= NOT((fsm_output(8)) OR (fsm_output(3)));
  mux_680_cse <= MUX_s_1_2_2(and_221_nl, nor_174_nl, fsm_output(1));
  COMP_LOOP_or_1_cse <= (and_dcpl_33 AND and_dcpl_41) OR (and_dcpl_47 AND (fsm_output(8))
      AND and_dcpl_76 AND and_dcpl_41);
  or_94_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"));
  or_756_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  and_213_cse <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("11"));
  or_787_nl <= (NOT (fsm_output(0))) OR (fsm_output(6)) OR (fsm_output(9)) OR (NOT
      (fsm_output(8))) OR (fsm_output(3)) OR (fsm_output(4)) OR (fsm_output(5));
  mux_749_cse <= MUX_s_1_2_2(or_tmp_451, or_787_nl, fsm_output(7));
  or_786_nl <= (NOT (fsm_output(9))) OR (fsm_output(8)) OR (fsm_output(3)) OR (fsm_output(4))
      OR (fsm_output(5));
  or_785_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_173;
  mux_746_nl <= MUX_s_1_2_2(or_786_nl, or_785_nl, fsm_output(6));
  mux_747_nl <= MUX_s_1_2_2(or_tmp_449, mux_746_nl, fsm_output(0));
  mux_748_cse <= MUX_s_1_2_2(mux_747_nl, or_tmp_451, fsm_output(7));
  or_780_nl <= (NOT (fsm_output(6))) OR (fsm_output(9)) OR (fsm_output(8)) OR not_tmp_173;
  mux_745_cse <= MUX_s_1_2_2(or_tmp_449, or_780_nl, fsm_output(0));
  and_205_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)=STD_LOGIC_VECTOR'("11"));
  or_814_cse <= CONV_SL_1_1(fsm_output(8 DOWNTO 6)/=STD_LOGIC_VECTOR'("000"));
  or_826_cse <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00"));
  COMP_LOOP_or_3_cse <= (and_dcpl_49 AND and_dcpl_45) OR (and_dcpl_38 AND and_dcpl_60)
      OR (and_dcpl_66 AND and_256_cse AND and_dcpl_45) OR (and_dcpl_73 AND and_256_cse
      AND and_dcpl_60) OR (and_dcpl_31 AND (fsm_output(8)) AND nor_236_cse AND and_dcpl_82)
      OR (and_dcpl_87 AND and_dcpl_29) OR (and_dcpl_87 AND and_dcpl_82) OR (and_dcpl_32
      AND and_dcpl_76 AND and_dcpl_28 AND (fsm_output(9)) AND (NOT (fsm_output(5))));
  operator_64_false_slc_modExp_exp_63_1_3 <= MUX_v_63_2_2((operator_66_true_div_cmp_z(63
      DOWNTO 1)), (tmp_10_lpi_4_dfm(63 DOWNTO 1)), and_dcpl_134);
  modExp_base_1_sva_mx1 <= MUX_v_64_2_2(modulo_result_rem_cmp_z, z_out_6, modulo_result_rem_cmp_z(63));
  modExp_while_and_3 <= (NOT (modulo_result_rem_cmp_z(63))) AND VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  modExp_while_and_5 <= (modulo_result_rem_cmp_z(63)) AND VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  nor_332_cse <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00")));
  or_tmp_29 <= nor_332_cse OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  and_303_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11"));
  or_tmp_31 <= and_303_cse OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  or_55_cse <= (fsm_output(9)) OR (NOT (fsm_output(5)));
  or_54_cse <= (NOT (fsm_output(4))) OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  or_tmp_51 <= (fsm_output(1)) OR (fsm_output(2)) OR (fsm_output(4));
  or_tmp_61 <= (fsm_output(2)) OR (NOT (fsm_output(4)));
  or_tmp_71 <= (NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("01"))))
      OR (fsm_output(9));
  or_tmp_72 <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("01"));
  or_91_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00"));
  mux_tmp_72 <= MUX_s_1_2_2(or_91_nl, or_tmp_72, fsm_output(7));
  or_tmp_77 <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  or_tmp_79 <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  mux_tmp_84 <= MUX_s_1_2_2(or_tmp_79, or_tmp_72, fsm_output(7));
  mux_tmp_86 <= MUX_s_1_2_2(or_tmp_79, (fsm_output(9)), fsm_output(7));
  or_103_nl <= (fsm_output(8)) OR (NOT (fsm_output(1))) OR (fsm_output(2));
  or_102_nl <= (NOT (fsm_output(8))) OR (fsm_output(1)) OR (fsm_output(2));
  mux_tmp_92 <= MUX_s_1_2_2(or_103_nl, or_102_nl, fsm_output(3));
  and_dcpl_13 <= NOT((fsm_output(9)) OR (fsm_output(5)));
  nor_tmp_34 <= (fsm_output(5)) AND (fsm_output(9));
  nor_312_cse <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 6)/=STD_LOGIC_VECTOR'("000")));
  or_901_nl <= (fsm_output(2)) OR (fsm_output(3)) OR (fsm_output(5)) OR (fsm_output(6))
      OR (fsm_output(7)) OR (fsm_output(8));
  mux_157_nl <= MUX_s_1_2_2(or_901_nl, nor_312_cse, fsm_output(9));
  nand_100_nl <= NOT((fsm_output(9)) AND (((fsm_output(2)) AND (fsm_output(3)) AND
      (fsm_output(5))) OR CONV_SL_1_1(fsm_output(8 DOWNTO 6)/=STD_LOGIC_VECTOR'("000"))));
  mux_158_nl <= MUX_s_1_2_2(mux_157_nl, nand_100_nl, or_590_cse);
  nand_101_nl <= NOT((fsm_output(9)) AND (CONV_SL_1_1(fsm_output(8 DOWNTO 5)/=STD_LOGIC_VECTOR'("0000"))));
  not_tmp_77 <= MUX_s_1_2_2(mux_158_nl, nand_101_nl, fsm_output(4));
  and_dcpl_28 <= NOT((fsm_output(6)) OR (fsm_output(0)) OR (fsm_output(4)));
  and_dcpl_29 <= and_dcpl_28 AND and_dcpl_13;
  and_dcpl_31 <= NOT((fsm_output(7)) OR (fsm_output(1)));
  and_dcpl_32 <= and_dcpl_31 AND (NOT (fsm_output(8)));
  and_dcpl_33 <= and_dcpl_32 AND nor_236_cse;
  and_dcpl_38 <= and_dcpl_32 AND and_256_cse;
  and_dcpl_40 <= (NOT (fsm_output(9))) AND (fsm_output(5));
  and_dcpl_41 <= and_dcpl_28 AND and_dcpl_40;
  and_dcpl_43 <= (NOT (fsm_output(6))) AND (fsm_output(0));
  and_dcpl_44 <= and_dcpl_43 AND (fsm_output(4));
  and_dcpl_45 <= and_dcpl_44 AND and_dcpl_40;
  and_dcpl_46 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_47 <= (NOT (fsm_output(7))) AND (fsm_output(1));
  and_dcpl_48 <= and_dcpl_47 AND (NOT (fsm_output(8)));
  and_dcpl_49 <= and_dcpl_48 AND and_dcpl_46;
  and_dcpl_51 <= (fsm_output(6)) AND (NOT (fsm_output(0)));
  and_dcpl_52 <= and_dcpl_51 AND (fsm_output(4));
  nor_tmp_40 <= (fsm_output(8)) AND (fsm_output(1));
  nor_310_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(8)) OR (fsm_output(1)));
  nor_311_nl <= NOT((fsm_output(2)) OR (NOT nor_tmp_40));
  not_tmp_91 <= MUX_s_1_2_2(nor_310_nl, nor_311_nl, fsm_output(3));
  mux_tmp_162 <= MUX_s_1_2_2(or_596_cse, or_913_cse, fsm_output(7));
  or_tmp_148 <= (fsm_output(9)) OR (NOT (fsm_output(7))) OR (fsm_output(0)) OR (NOT
      (fsm_output(6)));
  and_dcpl_60 <= and_dcpl_52 AND and_dcpl_40;
  and_dcpl_65 <= (fsm_output(7)) AND (NOT (fsm_output(1)));
  and_dcpl_66 <= and_dcpl_65 AND (NOT (fsm_output(8)));
  and_dcpl_72 <= (fsm_output(7)) AND (fsm_output(1));
  and_dcpl_73 <= and_dcpl_72 AND (NOT (fsm_output(8)));
  and_dcpl_76 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_82 <= (fsm_output(6)) AND (fsm_output(0)) AND (NOT (fsm_output(4))) AND
      and_dcpl_13;
  and_dcpl_86 <= and_dcpl_72 AND (fsm_output(8));
  and_dcpl_87 <= and_dcpl_86 AND nor_236_cse;
  not_tmp_108 <= NOT((fsm_output(2)) AND (fsm_output(9)));
  or_tmp_264 <= (fsm_output(2)) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("01")) OR (fsm_output(1)) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  or_tmp_278 <= CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (fsm_output(1))) OR (fsm_output(7)) OR (NOT (fsm_output(8))) OR (fsm_output(9));
  or_tmp_321 <= (fsm_output(2)) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("10")) OR (fsm_output(1)) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  or_tmp_334 <= CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (fsm_output(1))) OR (fsm_output(7)) OR (NOT (fsm_output(8))) OR (fsm_output(9));
  or_tmp_374 <= (fsm_output(2)) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("11")) OR (fsm_output(1)) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  or_tmp_387 <= CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (NOT (fsm_output(1))) OR (fsm_output(7)) OR (NOT (fsm_output(8))) OR (fsm_output(9));
  and_dcpl_101 <= and_dcpl_43 AND (NOT (fsm_output(4)));
  and_dcpl_102 <= and_dcpl_101 AND and_dcpl_13;
  and_dcpl_103 <= and_dcpl_48 AND and_dcpl_76;
  and_dcpl_104 <= and_dcpl_103 AND and_dcpl_102;
  mux_tmp_317 <= MUX_s_1_2_2((NOT or_756_cse), and_303_cse, fsm_output(2));
  mux_tmp_318 <= MUX_s_1_2_2((NOT (fsm_output(4))), (fsm_output(4)), fsm_output(3));
  or_tmp_404 <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("10"));
  mux_tmp_319 <= MUX_s_1_2_2((NOT or_tmp_404), mux_tmp_318, fsm_output(2));
  nor_tmp_63 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("111"));
  or_899_cse <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00"));
  nor_tmp_64 <= or_899_cse AND (fsm_output(4));
  or_tmp_415 <= NOT(nand_119_cse AND (fsm_output(4)));
  mux_324_nl <= MUX_s_1_2_2(nor_tmp_64, or_tmp_415, fsm_output(5));
  mux_323_nl <= MUX_s_1_2_2((NOT mux_tmp_317), nor_tmp_64, fsm_output(5));
  mux_tmp_325 <= MUX_s_1_2_2((NOT mux_324_nl), mux_323_nl, fsm_output(8));
  mux_327_nl <= MUX_s_1_2_2(and_303_cse, or_tmp_415, fsm_output(5));
  mux_326_nl <= MUX_s_1_2_2((NOT nor_tmp_63), and_303_cse, fsm_output(5));
  mux_328_nl <= MUX_s_1_2_2((NOT mux_327_nl), mux_326_nl, fsm_output(8));
  mux_tmp_329 <= MUX_s_1_2_2(mux_328_nl, mux_tmp_325, fsm_output(1));
  mux_tmp_335 <= MUX_s_1_2_2((fsm_output(3)), (fsm_output(4)), fsm_output(2));
  mux_336_nl <= MUX_s_1_2_2(mux_tmp_335, or_tmp_415, fsm_output(5));
  mux_334_nl <= MUX_s_1_2_2((NOT mux_tmp_317), and_303_cse, fsm_output(5));
  mux_tmp_337 <= MUX_s_1_2_2((NOT mux_336_nl), mux_334_nl, fsm_output(8));
  mux_332_nl <= MUX_s_1_2_2((NOT nor_tmp_64), (fsm_output(4)), fsm_output(5));
  mux_330_nl <= MUX_s_1_2_2(mux_tmp_318, (fsm_output(3)), fsm_output(2));
  mux_331_nl <= MUX_s_1_2_2((NOT mux_330_nl), nor_tmp_64, fsm_output(5));
  mux_333_nl <= MUX_s_1_2_2(mux_332_nl, mux_331_nl, fsm_output(8));
  mux_tmp_338 <= MUX_s_1_2_2(mux_tmp_337, mux_333_nl, fsm_output(1));
  mux_tmp_340 <= MUX_s_1_2_2((NOT and_303_cse), nor_tmp_64, fsm_output(5));
  or_tmp_416 <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("01"));
  mux_tmp_345 <= MUX_s_1_2_2(mux_tmp_318, or_tmp_416, fsm_output(2));
  mux_tmp_350 <= MUX_s_1_2_2(and_303_cse, mux_tmp_345, fsm_output(5));
  mux_tmp_373 <= MUX_s_1_2_2((NOT (fsm_output(5))), (fsm_output(5)), fsm_output(4));
  or_tmp_421 <= (NOT((NOT (fsm_output(8))) OR (fsm_output(2)))) OR (fsm_output(9))
      OR mux_tmp_373;
  or_tmp_423 <= (fsm_output(9)) OR (fsm_output(4)) OR (NOT (fsm_output(5)));
  or_tmp_426 <= (NOT (fsm_output(2))) OR (fsm_output(9)) OR mux_tmp_373;
  mux_374_nl <= MUX_s_1_2_2(or_55_cse, or_tmp_423, fsm_output(2));
  mux_tmp_375 <= MUX_s_1_2_2(or_tmp_426, mux_374_nl, fsm_output(8));
  or_462_cse <= (fsm_output(2)) OR (fsm_output(9)) OR (fsm_output(4)) OR (NOT (fsm_output(5)));
  mux_376_nl <= MUX_s_1_2_2(or_462_cse, or_55_cse, fsm_output(8));
  mux_377_nl <= MUX_s_1_2_2(mux_376_nl, mux_tmp_375, fsm_output(1));
  mux_tmp_378 <= MUX_s_1_2_2(mux_377_nl, or_tmp_421, fsm_output(3));
  or_467_nl <= (fsm_output(2)) OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  mux_tmp_379 <= MUX_s_1_2_2(or_tmp_426, or_467_nl, fsm_output(8));
  mux_tmp_380 <= MUX_s_1_2_2(or_tmp_426, or_55_cse, fsm_output(8));
  mux_381_nl <= MUX_s_1_2_2(mux_tmp_380, mux_tmp_379, fsm_output(1));
  or_465_nl <= (NOT((fsm_output(1)) OR (NOT (fsm_output(8))) OR (fsm_output(2))))
      OR (fsm_output(9)) OR mux_tmp_373;
  mux_tmp_382 <= MUX_s_1_2_2(mux_381_nl, or_465_nl, fsm_output(3));
  or_tmp_436 <= (fsm_output(9)) OR (NOT (fsm_output(4)));
  or_tmp_437 <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("01"));
  or_tmp_438 <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("10"));
  mux_tmp_393 <= MUX_s_1_2_2((NOT (fsm_output(4))), or_tmp_438, fsm_output(9));
  not_tmp_170 <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("11")));
  mux_396_nl <= MUX_s_1_2_2(not_tmp_170, or_tmp_438, fsm_output(9));
  mux_397_nl <= MUX_s_1_2_2(mux_396_nl, mux_tmp_393, fsm_output(2));
  or_475_nl <= (fsm_output(9)) OR not_tmp_170;
  mux_395_nl <= MUX_s_1_2_2(or_tmp_423, or_475_nl, fsm_output(2));
  mux_tmp_398 <= MUX_s_1_2_2(mux_397_nl, mux_395_nl, fsm_output(8));
  and_dcpl_105 <= NOT((fsm_output(7)) OR (fsm_output(2)));
  nor_232_nl <= NOT((fsm_output(8)) OR (NOT (fsm_output(1))));
  nor_233_nl <= NOT((NOT (fsm_output(8))) OR (fsm_output(1)));
  mux_416_nl <= MUX_s_1_2_2(nor_232_nl, nor_233_nl, fsm_output(3));
  and_dcpl_107 <= mux_416_nl AND and_dcpl_105 AND and_dcpl_41;
  not_tmp_173 <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 3)=STD_LOGIC_VECTOR'("111")));
  or_tmp_449 <= (fsm_output(6)) OR (fsm_output(9)) OR (fsm_output(8)) OR not_tmp_173;
  or_tmp_451 <= (fsm_output(0)) OR (NOT (fsm_output(6))) OR (fsm_output(9)) OR (NOT
      (fsm_output(8))) OR (fsm_output(3)) OR (fsm_output(4)) OR (fsm_output(5));
  nand_40_nl <= NOT((fsm_output(2)) AND (NOT mux_748_cse));
  nand_39_nl <= NOT((fsm_output(7)) AND (NOT mux_745_cse));
  mux_419_nl <= MUX_s_1_2_2(mux_749_cse, nand_39_nl, fsm_output(2));
  mux_423_itm <= MUX_s_1_2_2(nand_40_nl, mux_419_nl, fsm_output(1));
  or_tmp_455 <= (NOT (fsm_output(3))) OR (fsm_output(4)) OR (fsm_output(9)) OR (NOT
      (fsm_output(0))) OR (fsm_output(6));
  nand_87_nl <= NOT((fsm_output(4)) AND (fsm_output(9)) AND (fsm_output(0)) AND (NOT
      (fsm_output(6))));
  or_498_nl <= (fsm_output(4)) OR (fsm_output(9)) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  mux_427_nl <= MUX_s_1_2_2(nand_87_nl, or_498_nl, fsm_output(3));
  mux_428_nl <= MUX_s_1_2_2(mux_427_nl, or_tmp_455, fsm_output(7));
  or_496_nl <= (NOT (fsm_output(7))) OR (NOT (fsm_output(3))) OR (fsm_output(4))
      OR (fsm_output(9)) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  mux_429_nl <= MUX_s_1_2_2(mux_428_nl, or_496_nl, fsm_output(1));
  or_909_nl <= (fsm_output(2)) OR mux_429_nl;
  or_910_nl <= (NOT (fsm_output(7))) OR (fsm_output(3)) OR (NOT (fsm_output(4)))
      OR (fsm_output(9)) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  or_911_nl <= (fsm_output(7)) OR (NOT (fsm_output(3))) OR (fsm_output(4)) OR (fsm_output(9))
      OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_425_nl <= MUX_s_1_2_2(or_910_nl, or_911_nl, fsm_output(1));
  or_491_nl <= (NOT (fsm_output(3))) OR (fsm_output(4)) OR (fsm_output(9)) OR (fsm_output(0))
      OR (NOT (fsm_output(6)));
  mux_424_nl <= MUX_s_1_2_2(or_491_nl, or_tmp_455, fsm_output(7));
  nand_113_nl <= NOT((fsm_output(1)) AND (NOT mux_424_nl));
  mux_426_nl <= MUX_s_1_2_2(mux_425_nl, nand_113_nl, fsm_output(2));
  mux_430_nl <= MUX_s_1_2_2(or_909_nl, mux_426_nl, fsm_output(8));
  and_dcpl_108 <= NOT(mux_430_nl OR (fsm_output(5)));
  and_dcpl_109 <= NOT((fsm_output(4)) OR (fsm_output(9)));
  and_dcpl_110 <= and_dcpl_109 AND (fsm_output(5));
  mux_tmp_431 <= MUX_s_1_2_2((NOT (fsm_output(7))), (fsm_output(7)), fsm_output(1));
  and_tmp_6 <= (fsm_output(8)) AND mux_tmp_431;
  or_tmp_470 <= (fsm_output(8)) OR (NOT (fsm_output(1))) OR (fsm_output(7));
  or_503_nl <= (fsm_output(8)) OR (fsm_output(1)) OR (NOT (fsm_output(7)));
  mux_432_nl <= MUX_s_1_2_2(or_tmp_470, or_503_nl, fsm_output(2));
  or_501_nl <= (fsm_output(2)) OR (NOT and_tmp_6);
  mux_433_itm <= MUX_s_1_2_2(mux_432_nl, or_501_nl, fsm_output(3));
  nand_tmp_42 <= NOT((fsm_output(6)) AND (NOT mux_433_itm));
  or_507_nl <= (NOT (fsm_output(2))) OR (fsm_output(8)) OR (fsm_output(1)) OR (NOT
      (fsm_output(7)));
  or_505_nl <= (fsm_output(2)) OR (NOT and_dcpl_86);
  mux_434_nl <= MUX_s_1_2_2(or_507_nl, or_505_nl, fsm_output(3));
  or_508_nl <= (fsm_output(6)) OR mux_434_nl;
  mux_435_nl <= MUX_s_1_2_2(or_508_nl, nand_tmp_42, fsm_output(0));
  and_dcpl_111 <= (NOT mux_435_nl) AND and_dcpl_110;
  and_dcpl_117 <= (NOT((NOT((fsm_output(1)) XOR (fsm_output(2)))) OR (fsm_output(7))
      OR (fsm_output(8)) OR (fsm_output(3)))) AND (NOT (fsm_output(6))) AND (NOT
      (fsm_output(4))) AND and_dcpl_13;
  or_tmp_476 <= and_256_cse OR CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00"));
  and_tmp_7 <= (fsm_output(9)) AND ((fsm_output(4)) OR (fsm_output(6)) OR or_tmp_476);
  and_dcpl_119 <= (NOT (fsm_output(8))) AND (fsm_output(2));
  nor_227_nl <= NOT((fsm_output(0)) OR (fsm_output(3)));
  and_253_nl <= (fsm_output(0)) AND (fsm_output(3));
  mux_438_nl <= MUX_s_1_2_2(nor_227_nl, and_253_nl, fsm_output(4));
  and_dcpl_123 <= mux_438_nl AND and_dcpl_47 AND and_dcpl_119 AND (NOT (fsm_output(6)))
      AND and_dcpl_13;
  or_tmp_483 <= (fsm_output(2)) OR (NOT (fsm_output(8))) OR (fsm_output(1)) OR (NOT
      (fsm_output(7)));
  mux_439_nl <= MUX_s_1_2_2(or_tmp_470, (fsm_output(8)), fsm_output(2));
  mux_tmp_440 <= MUX_s_1_2_2((NOT mux_439_nl), or_tmp_483, fsm_output(3));
  or_tmp_484 <= (NOT (fsm_output(1))) OR (fsm_output(7));
  and_tmp_8 <= (fsm_output(8)) AND or_tmp_484;
  mux_447_nl <= MUX_s_1_2_2(or_tmp_470, and_tmp_8, fsm_output(2));
  mux_tmp_448 <= MUX_s_1_2_2((NOT mux_447_nl), or_tmp_483, fsm_output(3));
  or_531_nl <= (fsm_output(8)) OR (fsm_output(1)) OR (fsm_output(7));
  mux_tmp_455 <= MUX_s_1_2_2(or_826_cse, or_531_nl, fsm_output(2));
  nor_362_nl <= NOT((NOT (fsm_output(9))) OR (fsm_output(1)) OR (fsm_output(3)) OR
      (fsm_output(4)) OR (fsm_output(6)) OR (fsm_output(7)));
  nor_363_nl <= NOT((fsm_output(9)) OR (NOT((fsm_output(1)) AND (fsm_output(3)) AND
      (fsm_output(4)) AND (fsm_output(6)) AND (fsm_output(7)))));
  mux_673_nl <= MUX_s_1_2_2(nor_362_nl, nor_363_nl, fsm_output(5));
  and_dcpl_129 <= mux_673_nl AND and_dcpl_119 AND (NOT (fsm_output(0)));
  and_dcpl_130 <= and_dcpl_44 AND and_dcpl_13;
  and_dcpl_134 <= and_dcpl_48 AND and_256_cse AND and_dcpl_130;
  or_571_nl <= (fsm_output(8)) OR (NOT mux_tmp_431);
  or_570_nl <= (NOT (fsm_output(8))) OR (NOT (fsm_output(1))) OR (fsm_output(7));
  mux_503_nl <= MUX_s_1_2_2(or_571_nl, or_570_nl, fsm_output(2));
  mux_tmp_504 <= MUX_s_1_2_2(mux_503_nl, or_tmp_483, fsm_output(3));
  or_572_nl <= (fsm_output(6)) OR mux_tmp_504;
  mux_505_nl <= MUX_s_1_2_2(nand_tmp_42, or_572_nl, fsm_output(0));
  and_dcpl_138 <= (NOT mux_505_nl) AND and_dcpl_110;
  nor_tmp_81 <= CONV_SL_1_1(fsm_output(5 DOWNTO 3)=STD_LOGIC_VECTOR'("111"));
  and_306_nl <= (fsm_output(3)) AND (fsm_output(5));
  mux_tmp_506 <= MUX_s_1_2_2(and_306_nl, nor_tmp_81, fsm_output(2));
  nor_tmp_83 <= or_899_cse AND CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("11"));
  nor_211_nl <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00")));
  mux_508_nl <= MUX_s_1_2_2(nor_211_nl, and_213_cse, fsm_output(3));
  mux_tmp_509 <= MUX_s_1_2_2(mux_508_nl, nor_tmp_81, fsm_output(2));
  or_tmp_539 <= NOT(nand_119_cse AND and_213_cse);
  nor_tmp_86 <= or_tmp_416 AND (fsm_output(5));
  mux_tmp_522 <= MUX_s_1_2_2(nor_tmp_81, nor_tmp_86, fsm_output(2));
  or_tmp_548 <= NOT((fsm_output(8)) AND (fsm_output(2)) AND (NOT (fsm_output(3)))
      AND (fsm_output(4)));
  or_587_nl <= (fsm_output(8)) OR (fsm_output(2)) OR (fsm_output(3)) OR (NOT (fsm_output(4)));
  mux_tmp_530 <= MUX_s_1_2_2(or_587_nl, or_tmp_548, fsm_output(1));
  nor_208_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("10"))
      OR mux_tmp_530);
  or_588_nl <= (fsm_output(8)) OR (NOT (fsm_output(2))) OR (NOT (fsm_output(3)))
      OR (fsm_output(4));
  mux_531_nl <= MUX_s_1_2_2(or_tmp_548, or_588_nl, fsm_output(1));
  mux_532_nl <= MUX_s_1_2_2(mux_531_nl, mux_tmp_530, fsm_output(7));
  and_239_nl <= (fsm_output(6)) AND (NOT mux_532_nl);
  not_tmp_231 <= MUX_s_1_2_2(nor_208_nl, and_239_nl, fsm_output(0));
  or_tmp_562 <= (((fsm_output(2)) OR (NOT (fsm_output(7)))) AND (fsm_output(3)))
      OR (fsm_output(4));
  or_600_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("000"));
  mux_tmp_537 <= MUX_s_1_2_2(or_600_nl, or_tmp_562, fsm_output(8));
  or_tmp_567 <= (NOT((NOT (fsm_output(2))) OR (fsm_output(7)) OR (NOT (fsm_output(3)))))
      OR (fsm_output(4));
  mux_tmp_546 <= MUX_s_1_2_2((NOT or_756_cse), or_756_cse, fsm_output(7));
  mux_tmp_549 <= MUX_s_1_2_2(mux_tmp_546, or_tmp_567, fsm_output(8));
  or_tmp_573 <= (fsm_output(2)) OR (NOT((fsm_output(3)) AND (fsm_output(8))));
  and_dcpl_147 <= and_dcpl_101 AND and_dcpl_40;
  nor_nl <= NOT((fsm_output(1)) OR (fsm_output(8)));
  mux_tmp_579 <= MUX_s_1_2_2(nor_nl, nor_tmp_40, fsm_output(2));
  and_dcpl_154 <= mux_tmp_579 AND (NOT (fsm_output(7))) AND (NOT (fsm_output(3)));
  nor_189_nl <= NOT((fsm_output(6)) OR (NOT (fsm_output(2))) OR (NOT (fsm_output(4)))
      OR (NOT (fsm_output(5))) OR (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(3)));
  nor_190_nl <= NOT((fsm_output(6)) OR (NOT (fsm_output(2))) OR (NOT (fsm_output(4)))
      OR (NOT (fsm_output(5))) OR (fsm_output(9)) OR (fsm_output(8)) OR (NOT (fsm_output(3))));
  mux_584_nl <= MUX_s_1_2_2(nor_189_nl, nor_190_nl, fsm_output(7));
  nor_191_nl <= NOT((fsm_output(6)) OR (NOT (fsm_output(2))) OR (fsm_output(4)) OR
      (NOT (fsm_output(5))) OR (fsm_output(9)) OR (fsm_output(8)) OR (NOT (fsm_output(3))));
  nor_192_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(2)) OR (fsm_output(4)) OR
      (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(3)));
  mux_583_nl <= MUX_s_1_2_2(nor_191_nl, nor_192_nl, fsm_output(7));
  mux_585_nl <= MUX_s_1_2_2(mux_584_nl, mux_583_nl, fsm_output(1));
  nor_193_nl <= NOT((fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(5)) OR (fsm_output(9))
      OR (NOT (fsm_output(8))) OR (fsm_output(3)));
  nor_194_nl <= NOT((NOT (fsm_output(2))) OR (NOT (fsm_output(4))) OR (NOT (fsm_output(5)))
      OR (fsm_output(9)) OR (fsm_output(8)) OR (NOT (fsm_output(3))));
  mux_581_nl <= MUX_s_1_2_2(nor_193_nl, nor_194_nl, fsm_output(6));
  and_229_nl <= (fsm_output(7)) AND mux_581_nl;
  or_643_nl <= (fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(8)) OR (fsm_output(3));
  or_642_nl <= (fsm_output(2)) OR (NOT (fsm_output(4))) OR (NOT (fsm_output(5)))
      OR (fsm_output(9)) OR (fsm_output(8)) OR (NOT (fsm_output(3)));
  mux_580_nl <= MUX_s_1_2_2(or_643_nl, or_642_nl, fsm_output(6));
  nor_195_nl <= NOT((fsm_output(7)) OR mux_580_nl);
  mux_582_nl <= MUX_s_1_2_2(and_229_nl, nor_195_nl, fsm_output(1));
  not_tmp_260 <= MUX_s_1_2_2(mux_585_nl, mux_582_nl, fsm_output(0));
  or_tmp_621 <= (NOT (fsm_output(2))) OR (NOT (fsm_output(4))) OR (fsm_output(8));
  or_tmp_623 <= (fsm_output(4)) OR (NOT (fsm_output(8)));
  or_659_nl <= (NOT (fsm_output(4))) OR (fsm_output(8));
  mux_tmp_588 <= MUX_s_1_2_2(or_tmp_623, or_659_nl, fsm_output(2));
  mux_tmp_589 <= MUX_s_1_2_2(mux_tmp_588, or_tmp_621, fsm_output(1));
  mux_tmp_594 <= MUX_s_1_2_2((fsm_output(4)), or_tmp_623, fsm_output(2));
  mux_598_nl <= MUX_s_1_2_2((fsm_output(4)), or_tmp_623, or_94_cse);
  or_669_nl <= (NOT(CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"))))
      OR (NOT (fsm_output(4))) OR (fsm_output(8));
  mux_tmp_599 <= MUX_s_1_2_2(mux_598_nl, or_669_nl, fsm_output(3));
  or_tmp_635 <= (fsm_output(4)) OR (fsm_output(8));
  or_tmp_637 <= (fsm_output(2)) OR (NOT (fsm_output(4))) OR (fsm_output(8));
  nor_tmp_103 <= (fsm_output(2)) AND (fsm_output(4));
  or_73_nl <= (fsm_output(2)) OR (fsm_output(4));
  mux_623_nl <= MUX_s_1_2_2(or_73_nl, (NOT nor_tmp_103), fsm_output(3));
  mux_54_nl <= MUX_s_1_2_2((fsm_output(4)), or_tmp_51, fsm_output(3));
  mux_tmp_624 <= MUX_s_1_2_2(mux_623_nl, mux_54_nl, fsm_output(8));
  or_tmp_654 <= (NOT(VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm OR (NOT (fsm_output(1)))))
      OR (fsm_output(2)) OR (fsm_output(4));
  or_tmp_656 <= (((NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (fsm_output(1)))
      AND (fsm_output(2))) OR (fsm_output(4));
  or_694_nl <= (fsm_output(3)) OR or_tmp_656;
  mux_636_nl <= MUX_s_1_2_2((fsm_output(4)), or_tmp_654, fsm_output(3));
  mux_tmp_637 <= MUX_s_1_2_2(or_694_nl, mux_636_nl, fsm_output(8));
  or_tmp_670 <= (NOT (fsm_output(2))) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  or_708_nl <= (fsm_output(2)) OR (fsm_output(0)) OR (fsm_output(6));
  mux_tmp_668 <= MUX_s_1_2_2(or_708_nl, or_tmp_670, fsm_output(7));
  mux_tmp_711 <= MUX_s_1_2_2((NOT (fsm_output(7))), (fsm_output(7)), fsm_output(6));
  mux_tmp_722 <= MUX_s_1_2_2((fsm_output(4)), (fsm_output(7)), fsm_output(5));
  or_tmp_716 <= (NOT (fsm_output(4))) OR (fsm_output(7));
  mux_tmp_723 <= MUX_s_1_2_2((NOT or_tmp_716), (fsm_output(7)), fsm_output(5));
  and_tmp_14 <= (fsm_output(5)) AND or_tmp_716;
  and_dcpl_175 <= and_dcpl_154 AND and_dcpl_147;
  nand_74_nl <= NOT((fsm_output(6)) AND (fsm_output(1)) AND (fsm_output(7)) AND (fsm_output(8))
      AND (NOT (fsm_output(2))));
  or_797_nl <= (fsm_output(6)) OR (fsm_output(1)) OR (NOT (fsm_output(7))) OR (NOT
      (fsm_output(8))) OR (fsm_output(2));
  mux_756_nl <= MUX_s_1_2_2(nand_74_nl, or_797_nl, fsm_output(0));
  nor_158_nl <= NOT((fsm_output(4)) OR mux_756_nl);
  nor_159_nl <= NOT((fsm_output(4)) OR (fsm_output(0)) OR (fsm_output(6)) OR (NOT
      (fsm_output(1))) OR (fsm_output(7)) OR (fsm_output(8)) OR (fsm_output(2)));
  mux_757_nl <= MUX_s_1_2_2(nor_158_nl, nor_159_nl, fsm_output(5));
  nor_160_nl <= NOT((fsm_output(0)) OR (fsm_output(6)) OR (fsm_output(1)) OR (fsm_output(7))
      OR (NOT (fsm_output(8))) OR (fsm_output(2)));
  nor_161_nl <= NOT((fsm_output(6)) OR (fsm_output(1)) OR (NOT (fsm_output(7))) OR
      (fsm_output(8)) OR (NOT (fsm_output(2))));
  nor_162_nl <= NOT((NOT (fsm_output(7))) OR (fsm_output(8)) OR (NOT (fsm_output(2))));
  nor_163_nl <= NOT((fsm_output(7)) OR (fsm_output(8)) OR (fsm_output(2)));
  mux_753_nl <= MUX_s_1_2_2(nor_162_nl, nor_163_nl, fsm_output(1));
  and_209_nl <= (fsm_output(6)) AND mux_753_nl;
  mux_754_nl <= MUX_s_1_2_2(nor_161_nl, and_209_nl, fsm_output(0));
  mux_755_nl <= MUX_s_1_2_2(nor_160_nl, mux_754_nl, fsm_output(4));
  and_208_nl <= (fsm_output(5)) AND mux_755_nl;
  mux_758_nl <= MUX_s_1_2_2(mux_757_nl, and_208_nl, fsm_output(3));
  nor_164_nl <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 0)/=STD_LOGIC_VECTOR'("000000011")));
  not_tmp_321 <= MUX_s_1_2_2(mux_758_nl, nor_164_nl, fsm_output(9));
  or_tmp_760 <= (NOT((NOT (fsm_output(8))) OR (fsm_output(4)))) OR (fsm_output(9))
      OR (NOT (fsm_output(5)));
  or_801_nl <= (NOT((fsm_output(8)) OR (NOT (fsm_output(4))))) OR (fsm_output(9))
      OR (NOT (fsm_output(5)));
  mux_tmp_760 <= MUX_s_1_2_2(or_tmp_760, or_801_nl, fsm_output(3));
  or_tmp_762 <= (NOT((fsm_output(7)) OR (fsm_output(8)) OR (NOT (fsm_output(4)))))
      OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  or_tmp_769 <= (NOT((NOT (fsm_output(7))) OR (NOT (fsm_output(8))) OR (fsm_output(4))))
      OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  mux_tmp_763 <= MUX_s_1_2_2(or_1038_cse, or_55_cse, fsm_output(4));
  and_292_nl <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("11"));
  mux_tmp_771 <= MUX_s_1_2_2(or_54_cse, mux_894_cse, and_292_nl);
  and_dcpl_176 <= NOT((fsm_output(0)) OR (fsm_output(9)));
  nor_150_nl <= NOT((fsm_output(4)) OR (NOT (fsm_output(6))) OR (fsm_output(3)) OR
      (NOT (fsm_output(8))) OR (fsm_output(1)));
  nor_151_nl <= NOT((NOT (fsm_output(4))) OR (fsm_output(6)) OR (NOT (fsm_output(3)))
      OR (fsm_output(8)) OR (NOT (fsm_output(1))));
  not_tmp_324 <= MUX_s_1_2_2(nor_150_nl, nor_151_nl, fsm_output(5));
  or_831_nl <= (fsm_output(2)) OR (fsm_output(8)) OR (NOT and_dcpl_72);
  mux_784_nl <= MUX_s_1_2_2(or_831_nl, or_tmp_483, fsm_output(3));
  or_832_nl <= (fsm_output(6)) OR mux_784_nl;
  mux_785_nl <= MUX_s_1_2_2(nand_tmp_42, or_832_nl, fsm_output(0));
  and_dcpl_179 <= (NOT mux_785_nl) AND and_dcpl_110;
  or_27_nl <= (NOT (fsm_output(6))) OR (fsm_output(3));
  mux_tmp_787 <= MUX_s_1_2_2(mux_894_cse, or_54_cse, or_27_nl);
  mux_796_nl <= MUX_s_1_2_2(or_1038_cse, or_55_cse, or_756_cse);
  mux_797_nl <= MUX_s_1_2_2(mux_796_nl, or_tmp_29, fsm_output(6));
  mux_798_nl <= MUX_s_1_2_2(mux_797_nl, or_tmp_31, and_524_cse);
  mux_799_nl <= MUX_s_1_2_2(mux_798_nl, or_tmp_29, fsm_output(7));
  nor_132_nl <= NOT((NOT (fsm_output(7))) OR (fsm_output(0)) OR (fsm_output(1)) OR
      (NOT (fsm_output(6))));
  mux_795_nl <= MUX_s_1_2_2(or_tmp_31, or_tmp_29, nor_132_nl);
  mux_800_nl <= MUX_s_1_2_2(mux_799_nl, mux_795_nl, fsm_output(2));
  mux_792_nl <= MUX_s_1_2_2(mux_tmp_787, or_tmp_29, or_590_cse);
  mux_39_nl <= MUX_s_1_2_2(mux_894_cse, or_54_cse, fsm_output(3));
  or_843_nl <= (NOT((NOT((fsm_output(6)) OR (NOT (fsm_output(3))))) OR (fsm_output(4))))
      OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  mux_790_nl <= MUX_s_1_2_2(mux_39_nl, or_843_nl, fsm_output(1));
  mux_788_nl <= MUX_s_1_2_2(mux_tmp_787, or_tmp_29, fsm_output(1));
  mux_791_nl <= MUX_s_1_2_2(mux_790_nl, mux_788_nl, fsm_output(0));
  mux_793_nl <= MUX_s_1_2_2(mux_792_nl, mux_791_nl, fsm_output(7));
  mux_794_nl <= MUX_s_1_2_2(mux_793_nl, or_tmp_29, fsm_output(2));
  mux_801_itm <= MUX_s_1_2_2(mux_800_nl, mux_794_nl, fsm_output(8));
  STAGE_LOOP_i_3_0_sva_mx0c1 <= and_dcpl_38 AND and_dcpl_28 AND nor_tmp_34;
  VEC_LOOP_j_1_12_0_sva_11_0_mx0c1 <= and_dcpl_49 AND and_dcpl_101 AND nor_tmp_34;
  or_9_nl <= (fsm_output(8)) OR (fsm_output(3)) OR (fsm_output(7)) OR (fsm_output(6));
  or_556_nl <= (fsm_output(6)) OR (fsm_output(3)) OR mux_tmp_455;
  mux_495_nl <= MUX_s_1_2_2(or_9_nl, or_556_nl, fsm_output(0));
  nor_217_nl <= NOT((fsm_output(4)) OR mux_495_nl);
  mux_496_nl <= MUX_s_1_2_2(nor_217_nl, or_814_cse, fsm_output(9));
  modExp_result_sva_mx0c0 <= MUX_s_1_2_2(mux_496_nl, and_tmp_7, fsm_output(5));
  or_914_nl <= (fsm_output(0)) OR (NOT (fsm_output(6))) OR (fsm_output(3)) OR (fsm_output(2))
      OR (NOT (fsm_output(8))) OR (fsm_output(1));
  or_915_nl <= (NOT (fsm_output(0))) OR (fsm_output(6)) OR (NOT (fsm_output(3)))
      OR (NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(1)));
  mux_501_nl <= MUX_s_1_2_2(or_914_nl, or_915_nl, fsm_output(4));
  or_916_nl <= (NOT (fsm_output(4))) OR (fsm_output(0)) OR (fsm_output(6)) OR (NOT
      (fsm_output(3))) OR (fsm_output(2)) OR (fsm_output(8)) OR (NOT (fsm_output(1)));
  mux_502_nl <= MUX_s_1_2_2(mux_501_nl, or_916_nl, fsm_output(5));
  nor_359_m1c <= NOT(mux_502_nl OR (fsm_output(7)) OR (fsm_output(9)));
  and_160_m1c <= and_dcpl_73 AND nor_236_cse AND and_dcpl_147;
  and_163_m1c <= and_dcpl_65 AND (fsm_output(8)) AND and_dcpl_46 AND and_dcpl_147;
  or_184_nl <= (NOT (fsm_output(9))) OR (fsm_output(7)) OR (NOT (fsm_output(0)))
      OR (fsm_output(6));
  mux_165_cse <= MUX_s_1_2_2(or_184_nl, or_tmp_148, fsm_output(8));
  or_180_nl <= (fsm_output(9)) OR (fsm_output(7)) OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_163_cse <= MUX_s_1_2_2(or_tmp_148, or_180_nl, fsm_output(8));
  and_61_nl <= not_tmp_91 AND (NOT (fsm_output(7))) AND and_dcpl_52 AND and_dcpl_13;
  or_186_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00")) OR mux_tmp_162;
  mux_166_nl <= MUX_s_1_2_2(or_186_nl, mux_165_cse, fsm_output(3));
  nor_307_nl <= NOT((fsm_output(2)) OR mux_166_nl);
  nor_308_nl <= NOT((fsm_output(3)) OR mux_163_cse);
  nor_309_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(8))) OR (fsm_output(9)) OR
      mux_tmp_162);
  mux_164_nl <= MUX_s_1_2_2(nor_308_nl, nor_309_nl, fsm_output(2));
  mux_167_nl <= MUX_s_1_2_2(nor_307_nl, mux_164_nl, fsm_output(1));
  and_63_nl <= mux_167_nl AND CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("10"));
  nor_304_nl <= NOT((fsm_output(3)) OR (fsm_output(9)) OR (fsm_output(7)));
  nor_305_nl <= NOT((NOT (fsm_output(3))) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  mux_169_nl <= MUX_s_1_2_2(nor_304_nl, nor_305_nl, fsm_output(8));
  and_283_nl <= (NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("110"))))
      AND mux_169_nl;
  or_190_nl <= (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_189_nl <= (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_168_nl <= MUX_s_1_2_2(or_190_nl, or_189_nl, fsm_output(3));
  nor_306_nl <= NOT((NOT (fsm_output(4))) OR (fsm_output(5)) OR (fsm_output(6)) OR
      (fsm_output(8)) OR mux_168_nl);
  mux_170_nl <= MUX_s_1_2_2(and_283_nl, nor_306_nl, fsm_output(2));
  and_65_nl <= mux_170_nl AND CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  nor_301_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(1))));
  nor_302_nl <= NOT((NOT (fsm_output(2))) OR (NOT (fsm_output(8))) OR (fsm_output(1)));
  mux_172_nl <= MUX_s_1_2_2(nor_301_nl, nor_302_nl, fsm_output(3));
  and_282_nl <= (fsm_output(4)) AND (fsm_output(6)) AND mux_172_nl;
  nor_303_nl <= NOT((fsm_output(4)) OR (fsm_output(6)) OR mux_tmp_92);
  mux_173_nl <= MUX_s_1_2_2(and_282_nl, nor_303_nl, fsm_output(5));
  and_70_nl <= mux_173_nl AND (fsm_output(7)) AND (NOT (fsm_output(0))) AND (NOT
      (fsm_output(9)));
  or_209_nl <= (NOT (fsm_output(2))) OR (NOT (fsm_output(8))) OR (fsm_output(7));
  or_208_nl <= (fsm_output(2)) OR (NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("11"))));
  mux_175_nl <= MUX_s_1_2_2(or_209_nl, or_208_nl, fsm_output(3));
  nor_299_nl <= NOT((NOT (fsm_output(4))) OR (fsm_output(6)) OR mux_175_nl);
  or_205_nl <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("01"));
  or_204_nl <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("10"));
  mux_174_nl <= MUX_s_1_2_2(or_205_nl, or_204_nl, fsm_output(2));
  nor_300_nl <= NOT((fsm_output(4)) OR (NOT (fsm_output(6))) OR (fsm_output(3)) OR
      mux_174_nl);
  mux_176_nl <= MUX_s_1_2_2(nor_299_nl, nor_300_nl, fsm_output(5));
  and_77_nl <= mux_176_nl AND (fsm_output(1)) AND (fsm_output(0)) AND (NOT (fsm_output(9)));
  vec_rsc_0_0_i_adra_d_pff <= MUX1HOT_v_10_7_2(z_out_1, (z_out_6(12 DOWNTO 3)), COMP_LOOP_acc_psp_1_sva,
      (COMP_LOOP_acc_10_cse_12_1_1_sva(11 DOWNTO 2)), (COMP_LOOP_acc_1_cse_5_sva(11
      DOWNTO 2)), (COMP_LOOP_acc_11_psp_1_sva(10 DOWNTO 1)), (COMP_LOOP_acc_1_cse_2_sva(11
      DOWNTO 2)), STD_LOGIC_VECTOR'( COMP_LOOP_or_1_cse & COMP_LOOP_or_3_cse & and_61_nl
      & and_63_nl & and_65_nl & and_70_nl & and_77_nl));
  vec_rsc_0_0_i_da_d_pff <= modExp_base_1_sva_mx1;
  nor_292_nl <= NOT((NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR mux_190_cse);
  or_224_nl <= (VEC_LOOP_j_1_12_0_sva_11_0(1)) OR CONV_SL_1_1(fsm_output(9 DOWNTO
      7)/=STD_LOGIC_VECTOR'("000"));
  or_223_nl <= (COMP_LOOP_acc_11_psp_1_sva(0)) OR CONV_SL_1_1(fsm_output(9 DOWNTO
      7)/=STD_LOGIC_VECTOR'("001"));
  mux_181_nl <= MUX_s_1_2_2(or_224_nl, or_223_nl, fsm_output(1));
  nor_294_nl <= NOT((NOT (fsm_output(2))) OR (VEC_LOOP_j_1_12_0_sva_11_0(0)) OR mux_181_nl);
  nor_295_nl <= NOT((NOT (fsm_output(1))) OR CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  nor_296_nl <= NOT((fsm_output(1)) OR (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0)) OR (COMP_LOOP_acc_11_psp_1_sva(0))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011")));
  mux_180_nl <= MUX_s_1_2_2(nor_295_nl, nor_296_nl, fsm_output(2));
  mux_182_nl <= MUX_s_1_2_2(nor_294_nl, mux_180_nl, fsm_output(3));
  nand_11_nl <= NOT((fsm_output(6)) AND mux_182_nl);
  nor_297_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  nor_298_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  mux_178_nl <= MUX_s_1_2_2(nor_297_nl, nor_298_nl, fsm_output(1));
  nand_10_nl <= NOT((fsm_output(2)) AND mux_178_nl);
  or_213_nl <= (NOT (fsm_output(1))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("00")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  or_211_nl <= (fsm_output(1)) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("00")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("100"));
  mux_177_nl <= MUX_s_1_2_2(or_213_nl, or_211_nl, fsm_output(2));
  mux_179_nl <= MUX_s_1_2_2(nand_10_nl, mux_177_nl, fsm_output(3));
  or_217_nl <= (fsm_output(6)) OR mux_179_nl;
  mux_183_nl <= MUX_s_1_2_2(nand_11_nl, or_217_nl, fsm_output(0));
  nor_293_nl <= NOT((fsm_output(5)) OR mux_183_nl);
  vec_rsc_0_0_i_wea_d_pff <= MUX_s_1_2_2(nor_292_nl, nor_293_nl, fsm_output(4));
  or_254_cse <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")) OR (NOT
      (fsm_output(7))) OR (NOT (fsm_output(2))) OR (fsm_output(9));
  or_266_nl <= (fsm_output(1)) OR (fsm_output(7)) OR CONV_SL_1_1(z_out_6(2 DOWNTO
      1)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_108;
  or_264_nl <= (NOT (fsm_output(1))) OR (NOT (fsm_output(7))) OR (fsm_output(2))
      OR (fsm_output(9));
  mux_204_nl <= MUX_s_1_2_2(or_266_nl, or_264_nl, fsm_output(8));
  or_267_nl <= (fsm_output(3)) OR mux_204_nl;
  or_263_nl <= (fsm_output(3)) OR (fsm_output(8)) OR (fsm_output(1)) OR (fsm_output(7))
      OR CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_108;
  or_261_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"));
  mux_205_nl <= MUX_s_1_2_2(or_267_nl, or_263_nl, or_261_nl);
  or_259_nl <= (VEC_LOOP_j_1_12_0_sva_11_0(1)) OR (fsm_output(7)) OR (fsm_output(2))
      OR (fsm_output(9));
  or_258_nl <= (COMP_LOOP_acc_11_psp_1_sva(0)) OR (NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm)
      OR (NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(9));
  mux_201_nl <= MUX_s_1_2_2(or_259_nl, or_258_nl, fsm_output(1));
  or_260_nl <= (VEC_LOOP_j_1_12_0_sva_11_0(0)) OR mux_201_nl;
  or_257_nl <= CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (fsm_output(1))) OR (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(9));
  mux_202_nl <= MUX_s_1_2_2(or_260_nl, or_257_nl, fsm_output(8));
  or_256_nl <= (NOT (fsm_output(8))) OR (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0)) OR (fsm_output(1))
      OR (COMP_LOOP_acc_11_psp_1_sva(0)) OR (NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm)
      OR (NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(9));
  mux_203_nl <= MUX_s_1_2_2(mux_202_nl, or_256_nl, fsm_output(3));
  mux_206_nl <= MUX_s_1_2_2(mux_205_nl, mux_203_nl, fsm_output(5));
  nor_282_nl <= NOT((fsm_output(0)) OR mux_206_nl);
  or_253_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(7))
      OR (fsm_output(2)) OR (fsm_output(9));
  mux_200_nl <= MUX_s_1_2_2(or_254_cse, or_253_nl, fsm_output(1));
  nor_283_nl <= NOT((NOT((fsm_output(0)) AND (fsm_output(5)) AND (fsm_output(3))
      AND (NOT (fsm_output(8))))) OR mux_200_nl);
  mux_207_nl <= MUX_s_1_2_2(nor_282_nl, nor_283_nl, fsm_output(4));
  nor_284_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")) OR
      (fsm_output(7)) OR (fsm_output(2)) OR (fsm_output(9)));
  nor_285_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")) OR
      (NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(9)));
  mux_197_nl <= MUX_s_1_2_2(nor_284_nl, nor_285_nl, fsm_output(1));
  and_281_nl <= (NOT((fsm_output(3)) OR (NOT (fsm_output(8))))) AND mux_197_nl;
  nor_286_nl <= NOT((NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR (fsm_output(7))
      OR (fsm_output(2)) OR (fsm_output(9)));
  nor_287_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (NOT (fsm_output(7)))
      OR (fsm_output(2)) OR (fsm_output(9)));
  mux_193_nl <= MUX_s_1_2_2(nor_286_nl, nor_287_nl, fsm_output(1));
  nor_288_nl <= NOT((NOT (fsm_output(1))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR (NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(9)));
  or_246_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  mux_194_nl <= MUX_s_1_2_2(mux_193_nl, nor_288_nl, or_246_nl);
  nor_289_nl <= NOT((NOT (fsm_output(1))) OR (NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm)
      OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(9)));
  mux_195_nl <= MUX_s_1_2_2(mux_194_nl, nor_289_nl, fsm_output(8));
  nor_290_nl <= NOT((NOT (fsm_output(8))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(1)) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR (NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(9)));
  mux_196_nl <= MUX_s_1_2_2(mux_195_nl, nor_290_nl, fsm_output(3));
  mux_198_nl <= MUX_s_1_2_2(and_281_nl, mux_196_nl, fsm_output(5));
  and_280_nl <= (fsm_output(0)) AND mux_198_nl;
  or_242_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(7))
      OR (NOT (fsm_output(2))) OR (fsm_output(9));
  mux_192_nl <= MUX_s_1_2_2(or_242_nl, or_254_cse, fsm_output(1));
  nor_291_nl <= NOT((fsm_output(0)) OR (NOT (fsm_output(5))) OR (NOT (fsm_output(3)))
      OR (fsm_output(8)) OR mux_192_nl);
  mux_199_nl <= MUX_s_1_2_2(and_280_nl, nor_291_nl, fsm_output(4));
  vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_207_nl, mux_199_nl,
      fsm_output(6));
  nor_274_nl <= NOT((NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR mux_190_cse);
  nor_277_nl <= NOT((COMP_LOOP_acc_11_psp_1_sva(0)) OR CONV_SL_1_1(fsm_output(9 DOWNTO
      7)/=STD_LOGIC_VECTOR'("001")));
  mux_213_nl <= MUX_s_1_2_2(nor_268_cse, nor_277_nl, fsm_output(1));
  and_279_nl <= (fsm_output(2)) AND (VEC_LOOP_j_1_12_0_sva_11_0(0)) AND mux_213_nl;
  nor_278_nl <= NOT((NOT (fsm_output(1))) OR CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  nor_279_nl <= NOT((fsm_output(1)) OR (NOT (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0)))
      OR (COMP_LOOP_acc_11_psp_1_sva(0)) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011")));
  mux_212_nl <= MUX_s_1_2_2(nor_278_nl, nor_279_nl, fsm_output(2));
  mux_214_nl <= MUX_s_1_2_2(and_279_nl, mux_212_nl, fsm_output(3));
  nand_17_nl <= NOT((fsm_output(6)) AND mux_214_nl);
  nor_280_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  nor_281_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  mux_210_nl <= MUX_s_1_2_2(nor_280_nl, nor_281_nl, fsm_output(1));
  nand_15_nl <= NOT((fsm_output(2)) AND mux_210_nl);
  or_271_nl <= (NOT (fsm_output(1))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  or_269_nl <= (fsm_output(1)) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("100"));
  mux_209_nl <= MUX_s_1_2_2(or_271_nl, or_269_nl, fsm_output(2));
  mux_211_nl <= MUX_s_1_2_2(nand_15_nl, mux_209_nl, fsm_output(3));
  or_275_nl <= (fsm_output(6)) OR mux_211_nl;
  mux_215_nl <= MUX_s_1_2_2(nand_17_nl, or_275_nl, fsm_output(0));
  nor_275_nl <= NOT((fsm_output(5)) OR mux_215_nl);
  vec_rsc_0_1_i_wea_d_pff <= MUX_s_1_2_2(nor_274_nl, nor_275_nl, fsm_output(4));
  or_322_nl <= (fsm_output(1)) OR (fsm_output(7)) OR CONV_SL_1_1(z_out_6(2 DOWNTO
      1)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  mux_240_nl <= MUX_s_1_2_2(nand_95_cse, or_322_nl, fsm_output(2));
  or_324_nl <= (fsm_output(3)) OR mux_240_nl;
  or_320_nl <= (fsm_output(3)) OR (NOT (fsm_output(2))) OR (fsm_output(1)) OR (fsm_output(7))
      OR CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  or_318_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01"));
  mux_241_nl <= MUX_s_1_2_2(or_324_nl, or_320_nl, or_318_nl);
  mux_236_nl <= MUX_s_1_2_2(nor_268_cse, nor_269_cse, fsm_output(1));
  nand_22_nl <= NOT((VEC_LOOP_j_1_12_0_sva_11_0(0)) AND mux_236_nl);
  mux_237_nl <= MUX_s_1_2_2(nand_22_nl, or_tmp_278, fsm_output(2));
  mux_238_nl <= MUX_s_1_2_2(mux_237_nl, or_315_cse, fsm_output(3));
  or_313_nl <= (NOT (VEC_LOOP_j_1_12_0_sva_11_0(0))) OR (fsm_output(1)) OR (VEC_LOOP_j_1_12_0_sva_11_0(1))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000"));
  mux_235_nl <= MUX_s_1_2_2(or_313_nl, or_tmp_278, fsm_output(2));
  or_314_nl <= (fsm_output(3)) OR mux_235_nl;
  or_311_nl <= (NOT VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR (COMP_LOOP_acc_11_psp_1_sva(0));
  mux_239_nl <= MUX_s_1_2_2(mux_238_nl, or_314_nl, or_311_nl);
  mux_242_nl <= MUX_s_1_2_2(mux_241_nl, mux_239_nl, fsm_output(5));
  nor_267_nl <= NOT((fsm_output(0)) OR mux_242_nl);
  nor_270_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR
      (NOT (fsm_output(1))) OR (fsm_output(7)) OR (fsm_output(8)) OR (fsm_output(9)));
  nor_271_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR
      (fsm_output(1)) OR (NOT (fsm_output(7))) OR (fsm_output(8)) OR (fsm_output(9)));
  mux_234_nl <= MUX_s_1_2_2(nor_270_nl, nor_271_nl, fsm_output(2));
  and_276_nl <= (fsm_output(0)) AND (fsm_output(5)) AND (fsm_output(3)) AND mux_234_nl;
  mux_243_nl <= MUX_s_1_2_2(nor_267_nl, and_276_nl, fsm_output(4));
  or_307_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("010"));
  or_306_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  mux_231_nl <= MUX_s_1_2_2(or_307_nl, or_306_nl, fsm_output(1));
  or_308_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")) OR mux_231_nl;
  or_299_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR (NOT
      VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  mux_225_nl <= MUX_s_1_2_2(or_299_nl, or_tmp_264, fsm_output(3));
  or_303_nl <= (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  mux_226_nl <= MUX_s_1_2_2(or_304_cse, or_303_nl, fsm_output(1));
  or_302_nl <= (NOT (fsm_output(1))) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  or_301_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"));
  mux_227_nl <= MUX_s_1_2_2(mux_226_nl, or_302_nl, or_301_nl);
  or_300_nl <= (NOT (fsm_output(1))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("01")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010"));
  mux_228_nl <= MUX_s_1_2_2(mux_227_nl, or_300_nl, fsm_output(2));
  mux_229_nl <= MUX_s_1_2_2(mux_228_nl, or_tmp_264, fsm_output(3));
  mux_230_nl <= MUX_s_1_2_2(mux_225_nl, mux_229_nl, VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm);
  mux_232_nl <= MUX_s_1_2_2(or_308_nl, mux_230_nl, fsm_output(5));
  and_277_nl <= (fsm_output(0)) AND (NOT mux_232_nl);
  nor_272_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR
      CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000")));
  nor_273_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR
      CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  mux_224_nl <= MUX_s_1_2_2(nor_272_nl, nor_273_nl, fsm_output(1));
  and_278_nl <= (NOT (fsm_output(0))) AND (fsm_output(5)) AND (fsm_output(3)) AND
      (fsm_output(2)) AND mux_224_nl;
  mux_233_nl <= MUX_s_1_2_2(and_277_nl, and_278_nl, fsm_output(4));
  vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_243_nl, mux_233_nl,
      fsm_output(6));
  and_274_nl <= (NOT((NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")))) AND mux_258_cse;
  or_338_nl <= (NOT (COMP_LOOP_acc_11_psp_1_sva(0))) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  mux_249_nl <= MUX_s_1_2_2(or_370_cse, or_338_nl, fsm_output(1));
  nor_262_nl <= NOT((NOT (fsm_output(2))) OR (VEC_LOOP_j_1_12_0_sva_11_0(0)) OR mux_249_nl);
  nor_263_nl <= NOT((NOT (fsm_output(1))) OR CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  nor_264_nl <= NOT((fsm_output(1)) OR (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0)) OR (NOT
      (COMP_LOOP_acc_11_psp_1_sva(0))) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011")));
  mux_248_nl <= MUX_s_1_2_2(nor_263_nl, nor_264_nl, fsm_output(2));
  mux_250_nl <= MUX_s_1_2_2(nor_262_nl, mux_248_nl, fsm_output(3));
  nand_24_nl <= NOT((fsm_output(6)) AND mux_250_nl);
  nor_265_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  nor_266_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  mux_246_nl <= MUX_s_1_2_2(nor_265_nl, nor_266_nl, fsm_output(1));
  nand_23_nl <= NOT((fsm_output(2)) AND mux_246_nl);
  or_328_nl <= (NOT (fsm_output(1))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  or_326_nl <= (fsm_output(1)) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("100"));
  mux_245_nl <= MUX_s_1_2_2(or_328_nl, or_326_nl, fsm_output(2));
  mux_247_nl <= MUX_s_1_2_2(nand_23_nl, mux_245_nl, fsm_output(3));
  or_332_nl <= (fsm_output(6)) OR mux_247_nl;
  mux_251_nl <= MUX_s_1_2_2(nand_24_nl, or_332_nl, fsm_output(0));
  nor_261_nl <= NOT((fsm_output(5)) OR mux_251_nl);
  vec_rsc_0_2_i_wea_d_pff <= MUX_s_1_2_2(and_274_nl, nor_261_nl, fsm_output(4));
  or_379_nl <= (fsm_output(3)) OR (NOT (fsm_output(2))) OR (fsm_output(1)) OR (fsm_output(7))
      OR CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  or_375_nl <= (fsm_output(1)) OR (fsm_output(7)) OR CONV_SL_1_1(z_out_6(2 DOWNTO
      1)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  mux_276_nl <= MUX_s_1_2_2(nand_95_cse, or_375_nl, fsm_output(2));
  or_377_nl <= (fsm_output(3)) OR mux_276_nl;
  nor_54_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")));
  mux_277_nl <= MUX_s_1_2_2(or_379_nl, or_377_nl, nor_54_nl);
  or_372_nl <= (VEC_LOOP_j_1_12_0_sva_11_0(0)) OR (fsm_output(1)) OR (NOT (VEC_LOOP_j_1_12_0_sva_11_0(1)))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000"));
  mux_274_nl <= MUX_s_1_2_2(or_372_nl, or_tmp_334, fsm_output(2));
  or_373_nl <= (fsm_output(3)) OR mux_274_nl;
  mux_271_nl <= MUX_s_1_2_2(or_370_cse, or_369_cse, fsm_output(1));
  or_371_nl <= (VEC_LOOP_j_1_12_0_sva_11_0(0)) OR mux_271_nl;
  mux_272_nl <= MUX_s_1_2_2(or_371_nl, or_tmp_334, fsm_output(2));
  or_367_nl <= (fsm_output(2)) OR (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0)) OR (fsm_output(1))
      OR (NOT (fsm_output(7))) OR (NOT (fsm_output(8))) OR (fsm_output(9));
  mux_273_nl <= MUX_s_1_2_2(mux_272_nl, or_367_nl, fsm_output(3));
  mux_275_nl <= MUX_s_1_2_2(or_373_nl, mux_273_nl, and_270_cse);
  mux_278_nl <= MUX_s_1_2_2(mux_277_nl, mux_275_nl, fsm_output(5));
  nor_255_nl <= NOT((fsm_output(0)) OR mux_278_nl);
  nor_256_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR
      (NOT (fsm_output(1))) OR (fsm_output(7)) OR (fsm_output(8)) OR (fsm_output(9)));
  nor_257_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR
      (fsm_output(1)) OR (NOT (fsm_output(7))) OR (fsm_output(8)) OR (fsm_output(9)));
  mux_270_nl <= MUX_s_1_2_2(nor_256_nl, nor_257_nl, fsm_output(2));
  and_271_nl <= (fsm_output(0)) AND (fsm_output(5)) AND (fsm_output(3)) AND mux_270_nl;
  mux_279_nl <= MUX_s_1_2_2(nor_255_nl, and_271_nl, fsm_output(4));
  or_363_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("010"));
  or_362_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  mux_267_nl <= MUX_s_1_2_2(or_363_nl, or_362_nl, fsm_output(1));
  or_364_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")) OR mux_267_nl;
  or_356_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR (NOT
      VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  mux_261_nl <= MUX_s_1_2_2(or_356_nl, or_tmp_321, fsm_output(3));
  or_360_nl <= (NOT (fsm_output(1))) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  or_358_nl <= (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  mux_262_nl <= MUX_s_1_2_2(or_304_cse, or_358_nl, fsm_output(1));
  nor_51_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10")));
  mux_263_nl <= MUX_s_1_2_2(or_360_nl, mux_262_nl, nor_51_nl);
  or_357_nl <= (NOT (fsm_output(1))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("10")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010"));
  mux_264_nl <= MUX_s_1_2_2(mux_263_nl, or_357_nl, fsm_output(2));
  mux_265_nl <= MUX_s_1_2_2(mux_264_nl, or_tmp_321, fsm_output(3));
  mux_266_nl <= MUX_s_1_2_2(mux_261_nl, mux_265_nl, VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm);
  mux_268_nl <= MUX_s_1_2_2(or_364_nl, mux_266_nl, fsm_output(5));
  and_272_nl <= (fsm_output(0)) AND (NOT mux_268_nl);
  nor_258_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR
      CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000")));
  nor_259_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR
      CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  mux_260_nl <= MUX_s_1_2_2(nor_258_nl, nor_259_nl, fsm_output(1));
  and_273_nl <= (NOT (fsm_output(0))) AND (fsm_output(5)) AND (fsm_output(3)) AND
      (fsm_output(2)) AND mux_260_nl;
  mux_269_nl <= MUX_s_1_2_2(and_272_nl, and_273_nl, fsm_output(4));
  vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_279_nl, mux_269_nl,
      fsm_output(6));
  and_267_nl <= (fsm_output(5)) AND CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1
      DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND mux_258_cse;
  nor_250_nl <= NOT((NOT (COMP_LOOP_acc_11_psp_1_sva(0))) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  mux_285_nl <= MUX_s_1_2_2(nor_241_cse, nor_250_nl, fsm_output(1));
  and_269_nl <= (fsm_output(2)) AND (VEC_LOOP_j_1_12_0_sva_11_0(0)) AND mux_285_nl;
  nor_251_nl <= NOT((NOT (fsm_output(1))) OR CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  nor_252_nl <= NOT((fsm_output(1)) OR (NOT (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0)))
      OR (NOT (COMP_LOOP_acc_11_psp_1_sva(0))) OR CONV_SL_1_1(fsm_output(9 DOWNTO
      7)/=STD_LOGIC_VECTOR'("011")));
  mux_284_nl <= MUX_s_1_2_2(nor_251_nl, nor_252_nl, fsm_output(2));
  mux_286_nl <= MUX_s_1_2_2(and_269_nl, mux_284_nl, fsm_output(3));
  nand_32_nl <= NOT((fsm_output(6)) AND mux_286_nl);
  nor_253_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  nor_254_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")));
  mux_282_nl <= MUX_s_1_2_2(nor_253_nl, nor_254_nl, fsm_output(1));
  nand_30_nl <= NOT((fsm_output(2)) AND mux_282_nl);
  nand_112_nl <= NOT((fsm_output(1)) AND CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("011")));
  or_381_nl <= (fsm_output(1)) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("100"));
  mux_281_nl <= MUX_s_1_2_2(nand_112_nl, or_381_nl, fsm_output(2));
  mux_283_nl <= MUX_s_1_2_2(nand_30_nl, mux_281_nl, fsm_output(3));
  or_387_nl <= (fsm_output(6)) OR mux_283_nl;
  mux_287_nl <= MUX_s_1_2_2(nand_32_nl, or_387_nl, fsm_output(0));
  nor_248_nl <= NOT((fsm_output(5)) OR mux_287_nl);
  vec_rsc_0_3_i_wea_d_pff <= MUX_s_1_2_2(and_267_nl, nor_248_nl, fsm_output(4));
  or_431_nl <= (fsm_output(3)) OR (NOT (fsm_output(2))) OR (fsm_output(1)) OR (fsm_output(7))
      OR CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  or_427_nl <= (fsm_output(1)) OR (fsm_output(7)) OR CONV_SL_1_1(z_out_6(2 DOWNTO
      1)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  mux_312_nl <= MUX_s_1_2_2(nand_95_cse, or_427_nl, fsm_output(2));
  or_429_nl <= (fsm_output(3)) OR mux_312_nl;
  and_261_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11"));
  mux_313_nl <= MUX_s_1_2_2(or_431_nl, or_429_nl, and_261_nl);
  or_424_nl <= (NOT (VEC_LOOP_j_1_12_0_sva_11_0(0))) OR (fsm_output(1)) OR (NOT (VEC_LOOP_j_1_12_0_sva_11_0(1)))
      OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000"));
  mux_310_nl <= MUX_s_1_2_2(or_424_nl, or_tmp_387, fsm_output(2));
  or_425_nl <= (fsm_output(3)) OR mux_310_nl;
  mux_307_nl <= MUX_s_1_2_2(nor_241_cse, nor_269_cse, fsm_output(1));
  nand_38_nl <= NOT((VEC_LOOP_j_1_12_0_sva_11_0(0)) AND mux_307_nl);
  mux_308_nl <= MUX_s_1_2_2(nand_38_nl, or_tmp_387, fsm_output(2));
  mux_309_nl <= MUX_s_1_2_2(mux_308_nl, or_315_cse, fsm_output(3));
  mux_311_nl <= MUX_s_1_2_2(or_425_nl, mux_309_nl, and_270_cse);
  mux_314_nl <= MUX_s_1_2_2(mux_313_nl, mux_311_nl, fsm_output(5));
  nor_240_nl <= NOT((fsm_output(0)) OR mux_314_nl);
  nor_243_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11")) OR
      (NOT (fsm_output(1))) OR (fsm_output(7)) OR (fsm_output(8)) OR (fsm_output(9)));
  nor_244_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11")) OR
      (fsm_output(1)) OR (NOT (fsm_output(7))) OR (fsm_output(8)) OR (fsm_output(9)));
  mux_306_nl <= MUX_s_1_2_2(nor_243_nl, nor_244_nl, fsm_output(2));
  and_263_nl <= (fsm_output(0)) AND (fsm_output(5)) AND (fsm_output(3)) AND mux_306_nl;
  mux_315_nl <= MUX_s_1_2_2(nor_240_nl, and_263_nl, fsm_output(4));
  or_416_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9
      DOWNTO 7)/=STD_LOGIC_VECTOR'("010"));
  nand_91_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11")) AND
      CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("011")));
  mux_303_nl <= MUX_s_1_2_2(or_416_nl, nand_91_nl, fsm_output(1));
  or_417_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")) OR mux_303_nl;
  or_409_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01")) OR (NOT
      VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  mux_297_nl <= MUX_s_1_2_2(or_409_nl, or_tmp_374, fsm_output(3));
  nand_92_nl <= NOT((fsm_output(1)) AND VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm
      AND CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("001")));
  or_411_nl <= (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001"));
  mux_298_nl <= MUX_s_1_2_2(or_304_cse, or_411_nl, fsm_output(1));
  and_265_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  mux_299_nl <= MUX_s_1_2_2(nand_92_nl, mux_298_nl, and_265_nl);
  or_410_nl <= (NOT (fsm_output(1))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("11")) OR CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010"));
  mux_300_nl <= MUX_s_1_2_2(mux_299_nl, or_410_nl, fsm_output(2));
  mux_301_nl <= MUX_s_1_2_2(mux_300_nl, or_tmp_374, fsm_output(3));
  mux_302_nl <= MUX_s_1_2_2(mux_297_nl, mux_301_nl, VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm);
  mux_304_nl <= MUX_s_1_2_2(or_417_nl, mux_302_nl, fsm_output(5));
  and_264_nl <= (fsm_output(0)) AND (NOT mux_304_nl);
  nor_245_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11")) OR
      CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000")));
  nor_246_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11")) OR
      CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("001")));
  mux_296_nl <= MUX_s_1_2_2(nor_245_nl, nor_246_nl, fsm_output(1));
  and_266_nl <= (NOT (fsm_output(0))) AND (fsm_output(5)) AND (fsm_output(3)) AND
      (fsm_output(2)) AND mux_296_nl;
  mux_305_nl <= MUX_s_1_2_2(and_264_nl, and_266_nl, fsm_output(4));
  vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_315_nl, mux_305_nl,
      fsm_output(6));
  nor_394_nl <= NOT((fsm_output(1)) OR (NOT (fsm_output(5))) OR (NOT (fsm_output(3)))
      OR (NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(4))));
  nor_395_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(5)) OR (fsm_output(3)) OR
      (fsm_output(2)) OR (NOT (fsm_output(8))) OR (fsm_output(4)));
  mux_824_nl <= MUX_s_1_2_2(nor_394_nl, nor_395_nl, fsm_output(6));
  and_dcpl_196 <= mux_824_nl AND (NOT (fsm_output(9))) AND (fsm_output(7)) AND (fsm_output(0));
  or_tmp_841 <= (NOT (fsm_output(3))) OR (fsm_output(2)) OR (NOT (fsm_output(8)));
  mux_tmp_824 <= MUX_s_1_2_2(or_614_cse, or_tmp_841, fsm_output(1));
  mux_826_cse <= MUX_s_1_2_2(or_tmp_841, or_611_cse, fsm_output(1));
  nor_393_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("10"))
      OR mux_tmp_824);
  mux_827_nl <= MUX_s_1_2_2(mux_826_cse, mux_tmp_824, fsm_output(7));
  and_522_nl <= (fsm_output(6)) AND (NOT mux_827_nl);
  mux_828_nl <= MUX_s_1_2_2(nor_393_nl, and_522_nl, fsm_output(0));
  and_dcpl_199 <= mux_828_nl AND (NOT (fsm_output(4))) AND (fsm_output(5)) AND (NOT
      (fsm_output(9)));
  and_dcpl_200 <= NOT((fsm_output(6)) OR (fsm_output(0)));
  and_dcpl_204 <= (NOT (fsm_output(3))) AND (fsm_output(5));
  and_dcpl_208 <= NOT((fsm_output(8)) OR (fsm_output(4)) OR (fsm_output(2)) OR (NOT
      and_dcpl_204) OR (fsm_output(9)) OR (fsm_output(1)) OR (fsm_output(7)) OR (NOT
      and_dcpl_200));
  and_dcpl_215 <= (fsm_output(8)) AND (NOT (fsm_output(4))) AND (fsm_output(2)) AND
      and_dcpl_204 AND (NOT (fsm_output(9))) AND (fsm_output(1)) AND (NOT (fsm_output(7)))
      AND and_dcpl_200;
  and_dcpl_221 <= mux_680_cse AND (NOT (fsm_output(4))) AND (NOT (fsm_output(2)))
      AND (fsm_output(5)) AND (NOT (fsm_output(9))) AND (NOT (fsm_output(7))) AND
      and_dcpl_200;
  and_dcpl_230 <= NOT((fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(3)) OR (fsm_output(8))
      OR (NOT (fsm_output(5))) OR (fsm_output(9)) OR (fsm_output(1)) OR (fsm_output(7))
      OR (NOT and_dcpl_200));
  and_365_cse <= (fsm_output(2)) AND (NOT (fsm_output(4))) AND (NOT (fsm_output(3)))
      AND (fsm_output(8)) AND (fsm_output(5)) AND (NOT (fsm_output(9))) AND (fsm_output(1))
      AND (NOT (fsm_output(7))) AND and_dcpl_200;
  or_999_nl <= (NOT (fsm_output(1))) OR (NOT (fsm_output(5))) OR (fsm_output(8))
      OR (NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11"))));
  or_1000_nl <= (fsm_output(1)) OR (fsm_output(5)) OR (NOT (fsm_output(8))) OR (fsm_output(3))
      OR (fsm_output(4));
  mux_830_nl <= MUX_s_1_2_2(or_999_nl, or_1000_nl, fsm_output(6));
  and_dcpl_242 <= NOT(mux_830_nl OR (fsm_output(2)) OR (fsm_output(9)) OR (fsm_output(7))
      OR (NOT (fsm_output(0))));
  or_997_nl <= (NOT (fsm_output(7))) OR (NOT (fsm_output(1))) OR (fsm_output(5))
      OR (NOT (fsm_output(8))) OR (fsm_output(3)) OR (fsm_output(4)) OR (fsm_output(2));
  or_998_nl <= (fsm_output(7)) OR (fsm_output(1)) OR (NOT (fsm_output(5))) OR (fsm_output(8))
      OR (NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("111"))));
  mux_831_nl <= MUX_s_1_2_2(or_997_nl, or_998_nl, fsm_output(6));
  and_dcpl_244 <= NOT(mux_831_nl OR (fsm_output(9)) OR (fsm_output(0)));
  and_dcpl_253 <= nor_332_cse AND (NOT (fsm_output(2))) AND (NOT (fsm_output(8)))
      AND (fsm_output(5)) AND (NOT (fsm_output(9))) AND (NOT (fsm_output(1))) AND
      (NOT (fsm_output(7))) AND and_dcpl_200;
  nor_382_nl <= NOT((fsm_output(7)) OR (fsm_output(1)) OR (NOT (fsm_output(9))) OR
      (fsm_output(5)) OR (fsm_output(3)) OR (fsm_output(4)));
  nor_383_nl <= NOT((NOT (fsm_output(7))) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR not_tmp_173);
  mux_833_nl <= MUX_s_1_2_2(nor_382_nl, nor_383_nl, fsm_output(6));
  and_392_cse <= mux_833_nl AND (fsm_output(2)) AND (NOT (fsm_output(8))) AND (NOT
      (fsm_output(0)));
  or_tmp_858 <= (fsm_output(9)) OR (fsm_output(8)) OR (fsm_output(2)) OR (NOT (fsm_output(3)))
      OR (fsm_output(4));
  or_938_nl <= (fsm_output(9)) OR (NOT (fsm_output(8))) OR (NOT (fsm_output(2)))
      OR (NOT (fsm_output(3))) OR (fsm_output(4));
  mux_tmp_833 <= MUX_s_1_2_2(or_tmp_858, or_938_nl, fsm_output(1));
  or_945_nl <= (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(2)) OR (fsm_output(3))
      OR (NOT (fsm_output(4)));
  mux_837_nl <= MUX_s_1_2_2(or_945_nl, or_tmp_858, fsm_output(1));
  mux_838_nl <= MUX_s_1_2_2(mux_tmp_833, mux_837_nl, fsm_output(7));
  nand_140_nl <= NOT((fsm_output(6)) AND (NOT mux_838_nl));
  or_942_nl <= (NOT (fsm_output(9))) OR (fsm_output(8)) OR (fsm_output(2)) OR (fsm_output(3))
      OR (NOT (fsm_output(4)));
  or_940_nl <= (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(2)) OR (NOT
      (fsm_output(3))) OR (fsm_output(4));
  mux_835_nl <= MUX_s_1_2_2(or_942_nl, or_940_nl, fsm_output(1));
  mux_836_nl <= MUX_s_1_2_2(mux_835_nl, mux_tmp_833, fsm_output(7));
  or_993_nl <= (fsm_output(6)) OR mux_836_nl;
  mux_839_nl <= MUX_s_1_2_2(nand_140_nl, or_993_nl, fsm_output(0));
  and_dcpl_283 <= NOT(mux_839_nl OR (fsm_output(5)));
  and_dcpl_288 <= NOT((fsm_output(8)) OR (fsm_output(5)));
  and_dcpl_292 <= nor_332_cse AND (NOT (fsm_output(2))) AND and_dcpl_288 AND (NOT
      (fsm_output(9))) AND (NOT (fsm_output(1))) AND (NOT (fsm_output(7))) AND (NOT
      (fsm_output(6))) AND (fsm_output(0));
  and_dcpl_302 <= nor_332_cse AND (fsm_output(2)) AND and_dcpl_288 AND (NOT (fsm_output(9)))
      AND (fsm_output(1)) AND (NOT (fsm_output(7))) AND and_dcpl_200;
  and_dcpl_310 <= (NOT (fsm_output(4))) AND (fsm_output(3)) AND (fsm_output(2)) AND
      (NOT (fsm_output(8))) AND (fsm_output(5)) AND (fsm_output(9)) AND (NOT (fsm_output(1)))
      AND (NOT (fsm_output(7))) AND and_dcpl_200;
  and_dcpl_314 <= (fsm_output(9)) AND (NOT (fsm_output(1))) AND (NOT (fsm_output(7)))
      AND and_dcpl_200;
  and_dcpl_315 <= (NOT (fsm_output(8))) AND (fsm_output(5));
  and_dcpl_316 <= (fsm_output(2)) AND (NOT (fsm_output(4)));
  and_dcpl_319 <= and_dcpl_316 AND (fsm_output(3)) AND and_dcpl_315 AND and_dcpl_314;
  not_tmp_415 <= MUX_s_1_2_2((fsm_output(6)), (NOT (fsm_output(6))), fsm_output(0));
  or_951_nl <= (fsm_output(8)) OR (fsm_output(7)) OR (fsm_output(9)) OR (NOT (fsm_output(0)))
      OR (fsm_output(6));
  mux_843_nl <= MUX_s_1_2_2(mux_165_cse, or_951_nl, fsm_output(1));
  or_950_nl <= (fsm_output(1)) OR (fsm_output(8)) OR (NOT (fsm_output(7))) OR (fsm_output(9))
      OR not_tmp_415;
  mux_tmp_843 <= MUX_s_1_2_2(mux_843_nl, or_950_nl, fsm_output(5));
  or_959_nl <= (fsm_output(9)) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  or_957_nl <= (fsm_output(9)) OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_tmp_844 <= MUX_s_1_2_2(or_959_nl, or_957_nl, fsm_output(7));
  nand_125_nl <= NOT((fsm_output(1)) AND (fsm_output(8)) AND (NOT mux_tmp_844));
  or_956_nl <= (NOT (fsm_output(1))) OR (fsm_output(8)) OR (fsm_output(7)) OR (fsm_output(9))
      OR not_tmp_415;
  mux_tmp_845 <= MUX_s_1_2_2(nand_125_nl, or_956_nl, fsm_output(5));
  or_965_nl <= (fsm_output(8)) OR mux_tmp_844;
  mux_tmp_849 <= MUX_s_1_2_2(or_965_nl, mux_163_cse, fsm_output(1));
  nand_127_nl <= NOT((fsm_output(8)) AND (NOT mux_tmp_844));
  mux_856_nl <= MUX_s_1_2_2(nand_127_nl, mux_165_cse, fsm_output(1));
  mux_857_nl <= MUX_s_1_2_2(mux_856_nl, mux_tmp_849, fsm_output(5));
  mux_858_nl <= MUX_s_1_2_2(mux_857_nl, mux_tmp_843, fsm_output(4));
  or_966_nl <= (fsm_output(1)) OR mux_165_cse;
  mux_854_nl <= MUX_s_1_2_2(mux_tmp_849, or_966_nl, fsm_output(5));
  mux_855_nl <= MUX_s_1_2_2(mux_854_nl, mux_tmp_845, fsm_output(4));
  mux_859_nl <= MUX_s_1_2_2(mux_858_nl, mux_855_nl, fsm_output(3));
  nand_126_nl <= NOT((fsm_output(5)) AND (fsm_output(1)) AND (fsm_output(8)) AND
      (NOT mux_tmp_844));
  or_963_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_415;
  or_961_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011")) OR not_tmp_415;
  mux_848_nl <= MUX_s_1_2_2(or_963_nl, or_961_nl, fsm_output(1));
  mux_851_nl <= MUX_s_1_2_2(mux_tmp_849, mux_848_nl, fsm_output(5));
  mux_852_nl <= MUX_s_1_2_2(nand_126_nl, mux_851_nl, fsm_output(4));
  mux_847_nl <= MUX_s_1_2_2(mux_tmp_845, mux_tmp_843, fsm_output(4));
  mux_853_nl <= MUX_s_1_2_2(mux_852_nl, mux_847_nl, fsm_output(3));
  mux_860_itm <= MUX_s_1_2_2(mux_859_nl, mux_853_nl, fsm_output(2));
  and_dcpl_321 <= (NOT (fsm_output(9))) AND (fsm_output(1));
  and_dcpl_323 <= and_dcpl_321 AND (NOT (fsm_output(7))) AND and_dcpl_43;
  and_dcpl_325 <= and_dcpl_316 AND (NOT (fsm_output(3)));
  and_dcpl_326 <= and_dcpl_325 AND (NOT (fsm_output(8))) AND (NOT (fsm_output(5)));
  and_dcpl_327 <= and_dcpl_326 AND and_dcpl_323;
  and_dcpl_331 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("110")) AND
      and_dcpl_315 AND and_dcpl_323;
  and_dcpl_333 <= NOT((fsm_output(9)) OR (fsm_output(1)));
  and_dcpl_334 <= and_dcpl_333 AND (NOT (fsm_output(7)));
  and_dcpl_338 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("111")) AND
      and_dcpl_315;
  and_dcpl_339 <= and_dcpl_338 AND and_dcpl_334 AND and_dcpl_51;
  and_dcpl_342 <= and_dcpl_338 AND and_dcpl_333 AND (fsm_output(7)) AND and_dcpl_43;
  and_dcpl_343 <= and_dcpl_321 AND (fsm_output(7));
  and_dcpl_345 <= and_dcpl_338 AND and_dcpl_343 AND and_dcpl_51;
  and_dcpl_346 <= (fsm_output(6)) AND (fsm_output(0));
  and_dcpl_349 <= NOT((fsm_output(2)) OR (fsm_output(4)));
  and_dcpl_351 <= and_dcpl_349 AND (NOT (fsm_output(3))) AND (fsm_output(8)) AND
      (NOT (fsm_output(5)));
  and_dcpl_352 <= and_dcpl_351 AND and_dcpl_334 AND and_dcpl_346;
  and_dcpl_354 <= and_dcpl_351 AND and_dcpl_343 AND and_dcpl_200;
  and_dcpl_356 <= and_dcpl_351 AND and_dcpl_343 AND and_dcpl_346;
  and_dcpl_357 <= and_dcpl_326 AND and_dcpl_314;
  and_dcpl_361 <= and_dcpl_325 AND (fsm_output(8)) AND (fsm_output(5)) AND and_dcpl_334
      AND and_dcpl_43;
  and_dcpl_367 <= and_dcpl_349 AND (fsm_output(3)) AND and_dcpl_315 AND (fsm_output(9))
      AND (fsm_output(1)) AND (NOT (fsm_output(7))) AND and_dcpl_43;
  or_970_nl <= (fsm_output(1)) OR (NOT (fsm_output(2))) OR (fsm_output(9)) OR (fsm_output(8))
      OR not_tmp_173;
  or_968_nl <= (NOT (fsm_output(1))) OR (NOT (fsm_output(2))) OR (fsm_output(9))
      OR (fsm_output(8)) OR not_tmp_173;
  mux_tmp_860 <= MUX_s_1_2_2(or_970_nl, or_968_nl, fsm_output(7));
  or_tmp_890 <= (NOT (fsm_output(1))) OR (fsm_output(2)) OR (fsm_output(9)) OR (NOT
      (fsm_output(8))) OR (fsm_output(4)) OR (fsm_output(3)) OR (fsm_output(5));
  or_973_nl <= (fsm_output(1)) OR (NOT (fsm_output(2))) OR (fsm_output(9)) OR (NOT
      (fsm_output(8))) OR (fsm_output(4)) OR (fsm_output(3)) OR (fsm_output(5));
  mux_864_nl <= MUX_s_1_2_2(or_tmp_890, or_973_nl, fsm_output(7));
  mux_865_nl <= MUX_s_1_2_2(mux_tmp_860, mux_864_nl, fsm_output(6));
  or_972_nl <= (fsm_output(1)) OR (NOT (fsm_output(2))) OR (NOT (fsm_output(9)))
      OR (fsm_output(8)) OR (fsm_output(4)) OR (fsm_output(3)) OR (fsm_output(5));
  mux_862_nl <= MUX_s_1_2_2(or_972_nl, or_tmp_890, fsm_output(7));
  mux_863_nl <= MUX_s_1_2_2(mux_862_nl, mux_tmp_860, fsm_output(6));
  mux_866_itm <= MUX_s_1_2_2(mux_865_nl, mux_863_nl, fsm_output(0));
  or_976_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 1)/=STD_LOGIC_VECTOR'("010"));
  or_975_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 1)/=STD_LOGIC_VECTOR'("101"));
  mux_tmp_866 <= MUX_s_1_2_2(or_976_nl, or_975_nl, fsm_output(8));
  STAGE_LOOP_or_ssc <= and_dcpl_339 OR and_dcpl_345 OR and_dcpl_354 OR and_dcpl_357;
  or_tmp_911 <= (NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("10"))))
      OR (fsm_output(9));
  or_1007_nl <= (NOT((NOT (fsm_output(0))) OR (NOT (fsm_output(4))) OR (fsm_output(5))))
      OR (fsm_output(9));
  mux_878_nl <= MUX_s_1_2_2(or_tmp_911, or_1007_nl, fsm_output(1));
  or_1005_nl <= (NOT((NOT(and_524_cse OR (fsm_output(4)))) OR (fsm_output(5)))) OR
      (fsm_output(9));
  mux_tmp_877 <= MUX_s_1_2_2(mux_878_nl, or_1005_nl, fsm_output(2));
  or_tmp_917 <= (NOT((NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))))
      OR CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("01")))) OR (fsm_output(9));
  or_tmp_923 <= (NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("01"))))
      OR (fsm_output(9));
  mux_tmp_886 <= MUX_s_1_2_2((NOT (fsm_output(9))), (fsm_output(9)), fsm_output(5));
  or_tmp_942 <= NOT((fsm_output(3)) AND (fsm_output(2)) AND (fsm_output(4)) AND (fsm_output(5))
      AND (NOT (fsm_output(9))));
  nand_147_nl <= NOT((fsm_output(3)) AND VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm
      AND (fsm_output(2)) AND (fsm_output(4)) AND (fsm_output(5)) AND (NOT (fsm_output(9))));
  mux_tmp_907 <= MUX_s_1_2_2(nand_147_nl, or_tmp_942, fsm_output(1));
  or_1044_nl <= (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (fsm_output(2))
      OR (fsm_output(4)) OR (fsm_output(5)) OR (fsm_output(9));
  mux_tmp_910 <= MUX_s_1_2_2(or_1044_nl, or_462_cse, fsm_output(3));
  or_tmp_948 <= (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (NOT (fsm_output(2)))
      OR (fsm_output(4)) OR (NOT (fsm_output(5))) OR (fsm_output(9));
  or_tmp_949 <= (fsm_output(4)) OR (fsm_output(5)) OR (fsm_output(9));
  or_tmp_952 <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (fsm_output(5)) OR (fsm_output(9));
  mux_916_nl <= MUX_s_1_2_2(or_tmp_423, or_tmp_949, fsm_output(2));
  mux_tmp_915 <= MUX_s_1_2_2(or_tmp_952, mux_916_nl, VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm);
  or_tmp_953 <= (fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(5)) OR (fsm_output(9));
  mux_tmp_916 <= MUX_s_1_2_2(or_tmp_953, mux_tmp_915, fsm_output(3));
  mux_tmp_919 <= MUX_s_1_2_2(or_tmp_948, or_tmp_953, fsm_output(3));
  or_1053_nl <= (fsm_output(3)) OR (fsm_output(2)) OR (fsm_output(4)) OR (NOT (fsm_output(5)))
      OR (fsm_output(9));
  mux_tmp_921 <= MUX_s_1_2_2(mux_tmp_919, or_1053_nl, fsm_output(1));
  or_tmp_960 <= (fsm_output(4)) OR (fsm_output(5)) OR (NOT (fsm_output(9)));
  or_tmp_971 <= (NOT (fsm_output(2))) OR (fsm_output(5)) OR (fsm_output(0)) OR (fsm_output(3))
      OR (fsm_output(8)) OR (fsm_output(7)) OR (fsm_output(6));
  operator_64_false_1_or_2_itm <= and_dcpl_199 OR and_dcpl_221;
  COMP_LOOP_or_27_itm <= and_dcpl_242 OR and_dcpl_244;
  STAGE_LOOP_nor_itm <= NOT(and_dcpl_319 OR and_dcpl_331 OR and_dcpl_339 OR and_dcpl_342
      OR and_dcpl_345 OR and_dcpl_352 OR and_dcpl_354 OR and_dcpl_356 OR and_dcpl_357
      OR and_dcpl_361 OR and_dcpl_367);
  STAGE_LOOP_nor_53_itm <= NOT(and_dcpl_319 OR and_dcpl_327 OR and_dcpl_331 OR and_dcpl_339
      OR and_dcpl_342 OR and_dcpl_345 OR and_dcpl_352 OR and_dcpl_354 OR and_dcpl_356
      OR and_dcpl_357 OR and_dcpl_361 OR and_dcpl_367);
  STAGE_LOOP_or_1_itm <= and_dcpl_331 OR and_dcpl_339 OR and_dcpl_342 OR and_dcpl_345;
  STAGE_LOOP_or_2_itm <= and_dcpl_352 OR and_dcpl_354 OR and_dcpl_356 OR and_dcpl_357;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( not_tmp_77 = '0' ) THEN
        p_sva <= p_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((and_dcpl_33 AND and_dcpl_29) OR STAGE_LOOP_i_3_0_sva_mx0c1) = '1' )
          THEN
        STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(STD_LOGIC_VECTOR'( "0001"), (z_out_6(3
            DOWNTO 0)), STAGE_LOOP_i_3_0_sva_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( not_tmp_77 = '0' ) THEN
        r_sva <= r_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_vec_rsc_triosy_0_3_obj_ld_cse <= '0';
        VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm <= '0';
        modExp_exp_1_0_1_sva_1 <= '0';
        modExp_exp_1_1_1_sva <= '0';
        modExp_exp_1_7_1_sva <= '0';
      ELSE
        reg_vec_rsc_triosy_0_3_obj_ld_cse <= and_dcpl_32 AND and_256_cse AND (NOT
            (fsm_output(6))) AND (NOT (fsm_output(0))) AND (NOT (fsm_output(4)))
            AND (fsm_output(9)) AND (fsm_output(5)) AND (NOT (z_out_5(2)));
        VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm <= (COMP_LOOP_mux1h_15_nl
            AND (NOT((NOT mux_tmp_504) AND and_dcpl_147))) OR ((NOT mux_433_itm)
            AND and_dcpl_51 AND (NOT (fsm_output(4))) AND and_dcpl_40);
        modExp_exp_1_0_1_sva_1 <= (COMP_LOOP_mux_39_nl AND (NOT(mux_732_nl AND (NOT
            (fsm_output(7))) AND (NOT (fsm_output(4))) AND and_dcpl_40))) OR (mux_752_nl
            AND (fsm_output(7)) AND (NOT (fsm_output(4))) AND and_dcpl_40);
        modExp_exp_1_1_1_sva <= COMP_LOOP_mux1h_27_nl AND (NOT(not_tmp_324 AND and_dcpl_105
            AND and_dcpl_176));
        modExp_exp_1_7_1_sva <= COMP_LOOP_mux1h_44_nl AND mux_806_nl;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      modulo_result_rem_cmp_a <= MUX1HOT_v_64_4_2(z_out_7, operator_64_false_acc_mut_63_0,
          VEC_LOOP_1_COMP_LOOP_1_acc_8_itm, (z_out_5(63 DOWNTO 0)), STD_LOGIC_VECTOR'(
          modulo_result_or_nl & mux_372_nl & (NOT mux_415_nl) & and_dcpl_108));
      modulo_result_rem_cmp_b <= p_sva;
      operator_66_true_div_cmp_a <= MUX_v_65_2_2(z_out_5, (operator_64_false_acc_mut_64
          & operator_64_false_acc_mut_63_0), and_dcpl_117);
      operator_66_true_div_cmp_b_9_0 <= MUX_v_10_2_2(STAGE_LOOP_lshift_psp_sva_mx0w0,
          STAGE_LOOP_lshift_psp_sva, and_dcpl_117);
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (MUX_s_1_2_2(mux_436_nl, and_tmp_7, fsm_output(5))) = '1' ) THEN
        STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( mux_908_nl = '0' ) THEN
        operator_64_false_acc_mut_64 <= operator_64_false_mux1h_2_rgt(64);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( mux_944_nl = '0' ) THEN
        operator_64_false_acc_mut_63_0 <= operator_64_false_mux1h_2_rgt(63 DOWNTO
            0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        VEC_LOOP_j_1_12_0_sva_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (and_dcpl_123 OR VEC_LOOP_j_1_12_0_sva_11_0_mx0c1) = '1' ) THEN
        VEC_LOOP_j_1_12_0_sva_11_0 <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"),
            (z_out_6(11 DOWNTO 0)), VEC_LOOP_j_1_12_0_sva_11_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_k_9_2_1_sva_6_0 <= STD_LOGIC_VECTOR'( "0000000");
      ELSIF ( mux_949_nl = '0' ) THEN
        COMP_LOOP_k_9_2_1_sva_6_0 <= MUX_v_7_2_2(STD_LOGIC_VECTOR'("0000000"), (z_out_5(6
            DOWNTO 0)), or_992_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((modExp_while_and_3 OR modExp_while_and_5 OR modExp_result_sva_mx0c0
          OR mux_500_nl) AND (modExp_result_sva_mx0c0 OR modExp_result_and_rgt OR
          modExp_result_and_1_rgt)) = '1' ) THEN
        modExp_result_sva <= MUX1HOT_v_64_3_2(STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000001"),
            modulo_result_rem_cmp_z, z_out_6, STD_LOGIC_VECTOR'( modExp_result_sva_mx0c0
            & modExp_result_and_rgt & modExp_result_and_1_rgt));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( mux_529_nl = '0' ) THEN
        modExp_base_1_sva <= MUX1HOT_v_64_4_2(r_sva, modulo_result_rem_cmp_z, z_out_6,
            modExp_result_sva, STD_LOGIC_VECTOR'( and_144_nl & r_or_nl & r_or_1_nl
            & and_dcpl_138));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        tmp_10_lpi_4_dfm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (MUX_s_1_2_2(mux_557_nl, or_1002_nl, fsm_output(9))) = '1' ) THEN
        tmp_10_lpi_4_dfm <= MUX1HOT_v_64_5_2(('0' & operator_64_false_slc_modExp_exp_63_1_3),
            vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, vec_rsc_0_2_i_qa_d, vec_rsc_0_3_i_qa_d,
            STD_LOGIC_VECTOR'( and_dcpl_123 & COMP_LOOP_or_6_nl & COMP_LOOP_or_7_nl
            & COMP_LOOP_or_8_nl & COMP_LOOP_or_9_nl));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva <= '0';
      ELSIF ( (and_dcpl_104 OR and_dcpl_107 OR and_dcpl_129) = '1' ) THEN
        exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva <= MUX1HOT_s_1_3_2((NOT (z_out_6(63))),
            (NOT (z_out_1(8))), (NOT (VEC_LOOP_1_COMP_LOOP_1_acc_11_nl(9))), STD_LOGIC_VECTOR'(
            and_dcpl_104 & and_dcpl_107 & and_dcpl_129));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((mux_682_nl AND and_dcpl_109) OR and_dcpl_108) = '1' ) THEN
        VEC_LOOP_1_COMP_LOOP_1_acc_8_itm <= MUX_v_64_2_2(z_out_7, STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(VEC_LOOP_1_COMP_LOOP_1_acc_8_nl),
            64)), and_dcpl_108);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( COMP_LOOP_or_1_cse = '1' ) THEN
        COMP_LOOP_acc_psp_1_sva <= z_out_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_5_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (MUX_s_1_2_2(mux_709_nl, or_tmp_71, fsm_output(6))) = '1' ) THEN
        COMP_LOOP_acc_1_cse_5_sva <= z_out_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_11_psp_1_sva <= STD_LOGIC_VECTOR'( "00000000000");
      ELSIF ( (mux_721_nl OR (fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_11_psp_1_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux_42_nl)
            + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_2_1_sva_6_0 & '1'),
            8), 11), 11));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_2_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (mux_731_nl OR (fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_1_cse_2_sva <= z_out_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_2_1_sva <= '0';
        modExp_exp_1_3_1_sva <= '0';
        modExp_exp_1_4_1_sva <= '0';
        modExp_exp_1_5_1_sva <= '0';
        modExp_exp_1_6_1_sva <= '0';
      ELSIF ( mux_801_itm = '1' ) THEN
        modExp_exp_1_2_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_2_1_sva_6_0(0)), modExp_exp_1_3_1_sva,
            (COMP_LOOP_k_9_2_1_sva_6_0(1)), STD_LOGIC_VECTOR'( and_dcpl_175 & not_tmp_321
            & and_dcpl_179));
        modExp_exp_1_3_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_2_1_sva_6_0(1)), modExp_exp_1_4_1_sva,
            (COMP_LOOP_k_9_2_1_sva_6_0(2)), STD_LOGIC_VECTOR'( and_dcpl_175 & not_tmp_321
            & and_dcpl_179));
        modExp_exp_1_4_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_2_1_sva_6_0(2)), modExp_exp_1_5_1_sva,
            (COMP_LOOP_k_9_2_1_sva_6_0(3)), STD_LOGIC_VECTOR'( and_dcpl_175 & not_tmp_321
            & and_dcpl_179));
        modExp_exp_1_5_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_2_1_sva_6_0(3)), modExp_exp_1_6_1_sva,
            (COMP_LOOP_k_9_2_1_sva_6_0(4)), STD_LOGIC_VECTOR'( and_dcpl_175 & not_tmp_321
            & and_dcpl_179));
        modExp_exp_1_6_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_2_1_sva_6_0(4)), modExp_exp_1_7_1_sva,
            (COMP_LOOP_k_9_2_1_sva_6_0(5)), STD_LOGIC_VECTOR'( and_dcpl_175 & not_tmp_321
            & and_dcpl_179));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((not_tmp_324 AND and_dcpl_105 AND (fsm_output(0)) AND (NOT (fsm_output(9))))
          OR and_dcpl_111 OR (mux_807_nl AND and_dcpl_176)) = '1' ) THEN
        VEC_LOOP_1_COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm <= MUX_s_1_2_2((z_out_2(9)),
            (z_out_1(8)), and_dcpl_111);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_10_cse_12_1_1_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( COMP_LOOP_or_3_cse = '1' ) THEN
        COMP_LOOP_acc_10_cse_12_1_1_sva <= z_out_6(12 DOWNTO 1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_VEC_LOOP_1_acc_1_psp_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (NOT((fsm_output(7)) OR (fsm_output(1)) OR (NOT (fsm_output(8))) OR
          (NOT (fsm_output(2))) OR (fsm_output(3)) OR (fsm_output(6)) OR (NOT (fsm_output(0)))
          OR (fsm_output(4)) OR or_55_cse)) = '1' ) THEN
        reg_VEC_LOOP_1_acc_1_psp_ftd_1 <= z_out_6(11 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  modulo_result_or_nl <= and_dcpl_104 OR and_dcpl_107 OR (NOT mux_423_itm) OR and_dcpl_111;
  or_452_nl <= nor_236_cse OR (fsm_output(4));
  mux_366_nl <= MUX_s_1_2_2(mux_tmp_345, or_452_nl, fsm_output(5));
  mux_364_nl <= MUX_s_1_2_2(or_tmp_404, or_tmp_416, fsm_output(2));
  mux_365_nl <= MUX_s_1_2_2(and_303_cse, mux_364_nl, fsm_output(5));
  mux_367_nl <= MUX_s_1_2_2(mux_366_nl, mux_365_nl, fsm_output(8));
  mux_361_nl <= MUX_s_1_2_2(or_tmp_416, (NOT mux_tmp_318), fsm_output(2));
  mux_362_nl <= MUX_s_1_2_2(mux_tmp_345, mux_361_nl, fsm_output(5));
  mux_363_nl <= MUX_s_1_2_2(mux_362_nl, mux_tmp_350, fsm_output(8));
  mux_368_nl <= MUX_s_1_2_2(mux_367_nl, mux_363_nl, fsm_output(1));
  mux_369_nl <= MUX_s_1_2_2((NOT mux_368_nl), mux_tmp_338, fsm_output(6));
  mux_357_nl <= MUX_s_1_2_2((NOT mux_tmp_319), and_303_cse, fsm_output(5));
  mux_358_nl <= MUX_s_1_2_2(mux_tmp_340, mux_357_nl, fsm_output(8));
  mux_359_nl <= MUX_s_1_2_2(mux_358_nl, mux_tmp_337, fsm_output(1));
  mux_360_nl <= MUX_s_1_2_2(mux_tmp_329, mux_359_nl, fsm_output(6));
  mux_370_nl <= MUX_s_1_2_2(mux_369_nl, mux_360_nl, fsm_output(7));
  mux_351_nl <= MUX_s_1_2_2(or_tmp_416, (NOT or_tmp_404), fsm_output(2));
  mux_352_nl <= MUX_s_1_2_2(mux_tmp_345, mux_351_nl, fsm_output(5));
  mux_353_nl <= MUX_s_1_2_2(mux_352_nl, mux_tmp_350, fsm_output(8));
  mux_347_nl <= MUX_s_1_2_2((fsm_output(4)), (NOT (fsm_output(4))), and_256_cse);
  mux_348_nl <= MUX_s_1_2_2(or_tmp_416, mux_347_nl, fsm_output(5));
  mux_346_nl <= MUX_s_1_2_2(mux_tmp_335, mux_tmp_345, fsm_output(5));
  mux_349_nl <= MUX_s_1_2_2(mux_348_nl, mux_346_nl, fsm_output(8));
  mux_354_nl <= MUX_s_1_2_2(mux_353_nl, mux_349_nl, fsm_output(1));
  mux_341_nl <= MUX_s_1_2_2((NOT or_tmp_404), or_756_cse, fsm_output(2));
  mux_342_nl <= MUX_s_1_2_2((NOT nor_tmp_64), mux_341_nl, fsm_output(5));
  mux_343_nl <= MUX_s_1_2_2(mux_342_nl, mux_tmp_340, fsm_output(8));
  mux_344_nl <= MUX_s_1_2_2(mux_tmp_325, mux_343_nl, fsm_output(1));
  mux_355_nl <= MUX_s_1_2_2((NOT mux_354_nl), mux_344_nl, fsm_output(6));
  mux_339_nl <= MUX_s_1_2_2(mux_tmp_338, mux_tmp_329, fsm_output(6));
  mux_356_nl <= MUX_s_1_2_2(mux_355_nl, mux_339_nl, fsm_output(7));
  mux_371_nl <= MUX_s_1_2_2(mux_370_nl, mux_356_nl, fsm_output(0));
  or_446_nl <= (fsm_output(8)) OR (fsm_output(5)) OR (NOT(CONV_SL_1_1(fsm_output(4
      DOWNTO 2)/=STD_LOGIC_VECTOR'("001"))));
  or_443_nl <= (fsm_output(8)) OR (fsm_output(5)) OR nor_tmp_63;
  mux_321_nl <= MUX_s_1_2_2(or_446_nl, or_443_nl, fsm_output(1));
  nor_237_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"))
      OR mux_321_nl);
  or_439_nl <= (fsm_output(8)) OR (fsm_output(5)) OR mux_tmp_319;
  or_436_nl <= (fsm_output(8)) OR (fsm_output(5)) OR mux_tmp_317;
  mux_320_nl <= MUX_s_1_2_2(or_439_nl, or_436_nl, fsm_output(1));
  nor_239_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"))
      OR mux_320_nl);
  mux_322_nl <= MUX_s_1_2_2(nor_237_nl, nor_239_nl, fsm_output(0));
  mux_372_nl <= MUX_s_1_2_2(mux_371_nl, mux_322_nl, fsm_output(9));
  mux_409_nl <= MUX_s_1_2_2(mux_tmp_393, or_1047_cse, fsm_output(2));
  mux_410_nl <= MUX_s_1_2_2(mux_409_nl, or_tmp_436, fsm_output(8));
  mux_406_nl <= MUX_s_1_2_2(mux_tmp_373, or_tmp_437, fsm_output(9));
  mux_407_nl <= MUX_s_1_2_2(or_1047_cse, mux_406_nl, fsm_output(2));
  mux_408_nl <= MUX_s_1_2_2(mux_407_nl, or_tmp_436, fsm_output(8));
  mux_411_nl <= MUX_s_1_2_2(mux_410_nl, mux_408_nl, fsm_output(1));
  mux_412_nl <= MUX_s_1_2_2(mux_tmp_398, mux_411_nl, fsm_output(3));
  mux_413_nl <= MUX_s_1_2_2(mux_412_nl, mux_tmp_382, fsm_output(6));
  or_477_nl <= nor_70_cse OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  mux_403_nl <= MUX_s_1_2_2(or_477_nl, mux_tmp_380, fsm_output(1));
  mux_404_nl <= MUX_s_1_2_2(mux_403_nl, or_tmp_421, fsm_output(3));
  mux_405_nl <= MUX_s_1_2_2(mux_tmp_378, mux_404_nl, fsm_output(6));
  mux_414_nl <= MUX_s_1_2_2(mux_413_nl, mux_405_nl, fsm_output(7));
  or_474_nl <= (NOT (fsm_output(2))) OR (fsm_output(9)) OR (NOT (fsm_output(4)));
  mux_394_nl <= MUX_s_1_2_2(mux_tmp_393, or_474_nl, fsm_output(8));
  mux_399_nl <= MUX_s_1_2_2(mux_tmp_398, mux_394_nl, fsm_output(1));
  mux_391_nl <= MUX_s_1_2_2(or_tmp_436, or_tmp_437, nor_70_cse);
  mux_388_nl <= MUX_s_1_2_2(or_tmp_438, or_tmp_437, fsm_output(9));
  mux_389_nl <= MUX_s_1_2_2(or_1047_cse, mux_388_nl, fsm_output(2));
  mux_390_nl <= MUX_s_1_2_2(mux_389_nl, or_tmp_436, fsm_output(8));
  mux_392_nl <= MUX_s_1_2_2(mux_391_nl, mux_390_nl, fsm_output(1));
  mux_400_nl <= MUX_s_1_2_2(mux_399_nl, mux_392_nl, fsm_output(3));
  mux_386_nl <= MUX_s_1_2_2(mux_tmp_375, mux_tmp_379, fsm_output(1));
  or_469_nl <= (fsm_output(9)) OR mux_tmp_373;
  mux_384_nl <= MUX_s_1_2_2(or_469_nl, or_1047_cse, nor_70_cse);
  mux_385_nl <= MUX_s_1_2_2(or_tmp_421, mux_384_nl, fsm_output(1));
  mux_387_nl <= MUX_s_1_2_2(mux_386_nl, mux_385_nl, fsm_output(3));
  mux_401_nl <= MUX_s_1_2_2(mux_400_nl, mux_387_nl, fsm_output(6));
  mux_383_nl <= MUX_s_1_2_2(mux_tmp_382, mux_tmp_378, fsm_output(6));
  mux_402_nl <= MUX_s_1_2_2(mux_401_nl, mux_383_nl, fsm_output(7));
  mux_415_nl <= MUX_s_1_2_2(mux_414_nl, mux_402_nl, fsm_output(0));
  operator_64_false_1_mux_3_nl <= MUX_v_7_2_2((NOT COMP_LOOP_k_9_2_1_sva_6_0), (NOT
      (STAGE_LOOP_lshift_psp_sva(9 DOWNTO 3))), and_dcpl_196);
  nor_456_nl <= NOT((fsm_output(2)) OR (fsm_output(8)));
  and_531_nl <= (fsm_output(2)) AND (fsm_output(8));
  mux_952_nl <= MUX_s_1_2_2(nor_456_nl, and_531_nl, fsm_output(1));
  operator_64_false_1_or_5_nl <= (NOT(mux_952_nl AND and_dcpl_109 AND (NOT (fsm_output(3)))
      AND (fsm_output(5)) AND (NOT (fsm_output(7))) AND and_dcpl_200)) OR and_dcpl_196;
  operator_64_false_1_mux_4_nl <= MUX_v_7_2_2(STD_LOGIC_VECTOR'( "0000001"), COMP_LOOP_k_9_2_1_sva_6_0,
      and_dcpl_196);
  acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & operator_64_false_1_mux_3_nl
      & operator_64_false_1_or_5_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(operator_64_false_1_mux_4_nl
      & '1'), 8), 9), 9));
  COMP_LOOP_and_11_nl <= (NOT and_dcpl_134) AND and_dcpl_123;
  nor_184_nl <= NOT((fsm_output(4)) OR (NOT (fsm_output(6))) OR (fsm_output(3)) OR
      (fsm_output(2)) OR (NOT nor_tmp_40));
  nor_185_nl <= NOT((NOT (fsm_output(4))) OR (fsm_output(6)) OR (NOT (fsm_output(3)))
      OR (NOT (fsm_output(2))) OR (fsm_output(8)) OR (fsm_output(1)));
  mux_616_nl <= MUX_s_1_2_2(nor_184_nl, nor_185_nl, fsm_output(5));
  COMP_LOOP_or_11_nl <= (and_dcpl_154 AND and_dcpl_41) OR (mux_616_nl AND (fsm_output(7))
      AND (fsm_output(0)) AND (NOT (fsm_output(9))));
  mux_610_nl <= MUX_s_1_2_2(or_tmp_637, or_tmp_635, fsm_output(3));
  or_673_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (fsm_output(8));
  mux_608_nl <= MUX_s_1_2_2(or_tmp_637, or_673_nl, fsm_output(1));
  mux_609_nl <= MUX_s_1_2_2(mux_608_nl, or_tmp_635, fsm_output(3));
  mux_611_nl <= MUX_s_1_2_2(mux_610_nl, mux_609_nl, fsm_output(0));
  mux_604_nl <= MUX_s_1_2_2((fsm_output(4)), (NOT (fsm_output(8))), fsm_output(2));
  mux_605_nl <= MUX_s_1_2_2(mux_604_nl, or_tmp_623, fsm_output(1));
  or_671_nl <= (NOT (fsm_output(2))) OR (fsm_output(8));
  mux_603_nl <= MUX_s_1_2_2(or_tmp_621, or_671_nl, fsm_output(1));
  mux_606_nl <= MUX_s_1_2_2(mux_605_nl, mux_603_nl, fsm_output(3));
  mux_607_nl <= MUX_s_1_2_2(mux_606_nl, mux_tmp_599, fsm_output(0));
  mux_612_nl <= MUX_s_1_2_2((NOT mux_611_nl), mux_607_nl, fsm_output(5));
  mux_600_nl <= MUX_s_1_2_2(mux_tmp_594, mux_tmp_589, fsm_output(3));
  mux_601_nl <= MUX_s_1_2_2(mux_600_nl, mux_tmp_599, fsm_output(0));
  mux_602_nl <= MUX_s_1_2_2(nor_330_cse, mux_601_nl, fsm_output(5));
  mux_613_nl <= MUX_s_1_2_2(mux_612_nl, mux_602_nl, fsm_output(6));
  or_665_nl <= (fsm_output(1)) OR mux_tmp_588;
  mux_595_nl <= MUX_s_1_2_2(mux_tmp_594, or_665_nl, fsm_output(3));
  mux_596_nl <= MUX_s_1_2_2(nor_330_cse, mux_595_nl, fsm_output(5));
  or_71_nl <= (NOT (fsm_output(8))) OR (fsm_output(3)) OR (NOT (fsm_output(1))) OR
      (fsm_output(2)) OR (fsm_output(4));
  or_662_nl <= (fsm_output(1)) OR (NOT (fsm_output(2))) OR (fsm_output(4)) OR (fsm_output(8));
  nand_55_nl <= NOT((fsm_output(1)) AND (NOT mux_tmp_588));
  mux_591_nl <= MUX_s_1_2_2(or_662_nl, nand_55_nl, fsm_output(3));
  or_661_nl <= (NOT (fsm_output(1))) OR (fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(8));
  mux_590_nl <= MUX_s_1_2_2(or_661_nl, mux_tmp_589, fsm_output(3));
  mux_592_nl <= MUX_s_1_2_2(mux_591_nl, mux_590_nl, fsm_output(0));
  mux_593_nl <= MUX_s_1_2_2(or_71_nl, mux_592_nl, fsm_output(5));
  mux_597_nl <= MUX_s_1_2_2(mux_596_nl, mux_593_nl, fsm_output(6));
  mux_614_nl <= MUX_s_1_2_2(mux_613_nl, mux_597_nl, fsm_output(7));
  or_656_nl <= (fsm_output(3)) OR (fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(8));
  or_655_nl <= (fsm_output(3)) OR (fsm_output(1)) OR (fsm_output(2)) OR (fsm_output(4))
      OR (fsm_output(8));
  mux_587_nl <= MUX_s_1_2_2(or_656_nl, or_655_nl, fsm_output(0));
  nor_186_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000"))
      OR mux_587_nl);
  mux_615_nl <= MUX_s_1_2_2(mux_614_nl, nor_186_nl, fsm_output(9));
  COMP_LOOP_mux1h_15_nl <= MUX1HOT_s_1_5_2((operator_66_true_div_cmp_z(0)), (tmp_10_lpi_4_dfm(0)),
      (acc_nl(8)), modExp_exp_1_0_1_sva_1, VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm,
      STD_LOGIC_VECTOR'( COMP_LOOP_and_11_nl & and_dcpl_134 & COMP_LOOP_or_11_nl
      & not_tmp_260 & mux_615_nl));
  mux_750_nl <= MUX_s_1_2_2(mux_749_cse, mux_748_cse, fsm_output(1));
  or_890_nl <= (fsm_output(1)) OR (NOT (fsm_output(7))) OR mux_745_cse;
  mux_751_nl <= MUX_s_1_2_2(mux_750_nl, or_890_nl, fsm_output(2));
  COMP_LOOP_mux_39_nl <= MUX_s_1_2_2(modExp_exp_1_1_1_sva, modExp_exp_1_0_1_sva_1,
      mux_751_nl);
  and_212_nl <= (fsm_output(6)) AND (NOT mux_tmp_92);
  nor_170_nl <= NOT((fsm_output(6)) OR (fsm_output(3)) OR (NOT mux_tmp_579));
  mux_732_nl <= MUX_s_1_2_2(and_212_nl, nor_170_nl, fsm_output(0));
  and_210_nl <= (fsm_output(6)) AND not_tmp_91;
  nor_165_nl <= NOT((fsm_output(6)) OR mux_tmp_92);
  mux_752_nl <= MUX_s_1_2_2(and_210_nl, nor_165_nl, fsm_output(0));
  mux_776_nl <= MUX_s_1_2_2(mux_tmp_763, or_54_cse, fsm_output(8));
  mux_775_nl <= MUX_s_1_2_2(or_54_cse, mux_894_cse, fsm_output(8));
  mux_777_nl <= MUX_s_1_2_2(mux_776_nl, mux_775_nl, fsm_output(7));
  mux_778_nl <= MUX_s_1_2_2(mux_777_nl, mux_tmp_771, fsm_output(6));
  mux_779_nl <= MUX_s_1_2_2(mux_778_nl, or_tmp_760, fsm_output(3));
  mux_772_nl <= MUX_s_1_2_2(mux_tmp_763, or_54_cse, or_826_cse);
  mux_773_nl <= MUX_s_1_2_2(mux_772_nl, mux_tmp_771, fsm_output(6));
  mux_774_nl <= MUX_s_1_2_2(mux_773_nl, or_tmp_769, fsm_output(3));
  mux_780_nl <= MUX_s_1_2_2(mux_779_nl, mux_774_nl, fsm_output(0));
  or_824_nl <= (NOT((NOT(and_205_cse OR (fsm_output(8)))) OR (fsm_output(4)))) OR
      (fsm_output(9)) OR (NOT (fsm_output(5)));
  or_820_nl <= (NOT(and_205_cse OR (fsm_output(8)) OR (NOT (fsm_output(4))))) OR
      (fsm_output(9)) OR (NOT (fsm_output(5)));
  mux_768_nl <= MUX_s_1_2_2(or_824_nl, or_820_nl, fsm_output(3));
  mux_769_nl <= MUX_s_1_2_2(mux_768_nl, mux_tmp_760, fsm_output(0));
  mux_781_nl <= MUX_s_1_2_2(mux_780_nl, mux_769_nl, fsm_output(2));
  mux_764_nl <= MUX_s_1_2_2(mux_tmp_763, or_54_cse, or_814_cse);
  mux_762_nl <= MUX_s_1_2_2(or_tmp_762, or_tmp_769, fsm_output(6));
  mux_765_nl <= MUX_s_1_2_2(mux_764_nl, mux_762_nl, fsm_output(3));
  or_810_nl <= (NOT((NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00"))))
      OR (fsm_output(4)))) OR (fsm_output(9)) OR (NOT (fsm_output(5)));
  mux_761_nl <= MUX_s_1_2_2(or_810_nl, or_tmp_762, fsm_output(3));
  mux_766_nl <= MUX_s_1_2_2(mux_765_nl, mux_761_nl, fsm_output(0));
  mux_767_nl <= MUX_s_1_2_2(mux_766_nl, mux_tmp_760, fsm_output(2));
  mux_782_nl <= MUX_s_1_2_2(mux_781_nl, mux_767_nl, fsm_output(1));
  COMP_LOOP_mux1h_27_nl <= MUX1HOT_s_1_4_2((COMP_LOOP_k_9_2_1_sva_6_0(6)), modExp_exp_1_2_1_sva,
      modExp_exp_1_1_1_sva, (COMP_LOOP_k_9_2_1_sva_6_0(0)), STD_LOGIC_VECTOR'( and_dcpl_175
      & not_tmp_321 & (NOT mux_782_nl) & and_dcpl_179));
  COMP_LOOP_mux1h_44_nl <= MUX1HOT_s_1_4_2((COMP_LOOP_k_9_2_1_sva_6_0(5)), modExp_exp_1_1_1_sva,
      modExp_exp_1_7_1_sva, (COMP_LOOP_k_9_2_1_sva_6_0(6)), STD_LOGIC_VECTOR'( and_dcpl_175
      & and_dcpl_107 & (NOT mux_801_itm) & and_dcpl_179));
  or_nl <= (NOT (fsm_output(0))) OR (fsm_output(6)) OR (NOT (fsm_output(7))) OR (fsm_output(9))
      OR (NOT (fsm_output(8))) OR (fsm_output(3)) OR (fsm_output(4)) OR (fsm_output(5));
  or_989_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 6)/=STD_LOGIC_VECTOR'("0010")) OR
      not_tmp_173;
  or_990_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 6)/=STD_LOGIC_VECTOR'("0011")) OR
      not_tmp_173;
  mux_804_nl <= MUX_s_1_2_2(or_989_nl, or_990_nl, fsm_output(0));
  mux_805_nl <= MUX_s_1_2_2(or_nl, mux_804_nl, fsm_output(2));
  or_852_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 3)/=STD_LOGIC_VECTOR'("0111000"));
  or_851_nl <= (fsm_output(7)) OR (NOT (fsm_output(9))) OR (fsm_output(8)) OR (fsm_output(3))
      OR (fsm_output(4)) OR (fsm_output(5));
  or_850_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000")) OR not_tmp_173;
  mux_802_nl <= MUX_s_1_2_2(or_851_nl, or_850_nl, fsm_output(6));
  mux_803_nl <= MUX_s_1_2_2(or_852_nl, mux_802_nl, fsm_output(0));
  or_991_nl <= (fsm_output(2)) OR mux_803_nl;
  mux_806_nl <= MUX_s_1_2_2(mux_805_nl, or_991_nl, fsm_output(1));
  nor_228_nl <= NOT((fsm_output(4)) OR (fsm_output(6)) OR (fsm_output(3)) OR (fsm_output(2))
      OR (fsm_output(8)) OR (fsm_output(1)) OR (fsm_output(7)));
  mux_436_nl <= MUX_s_1_2_2(nor_228_nl, or_814_cse, fsm_output(9));
  mux_901_nl <= MUX_s_1_2_2(or_1038_cse, (fsm_output(9)), fsm_output(4));
  mux_902_nl <= MUX_s_1_2_2(mux_901_nl, nor_tmp_34, fsm_output(0));
  mux_903_nl <= MUX_s_1_2_2(mux_902_nl, mux_tmp_886, fsm_output(1));
  or_1037_nl <= (NOT (fsm_output(1))) OR (fsm_output(4));
  mux_900_nl <= MUX_s_1_2_2(nor_tmp_34, mux_tmp_886, or_1037_nl);
  mux_904_nl <= MUX_s_1_2_2(mux_903_nl, mux_900_nl, fsm_output(2));
  or_1036_nl <= (NOT(and_524_cse OR CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("10"))))
      OR (fsm_output(9));
  mux_899_nl <= MUX_s_1_2_2(or_1036_nl, or_tmp_923, fsm_output(2));
  mux_905_nl <= MUX_s_1_2_2(mux_904_nl, mux_899_nl, fsm_output(7));
  mux_897_nl <= MUX_s_1_2_2(or_tmp_911, or_tmp_917, fsm_output(2));
  mux_898_nl <= MUX_s_1_2_2(mux_tmp_877, mux_897_nl, fsm_output(7));
  mux_906_nl <= MUX_s_1_2_2(mux_905_nl, mux_898_nl, fsm_output(6));
  mux_895_nl <= MUX_s_1_2_2(mux_894_cse, or_tmp_923, fsm_output(0));
  nor_429_nl <= NOT((fsm_output(6)) OR (fsm_output(7)) OR (NOT (fsm_output(2))) OR
      (NOT (fsm_output(1))));
  mux_896_nl <= MUX_s_1_2_2(or_tmp_911, mux_895_nl, nor_429_nl);
  mux_907_nl <= MUX_s_1_2_2(mux_906_nl, mux_896_nl, fsm_output(8));
  mux_889_nl <= MUX_s_1_2_2(nor_tmp_34, mux_tmp_886, fsm_output(4));
  mux_886_nl <= MUX_s_1_2_2(nor_tmp_34, or_55_cse, fsm_output(4));
  and_525_nl <= (CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00"))) AND
      (fsm_output(9));
  mux_887_nl <= MUX_s_1_2_2(mux_886_nl, and_525_nl, and_524_cse);
  mux_890_nl <= MUX_s_1_2_2(mux_889_nl, mux_887_nl, fsm_output(2));
  or_1032_nl <= (NOT((NOT((NOT(CONV_SL_1_1(fsm_output(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))))
      OR (fsm_output(4)))) OR (fsm_output(5)))) OR (fsm_output(9));
  mux_891_nl <= MUX_s_1_2_2(mux_890_nl, or_1032_nl, fsm_output(7));
  or_1028_nl <= (NOT((NOT((NOT((NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(1))
      OR (NOT (fsm_output(0))))) OR (fsm_output(4)))) OR (fsm_output(5)))) OR (fsm_output(9));
  mux_892_nl <= MUX_s_1_2_2(mux_891_nl, or_1028_nl, fsm_output(6));
  or_1025_nl <= (NOT((NOT((NOT(CONV_SL_1_1(fsm_output(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))))
      OR (fsm_output(4)))) OR (fsm_output(5)))) OR (fsm_output(9));
  or_1021_nl <= (NOT((fsm_output(0)) OR (fsm_output(4)) OR (NOT (fsm_output(5)))))
      OR (fsm_output(9));
  mux_882_nl <= MUX_s_1_2_2(or_1021_nl, or_tmp_923, fsm_output(1));
  or_1018_nl <= (NOT((NOT((NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))))
      OR (fsm_output(4)))) OR (fsm_output(5)))) OR (fsm_output(9));
  mux_883_nl <= MUX_s_1_2_2(mux_882_nl, or_1018_nl, fsm_output(2));
  mux_884_nl <= MUX_s_1_2_2(or_1025_nl, mux_883_nl, fsm_output(7));
  or_1011_nl <= (NOT((NOT((NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))))
      OR (fsm_output(4)))) OR (fsm_output(5)))) OR (fsm_output(9));
  mux_880_nl <= MUX_s_1_2_2(or_tmp_917, or_1011_nl, fsm_output(2));
  mux_881_nl <= MUX_s_1_2_2(mux_880_nl, mux_tmp_877, fsm_output(7));
  mux_885_nl <= MUX_s_1_2_2(mux_884_nl, mux_881_nl, fsm_output(6));
  mux_893_nl <= MUX_s_1_2_2(mux_892_nl, mux_885_nl, fsm_output(8));
  mux_908_nl <= MUX_s_1_2_2(mux_907_nl, mux_893_nl, fsm_output(3));
  mux_939_nl <= MUX_s_1_2_2(mux_tmp_915, or_tmp_948, fsm_output(3));
  mux_940_nl <= MUX_s_1_2_2(or_tmp_942, mux_939_nl, fsm_output(1));
  mux_941_nl <= MUX_s_1_2_2(mux_940_nl, mux_tmp_907, fsm_output(7));
  nand_nl <= NOT(VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm AND (fsm_output(2))
      AND (fsm_output(4)) AND (fsm_output(5)) AND (NOT (fsm_output(9))));
  or_1061_nl <= (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (fsm_output(2))
      OR (fsm_output(4)) OR (NOT (fsm_output(5))) OR (fsm_output(9));
  mux_938_nl <= MUX_s_1_2_2(nand_nl, or_1061_nl, fsm_output(3));
  or_1063_nl <= (fsm_output(7)) OR (fsm_output(1)) OR mux_938_nl;
  mux_942_nl <= MUX_s_1_2_2(mux_941_nl, or_1063_nl, fsm_output(8));
  mux_933_nl <= MUX_s_1_2_2((fsm_output(9)), or_1038_cse, fsm_output(4));
  mux_934_nl <= MUX_s_1_2_2(mux_933_nl, or_tmp_960, fsm_output(2));
  or_1059_nl <= (fsm_output(3)) OR mux_934_nl;
  mux_930_nl <= MUX_s_1_2_2(or_tmp_960, or_tmp_949, fsm_output(2));
  mux_931_nl <= MUX_s_1_2_2(or_tmp_952, mux_930_nl, VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm);
  or_1055_nl <= (NOT (fsm_output(2))) OR (NOT (fsm_output(4))) OR (fsm_output(5))
      OR (fsm_output(9));
  mux_932_nl <= MUX_s_1_2_2(mux_931_nl, or_1055_nl, fsm_output(3));
  mux_935_nl <= MUX_s_1_2_2(or_1059_nl, mux_932_nl, fsm_output(1));
  mux_936_nl <= MUX_s_1_2_2(mux_935_nl, mux_tmp_921, fsm_output(7));
  or_1054_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(5)))
      OR (fsm_output(9));
  mux_928_nl <= MUX_s_1_2_2(or_1054_nl, or_tmp_953, fsm_output(3));
  nand_145_nl <= NOT((fsm_output(1)) AND (NOT mux_928_nl));
  mux_927_nl <= MUX_s_1_2_2(mux_tmp_910, mux_tmp_916, fsm_output(1));
  mux_929_nl <= MUX_s_1_2_2(nand_145_nl, mux_927_nl, fsm_output(7));
  mux_937_nl <= MUX_s_1_2_2(mux_936_nl, mux_929_nl, fsm_output(8));
  mux_943_nl <= MUX_s_1_2_2(mux_942_nl, mux_937_nl, fsm_output(0));
  or_1052_nl <= (fsm_output(3)) OR (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT
      (fsm_output(5))) OR (fsm_output(9));
  mux_922_nl <= MUX_s_1_2_2(or_1052_nl, mux_tmp_919, fsm_output(1));
  mux_924_nl <= MUX_s_1_2_2(mux_tmp_921, mux_922_nl, fsm_output(7));
  or_1051_nl <= (NOT (fsm_output(3))) OR (fsm_output(2)) OR (fsm_output(4)) OR (NOT
      (fsm_output(5))) OR (fsm_output(9));
  mux_919_nl <= MUX_s_1_2_2(or_1051_nl, mux_tmp_916, fsm_output(1));
  mux_913_nl <= MUX_s_1_2_2(or_1047_cse, or_tmp_949, fsm_output(2));
  mux_914_nl <= MUX_s_1_2_2(mux_913_nl, or_tmp_948, fsm_output(3));
  mux_915_nl <= MUX_s_1_2_2(mux_914_nl, mux_tmp_910, fsm_output(1));
  mux_920_nl <= MUX_s_1_2_2(mux_919_nl, mux_915_nl, fsm_output(7));
  mux_925_nl <= MUX_s_1_2_2(mux_924_nl, mux_920_nl, fsm_output(8));
  or_1041_nl <= (NOT (fsm_output(3))) OR (NOT VEC_LOOP_1_COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR (fsm_output(2)) OR (NOT (fsm_output(4))) OR (NOT (fsm_output(5))) OR (fsm_output(9));
  mux_910_nl <= MUX_s_1_2_2(or_tmp_942, or_1041_nl, fsm_output(1));
  mux_911_nl <= MUX_s_1_2_2(mux_910_nl, mux_tmp_907, fsm_output(7));
  or_1042_nl <= (fsm_output(8)) OR mux_911_nl;
  mux_926_nl <= MUX_s_1_2_2(mux_925_nl, or_1042_nl, fsm_output(0));
  mux_944_nl <= MUX_s_1_2_2(mux_943_nl, mux_926_nl, fsm_output(6));
  nand_117_nl <= NOT((fsm_output(9)) AND (fsm_output(5)) AND (NOT (fsm_output(4)))
      AND (fsm_output(0)) AND (fsm_output(3)) AND (fsm_output(1)) AND (NOT (fsm_output(8))));
  or_548_nl <= (fsm_output(0)) OR (fsm_output(3)) OR (NOT (fsm_output(1))) OR (fsm_output(8));
  nand_85_nl <= NOT((fsm_output(0)) AND (fsm_output(3)) AND (fsm_output(1)) AND (NOT
      (fsm_output(8))));
  mux_476_nl <= MUX_s_1_2_2(or_548_nl, nand_85_nl, fsm_output(4));
  or_546_nl <= (fsm_output(4)) OR (NOT (fsm_output(0))) OR (fsm_output(3)) OR (fsm_output(1))
      OR (NOT (fsm_output(8)));
  mux_477_nl <= MUX_s_1_2_2(mux_476_nl, or_546_nl, fsm_output(5));
  or_912_nl <= (fsm_output(9)) OR mux_477_nl;
  mux_478_nl <= MUX_s_1_2_2(nand_117_nl, or_912_nl, fsm_output(2));
  or_992_nl <= mux_478_nl OR CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  or_1069_nl <= (NOT (fsm_output(2))) OR (NOT (fsm_output(5))) OR (NOT (fsm_output(0)))
      OR (fsm_output(3)) OR (NOT (fsm_output(8))) OR (fsm_output(7)) OR (fsm_output(6));
  mux_947_nl <= MUX_s_1_2_2(or_1069_nl, or_tmp_971, fsm_output(9));
  or_1067_nl <= (fsm_output(2)) OR (NOT (fsm_output(5))) OR (NOT (fsm_output(0)))
      OR (NOT (fsm_output(3))) OR (fsm_output(8)) OR (fsm_output(7)) OR (fsm_output(6));
  mux_946_nl <= MUX_s_1_2_2(or_tmp_971, or_1067_nl, fsm_output(9));
  mux_948_nl <= MUX_s_1_2_2(mux_947_nl, mux_946_nl, fsm_output(1));
  nor_434_nl <= NOT((NOT (fsm_output(0))) OR (NOT (fsm_output(3))) OR (fsm_output(8))
      OR (fsm_output(7)) OR (fsm_output(6)));
  nor_435_nl <= NOT((fsm_output(0)) OR (NOT (fsm_output(3))) OR (fsm_output(8)) OR
      (NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)=STD_LOGIC_VECTOR'("11")))));
  mux_945_nl <= MUX_s_1_2_2(nor_434_nl, nor_435_nl, fsm_output(5));
  nand_143_nl <= NOT((NOT((NOT (fsm_output(1))) OR (fsm_output(9)) OR (NOT (fsm_output(2)))))
      AND mux_945_nl);
  mux_949_nl <= MUX_s_1_2_2(mux_948_nl, nand_143_nl, fsm_output(4));
  or_563_nl <= (fsm_output(4)) OR (fsm_output(6)) OR (fsm_output(7)) OR (fsm_output(8));
  or_562_nl <= (fsm_output(2)) OR (fsm_output(6)) OR (fsm_output(7)) OR (fsm_output(8));
  mux_499_nl <= MUX_s_1_2_2(or_563_nl, or_562_nl, and_524_cse);
  or_897_nl <= (fsm_output(5)) OR (fsm_output(3)) OR mux_499_nl;
  nor_216_nl <= NOT(and_256_cse OR (fsm_output(4)) OR (fsm_output(6)) OR (fsm_output(7))
      OR (fsm_output(8)));
  mux_498_nl <= MUX_s_1_2_2(nor_312_cse, nor_216_nl, fsm_output(5));
  mux_500_nl <= MUX_s_1_2_2(or_897_nl, mux_498_nl, fsm_output(9));
  and_144_nl <= and_dcpl_103 AND and_dcpl_29;
  r_or_nl <= ((NOT (modulo_result_rem_cmp_z(63))) AND nor_359_m1c) OR (not_tmp_231
      AND and_dcpl_40 AND (NOT (modulo_result_rem_cmp_z(63))));
  r_or_1_nl <= ((modulo_result_rem_cmp_z(63)) AND nor_359_m1c) OR (not_tmp_231 AND
      and_dcpl_40 AND (modulo_result_rem_cmp_z(63)));
  and_240_nl <= (fsm_output(6)) AND (NOT or_tmp_539);
  mux_524_nl <= MUX_s_1_2_2(mux_tmp_522, nor_tmp_83, fsm_output(6));
  mux_523_nl <= MUX_s_1_2_2((NOT or_tmp_539), mux_tmp_522, fsm_output(6));
  mux_525_nl <= MUX_s_1_2_2(mux_524_nl, mux_523_nl, fsm_output(0));
  mux_526_nl <= MUX_s_1_2_2(and_240_nl, mux_525_nl, fsm_output(7));
  nor_209_nl <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 2)/=STD_LOGIC_VECTOR'("1010")));
  mux_519_nl <= MUX_s_1_2_2(nor_209_nl, nor_tmp_81, fsm_output(6));
  and_149_nl <= (fsm_output(6)) AND mux_tmp_506;
  mux_520_nl <= MUX_s_1_2_2(mux_519_nl, and_149_nl, fsm_output(0));
  mux_521_nl <= MUX_s_1_2_2(mux_520_nl, mux_tmp_509, fsm_output(7));
  mux_527_nl <= MUX_s_1_2_2(mux_526_nl, mux_521_nl, fsm_output(8));
  or_581_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 2)/=STD_LOGIC_VECTOR'("1000"));
  mux_515_nl <= MUX_s_1_2_2(or_581_nl, or_tmp_539, fsm_output(6));
  or_579_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 2)/=STD_LOGIC_VECTOR'("0001"));
  or_577_nl <= (fsm_output(3)) OR (NOT and_213_cse);
  mux_513_nl <= MUX_s_1_2_2((NOT nor_tmp_86), or_577_nl, fsm_output(2));
  mux_514_nl <= MUX_s_1_2_2(or_579_nl, mux_513_nl, fsm_output(6));
  mux_516_nl <= MUX_s_1_2_2(mux_515_nl, mux_514_nl, fsm_output(0));
  mux_517_nl <= MUX_s_1_2_2(mux_516_nl, or_tmp_539, fsm_output(7));
  and_148_nl <= (fsm_output(6)) AND nor_tmp_83;
  mux_510_nl <= MUX_s_1_2_2(mux_tmp_506, mux_tmp_509, fsm_output(6));
  mux_507_nl <= MUX_s_1_2_2(nor_tmp_83, mux_tmp_506, fsm_output(6));
  mux_511_nl <= MUX_s_1_2_2(mux_510_nl, mux_507_nl, fsm_output(0));
  mux_512_nl <= MUX_s_1_2_2(and_148_nl, mux_511_nl, fsm_output(7));
  mux_518_nl <= MUX_s_1_2_2((NOT mux_517_nl), mux_512_nl, fsm_output(8));
  mux_528_nl <= MUX_s_1_2_2(mux_527_nl, mux_518_nl, fsm_output(1));
  nor_325_nl <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 2)/=STD_LOGIC_VECTOR'("0000000")));
  mux_529_nl <= MUX_s_1_2_2(mux_528_nl, nor_325_nl, fsm_output(9));
  nor_203_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR mux_561_cse);
  nor_204_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR mux_560_cse);
  mux_562_nl <= MUX_s_1_2_2(nor_203_nl, nor_204_nl, fsm_output(1));
  and_235_nl <= (fsm_output(6)) AND mux_562_nl;
  or_607_nl <= (fsm_output(7)) OR CONV_SL_1_1(VEC_LOOP_j_1_12_0_sva_11_0(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(2)) OR (fsm_output(3)) OR (fsm_output(8));
  or_606_nl <= (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(3)) OR CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (NOT (fsm_output(8)));
  mux_559_nl <= MUX_s_1_2_2(or_607_nl, or_606_nl, fsm_output(1));
  nor_205_nl <= NOT((fsm_output(6)) OR mux_559_nl);
  mux_563_nl <= MUX_s_1_2_2(and_235_nl, nor_205_nl, fsm_output(0));
  COMP_LOOP_or_6_nl <= (mux_563_nl AND and_dcpl_110) OR ((NOT((VEC_LOOP_j_1_12_0_sva_11_0(0))
      OR (COMP_LOOP_acc_11_psp_1_sva(0)))) AND and_160_m1c) OR ((NOT((reg_VEC_LOOP_1_acc_1_psp_ftd_1(0))
      OR (COMP_LOOP_acc_11_psp_1_sva(0)))) AND and_163_m1c);
  nor_200_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR mux_561_cse);
  nor_201_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR mux_560_cse);
  mux_567_nl <= MUX_s_1_2_2(nor_200_nl, nor_201_nl, fsm_output(1));
  and_234_nl <= (fsm_output(6)) AND mux_567_nl;
  or_618_nl <= (fsm_output(7)) OR CONV_SL_1_1(VEC_LOOP_j_1_12_0_sva_11_0(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("01")) OR (fsm_output(2)) OR (fsm_output(3)) OR (fsm_output(8));
  or_617_nl <= (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(3)) OR CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR (NOT (fsm_output(8)));
  mux_564_nl <= MUX_s_1_2_2(or_618_nl, or_617_nl, fsm_output(1));
  nor_202_nl <= NOT((fsm_output(6)) OR mux_564_nl);
  mux_568_nl <= MUX_s_1_2_2(and_234_nl, nor_202_nl, fsm_output(0));
  COMP_LOOP_or_7_nl <= (mux_568_nl AND and_dcpl_110) OR ((VEC_LOOP_j_1_12_0_sva_11_0(0))
      AND (NOT (COMP_LOOP_acc_11_psp_1_sva(0))) AND and_160_m1c) OR ((reg_VEC_LOOP_1_acc_1_psp_ftd_1(0))
      AND (NOT (COMP_LOOP_acc_11_psp_1_sva(0))) AND and_163_m1c);
  nor_197_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR mux_561_cse);
  nor_198_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR mux_560_cse);
  mux_572_nl <= MUX_s_1_2_2(nor_197_nl, nor_198_nl, fsm_output(1));
  and_233_nl <= (fsm_output(6)) AND mux_572_nl;
  or_629_nl <= (fsm_output(7)) OR CONV_SL_1_1(VEC_LOOP_j_1_12_0_sva_11_0(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("10")) OR (fsm_output(2)) OR (fsm_output(3)) OR (fsm_output(8));
  or_628_nl <= (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(3)) OR (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0))
      OR (NOT((reg_VEC_LOOP_1_acc_1_psp_ftd_1(1)) AND (fsm_output(8))));
  mux_569_nl <= MUX_s_1_2_2(or_629_nl, or_628_nl, fsm_output(1));
  nor_199_nl <= NOT((fsm_output(6)) OR mux_569_nl);
  mux_573_nl <= MUX_s_1_2_2(and_233_nl, nor_199_nl, fsm_output(0));
  COMP_LOOP_or_8_nl <= (mux_573_nl AND and_dcpl_110) OR ((COMP_LOOP_acc_11_psp_1_sva(0))
      AND (NOT (VEC_LOOP_j_1_12_0_sva_11_0(0))) AND and_160_m1c) OR ((COMP_LOOP_acc_11_psp_1_sva(0))
      AND (NOT (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0))) AND and_163_m1c);
  and_231_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT mux_561_cse);
  and_232_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_5_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT mux_560_cse);
  mux_577_nl <= MUX_s_1_2_2(and_231_nl, and_232_nl, fsm_output(1));
  and_230_nl <= (fsm_output(6)) AND mux_577_nl;
  or_636_nl <= (fsm_output(7)) OR CONV_SL_1_1(VEC_LOOP_j_1_12_0_sva_11_0(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("11")) OR (fsm_output(2)) OR (fsm_output(3)) OR (fsm_output(8));
  or_635_nl <= (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(3)) OR (NOT(CONV_SL_1_1(reg_VEC_LOOP_1_acc_1_psp_ftd_1(1
      DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (fsm_output(8))));
  mux_574_nl <= MUX_s_1_2_2(or_636_nl, or_635_nl, fsm_output(1));
  nor_196_nl <= NOT((fsm_output(6)) OR mux_574_nl);
  mux_578_nl <= MUX_s_1_2_2(and_230_nl, nor_196_nl, fsm_output(0));
  COMP_LOOP_or_9_nl <= (mux_578_nl AND and_dcpl_110) OR ((VEC_LOOP_j_1_12_0_sva_11_0(0))
      AND (COMP_LOOP_acc_11_psp_1_sva(0)) AND and_160_m1c) OR ((reg_VEC_LOOP_1_acc_1_psp_ftd_1(0))
      AND (COMP_LOOP_acc_11_psp_1_sva(0)) AND and_163_m1c);
  mux_551_nl <= MUX_s_1_2_2((NOT or_756_cse), (fsm_output(4)), fsm_output(7));
  mux_552_nl <= MUX_s_1_2_2(mux_551_nl, mux_tmp_546, fsm_output(2));
  mux_553_nl <= MUX_s_1_2_2(mux_552_nl, or_tmp_567, fsm_output(8));
  mux_554_nl <= MUX_s_1_2_2(mux_553_nl, mux_tmp_549, fsm_output(1));
  mux_545_nl <= MUX_s_1_2_2(and_303_cse, or_756_cse, fsm_output(7));
  mux_547_nl <= MUX_s_1_2_2(mux_tmp_546, mux_545_nl, fsm_output(2));
  mux_548_nl <= MUX_s_1_2_2(mux_547_nl, or_tmp_562, fsm_output(8));
  mux_550_nl <= MUX_s_1_2_2(mux_tmp_549, mux_548_nl, fsm_output(1));
  mux_555_nl <= MUX_s_1_2_2(mux_554_nl, mux_550_nl, fsm_output(0));
  mux_543_nl <= MUX_s_1_2_2(or_tmp_562, (fsm_output(4)), fsm_output(8));
  mux_542_nl <= MUX_s_1_2_2(or_756_cse, or_tmp_567, fsm_output(8));
  mux_544_nl <= MUX_s_1_2_2(mux_543_nl, mux_542_nl, fsm_output(1));
  mux_556_nl <= MUX_s_1_2_2(mux_555_nl, mux_544_nl, fsm_output(6));
  or_603_nl <= (NOT((NOT (fsm_output(2))) OR (fsm_output(7)))) OR CONV_SL_1_1(fsm_output(4
      DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_601_nl <= and_256_cse OR (fsm_output(4));
  mux_539_nl <= MUX_s_1_2_2(or_603_nl, or_601_nl, fsm_output(8));
  mux_540_nl <= MUX_s_1_2_2(mux_539_nl, mux_tmp_537, fsm_output(1));
  or_598_nl <= (fsm_output(2)) OR (NOT (fsm_output(7))) OR (fsm_output(3)) OR (fsm_output(4));
  mux_536_nl <= MUX_s_1_2_2(or_598_nl, or_756_cse, fsm_output(8));
  mux_538_nl <= MUX_s_1_2_2(mux_tmp_537, mux_536_nl, fsm_output(1));
  mux_541_nl <= MUX_s_1_2_2(mux_540_nl, mux_538_nl, or_596_cse);
  mux_557_nl <= MUX_s_1_2_2(mux_556_nl, (NOT mux_541_nl), fsm_output(5));
  or_593_nl <= (fsm_output(7)) OR and_303_cse;
  or_592_nl <= (fsm_output(7)) OR (fsm_output(4));
  mux_534_nl <= MUX_s_1_2_2(or_593_nl, or_592_nl, fsm_output(2));
  or_594_nl <= (fsm_output(8)) OR mux_534_nl;
  or_591_nl <= (fsm_output(8)) OR (fsm_output(7)) OR (fsm_output(4));
  mux_535_nl <= MUX_s_1_2_2(or_594_nl, or_591_nl, or_590_cse);
  or_1002_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR mux_535_nl;
  VEC_LOOP_1_COMP_LOOP_1_acc_11_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED((z_out_5(7
      DOWNTO 0)) & STD_LOGIC_VECTOR'( "00")) + SIGNED('1' & (NOT (STAGE_LOOP_lshift_psp_sva(9
      DOWNTO 1)))) + SIGNED'( "0000000001"), 10));
  VEC_LOOP_1_COMP_LOOP_1_acc_8_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(tmp_10_lpi_4_dfm)
      - SIGNED(modExp_base_1_sva_mx1), 64));
  or_721_nl <= (fsm_output(0)) OR (fsm_output(6)) OR (fsm_output(1)) OR (fsm_output(8))
      OR (NOT (fsm_output(3)));
  nand_58_nl <= NOT((fsm_output(0)) AND mux_680_cse);
  mux_681_nl <= MUX_s_1_2_2(or_721_nl, nand_58_nl, fsm_output(5));
  nor_173_nl <= NOT((fsm_output(2)) OR mux_681_nl);
  nor_175_nl <= NOT((fsm_output(6)) OR (NOT((fsm_output(1)) AND (fsm_output(8)) AND
      (fsm_output(3)))));
  and_223_nl <= (fsm_output(6)) AND (fsm_output(1)) AND (fsm_output(8)) AND (fsm_output(3));
  mux_678_nl <= MUX_s_1_2_2(nor_175_nl, and_223_nl, fsm_output(0));
  and_222_nl <= (fsm_output(5)) AND mux_678_nl;
  nor_176_nl <= NOT((fsm_output(6)) OR (fsm_output(1)) OR (fsm_output(8)) OR (fsm_output(3)));
  nor_177_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(1)) OR (fsm_output(8)) OR
      (fsm_output(3)));
  mux_677_nl <= MUX_s_1_2_2(nor_176_nl, nor_177_nl, fsm_output(0));
  and_224_nl <= (fsm_output(5)) AND mux_677_nl;
  mux_679_nl <= MUX_s_1_2_2(and_222_nl, and_224_nl, fsm_output(2));
  mux_682_nl <= MUX_s_1_2_2(nor_173_nl, mux_679_nl, fsm_output(7));
  mux_87_nl <= MUX_s_1_2_2(mux_tmp_86, mux_tmp_84, fsm_output(3));
  mux_85_nl <= MUX_s_1_2_2(mux_tmp_84, or_tmp_77, fsm_output(3));
  and_297_nl <= or_590_cse AND (fsm_output(2));
  mux_88_nl <= MUX_s_1_2_2(mux_87_nl, mux_85_nl, and_297_nl);
  mux_89_nl <= MUX_s_1_2_2(mux_tmp_86, mux_88_nl, fsm_output(4));
  mux_699_nl <= MUX_s_1_2_2(or_tmp_77, or_tmp_71, fsm_output(3));
  mux_79_nl <= MUX_s_1_2_2(mux_tmp_72, or_tmp_71, fsm_output(3));
  mux_700_nl <= MUX_s_1_2_2(mux_699_nl, mux_79_nl, or_94_cse);
  or_93_nl <= and_300_cse OR (fsm_output(3));
  mux_78_nl <= MUX_s_1_2_2(mux_tmp_72, or_tmp_71, or_93_nl);
  mux_701_nl <= MUX_s_1_2_2(mux_700_nl, mux_78_nl, fsm_output(0));
  mux_702_nl <= MUX_s_1_2_2(mux_701_nl, or_tmp_71, fsm_output(4));
  mux_709_nl <= MUX_s_1_2_2(mux_89_nl, mux_702_nl, fsm_output(5));
  COMP_LOOP_mux_42_nl <= MUX_v_11_2_2((VEC_LOOP_j_1_12_0_sva_11_0(11 DOWNTO 1)),
      (reg_VEC_LOOP_1_acc_1_psp_ftd_1(11 DOWNTO 1)), and_365_cse);
  mux_717_nl <= MUX_s_1_2_2(or_154_cse, (NOT mux_tmp_711), and_300_cse);
  mux_718_nl <= MUX_s_1_2_2(mux_717_nl, or_154_cse, fsm_output(8));
  or_758_nl <= (NOT (fsm_output(8))) OR (fsm_output(2));
  mux_716_nl <= MUX_s_1_2_2((NOT or_154_cse), mux_tmp_711, or_758_nl);
  mux_719_nl <= MUX_s_1_2_2((NOT mux_718_nl), mux_716_nl, fsm_output(3));
  mux_720_nl <= MUX_s_1_2_2((NOT or_154_cse), mux_719_nl, fsm_output(4));
  or_757_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"));
  mux_713_nl <= MUX_s_1_2_2(mux_tmp_711, and_205_cse, or_757_nl);
  and_217_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  mux_712_nl <= MUX_s_1_2_2(mux_tmp_711, and_205_cse, and_217_nl);
  mux_714_nl <= MUX_s_1_2_2(mux_713_nl, mux_712_nl, fsm_output(8));
  mux_715_nl <= MUX_s_1_2_2(mux_714_nl, and_205_cse, or_756_cse);
  mux_721_nl <= MUX_s_1_2_2(mux_720_nl, mux_715_nl, fsm_output(5));
  or_763_nl <= and_213_cse OR (fsm_output(7));
  or_762_nl <= (fsm_output(5)) OR (fsm_output(7));
  or_761_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 0)/=STD_LOGIC_VECTOR'("0000"));
  mux_730_nl <= MUX_s_1_2_2(or_763_nl, or_762_nl, or_761_nl);
  nor_171_nl <= NOT((fsm_output(6)) OR mux_730_nl);
  mux_726_nl <= MUX_s_1_2_2(mux_tmp_723, mux_tmp_722, and_524_cse);
  mux_727_nl <= MUX_s_1_2_2(and_tmp_14, mux_726_nl, fsm_output(3));
  mux_724_nl <= MUX_s_1_2_2(and_tmp_14, mux_tmp_723, and_524_cse);
  mux_725_nl <= MUX_s_1_2_2(mux_724_nl, mux_tmp_722, fsm_output(3));
  mux_728_nl <= MUX_s_1_2_2(mux_727_nl, mux_725_nl, fsm_output(2));
  mux_729_nl <= MUX_s_1_2_2(mux_728_nl, (fsm_output(7)), fsm_output(6));
  mux_731_nl <= MUX_s_1_2_2(nor_171_nl, mux_729_nl, fsm_output(8));
  nor_142_nl <= NOT((fsm_output(4)) OR (fsm_output(6)) OR (fsm_output(3)) OR (fsm_output(2))
      OR (NOT and_dcpl_86));
  nor_143_nl <= NOT((NOT (fsm_output(4))) OR (NOT (fsm_output(6))) OR (NOT (fsm_output(3)))
      OR (NOT (fsm_output(2))) OR (fsm_output(8)) OR (fsm_output(1)) OR (fsm_output(7)));
  mux_807_nl <= MUX_s_1_2_2(nor_142_nl, nor_143_nl, fsm_output(5));
  operator_64_false_1_mux_5_nl <= MUX_v_2_2_2((VEC_LOOP_j_1_12_0_sva_11_0(11 DOWNTO
      10)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(11 DOWNTO 10)), and_dcpl_215);
  operator_64_false_1_operator_64_false_1_or_1_nl <= MUX_v_2_2_2(operator_64_false_1_mux_5_nl,
      STD_LOGIC_VECTOR'("11"), operator_64_false_1_or_2_itm);
  operator_64_false_1_mux1h_9_nl <= MUX1HOT_s_1_4_2((NOT modExp_exp_1_7_1_sva), (VEC_LOOP_j_1_12_0_sva_11_0(9)),
      (reg_VEC_LOOP_1_acc_1_psp_ftd_1(9)), (NOT modExp_exp_1_1_1_sva), STD_LOGIC_VECTOR'(
      and_dcpl_199 & and_dcpl_208 & and_dcpl_215 & and_dcpl_221));
  operator_64_false_1_mux1h_10_nl <= MUX1HOT_s_1_4_2((NOT modExp_exp_1_6_1_sva),
      (VEC_LOOP_j_1_12_0_sva_11_0(8)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(8)), (NOT
      modExp_exp_1_7_1_sva), STD_LOGIC_VECTOR'( and_dcpl_199 & and_dcpl_208 & and_dcpl_215
      & and_dcpl_221));
  operator_64_false_1_mux1h_11_nl <= MUX1HOT_s_1_4_2((NOT modExp_exp_1_5_1_sva),
      (VEC_LOOP_j_1_12_0_sva_11_0(7)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(7)), (NOT
      modExp_exp_1_6_1_sva), STD_LOGIC_VECTOR'( and_dcpl_199 & and_dcpl_208 & and_dcpl_215
      & and_dcpl_221));
  operator_64_false_1_mux1h_12_nl <= MUX1HOT_s_1_4_2((NOT modExp_exp_1_4_1_sva),
      (VEC_LOOP_j_1_12_0_sva_11_0(6)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(6)), (NOT
      modExp_exp_1_5_1_sva), STD_LOGIC_VECTOR'( and_dcpl_199 & and_dcpl_208 & and_dcpl_215
      & and_dcpl_221));
  operator_64_false_1_mux1h_13_nl <= MUX1HOT_s_1_4_2((NOT modExp_exp_1_3_1_sva),
      (VEC_LOOP_j_1_12_0_sva_11_0(5)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(5)), (NOT
      modExp_exp_1_4_1_sva), STD_LOGIC_VECTOR'( and_dcpl_199 & and_dcpl_208 & and_dcpl_215
      & and_dcpl_221));
  operator_64_false_1_mux1h_14_nl <= MUX1HOT_s_1_4_2((NOT modExp_exp_1_2_1_sva),
      (VEC_LOOP_j_1_12_0_sva_11_0(4)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(4)), (NOT
      modExp_exp_1_3_1_sva), STD_LOGIC_VECTOR'( and_dcpl_199 & and_dcpl_208 & and_dcpl_215
      & and_dcpl_221));
  operator_64_false_1_mux1h_15_nl <= MUX1HOT_s_1_4_2((NOT modExp_exp_1_1_1_sva),
      (VEC_LOOP_j_1_12_0_sva_11_0(3)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(3)), (NOT
      modExp_exp_1_2_1_sva), STD_LOGIC_VECTOR'( and_dcpl_199 & and_dcpl_208 & and_dcpl_215
      & and_dcpl_221));
  operator_64_false_1_mux1h_16_nl <= MUX1HOT_s_1_3_2((NOT modExp_exp_1_0_1_sva_1),
      (VEC_LOOP_j_1_12_0_sva_11_0(2)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(2)), STD_LOGIC_VECTOR'(
      operator_64_false_1_or_2_itm & and_dcpl_208 & and_dcpl_215));
  operator_64_false_1_or_6_nl <= and_dcpl_208 OR and_dcpl_215;
  operator_64_false_1_operator_64_false_1_mux_1_nl <= MUX_v_7_2_2(STD_LOGIC_VECTOR'(
      "0000001"), COMP_LOOP_k_9_2_1_sva_6_0, operator_64_false_1_or_6_nl);
  z_out_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(operator_64_false_1_operator_64_false_1_or_1_nl
      & operator_64_false_1_mux1h_9_nl & operator_64_false_1_mux1h_10_nl & operator_64_false_1_mux1h_11_nl
      & operator_64_false_1_mux1h_12_nl & operator_64_false_1_mux1h_13_nl & operator_64_false_1_mux1h_14_nl
      & operator_64_false_1_mux1h_15_nl & operator_64_false_1_mux1h_16_nl) + CONV_UNSIGNED(UNSIGNED(operator_64_false_1_operator_64_false_1_mux_1_nl),
      10), 10));
  COMP_LOOP_mux1h_83_nl <= MUX1HOT_v_3_3_2((VEC_LOOP_j_1_12_0_sva_11_0(11 DOWNTO
      9)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(11 DOWNTO 9)), STD_LOGIC_VECTOR'( "001"),
      STD_LOGIC_VECTOR'( and_dcpl_230 & and_365_cse & COMP_LOOP_or_27_itm));
  COMP_LOOP_mux1h_84_nl <= MUX1HOT_v_9_3_2((VEC_LOOP_j_1_12_0_sva_11_0(8 DOWNTO 0)),
      (reg_VEC_LOOP_1_acc_1_psp_ftd_1(8 DOWNTO 0)), (NOT (STAGE_LOOP_lshift_psp_sva(9
      DOWNTO 1))), STD_LOGIC_VECTOR'( and_dcpl_230 & and_365_cse & COMP_LOOP_or_27_itm));
  COMP_LOOP_or_34_nl <= (NOT(and_dcpl_230 OR and_365_cse)) OR and_dcpl_242 OR and_dcpl_244;
  COMP_LOOP_mux_41_nl <= MUX_v_2_2_2(STD_LOGIC_VECTOR'( "01"), STD_LOGIC_VECTOR'(
      "10"), and_dcpl_244);
  COMP_LOOP_COMP_LOOP_or_3_nl <= MUX_v_2_2_2(COMP_LOOP_mux_41_nl, STD_LOGIC_VECTOR'("11"),
      and_365_cse);
  acc_2_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux1h_83_nl & COMP_LOOP_mux1h_84_nl
      & COMP_LOOP_or_34_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_2_1_sva_6_0
      & COMP_LOOP_COMP_LOOP_or_3_nl & '1'), 10), 13), 13));
  z_out_2 <= acc_2_nl(12 DOWNTO 1);
  and_532_nl <= nor_332_cse AND (fsm_output(2)) AND (fsm_output(8)) AND (fsm_output(5))
      AND (NOT (fsm_output(9))) AND (fsm_output(1)) AND (NOT (fsm_output(7))) AND
      and_dcpl_200;
  COMP_LOOP_or_35_nl <= and_dcpl_244 OR and_392_cse;
  COMP_LOOP_mux1h_85_nl <= MUX1HOT_v_12_3_2(VEC_LOOP_j_1_12_0_sva_11_0, reg_VEC_LOOP_1_acc_1_psp_ftd_1,
      (STD_LOGIC_VECTOR'( "00") & STAGE_LOOP_lshift_psp_sva), STD_LOGIC_VECTOR'(
      and_dcpl_253 & and_532_nl & COMP_LOOP_or_35_nl));
  COMP_LOOP_COMP_LOOP_or_4_nl <= and_dcpl_253 OR and_392_cse;
  z_out_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux1h_85_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_2_1_sva_6_0
      & COMP_LOOP_COMP_LOOP_or_4_nl & '1'), 9), 12), 12));
  COMP_LOOP_COMP_LOOP_or_5_nl <= (NOT(and_dcpl_283 OR and_dcpl_292 OR and_392_cse
      OR and_dcpl_310)) OR and_dcpl_302;
  COMP_LOOP_mux1h_86_nl <= MUX1HOT_v_64_5_2(tmp_10_lpi_4_dfm, p_sva, (STD_LOGIC_VECTOR'(
      "000000000000000000000000000000000000000000000000000000000") & COMP_LOOP_k_9_2_1_sva_6_0),
      (NOT (operator_66_true_div_cmp_z(63 DOWNTO 0))), (STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000")
      & (z_out_6(3 DOWNTO 1))), STD_LOGIC_VECTOR'( and_dcpl_283 & and_dcpl_292 &
      and_392_cse & and_dcpl_302 & and_dcpl_310));
  COMP_LOOP_or_37_nl <= and_392_cse OR and_dcpl_302;
  COMP_LOOP_mux1h_87_nl <= MUX1HOT_v_64_3_2(modExp_base_1_sva_mx1, STD_LOGIC_VECTOR'(
      "0000000000000000000000000000000000000000000000000000000000000001"), STD_LOGIC_VECTOR'(
      "0000000000000000000000000000000000000000000000000000000000000011"), STD_LOGIC_VECTOR'(
      and_dcpl_283 & COMP_LOOP_or_37_nl & and_dcpl_310));
  COMP_LOOP_or_36_nl <= MUX_v_64_2_2(COMP_LOOP_mux1h_87_nl, STD_LOGIC_VECTOR'("1111111111111111111111111111111111111111111111111111111111111111"),
      and_dcpl_292);
  z_out_5 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_or_5_nl
      & COMP_LOOP_mux1h_86_nl) + CONV_UNSIGNED(SIGNED(COMP_LOOP_or_36_nl), 65), 65));
  STAGE_LOOP_STAGE_LOOP_or_1_nl <= ((modulo_result_rem_cmp_z(63)) AND STAGE_LOOP_nor_itm)
      OR and_dcpl_327;
  STAGE_LOOP_mux_55_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(62)), (NOT (operator_64_false_acc_mut_63_0(62))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_103_nl <= STAGE_LOOP_mux_55_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_56_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(61)), (NOT (operator_64_false_acc_mut_63_0(61))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_104_nl <= STAGE_LOOP_mux_56_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_57_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(60)), (NOT (operator_64_false_acc_mut_63_0(60))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_105_nl <= STAGE_LOOP_mux_57_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_58_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(59)), (NOT (operator_64_false_acc_mut_63_0(59))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_106_nl <= STAGE_LOOP_mux_58_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_59_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(58)), (NOT (operator_64_false_acc_mut_63_0(58))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_107_nl <= STAGE_LOOP_mux_59_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_60_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(57)), (NOT (operator_64_false_acc_mut_63_0(57))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_108_nl <= STAGE_LOOP_mux_60_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_61_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(56)), (NOT (operator_64_false_acc_mut_63_0(56))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_109_nl <= STAGE_LOOP_mux_61_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_62_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(55)), (NOT (operator_64_false_acc_mut_63_0(55))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_110_nl <= STAGE_LOOP_mux_62_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_63_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(54)), (NOT (operator_64_false_acc_mut_63_0(54))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_111_nl <= STAGE_LOOP_mux_63_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_64_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(53)), (NOT (operator_64_false_acc_mut_63_0(53))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_112_nl <= STAGE_LOOP_mux_64_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_65_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(52)), (NOT (operator_64_false_acc_mut_63_0(52))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_113_nl <= STAGE_LOOP_mux_65_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_66_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(51)), (NOT (operator_64_false_acc_mut_63_0(51))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_114_nl <= STAGE_LOOP_mux_66_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_67_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(50)), (NOT (operator_64_false_acc_mut_63_0(50))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_115_nl <= STAGE_LOOP_mux_67_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_68_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(49)), (NOT (operator_64_false_acc_mut_63_0(49))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_116_nl <= STAGE_LOOP_mux_68_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_69_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(48)), (NOT (operator_64_false_acc_mut_63_0(48))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_117_nl <= STAGE_LOOP_mux_69_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_70_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(47)), (NOT (operator_64_false_acc_mut_63_0(47))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_118_nl <= STAGE_LOOP_mux_70_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_71_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(46)), (NOT (operator_64_false_acc_mut_63_0(46))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_119_nl <= STAGE_LOOP_mux_71_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_72_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(45)), (NOT (operator_64_false_acc_mut_63_0(45))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_120_nl <= STAGE_LOOP_mux_72_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_73_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(44)), (NOT (operator_64_false_acc_mut_63_0(44))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_121_nl <= STAGE_LOOP_mux_73_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_74_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(43)), (NOT (operator_64_false_acc_mut_63_0(43))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_122_nl <= STAGE_LOOP_mux_74_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_75_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(42)), (NOT (operator_64_false_acc_mut_63_0(42))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_123_nl <= STAGE_LOOP_mux_75_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_76_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(41)), (NOT (operator_64_false_acc_mut_63_0(41))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_124_nl <= STAGE_LOOP_mux_76_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_77_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(40)), (NOT (operator_64_false_acc_mut_63_0(40))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_125_nl <= STAGE_LOOP_mux_77_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_78_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(39)), (NOT (operator_64_false_acc_mut_63_0(39))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_126_nl <= STAGE_LOOP_mux_78_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_79_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(38)), (NOT (operator_64_false_acc_mut_63_0(38))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_127_nl <= STAGE_LOOP_mux_79_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_80_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(37)), (NOT (operator_64_false_acc_mut_63_0(37))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_128_nl <= STAGE_LOOP_mux_80_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_81_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(36)), (NOT (operator_64_false_acc_mut_63_0(36))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_129_nl <= STAGE_LOOP_mux_81_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_82_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(35)), (NOT (operator_64_false_acc_mut_63_0(35))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_130_nl <= STAGE_LOOP_mux_82_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_83_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(34)), (NOT (operator_64_false_acc_mut_63_0(34))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_131_nl <= STAGE_LOOP_mux_83_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_84_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(33)), (NOT (operator_64_false_acc_mut_63_0(33))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_132_nl <= STAGE_LOOP_mux_84_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_85_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(32)), (NOT (operator_64_false_acc_mut_63_0(32))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_133_nl <= STAGE_LOOP_mux_85_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_86_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(31)), (NOT (operator_64_false_acc_mut_63_0(31))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_134_nl <= STAGE_LOOP_mux_86_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_87_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(30)), (NOT (operator_64_false_acc_mut_63_0(30))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_135_nl <= STAGE_LOOP_mux_87_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_88_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(29)), (NOT (operator_64_false_acc_mut_63_0(29))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_136_nl <= STAGE_LOOP_mux_88_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_89_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(28)), (NOT (operator_64_false_acc_mut_63_0(28))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_137_nl <= STAGE_LOOP_mux_89_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_90_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(27)), (NOT (operator_64_false_acc_mut_63_0(27))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_138_nl <= STAGE_LOOP_mux_90_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_91_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(26)), (NOT (operator_64_false_acc_mut_63_0(26))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_139_nl <= STAGE_LOOP_mux_91_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_92_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(25)), (NOT (operator_64_false_acc_mut_63_0(25))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_140_nl <= STAGE_LOOP_mux_92_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_93_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(24)), (NOT (operator_64_false_acc_mut_63_0(24))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_141_nl <= STAGE_LOOP_mux_93_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_94_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(23)), (NOT (operator_64_false_acc_mut_63_0(23))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_142_nl <= STAGE_LOOP_mux_94_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_95_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(22)), (NOT (operator_64_false_acc_mut_63_0(22))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_143_nl <= STAGE_LOOP_mux_95_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_96_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(21)), (NOT (operator_64_false_acc_mut_63_0(21))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_144_nl <= STAGE_LOOP_mux_96_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_97_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(20)), (NOT (operator_64_false_acc_mut_63_0(20))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_145_nl <= STAGE_LOOP_mux_97_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_98_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(19)), (NOT (operator_64_false_acc_mut_63_0(19))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_146_nl <= STAGE_LOOP_mux_98_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_99_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(18)), (NOT (operator_64_false_acc_mut_63_0(18))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_147_nl <= STAGE_LOOP_mux_99_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_100_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(17)), (NOT (operator_64_false_acc_mut_63_0(17))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_148_nl <= STAGE_LOOP_mux_100_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_101_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(16)), (NOT (operator_64_false_acc_mut_63_0(16))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_149_nl <= STAGE_LOOP_mux_101_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_102_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(15)), (NOT (operator_64_false_acc_mut_63_0(15))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_150_nl <= STAGE_LOOP_mux_102_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_103_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(14)), (NOT (operator_64_false_acc_mut_63_0(14))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_151_nl <= STAGE_LOOP_mux_103_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_104_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(13)), (NOT (operator_64_false_acc_mut_63_0(13))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_152_nl <= STAGE_LOOP_mux_104_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux_105_nl <= MUX_s_1_2_2((modulo_result_rem_cmp_z(12)), (NOT (operator_64_false_acc_mut_63_0(12))),
      and_dcpl_327);
  STAGE_LOOP_STAGE_LOOP_and_153_nl <= STAGE_LOOP_mux_105_nl AND STAGE_LOOP_nor_itm;
  STAGE_LOOP_mux1h_6_nl <= MUX1HOT_v_2_4_2((modulo_result_rem_cmp_z(11 DOWNTO 10)),
      (NOT (operator_64_false_acc_mut_63_0(11 DOWNTO 10))), (VEC_LOOP_j_1_12_0_sva_11_0(11
      DOWNTO 10)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(11 DOWNTO 10)), STD_LOGIC_VECTOR'(
      (NOT mux_860_itm) & and_dcpl_327 & and_dcpl_361 & and_dcpl_367));
  STAGE_LOOP_nor_106_nl <= NOT(and_dcpl_319 OR and_dcpl_331 OR and_dcpl_339 OR and_dcpl_342
      OR and_dcpl_345 OR and_dcpl_352 OR and_dcpl_354 OR and_dcpl_356 OR and_dcpl_357);
  STAGE_LOOP_and_4_nl <= MUX_v_2_2_2(STD_LOGIC_VECTOR'("00"), STAGE_LOOP_mux1h_6_nl,
      STAGE_LOOP_nor_106_nl);
  COMP_LOOP_acc_61_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva(9
      DOWNTO 2)) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_2_1_sva_6_0),
      7), 8), 8));
  COMP_LOOP_acc_62_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva(9
      DOWNTO 1)) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_2_1_sva_6_0
      & '1'), 8), 9), 9));
  STAGE_LOOP_or_10_nl <= and_dcpl_331 OR and_dcpl_352;
  STAGE_LOOP_or_11_nl <= and_dcpl_342 OR and_dcpl_356;
  STAGE_LOOP_mux1h_7_nl <= MUX1HOT_v_9_8_2((STD_LOGIC_VECTOR'( "000000") & (STAGE_LOOP_i_3_0_sva(3
      DOWNTO 1))), (modulo_result_rem_cmp_z(9 DOWNTO 1)), (NOT (operator_64_false_acc_mut_63_0(9
      DOWNTO 1))), (STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_acc_61_nl),
      8)) & (STAGE_LOOP_lshift_psp_sva(1))), (z_out_3(9 DOWNTO 1)), STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_acc_62_nl),
      9)), (VEC_LOOP_j_1_12_0_sva_11_0(9 DOWNTO 1)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(9
      DOWNTO 1)), STD_LOGIC_VECTOR'( and_dcpl_319 & (NOT mux_860_itm) & and_dcpl_327
      & STAGE_LOOP_or_10_nl & STAGE_LOOP_or_ssc & STAGE_LOOP_or_11_nl & and_dcpl_361
      & and_dcpl_367));
  STAGE_LOOP_or_12_nl <= and_dcpl_331 OR and_dcpl_342 OR and_dcpl_352 OR and_dcpl_356;
  STAGE_LOOP_mux1h_8_nl <= MUX1HOT_s_1_7_2((STAGE_LOOP_i_3_0_sva(0)), (modulo_result_rem_cmp_z(0)),
      (NOT (operator_64_false_acc_mut_63_0(0))), (STAGE_LOOP_lshift_psp_sva(0)),
      (z_out_3(0)), (VEC_LOOP_j_1_12_0_sva_11_0(0)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(0)),
      STD_LOGIC_VECTOR'( and_dcpl_319 & (NOT mux_860_itm) & and_dcpl_327 & STAGE_LOOP_or_12_nl
      & STAGE_LOOP_or_ssc & and_dcpl_361 & and_dcpl_367));
  STAGE_LOOP_STAGE_LOOP_and_154_nl <= (p_sva(63)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_155_nl <= (p_sva(62)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_156_nl <= (p_sva(61)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_157_nl <= (p_sva(60)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_158_nl <= (p_sva(59)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_159_nl <= (p_sva(58)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_160_nl <= (p_sva(57)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_161_nl <= (p_sva(56)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_162_nl <= (p_sva(55)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_163_nl <= (p_sva(54)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_164_nl <= (p_sva(53)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_165_nl <= (p_sva(52)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_166_nl <= (p_sva(51)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_167_nl <= (p_sva(50)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_168_nl <= (p_sva(49)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_169_nl <= (p_sva(48)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_170_nl <= (p_sva(47)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_171_nl <= (p_sva(46)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_172_nl <= (p_sva(45)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_173_nl <= (p_sva(44)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_174_nl <= (p_sva(43)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_175_nl <= (p_sva(42)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_176_nl <= (p_sva(41)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_177_nl <= (p_sva(40)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_178_nl <= (p_sva(39)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_179_nl <= (p_sva(38)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_180_nl <= (p_sva(37)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_181_nl <= (p_sva(36)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_182_nl <= (p_sva(35)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_183_nl <= (p_sva(34)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_184_nl <= (p_sva(33)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_185_nl <= (p_sva(32)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_186_nl <= (p_sva(31)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_187_nl <= (p_sva(30)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_188_nl <= (p_sva(29)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_189_nl <= (p_sva(28)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_190_nl <= (p_sva(27)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_191_nl <= (p_sva(26)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_192_nl <= (p_sva(25)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_193_nl <= (p_sva(24)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_194_nl <= (p_sva(23)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_195_nl <= (p_sva(22)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_196_nl <= (p_sva(21)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_197_nl <= (p_sva(20)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_198_nl <= (p_sva(19)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_199_nl <= (p_sva(18)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_200_nl <= (p_sva(17)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_201_nl <= (p_sva(16)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_202_nl <= (p_sva(15)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_203_nl <= (p_sva(14)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_204_nl <= (p_sva(13)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_STAGE_LOOP_and_205_nl <= (p_sva(12)) AND STAGE_LOOP_nor_53_itm;
  STAGE_LOOP_mux1h_9_nl <= MUX1HOT_v_2_3_2((p_sva(11 DOWNTO 10)), (VEC_LOOP_j_1_12_0_sva_11_0(11
      DOWNTO 10)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(11 DOWNTO 10)), STD_LOGIC_VECTOR'(
      (NOT mux_860_itm) & STAGE_LOOP_or_1_itm & STAGE_LOOP_or_2_itm));
  STAGE_LOOP_nor_107_nl <= NOT(and_dcpl_319 OR and_dcpl_327 OR and_dcpl_361 OR and_dcpl_367);
  STAGE_LOOP_and_5_nl <= MUX_v_2_2_2(STD_LOGIC_VECTOR'("00"), STAGE_LOOP_mux1h_9_nl,
      STAGE_LOOP_nor_107_nl);
  STAGE_LOOP_or_13_nl <= and_dcpl_319 OR and_dcpl_327;
  STAGE_LOOP_or_14_nl <= and_dcpl_361 OR and_dcpl_367;
  STAGE_LOOP_mux1h_10_nl <= MUX1HOT_v_10_5_2(STD_LOGIC_VECTOR'( "0000000001"), (p_sva(9
      DOWNTO 0)), (VEC_LOOP_j_1_12_0_sva_11_0(9 DOWNTO 0)), (reg_VEC_LOOP_1_acc_1_psp_ftd_1(9
      DOWNTO 0)), STAGE_LOOP_lshift_psp_sva, STD_LOGIC_VECTOR'( STAGE_LOOP_or_13_nl
      & (NOT mux_860_itm) & STAGE_LOOP_or_1_itm & STAGE_LOOP_or_2_itm & STAGE_LOOP_or_14_nl));
  z_out_6 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_STAGE_LOOP_or_1_nl
      & STAGE_LOOP_STAGE_LOOP_and_103_nl & STAGE_LOOP_STAGE_LOOP_and_104_nl & STAGE_LOOP_STAGE_LOOP_and_105_nl
      & STAGE_LOOP_STAGE_LOOP_and_106_nl & STAGE_LOOP_STAGE_LOOP_and_107_nl & STAGE_LOOP_STAGE_LOOP_and_108_nl
      & STAGE_LOOP_STAGE_LOOP_and_109_nl & STAGE_LOOP_STAGE_LOOP_and_110_nl & STAGE_LOOP_STAGE_LOOP_and_111_nl
      & STAGE_LOOP_STAGE_LOOP_and_112_nl & STAGE_LOOP_STAGE_LOOP_and_113_nl & STAGE_LOOP_STAGE_LOOP_and_114_nl
      & STAGE_LOOP_STAGE_LOOP_and_115_nl & STAGE_LOOP_STAGE_LOOP_and_116_nl & STAGE_LOOP_STAGE_LOOP_and_117_nl
      & STAGE_LOOP_STAGE_LOOP_and_118_nl & STAGE_LOOP_STAGE_LOOP_and_119_nl & STAGE_LOOP_STAGE_LOOP_and_120_nl
      & STAGE_LOOP_STAGE_LOOP_and_121_nl & STAGE_LOOP_STAGE_LOOP_and_122_nl & STAGE_LOOP_STAGE_LOOP_and_123_nl
      & STAGE_LOOP_STAGE_LOOP_and_124_nl & STAGE_LOOP_STAGE_LOOP_and_125_nl & STAGE_LOOP_STAGE_LOOP_and_126_nl
      & STAGE_LOOP_STAGE_LOOP_and_127_nl & STAGE_LOOP_STAGE_LOOP_and_128_nl & STAGE_LOOP_STAGE_LOOP_and_129_nl
      & STAGE_LOOP_STAGE_LOOP_and_130_nl & STAGE_LOOP_STAGE_LOOP_and_131_nl & STAGE_LOOP_STAGE_LOOP_and_132_nl
      & STAGE_LOOP_STAGE_LOOP_and_133_nl & STAGE_LOOP_STAGE_LOOP_and_134_nl & STAGE_LOOP_STAGE_LOOP_and_135_nl
      & STAGE_LOOP_STAGE_LOOP_and_136_nl & STAGE_LOOP_STAGE_LOOP_and_137_nl & STAGE_LOOP_STAGE_LOOP_and_138_nl
      & STAGE_LOOP_STAGE_LOOP_and_139_nl & STAGE_LOOP_STAGE_LOOP_and_140_nl & STAGE_LOOP_STAGE_LOOP_and_141_nl
      & STAGE_LOOP_STAGE_LOOP_and_142_nl & STAGE_LOOP_STAGE_LOOP_and_143_nl & STAGE_LOOP_STAGE_LOOP_and_144_nl
      & STAGE_LOOP_STAGE_LOOP_and_145_nl & STAGE_LOOP_STAGE_LOOP_and_146_nl & STAGE_LOOP_STAGE_LOOP_and_147_nl
      & STAGE_LOOP_STAGE_LOOP_and_148_nl & STAGE_LOOP_STAGE_LOOP_and_149_nl & STAGE_LOOP_STAGE_LOOP_and_150_nl
      & STAGE_LOOP_STAGE_LOOP_and_151_nl & STAGE_LOOP_STAGE_LOOP_and_152_nl & STAGE_LOOP_STAGE_LOOP_and_153_nl
      & STAGE_LOOP_and_4_nl & STAGE_LOOP_mux1h_7_nl & STAGE_LOOP_mux1h_8_nl) + UNSIGNED(STAGE_LOOP_STAGE_LOOP_and_154_nl
      & STAGE_LOOP_STAGE_LOOP_and_155_nl & STAGE_LOOP_STAGE_LOOP_and_156_nl & STAGE_LOOP_STAGE_LOOP_and_157_nl
      & STAGE_LOOP_STAGE_LOOP_and_158_nl & STAGE_LOOP_STAGE_LOOP_and_159_nl & STAGE_LOOP_STAGE_LOOP_and_160_nl
      & STAGE_LOOP_STAGE_LOOP_and_161_nl & STAGE_LOOP_STAGE_LOOP_and_162_nl & STAGE_LOOP_STAGE_LOOP_and_163_nl
      & STAGE_LOOP_STAGE_LOOP_and_164_nl & STAGE_LOOP_STAGE_LOOP_and_165_nl & STAGE_LOOP_STAGE_LOOP_and_166_nl
      & STAGE_LOOP_STAGE_LOOP_and_167_nl & STAGE_LOOP_STAGE_LOOP_and_168_nl & STAGE_LOOP_STAGE_LOOP_and_169_nl
      & STAGE_LOOP_STAGE_LOOP_and_170_nl & STAGE_LOOP_STAGE_LOOP_and_171_nl & STAGE_LOOP_STAGE_LOOP_and_172_nl
      & STAGE_LOOP_STAGE_LOOP_and_173_nl & STAGE_LOOP_STAGE_LOOP_and_174_nl & STAGE_LOOP_STAGE_LOOP_and_175_nl
      & STAGE_LOOP_STAGE_LOOP_and_176_nl & STAGE_LOOP_STAGE_LOOP_and_177_nl & STAGE_LOOP_STAGE_LOOP_and_178_nl
      & STAGE_LOOP_STAGE_LOOP_and_179_nl & STAGE_LOOP_STAGE_LOOP_and_180_nl & STAGE_LOOP_STAGE_LOOP_and_181_nl
      & STAGE_LOOP_STAGE_LOOP_and_182_nl & STAGE_LOOP_STAGE_LOOP_and_183_nl & STAGE_LOOP_STAGE_LOOP_and_184_nl
      & STAGE_LOOP_STAGE_LOOP_and_185_nl & STAGE_LOOP_STAGE_LOOP_and_186_nl & STAGE_LOOP_STAGE_LOOP_and_187_nl
      & STAGE_LOOP_STAGE_LOOP_and_188_nl & STAGE_LOOP_STAGE_LOOP_and_189_nl & STAGE_LOOP_STAGE_LOOP_and_190_nl
      & STAGE_LOOP_STAGE_LOOP_and_191_nl & STAGE_LOOP_STAGE_LOOP_and_192_nl & STAGE_LOOP_STAGE_LOOP_and_193_nl
      & STAGE_LOOP_STAGE_LOOP_and_194_nl & STAGE_LOOP_STAGE_LOOP_and_195_nl & STAGE_LOOP_STAGE_LOOP_and_196_nl
      & STAGE_LOOP_STAGE_LOOP_and_197_nl & STAGE_LOOP_STAGE_LOOP_and_198_nl & STAGE_LOOP_STAGE_LOOP_and_199_nl
      & STAGE_LOOP_STAGE_LOOP_and_200_nl & STAGE_LOOP_STAGE_LOOP_and_201_nl & STAGE_LOOP_STAGE_LOOP_and_202_nl
      & STAGE_LOOP_STAGE_LOOP_and_203_nl & STAGE_LOOP_STAGE_LOOP_and_204_nl & STAGE_LOOP_STAGE_LOOP_and_205_nl
      & STAGE_LOOP_and_5_nl & STAGE_LOOP_mux1h_10_nl), 64));
  and_533_nl <= nor_332_cse AND (fsm_output(2)) AND and_dcpl_288 AND (NOT (fsm_output(9)))
      AND (fsm_output(1)) AND (NOT (fsm_output(7))) AND (NOT (fsm_output(6))) AND
      (fsm_output(0));
  or_1078_nl <= (fsm_output(7)) OR mux_826_cse;
  nand_149_nl <= NOT((fsm_output(8)) AND (fsm_output(2)) AND (fsm_output(3)));
  mux_957_nl <= MUX_s_1_2_2(nand_149_nl, or_614_cse, fsm_output(1));
  mux_956_nl <= MUX_s_1_2_2(mux_tmp_824, mux_957_nl, fsm_output(7));
  mux_954_nl <= MUX_s_1_2_2(or_1078_nl, mux_956_nl, fsm_output(6));
  or_1080_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("10")) OR mux_tmp_824;
  mux_953_nl <= MUX_s_1_2_2(mux_954_nl, or_1080_nl, fsm_output(0));
  modExp_while_if_modExp_while_if_nand_1_nl <= NOT(mux_866_itm AND (mux_953_nl OR
      (fsm_output(4)) OR (NOT (fsm_output(5))) OR (fsm_output(9))));
  nor_461_nl <= NOT((fsm_output(7)) OR (fsm_output(0)) OR (fsm_output(6)) OR (fsm_output(8))
      OR (fsm_output(1)) OR (fsm_output(2)) OR (NOT (fsm_output(3))));
  nor_462_nl <= NOT(CONV_SL_1_1(fsm_output(3 DOWNTO 1)/=STD_LOGIC_VECTOR'("001")));
  nor_463_nl <= NOT(CONV_SL_1_1(fsm_output(3 DOWNTO 1)/=STD_LOGIC_VECTOR'("100")));
  mux_960_nl <= MUX_s_1_2_2(nor_462_nl, nor_463_nl, fsm_output(8));
  and_535_nl <= (fsm_output(0)) AND mux_960_nl;
  nor_464_nl <= NOT((fsm_output(6)) OR mux_tmp_866);
  and_536_nl <= (fsm_output(6)) AND (NOT mux_tmp_866);
  mux_961_nl <= MUX_s_1_2_2(nor_464_nl, and_536_nl, fsm_output(0));
  mux_959_nl <= MUX_s_1_2_2(and_535_nl, mux_961_nl, fsm_output(7));
  mux_958_nl <= MUX_s_1_2_2(nor_461_nl, mux_959_nl, fsm_output(5));
  and_534_nl <= mux_958_nl AND and_dcpl_109;
  modExp_while_if_mux1h_1_nl <= MUX1HOT_v_64_3_2(modExp_result_sva, operator_64_false_acc_mut_63_0,
      modExp_base_1_sva, STD_LOGIC_VECTOR'( and_533_nl & modExp_while_if_modExp_while_if_nand_1_nl
      & and_534_nl));
  modExp_while_if_modExp_while_if_nor_1_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR mux_866_itm);
  modExp_while_if_and_6_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1 DOWNTO
      0)=STD_LOGIC_VECTOR'("01")) AND (NOT mux_866_itm);
  modExp_while_if_and_7_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1 DOWNTO
      0)=STD_LOGIC_VECTOR'("10")) AND (NOT mux_866_itm);
  modExp_while_if_and_8_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(1 DOWNTO
      0)=STD_LOGIC_VECTOR'("11")) AND (NOT mux_866_itm);
  modExp_while_if_modExp_while_if_mux1h_1_nl <= MUX1HOT_v_64_5_2(modExp_base_1_sva,
      vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, vec_rsc_0_2_i_qa_d, vec_rsc_0_3_i_qa_d,
      STD_LOGIC_VECTOR'( mux_866_itm & modExp_while_if_modExp_while_if_nor_1_nl &
      modExp_while_if_and_6_nl & modExp_while_if_and_7_nl & modExp_while_if_and_8_nl));
  z_out_7 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(modExp_while_if_mux1h_1_nl)
      * UNSIGNED(modExp_while_if_modExp_while_if_mux1h_1_nl)), 64));
END v24;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_0_adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsc_0_0_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_wea : OUT STD_LOGIC;
    vec_rsc_0_0_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    vec_rsc_0_1_adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsc_0_1_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_wea : OUT STD_LOGIC;
    vec_rsc_0_1_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    vec_rsc_0_2_adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsc_0_2_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_2_wea : OUT STD_LOGIC;
    vec_rsc_0_2_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_2_lz : OUT STD_LOGIC;
    vec_rsc_0_3_adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsc_0_3_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_3_wea : OUT STD_LOGIC;
    vec_rsc_0_3_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_3_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC
  );
END inPlaceNTT_DIT;

ARCHITECTURE v24 OF inPlaceNTT_DIT IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_0_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_2_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_3_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_adra_d_iff : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da_d_iff : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_2_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_3_i_wea_d_iff : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_10_64_1024_1024_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_0_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_adra : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_adra_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_10_64_1024_1024_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_1_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_adra : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_adra_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_10_64_1024_1024_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_2_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_adra : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_adra_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_10_64_1024_1024_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_3_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_adra : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_adra_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_2_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_3_lz : OUT STD_LOGIC;
      p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      p_rsc_triosy_lz : OUT STD_LOGIC;
      r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      r_rsc_triosy_lz : OUT STD_LOGIC;
      vec_rsc_0_0_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_1_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_2_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_3_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_0_i_adra_d_pff : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      vec_rsc_0_0_i_da_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_1_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_2_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_3_i_wea_d_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_core_inst_p_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_core_inst_r_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_1_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_2_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_3_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff : STD_LOGIC_VECTOR (9
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff : STD_LOGIC_VECTOR (63 DOWNTO
      0);

BEGIN
  vec_rsc_0_0_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_10_64_1024_1024_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_0_i_qa,
      wea => vec_rsc_0_0_wea,
      da => vec_rsc_0_0_i_da,
      adra => vec_rsc_0_0_i_adra,
      adra_d => vec_rsc_0_0_i_adra_d,
      da_d => vec_rsc_0_0_i_da_d,
      qa_d => vec_rsc_0_0_i_qa_d_1,
      wea_d => vec_rsc_0_0_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_0_i_wea_d_iff
    );
  vec_rsc_0_0_i_qa <= vec_rsc_0_0_qa;
  vec_rsc_0_0_da <= vec_rsc_0_0_i_da;
  vec_rsc_0_0_adra <= vec_rsc_0_0_i_adra;
  vec_rsc_0_0_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_0_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_0_i_qa_d <= vec_rsc_0_0_i_qa_d_1;

  vec_rsc_0_1_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_10_64_1024_1024_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_1_i_qa,
      wea => vec_rsc_0_1_wea,
      da => vec_rsc_0_1_i_da,
      adra => vec_rsc_0_1_i_adra,
      adra_d => vec_rsc_0_1_i_adra_d,
      da_d => vec_rsc_0_1_i_da_d,
      qa_d => vec_rsc_0_1_i_qa_d_1,
      wea_d => vec_rsc_0_1_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_1_i_wea_d_iff
    );
  vec_rsc_0_1_i_qa <= vec_rsc_0_1_qa;
  vec_rsc_0_1_da <= vec_rsc_0_1_i_da;
  vec_rsc_0_1_adra <= vec_rsc_0_1_i_adra;
  vec_rsc_0_1_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_1_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_1_i_qa_d <= vec_rsc_0_1_i_qa_d_1;

  vec_rsc_0_2_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_10_64_1024_1024_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_2_i_qa,
      wea => vec_rsc_0_2_wea,
      da => vec_rsc_0_2_i_da,
      adra => vec_rsc_0_2_i_adra,
      adra_d => vec_rsc_0_2_i_adra_d,
      da_d => vec_rsc_0_2_i_da_d,
      qa_d => vec_rsc_0_2_i_qa_d_1,
      wea_d => vec_rsc_0_2_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_2_i_wea_d_iff
    );
  vec_rsc_0_2_i_qa <= vec_rsc_0_2_qa;
  vec_rsc_0_2_da <= vec_rsc_0_2_i_da;
  vec_rsc_0_2_adra <= vec_rsc_0_2_i_adra;
  vec_rsc_0_2_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_2_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_2_i_qa_d <= vec_rsc_0_2_i_qa_d_1;

  vec_rsc_0_3_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_10_64_1024_1024_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_3_i_qa,
      wea => vec_rsc_0_3_wea,
      da => vec_rsc_0_3_i_da,
      adra => vec_rsc_0_3_i_adra,
      adra_d => vec_rsc_0_3_i_adra_d,
      da_d => vec_rsc_0_3_i_da_d,
      qa_d => vec_rsc_0_3_i_qa_d_1,
      wea_d => vec_rsc_0_3_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_3_i_wea_d_iff
    );
  vec_rsc_0_3_i_qa <= vec_rsc_0_3_qa;
  vec_rsc_0_3_da <= vec_rsc_0_3_i_da;
  vec_rsc_0_3_adra <= vec_rsc_0_3_i_adra;
  vec_rsc_0_3_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_3_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_3_i_qa_d <= vec_rsc_0_3_i_qa_d_1;

  inPlaceNTT_DIT_core_inst : inPlaceNTT_DIT_core
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_triosy_0_0_lz => vec_rsc_triosy_0_0_lz,
      vec_rsc_triosy_0_1_lz => vec_rsc_triosy_0_1_lz,
      vec_rsc_triosy_0_2_lz => vec_rsc_triosy_0_2_lz,
      vec_rsc_triosy_0_3_lz => vec_rsc_triosy_0_3_lz,
      p_rsc_dat => inPlaceNTT_DIT_core_inst_p_rsc_dat,
      p_rsc_triosy_lz => p_rsc_triosy_lz,
      r_rsc_dat => inPlaceNTT_DIT_core_inst_r_rsc_dat,
      r_rsc_triosy_lz => r_rsc_triosy_lz,
      vec_rsc_0_0_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_qa_d,
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_1_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_1_i_qa_d,
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_2_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_2_i_qa_d,
      vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_3_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_3_i_qa_d,
      vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_0_i_adra_d_pff => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff,
      vec_rsc_0_0_i_da_d_pff => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff,
      vec_rsc_0_0_i_wea_d_pff => vec_rsc_0_0_i_wea_d_iff,
      vec_rsc_0_1_i_wea_d_pff => vec_rsc_0_1_i_wea_d_iff,
      vec_rsc_0_2_i_wea_d_pff => vec_rsc_0_2_i_wea_d_iff,
      vec_rsc_0_3_i_wea_d_pff => vec_rsc_0_3_i_wea_d_iff
    );
  inPlaceNTT_DIT_core_inst_p_rsc_dat <= p_rsc_dat;
  inPlaceNTT_DIT_core_inst_r_rsc_dat <= r_rsc_dat;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_qa_d <= vec_rsc_0_0_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_1_i_qa_d <= vec_rsc_0_1_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_2_i_qa_d <= vec_rsc_0_2_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_3_i_qa_d <= vec_rsc_0_3_i_qa_d;
  vec_rsc_0_0_i_adra_d_iff <= inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff;
  vec_rsc_0_0_i_da_d_iff <= inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff;

END v24;



