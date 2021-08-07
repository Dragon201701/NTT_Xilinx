
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
--  Generated date: Wed Jun 30 21:02:14 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen;

ARCHITECTURE v34 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v34;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen;

ARCHITECTURE v34 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v34;

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
    fsm_output : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    STAGE_LOOP_C_9_tr0 : IN STD_LOGIC;
    modExp_while_C_42_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
    COMP_LOOP_1_modExp_1_while_C_42_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_68_tr0 : IN STD_LOGIC;
    COMP_LOOP_2_modExp_1_while_C_42_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_136_tr0 : IN STD_LOGIC;
    VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
    STAGE_LOOP_C_10_tr0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_core_core_fsm;

ARCHITECTURE v34 OF inPlaceNTT_DIT_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for inPlaceNTT_DIT_core_core_fsm_1
  TYPE inPlaceNTT_DIT_core_core_fsm_1_ST IS (main_C_0, STAGE_LOOP_C_0, STAGE_LOOP_C_1,
      STAGE_LOOP_C_2, STAGE_LOOP_C_3, STAGE_LOOP_C_4, STAGE_LOOP_C_5, STAGE_LOOP_C_6,
      STAGE_LOOP_C_7, STAGE_LOOP_C_8, STAGE_LOOP_C_9, modExp_while_C_0, modExp_while_C_1,
      modExp_while_C_2, modExp_while_C_3, modExp_while_C_4, modExp_while_C_5, modExp_while_C_6,
      modExp_while_C_7, modExp_while_C_8, modExp_while_C_9, modExp_while_C_10, modExp_while_C_11,
      modExp_while_C_12, modExp_while_C_13, modExp_while_C_14, modExp_while_C_15,
      modExp_while_C_16, modExp_while_C_17, modExp_while_C_18, modExp_while_C_19,
      modExp_while_C_20, modExp_while_C_21, modExp_while_C_22, modExp_while_C_23,
      modExp_while_C_24, modExp_while_C_25, modExp_while_C_26, modExp_while_C_27,
      modExp_while_C_28, modExp_while_C_29, modExp_while_C_30, modExp_while_C_31,
      modExp_while_C_32, modExp_while_C_33, modExp_while_C_34, modExp_while_C_35,
      modExp_while_C_36, modExp_while_C_37, modExp_while_C_38, modExp_while_C_39,
      modExp_while_C_40, modExp_while_C_41, modExp_while_C_42, COMP_LOOP_C_0, COMP_LOOP_C_1,
      COMP_LOOP_1_modExp_1_while_C_0, COMP_LOOP_1_modExp_1_while_C_1, COMP_LOOP_1_modExp_1_while_C_2,
      COMP_LOOP_1_modExp_1_while_C_3, COMP_LOOP_1_modExp_1_while_C_4, COMP_LOOP_1_modExp_1_while_C_5,
      COMP_LOOP_1_modExp_1_while_C_6, COMP_LOOP_1_modExp_1_while_C_7, COMP_LOOP_1_modExp_1_while_C_8,
      COMP_LOOP_1_modExp_1_while_C_9, COMP_LOOP_1_modExp_1_while_C_10, COMP_LOOP_1_modExp_1_while_C_11,
      COMP_LOOP_1_modExp_1_while_C_12, COMP_LOOP_1_modExp_1_while_C_13, COMP_LOOP_1_modExp_1_while_C_14,
      COMP_LOOP_1_modExp_1_while_C_15, COMP_LOOP_1_modExp_1_while_C_16, COMP_LOOP_1_modExp_1_while_C_17,
      COMP_LOOP_1_modExp_1_while_C_18, COMP_LOOP_1_modExp_1_while_C_19, COMP_LOOP_1_modExp_1_while_C_20,
      COMP_LOOP_1_modExp_1_while_C_21, COMP_LOOP_1_modExp_1_while_C_22, COMP_LOOP_1_modExp_1_while_C_23,
      COMP_LOOP_1_modExp_1_while_C_24, COMP_LOOP_1_modExp_1_while_C_25, COMP_LOOP_1_modExp_1_while_C_26,
      COMP_LOOP_1_modExp_1_while_C_27, COMP_LOOP_1_modExp_1_while_C_28, COMP_LOOP_1_modExp_1_while_C_29,
      COMP_LOOP_1_modExp_1_while_C_30, COMP_LOOP_1_modExp_1_while_C_31, COMP_LOOP_1_modExp_1_while_C_32,
      COMP_LOOP_1_modExp_1_while_C_33, COMP_LOOP_1_modExp_1_while_C_34, COMP_LOOP_1_modExp_1_while_C_35,
      COMP_LOOP_1_modExp_1_while_C_36, COMP_LOOP_1_modExp_1_while_C_37, COMP_LOOP_1_modExp_1_while_C_38,
      COMP_LOOP_1_modExp_1_while_C_39, COMP_LOOP_1_modExp_1_while_C_40, COMP_LOOP_1_modExp_1_while_C_41,
      COMP_LOOP_1_modExp_1_while_C_42, COMP_LOOP_C_2, COMP_LOOP_C_3, COMP_LOOP_C_4,
      COMP_LOOP_C_5, COMP_LOOP_C_6, COMP_LOOP_C_7, COMP_LOOP_C_8, COMP_LOOP_C_9,
      COMP_LOOP_C_10, COMP_LOOP_C_11, COMP_LOOP_C_12, COMP_LOOP_C_13, COMP_LOOP_C_14,
      COMP_LOOP_C_15, COMP_LOOP_C_16, COMP_LOOP_C_17, COMP_LOOP_C_18, COMP_LOOP_C_19,
      COMP_LOOP_C_20, COMP_LOOP_C_21, COMP_LOOP_C_22, COMP_LOOP_C_23, COMP_LOOP_C_24,
      COMP_LOOP_C_25, COMP_LOOP_C_26, COMP_LOOP_C_27, COMP_LOOP_C_28, COMP_LOOP_C_29,
      COMP_LOOP_C_30, COMP_LOOP_C_31, COMP_LOOP_C_32, COMP_LOOP_C_33, COMP_LOOP_C_34,
      COMP_LOOP_C_35, COMP_LOOP_C_36, COMP_LOOP_C_37, COMP_LOOP_C_38, COMP_LOOP_C_39,
      COMP_LOOP_C_40, COMP_LOOP_C_41, COMP_LOOP_C_42, COMP_LOOP_C_43, COMP_LOOP_C_44,
      COMP_LOOP_C_45, COMP_LOOP_C_46, COMP_LOOP_C_47, COMP_LOOP_C_48, COMP_LOOP_C_49,
      COMP_LOOP_C_50, COMP_LOOP_C_51, COMP_LOOP_C_52, COMP_LOOP_C_53, COMP_LOOP_C_54,
      COMP_LOOP_C_55, COMP_LOOP_C_56, COMP_LOOP_C_57, COMP_LOOP_C_58, COMP_LOOP_C_59,
      COMP_LOOP_C_60, COMP_LOOP_C_61, COMP_LOOP_C_62, COMP_LOOP_C_63, COMP_LOOP_C_64,
      COMP_LOOP_C_65, COMP_LOOP_C_66, COMP_LOOP_C_67, COMP_LOOP_C_68, COMP_LOOP_C_69,
      COMP_LOOP_2_modExp_1_while_C_0, COMP_LOOP_2_modExp_1_while_C_1, COMP_LOOP_2_modExp_1_while_C_2,
      COMP_LOOP_2_modExp_1_while_C_3, COMP_LOOP_2_modExp_1_while_C_4, COMP_LOOP_2_modExp_1_while_C_5,
      COMP_LOOP_2_modExp_1_while_C_6, COMP_LOOP_2_modExp_1_while_C_7, COMP_LOOP_2_modExp_1_while_C_8,
      COMP_LOOP_2_modExp_1_while_C_9, COMP_LOOP_2_modExp_1_while_C_10, COMP_LOOP_2_modExp_1_while_C_11,
      COMP_LOOP_2_modExp_1_while_C_12, COMP_LOOP_2_modExp_1_while_C_13, COMP_LOOP_2_modExp_1_while_C_14,
      COMP_LOOP_2_modExp_1_while_C_15, COMP_LOOP_2_modExp_1_while_C_16, COMP_LOOP_2_modExp_1_while_C_17,
      COMP_LOOP_2_modExp_1_while_C_18, COMP_LOOP_2_modExp_1_while_C_19, COMP_LOOP_2_modExp_1_while_C_20,
      COMP_LOOP_2_modExp_1_while_C_21, COMP_LOOP_2_modExp_1_while_C_22, COMP_LOOP_2_modExp_1_while_C_23,
      COMP_LOOP_2_modExp_1_while_C_24, COMP_LOOP_2_modExp_1_while_C_25, COMP_LOOP_2_modExp_1_while_C_26,
      COMP_LOOP_2_modExp_1_while_C_27, COMP_LOOP_2_modExp_1_while_C_28, COMP_LOOP_2_modExp_1_while_C_29,
      COMP_LOOP_2_modExp_1_while_C_30, COMP_LOOP_2_modExp_1_while_C_31, COMP_LOOP_2_modExp_1_while_C_32,
      COMP_LOOP_2_modExp_1_while_C_33, COMP_LOOP_2_modExp_1_while_C_34, COMP_LOOP_2_modExp_1_while_C_35,
      COMP_LOOP_2_modExp_1_while_C_36, COMP_LOOP_2_modExp_1_while_C_37, COMP_LOOP_2_modExp_1_while_C_38,
      COMP_LOOP_2_modExp_1_while_C_39, COMP_LOOP_2_modExp_1_while_C_40, COMP_LOOP_2_modExp_1_while_C_41,
      COMP_LOOP_2_modExp_1_while_C_42, COMP_LOOP_C_70, COMP_LOOP_C_71, COMP_LOOP_C_72,
      COMP_LOOP_C_73, COMP_LOOP_C_74, COMP_LOOP_C_75, COMP_LOOP_C_76, COMP_LOOP_C_77,
      COMP_LOOP_C_78, COMP_LOOP_C_79, COMP_LOOP_C_80, COMP_LOOP_C_81, COMP_LOOP_C_82,
      COMP_LOOP_C_83, COMP_LOOP_C_84, COMP_LOOP_C_85, COMP_LOOP_C_86, COMP_LOOP_C_87,
      COMP_LOOP_C_88, COMP_LOOP_C_89, COMP_LOOP_C_90, COMP_LOOP_C_91, COMP_LOOP_C_92,
      COMP_LOOP_C_93, COMP_LOOP_C_94, COMP_LOOP_C_95, COMP_LOOP_C_96, COMP_LOOP_C_97,
      COMP_LOOP_C_98, COMP_LOOP_C_99, COMP_LOOP_C_100, COMP_LOOP_C_101, COMP_LOOP_C_102,
      COMP_LOOP_C_103, COMP_LOOP_C_104, COMP_LOOP_C_105, COMP_LOOP_C_106, COMP_LOOP_C_107,
      COMP_LOOP_C_108, COMP_LOOP_C_109, COMP_LOOP_C_110, COMP_LOOP_C_111, COMP_LOOP_C_112,
      COMP_LOOP_C_113, COMP_LOOP_C_114, COMP_LOOP_C_115, COMP_LOOP_C_116, COMP_LOOP_C_117,
      COMP_LOOP_C_118, COMP_LOOP_C_119, COMP_LOOP_C_120, COMP_LOOP_C_121, COMP_LOOP_C_122,
      COMP_LOOP_C_123, COMP_LOOP_C_124, COMP_LOOP_C_125, COMP_LOOP_C_126, COMP_LOOP_C_127,
      COMP_LOOP_C_128, COMP_LOOP_C_129, COMP_LOOP_C_130, COMP_LOOP_C_131, COMP_LOOP_C_132,
      COMP_LOOP_C_133, COMP_LOOP_C_134, COMP_LOOP_C_135, COMP_LOOP_C_136, VEC_LOOP_C_0,
      STAGE_LOOP_C_10, main_C_1);

  SIGNAL state_var : inPlaceNTT_DIT_core_core_fsm_1_ST;
  SIGNAL state_var_NS : inPlaceNTT_DIT_core_core_fsm_1_ST;

BEGIN
  inPlaceNTT_DIT_core_core_fsm_1 : PROCESS (STAGE_LOOP_C_9_tr0, modExp_while_C_42_tr0,
      COMP_LOOP_C_1_tr0, COMP_LOOP_1_modExp_1_while_C_42_tr0, COMP_LOOP_C_68_tr0,
      COMP_LOOP_2_modExp_1_while_C_42_tr0, COMP_LOOP_C_136_tr0, VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_10_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN STAGE_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000001");
        state_var_NS <= STAGE_LOOP_C_1;
      WHEN STAGE_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000010");
        state_var_NS <= STAGE_LOOP_C_2;
      WHEN STAGE_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000011");
        state_var_NS <= STAGE_LOOP_C_3;
      WHEN STAGE_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000100");
        state_var_NS <= STAGE_LOOP_C_4;
      WHEN STAGE_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000101");
        state_var_NS <= STAGE_LOOP_C_5;
      WHEN STAGE_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000110");
        state_var_NS <= STAGE_LOOP_C_6;
      WHEN STAGE_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000111");
        state_var_NS <= STAGE_LOOP_C_7;
      WHEN STAGE_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001000");
        state_var_NS <= STAGE_LOOP_C_8;
      WHEN STAGE_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001001");
        state_var_NS <= STAGE_LOOP_C_9;
      WHEN STAGE_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001010");
        IF ( STAGE_LOOP_C_9_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_0;
        ELSE
          state_var_NS <= modExp_while_C_0;
        END IF;
      WHEN modExp_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001011");
        state_var_NS <= modExp_while_C_1;
      WHEN modExp_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001100");
        state_var_NS <= modExp_while_C_2;
      WHEN modExp_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001101");
        state_var_NS <= modExp_while_C_3;
      WHEN modExp_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001110");
        state_var_NS <= modExp_while_C_4;
      WHEN modExp_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001111");
        state_var_NS <= modExp_while_C_5;
      WHEN modExp_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010000");
        state_var_NS <= modExp_while_C_6;
      WHEN modExp_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010001");
        state_var_NS <= modExp_while_C_7;
      WHEN modExp_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010010");
        state_var_NS <= modExp_while_C_8;
      WHEN modExp_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010011");
        state_var_NS <= modExp_while_C_9;
      WHEN modExp_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010100");
        state_var_NS <= modExp_while_C_10;
      WHEN modExp_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010101");
        state_var_NS <= modExp_while_C_11;
      WHEN modExp_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010110");
        state_var_NS <= modExp_while_C_12;
      WHEN modExp_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010111");
        state_var_NS <= modExp_while_C_13;
      WHEN modExp_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011000");
        state_var_NS <= modExp_while_C_14;
      WHEN modExp_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011001");
        state_var_NS <= modExp_while_C_15;
      WHEN modExp_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011010");
        state_var_NS <= modExp_while_C_16;
      WHEN modExp_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011011");
        state_var_NS <= modExp_while_C_17;
      WHEN modExp_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011100");
        state_var_NS <= modExp_while_C_18;
      WHEN modExp_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011101");
        state_var_NS <= modExp_while_C_19;
      WHEN modExp_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011110");
        state_var_NS <= modExp_while_C_20;
      WHEN modExp_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011111");
        state_var_NS <= modExp_while_C_21;
      WHEN modExp_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100000");
        state_var_NS <= modExp_while_C_22;
      WHEN modExp_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100001");
        state_var_NS <= modExp_while_C_23;
      WHEN modExp_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100010");
        state_var_NS <= modExp_while_C_24;
      WHEN modExp_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100011");
        state_var_NS <= modExp_while_C_25;
      WHEN modExp_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100100");
        state_var_NS <= modExp_while_C_26;
      WHEN modExp_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100101");
        state_var_NS <= modExp_while_C_27;
      WHEN modExp_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100110");
        state_var_NS <= modExp_while_C_28;
      WHEN modExp_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100111");
        state_var_NS <= modExp_while_C_29;
      WHEN modExp_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101000");
        state_var_NS <= modExp_while_C_30;
      WHEN modExp_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101001");
        state_var_NS <= modExp_while_C_31;
      WHEN modExp_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101010");
        state_var_NS <= modExp_while_C_32;
      WHEN modExp_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101011");
        state_var_NS <= modExp_while_C_33;
      WHEN modExp_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101100");
        state_var_NS <= modExp_while_C_34;
      WHEN modExp_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101101");
        state_var_NS <= modExp_while_C_35;
      WHEN modExp_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101110");
        state_var_NS <= modExp_while_C_36;
      WHEN modExp_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101111");
        state_var_NS <= modExp_while_C_37;
      WHEN modExp_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110000");
        state_var_NS <= modExp_while_C_38;
      WHEN modExp_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110001");
        state_var_NS <= modExp_while_C_39;
      WHEN modExp_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110010");
        state_var_NS <= modExp_while_C_40;
      WHEN modExp_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110011");
        state_var_NS <= modExp_while_C_41;
      WHEN modExp_while_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110100");
        state_var_NS <= modExp_while_C_42;
      WHEN modExp_while_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110101");
        IF ( modExp_while_C_42_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_0;
        ELSE
          state_var_NS <= modExp_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110110");
        state_var_NS <= COMP_LOOP_C_1;
      WHEN COMP_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110111");
        IF ( COMP_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_2;
        ELSE
          state_var_NS <= COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_1_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_1;
      WHEN COMP_LOOP_1_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_2;
      WHEN COMP_LOOP_1_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_3;
      WHEN COMP_LOOP_1_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_4;
      WHEN COMP_LOOP_1_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_5;
      WHEN COMP_LOOP_1_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_6;
      WHEN COMP_LOOP_1_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_7;
      WHEN COMP_LOOP_1_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_8;
      WHEN COMP_LOOP_1_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_9;
      WHEN COMP_LOOP_1_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_10;
      WHEN COMP_LOOP_1_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_11;
      WHEN COMP_LOOP_1_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_12;
      WHEN COMP_LOOP_1_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_13;
      WHEN COMP_LOOP_1_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_14;
      WHEN COMP_LOOP_1_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_15;
      WHEN COMP_LOOP_1_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_16;
      WHEN COMP_LOOP_1_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_17;
      WHEN COMP_LOOP_1_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_18;
      WHEN COMP_LOOP_1_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_19;
      WHEN COMP_LOOP_1_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_20;
      WHEN COMP_LOOP_1_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_21;
      WHEN COMP_LOOP_1_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_22;
      WHEN COMP_LOOP_1_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_23;
      WHEN COMP_LOOP_1_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_24;
      WHEN COMP_LOOP_1_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_25;
      WHEN COMP_LOOP_1_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_26;
      WHEN COMP_LOOP_1_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_27;
      WHEN COMP_LOOP_1_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_28;
      WHEN COMP_LOOP_1_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_29;
      WHEN COMP_LOOP_1_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_30;
      WHEN COMP_LOOP_1_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_31;
      WHEN COMP_LOOP_1_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_32;
      WHEN COMP_LOOP_1_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_33;
      WHEN COMP_LOOP_1_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_34;
      WHEN COMP_LOOP_1_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_35;
      WHEN COMP_LOOP_1_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_36;
      WHEN COMP_LOOP_1_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_37;
      WHEN COMP_LOOP_1_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_38;
      WHEN COMP_LOOP_1_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_39;
      WHEN COMP_LOOP_1_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_40;
      WHEN COMP_LOOP_1_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_41;
      WHEN COMP_LOOP_1_modExp_1_while_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_42;
      WHEN COMP_LOOP_1_modExp_1_while_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100010");
        IF ( COMP_LOOP_1_modExp_1_while_C_42_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_2;
        ELSE
          state_var_NS <= COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100011");
        state_var_NS <= COMP_LOOP_C_3;
      WHEN COMP_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100100");
        state_var_NS <= COMP_LOOP_C_4;
      WHEN COMP_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100101");
        state_var_NS <= COMP_LOOP_C_5;
      WHEN COMP_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100110");
        state_var_NS <= COMP_LOOP_C_6;
      WHEN COMP_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100111");
        state_var_NS <= COMP_LOOP_C_7;
      WHEN COMP_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101000");
        state_var_NS <= COMP_LOOP_C_8;
      WHEN COMP_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101001");
        state_var_NS <= COMP_LOOP_C_9;
      WHEN COMP_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101010");
        state_var_NS <= COMP_LOOP_C_10;
      WHEN COMP_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101011");
        state_var_NS <= COMP_LOOP_C_11;
      WHEN COMP_LOOP_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101100");
        state_var_NS <= COMP_LOOP_C_12;
      WHEN COMP_LOOP_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101101");
        state_var_NS <= COMP_LOOP_C_13;
      WHEN COMP_LOOP_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101110");
        state_var_NS <= COMP_LOOP_C_14;
      WHEN COMP_LOOP_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101111");
        state_var_NS <= COMP_LOOP_C_15;
      WHEN COMP_LOOP_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110000");
        state_var_NS <= COMP_LOOP_C_16;
      WHEN COMP_LOOP_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110001");
        state_var_NS <= COMP_LOOP_C_17;
      WHEN COMP_LOOP_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110010");
        state_var_NS <= COMP_LOOP_C_18;
      WHEN COMP_LOOP_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110011");
        state_var_NS <= COMP_LOOP_C_19;
      WHEN COMP_LOOP_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110100");
        state_var_NS <= COMP_LOOP_C_20;
      WHEN COMP_LOOP_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110101");
        state_var_NS <= COMP_LOOP_C_21;
      WHEN COMP_LOOP_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110110");
        state_var_NS <= COMP_LOOP_C_22;
      WHEN COMP_LOOP_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110111");
        state_var_NS <= COMP_LOOP_C_23;
      WHEN COMP_LOOP_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111000");
        state_var_NS <= COMP_LOOP_C_24;
      WHEN COMP_LOOP_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111001");
        state_var_NS <= COMP_LOOP_C_25;
      WHEN COMP_LOOP_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111010");
        state_var_NS <= COMP_LOOP_C_26;
      WHEN COMP_LOOP_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111011");
        state_var_NS <= COMP_LOOP_C_27;
      WHEN COMP_LOOP_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111100");
        state_var_NS <= COMP_LOOP_C_28;
      WHEN COMP_LOOP_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111101");
        state_var_NS <= COMP_LOOP_C_29;
      WHEN COMP_LOOP_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111110");
        state_var_NS <= COMP_LOOP_C_30;
      WHEN COMP_LOOP_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111111");
        state_var_NS <= COMP_LOOP_C_31;
      WHEN COMP_LOOP_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000000");
        state_var_NS <= COMP_LOOP_C_32;
      WHEN COMP_LOOP_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000001");
        state_var_NS <= COMP_LOOP_C_33;
      WHEN COMP_LOOP_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000010");
        state_var_NS <= COMP_LOOP_C_34;
      WHEN COMP_LOOP_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000011");
        state_var_NS <= COMP_LOOP_C_35;
      WHEN COMP_LOOP_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000100");
        state_var_NS <= COMP_LOOP_C_36;
      WHEN COMP_LOOP_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000101");
        state_var_NS <= COMP_LOOP_C_37;
      WHEN COMP_LOOP_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000110");
        state_var_NS <= COMP_LOOP_C_38;
      WHEN COMP_LOOP_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000111");
        state_var_NS <= COMP_LOOP_C_39;
      WHEN COMP_LOOP_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001000");
        state_var_NS <= COMP_LOOP_C_40;
      WHEN COMP_LOOP_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001001");
        state_var_NS <= COMP_LOOP_C_41;
      WHEN COMP_LOOP_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001010");
        state_var_NS <= COMP_LOOP_C_42;
      WHEN COMP_LOOP_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001011");
        state_var_NS <= COMP_LOOP_C_43;
      WHEN COMP_LOOP_C_43 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001100");
        state_var_NS <= COMP_LOOP_C_44;
      WHEN COMP_LOOP_C_44 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001101");
        state_var_NS <= COMP_LOOP_C_45;
      WHEN COMP_LOOP_C_45 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001110");
        state_var_NS <= COMP_LOOP_C_46;
      WHEN COMP_LOOP_C_46 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001111");
        state_var_NS <= COMP_LOOP_C_47;
      WHEN COMP_LOOP_C_47 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010000");
        state_var_NS <= COMP_LOOP_C_48;
      WHEN COMP_LOOP_C_48 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010001");
        state_var_NS <= COMP_LOOP_C_49;
      WHEN COMP_LOOP_C_49 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010010");
        state_var_NS <= COMP_LOOP_C_50;
      WHEN COMP_LOOP_C_50 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010011");
        state_var_NS <= COMP_LOOP_C_51;
      WHEN COMP_LOOP_C_51 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010100");
        state_var_NS <= COMP_LOOP_C_52;
      WHEN COMP_LOOP_C_52 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010101");
        state_var_NS <= COMP_LOOP_C_53;
      WHEN COMP_LOOP_C_53 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010110");
        state_var_NS <= COMP_LOOP_C_54;
      WHEN COMP_LOOP_C_54 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010111");
        state_var_NS <= COMP_LOOP_C_55;
      WHEN COMP_LOOP_C_55 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011000");
        state_var_NS <= COMP_LOOP_C_56;
      WHEN COMP_LOOP_C_56 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011001");
        state_var_NS <= COMP_LOOP_C_57;
      WHEN COMP_LOOP_C_57 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011010");
        state_var_NS <= COMP_LOOP_C_58;
      WHEN COMP_LOOP_C_58 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011011");
        state_var_NS <= COMP_LOOP_C_59;
      WHEN COMP_LOOP_C_59 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011100");
        state_var_NS <= COMP_LOOP_C_60;
      WHEN COMP_LOOP_C_60 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011101");
        state_var_NS <= COMP_LOOP_C_61;
      WHEN COMP_LOOP_C_61 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011110");
        state_var_NS <= COMP_LOOP_C_62;
      WHEN COMP_LOOP_C_62 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011111");
        state_var_NS <= COMP_LOOP_C_63;
      WHEN COMP_LOOP_C_63 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100000");
        state_var_NS <= COMP_LOOP_C_64;
      WHEN COMP_LOOP_C_64 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100001");
        state_var_NS <= COMP_LOOP_C_65;
      WHEN COMP_LOOP_C_65 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100010");
        state_var_NS <= COMP_LOOP_C_66;
      WHEN COMP_LOOP_C_66 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100011");
        state_var_NS <= COMP_LOOP_C_67;
      WHEN COMP_LOOP_C_67 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100100");
        state_var_NS <= COMP_LOOP_C_68;
      WHEN COMP_LOOP_C_68 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100101");
        IF ( COMP_LOOP_C_68_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_69;
        END IF;
      WHEN COMP_LOOP_C_69 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_0;
      WHEN COMP_LOOP_2_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_1;
      WHEN COMP_LOOP_2_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_2;
      WHEN COMP_LOOP_2_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_3;
      WHEN COMP_LOOP_2_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_4;
      WHEN COMP_LOOP_2_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_5;
      WHEN COMP_LOOP_2_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_6;
      WHEN COMP_LOOP_2_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_7;
      WHEN COMP_LOOP_2_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_8;
      WHEN COMP_LOOP_2_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_9;
      WHEN COMP_LOOP_2_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_10;
      WHEN COMP_LOOP_2_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_11;
      WHEN COMP_LOOP_2_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_12;
      WHEN COMP_LOOP_2_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_13;
      WHEN COMP_LOOP_2_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_14;
      WHEN COMP_LOOP_2_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_15;
      WHEN COMP_LOOP_2_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_16;
      WHEN COMP_LOOP_2_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_17;
      WHEN COMP_LOOP_2_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_18;
      WHEN COMP_LOOP_2_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_19;
      WHEN COMP_LOOP_2_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_20;
      WHEN COMP_LOOP_2_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_21;
      WHEN COMP_LOOP_2_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_22;
      WHEN COMP_LOOP_2_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_23;
      WHEN COMP_LOOP_2_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_24;
      WHEN COMP_LOOP_2_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_25;
      WHEN COMP_LOOP_2_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_26;
      WHEN COMP_LOOP_2_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_27;
      WHEN COMP_LOOP_2_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_28;
      WHEN COMP_LOOP_2_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_29;
      WHEN COMP_LOOP_2_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_30;
      WHEN COMP_LOOP_2_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_31;
      WHEN COMP_LOOP_2_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_32;
      WHEN COMP_LOOP_2_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_33;
      WHEN COMP_LOOP_2_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_34;
      WHEN COMP_LOOP_2_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_35;
      WHEN COMP_LOOP_2_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_36;
      WHEN COMP_LOOP_2_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_37;
      WHEN COMP_LOOP_2_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_38;
      WHEN COMP_LOOP_2_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_39;
      WHEN COMP_LOOP_2_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_40;
      WHEN COMP_LOOP_2_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_41;
      WHEN COMP_LOOP_2_modExp_1_while_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_42;
      WHEN COMP_LOOP_2_modExp_1_while_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010001");
        IF ( COMP_LOOP_2_modExp_1_while_C_42_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_70;
        ELSE
          state_var_NS <= COMP_LOOP_2_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_70 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010010");
        state_var_NS <= COMP_LOOP_C_71;
      WHEN COMP_LOOP_C_71 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010011");
        state_var_NS <= COMP_LOOP_C_72;
      WHEN COMP_LOOP_C_72 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010100");
        state_var_NS <= COMP_LOOP_C_73;
      WHEN COMP_LOOP_C_73 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010101");
        state_var_NS <= COMP_LOOP_C_74;
      WHEN COMP_LOOP_C_74 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010110");
        state_var_NS <= COMP_LOOP_C_75;
      WHEN COMP_LOOP_C_75 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010111");
        state_var_NS <= COMP_LOOP_C_76;
      WHEN COMP_LOOP_C_76 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011000");
        state_var_NS <= COMP_LOOP_C_77;
      WHEN COMP_LOOP_C_77 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011001");
        state_var_NS <= COMP_LOOP_C_78;
      WHEN COMP_LOOP_C_78 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011010");
        state_var_NS <= COMP_LOOP_C_79;
      WHEN COMP_LOOP_C_79 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011011");
        state_var_NS <= COMP_LOOP_C_80;
      WHEN COMP_LOOP_C_80 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011100");
        state_var_NS <= COMP_LOOP_C_81;
      WHEN COMP_LOOP_C_81 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011101");
        state_var_NS <= COMP_LOOP_C_82;
      WHEN COMP_LOOP_C_82 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011110");
        state_var_NS <= COMP_LOOP_C_83;
      WHEN COMP_LOOP_C_83 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011111");
        state_var_NS <= COMP_LOOP_C_84;
      WHEN COMP_LOOP_C_84 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100000");
        state_var_NS <= COMP_LOOP_C_85;
      WHEN COMP_LOOP_C_85 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100001");
        state_var_NS <= COMP_LOOP_C_86;
      WHEN COMP_LOOP_C_86 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100010");
        state_var_NS <= COMP_LOOP_C_87;
      WHEN COMP_LOOP_C_87 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100011");
        state_var_NS <= COMP_LOOP_C_88;
      WHEN COMP_LOOP_C_88 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100100");
        state_var_NS <= COMP_LOOP_C_89;
      WHEN COMP_LOOP_C_89 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100101");
        state_var_NS <= COMP_LOOP_C_90;
      WHEN COMP_LOOP_C_90 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100110");
        state_var_NS <= COMP_LOOP_C_91;
      WHEN COMP_LOOP_C_91 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100111");
        state_var_NS <= COMP_LOOP_C_92;
      WHEN COMP_LOOP_C_92 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101000");
        state_var_NS <= COMP_LOOP_C_93;
      WHEN COMP_LOOP_C_93 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101001");
        state_var_NS <= COMP_LOOP_C_94;
      WHEN COMP_LOOP_C_94 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101010");
        state_var_NS <= COMP_LOOP_C_95;
      WHEN COMP_LOOP_C_95 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101011");
        state_var_NS <= COMP_LOOP_C_96;
      WHEN COMP_LOOP_C_96 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101100");
        state_var_NS <= COMP_LOOP_C_97;
      WHEN COMP_LOOP_C_97 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101101");
        state_var_NS <= COMP_LOOP_C_98;
      WHEN COMP_LOOP_C_98 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101110");
        state_var_NS <= COMP_LOOP_C_99;
      WHEN COMP_LOOP_C_99 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101111");
        state_var_NS <= COMP_LOOP_C_100;
      WHEN COMP_LOOP_C_100 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110000");
        state_var_NS <= COMP_LOOP_C_101;
      WHEN COMP_LOOP_C_101 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110001");
        state_var_NS <= COMP_LOOP_C_102;
      WHEN COMP_LOOP_C_102 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110010");
        state_var_NS <= COMP_LOOP_C_103;
      WHEN COMP_LOOP_C_103 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110011");
        state_var_NS <= COMP_LOOP_C_104;
      WHEN COMP_LOOP_C_104 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110100");
        state_var_NS <= COMP_LOOP_C_105;
      WHEN COMP_LOOP_C_105 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110101");
        state_var_NS <= COMP_LOOP_C_106;
      WHEN COMP_LOOP_C_106 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110110");
        state_var_NS <= COMP_LOOP_C_107;
      WHEN COMP_LOOP_C_107 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110111");
        state_var_NS <= COMP_LOOP_C_108;
      WHEN COMP_LOOP_C_108 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111000");
        state_var_NS <= COMP_LOOP_C_109;
      WHEN COMP_LOOP_C_109 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111001");
        state_var_NS <= COMP_LOOP_C_110;
      WHEN COMP_LOOP_C_110 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111010");
        state_var_NS <= COMP_LOOP_C_111;
      WHEN COMP_LOOP_C_111 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111011");
        state_var_NS <= COMP_LOOP_C_112;
      WHEN COMP_LOOP_C_112 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111100");
        state_var_NS <= COMP_LOOP_C_113;
      WHEN COMP_LOOP_C_113 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111101");
        state_var_NS <= COMP_LOOP_C_114;
      WHEN COMP_LOOP_C_114 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111110");
        state_var_NS <= COMP_LOOP_C_115;
      WHEN COMP_LOOP_C_115 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111111");
        state_var_NS <= COMP_LOOP_C_116;
      WHEN COMP_LOOP_C_116 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000000");
        state_var_NS <= COMP_LOOP_C_117;
      WHEN COMP_LOOP_C_117 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000001");
        state_var_NS <= COMP_LOOP_C_118;
      WHEN COMP_LOOP_C_118 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000010");
        state_var_NS <= COMP_LOOP_C_119;
      WHEN COMP_LOOP_C_119 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000011");
        state_var_NS <= COMP_LOOP_C_120;
      WHEN COMP_LOOP_C_120 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000100");
        state_var_NS <= COMP_LOOP_C_121;
      WHEN COMP_LOOP_C_121 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000101");
        state_var_NS <= COMP_LOOP_C_122;
      WHEN COMP_LOOP_C_122 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000110");
        state_var_NS <= COMP_LOOP_C_123;
      WHEN COMP_LOOP_C_123 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000111");
        state_var_NS <= COMP_LOOP_C_124;
      WHEN COMP_LOOP_C_124 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001000");
        state_var_NS <= COMP_LOOP_C_125;
      WHEN COMP_LOOP_C_125 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001001");
        state_var_NS <= COMP_LOOP_C_126;
      WHEN COMP_LOOP_C_126 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001010");
        state_var_NS <= COMP_LOOP_C_127;
      WHEN COMP_LOOP_C_127 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001011");
        state_var_NS <= COMP_LOOP_C_128;
      WHEN COMP_LOOP_C_128 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001100");
        state_var_NS <= COMP_LOOP_C_129;
      WHEN COMP_LOOP_C_129 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001101");
        state_var_NS <= COMP_LOOP_C_130;
      WHEN COMP_LOOP_C_130 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001110");
        state_var_NS <= COMP_LOOP_C_131;
      WHEN COMP_LOOP_C_131 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100001111");
        state_var_NS <= COMP_LOOP_C_132;
      WHEN COMP_LOOP_C_132 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010000");
        state_var_NS <= COMP_LOOP_C_133;
      WHEN COMP_LOOP_C_133 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010001");
        state_var_NS <= COMP_LOOP_C_134;
      WHEN COMP_LOOP_C_134 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010010");
        state_var_NS <= COMP_LOOP_C_135;
      WHEN COMP_LOOP_C_135 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010011");
        state_var_NS <= COMP_LOOP_C_136;
      WHEN COMP_LOOP_C_136 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010100");
        IF ( COMP_LOOP_C_136_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN VEC_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010101");
        IF ( VEC_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= STAGE_LOOP_C_10;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN STAGE_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010110");
        IF ( STAGE_LOOP_C_10_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= STAGE_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100010111");
        state_var_NS <= main_C_0;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000");
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

END v34;

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
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC;
    vec_rsc_0_0_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_1_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_0_i_adra_d_pff : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    vec_rsc_0_0_i_da_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_1_i_wea_d_pff : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_core;

ARCHITECTURE v34 OF inPlaceNTT_DIT_core IS
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
  SIGNAL fsm_output : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL and_dcpl : STD_LOGIC;
  SIGNAL or_tmp_35 : STD_LOGIC;
  SIGNAL or_tmp_37 : STD_LOGIC;
  SIGNAL nor_tmp_11 : STD_LOGIC;
  SIGNAL not_tmp_45 : STD_LOGIC;
  SIGNAL nor_tmp_20 : STD_LOGIC;
  SIGNAL mux_tmp_62 : STD_LOGIC;
  SIGNAL not_tmp_64 : STD_LOGIC;
  SIGNAL and_dcpl_30 : STD_LOGIC;
  SIGNAL and_dcpl_31 : STD_LOGIC;
  SIGNAL and_dcpl_32 : STD_LOGIC;
  SIGNAL and_dcpl_33 : STD_LOGIC;
  SIGNAL and_dcpl_34 : STD_LOGIC;
  SIGNAL and_dcpl_35 : STD_LOGIC;
  SIGNAL and_dcpl_36 : STD_LOGIC;
  SIGNAL and_dcpl_39 : STD_LOGIC;
  SIGNAL and_dcpl_40 : STD_LOGIC;
  SIGNAL and_dcpl_41 : STD_LOGIC;
  SIGNAL and_dcpl_42 : STD_LOGIC;
  SIGNAL and_dcpl_43 : STD_LOGIC;
  SIGNAL and_dcpl_45 : STD_LOGIC;
  SIGNAL and_dcpl_46 : STD_LOGIC;
  SIGNAL and_dcpl_47 : STD_LOGIC;
  SIGNAL and_dcpl_49 : STD_LOGIC;
  SIGNAL and_dcpl_52 : STD_LOGIC;
  SIGNAL and_dcpl_55 : STD_LOGIC;
  SIGNAL and_dcpl_65 : STD_LOGIC;
  SIGNAL and_dcpl_66 : STD_LOGIC;
  SIGNAL and_dcpl_68 : STD_LOGIC;
  SIGNAL and_dcpl_69 : STD_LOGIC;
  SIGNAL and_dcpl_76 : STD_LOGIC;
  SIGNAL and_dcpl_77 : STD_LOGIC;
  SIGNAL and_dcpl_79 : STD_LOGIC;
  SIGNAL and_dcpl_80 : STD_LOGIC;
  SIGNAL and_dcpl_81 : STD_LOGIC;
  SIGNAL or_dcpl_22 : STD_LOGIC;
  SIGNAL or_dcpl_24 : STD_LOGIC;
  SIGNAL and_dcpl_86 : STD_LOGIC;
  SIGNAL mux_tmp_81 : STD_LOGIC;
  SIGNAL nor_tmp_28 : STD_LOGIC;
  SIGNAL not_tmp_93 : STD_LOGIC;
  SIGNAL mux_tmp_86 : STD_LOGIC;
  SIGNAL and_dcpl_93 : STD_LOGIC;
  SIGNAL and_dcpl_97 : STD_LOGIC;
  SIGNAL mux_tmp_90 : STD_LOGIC;
  SIGNAL and_dcpl_99 : STD_LOGIC;
  SIGNAL and_dcpl_100 : STD_LOGIC;
  SIGNAL and_dcpl_102 : STD_LOGIC;
  SIGNAL mux_tmp_100 : STD_LOGIC;
  SIGNAL and_dcpl_112 : STD_LOGIC;
  SIGNAL or_tmp_122 : STD_LOGIC;
  SIGNAL and_dcpl_113 : STD_LOGIC;
  SIGNAL mux_tmp_104 : STD_LOGIC;
  SIGNAL and_dcpl_116 : STD_LOGIC;
  SIGNAL and_dcpl_118 : STD_LOGIC;
  SIGNAL and_dcpl_122 : STD_LOGIC;
  SIGNAL and_dcpl_132 : STD_LOGIC;
  SIGNAL and_dcpl_134 : STD_LOGIC;
  SIGNAL not_tmp_132 : STD_LOGIC;
  SIGNAL and_dcpl_142 : STD_LOGIC;
  SIGNAL and_dcpl_144 : STD_LOGIC;
  SIGNAL or_tmp_177 : STD_LOGIC;
  SIGNAL and_tmp_19 : STD_LOGIC;
  SIGNAL or_tmp_184 : STD_LOGIC;
  SIGNAL and_dcpl_152 : STD_LOGIC;
  SIGNAL and_dcpl_154 : STD_LOGIC;
  SIGNAL or_tmp_201 : STD_LOGIC;
  SIGNAL and_dcpl_159 : STD_LOGIC;
  SIGNAL or_dcpl_31 : STD_LOGIC;
  SIGNAL or_dcpl_37 : STD_LOGIC;
  SIGNAL or_dcpl_38 : STD_LOGIC;
  SIGNAL or_dcpl_40 : STD_LOGIC;
  SIGNAL or_dcpl_41 : STD_LOGIC;
  SIGNAL and_dcpl_163 : STD_LOGIC;
  SIGNAL and_dcpl_164 : STD_LOGIC;
  SIGNAL and_dcpl_166 : STD_LOGIC;
  SIGNAL or_dcpl_48 : STD_LOGIC;
  SIGNAL or_dcpl_59 : STD_LOGIC;
  SIGNAL or_dcpl_62 : STD_LOGIC;
  SIGNAL exit_COMP_LOOP_1_modExp_1_while_sva : STD_LOGIC;
  SIGNAL COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm : STD_LOGIC;
  SIGNAL VEC_LOOP_j_sva_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL modExp_exp_1_0_1_sva : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_1_cse_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_10_cse_12_1_1_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_1_acc_8_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_139_m1c : STD_LOGIC;
  SIGNAL reg_vec_rsc_triosy_0_1_obj_ld_cse : STD_LOGIC;
  SIGNAL and_254_cse : STD_LOGIC;
  SIGNAL and_217_cse : STD_LOGIC;
  SIGNAL or_142_cse : STD_LOGIC;
  SIGNAL or_292_cse : STD_LOGIC;
  SIGNAL or_342_cse : STD_LOGIC;
  SIGNAL nor_110_cse : STD_LOGIC;
  SIGNAL and_216_cse : STD_LOGIC;
  SIGNAL or_221_cse : STD_LOGIC;
  SIGNAL and_270_cse : STD_LOGIC;
  SIGNAL or_38_cse : STD_LOGIC;
  SIGNAL or_327_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_k_9_1_sva_7_0 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL and_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_psp_sva_1 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_psp_sva : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_dcpl_197 : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL and_dcpl_198 : STD_LOGIC;
  SIGNAL and_dcpl_201 : STD_LOGIC;
  SIGNAL and_dcpl_202 : STD_LOGIC;
  SIGNAL and_dcpl_205 : STD_LOGIC;
  SIGNAL and_dcpl_206 : STD_LOGIC;
  SIGNAL and_dcpl_212 : STD_LOGIC;
  SIGNAL and_dcpl_216 : STD_LOGIC;
  SIGNAL and_dcpl_217 : STD_LOGIC;
  SIGNAL and_dcpl_226 : STD_LOGIC;
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL and_dcpl_247 : STD_LOGIC;
  SIGNAL and_dcpl_256 : STD_LOGIC;
  SIGNAL and_dcpl_269 : STD_LOGIC;
  SIGNAL z_out_3 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL and_dcpl_284 : STD_LOGIC;
  SIGNAL z_out_5 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL r_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_psp_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL modExp_result_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_exp_1_7_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_5_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_4_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_3_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_2_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_1_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_0_1_sva_1 : STD_LOGIC;
  SIGNAL modExp_exp_1_5_1_sva_1 : STD_LOGIC;
  SIGNAL modExp_while_if_mul_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_modExp_1_while_if_mul_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_mul_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_acc_5_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_2_modExp_1_while_mul_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_2_mul_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_while_mul_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_modExp_1_while_mul_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_2_modExp_1_while_if_mul_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva_mx0c1 : STD_LOGIC;
  SIGNAL STAGE_LOOP_i_3_0_sva_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL modulo_qr_sva_1_mx0w1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_acc_5_mut_mx0w7 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_psp_sva_mx0w0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL VEC_LOOP_j_sva_11_0_mx0c1 : STD_LOGIC;
  SIGNAL modExp_result_sva_mx0c0 : STD_LOGIC;
  SIGNAL operator_64_false_slc_modExp_exp_63_1_3 : STD_LOGIC_VECTOR (62 DOWNTO 0);
  SIGNAL modExp_while_and_3 : STD_LOGIC;
  SIGNAL modExp_while_and_5 : STD_LOGIC;
  SIGNAL and_145_m1c : STD_LOGIC;
  SIGNAL modExp_result_and_rgt : STD_LOGIC;
  SIGNAL modExp_result_and_1_rgt : STD_LOGIC;
  SIGNAL COMP_LOOP_or_2_cse : STD_LOGIC;
  SIGNAL and_320_cse : STD_LOGIC;
  SIGNAL mux_tmp : STD_LOGIC;
  SIGNAL operator_64_false_mux1h_1_rgt : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL operator_64_false_acc_mut_64 : STD_LOGIC;
  SIGNAL operator_64_false_acc_mut_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL nor_215_cse : STD_LOGIC;
  SIGNAL STAGE_LOOP_acc_itm_2_1 : STD_LOGIC;
  SIGNAL z_out_4_8 : STD_LOGIC;
  SIGNAL nand_18_cse : STD_LOGIC;

  SIGNAL modulo_result_or_nl : STD_LOGIC;
  SIGNAL mux_80_nl : STD_LOGIC;
  SIGNAL mux_79_nl : STD_LOGIC;
  SIGNAL nor_121_nl : STD_LOGIC;
  SIGNAL nor_122_nl : STD_LOGIC;
  SIGNAL nor_123_nl : STD_LOGIC;
  SIGNAL and_96_nl : STD_LOGIC;
  SIGNAL and_98_nl : STD_LOGIC;
  SIGNAL and_102_nl : STD_LOGIC;
  SIGNAL mux_83_nl : STD_LOGIC;
  SIGNAL or_133_nl : STD_LOGIC;
  SIGNAL and_105_nl : STD_LOGIC;
  SIGNAL mux_84_nl : STD_LOGIC;
  SIGNAL nor_120_nl : STD_LOGIC;
  SIGNAL and_106_nl : STD_LOGIC;
  SIGNAL mux_87_nl : STD_LOGIC;
  SIGNAL mux_85_nl : STD_LOGIC;
  SIGNAL nor_168_nl : STD_LOGIC;
  SIGNAL mux_93_nl : STD_LOGIC;
  SIGNAL nand_42_nl : STD_LOGIC;
  SIGNAL mux_92_nl : STD_LOGIC;
  SIGNAL mux_91_nl : STD_LOGIC;
  SIGNAL or_360_nl : STD_LOGIC;
  SIGNAL nand_43_nl : STD_LOGIC;
  SIGNAL mux_89_nl : STD_LOGIC;
  SIGNAL mux_97_nl : STD_LOGIC;
  SIGNAL and_250_nl : STD_LOGIC;
  SIGNAL mux_96_nl : STD_LOGIC;
  SIGNAL mux_95_nl : STD_LOGIC;
  SIGNAL nor_115_nl : STD_LOGIC;
  SIGNAL and_251_nl : STD_LOGIC;
  SIGNAL nor_116_nl : STD_LOGIC;
  SIGNAL mux_94_nl : STD_LOGIC;
  SIGNAL and_122_nl : STD_LOGIC;
  SIGNAL and_123_nl : STD_LOGIC;
  SIGNAL mux_99_nl : STD_LOGIC;
  SIGNAL and_249_nl : STD_LOGIC;
  SIGNAL nor_114_nl : STD_LOGIC;
  SIGNAL mux_98_nl : STD_LOGIC;
  SIGNAL and_126_nl : STD_LOGIC;
  SIGNAL mux_101_nl : STD_LOGIC;
  SIGNAL nor_113_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_mux_2_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_206_nl : STD_LOGIC;
  SIGNAL mux_201_nl : STD_LOGIC;
  SIGNAL and_219_nl : STD_LOGIC;
  SIGNAL nor_82_nl : STD_LOGIC;
  SIGNAL and_131_nl : STD_LOGIC;
  SIGNAL nor_167_nl : STD_LOGIC;
  SIGNAL mux_110_nl : STD_LOGIC;
  SIGNAL mux_109_nl : STD_LOGIC;
  SIGNAL mux_108_nl : STD_LOGIC;
  SIGNAL mux_107_nl : STD_LOGIC;
  SIGNAL nor_111_nl : STD_LOGIC;
  SIGNAL and_246_nl : STD_LOGIC;
  SIGNAL mux_106_nl : STD_LOGIC;
  SIGNAL mux_105_nl : STD_LOGIC;
  SIGNAL nor_112_nl : STD_LOGIC;
  SIGNAL and_248_nl : STD_LOGIC;
  SIGNAL mux_221_nl : STD_LOGIC;
  SIGNAL mux_220_nl : STD_LOGIC;
  SIGNAL nor_216_nl : STD_LOGIC;
  SIGNAL mux_219_nl : STD_LOGIC;
  SIGNAL or_388_nl : STD_LOGIC;
  SIGNAL or_387_nl : STD_LOGIC;
  SIGNAL mux_218_nl : STD_LOGIC;
  SIGNAL mux_217_nl : STD_LOGIC;
  SIGNAL and_400_nl : STD_LOGIC;
  SIGNAL or_384_nl : STD_LOGIC;
  SIGNAL nand_53_nl : STD_LOGIC;
  SIGNAL mux_216_nl : STD_LOGIC;
  SIGNAL mux_215_nl : STD_LOGIC;
  SIGNAL and_401_nl : STD_LOGIC;
  SIGNAL or_382_nl : STD_LOGIC;
  SIGNAL mux_224_nl : STD_LOGIC;
  SIGNAL mux_223_nl : STD_LOGIC;
  SIGNAL mux_222_nl : STD_LOGIC;
  SIGNAL nor_211_nl : STD_LOGIC;
  SIGNAL nor_212_nl : STD_LOGIC;
  SIGNAL nor_213_nl : STD_LOGIC;
  SIGNAL nor_214_nl : STD_LOGIC;
  SIGNAL nand_50_nl : STD_LOGIC;
  SIGNAL mux_118_nl : STD_LOGIC;
  SIGNAL or_165_nl : STD_LOGIC;
  SIGNAL mux_226_nl : STD_LOGIC;
  SIGNAL nor_208_nl : STD_LOGIC;
  SIGNAL mux_225_nl : STD_LOGIC;
  SIGNAL or_400_nl : STD_LOGIC;
  SIGNAL or_398_nl : STD_LOGIC;
  SIGNAL nor_209_nl : STD_LOGIC;
  SIGNAL nor_210_nl : STD_LOGIC;
  SIGNAL mux_127_nl : STD_LOGIC;
  SIGNAL mux_126_nl : STD_LOGIC;
  SIGNAL or_336_nl : STD_LOGIC;
  SIGNAL mux_125_nl : STD_LOGIC;
  SIGNAL or_180_nl : STD_LOGIC;
  SIGNAL or_337_nl : STD_LOGIC;
  SIGNAL nor_106_nl : STD_LOGIC;
  SIGNAL mux_124_nl : STD_LOGIC;
  SIGNAL or_175_nl : STD_LOGIC;
  SIGNAL mux_128_nl : STD_LOGIC;
  SIGNAL nor_104_nl : STD_LOGIC;
  SIGNAL nor_105_nl : STD_LOGIC;
  SIGNAL and_142_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_7_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_8_nl : STD_LOGIC;
  SIGNAL and_154_nl : STD_LOGIC;
  SIGNAL and_157_nl : STD_LOGIC;
  SIGNAL mux_141_nl : STD_LOGIC;
  SIGNAL mux_140_nl : STD_LOGIC;
  SIGNAL mux_139_nl : STD_LOGIC;
  SIGNAL or_197_nl : STD_LOGIC;
  SIGNAL or_71_nl : STD_LOGIC;
  SIGNAL mux_47_nl : STD_LOGIC;
  SIGNAL mux_46_nl : STD_LOGIC;
  SIGNAL or_70_nl : STD_LOGIC;
  SIGNAL mux_136_nl : STD_LOGIC;
  SIGNAL mux_135_nl : STD_LOGIC;
  SIGNAL or_333_nl : STD_LOGIC;
  SIGNAL nand_29_nl : STD_LOGIC;
  SIGNAL mux_45_nl : STD_LOGIC;
  SIGNAL nand_30_nl : STD_LOGIC;
  SIGNAL mux_44_nl : STD_LOGIC;
  SIGNAL mux_43_nl : STD_LOGIC;
  SIGNAL nor_144_nl : STD_LOGIC;
  SIGNAL mux_42_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_and_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_and_1_nl : STD_LOGIC;
  SIGNAL mux_156_nl : STD_LOGIC;
  SIGNAL mux_155_nl : STD_LOGIC;
  SIGNAL mux_154_nl : STD_LOGIC;
  SIGNAL mux_153_nl : STD_LOGIC;
  SIGNAL mux_152_nl : STD_LOGIC;
  SIGNAL nor_96_nl : STD_LOGIC;
  SIGNAL mux_151_nl : STD_LOGIC;
  SIGNAL mux_150_nl : STD_LOGIC;
  SIGNAL mux_149_nl : STD_LOGIC;
  SIGNAL or_331_nl : STD_LOGIC;
  SIGNAL and_234_nl : STD_LOGIC;
  SIGNAL mux_148_nl : STD_LOGIC;
  SIGNAL nand_5_nl : STD_LOGIC;
  SIGNAL mux_147_nl : STD_LOGIC;
  SIGNAL mux_146_nl : STD_LOGIC;
  SIGNAL mux_145_nl : STD_LOGIC;
  SIGNAL or_204_nl : STD_LOGIC;
  SIGNAL mux_144_nl : STD_LOGIC;
  SIGNAL or_202_nl : STD_LOGIC;
  SIGNAL nor_99_nl : STD_LOGIC;
  SIGNAL mux_143_nl : STD_LOGIC;
  SIGNAL mux_142_nl : STD_LOGIC;
  SIGNAL or_200_nl : STD_LOGIC;
  SIGNAL or_199_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_16_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_and_5_nl : STD_LOGIC;
  SIGNAL mux_168_nl : STD_LOGIC;
  SIGNAL mux_167_nl : STD_LOGIC;
  SIGNAL mux_166_nl : STD_LOGIC;
  SIGNAL mux_165_nl : STD_LOGIC;
  SIGNAL mux_164_nl : STD_LOGIC;
  SIGNAL mux_163_nl : STD_LOGIC;
  SIGNAL or_219_nl : STD_LOGIC;
  SIGNAL mux_162_nl : STD_LOGIC;
  SIGNAL mux_161_nl : STD_LOGIC;
  SIGNAL mux_160_nl : STD_LOGIC;
  SIGNAL or_218_nl : STD_LOGIC;
  SIGNAL mux_159_nl : STD_LOGIC;
  SIGNAL mux_158_nl : STD_LOGIC;
  SIGNAL or_216_nl : STD_LOGIC;
  SIGNAL or_47_nl : STD_LOGIC;
  SIGNAL mux_176_nl : STD_LOGIC;
  SIGNAL mux_175_nl : STD_LOGIC;
  SIGNAL mux_174_nl : STD_LOGIC;
  SIGNAL mux_173_nl : STD_LOGIC;
  SIGNAL or_230_nl : STD_LOGIC;
  SIGNAL and_242_nl : STD_LOGIC;
  SIGNAL mux_172_nl : STD_LOGIC;
  SIGNAL mux_171_nl : STD_LOGIC;
  SIGNAL mux_170_nl : STD_LOGIC;
  SIGNAL mux_169_nl : STD_LOGIC;
  SIGNAL and_230_nl : STD_LOGIC;
  SIGNAL or_225_nl : STD_LOGIC;
  SIGNAL or_223_nl : STD_LOGIC;
  SIGNAL mux_178_nl : STD_LOGIC;
  SIGNAL mux_177_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_1_acc_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL mux_183_nl : STD_LOGIC;
  SIGNAL nor_164_nl : STD_LOGIC;
  SIGNAL and_281_nl : STD_LOGIC;
  SIGNAL and_194_nl : STD_LOGIC;
  SIGNAL mux_193_nl : STD_LOGIC;
  SIGNAL nor_86_nl : STD_LOGIC;
  SIGNAL nor_87_nl : STD_LOGIC;
  SIGNAL mux_192_nl : STD_LOGIC;
  SIGNAL nand_40_nl : STD_LOGIC;
  SIGNAL mux_191_nl : STD_LOGIC;
  SIGNAL mux_190_nl : STD_LOGIC;
  SIGNAL or_277_nl : STD_LOGIC;
  SIGNAL mux_189_nl : STD_LOGIC;
  SIGNAL and_191_nl : STD_LOGIC;
  SIGNAL or_358_nl : STD_LOGIC;
  SIGNAL mux_188_nl : STD_LOGIC;
  SIGNAL nand_10_nl : STD_LOGIC;
  SIGNAL nor_89_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_26_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_40_nl : STD_LOGIC;
  SIGNAL nor_160_nl : STD_LOGIC;
  SIGNAL mux_199_nl : STD_LOGIC;
  SIGNAL mux_198_nl : STD_LOGIC;
  SIGNAL nand_46_nl : STD_LOGIC;
  SIGNAL mux_197_nl : STD_LOGIC;
  SIGNAL mux_196_nl : STD_LOGIC;
  SIGNAL mux_195_nl : STD_LOGIC;
  SIGNAL nand_9_nl : STD_LOGIC;
  SIGNAL mux_194_nl : STD_LOGIC;
  SIGNAL or_282_nl : STD_LOGIC;
  SIGNAL mux_206_nl : STD_LOGIC;
  SIGNAL or_297_nl : STD_LOGIC;
  SIGNAL mux_208_nl : STD_LOGIC;
  SIGNAL and_213_nl : STD_LOGIC;
  SIGNAL nor_81_nl : STD_LOGIC;
  SIGNAL or_347_nl : STD_LOGIC;
  SIGNAL nor_140_nl : STD_LOGIC;
  SIGNAL mux_82_nl : STD_LOGIC;
  SIGNAL mux_88_nl : STD_LOGIC;
  SIGNAL nor_118_nl : STD_LOGIC;
  SIGNAL nor_119_nl : STD_LOGIC;
  SIGNAL mux_102_nl : STD_LOGIC;
  SIGNAL or_152_nl : STD_LOGIC;
  SIGNAL or_151_nl : STD_LOGIC;
  SIGNAL mux_129_nl : STD_LOGIC;
  SIGNAL and_404_nl : STD_LOGIC;
  SIGNAL nor_nl : STD_LOGIC;
  SIGNAL nor_102_nl : STD_LOGIC;
  SIGNAL nor_103_nl : STD_LOGIC;
  SIGNAL mux_157_nl : STD_LOGIC;
  SIGNAL or_211_nl : STD_LOGIC;
  SIGNAL mux_184_nl : STD_LOGIC;
  SIGNAL nor_91_nl : STD_LOGIC;
  SIGNAL nor_92_nl : STD_LOGIC;
  SIGNAL mux_187_nl : STD_LOGIC;
  SIGNAL nand_41_nl : STD_LOGIC;
  SIGNAL mux_186_nl : STD_LOGIC;
  SIGNAL and_186_nl : STD_LOGIC;
  SIGNAL or_270_nl : STD_LOGIC;
  SIGNAL mux_185_nl : STD_LOGIC;
  SIGNAL and_280_nl : STD_LOGIC;
  SIGNAL or_359_nl : STD_LOGIC;
  SIGNAL nor_107_nl : STD_LOGIC;
  SIGNAL mux_122_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_acc_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL and_70_nl : STD_LOGIC;
  SIGNAL nor_175_nl : STD_LOGIC;
  SIGNAL mux_65_nl : STD_LOGIC;
  SIGNAL or_366_nl : STD_LOGIC;
  SIGNAL or_367_nl : STD_LOGIC;
  SIGNAL and_75_nl : STD_LOGIC;
  SIGNAL mux_66_nl : STD_LOGIC;
  SIGNAL nor_136_nl : STD_LOGIC;
  SIGNAL nor_137_nl : STD_LOGIC;
  SIGNAL nor_133_nl : STD_LOGIC;
  SIGNAL nor_134_nl : STD_LOGIC;
  SIGNAL mux_68_nl : STD_LOGIC;
  SIGNAL nand_1_nl : STD_LOGIC;
  SIGNAL mux_67_nl : STD_LOGIC;
  SIGNAL nor_135_nl : STD_LOGIC;
  SIGNAL and_260_nl : STD_LOGIC;
  SIGNAL or_99_nl : STD_LOGIC;
  SIGNAL mux_72_nl : STD_LOGIC;
  SIGNAL and_259_nl : STD_LOGIC;
  SIGNAL mux_71_nl : STD_LOGIC;
  SIGNAL nor_130_nl : STD_LOGIC;
  SIGNAL nor_131_nl : STD_LOGIC;
  SIGNAL nor_132_nl : STD_LOGIC;
  SIGNAL mux_70_nl : STD_LOGIC;
  SIGNAL or_107_nl : STD_LOGIC;
  SIGNAL or_105_nl : STD_LOGIC;
  SIGNAL nor_127_nl : STD_LOGIC;
  SIGNAL nor_128_nl : STD_LOGIC;
  SIGNAL mux_74_nl : STD_LOGIC;
  SIGNAL nand_25_nl : STD_LOGIC;
  SIGNAL mux_73_nl : STD_LOGIC;
  SIGNAL nor_129_nl : STD_LOGIC;
  SIGNAL and_258_nl : STD_LOGIC;
  SIGNAL or_113_nl : STD_LOGIC;
  SIGNAL mux_78_nl : STD_LOGIC;
  SIGNAL and_257_nl : STD_LOGIC;
  SIGNAL mux_77_nl : STD_LOGIC;
  SIGNAL nor_124_nl : STD_LOGIC;
  SIGNAL nor_125_nl : STD_LOGIC;
  SIGNAL nor_126_nl : STD_LOGIC;
  SIGNAL mux_76_nl : STD_LOGIC;
  SIGNAL or_119_nl : STD_LOGIC;
  SIGNAL or_117_nl : STD_LOGIC;
  SIGNAL and_403_nl : STD_LOGIC;
  SIGNAL or_nl : STD_LOGIC;
  SIGNAL acc_nl : STD_LOGIC_VECTOR (65 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_13_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_nand_2_nl : STD_LOGIC;
  SIGNAL mux_229_nl : STD_LOGIC;
  SIGNAL nor_217_nl : STD_LOGIC;
  SIGNAL nor_218_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_nand_3_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_not_50_nl : STD_LOGIC;
  SIGNAL acc_1_nl : STD_LOGIC_VECTOR (65 DOWNTO 0);
  SIGNAL COMP_LOOP_mux1h_71_nl : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL COMP_LOOP_or_17_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_1_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL COMP_LOOP_nor_4_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_11_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL operator_64_false_1_or_3_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_2_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_13_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_405_nl : STD_LOGIC;
  SIGNAL and_406_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_or_4_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_acc_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL operator_64_false_1_mux_12_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_13_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_14_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_15_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_16_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_17_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_18_nl : STD_LOGIC;
  SIGNAL modExp_while_if_mux1h_2_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_407_nl : STD_LOGIC;
  SIGNAL and_408_nl : STD_LOGIC;
  SIGNAL mux_230_nl : STD_LOGIC;
  SIGNAL nor_221_nl : STD_LOGIC;
  SIGNAL and_409_nl : STD_LOGIC;
  SIGNAL mux_231_nl : STD_LOGIC;
  SIGNAL nor_222_nl : STD_LOGIC;
  SIGNAL nor_223_nl : STD_LOGIC;
  SIGNAL and_410_nl : STD_LOGIC;
  SIGNAL mux_232_nl : STD_LOGIC;
  SIGNAL mux_233_nl : STD_LOGIC;
  SIGNAL nor_225_nl : STD_LOGIC;
  SIGNAL nor_226_nl : STD_LOGIC;
  SIGNAL mux_234_nl : STD_LOGIC;
  SIGNAL or_404_nl : STD_LOGIC;
  SIGNAL or_405_nl : STD_LOGIC;
  SIGNAL nor_227_nl : STD_LOGIC;
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
      fsm_output : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      STAGE_LOOP_C_9_tr0 : IN STD_LOGIC;
      modExp_while_C_42_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
      COMP_LOOP_1_modExp_1_while_C_42_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_68_tr0 : IN STD_LOGIC;
      COMP_LOOP_2_modExp_1_while_C_42_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_136_tr0 : IN STD_LOGIC;
      VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
      STAGE_LOOP_C_10_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (8 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_68_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_42_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0 : STD_LOGIC;

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

  FUNCTION MUX1HOT_v_11_5_2(input_4 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(10 DOWNTO 0);

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

  FUNCTION MUX1HOT_v_64_12_2(input_11 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_10 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(11 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 8));
      result := result or ( input_8 and tmp);
      tmp := (OTHERS=>sel( 9));
      result := result or ( input_9 and tmp);
      tmp := (OTHERS=>sel( 10));
      result := result or ( input_10 and tmp);
      tmp := (OTHERS=>sel( 11));
      result := result or ( input_11 and tmp);
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

  FUNCTION MUX1HOT_v_64_7_2(input_6 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(6 DOWNTO 0))
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

  FUNCTION MUX1HOT_v_65_5_2(input_4 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(64 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
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

  vec_rsc_triosy_0_1_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_1_obj_ld_cse,
      lz => vec_rsc_triosy_0_1_lz
    );
  vec_rsc_triosy_0_0_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_1_obj_ld_cse,
      lz => vec_rsc_triosy_0_0_lz
    );
  p_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_1_obj_ld_cse,
      lz => p_rsc_triosy_lz
    );
  r_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_1_obj_ld_cse,
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
      STAGE_LOOP_C_9_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0,
      modExp_while_C_42_tr0 => exit_COMP_LOOP_1_modExp_1_while_sva,
      COMP_LOOP_C_1_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0,
      COMP_LOOP_1_modExp_1_while_C_42_tr0 => exit_COMP_LOOP_1_modExp_1_while_sva,
      COMP_LOOP_C_68_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_68_tr0,
      COMP_LOOP_2_modExp_1_while_C_42_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_42_tr0,
      COMP_LOOP_C_136_tr0 => exit_COMP_LOOP_1_modExp_1_while_sva,
      VEC_LOOP_C_0_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_10_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0
    );
  fsm_output <= inPlaceNTT_DIT_core_core_fsm_inst_fsm_output;
  inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0 <= NOT (z_out_1(64));
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 <= NOT COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_68_tr0 <= NOT COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_42_tr0 <= NOT COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 <= z_out_3(12);
  inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0 <= NOT STAGE_LOOP_acc_itm_2_1;

  and_254_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  or_142_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  and_217_cse <= (fsm_output(4)) AND (fsm_output(7));
  or_292_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"));
  or_342_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"));
  nor_110_cse <= NOT((fsm_output(4)) OR (fsm_output(7)));
  and_216_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  and_219_nl <= (VEC_LOOP_j_sva_11_0(0)) AND (fsm_output(0)) AND (fsm_output(4));
  nor_82_nl <= NOT((NOT (COMP_LOOP_acc_1_cse_sva(0))) OR (fsm_output(0)) OR (fsm_output(4)));
  mux_201_nl <= MUX_s_1_2_2(and_219_nl, nor_82_nl, fsm_output(7));
  and_206_nl <= mux_201_nl AND (fsm_output(2)) AND (NOT (fsm_output(3))) AND (fsm_output(1))
      AND (fsm_output(5)) AND nor_215_cse;
  COMP_LOOP_COMP_LOOP_mux_2_nl <= MUX_v_64_2_2(vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d,
      and_206_nl);
  and_131_nl <= and_dcpl_35 AND and_dcpl_113 AND and_dcpl_32;
  nor_111_nl <= NOT(and_216_cse OR (fsm_output(6)));
  and_246_nl <= or_292_cse AND (fsm_output(6));
  mux_107_nl <= MUX_s_1_2_2(nor_111_nl, and_246_nl, fsm_output(3));
  mux_108_nl <= MUX_s_1_2_2((NOT (fsm_output(6))), mux_107_nl, fsm_output(4));
  nor_112_nl <= NOT(and_270_cse OR (fsm_output(6)));
  and_248_nl <= or_342_cse AND (fsm_output(6));
  mux_105_nl <= MUX_s_1_2_2(nor_112_nl, and_248_nl, fsm_output(3));
  mux_106_nl <= MUX_s_1_2_2(mux_105_nl, (fsm_output(6)), fsm_output(4));
  mux_109_nl <= MUX_s_1_2_2(mux_108_nl, mux_106_nl, fsm_output(7));
  mux_110_nl <= MUX_s_1_2_2((NOT (fsm_output(6))), mux_109_nl, fsm_output(5));
  nor_167_nl <= NOT(mux_110_nl OR (fsm_output(8)));
  operator_64_false_mux1h_1_rgt <= MUX1HOT_v_65_3_2(z_out, (STD_LOGIC_VECTOR'( "00")
      & operator_64_false_slc_modExp_exp_63_1_3), ('0' & COMP_LOOP_COMP_LOOP_mux_2_nl),
      STD_LOGIC_VECTOR'( and_131_nl & and_dcpl_116 & nor_167_nl));
  nor_215_cse <= NOT((fsm_output(6)) OR (fsm_output(8)));
  and_139_m1c <= and_dcpl_36 AND and_dcpl_46;
  and_cse <= (fsm_output(4)) AND (CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")));
  modExp_result_and_rgt <= (NOT modExp_while_and_5) AND and_139_m1c;
  modExp_result_and_1_rgt <= modExp_while_and_5 AND and_139_m1c;
  nand_18_cse <= NOT((fsm_output(4)) AND (fsm_output(2)));
  nor_104_nl <= NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR nand_18_cse);
  nor_105_nl <= NOT((fsm_output(0)) OR (NOT (fsm_output(1))) OR (fsm_output(4)) OR
      (fsm_output(2)));
  mux_128_nl <= MUX_s_1_2_2(nor_104_nl, nor_105_nl, fsm_output(6));
  and_145_m1c <= mux_128_nl AND (NOT (fsm_output(3))) AND (fsm_output(5)) AND and_dcpl_30;
  or_221_cse <= (fsm_output(2)) OR (fsm_output(7)) OR (NOT (fsm_output(6)));
  and_270_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11"));
  or_327_cse <= CONV_SL_1_1(fsm_output(3 DOWNTO 0)/=STD_LOGIC_VECTOR'("0000"));
  COMP_LOOP_or_2_cse <= and_dcpl_52 OR and_dcpl_68;
  STAGE_LOOP_i_3_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_i_3_0_sva)
      + UNSIGNED'( "0001"), 4));
  COMP_LOOP_acc_psp_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_11_0(11
      DOWNTO 1)) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0),
      8), 11), 11));
  modulo_qr_sva_1_mx0w1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(modulo_result_rem_cmp_z)
      + UNSIGNED(p_sva), 64));
  vec_rsc_0_0_i_da_d_1 <= MUX_v_64_2_2(modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w1,
      modulo_result_rem_cmp_z(63));
  COMP_LOOP_1_acc_5_mut_mx0w7 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(operator_64_false_acc_mut_63_0)
      + SIGNED(vec_rsc_0_0_i_da_d_1), 64));
  operator_64_false_slc_modExp_exp_63_1_3 <= MUX_v_63_2_2((operator_66_true_div_cmp_z(63
      DOWNTO 1)), (COMP_LOOP_1_acc_8_itm(63 DOWNTO 1)), and_dcpl_122);
  modExp_while_and_3 <= (NOT (modulo_result_rem_cmp_z(63))) AND modExp_exp_1_0_1_sva;
  modExp_while_and_5 <= (modulo_result_rem_cmp_z(63)) AND modExp_exp_1_0_1_sva;
  and_dcpl <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("01"));
  or_38_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_tmp_35 <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  or_tmp_37 <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("10"));
  nor_tmp_11 <= or_142_cse AND (fsm_output(7));
  not_tmp_45 <= NOT(and_254_cse OR (fsm_output(7)));
  nor_tmp_20 <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11"));
  mux_tmp_62 <= MUX_s_1_2_2(nor_tmp_20, and_cse, and_254_cse);
  or_347_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 0)/=STD_LOGIC_VECTOR'("00000000"));
  nor_140_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000"))
      OR mux_tmp_62);
  not_tmp_64 <= MUX_s_1_2_2(or_347_nl, nor_140_nl, fsm_output(8));
  and_dcpl_30 <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_31 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_32 <= and_dcpl_31 AND and_dcpl_30;
  and_dcpl_33 <= NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_34 <= NOT(CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_35 <= and_dcpl_34 AND (NOT (fsm_output(4)));
  and_dcpl_36 <= and_dcpl_35 AND and_dcpl_33;
  and_dcpl_39 <= and_dcpl_31 AND CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_40 <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_41 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_42 <= and_dcpl_41 AND (fsm_output(4));
  and_dcpl_43 <= and_dcpl_42 AND and_dcpl_40;
  and_dcpl_45 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_46 <= and_dcpl_45 AND and_dcpl_30;
  and_dcpl_47 <= and_dcpl_43 AND and_dcpl_46;
  and_dcpl_49 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")) AND
      and_dcpl_30;
  and_dcpl_52 <= and_dcpl_35 AND and_254_cse AND and_dcpl_49;
  and_dcpl_55 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("11"));
  and_dcpl_65 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("10")) AND
      and_dcpl;
  and_dcpl_66 <= and_dcpl_34 AND (fsm_output(4));
  and_dcpl_68 <= and_dcpl_66 AND and_dcpl_40 AND and_dcpl_65;
  and_dcpl_69 <= NOT((fsm_output(3)) OR (fsm_output(8)));
  and_dcpl_76 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_77 <= and_dcpl_76 AND (NOT (fsm_output(4)));
  and_dcpl_79 <= and_dcpl_77 AND and_254_cse AND and_dcpl_32;
  and_dcpl_80 <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_81 <= and_dcpl_80 AND (NOT (fsm_output(8)));
  or_dcpl_22 <= and_dcpl_55 OR (fsm_output(4));
  or_dcpl_24 <= NOT(((NOT(and_dcpl_33 OR (NOT (fsm_output(2))))) OR (fsm_output(3)))
      AND (fsm_output(4)));
  and_dcpl_86 <= NOT((fsm_output(1)) OR (fsm_output(8)));
  mux_tmp_81 <= MUX_s_1_2_2((fsm_output(4)), or_dcpl_22, or_142_cse);
  nor_tmp_28 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("111"));
  mux_82_nl <= MUX_s_1_2_2(nor_tmp_28, nor_tmp_20, or_142_cse);
  not_tmp_93 <= NOT((fsm_output(5)) AND mux_82_nl);
  mux_tmp_86 <= MUX_s_1_2_2((NOT (fsm_output(3))), and_dcpl_55, fsm_output(4));
  and_dcpl_93 <= (fsm_output(6)) AND (NOT (fsm_output(8)));
  nor_118_nl <= NOT((fsm_output(0)) OR (NOT((fsm_output(1)) AND (fsm_output(4)))));
  nor_119_nl <= NOT((NOT (fsm_output(0))) OR (fsm_output(1)) OR (fsm_output(4)));
  mux_88_nl <= MUX_s_1_2_2(nor_118_nl, nor_119_nl, fsm_output(7));
  and_dcpl_97 <= mux_88_nl AND (NOT (fsm_output(2))) AND (fsm_output(3)) AND (fsm_output(5))
      AND and_dcpl_93;
  mux_tmp_90 <= MUX_s_1_2_2((fsm_output(4)), or_dcpl_22, and_254_cse);
  and_dcpl_99 <= and_dcpl_45 AND and_dcpl;
  and_dcpl_100 <= and_dcpl_41 AND (NOT (fsm_output(4)));
  and_dcpl_102 <= and_dcpl_100 AND and_254_cse AND and_dcpl_99;
  mux_tmp_100 <= MUX_s_1_2_2(or_dcpl_22, or_38_cse, or_142_cse);
  and_dcpl_112 <= (or_292_cse XOR (fsm_output(3))) AND (NOT (fsm_output(4))) AND
      and_dcpl_32;
  mux_102_nl <= MUX_s_1_2_2(nor_tmp_20, and_cse, fsm_output(1));
  or_tmp_122 <= CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000")) OR
      mux_102_nl;
  and_dcpl_113 <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  or_152_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 0)/=STD_LOGIC_VECTOR'("01010"));
  or_151_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 0)/=STD_LOGIC_VECTOR'("10101"));
  mux_tmp_104 <= MUX_s_1_2_2(or_152_nl, or_151_nl, fsm_output(5));
  and_dcpl_116 <= (NOT mux_tmp_104) AND and_dcpl_81;
  and_dcpl_118 <= and_dcpl_42 AND and_dcpl_113;
  and_dcpl_122 <= and_dcpl_118 AND and_dcpl_46;
  and_404_nl <= (fsm_output(0)) AND (fsm_output(4));
  nor_nl <= NOT((fsm_output(0)) OR (fsm_output(4)));
  mux_129_nl <= MUX_s_1_2_2(and_404_nl, nor_nl, fsm_output(7));
  and_dcpl_132 <= mux_129_nl AND and_dcpl_41 AND (fsm_output(1)) AND (fsm_output(5))
      AND nor_215_cse;
  and_dcpl_134 <= (NOT (fsm_output(3))) AND (fsm_output(6));
  nor_102_nl <= NOT((NOT (fsm_output(5))) OR (fsm_output(0)) OR (fsm_output(1)) OR
      (fsm_output(4)) OR (NOT (fsm_output(2))));
  nor_103_nl <= NOT((fsm_output(5)) OR (NOT (fsm_output(0))) OR (NOT (fsm_output(1)))
      OR (NOT (fsm_output(4))) OR (fsm_output(2)));
  not_tmp_132 <= MUX_s_1_2_2(nor_102_nl, nor_103_nl, fsm_output(7));
  and_dcpl_142 <= and_dcpl_45 AND (fsm_output(7));
  and_dcpl_144 <= nor_tmp_28 AND and_dcpl_33;
  or_tmp_177 <= and_254_cse OR (fsm_output(2));
  and_tmp_19 <= (fsm_output(5)) AND or_142_cse AND (fsm_output(2));
  or_tmp_184 <= (fsm_output(4)) OR (NOT and_dcpl_55);
  or_211_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("100"));
  mux_157_nl <= MUX_s_1_2_2(or_tmp_184, or_211_nl, fsm_output(7));
  and_dcpl_152 <= (NOT mux_157_nl) AND (NOT (fsm_output(1))) AND (fsm_output(0))
      AND (NOT (fsm_output(5))) AND and_dcpl_93;
  and_dcpl_154 <= and_dcpl_42 AND and_254_cse AND and_dcpl_46;
  or_tmp_201 <= (fsm_output(7)) OR (NOT (fsm_output(4)));
  and_dcpl_159 <= and_dcpl_76 AND (fsm_output(4)) AND and_dcpl_33 AND and_dcpl_46;
  or_dcpl_31 <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_37 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("01"));
  or_dcpl_38 <= or_dcpl_37 OR or_dcpl_31;
  or_dcpl_40 <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("01"));
  or_dcpl_41 <= or_dcpl_40 OR (NOT (fsm_output(4)));
  nor_91_nl <= NOT((fsm_output(6)) OR (NOT (fsm_output(5))) OR (fsm_output(0)) OR
      (NOT (fsm_output(3))));
  nor_92_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(5)) OR (NOT (fsm_output(0)))
      OR (fsm_output(3)));
  mux_184_nl <= MUX_s_1_2_2(nor_91_nl, nor_92_nl, fsm_output(7));
  and_dcpl_163 <= mux_184_nl AND (NOT (fsm_output(2))) AND (fsm_output(4)) AND and_dcpl_86;
  and_186_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11")) AND or_342_cse;
  or_270_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00")) OR and_216_cse;
  mux_186_nl <= MUX_s_1_2_2(and_186_nl, or_270_nl, fsm_output(7));
  nand_41_nl <= NOT((fsm_output(5)) AND mux_186_nl);
  and_280_nl <= (fsm_output(7)) AND (fsm_output(4)) AND or_327_cse;
  or_359_nl <= (fsm_output(7)) OR (fsm_output(4)) OR (fsm_output(3)) OR and_254_cse
      OR (fsm_output(2));
  mux_185_nl <= MUX_s_1_2_2(and_280_nl, or_359_nl, fsm_output(5));
  mux_187_nl <= MUX_s_1_2_2(nand_41_nl, mux_185_nl, fsm_output(6));
  and_dcpl_164 <= NOT(mux_187_nl OR (fsm_output(8)));
  and_dcpl_166 <= and_dcpl_100 AND and_dcpl_40 AND and_dcpl_99;
  or_dcpl_48 <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"));
  or_dcpl_59 <= or_dcpl_40 OR (fsm_output(4));
  or_dcpl_62 <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("01"));
  STAGE_LOOP_i_3_0_sva_mx0c1 <= and_dcpl_43 AND and_dcpl_39;
  VEC_LOOP_j_sva_11_0_mx0c1 <= and_dcpl_118 AND and_dcpl_39;
  mux_122_nl <= MUX_s_1_2_2(or_dcpl_22, or_38_cse, and_254_cse);
  nor_107_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000"))
      OR mux_122_nl);
  modExp_result_sva_mx0c0 <= MUX_s_1_2_2(nor_107_nl, or_tmp_122, fsm_output(8));
  STAGE_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(STAGE_LOOP_i_3_0_sva_2(3
      DOWNTO 1)) + SIGNED'( "011"), 3));
  STAGE_LOOP_acc_itm_2_1 <= STAGE_LOOP_acc_nl(2);
  and_70_nl <= and_dcpl_55 AND (NOT (fsm_output(4))) AND and_254_cse AND and_dcpl_31
      AND and_dcpl;
  or_366_nl <= (NOT (fsm_output(7))) OR (NOT (fsm_output(5))) OR (fsm_output(0))
      OR (fsm_output(1)) OR (fsm_output(4)) OR (NOT (fsm_output(2)));
  or_367_nl <= (fsm_output(7)) OR (fsm_output(5)) OR (NOT (fsm_output(0))) OR (NOT
      (fsm_output(1))) OR (NOT (fsm_output(4))) OR (fsm_output(2));
  mux_65_nl <= MUX_s_1_2_2(or_366_nl, or_367_nl, fsm_output(8));
  nor_175_nl <= NOT(mux_65_nl OR (fsm_output(3)) OR (fsm_output(6)));
  nor_136_nl <= NOT((NOT (fsm_output(0))) OR (fsm_output(1)) OR (fsm_output(4)) OR
      (fsm_output(3)));
  nor_137_nl <= NOT((fsm_output(0)) OR (NOT((fsm_output(1)) AND (fsm_output(4)) AND
      (fsm_output(3)))));
  mux_66_nl <= MUX_s_1_2_2(nor_136_nl, nor_137_nl, fsm_output(6));
  and_75_nl <= mux_66_nl AND (fsm_output(2)) AND (fsm_output(5)) AND and_dcpl;
  vec_rsc_0_0_i_adra_d_pff <= MUX1HOT_v_11_5_2(COMP_LOOP_acc_psp_sva_1, (z_out_3(12
      DOWNTO 2)), COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_10_cse_12_1_1_sva(11 DOWNTO
      1)), (COMP_LOOP_acc_1_cse_sva(11 DOWNTO 1)), STD_LOGIC_VECTOR'( and_dcpl_47
      & COMP_LOOP_or_2_cse & and_70_nl & nor_175_nl & and_75_nl));
  vec_rsc_0_0_i_da_d_pff <= vec_rsc_0_0_i_da_d_1;
  nor_133_nl <= NOT((fsm_output(7)) OR (NOT (fsm_output(8))) OR (NOT (fsm_output(0)))
      OR (fsm_output(5)) OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (NOT (fsm_output(1)))
      OR (COMP_LOOP_acc_10_cse_12_1_1_sva(0)) OR (fsm_output(6)));
  nor_135_nl <= NOT((fsm_output(3)) OR (fsm_output(1)) OR (COMP_LOOP_acc_10_cse_12_1_1_sva(0))
      OR (fsm_output(6)));
  and_260_nl <= (fsm_output(3)) AND (fsm_output(1)) AND (NOT (COMP_LOOP_acc_1_cse_sva(0)))
      AND (fsm_output(6));
  mux_67_nl <= MUX_s_1_2_2(nor_135_nl, and_260_nl, fsm_output(4));
  nand_1_nl <= NOT((fsm_output(5)) AND mux_67_nl);
  or_99_nl <= (fsm_output(5)) OR (fsm_output(4)) OR (NOT (fsm_output(3))) OR (NOT
      (fsm_output(1))) OR (VEC_LOOP_j_sva_11_0(0)) OR (fsm_output(6));
  mux_68_nl <= MUX_s_1_2_2(nand_1_nl, or_99_nl, fsm_output(0));
  nor_134_nl <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("01"))
      OR mux_68_nl);
  vec_rsc_0_0_i_wea_d_pff <= MUX_s_1_2_2(nor_133_nl, nor_134_nl, fsm_output(2));
  nor_130_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR (z_out_3(1)) OR (NOT (fsm_output(7))));
  nor_131_nl <= NOT((fsm_output(6)) OR (VEC_LOOP_j_sva_11_0(0)) OR (NOT (fsm_output(5)))
      OR (fsm_output(7)));
  mux_71_nl <= MUX_s_1_2_2(nor_130_nl, nor_131_nl, fsm_output(2));
  and_259_nl <= (fsm_output(4)) AND (fsm_output(1)) AND mux_71_nl;
  or_107_nl <= (NOT (fsm_output(2))) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm)
      OR (COMP_LOOP_acc_1_cse_sva(0)) OR (NOT (fsm_output(7)));
  or_105_nl <= (fsm_output(2)) OR (NOT (fsm_output(6))) OR (z_out_3(1)) OR (NOT (fsm_output(5)))
      OR (fsm_output(7));
  mux_70_nl <= MUX_s_1_2_2(or_107_nl, or_105_nl, fsm_output(1));
  nor_132_nl <= NOT((fsm_output(4)) OR mux_70_nl);
  mux_72_nl <= MUX_s_1_2_2(and_259_nl, nor_132_nl, fsm_output(0));
  vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d <= mux_72_nl AND and_dcpl_69;
  nor_127_nl <= NOT((fsm_output(7)) OR (NOT (fsm_output(8))) OR (NOT (fsm_output(0)))
      OR (fsm_output(5)) OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (NOT (fsm_output(1)))
      OR (NOT (COMP_LOOP_acc_10_cse_12_1_1_sva(0))) OR (fsm_output(6)));
  nor_129_nl <= NOT((fsm_output(3)) OR (fsm_output(1)) OR (NOT (COMP_LOOP_acc_10_cse_12_1_1_sva(0)))
      OR (fsm_output(6)));
  and_258_nl <= (fsm_output(3)) AND (fsm_output(1)) AND (COMP_LOOP_acc_1_cse_sva(0))
      AND (fsm_output(6));
  mux_73_nl <= MUX_s_1_2_2(nor_129_nl, and_258_nl, fsm_output(4));
  nand_25_nl <= NOT((fsm_output(5)) AND mux_73_nl);
  or_113_nl <= (fsm_output(5)) OR (fsm_output(4)) OR (NOT (fsm_output(3))) OR (NOT
      (fsm_output(1))) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR (fsm_output(6));
  mux_74_nl <= MUX_s_1_2_2(nand_25_nl, or_113_nl, fsm_output(0));
  nor_128_nl <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("01"))
      OR mux_74_nl);
  vec_rsc_0_1_i_wea_d_pff <= MUX_s_1_2_2(nor_127_nl, nor_128_nl, fsm_output(2));
  nor_124_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT((z_out_3(1)) AND (fsm_output(7)))));
  nor_125_nl <= NOT((fsm_output(6)) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR (NOT (fsm_output(5)))
      OR (fsm_output(7)));
  mux_77_nl <= MUX_s_1_2_2(nor_124_nl, nor_125_nl, fsm_output(2));
  and_257_nl <= (fsm_output(4)) AND (fsm_output(1)) AND mux_77_nl;
  or_119_nl <= (NOT((fsm_output(2)) AND (NOT (fsm_output(6))) AND (fsm_output(5))
      AND COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm)) OR
      (NOT((COMP_LOOP_acc_1_cse_sva(0)) AND (fsm_output(7))));
  or_117_nl <= (fsm_output(2)) OR (NOT (fsm_output(6))) OR (NOT (z_out_3(1))) OR
      (NOT (fsm_output(5))) OR (fsm_output(7));
  mux_76_nl <= MUX_s_1_2_2(or_119_nl, or_117_nl, fsm_output(1));
  nor_126_nl <= NOT((fsm_output(4)) OR mux_76_nl);
  mux_78_nl <= MUX_s_1_2_2(and_257_nl, nor_126_nl, fsm_output(0));
  vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d <= mux_78_nl AND and_dcpl_69;
  and_dcpl_197 <= NOT(CONV_SL_1_1(fsm_output/=STD_LOGIC_VECTOR'("000000001")));
  and_dcpl_198 <= (NOT (fsm_output(8))) AND (fsm_output(0));
  and_dcpl_201 <= (fsm_output(1)) AND (NOT (fsm_output(7)));
  and_dcpl_202 <= NOT((fsm_output(4)) OR (fsm_output(2)));
  and_dcpl_205 <= and_dcpl_202 AND (NOT (fsm_output(3))) AND and_dcpl_201 AND CONV_SL_1_1(fsm_output(6
      DOWNTO 5)=STD_LOGIC_VECTOR'("11")) AND and_dcpl_198;
  and_dcpl_206 <= NOT((fsm_output(8)) OR (fsm_output(0)));
  and_dcpl_212 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("101")) AND
      and_dcpl_201 AND CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("01"))
      AND and_dcpl_206;
  and_dcpl_216 <= and_dcpl_202 AND (fsm_output(3)) AND and_dcpl_201;
  and_dcpl_217 <= and_dcpl_216 AND and_dcpl_31 AND and_dcpl_198;
  and_320_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 1)=STD_LOGIC_VECTOR'("1101001"))
      AND and_dcpl_206;
  and_dcpl_226 <= and_dcpl_216 AND and_dcpl_31 AND and_dcpl_206;
  and_dcpl_247 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("101"));
  and_dcpl_256 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("000")) AND
      and_dcpl_201 AND (fsm_output(6)) AND (fsm_output(5)) AND (NOT (fsm_output(8)))
      AND (fsm_output(0));
  and_dcpl_269 <= and_dcpl_247 AND (NOT (fsm_output(1))) AND (NOT (fsm_output(7)))
      AND (NOT (fsm_output(6))) AND (NOT (fsm_output(5))) AND (fsm_output(8)) AND
      (fsm_output(0));
  and_dcpl_284 <= CONV_SL_1_1(fsm_output=STD_LOGIC_VECTOR'("000111000"));
  and_403_nl <= (fsm_output(3)) AND (fsm_output(7));
  or_nl <= (fsm_output(3)) OR (fsm_output(7));
  mux_tmp <= MUX_s_1_2_2(and_403_nl, or_nl, fsm_output(4));
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( not_tmp_64 = '0' ) THEN
        p_sva <= p_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((and_dcpl_36 AND and_dcpl_32) OR STAGE_LOOP_i_3_0_sva_mx0c1) = '1' )
          THEN
        STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(STD_LOGIC_VECTOR'( "0001"), STAGE_LOOP_i_3_0_sva_2,
            STAGE_LOOP_i_3_0_sva_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( not_tmp_64 = '0' ) THEN
        r_sva <= r_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_vec_rsc_triosy_0_1_obj_ld_cse <= '0';
        modExp_exp_1_0_1_sva <= '0';
        modExp_exp_1_7_1_sva <= '0';
        modExp_exp_1_1_1_sva <= '0';
      ELSE
        reg_vec_rsc_triosy_0_1_obj_ld_cse <= and_dcpl_43 AND and_dcpl_31 AND CONV_SL_1_1(fsm_output(8
            DOWNTO 7)=STD_LOGIC_VECTOR'("10")) AND (NOT STAGE_LOOP_acc_itm_2_1);
        modExp_exp_1_0_1_sva <= (COMP_LOOP_mux1h_16_nl AND (NOT and_dcpl_154)) OR
            mux_176_nl OR (fsm_output(8));
        modExp_exp_1_7_1_sva <= COMP_LOOP_mux1h_26_nl AND (NOT(and_dcpl_66 AND and_dcpl_113
            AND and_dcpl_65));
        modExp_exp_1_1_1_sva <= COMP_LOOP_mux1h_40_nl AND (NOT(and_dcpl_35 AND and_dcpl_40
            AND and_dcpl_49));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      modulo_result_rem_cmp_a <= MUX1HOT_v_64_12_2(z_out_5, modExp_while_if_mul_mut,
          modExp_while_mul_itm, COMP_LOOP_1_modExp_1_while_if_mul_mut, COMP_LOOP_1_modExp_1_while_mul_itm,
          COMP_LOOP_1_mul_mut, COMP_LOOP_1_acc_5_mut_mx0w7, COMP_LOOP_1_acc_5_mut,
          COMP_LOOP_1_acc_8_itm, COMP_LOOP_2_modExp_1_while_mul_mut, COMP_LOOP_2_modExp_1_while_if_mul_itm,
          COMP_LOOP_2_mul_mut, STD_LOGIC_VECTOR'( modulo_result_or_nl & and_96_nl
          & and_98_nl & and_102_nl & and_105_nl & and_106_nl & and_dcpl_97 & nor_168_nl
          & mux_97_nl & and_122_nl & and_123_nl & and_126_nl));
      modulo_result_rem_cmp_b <= p_sva;
      operator_66_true_div_cmp_a <= MUX_v_65_2_2(z_out, (operator_64_false_acc_mut_64
          & operator_64_false_acc_mut_63_0), and_dcpl_112);
      operator_66_true_div_cmp_b_9_0 <= MUX_v_10_2_2(STAGE_LOOP_lshift_psp_sva_mx0w0,
          STAGE_LOOP_lshift_psp_sva, and_dcpl_112);
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (MUX_s_1_2_2(nor_113_nl, or_tmp_122, fsm_output(8))) = '1' ) THEN
        STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (mux_221_nl AND (NOT (fsm_output(8)))) = '1' ) THEN
        operator_64_false_acc_mut_64 <= operator_64_false_mux1h_1_rgt(64);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (mux_224_nl AND nor_215_cse) = '1' ) THEN
        operator_64_false_acc_mut_63_0 <= operator_64_false_mux1h_1_rgt(63 DOWNTO
            0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        VEC_LOOP_j_sva_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (and_dcpl_116 OR VEC_LOOP_j_sva_11_0_mx0c1) = '1' ) THEN
        VEC_LOOP_j_sva_11_0 <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"), (z_out_3(11
            DOWNTO 0)), VEC_LOOP_j_sva_11_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_k_9_1_sva_7_0 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (MUX_s_1_2_2(mux_226_nl, nor_210_nl, fsm_output(8))) = '1' ) THEN
        COMP_LOOP_k_9_1_sva_7_0 <= MUX_v_8_2_2(STD_LOGIC_VECTOR'("00000000"), (z_out_1(7
            DOWNTO 0)), nand_50_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((modExp_while_and_3 OR modExp_while_and_5 OR modExp_result_sva_mx0c0
          OR mux_127_nl) AND (modExp_result_sva_mx0c0 OR modExp_result_and_rgt OR
          modExp_result_and_1_rgt)) = '1' ) THEN
        modExp_result_sva <= MUX1HOT_v_64_3_2(STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000001"),
            modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w1, STD_LOGIC_VECTOR'( modExp_result_sva_mx0c0
            & modExp_result_and_rgt & modExp_result_and_1_rgt));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (mux_141_nl OR (fsm_output(8))) = '1' ) THEN
        COMP_LOOP_1_acc_5_mut <= MUX1HOT_v_64_7_2(r_sva, modulo_result_rem_cmp_z,
            modulo_qr_sva_1_mx0w1, modExp_result_sva, vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d,
            COMP_LOOP_1_acc_5_mut_mx0w7, STD_LOGIC_VECTOR'( and_142_nl & COMP_LOOP_or_7_nl
            & COMP_LOOP_or_8_nl & and_dcpl_132 & and_154_nl & and_157_nl & and_dcpl_97));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_1_acc_8_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (NOT((NOT(modExp_while_and_3 OR modExp_while_and_5 OR and_dcpl_116
          OR and_dcpl_132 OR and_dcpl_97)) OR mux_156_nl)) = '1' ) THEN
        COMP_LOOP_1_acc_8_itm <= MUX1HOT_v_64_5_2(('0' & operator_64_false_slc_modExp_exp_63_1_3),
            STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000001"),
            modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w1, (z_out(63 DOWNTO 0)),
            STD_LOGIC_VECTOR'( and_dcpl_116 & and_dcpl_132 & COMP_LOOP_and_nl & COMP_LOOP_and_1_nl
            & and_dcpl_97));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(mux_178_nl AND and_dcpl_32)) = '1' ) THEN
        modExp_while_if_mul_mut <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exit_COMP_LOOP_1_modExp_1_while_sva <= '0';
      ELSIF ( (and_dcpl_79 OR and_dcpl_159 OR and_dcpl_68) = '1' ) THEN
        exit_COMP_LOOP_1_modExp_1_while_sva <= MUX1HOT_s_1_3_2((NOT (z_out_1(63))),
            (NOT z_out_4_8), (NOT (COMP_LOOP_1_acc_nl(9))), STD_LOGIC_VECTOR'( and_dcpl_79
            & and_dcpl_159 & and_dcpl_68));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(or_tmp_184 OR or_142_cse OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
          OR or_dcpl_31)) = '1' ) THEN
        modExp_while_mul_itm <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(or_dcpl_41 OR CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
          OR or_dcpl_38)) = '1' ) THEN
        COMP_LOOP_acc_psp_sva <= COMP_LOOP_acc_psp_sva_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (and_dcpl_47 OR and_dcpl_52 OR and_dcpl_102) = '1' ) THEN
        COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm <= MUX1HOT_s_1_3_2((z_out_3(9)),
            (z_out_1(9)), z_out_4_8, STD_LOGIC_VECTOR'( and_dcpl_47 & and_dcpl_52
            & and_dcpl_102));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (mux_183_nl OR (fsm_output(8))) = '1' ) THEN
        COMP_LOOP_acc_1_cse_sva <= z_out_1(11 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_5_1_sva_1 <= '0';
      ELSIF ( and_dcpl_164 = '0' ) THEN
        modExp_exp_1_5_1_sva_1 <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0(5)), modExp_exp_1_7_1_sva,
            (COMP_LOOP_k_9_1_sva_7_0(6)), STD_LOGIC_VECTOR'( and_dcpl_154 & and_dcpl_163
            & and_dcpl_166));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_0_1_sva_1 <= '0';
      ELSIF ( (mux_192_nl OR (fsm_output(8))) = '1' ) THEN
        modExp_exp_1_0_1_sva_1 <= MUX_s_1_2_2((COMP_LOOP_k_9_1_sva_7_0(0)), modExp_exp_1_1_1_sva,
            and_194_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_5_1_sva <= '0';
      ELSIF ( and_dcpl_164 = '0' ) THEN
        modExp_exp_1_5_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0(4)), modExp_exp_1_5_1_sva_1,
            (COMP_LOOP_k_9_1_sva_7_0(5)), STD_LOGIC_VECTOR'( and_dcpl_154 & and_dcpl_163
            & and_dcpl_166));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_4_1_sva <= '0';
      ELSIF ( and_dcpl_164 = '0' ) THEN
        modExp_exp_1_4_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0(3)), modExp_exp_1_5_1_sva,
            (COMP_LOOP_k_9_1_sva_7_0(4)), STD_LOGIC_VECTOR'( and_dcpl_154 & and_dcpl_163
            & and_dcpl_166));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_3_1_sva <= '0';
      ELSIF ( and_dcpl_164 = '0' ) THEN
        modExp_exp_1_3_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0(2)), modExp_exp_1_4_1_sva,
            (COMP_LOOP_k_9_1_sva_7_0(3)), STD_LOGIC_VECTOR'( and_dcpl_154 & and_dcpl_163
            & and_dcpl_166));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_2_1_sva <= '0';
      ELSIF ( and_dcpl_164 = '0' ) THEN
        modExp_exp_1_2_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0(1)), modExp_exp_1_3_1_sva,
            (COMP_LOOP_k_9_1_sva_7_0(2)), STD_LOGIC_VECTOR'( and_dcpl_154 & and_dcpl_163
            & and_dcpl_166));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT((NOT mux_206_nl) AND and_dcpl_30)) = '1' ) THEN
        COMP_LOOP_1_modExp_1_while_if_mul_mut <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("110")) OR
          or_dcpl_48 OR or_dcpl_38)) = '1' ) THEN
        COMP_LOOP_1_modExp_1_while_mul_itm <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_10_cse_12_1_1_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( COMP_LOOP_or_2_cse = '1' ) THEN
        COMP_LOOP_acc_10_cse_12_1_1_sva <= z_out_3(12 DOWNTO 1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(or_dcpl_59 OR or_dcpl_48 OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("11"))
          OR or_dcpl_31)) = '1' ) THEN
        COMP_LOOP_1_mul_mut <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(or_dcpl_59 OR CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
          OR or_dcpl_37 OR or_dcpl_62)) = '1' ) THEN
        COMP_LOOP_2_modExp_1_while_mul_mut <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(mux_208_nl AND and_dcpl)) = '1' ) THEN
        COMP_LOOP_2_modExp_1_while_if_mul_itm <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(or_dcpl_41 OR or_142_cse OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
          OR or_dcpl_62)) = '1' ) THEN
        COMP_LOOP_2_mul_mut <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  nor_121_nl <= NOT((NOT (fsm_output(5))) OR (fsm_output(0)) OR (NOT (fsm_output(4)))
      OR (NOT (fsm_output(3))) OR (fsm_output(2)));
  nor_122_nl <= NOT((NOT (fsm_output(5))) OR (NOT (fsm_output(0))) OR (fsm_output(4))
      OR (fsm_output(3)) OR (NOT (fsm_output(2))));
  mux_79_nl <= MUX_s_1_2_2(nor_121_nl, nor_122_nl, fsm_output(6));
  nor_123_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(5)) OR (fsm_output(0)) OR
      (NOT (fsm_output(4))) OR (fsm_output(3)) OR (NOT (fsm_output(2))));
  mux_80_nl <= MUX_s_1_2_2(mux_79_nl, nor_123_nl, fsm_output(7));
  modulo_result_or_nl <= and_dcpl_79 OR (mux_80_nl AND and_dcpl_86) OR and_dcpl_102;
  and_96_nl <= or_dcpl_22 AND (NOT (fsm_output(5))) AND and_dcpl_81;
  and_98_nl <= or_dcpl_24 AND and_dcpl_46;
  or_133_nl <= (fsm_output(5)) OR mux_tmp_81;
  mux_83_nl <= MUX_s_1_2_2(not_tmp_93, or_133_nl, fsm_output(6));
  and_102_nl <= (NOT mux_83_nl) AND and_dcpl_30;
  nor_120_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 1)/=STD_LOGIC_VECTOR'("0000")));
  mux_84_nl <= MUX_s_1_2_2(mux_tmp_81, nor_120_nl, fsm_output(5));
  and_105_nl <= mux_84_nl AND CONV_SL_1_1(fsm_output(8 DOWNTO 6)=STD_LOGIC_VECTOR'("001"));
  mux_85_nl <= MUX_s_1_2_2(and_dcpl_34, (fsm_output(3)), fsm_output(4));
  mux_87_nl <= MUX_s_1_2_2(mux_tmp_86, mux_85_nl, fsm_output(1));
  and_106_nl <= (NOT mux_87_nl) AND and_dcpl_49;
  mux_92_nl <= MUX_s_1_2_2(nor_tmp_28, nor_tmp_20, and_254_cse);
  nand_42_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")) AND
      mux_92_nl);
  or_360_nl <= (fsm_output(5)) OR mux_tmp_90;
  mux_89_nl <= MUX_s_1_2_2(or_dcpl_22, (NOT mux_tmp_86), fsm_output(1));
  nand_43_nl <= NOT((fsm_output(5)) AND mux_89_nl);
  mux_91_nl <= MUX_s_1_2_2(or_360_nl, nand_43_nl, fsm_output(6));
  mux_93_nl <= MUX_s_1_2_2(nand_42_nl, mux_91_nl, fsm_output(7));
  nor_168_nl <= NOT(mux_93_nl OR (fsm_output(8)));
  nor_115_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("000")));
  mux_95_nl <= MUX_s_1_2_2(mux_tmp_90, nor_115_nl, fsm_output(5));
  and_251_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 1)=STD_LOGIC_VECTOR'("11111"));
  mux_96_nl <= MUX_s_1_2_2(mux_95_nl, and_251_nl, fsm_output(6));
  and_250_nl <= (fsm_output(7)) AND mux_96_nl;
  mux_94_nl <= MUX_s_1_2_2(and_cse, (fsm_output(4)), and_254_cse);
  nor_116_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000"))
      OR mux_94_nl);
  mux_97_nl <= MUX_s_1_2_2(and_250_nl, nor_116_nl, fsm_output(8));
  and_122_nl <= (NOT mux_tmp_86) AND CONV_SL_1_1(fsm_output(8 DOWNTO 5)=STD_LOGIC_VECTOR'("0101"));
  and_249_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 2)=STD_LOGIC_VECTOR'("1111"));
  mux_98_nl <= MUX_s_1_2_2(and_cse, (fsm_output(4)), or_142_cse);
  nor_114_nl <= NOT((fsm_output(5)) OR mux_98_nl);
  mux_99_nl <= MUX_s_1_2_2(and_249_nl, nor_114_nl, fsm_output(6));
  and_123_nl <= mux_99_nl AND and_dcpl;
  mux_101_nl <= MUX_s_1_2_2(or_dcpl_24, mux_tmp_100, fsm_output(5));
  and_126_nl <= (NOT mux_101_nl) AND CONV_SL_1_1(fsm_output(8 DOWNTO 6)=STD_LOGIC_VECTOR'("011"));
  COMP_LOOP_and_5_nl <= (NOT and_dcpl_122) AND and_dcpl_116;
  mux_165_nl <= MUX_s_1_2_2((NOT or_tmp_37), (fsm_output(7)), or_342_cse);
  mux_166_nl <= MUX_s_1_2_2((NOT (fsm_output(6))), mux_165_nl, fsm_output(4));
  or_219_nl <= (NOT (fsm_output(2))) OR (NOT (fsm_output(7))) OR (fsm_output(6));
  mux_163_nl <= MUX_s_1_2_2(or_221_cse, or_219_nl, and_254_cse);
  mux_164_nl <= MUX_s_1_2_2(mux_163_nl, or_tmp_37, fsm_output(4));
  mux_167_nl <= MUX_s_1_2_2(mux_166_nl, mux_164_nl, fsm_output(5));
  or_218_nl <= (NOT((NOT (fsm_output(2))) OR (fsm_output(7)))) OR (fsm_output(6));
  or_216_nl <= (NOT (fsm_output(2))) OR (fsm_output(7));
  mux_158_nl <= MUX_s_1_2_2((NOT (fsm_output(6))), (fsm_output(6)), or_216_nl);
  mux_159_nl <= MUX_s_1_2_2(mux_158_nl, or_tmp_37, fsm_output(1));
  mux_160_nl <= MUX_s_1_2_2(or_218_nl, mux_159_nl, fsm_output(0));
  mux_161_nl <= MUX_s_1_2_2((NOT mux_160_nl), (fsm_output(7)), fsm_output(4));
  or_47_nl <= nor_110_cse OR (fsm_output(6));
  mux_162_nl <= MUX_s_1_2_2(mux_161_nl, or_47_nl, fsm_output(5));
  mux_168_nl <= MUX_s_1_2_2(mux_167_nl, mux_162_nl, fsm_output(3));
  COMP_LOOP_mux1h_16_nl <= MUX1HOT_s_1_4_2((operator_66_true_div_cmp_z(0)), (COMP_LOOP_1_acc_8_itm(0)),
      modExp_exp_1_0_1_sva_1, modExp_exp_1_0_1_sva, STD_LOGIC_VECTOR'( COMP_LOOP_and_5_nl
      & and_dcpl_122 & and_dcpl_152 & (NOT mux_168_nl)));
  or_230_nl <= ((fsm_output(1)) AND (fsm_output(7))) OR (fsm_output(4));
  and_242_nl <= (fsm_output(0)) AND (fsm_output(2));
  mux_173_nl <= MUX_s_1_2_2(and_217_cse, or_230_nl, and_242_nl);
  mux_174_nl <= MUX_s_1_2_2(or_tmp_201, (NOT mux_173_nl), fsm_output(5));
  mux_171_nl <= MUX_s_1_2_2(or_tmp_201, (fsm_output(7)), or_292_cse);
  mux_172_nl <= MUX_s_1_2_2(mux_171_nl, nor_110_cse, fsm_output(5));
  mux_175_nl <= MUX_s_1_2_2(mux_174_nl, mux_172_nl, fsm_output(3));
  and_230_nl <= or_292_cse AND (fsm_output(7)) AND (fsm_output(4));
  or_225_nl <= (fsm_output(2)) OR and_254_cse OR (fsm_output(7)) OR (fsm_output(4));
  mux_169_nl <= MUX_s_1_2_2(and_230_nl, or_225_nl, fsm_output(5));
  or_223_nl <= (fsm_output(5)) OR and_217_cse;
  mux_170_nl <= MUX_s_1_2_2(mux_169_nl, or_223_nl, fsm_output(3));
  mux_176_nl <= MUX_s_1_2_2(mux_175_nl, mux_170_nl, fsm_output(6));
  COMP_LOOP_mux1h_26_nl <= MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0(6)), modExp_exp_1_1_1_sva,
      modExp_exp_1_7_1_sva, (COMP_LOOP_k_9_1_sva_7_0(7)), STD_LOGIC_VECTOR'( and_dcpl_154
      & and_dcpl_159 & and_dcpl_164 & and_dcpl_166));
  nand_46_nl <= NOT((NOT(or_327_cse AND (fsm_output(7)))) AND (fsm_output(6)));
  mux_198_nl <= MUX_s_1_2_2((NOT (fsm_output(6))), nand_46_nl, fsm_output(4));
  nand_9_nl <= NOT((fsm_output(2)) AND (fsm_output(0)) AND (fsm_output(7)) AND (NOT
      (fsm_output(6))));
  mux_195_nl <= MUX_s_1_2_2(or_221_cse, nand_9_nl, fsm_output(1));
  mux_196_nl <= MUX_s_1_2_2(mux_195_nl, or_tmp_37, fsm_output(3));
  or_282_nl <= (NOT((fsm_output(1)) OR (fsm_output(2)) OR (fsm_output(0)) OR (fsm_output(7))))
      OR (fsm_output(6));
  mux_194_nl <= MUX_s_1_2_2(or_tmp_37, or_282_nl, fsm_output(3));
  mux_197_nl <= MUX_s_1_2_2(mux_196_nl, mux_194_nl, fsm_output(4));
  mux_199_nl <= MUX_s_1_2_2(mux_198_nl, mux_197_nl, fsm_output(5));
  nor_160_nl <= NOT(mux_199_nl OR (fsm_output(8)));
  COMP_LOOP_mux1h_40_nl <= MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0(7)), modExp_exp_1_2_1_sva,
      modExp_exp_1_1_1_sva, (COMP_LOOP_k_9_1_sva_7_0(1)), STD_LOGIC_VECTOR'( and_dcpl_154
      & and_dcpl_163 & nor_160_nl & and_dcpl_166));
  nor_113_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 1)/=STD_LOGIC_VECTOR'("0000000")));
  or_388_nl <= (NOT (fsm_output(1))) OR (NOT (fsm_output(3))) OR (fsm_output(7));
  or_387_nl <= (fsm_output(1)) OR (fsm_output(3)) OR (fsm_output(7));
  mux_219_nl <= MUX_s_1_2_2(or_388_nl, or_387_nl, fsm_output(0));
  nor_216_nl <= NOT((fsm_output(2)) OR (fsm_output(4)) OR mux_219_nl);
  and_400_nl <= ((fsm_output(1)) OR (fsm_output(3))) AND (fsm_output(7));
  or_384_nl <= (fsm_output(0)) OR (fsm_output(3)) OR (fsm_output(7));
  mux_217_nl <= MUX_s_1_2_2(and_400_nl, or_384_nl, fsm_output(4));
  mux_218_nl <= MUX_s_1_2_2(mux_tmp, mux_217_nl, fsm_output(2));
  mux_220_nl <= MUX_s_1_2_2(nor_216_nl, mux_218_nl, fsm_output(5));
  and_401_nl <= or_142_cse AND (fsm_output(3)) AND (fsm_output(7));
  or_382_nl <= ((fsm_output(1)) AND (fsm_output(3))) OR (fsm_output(7));
  mux_215_nl <= MUX_s_1_2_2(and_401_nl, or_382_nl, fsm_output(4));
  mux_216_nl <= MUX_s_1_2_2(mux_215_nl, mux_tmp, fsm_output(2));
  nand_53_nl <= NOT((fsm_output(5)) AND mux_216_nl);
  mux_221_nl <= MUX_s_1_2_2(mux_220_nl, nand_53_nl, fsm_output(6));
  nor_211_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(0))) OR (fsm_output(2)) OR
      (fsm_output(7)));
  nor_212_nl <= NOT((NOT (fsm_output(3))) OR (fsm_output(0)) OR (fsm_output(2)) OR
      (fsm_output(7)));
  mux_222_nl <= MUX_s_1_2_2(nor_211_nl, nor_212_nl, fsm_output(1));
  nor_213_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(3)) OR (fsm_output(0)) OR
      (NOT((fsm_output(2)) AND (fsm_output(7)))));
  mux_223_nl <= MUX_s_1_2_2(mux_222_nl, nor_213_nl, fsm_output(5));
  nor_214_nl <= NOT((NOT (fsm_output(5))) OR (fsm_output(3)) OR (NOT (fsm_output(0)))
      OR (NOT (fsm_output(2))) OR (fsm_output(7)));
  mux_224_nl <= MUX_s_1_2_2(mux_223_nl, nor_214_nl, fsm_output(4));
  or_165_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 0)/=STD_LOGIC_VECTOR'("010101"));
  mux_118_nl <= MUX_s_1_2_2(mux_tmp_104, or_165_nl, fsm_output(8));
  nand_50_nl <= NOT((NOT mux_118_nl) AND and_dcpl_80);
  or_400_nl <= (fsm_output(7)) OR (fsm_output(4)) OR (NOT (fsm_output(3)));
  or_398_nl <= (NOT (fsm_output(7))) OR (NOT (fsm_output(4))) OR (fsm_output(3));
  mux_225_nl <= MUX_s_1_2_2(or_400_nl, or_398_nl, fsm_output(6));
  nor_208_nl <= NOT(CONV_SL_1_1(fsm_output(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR mux_225_nl);
  nor_209_nl <= NOT((NOT (fsm_output(0))) OR (fsm_output(1)) OR (NOT (fsm_output(2)))
      OR (fsm_output(6)) OR (fsm_output(7)) OR (NOT (fsm_output(4))) OR (fsm_output(3)));
  mux_226_nl <= MUX_s_1_2_2(nor_208_nl, nor_209_nl, fsm_output(5));
  nor_210_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 0)/=STD_LOGIC_VECTOR'("00010101")));
  or_180_nl <= (fsm_output(2)) OR and_254_cse OR CONV_SL_1_1(fsm_output(7 DOWNTO
      6)/=STD_LOGIC_VECTOR'("00"));
  mux_125_nl <= MUX_s_1_2_2(or_tmp_35, or_180_nl, fsm_output(3));
  or_336_nl <= (fsm_output(4)) OR mux_125_nl;
  or_337_nl <= (fsm_output(4)) OR (fsm_output(3)) OR (fsm_output(2)) OR (fsm_output(0))
      OR (fsm_output(1)) OR (fsm_output(6)) OR (fsm_output(7));
  mux_126_nl <= MUX_s_1_2_2(or_336_nl, or_337_nl, fsm_output(5));
  or_175_nl <= (fsm_output(3)) OR and_270_cse OR CONV_SL_1_1(fsm_output(7 DOWNTO
      6)/=STD_LOGIC_VECTOR'("00"));
  mux_124_nl <= MUX_s_1_2_2(or_tmp_35, or_175_nl, fsm_output(4));
  nor_106_nl <= NOT((fsm_output(5)) OR mux_124_nl);
  mux_127_nl <= MUX_s_1_2_2(mux_126_nl, nor_106_nl, fsm_output(8));
  and_142_nl <= and_dcpl_77 AND and_dcpl_40 AND and_dcpl_32;
  COMP_LOOP_or_7_nl <= ((NOT (modulo_result_rem_cmp_z(63))) AND and_145_m1c) OR (and_dcpl_144
      AND and_dcpl_142 AND (NOT (fsm_output(8))) AND (NOT (modulo_result_rem_cmp_z(63))));
  COMP_LOOP_or_8_nl <= ((modulo_result_rem_cmp_z(63)) AND and_145_m1c) OR (and_dcpl_144
      AND and_dcpl_142 AND (NOT (fsm_output(8))) AND (modulo_result_rem_cmp_z(63)));
  and_154_nl <= not_tmp_132 AND and_dcpl_134 AND (NOT (fsm_output(8))) AND (NOT (COMP_LOOP_acc_10_cse_12_1_1_sva(0)));
  and_157_nl <= not_tmp_132 AND and_dcpl_134 AND (NOT (fsm_output(8))) AND (COMP_LOOP_acc_10_cse_12_1_1_sva(0));
  or_197_nl <= (NOT (fsm_output(6))) OR (fsm_output(2)) OR (fsm_output(1)) OR (NOT
      (fsm_output(7)));
  mux_139_nl <= MUX_s_1_2_2((NOT (fsm_output(7))), or_197_nl, fsm_output(4));
  or_70_nl <= (fsm_output(1)) OR (NOT (fsm_output(7)));
  mux_46_nl <= MUX_s_1_2_2(not_tmp_45, or_70_nl, fsm_output(2));
  mux_47_nl <= MUX_s_1_2_2(mux_46_nl, (NOT (fsm_output(7))), fsm_output(6));
  or_71_nl <= (fsm_output(4)) OR mux_47_nl;
  mux_140_nl <= MUX_s_1_2_2(mux_139_nl, or_71_nl, fsm_output(3));
  or_333_nl <= (fsm_output(6)) OR (NOT((fsm_output(2)) AND (fsm_output(0)) AND (fsm_output(1))
      AND (fsm_output(7))));
  nand_29_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)=STD_LOGIC_VECTOR'("11")));
  mux_135_nl <= MUX_s_1_2_2(or_333_nl, nand_29_nl, fsm_output(4));
  nand_30_nl <= NOT((fsm_output(6)) AND or_292_cse AND (fsm_output(7)));
  nor_144_nl <= NOT((fsm_output(0)) OR (fsm_output(1)) OR (fsm_output(7)));
  mux_43_nl <= MUX_s_1_2_2(nor_144_nl, nor_tmp_11, fsm_output(2));
  mux_42_nl <= MUX_s_1_2_2(not_tmp_45, nor_tmp_11, fsm_output(2));
  mux_44_nl <= MUX_s_1_2_2((NOT mux_43_nl), mux_42_nl, fsm_output(6));
  mux_45_nl <= MUX_s_1_2_2(nand_30_nl, mux_44_nl, fsm_output(4));
  mux_136_nl <= MUX_s_1_2_2(mux_135_nl, mux_45_nl, fsm_output(3));
  mux_141_nl <= MUX_s_1_2_2(mux_140_nl, mux_136_nl, fsm_output(5));
  COMP_LOOP_and_nl <= (NOT modExp_while_and_5) AND and_dcpl_152;
  COMP_LOOP_and_1_nl <= modExp_while_and_5 AND and_dcpl_152;
  mux_152_nl <= MUX_s_1_2_2((NOT (fsm_output(5))), and_tmp_19, fsm_output(4));
  nor_96_nl <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00")) OR
      or_tmp_177);
  mux_153_nl <= MUX_s_1_2_2(mux_152_nl, nor_96_nl, fsm_output(3));
  mux_150_nl <= MUX_s_1_2_2(and_tmp_19, (fsm_output(5)), fsm_output(4));
  or_331_nl <= (fsm_output(5)) OR (NOT(CONV_SL_1_1(fsm_output(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))));
  and_234_nl <= (fsm_output(5)) AND (NOT or_tmp_177);
  mux_149_nl <= MUX_s_1_2_2(or_331_nl, and_234_nl, fsm_output(4));
  mux_151_nl <= MUX_s_1_2_2(mux_150_nl, mux_149_nl, fsm_output(3));
  mux_154_nl <= MUX_s_1_2_2(mux_153_nl, mux_151_nl, fsm_output(6));
  mux_147_nl <= MUX_s_1_2_2((fsm_output(2)), (NOT (fsm_output(2))), and_254_cse);
  nand_5_nl <= NOT((NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 3)/=STD_LOGIC_VECTOR'("100"))))
      AND mux_147_nl);
  or_204_nl <= (fsm_output(5)) OR (NOT((NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))))
      OR (fsm_output(2))));
  mux_145_nl <= MUX_s_1_2_2((NOT (fsm_output(5))), or_204_nl, fsm_output(4));
  or_202_nl <= (NOT (fsm_output(5))) OR (fsm_output(1)) OR (fsm_output(2));
  mux_144_nl <= MUX_s_1_2_2(or_202_nl, (fsm_output(5)), fsm_output(4));
  mux_146_nl <= MUX_s_1_2_2(mux_145_nl, mux_144_nl, fsm_output(3));
  mux_148_nl <= MUX_s_1_2_2(nand_5_nl, mux_146_nl, fsm_output(6));
  mux_155_nl <= MUX_s_1_2_2((NOT mux_154_nl), mux_148_nl, fsm_output(7));
  or_200_nl <= (fsm_output(5)) OR (fsm_output(1)) OR (fsm_output(2));
  mux_142_nl <= MUX_s_1_2_2((fsm_output(5)), or_200_nl, fsm_output(4));
  or_199_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00"));
  mux_143_nl <= MUX_s_1_2_2(mux_142_nl, or_199_nl, fsm_output(3));
  nor_99_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00")) OR
      mux_143_nl);
  mux_156_nl <= MUX_s_1_2_2(mux_155_nl, nor_99_nl, fsm_output(8));
  mux_177_nl <= MUX_s_1_2_2(and_dcpl_55, (NOT and_dcpl_55), fsm_output(4));
  mux_178_nl <= MUX_s_1_2_2(or_dcpl_22, mux_177_nl, and_254_cse);
  COMP_LOOP_1_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED((z_out_1(8 DOWNTO 0))
      & '0') + SIGNED('1' & (NOT (STAGE_LOOP_lshift_psp_sva(9 DOWNTO 1)))) + SIGNED'(
      "0000000001"), 10));
  nor_164_nl <= NOT((fsm_output(6)) OR ((fsm_output(5)) AND mux_tmp_62));
  and_281_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 1)=STD_LOGIC_VECTOR'("111111"));
  mux_183_nl <= MUX_s_1_2_2(nor_164_nl, and_281_nl, fsm_output(7));
  nor_86_nl <= NOT((NOT (fsm_output(5))) OR (fsm_output(0)) OR (NOT (fsm_output(1)))
      OR (fsm_output(4)));
  nor_87_nl <= NOT((fsm_output(5)) OR (NOT (fsm_output(0))) OR (fsm_output(1)) OR
      (NOT (fsm_output(4))));
  mux_193_nl <= MUX_s_1_2_2(nor_86_nl, nor_87_nl, fsm_output(7));
  and_194_nl <= mux_193_nl AND and_dcpl_34 AND and_dcpl_93;
  or_277_nl <= (fsm_output(4)) OR (or_142_cse AND (fsm_output(2)));
  mux_190_nl <= MUX_s_1_2_2((fsm_output(4)), or_277_nl, fsm_output(3));
  and_191_nl <= (fsm_output(4)) AND or_342_cse;
  mux_189_nl <= MUX_s_1_2_2(and_191_nl, (fsm_output(4)), fsm_output(3));
  mux_191_nl <= MUX_s_1_2_2(mux_190_nl, mux_189_nl, fsm_output(7));
  nand_40_nl <= NOT((fsm_output(6)) AND (NOT mux_191_nl));
  nand_10_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11")));
  nor_89_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00")) OR
      and_216_cse);
  mux_188_nl <= MUX_s_1_2_2(nand_10_nl, nor_89_nl, fsm_output(7));
  or_358_nl <= (fsm_output(6)) OR mux_188_nl;
  mux_192_nl <= MUX_s_1_2_2(nand_40_nl, or_358_nl, fsm_output(5));
  or_297_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00")) OR and_dcpl_55;
  mux_206_nl <= MUX_s_1_2_2(not_tmp_93, or_297_nl, fsm_output(6));
  and_213_nl <= (fsm_output(5)) AND mux_tmp_100;
  nor_81_nl <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00")));
  mux_208_nl <= MUX_s_1_2_2(and_213_nl, nor_81_nl, fsm_output(6));
  COMP_LOOP_mux_13_nl <= MUX_v_64_2_2(operator_64_false_acc_mut_63_0, p_sva, and_dcpl_197);
  nor_217_nl <= NOT((NOT (fsm_output(1))) OR (NOT (fsm_output(4))) OR (fsm_output(7)));
  nor_218_nl <= NOT((fsm_output(1)) OR (fsm_output(4)) OR (NOT (fsm_output(7))));
  mux_229_nl <= MUX_s_1_2_2(nor_217_nl, nor_218_nl, fsm_output(0));
  COMP_LOOP_COMP_LOOP_nand_2_nl <= NOT(and_dcpl_197 AND (NOT(mux_229_nl AND (fsm_output(6))
      AND (NOT (fsm_output(2))) AND (fsm_output(3)) AND (fsm_output(5)) AND (NOT
      (fsm_output(8))))));
  COMP_LOOP_not_50_nl <= NOT and_dcpl_197;
  COMP_LOOP_COMP_LOOP_nand_3_nl <= NOT(MUX_v_64_2_2(STD_LOGIC_VECTOR'("0000000000000000000000000000000000000000000000000000000000000000"),
      vec_rsc_0_0_i_da_d_1, COMP_LOOP_not_50_nl));
  acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux_13_nl
      & COMP_LOOP_COMP_LOOP_nand_2_nl), 65), 66) + CONV_UNSIGNED(CONV_SIGNED(SIGNED(COMP_LOOP_COMP_LOOP_nand_3_nl
      & '1'), 65), 66), 66));
  z_out <= acc_nl(65 DOWNTO 1);
  COMP_LOOP_mux1h_71_nl <= MUX1HOT_v_65_5_2((STD_LOGIC_VECTOR'( "00000000000000000000000000000000000000000000000000000001")
      & (NOT (STAGE_LOOP_lshift_psp_sva(9 DOWNTO 1)))), (STD_LOGIC_VECTOR'( "00000000000000000000000000000000000000000000000000000")
      & VEC_LOOP_j_sva_11_0), (STD_LOGIC_VECTOR'( "11") & (NOT (operator_64_false_acc_mut_63_0(62
      DOWNTO 0)))), (STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000000")
      & COMP_LOOP_k_9_1_sva_7_0), ('1' & (NOT (operator_66_true_div_cmp_z(63 DOWNTO
      0)))), STD_LOGIC_VECTOR'( and_dcpl_205 & and_dcpl_212 & and_dcpl_217 & and_320_cse
      & and_dcpl_226));
  COMP_LOOP_or_17_nl <= (NOT(and_dcpl_212 OR and_dcpl_217 OR and_320_cse OR and_dcpl_226))
      OR and_dcpl_205;
  COMP_LOOP_nor_4_nl <= NOT(and_dcpl_217 OR and_320_cse OR and_dcpl_226);
  COMP_LOOP_COMP_LOOP_and_1_nl <= MUX_v_8_2_2(STD_LOGIC_VECTOR'("00000000"), COMP_LOOP_k_9_1_sva_7_0,
      COMP_LOOP_nor_4_nl);
  acc_1_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux1h_71_nl & COMP_LOOP_or_17_nl)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_and_1_nl & STD_LOGIC_VECTOR'(
      "11")), 10), 66), 66));
  z_out_1 <= acc_1_nl(65 DOWNTO 1);
  operator_64_false_1_or_3_nl <= and_dcpl_256 OR and_320_cse OR and_dcpl_269;
  operator_64_false_1_mux_11_nl <= MUX_v_12_2_2((STD_LOGIC_VECTOR'( "111") & (NOT
      COMP_LOOP_k_9_1_sva_7_0) & '1'), VEC_LOOP_j_sva_11_0, operator_64_false_1_or_3_nl);
  and_405_nl <= and_dcpl_34 AND (fsm_output(4)) AND (fsm_output(1)) AND (fsm_output(7))
      AND (fsm_output(6)) AND (NOT (fsm_output(5))) AND (NOT (fsm_output(8))) AND
      (NOT (fsm_output(0)));
  COMP_LOOP_acc_13_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_1_sva_7_0 & and_405_nl),
      9), 10), 10));
  and_406_nl <= and_dcpl_247 AND and_dcpl_201 AND CONV_SL_1_1(fsm_output(6 DOWNTO
      5)=STD_LOGIC_VECTOR'("01")) AND and_dcpl_206;
  operator_64_false_1_or_4_nl <= and_dcpl_256 OR and_320_cse;
  operator_64_false_1_mux1h_2_nl <= MUX1HOT_v_10_3_2(STD_LOGIC_VECTOR'( "0000000001"),
      STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_acc_13_nl), 10)), STAGE_LOOP_lshift_psp_sva,
      STD_LOGIC_VECTOR'( and_406_nl & operator_64_false_1_or_4_nl & and_dcpl_269));
  z_out_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(operator_64_false_1_mux_11_nl),
      13) + CONV_UNSIGNED(UNSIGNED(operator_64_false_1_mux1h_2_nl), 13), 13));
  operator_64_false_1_mux_12_nl <= MUX_s_1_2_2((NOT modExp_exp_1_7_1_sva), (NOT modExp_exp_1_1_1_sva),
      and_dcpl_284);
  operator_64_false_1_mux_13_nl <= MUX_s_1_2_2((NOT modExp_exp_1_5_1_sva_1), (NOT
      modExp_exp_1_7_1_sva), and_dcpl_284);
  operator_64_false_1_mux_14_nl <= MUX_s_1_2_2((NOT modExp_exp_1_5_1_sva), (NOT modExp_exp_1_5_1_sva_1),
      and_dcpl_284);
  operator_64_false_1_mux_15_nl <= MUX_s_1_2_2((NOT modExp_exp_1_4_1_sva), (NOT modExp_exp_1_5_1_sva),
      and_dcpl_284);
  operator_64_false_1_mux_16_nl <= MUX_s_1_2_2((NOT modExp_exp_1_3_1_sva), (NOT modExp_exp_1_4_1_sva),
      and_dcpl_284);
  operator_64_false_1_mux_17_nl <= MUX_s_1_2_2((NOT modExp_exp_1_2_1_sva), (NOT modExp_exp_1_3_1_sva),
      and_dcpl_284);
  operator_64_false_1_mux_18_nl <= MUX_s_1_2_2((NOT modExp_exp_1_1_1_sva), (NOT modExp_exp_1_2_1_sva),
      and_dcpl_284);
  operator_64_false_1_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( '1' & operator_64_false_1_mux_12_nl
      & operator_64_false_1_mux_13_nl & operator_64_false_1_mux_14_nl & operator_64_false_1_mux_15_nl
      & operator_64_false_1_mux_16_nl & operator_64_false_1_mux_17_nl & operator_64_false_1_mux_18_nl
      & (NOT modExp_exp_1_0_1_sva_1)) + UNSIGNED'( "000000001"), 9));
  z_out_4_8 <= operator_64_false_1_acc_nl(8);
  and_407_nl <= and_dcpl_202 AND (fsm_output(3)) AND (fsm_output(1)) AND (NOT (fsm_output(7)))
      AND and_dcpl_31 AND (NOT (fsm_output(8))) AND (fsm_output(0));
  nor_221_nl <= NOT((fsm_output(5)) OR (fsm_output(7)) OR (fsm_output(1)) OR (NOT
      (fsm_output(3))) OR (NOT (fsm_output(2))) OR (fsm_output(4)));
  nor_222_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 1)/=STD_LOGIC_VECTOR'("1100")));
  nor_223_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 1)/=STD_LOGIC_VECTOR'("0011")));
  mux_231_nl <= MUX_s_1_2_2(nor_222_nl, nor_223_nl, fsm_output(7));
  and_409_nl <= (fsm_output(5)) AND mux_231_nl;
  mux_230_nl <= MUX_s_1_2_2(nor_221_nl, and_409_nl, fsm_output(0));
  and_408_nl <= mux_230_nl AND nor_215_cse;
  nor_225_nl <= NOT((NOT (fsm_output(6))) OR (NOT (fsm_output(7))) OR (fsm_output(3))
      OR nand_18_cse);
  or_404_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("110"));
  or_405_nl <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("010"));
  mux_234_nl <= MUX_s_1_2_2(or_404_nl, or_405_nl, fsm_output(7));
  nor_226_nl <= NOT((fsm_output(6)) OR mux_234_nl);
  mux_233_nl <= MUX_s_1_2_2(nor_225_nl, nor_226_nl, fsm_output(5));
  nor_227_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 2)/=STD_LOGIC_VECTOR'("011001")));
  mux_232_nl <= MUX_s_1_2_2(mux_233_nl, nor_227_nl, fsm_output(0));
  and_410_nl <= mux_232_nl AND and_dcpl_86;
  modExp_while_if_mux1h_2_nl <= MUX1HOT_v_64_3_2(modExp_result_sva, COMP_LOOP_1_acc_5_mut,
      COMP_LOOP_1_acc_8_itm, STD_LOGIC_VECTOR'( and_407_nl & and_408_nl & and_410_nl));
  z_out_5 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(SIGNED'( SIGNED(modExp_while_if_mux1h_2_nl)
      * SIGNED(COMP_LOOP_1_acc_5_mut)), 64));
END v34;

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
    vec_rsc_0_0_adra : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    vec_rsc_0_0_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_wea : OUT STD_LOGIC;
    vec_rsc_0_0_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    vec_rsc_0_1_adra : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    vec_rsc_0_1_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_wea : OUT STD_LOGIC;
    vec_rsc_0_1_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC
  );
END inPlaceNTT_DIT;

ARCHITECTURE v34 OF inPlaceNTT_DIT IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_0_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_adra_d_iff : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da_d_iff : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_wea_d_iff : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_0_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_adra : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_adra_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_1_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_adra : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_adra_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
      p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      p_rsc_triosy_lz : OUT STD_LOGIC;
      r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      r_rsc_triosy_lz : OUT STD_LOGIC;
      vec_rsc_0_0_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_1_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_0_i_adra_d_pff : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      vec_rsc_0_0_i_da_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_1_i_wea_d_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_core_inst_p_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_core_inst_r_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_1_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff : STD_LOGIC_VECTOR (10
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff : STD_LOGIC_VECTOR (63 DOWNTO
      0);

BEGIN
  vec_rsc_0_0_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
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

  vec_rsc_0_1_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
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

  inPlaceNTT_DIT_core_inst : inPlaceNTT_DIT_core
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_triosy_0_0_lz => vec_rsc_triosy_0_0_lz,
      vec_rsc_triosy_0_1_lz => vec_rsc_triosy_0_1_lz,
      p_rsc_dat => inPlaceNTT_DIT_core_inst_p_rsc_dat,
      p_rsc_triosy_lz => p_rsc_triosy_lz,
      r_rsc_dat => inPlaceNTT_DIT_core_inst_r_rsc_dat,
      r_rsc_triosy_lz => r_rsc_triosy_lz,
      vec_rsc_0_0_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_qa_d,
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_1_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_1_i_qa_d,
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_0_i_adra_d_pff => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff,
      vec_rsc_0_0_i_da_d_pff => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff,
      vec_rsc_0_0_i_wea_d_pff => vec_rsc_0_0_i_wea_d_iff,
      vec_rsc_0_1_i_wea_d_pff => vec_rsc_0_1_i_wea_d_iff
    );
  inPlaceNTT_DIT_core_inst_p_rsc_dat <= p_rsc_dat;
  inPlaceNTT_DIT_core_inst_r_rsc_dat <= r_rsc_dat;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_qa_d <= vec_rsc_0_0_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_1_i_qa_d <= vec_rsc_0_1_i_qa_d;
  vec_rsc_0_0_i_adra_d_iff <= inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff;
  vec_rsc_0_0_i_da_d_iff <= inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff;

END v34;



