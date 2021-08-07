
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
--  Generated date: Wed Jun 30 21:47:21 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_11_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_11_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_11_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_11_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_10_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_10_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_10_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_10_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_9_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_9_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_9_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_9_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_8_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_8_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_8_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_8_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_9_64_512_512_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_9_64_512_512_64_1_gen
    IS
  PORT(
    qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea : OUT STD_LOGIC;
    da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wea_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_9_64_512_512_64_1_gen;

ARCHITECTURE v41 OF inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_9_64_512_512_64_1_gen
    IS
  -- Default Constants

BEGIN
  qa_d <= qa;
  wea <= (rwA_rw_ram_ir_internal_WMASK_B_d);
  da <= (da_d);
  adra <= (adra_d);
END v41;

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
    STAGE_LOOP_C_8_tr0 : IN STD_LOGIC;
    modExp_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
    COMP_LOOP_1_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_65_tr0 : IN STD_LOGIC;
    COMP_LOOP_2_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_130_tr0 : IN STD_LOGIC;
    COMP_LOOP_3_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_195_tr0 : IN STD_LOGIC;
    COMP_LOOP_4_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_260_tr0 : IN STD_LOGIC;
    COMP_LOOP_5_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_325_tr0 : IN STD_LOGIC;
    COMP_LOOP_6_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_390_tr0 : IN STD_LOGIC;
    COMP_LOOP_7_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_455_tr0 : IN STD_LOGIC;
    COMP_LOOP_8_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
    COMP_LOOP_C_520_tr0 : IN STD_LOGIC;
    VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
    STAGE_LOOP_C_9_tr0 : IN STD_LOGIC
  );
END inPlaceNTT_DIT_core_core_fsm;

ARCHITECTURE v41 OF inPlaceNTT_DIT_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for inPlaceNTT_DIT_core_core_fsm_1
  TYPE inPlaceNTT_DIT_core_core_fsm_1_ST IS (main_C_0, STAGE_LOOP_C_0, STAGE_LOOP_C_1,
      STAGE_LOOP_C_2, STAGE_LOOP_C_3, STAGE_LOOP_C_4, STAGE_LOOP_C_5, STAGE_LOOP_C_6,
      STAGE_LOOP_C_7, STAGE_LOOP_C_8, modExp_while_C_0, modExp_while_C_1, modExp_while_C_2,
      modExp_while_C_3, modExp_while_C_4, modExp_while_C_5, modExp_while_C_6, modExp_while_C_7,
      modExp_while_C_8, modExp_while_C_9, modExp_while_C_10, modExp_while_C_11, modExp_while_C_12,
      modExp_while_C_13, modExp_while_C_14, modExp_while_C_15, modExp_while_C_16,
      modExp_while_C_17, modExp_while_C_18, modExp_while_C_19, modExp_while_C_20,
      modExp_while_C_21, modExp_while_C_22, modExp_while_C_23, modExp_while_C_24,
      modExp_while_C_25, modExp_while_C_26, modExp_while_C_27, modExp_while_C_28,
      modExp_while_C_29, modExp_while_C_30, modExp_while_C_31, modExp_while_C_32,
      modExp_while_C_33, modExp_while_C_34, modExp_while_C_35, modExp_while_C_36,
      modExp_while_C_37, modExp_while_C_38, modExp_while_C_39, modExp_while_C_40,
      COMP_LOOP_C_0, COMP_LOOP_C_1, COMP_LOOP_1_modExp_1_while_C_0, COMP_LOOP_1_modExp_1_while_C_1,
      COMP_LOOP_1_modExp_1_while_C_2, COMP_LOOP_1_modExp_1_while_C_3, COMP_LOOP_1_modExp_1_while_C_4,
      COMP_LOOP_1_modExp_1_while_C_5, COMP_LOOP_1_modExp_1_while_C_6, COMP_LOOP_1_modExp_1_while_C_7,
      COMP_LOOP_1_modExp_1_while_C_8, COMP_LOOP_1_modExp_1_while_C_9, COMP_LOOP_1_modExp_1_while_C_10,
      COMP_LOOP_1_modExp_1_while_C_11, COMP_LOOP_1_modExp_1_while_C_12, COMP_LOOP_1_modExp_1_while_C_13,
      COMP_LOOP_1_modExp_1_while_C_14, COMP_LOOP_1_modExp_1_while_C_15, COMP_LOOP_1_modExp_1_while_C_16,
      COMP_LOOP_1_modExp_1_while_C_17, COMP_LOOP_1_modExp_1_while_C_18, COMP_LOOP_1_modExp_1_while_C_19,
      COMP_LOOP_1_modExp_1_while_C_20, COMP_LOOP_1_modExp_1_while_C_21, COMP_LOOP_1_modExp_1_while_C_22,
      COMP_LOOP_1_modExp_1_while_C_23, COMP_LOOP_1_modExp_1_while_C_24, COMP_LOOP_1_modExp_1_while_C_25,
      COMP_LOOP_1_modExp_1_while_C_26, COMP_LOOP_1_modExp_1_while_C_27, COMP_LOOP_1_modExp_1_while_C_28,
      COMP_LOOP_1_modExp_1_while_C_29, COMP_LOOP_1_modExp_1_while_C_30, COMP_LOOP_1_modExp_1_while_C_31,
      COMP_LOOP_1_modExp_1_while_C_32, COMP_LOOP_1_modExp_1_while_C_33, COMP_LOOP_1_modExp_1_while_C_34,
      COMP_LOOP_1_modExp_1_while_C_35, COMP_LOOP_1_modExp_1_while_C_36, COMP_LOOP_1_modExp_1_while_C_37,
      COMP_LOOP_1_modExp_1_while_C_38, COMP_LOOP_1_modExp_1_while_C_39, COMP_LOOP_1_modExp_1_while_C_40,
      COMP_LOOP_C_2, COMP_LOOP_C_3, COMP_LOOP_C_4, COMP_LOOP_C_5, COMP_LOOP_C_6,
      COMP_LOOP_C_7, COMP_LOOP_C_8, COMP_LOOP_C_9, COMP_LOOP_C_10, COMP_LOOP_C_11,
      COMP_LOOP_C_12, COMP_LOOP_C_13, COMP_LOOP_C_14, COMP_LOOP_C_15, COMP_LOOP_C_16,
      COMP_LOOP_C_17, COMP_LOOP_C_18, COMP_LOOP_C_19, COMP_LOOP_C_20, COMP_LOOP_C_21,
      COMP_LOOP_C_22, COMP_LOOP_C_23, COMP_LOOP_C_24, COMP_LOOP_C_25, COMP_LOOP_C_26,
      COMP_LOOP_C_27, COMP_LOOP_C_28, COMP_LOOP_C_29, COMP_LOOP_C_30, COMP_LOOP_C_31,
      COMP_LOOP_C_32, COMP_LOOP_C_33, COMP_LOOP_C_34, COMP_LOOP_C_35, COMP_LOOP_C_36,
      COMP_LOOP_C_37, COMP_LOOP_C_38, COMP_LOOP_C_39, COMP_LOOP_C_40, COMP_LOOP_C_41,
      COMP_LOOP_C_42, COMP_LOOP_C_43, COMP_LOOP_C_44, COMP_LOOP_C_45, COMP_LOOP_C_46,
      COMP_LOOP_C_47, COMP_LOOP_C_48, COMP_LOOP_C_49, COMP_LOOP_C_50, COMP_LOOP_C_51,
      COMP_LOOP_C_52, COMP_LOOP_C_53, COMP_LOOP_C_54, COMP_LOOP_C_55, COMP_LOOP_C_56,
      COMP_LOOP_C_57, COMP_LOOP_C_58, COMP_LOOP_C_59, COMP_LOOP_C_60, COMP_LOOP_C_61,
      COMP_LOOP_C_62, COMP_LOOP_C_63, COMP_LOOP_C_64, COMP_LOOP_C_65, COMP_LOOP_C_66,
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
      COMP_LOOP_2_modExp_1_while_C_39, COMP_LOOP_2_modExp_1_while_C_40, COMP_LOOP_C_67,
      COMP_LOOP_C_68, COMP_LOOP_C_69, COMP_LOOP_C_70, COMP_LOOP_C_71, COMP_LOOP_C_72,
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
      COMP_LOOP_C_128, COMP_LOOP_C_129, COMP_LOOP_C_130, COMP_LOOP_C_131, COMP_LOOP_3_modExp_1_while_C_0,
      COMP_LOOP_3_modExp_1_while_C_1, COMP_LOOP_3_modExp_1_while_C_2, COMP_LOOP_3_modExp_1_while_C_3,
      COMP_LOOP_3_modExp_1_while_C_4, COMP_LOOP_3_modExp_1_while_C_5, COMP_LOOP_3_modExp_1_while_C_6,
      COMP_LOOP_3_modExp_1_while_C_7, COMP_LOOP_3_modExp_1_while_C_8, COMP_LOOP_3_modExp_1_while_C_9,
      COMP_LOOP_3_modExp_1_while_C_10, COMP_LOOP_3_modExp_1_while_C_11, COMP_LOOP_3_modExp_1_while_C_12,
      COMP_LOOP_3_modExp_1_while_C_13, COMP_LOOP_3_modExp_1_while_C_14, COMP_LOOP_3_modExp_1_while_C_15,
      COMP_LOOP_3_modExp_1_while_C_16, COMP_LOOP_3_modExp_1_while_C_17, COMP_LOOP_3_modExp_1_while_C_18,
      COMP_LOOP_3_modExp_1_while_C_19, COMP_LOOP_3_modExp_1_while_C_20, COMP_LOOP_3_modExp_1_while_C_21,
      COMP_LOOP_3_modExp_1_while_C_22, COMP_LOOP_3_modExp_1_while_C_23, COMP_LOOP_3_modExp_1_while_C_24,
      COMP_LOOP_3_modExp_1_while_C_25, COMP_LOOP_3_modExp_1_while_C_26, COMP_LOOP_3_modExp_1_while_C_27,
      COMP_LOOP_3_modExp_1_while_C_28, COMP_LOOP_3_modExp_1_while_C_29, COMP_LOOP_3_modExp_1_while_C_30,
      COMP_LOOP_3_modExp_1_while_C_31, COMP_LOOP_3_modExp_1_while_C_32, COMP_LOOP_3_modExp_1_while_C_33,
      COMP_LOOP_3_modExp_1_while_C_34, COMP_LOOP_3_modExp_1_while_C_35, COMP_LOOP_3_modExp_1_while_C_36,
      COMP_LOOP_3_modExp_1_while_C_37, COMP_LOOP_3_modExp_1_while_C_38, COMP_LOOP_3_modExp_1_while_C_39,
      COMP_LOOP_3_modExp_1_while_C_40, COMP_LOOP_C_132, COMP_LOOP_C_133, COMP_LOOP_C_134,
      COMP_LOOP_C_135, COMP_LOOP_C_136, COMP_LOOP_C_137, COMP_LOOP_C_138, COMP_LOOP_C_139,
      COMP_LOOP_C_140, COMP_LOOP_C_141, COMP_LOOP_C_142, COMP_LOOP_C_143, COMP_LOOP_C_144,
      COMP_LOOP_C_145, COMP_LOOP_C_146, COMP_LOOP_C_147, COMP_LOOP_C_148, COMP_LOOP_C_149,
      COMP_LOOP_C_150, COMP_LOOP_C_151, COMP_LOOP_C_152, COMP_LOOP_C_153, COMP_LOOP_C_154,
      COMP_LOOP_C_155, COMP_LOOP_C_156, COMP_LOOP_C_157, COMP_LOOP_C_158, COMP_LOOP_C_159,
      COMP_LOOP_C_160, COMP_LOOP_C_161, COMP_LOOP_C_162, COMP_LOOP_C_163, COMP_LOOP_C_164,
      COMP_LOOP_C_165, COMP_LOOP_C_166, COMP_LOOP_C_167, COMP_LOOP_C_168, COMP_LOOP_C_169,
      COMP_LOOP_C_170, COMP_LOOP_C_171, COMP_LOOP_C_172, COMP_LOOP_C_173, COMP_LOOP_C_174,
      COMP_LOOP_C_175, COMP_LOOP_C_176, COMP_LOOP_C_177, COMP_LOOP_C_178, COMP_LOOP_C_179,
      COMP_LOOP_C_180, COMP_LOOP_C_181, COMP_LOOP_C_182, COMP_LOOP_C_183, COMP_LOOP_C_184,
      COMP_LOOP_C_185, COMP_LOOP_C_186, COMP_LOOP_C_187, COMP_LOOP_C_188, COMP_LOOP_C_189,
      COMP_LOOP_C_190, COMP_LOOP_C_191, COMP_LOOP_C_192, COMP_LOOP_C_193, COMP_LOOP_C_194,
      COMP_LOOP_C_195, COMP_LOOP_C_196, COMP_LOOP_4_modExp_1_while_C_0, COMP_LOOP_4_modExp_1_while_C_1,
      COMP_LOOP_4_modExp_1_while_C_2, COMP_LOOP_4_modExp_1_while_C_3, COMP_LOOP_4_modExp_1_while_C_4,
      COMP_LOOP_4_modExp_1_while_C_5, COMP_LOOP_4_modExp_1_while_C_6, COMP_LOOP_4_modExp_1_while_C_7,
      COMP_LOOP_4_modExp_1_while_C_8, COMP_LOOP_4_modExp_1_while_C_9, COMP_LOOP_4_modExp_1_while_C_10,
      COMP_LOOP_4_modExp_1_while_C_11, COMP_LOOP_4_modExp_1_while_C_12, COMP_LOOP_4_modExp_1_while_C_13,
      COMP_LOOP_4_modExp_1_while_C_14, COMP_LOOP_4_modExp_1_while_C_15, COMP_LOOP_4_modExp_1_while_C_16,
      COMP_LOOP_4_modExp_1_while_C_17, COMP_LOOP_4_modExp_1_while_C_18, COMP_LOOP_4_modExp_1_while_C_19,
      COMP_LOOP_4_modExp_1_while_C_20, COMP_LOOP_4_modExp_1_while_C_21, COMP_LOOP_4_modExp_1_while_C_22,
      COMP_LOOP_4_modExp_1_while_C_23, COMP_LOOP_4_modExp_1_while_C_24, COMP_LOOP_4_modExp_1_while_C_25,
      COMP_LOOP_4_modExp_1_while_C_26, COMP_LOOP_4_modExp_1_while_C_27, COMP_LOOP_4_modExp_1_while_C_28,
      COMP_LOOP_4_modExp_1_while_C_29, COMP_LOOP_4_modExp_1_while_C_30, COMP_LOOP_4_modExp_1_while_C_31,
      COMP_LOOP_4_modExp_1_while_C_32, COMP_LOOP_4_modExp_1_while_C_33, COMP_LOOP_4_modExp_1_while_C_34,
      COMP_LOOP_4_modExp_1_while_C_35, COMP_LOOP_4_modExp_1_while_C_36, COMP_LOOP_4_modExp_1_while_C_37,
      COMP_LOOP_4_modExp_1_while_C_38, COMP_LOOP_4_modExp_1_while_C_39, COMP_LOOP_4_modExp_1_while_C_40,
      COMP_LOOP_C_197, COMP_LOOP_C_198, COMP_LOOP_C_199, COMP_LOOP_C_200, COMP_LOOP_C_201,
      COMP_LOOP_C_202, COMP_LOOP_C_203, COMP_LOOP_C_204, COMP_LOOP_C_205, COMP_LOOP_C_206,
      COMP_LOOP_C_207, COMP_LOOP_C_208, COMP_LOOP_C_209, COMP_LOOP_C_210, COMP_LOOP_C_211,
      COMP_LOOP_C_212, COMP_LOOP_C_213, COMP_LOOP_C_214, COMP_LOOP_C_215, COMP_LOOP_C_216,
      COMP_LOOP_C_217, COMP_LOOP_C_218, COMP_LOOP_C_219, COMP_LOOP_C_220, COMP_LOOP_C_221,
      COMP_LOOP_C_222, COMP_LOOP_C_223, COMP_LOOP_C_224, COMP_LOOP_C_225, COMP_LOOP_C_226,
      COMP_LOOP_C_227, COMP_LOOP_C_228, COMP_LOOP_C_229, COMP_LOOP_C_230, COMP_LOOP_C_231,
      COMP_LOOP_C_232, COMP_LOOP_C_233, COMP_LOOP_C_234, COMP_LOOP_C_235, COMP_LOOP_C_236,
      COMP_LOOP_C_237, COMP_LOOP_C_238, COMP_LOOP_C_239, COMP_LOOP_C_240, COMP_LOOP_C_241,
      COMP_LOOP_C_242, COMP_LOOP_C_243, COMP_LOOP_C_244, COMP_LOOP_C_245, COMP_LOOP_C_246,
      COMP_LOOP_C_247, COMP_LOOP_C_248, COMP_LOOP_C_249, COMP_LOOP_C_250, COMP_LOOP_C_251,
      COMP_LOOP_C_252, COMP_LOOP_C_253, COMP_LOOP_C_254, COMP_LOOP_C_255, COMP_LOOP_C_256,
      COMP_LOOP_C_257, COMP_LOOP_C_258, COMP_LOOP_C_259, COMP_LOOP_C_260, COMP_LOOP_C_261,
      COMP_LOOP_5_modExp_1_while_C_0, COMP_LOOP_5_modExp_1_while_C_1, COMP_LOOP_5_modExp_1_while_C_2,
      COMP_LOOP_5_modExp_1_while_C_3, COMP_LOOP_5_modExp_1_while_C_4, COMP_LOOP_5_modExp_1_while_C_5,
      COMP_LOOP_5_modExp_1_while_C_6, COMP_LOOP_5_modExp_1_while_C_7, COMP_LOOP_5_modExp_1_while_C_8,
      COMP_LOOP_5_modExp_1_while_C_9, COMP_LOOP_5_modExp_1_while_C_10, COMP_LOOP_5_modExp_1_while_C_11,
      COMP_LOOP_5_modExp_1_while_C_12, COMP_LOOP_5_modExp_1_while_C_13, COMP_LOOP_5_modExp_1_while_C_14,
      COMP_LOOP_5_modExp_1_while_C_15, COMP_LOOP_5_modExp_1_while_C_16, COMP_LOOP_5_modExp_1_while_C_17,
      COMP_LOOP_5_modExp_1_while_C_18, COMP_LOOP_5_modExp_1_while_C_19, COMP_LOOP_5_modExp_1_while_C_20,
      COMP_LOOP_5_modExp_1_while_C_21, COMP_LOOP_5_modExp_1_while_C_22, COMP_LOOP_5_modExp_1_while_C_23,
      COMP_LOOP_5_modExp_1_while_C_24, COMP_LOOP_5_modExp_1_while_C_25, COMP_LOOP_5_modExp_1_while_C_26,
      COMP_LOOP_5_modExp_1_while_C_27, COMP_LOOP_5_modExp_1_while_C_28, COMP_LOOP_5_modExp_1_while_C_29,
      COMP_LOOP_5_modExp_1_while_C_30, COMP_LOOP_5_modExp_1_while_C_31, COMP_LOOP_5_modExp_1_while_C_32,
      COMP_LOOP_5_modExp_1_while_C_33, COMP_LOOP_5_modExp_1_while_C_34, COMP_LOOP_5_modExp_1_while_C_35,
      COMP_LOOP_5_modExp_1_while_C_36, COMP_LOOP_5_modExp_1_while_C_37, COMP_LOOP_5_modExp_1_while_C_38,
      COMP_LOOP_5_modExp_1_while_C_39, COMP_LOOP_5_modExp_1_while_C_40, COMP_LOOP_C_262,
      COMP_LOOP_C_263, COMP_LOOP_C_264, COMP_LOOP_C_265, COMP_LOOP_C_266, COMP_LOOP_C_267,
      COMP_LOOP_C_268, COMP_LOOP_C_269, COMP_LOOP_C_270, COMP_LOOP_C_271, COMP_LOOP_C_272,
      COMP_LOOP_C_273, COMP_LOOP_C_274, COMP_LOOP_C_275, COMP_LOOP_C_276, COMP_LOOP_C_277,
      COMP_LOOP_C_278, COMP_LOOP_C_279, COMP_LOOP_C_280, COMP_LOOP_C_281, COMP_LOOP_C_282,
      COMP_LOOP_C_283, COMP_LOOP_C_284, COMP_LOOP_C_285, COMP_LOOP_C_286, COMP_LOOP_C_287,
      COMP_LOOP_C_288, COMP_LOOP_C_289, COMP_LOOP_C_290, COMP_LOOP_C_291, COMP_LOOP_C_292,
      COMP_LOOP_C_293, COMP_LOOP_C_294, COMP_LOOP_C_295, COMP_LOOP_C_296, COMP_LOOP_C_297,
      COMP_LOOP_C_298, COMP_LOOP_C_299, COMP_LOOP_C_300, COMP_LOOP_C_301, COMP_LOOP_C_302,
      COMP_LOOP_C_303, COMP_LOOP_C_304, COMP_LOOP_C_305, COMP_LOOP_C_306, COMP_LOOP_C_307,
      COMP_LOOP_C_308, COMP_LOOP_C_309, COMP_LOOP_C_310, COMP_LOOP_C_311, COMP_LOOP_C_312,
      COMP_LOOP_C_313, COMP_LOOP_C_314, COMP_LOOP_C_315, COMP_LOOP_C_316, COMP_LOOP_C_317,
      COMP_LOOP_C_318, COMP_LOOP_C_319, COMP_LOOP_C_320, COMP_LOOP_C_321, COMP_LOOP_C_322,
      COMP_LOOP_C_323, COMP_LOOP_C_324, COMP_LOOP_C_325, COMP_LOOP_C_326, COMP_LOOP_6_modExp_1_while_C_0,
      COMP_LOOP_6_modExp_1_while_C_1, COMP_LOOP_6_modExp_1_while_C_2, COMP_LOOP_6_modExp_1_while_C_3,
      COMP_LOOP_6_modExp_1_while_C_4, COMP_LOOP_6_modExp_1_while_C_5, COMP_LOOP_6_modExp_1_while_C_6,
      COMP_LOOP_6_modExp_1_while_C_7, COMP_LOOP_6_modExp_1_while_C_8, COMP_LOOP_6_modExp_1_while_C_9,
      COMP_LOOP_6_modExp_1_while_C_10, COMP_LOOP_6_modExp_1_while_C_11, COMP_LOOP_6_modExp_1_while_C_12,
      COMP_LOOP_6_modExp_1_while_C_13, COMP_LOOP_6_modExp_1_while_C_14, COMP_LOOP_6_modExp_1_while_C_15,
      COMP_LOOP_6_modExp_1_while_C_16, COMP_LOOP_6_modExp_1_while_C_17, COMP_LOOP_6_modExp_1_while_C_18,
      COMP_LOOP_6_modExp_1_while_C_19, COMP_LOOP_6_modExp_1_while_C_20, COMP_LOOP_6_modExp_1_while_C_21,
      COMP_LOOP_6_modExp_1_while_C_22, COMP_LOOP_6_modExp_1_while_C_23, COMP_LOOP_6_modExp_1_while_C_24,
      COMP_LOOP_6_modExp_1_while_C_25, COMP_LOOP_6_modExp_1_while_C_26, COMP_LOOP_6_modExp_1_while_C_27,
      COMP_LOOP_6_modExp_1_while_C_28, COMP_LOOP_6_modExp_1_while_C_29, COMP_LOOP_6_modExp_1_while_C_30,
      COMP_LOOP_6_modExp_1_while_C_31, COMP_LOOP_6_modExp_1_while_C_32, COMP_LOOP_6_modExp_1_while_C_33,
      COMP_LOOP_6_modExp_1_while_C_34, COMP_LOOP_6_modExp_1_while_C_35, COMP_LOOP_6_modExp_1_while_C_36,
      COMP_LOOP_6_modExp_1_while_C_37, COMP_LOOP_6_modExp_1_while_C_38, COMP_LOOP_6_modExp_1_while_C_39,
      COMP_LOOP_6_modExp_1_while_C_40, COMP_LOOP_C_327, COMP_LOOP_C_328, COMP_LOOP_C_329,
      COMP_LOOP_C_330, COMP_LOOP_C_331, COMP_LOOP_C_332, COMP_LOOP_C_333, COMP_LOOP_C_334,
      COMP_LOOP_C_335, COMP_LOOP_C_336, COMP_LOOP_C_337, COMP_LOOP_C_338, COMP_LOOP_C_339,
      COMP_LOOP_C_340, COMP_LOOP_C_341, COMP_LOOP_C_342, COMP_LOOP_C_343, COMP_LOOP_C_344,
      COMP_LOOP_C_345, COMP_LOOP_C_346, COMP_LOOP_C_347, COMP_LOOP_C_348, COMP_LOOP_C_349,
      COMP_LOOP_C_350, COMP_LOOP_C_351, COMP_LOOP_C_352, COMP_LOOP_C_353, COMP_LOOP_C_354,
      COMP_LOOP_C_355, COMP_LOOP_C_356, COMP_LOOP_C_357, COMP_LOOP_C_358, COMP_LOOP_C_359,
      COMP_LOOP_C_360, COMP_LOOP_C_361, COMP_LOOP_C_362, COMP_LOOP_C_363, COMP_LOOP_C_364,
      COMP_LOOP_C_365, COMP_LOOP_C_366, COMP_LOOP_C_367, COMP_LOOP_C_368, COMP_LOOP_C_369,
      COMP_LOOP_C_370, COMP_LOOP_C_371, COMP_LOOP_C_372, COMP_LOOP_C_373, COMP_LOOP_C_374,
      COMP_LOOP_C_375, COMP_LOOP_C_376, COMP_LOOP_C_377, COMP_LOOP_C_378, COMP_LOOP_C_379,
      COMP_LOOP_C_380, COMP_LOOP_C_381, COMP_LOOP_C_382, COMP_LOOP_C_383, COMP_LOOP_C_384,
      COMP_LOOP_C_385, COMP_LOOP_C_386, COMP_LOOP_C_387, COMP_LOOP_C_388, COMP_LOOP_C_389,
      COMP_LOOP_C_390, COMP_LOOP_C_391, COMP_LOOP_7_modExp_1_while_C_0, COMP_LOOP_7_modExp_1_while_C_1,
      COMP_LOOP_7_modExp_1_while_C_2, COMP_LOOP_7_modExp_1_while_C_3, COMP_LOOP_7_modExp_1_while_C_4,
      COMP_LOOP_7_modExp_1_while_C_5, COMP_LOOP_7_modExp_1_while_C_6, COMP_LOOP_7_modExp_1_while_C_7,
      COMP_LOOP_7_modExp_1_while_C_8, COMP_LOOP_7_modExp_1_while_C_9, COMP_LOOP_7_modExp_1_while_C_10,
      COMP_LOOP_7_modExp_1_while_C_11, COMP_LOOP_7_modExp_1_while_C_12, COMP_LOOP_7_modExp_1_while_C_13,
      COMP_LOOP_7_modExp_1_while_C_14, COMP_LOOP_7_modExp_1_while_C_15, COMP_LOOP_7_modExp_1_while_C_16,
      COMP_LOOP_7_modExp_1_while_C_17, COMP_LOOP_7_modExp_1_while_C_18, COMP_LOOP_7_modExp_1_while_C_19,
      COMP_LOOP_7_modExp_1_while_C_20, COMP_LOOP_7_modExp_1_while_C_21, COMP_LOOP_7_modExp_1_while_C_22,
      COMP_LOOP_7_modExp_1_while_C_23, COMP_LOOP_7_modExp_1_while_C_24, COMP_LOOP_7_modExp_1_while_C_25,
      COMP_LOOP_7_modExp_1_while_C_26, COMP_LOOP_7_modExp_1_while_C_27, COMP_LOOP_7_modExp_1_while_C_28,
      COMP_LOOP_7_modExp_1_while_C_29, COMP_LOOP_7_modExp_1_while_C_30, COMP_LOOP_7_modExp_1_while_C_31,
      COMP_LOOP_7_modExp_1_while_C_32, COMP_LOOP_7_modExp_1_while_C_33, COMP_LOOP_7_modExp_1_while_C_34,
      COMP_LOOP_7_modExp_1_while_C_35, COMP_LOOP_7_modExp_1_while_C_36, COMP_LOOP_7_modExp_1_while_C_37,
      COMP_LOOP_7_modExp_1_while_C_38, COMP_LOOP_7_modExp_1_while_C_39, COMP_LOOP_7_modExp_1_while_C_40,
      COMP_LOOP_C_392, COMP_LOOP_C_393, COMP_LOOP_C_394, COMP_LOOP_C_395, COMP_LOOP_C_396,
      COMP_LOOP_C_397, COMP_LOOP_C_398, COMP_LOOP_C_399, COMP_LOOP_C_400, COMP_LOOP_C_401,
      COMP_LOOP_C_402, COMP_LOOP_C_403, COMP_LOOP_C_404, COMP_LOOP_C_405, COMP_LOOP_C_406,
      COMP_LOOP_C_407, COMP_LOOP_C_408, COMP_LOOP_C_409, COMP_LOOP_C_410, COMP_LOOP_C_411,
      COMP_LOOP_C_412, COMP_LOOP_C_413, COMP_LOOP_C_414, COMP_LOOP_C_415, COMP_LOOP_C_416,
      COMP_LOOP_C_417, COMP_LOOP_C_418, COMP_LOOP_C_419, COMP_LOOP_C_420, COMP_LOOP_C_421,
      COMP_LOOP_C_422, COMP_LOOP_C_423, COMP_LOOP_C_424, COMP_LOOP_C_425, COMP_LOOP_C_426,
      COMP_LOOP_C_427, COMP_LOOP_C_428, COMP_LOOP_C_429, COMP_LOOP_C_430, COMP_LOOP_C_431,
      COMP_LOOP_C_432, COMP_LOOP_C_433, COMP_LOOP_C_434, COMP_LOOP_C_435, COMP_LOOP_C_436,
      COMP_LOOP_C_437, COMP_LOOP_C_438, COMP_LOOP_C_439, COMP_LOOP_C_440, COMP_LOOP_C_441,
      COMP_LOOP_C_442, COMP_LOOP_C_443, COMP_LOOP_C_444, COMP_LOOP_C_445, COMP_LOOP_C_446,
      COMP_LOOP_C_447, COMP_LOOP_C_448, COMP_LOOP_C_449, COMP_LOOP_C_450, COMP_LOOP_C_451,
      COMP_LOOP_C_452, COMP_LOOP_C_453, COMP_LOOP_C_454, COMP_LOOP_C_455, COMP_LOOP_C_456,
      COMP_LOOP_8_modExp_1_while_C_0, COMP_LOOP_8_modExp_1_while_C_1, COMP_LOOP_8_modExp_1_while_C_2,
      COMP_LOOP_8_modExp_1_while_C_3, COMP_LOOP_8_modExp_1_while_C_4, COMP_LOOP_8_modExp_1_while_C_5,
      COMP_LOOP_8_modExp_1_while_C_6, COMP_LOOP_8_modExp_1_while_C_7, COMP_LOOP_8_modExp_1_while_C_8,
      COMP_LOOP_8_modExp_1_while_C_9, COMP_LOOP_8_modExp_1_while_C_10, COMP_LOOP_8_modExp_1_while_C_11,
      COMP_LOOP_8_modExp_1_while_C_12, COMP_LOOP_8_modExp_1_while_C_13, COMP_LOOP_8_modExp_1_while_C_14,
      COMP_LOOP_8_modExp_1_while_C_15, COMP_LOOP_8_modExp_1_while_C_16, COMP_LOOP_8_modExp_1_while_C_17,
      COMP_LOOP_8_modExp_1_while_C_18, COMP_LOOP_8_modExp_1_while_C_19, COMP_LOOP_8_modExp_1_while_C_20,
      COMP_LOOP_8_modExp_1_while_C_21, COMP_LOOP_8_modExp_1_while_C_22, COMP_LOOP_8_modExp_1_while_C_23,
      COMP_LOOP_8_modExp_1_while_C_24, COMP_LOOP_8_modExp_1_while_C_25, COMP_LOOP_8_modExp_1_while_C_26,
      COMP_LOOP_8_modExp_1_while_C_27, COMP_LOOP_8_modExp_1_while_C_28, COMP_LOOP_8_modExp_1_while_C_29,
      COMP_LOOP_8_modExp_1_while_C_30, COMP_LOOP_8_modExp_1_while_C_31, COMP_LOOP_8_modExp_1_while_C_32,
      COMP_LOOP_8_modExp_1_while_C_33, COMP_LOOP_8_modExp_1_while_C_34, COMP_LOOP_8_modExp_1_while_C_35,
      COMP_LOOP_8_modExp_1_while_C_36, COMP_LOOP_8_modExp_1_while_C_37, COMP_LOOP_8_modExp_1_while_C_38,
      COMP_LOOP_8_modExp_1_while_C_39, COMP_LOOP_8_modExp_1_while_C_40, COMP_LOOP_C_457,
      COMP_LOOP_C_458, COMP_LOOP_C_459, COMP_LOOP_C_460, COMP_LOOP_C_461, COMP_LOOP_C_462,
      COMP_LOOP_C_463, COMP_LOOP_C_464, COMP_LOOP_C_465, COMP_LOOP_C_466, COMP_LOOP_C_467,
      COMP_LOOP_C_468, COMP_LOOP_C_469, COMP_LOOP_C_470, COMP_LOOP_C_471, COMP_LOOP_C_472,
      COMP_LOOP_C_473, COMP_LOOP_C_474, COMP_LOOP_C_475, COMP_LOOP_C_476, COMP_LOOP_C_477,
      COMP_LOOP_C_478, COMP_LOOP_C_479, COMP_LOOP_C_480, COMP_LOOP_C_481, COMP_LOOP_C_482,
      COMP_LOOP_C_483, COMP_LOOP_C_484, COMP_LOOP_C_485, COMP_LOOP_C_486, COMP_LOOP_C_487,
      COMP_LOOP_C_488, COMP_LOOP_C_489, COMP_LOOP_C_490, COMP_LOOP_C_491, COMP_LOOP_C_492,
      COMP_LOOP_C_493, COMP_LOOP_C_494, COMP_LOOP_C_495, COMP_LOOP_C_496, COMP_LOOP_C_497,
      COMP_LOOP_C_498, COMP_LOOP_C_499, COMP_LOOP_C_500, COMP_LOOP_C_501, COMP_LOOP_C_502,
      COMP_LOOP_C_503, COMP_LOOP_C_504, COMP_LOOP_C_505, COMP_LOOP_C_506, COMP_LOOP_C_507,
      COMP_LOOP_C_508, COMP_LOOP_C_509, COMP_LOOP_C_510, COMP_LOOP_C_511, COMP_LOOP_C_512,
      COMP_LOOP_C_513, COMP_LOOP_C_514, COMP_LOOP_C_515, COMP_LOOP_C_516, COMP_LOOP_C_517,
      COMP_LOOP_C_518, COMP_LOOP_C_519, COMP_LOOP_C_520, VEC_LOOP_C_0, STAGE_LOOP_C_9,
      main_C_1);

  SIGNAL state_var : inPlaceNTT_DIT_core_core_fsm_1_ST;
  SIGNAL state_var_NS : inPlaceNTT_DIT_core_core_fsm_1_ST;

BEGIN
  inPlaceNTT_DIT_core_core_fsm_1 : PROCESS (STAGE_LOOP_C_8_tr0, modExp_while_C_40_tr0,
      COMP_LOOP_C_1_tr0, COMP_LOOP_1_modExp_1_while_C_40_tr0, COMP_LOOP_C_65_tr0,
      COMP_LOOP_2_modExp_1_while_C_40_tr0, COMP_LOOP_C_130_tr0, COMP_LOOP_3_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_195_tr0, COMP_LOOP_4_modExp_1_while_C_40_tr0, COMP_LOOP_C_260_tr0,
      COMP_LOOP_5_modExp_1_while_C_40_tr0, COMP_LOOP_C_325_tr0, COMP_LOOP_6_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_390_tr0, COMP_LOOP_7_modExp_1_while_C_40_tr0, COMP_LOOP_C_455_tr0,
      COMP_LOOP_8_modExp_1_while_C_40_tr0, COMP_LOOP_C_520_tr0, VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_9_tr0, state_var)
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
        state_var_NS <= STAGE_LOOP_C_6;
      WHEN STAGE_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000111");
        state_var_NS <= STAGE_LOOP_C_7;
      WHEN STAGE_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001000");
        state_var_NS <= STAGE_LOOP_C_8;
      WHEN STAGE_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001001");
        IF ( STAGE_LOOP_C_8_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_0;
        ELSE
          state_var_NS <= modExp_while_C_0;
        END IF;
      WHEN modExp_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001010");
        state_var_NS <= modExp_while_C_1;
      WHEN modExp_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001011");
        state_var_NS <= modExp_while_C_2;
      WHEN modExp_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001100");
        state_var_NS <= modExp_while_C_3;
      WHEN modExp_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001101");
        state_var_NS <= modExp_while_C_4;
      WHEN modExp_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001110");
        state_var_NS <= modExp_while_C_5;
      WHEN modExp_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001111");
        state_var_NS <= modExp_while_C_6;
      WHEN modExp_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010000");
        state_var_NS <= modExp_while_C_7;
      WHEN modExp_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010001");
        state_var_NS <= modExp_while_C_8;
      WHEN modExp_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010010");
        state_var_NS <= modExp_while_C_9;
      WHEN modExp_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010011");
        state_var_NS <= modExp_while_C_10;
      WHEN modExp_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010100");
        state_var_NS <= modExp_while_C_11;
      WHEN modExp_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010101");
        state_var_NS <= modExp_while_C_12;
      WHEN modExp_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010110");
        state_var_NS <= modExp_while_C_13;
      WHEN modExp_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010111");
        state_var_NS <= modExp_while_C_14;
      WHEN modExp_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011000");
        state_var_NS <= modExp_while_C_15;
      WHEN modExp_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011001");
        state_var_NS <= modExp_while_C_16;
      WHEN modExp_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011010");
        state_var_NS <= modExp_while_C_17;
      WHEN modExp_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011011");
        state_var_NS <= modExp_while_C_18;
      WHEN modExp_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011100");
        state_var_NS <= modExp_while_C_19;
      WHEN modExp_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011101");
        state_var_NS <= modExp_while_C_20;
      WHEN modExp_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011110");
        state_var_NS <= modExp_while_C_21;
      WHEN modExp_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000011111");
        state_var_NS <= modExp_while_C_22;
      WHEN modExp_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100000");
        state_var_NS <= modExp_while_C_23;
      WHEN modExp_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100001");
        state_var_NS <= modExp_while_C_24;
      WHEN modExp_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100010");
        state_var_NS <= modExp_while_C_25;
      WHEN modExp_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100011");
        state_var_NS <= modExp_while_C_26;
      WHEN modExp_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100100");
        state_var_NS <= modExp_while_C_27;
      WHEN modExp_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100101");
        state_var_NS <= modExp_while_C_28;
      WHEN modExp_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100110");
        state_var_NS <= modExp_while_C_29;
      WHEN modExp_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100111");
        state_var_NS <= modExp_while_C_30;
      WHEN modExp_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101000");
        state_var_NS <= modExp_while_C_31;
      WHEN modExp_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101001");
        state_var_NS <= modExp_while_C_32;
      WHEN modExp_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101010");
        state_var_NS <= modExp_while_C_33;
      WHEN modExp_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101011");
        state_var_NS <= modExp_while_C_34;
      WHEN modExp_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101100");
        state_var_NS <= modExp_while_C_35;
      WHEN modExp_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101101");
        state_var_NS <= modExp_while_C_36;
      WHEN modExp_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101110");
        state_var_NS <= modExp_while_C_37;
      WHEN modExp_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000101111");
        state_var_NS <= modExp_while_C_38;
      WHEN modExp_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110000");
        state_var_NS <= modExp_while_C_39;
      WHEN modExp_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110001");
        state_var_NS <= modExp_while_C_40;
      WHEN modExp_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110010");
        IF ( modExp_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_0;
        ELSE
          state_var_NS <= modExp_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110011");
        state_var_NS <= COMP_LOOP_C_1;
      WHEN COMP_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110100");
        IF ( COMP_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_2;
        ELSE
          state_var_NS <= COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_1_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_1;
      WHEN COMP_LOOP_1_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_2;
      WHEN COMP_LOOP_1_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000110111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_3;
      WHEN COMP_LOOP_1_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_4;
      WHEN COMP_LOOP_1_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_5;
      WHEN COMP_LOOP_1_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_6;
      WHEN COMP_LOOP_1_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_7;
      WHEN COMP_LOOP_1_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_8;
      WHEN COMP_LOOP_1_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_9;
      WHEN COMP_LOOP_1_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_10;
      WHEN COMP_LOOP_1_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000111111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_11;
      WHEN COMP_LOOP_1_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_12;
      WHEN COMP_LOOP_1_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_13;
      WHEN COMP_LOOP_1_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_14;
      WHEN COMP_LOOP_1_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_15;
      WHEN COMP_LOOP_1_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_16;
      WHEN COMP_LOOP_1_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_17;
      WHEN COMP_LOOP_1_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_18;
      WHEN COMP_LOOP_1_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_19;
      WHEN COMP_LOOP_1_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_20;
      WHEN COMP_LOOP_1_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_21;
      WHEN COMP_LOOP_1_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_22;
      WHEN COMP_LOOP_1_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_23;
      WHEN COMP_LOOP_1_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_24;
      WHEN COMP_LOOP_1_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_25;
      WHEN COMP_LOOP_1_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_26;
      WHEN COMP_LOOP_1_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001001111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_27;
      WHEN COMP_LOOP_1_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_28;
      WHEN COMP_LOOP_1_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_29;
      WHEN COMP_LOOP_1_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_30;
      WHEN COMP_LOOP_1_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_31;
      WHEN COMP_LOOP_1_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_32;
      WHEN COMP_LOOP_1_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010101");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_33;
      WHEN COMP_LOOP_1_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010110");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_34;
      WHEN COMP_LOOP_1_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001010111");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_35;
      WHEN COMP_LOOP_1_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011000");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_36;
      WHEN COMP_LOOP_1_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011001");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_37;
      WHEN COMP_LOOP_1_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011010");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_38;
      WHEN COMP_LOOP_1_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011011");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_39;
      WHEN COMP_LOOP_1_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011100");
        state_var_NS <= COMP_LOOP_1_modExp_1_while_C_40;
      WHEN COMP_LOOP_1_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011101");
        IF ( COMP_LOOP_1_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_2;
        ELSE
          state_var_NS <= COMP_LOOP_1_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011110");
        state_var_NS <= COMP_LOOP_C_3;
      WHEN COMP_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001011111");
        state_var_NS <= COMP_LOOP_C_4;
      WHEN COMP_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100000");
        state_var_NS <= COMP_LOOP_C_5;
      WHEN COMP_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100001");
        state_var_NS <= COMP_LOOP_C_6;
      WHEN COMP_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100010");
        state_var_NS <= COMP_LOOP_C_7;
      WHEN COMP_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100011");
        state_var_NS <= COMP_LOOP_C_8;
      WHEN COMP_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100100");
        state_var_NS <= COMP_LOOP_C_9;
      WHEN COMP_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100101");
        state_var_NS <= COMP_LOOP_C_10;
      WHEN COMP_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100110");
        state_var_NS <= COMP_LOOP_C_11;
      WHEN COMP_LOOP_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001100111");
        state_var_NS <= COMP_LOOP_C_12;
      WHEN COMP_LOOP_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101000");
        state_var_NS <= COMP_LOOP_C_13;
      WHEN COMP_LOOP_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101001");
        state_var_NS <= COMP_LOOP_C_14;
      WHEN COMP_LOOP_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101010");
        state_var_NS <= COMP_LOOP_C_15;
      WHEN COMP_LOOP_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101011");
        state_var_NS <= COMP_LOOP_C_16;
      WHEN COMP_LOOP_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101100");
        state_var_NS <= COMP_LOOP_C_17;
      WHEN COMP_LOOP_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101101");
        state_var_NS <= COMP_LOOP_C_18;
      WHEN COMP_LOOP_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101110");
        state_var_NS <= COMP_LOOP_C_19;
      WHEN COMP_LOOP_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001101111");
        state_var_NS <= COMP_LOOP_C_20;
      WHEN COMP_LOOP_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110000");
        state_var_NS <= COMP_LOOP_C_21;
      WHEN COMP_LOOP_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110001");
        state_var_NS <= COMP_LOOP_C_22;
      WHEN COMP_LOOP_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110010");
        state_var_NS <= COMP_LOOP_C_23;
      WHEN COMP_LOOP_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110011");
        state_var_NS <= COMP_LOOP_C_24;
      WHEN COMP_LOOP_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110100");
        state_var_NS <= COMP_LOOP_C_25;
      WHEN COMP_LOOP_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110101");
        state_var_NS <= COMP_LOOP_C_26;
      WHEN COMP_LOOP_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110110");
        state_var_NS <= COMP_LOOP_C_27;
      WHEN COMP_LOOP_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001110111");
        state_var_NS <= COMP_LOOP_C_28;
      WHEN COMP_LOOP_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111000");
        state_var_NS <= COMP_LOOP_C_29;
      WHEN COMP_LOOP_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111001");
        state_var_NS <= COMP_LOOP_C_30;
      WHEN COMP_LOOP_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111010");
        state_var_NS <= COMP_LOOP_C_31;
      WHEN COMP_LOOP_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111011");
        state_var_NS <= COMP_LOOP_C_32;
      WHEN COMP_LOOP_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111100");
        state_var_NS <= COMP_LOOP_C_33;
      WHEN COMP_LOOP_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111101");
        state_var_NS <= COMP_LOOP_C_34;
      WHEN COMP_LOOP_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111110");
        state_var_NS <= COMP_LOOP_C_35;
      WHEN COMP_LOOP_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001111111");
        state_var_NS <= COMP_LOOP_C_36;
      WHEN COMP_LOOP_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000000");
        state_var_NS <= COMP_LOOP_C_37;
      WHEN COMP_LOOP_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000001");
        state_var_NS <= COMP_LOOP_C_38;
      WHEN COMP_LOOP_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000010");
        state_var_NS <= COMP_LOOP_C_39;
      WHEN COMP_LOOP_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000011");
        state_var_NS <= COMP_LOOP_C_40;
      WHEN COMP_LOOP_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000100");
        state_var_NS <= COMP_LOOP_C_41;
      WHEN COMP_LOOP_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000101");
        state_var_NS <= COMP_LOOP_C_42;
      WHEN COMP_LOOP_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000110");
        state_var_NS <= COMP_LOOP_C_43;
      WHEN COMP_LOOP_C_43 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000111");
        state_var_NS <= COMP_LOOP_C_44;
      WHEN COMP_LOOP_C_44 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001000");
        state_var_NS <= COMP_LOOP_C_45;
      WHEN COMP_LOOP_C_45 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001001");
        state_var_NS <= COMP_LOOP_C_46;
      WHEN COMP_LOOP_C_46 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001010");
        state_var_NS <= COMP_LOOP_C_47;
      WHEN COMP_LOOP_C_47 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001011");
        state_var_NS <= COMP_LOOP_C_48;
      WHEN COMP_LOOP_C_48 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001100");
        state_var_NS <= COMP_LOOP_C_49;
      WHEN COMP_LOOP_C_49 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001101");
        state_var_NS <= COMP_LOOP_C_50;
      WHEN COMP_LOOP_C_50 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001110");
        state_var_NS <= COMP_LOOP_C_51;
      WHEN COMP_LOOP_C_51 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010001111");
        state_var_NS <= COMP_LOOP_C_52;
      WHEN COMP_LOOP_C_52 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010000");
        state_var_NS <= COMP_LOOP_C_53;
      WHEN COMP_LOOP_C_53 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010001");
        state_var_NS <= COMP_LOOP_C_54;
      WHEN COMP_LOOP_C_54 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010010");
        state_var_NS <= COMP_LOOP_C_55;
      WHEN COMP_LOOP_C_55 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010011");
        state_var_NS <= COMP_LOOP_C_56;
      WHEN COMP_LOOP_C_56 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010100");
        state_var_NS <= COMP_LOOP_C_57;
      WHEN COMP_LOOP_C_57 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010101");
        state_var_NS <= COMP_LOOP_C_58;
      WHEN COMP_LOOP_C_58 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010110");
        state_var_NS <= COMP_LOOP_C_59;
      WHEN COMP_LOOP_C_59 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010010111");
        state_var_NS <= COMP_LOOP_C_60;
      WHEN COMP_LOOP_C_60 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011000");
        state_var_NS <= COMP_LOOP_C_61;
      WHEN COMP_LOOP_C_61 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011001");
        state_var_NS <= COMP_LOOP_C_62;
      WHEN COMP_LOOP_C_62 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011010");
        state_var_NS <= COMP_LOOP_C_63;
      WHEN COMP_LOOP_C_63 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011011");
        state_var_NS <= COMP_LOOP_C_64;
      WHEN COMP_LOOP_C_64 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011100");
        state_var_NS <= COMP_LOOP_C_65;
      WHEN COMP_LOOP_C_65 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011101");
        IF ( COMP_LOOP_C_65_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_66;
        END IF;
      WHEN COMP_LOOP_C_66 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_0;
      WHEN COMP_LOOP_2_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010011111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_1;
      WHEN COMP_LOOP_2_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_2;
      WHEN COMP_LOOP_2_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_3;
      WHEN COMP_LOOP_2_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_4;
      WHEN COMP_LOOP_2_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_5;
      WHEN COMP_LOOP_2_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_6;
      WHEN COMP_LOOP_2_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_7;
      WHEN COMP_LOOP_2_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_8;
      WHEN COMP_LOOP_2_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010100111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_9;
      WHEN COMP_LOOP_2_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_10;
      WHEN COMP_LOOP_2_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_11;
      WHEN COMP_LOOP_2_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_12;
      WHEN COMP_LOOP_2_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_13;
      WHEN COMP_LOOP_2_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_14;
      WHEN COMP_LOOP_2_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_15;
      WHEN COMP_LOOP_2_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_16;
      WHEN COMP_LOOP_2_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010101111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_17;
      WHEN COMP_LOOP_2_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_18;
      WHEN COMP_LOOP_2_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_19;
      WHEN COMP_LOOP_2_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_20;
      WHEN COMP_LOOP_2_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_21;
      WHEN COMP_LOOP_2_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_22;
      WHEN COMP_LOOP_2_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_23;
      WHEN COMP_LOOP_2_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_24;
      WHEN COMP_LOOP_2_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010110111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_25;
      WHEN COMP_LOOP_2_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_26;
      WHEN COMP_LOOP_2_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_27;
      WHEN COMP_LOOP_2_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_28;
      WHEN COMP_LOOP_2_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_29;
      WHEN COMP_LOOP_2_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_30;
      WHEN COMP_LOOP_2_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_31;
      WHEN COMP_LOOP_2_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_32;
      WHEN COMP_LOOP_2_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010111111");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_33;
      WHEN COMP_LOOP_2_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000000");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_34;
      WHEN COMP_LOOP_2_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000001");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_35;
      WHEN COMP_LOOP_2_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000010");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_36;
      WHEN COMP_LOOP_2_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000011");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_37;
      WHEN COMP_LOOP_2_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000100");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_38;
      WHEN COMP_LOOP_2_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000101");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_39;
      WHEN COMP_LOOP_2_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000110");
        state_var_NS <= COMP_LOOP_2_modExp_1_while_C_40;
      WHEN COMP_LOOP_2_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011000111");
        IF ( COMP_LOOP_2_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_67;
        ELSE
          state_var_NS <= COMP_LOOP_2_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_67 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001000");
        state_var_NS <= COMP_LOOP_C_68;
      WHEN COMP_LOOP_C_68 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001001");
        state_var_NS <= COMP_LOOP_C_69;
      WHEN COMP_LOOP_C_69 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001010");
        state_var_NS <= COMP_LOOP_C_70;
      WHEN COMP_LOOP_C_70 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001011");
        state_var_NS <= COMP_LOOP_C_71;
      WHEN COMP_LOOP_C_71 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001100");
        state_var_NS <= COMP_LOOP_C_72;
      WHEN COMP_LOOP_C_72 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001101");
        state_var_NS <= COMP_LOOP_C_73;
      WHEN COMP_LOOP_C_73 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001110");
        state_var_NS <= COMP_LOOP_C_74;
      WHEN COMP_LOOP_C_74 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011001111");
        state_var_NS <= COMP_LOOP_C_75;
      WHEN COMP_LOOP_C_75 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010000");
        state_var_NS <= COMP_LOOP_C_76;
      WHEN COMP_LOOP_C_76 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010001");
        state_var_NS <= COMP_LOOP_C_77;
      WHEN COMP_LOOP_C_77 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010010");
        state_var_NS <= COMP_LOOP_C_78;
      WHEN COMP_LOOP_C_78 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010011");
        state_var_NS <= COMP_LOOP_C_79;
      WHEN COMP_LOOP_C_79 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010100");
        state_var_NS <= COMP_LOOP_C_80;
      WHEN COMP_LOOP_C_80 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010101");
        state_var_NS <= COMP_LOOP_C_81;
      WHEN COMP_LOOP_C_81 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010110");
        state_var_NS <= COMP_LOOP_C_82;
      WHEN COMP_LOOP_C_82 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011010111");
        state_var_NS <= COMP_LOOP_C_83;
      WHEN COMP_LOOP_C_83 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011000");
        state_var_NS <= COMP_LOOP_C_84;
      WHEN COMP_LOOP_C_84 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011001");
        state_var_NS <= COMP_LOOP_C_85;
      WHEN COMP_LOOP_C_85 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011010");
        state_var_NS <= COMP_LOOP_C_86;
      WHEN COMP_LOOP_C_86 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011011");
        state_var_NS <= COMP_LOOP_C_87;
      WHEN COMP_LOOP_C_87 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011100");
        state_var_NS <= COMP_LOOP_C_88;
      WHEN COMP_LOOP_C_88 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011101");
        state_var_NS <= COMP_LOOP_C_89;
      WHEN COMP_LOOP_C_89 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011110");
        state_var_NS <= COMP_LOOP_C_90;
      WHEN COMP_LOOP_C_90 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011011111");
        state_var_NS <= COMP_LOOP_C_91;
      WHEN COMP_LOOP_C_91 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100000");
        state_var_NS <= COMP_LOOP_C_92;
      WHEN COMP_LOOP_C_92 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100001");
        state_var_NS <= COMP_LOOP_C_93;
      WHEN COMP_LOOP_C_93 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100010");
        state_var_NS <= COMP_LOOP_C_94;
      WHEN COMP_LOOP_C_94 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100011");
        state_var_NS <= COMP_LOOP_C_95;
      WHEN COMP_LOOP_C_95 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100100");
        state_var_NS <= COMP_LOOP_C_96;
      WHEN COMP_LOOP_C_96 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100101");
        state_var_NS <= COMP_LOOP_C_97;
      WHEN COMP_LOOP_C_97 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100110");
        state_var_NS <= COMP_LOOP_C_98;
      WHEN COMP_LOOP_C_98 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011100111");
        state_var_NS <= COMP_LOOP_C_99;
      WHEN COMP_LOOP_C_99 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101000");
        state_var_NS <= COMP_LOOP_C_100;
      WHEN COMP_LOOP_C_100 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101001");
        state_var_NS <= COMP_LOOP_C_101;
      WHEN COMP_LOOP_C_101 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101010");
        state_var_NS <= COMP_LOOP_C_102;
      WHEN COMP_LOOP_C_102 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101011");
        state_var_NS <= COMP_LOOP_C_103;
      WHEN COMP_LOOP_C_103 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101100");
        state_var_NS <= COMP_LOOP_C_104;
      WHEN COMP_LOOP_C_104 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101101");
        state_var_NS <= COMP_LOOP_C_105;
      WHEN COMP_LOOP_C_105 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101110");
        state_var_NS <= COMP_LOOP_C_106;
      WHEN COMP_LOOP_C_106 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011101111");
        state_var_NS <= COMP_LOOP_C_107;
      WHEN COMP_LOOP_C_107 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110000");
        state_var_NS <= COMP_LOOP_C_108;
      WHEN COMP_LOOP_C_108 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110001");
        state_var_NS <= COMP_LOOP_C_109;
      WHEN COMP_LOOP_C_109 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110010");
        state_var_NS <= COMP_LOOP_C_110;
      WHEN COMP_LOOP_C_110 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110011");
        state_var_NS <= COMP_LOOP_C_111;
      WHEN COMP_LOOP_C_111 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110100");
        state_var_NS <= COMP_LOOP_C_112;
      WHEN COMP_LOOP_C_112 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110101");
        state_var_NS <= COMP_LOOP_C_113;
      WHEN COMP_LOOP_C_113 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110110");
        state_var_NS <= COMP_LOOP_C_114;
      WHEN COMP_LOOP_C_114 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011110111");
        state_var_NS <= COMP_LOOP_C_115;
      WHEN COMP_LOOP_C_115 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111000");
        state_var_NS <= COMP_LOOP_C_116;
      WHEN COMP_LOOP_C_116 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111001");
        state_var_NS <= COMP_LOOP_C_117;
      WHEN COMP_LOOP_C_117 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111010");
        state_var_NS <= COMP_LOOP_C_118;
      WHEN COMP_LOOP_C_118 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111011");
        state_var_NS <= COMP_LOOP_C_119;
      WHEN COMP_LOOP_C_119 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111100");
        state_var_NS <= COMP_LOOP_C_120;
      WHEN COMP_LOOP_C_120 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111101");
        state_var_NS <= COMP_LOOP_C_121;
      WHEN COMP_LOOP_C_121 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111110");
        state_var_NS <= COMP_LOOP_C_122;
      WHEN COMP_LOOP_C_122 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0011111111");
        state_var_NS <= COMP_LOOP_C_123;
      WHEN COMP_LOOP_C_123 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000000");
        state_var_NS <= COMP_LOOP_C_124;
      WHEN COMP_LOOP_C_124 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000001");
        state_var_NS <= COMP_LOOP_C_125;
      WHEN COMP_LOOP_C_125 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000010");
        state_var_NS <= COMP_LOOP_C_126;
      WHEN COMP_LOOP_C_126 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000011");
        state_var_NS <= COMP_LOOP_C_127;
      WHEN COMP_LOOP_C_127 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000100");
        state_var_NS <= COMP_LOOP_C_128;
      WHEN COMP_LOOP_C_128 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000101");
        state_var_NS <= COMP_LOOP_C_129;
      WHEN COMP_LOOP_C_129 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000110");
        state_var_NS <= COMP_LOOP_C_130;
      WHEN COMP_LOOP_C_130 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000111");
        IF ( COMP_LOOP_C_130_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_131;
        END IF;
      WHEN COMP_LOOP_C_131 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001000");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_0;
      WHEN COMP_LOOP_3_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001001");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_1;
      WHEN COMP_LOOP_3_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001010");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_2;
      WHEN COMP_LOOP_3_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001011");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_3;
      WHEN COMP_LOOP_3_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001100");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_4;
      WHEN COMP_LOOP_3_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001101");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_5;
      WHEN COMP_LOOP_3_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001110");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_6;
      WHEN COMP_LOOP_3_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100001111");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_7;
      WHEN COMP_LOOP_3_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010000");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_8;
      WHEN COMP_LOOP_3_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010001");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_9;
      WHEN COMP_LOOP_3_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010010");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_10;
      WHEN COMP_LOOP_3_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010011");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_11;
      WHEN COMP_LOOP_3_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010100");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_12;
      WHEN COMP_LOOP_3_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010101");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_13;
      WHEN COMP_LOOP_3_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010110");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_14;
      WHEN COMP_LOOP_3_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100010111");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_15;
      WHEN COMP_LOOP_3_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011000");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_16;
      WHEN COMP_LOOP_3_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011001");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_17;
      WHEN COMP_LOOP_3_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011010");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_18;
      WHEN COMP_LOOP_3_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011011");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_19;
      WHEN COMP_LOOP_3_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011100");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_20;
      WHEN COMP_LOOP_3_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011101");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_21;
      WHEN COMP_LOOP_3_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011110");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_22;
      WHEN COMP_LOOP_3_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100011111");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_23;
      WHEN COMP_LOOP_3_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100000");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_24;
      WHEN COMP_LOOP_3_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100001");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_25;
      WHEN COMP_LOOP_3_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100010");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_26;
      WHEN COMP_LOOP_3_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100011");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_27;
      WHEN COMP_LOOP_3_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100100");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_28;
      WHEN COMP_LOOP_3_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100101");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_29;
      WHEN COMP_LOOP_3_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100110");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_30;
      WHEN COMP_LOOP_3_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100100111");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_31;
      WHEN COMP_LOOP_3_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101000");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_32;
      WHEN COMP_LOOP_3_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101001");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_33;
      WHEN COMP_LOOP_3_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101010");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_34;
      WHEN COMP_LOOP_3_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101011");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_35;
      WHEN COMP_LOOP_3_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101100");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_36;
      WHEN COMP_LOOP_3_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101101");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_37;
      WHEN COMP_LOOP_3_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101110");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_38;
      WHEN COMP_LOOP_3_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100101111");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_39;
      WHEN COMP_LOOP_3_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110000");
        state_var_NS <= COMP_LOOP_3_modExp_1_while_C_40;
      WHEN COMP_LOOP_3_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110001");
        IF ( COMP_LOOP_3_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_132;
        ELSE
          state_var_NS <= COMP_LOOP_3_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_132 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110010");
        state_var_NS <= COMP_LOOP_C_133;
      WHEN COMP_LOOP_C_133 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110011");
        state_var_NS <= COMP_LOOP_C_134;
      WHEN COMP_LOOP_C_134 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110100");
        state_var_NS <= COMP_LOOP_C_135;
      WHEN COMP_LOOP_C_135 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110101");
        state_var_NS <= COMP_LOOP_C_136;
      WHEN COMP_LOOP_C_136 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110110");
        state_var_NS <= COMP_LOOP_C_137;
      WHEN COMP_LOOP_C_137 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100110111");
        state_var_NS <= COMP_LOOP_C_138;
      WHEN COMP_LOOP_C_138 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111000");
        state_var_NS <= COMP_LOOP_C_139;
      WHEN COMP_LOOP_C_139 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111001");
        state_var_NS <= COMP_LOOP_C_140;
      WHEN COMP_LOOP_C_140 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111010");
        state_var_NS <= COMP_LOOP_C_141;
      WHEN COMP_LOOP_C_141 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111011");
        state_var_NS <= COMP_LOOP_C_142;
      WHEN COMP_LOOP_C_142 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111100");
        state_var_NS <= COMP_LOOP_C_143;
      WHEN COMP_LOOP_C_143 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111101");
        state_var_NS <= COMP_LOOP_C_144;
      WHEN COMP_LOOP_C_144 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111110");
        state_var_NS <= COMP_LOOP_C_145;
      WHEN COMP_LOOP_C_145 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100111111");
        state_var_NS <= COMP_LOOP_C_146;
      WHEN COMP_LOOP_C_146 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000000");
        state_var_NS <= COMP_LOOP_C_147;
      WHEN COMP_LOOP_C_147 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000001");
        state_var_NS <= COMP_LOOP_C_148;
      WHEN COMP_LOOP_C_148 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000010");
        state_var_NS <= COMP_LOOP_C_149;
      WHEN COMP_LOOP_C_149 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000011");
        state_var_NS <= COMP_LOOP_C_150;
      WHEN COMP_LOOP_C_150 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000100");
        state_var_NS <= COMP_LOOP_C_151;
      WHEN COMP_LOOP_C_151 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000101");
        state_var_NS <= COMP_LOOP_C_152;
      WHEN COMP_LOOP_C_152 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000110");
        state_var_NS <= COMP_LOOP_C_153;
      WHEN COMP_LOOP_C_153 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101000111");
        state_var_NS <= COMP_LOOP_C_154;
      WHEN COMP_LOOP_C_154 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001000");
        state_var_NS <= COMP_LOOP_C_155;
      WHEN COMP_LOOP_C_155 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001001");
        state_var_NS <= COMP_LOOP_C_156;
      WHEN COMP_LOOP_C_156 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001010");
        state_var_NS <= COMP_LOOP_C_157;
      WHEN COMP_LOOP_C_157 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001011");
        state_var_NS <= COMP_LOOP_C_158;
      WHEN COMP_LOOP_C_158 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001100");
        state_var_NS <= COMP_LOOP_C_159;
      WHEN COMP_LOOP_C_159 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001101");
        state_var_NS <= COMP_LOOP_C_160;
      WHEN COMP_LOOP_C_160 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001110");
        state_var_NS <= COMP_LOOP_C_161;
      WHEN COMP_LOOP_C_161 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101001111");
        state_var_NS <= COMP_LOOP_C_162;
      WHEN COMP_LOOP_C_162 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010000");
        state_var_NS <= COMP_LOOP_C_163;
      WHEN COMP_LOOP_C_163 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010001");
        state_var_NS <= COMP_LOOP_C_164;
      WHEN COMP_LOOP_C_164 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010010");
        state_var_NS <= COMP_LOOP_C_165;
      WHEN COMP_LOOP_C_165 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010011");
        state_var_NS <= COMP_LOOP_C_166;
      WHEN COMP_LOOP_C_166 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010100");
        state_var_NS <= COMP_LOOP_C_167;
      WHEN COMP_LOOP_C_167 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010101");
        state_var_NS <= COMP_LOOP_C_168;
      WHEN COMP_LOOP_C_168 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010110");
        state_var_NS <= COMP_LOOP_C_169;
      WHEN COMP_LOOP_C_169 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101010111");
        state_var_NS <= COMP_LOOP_C_170;
      WHEN COMP_LOOP_C_170 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011000");
        state_var_NS <= COMP_LOOP_C_171;
      WHEN COMP_LOOP_C_171 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011001");
        state_var_NS <= COMP_LOOP_C_172;
      WHEN COMP_LOOP_C_172 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011010");
        state_var_NS <= COMP_LOOP_C_173;
      WHEN COMP_LOOP_C_173 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011011");
        state_var_NS <= COMP_LOOP_C_174;
      WHEN COMP_LOOP_C_174 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011100");
        state_var_NS <= COMP_LOOP_C_175;
      WHEN COMP_LOOP_C_175 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011101");
        state_var_NS <= COMP_LOOP_C_176;
      WHEN COMP_LOOP_C_176 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011110");
        state_var_NS <= COMP_LOOP_C_177;
      WHEN COMP_LOOP_C_177 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101011111");
        state_var_NS <= COMP_LOOP_C_178;
      WHEN COMP_LOOP_C_178 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100000");
        state_var_NS <= COMP_LOOP_C_179;
      WHEN COMP_LOOP_C_179 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100001");
        state_var_NS <= COMP_LOOP_C_180;
      WHEN COMP_LOOP_C_180 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100010");
        state_var_NS <= COMP_LOOP_C_181;
      WHEN COMP_LOOP_C_181 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100011");
        state_var_NS <= COMP_LOOP_C_182;
      WHEN COMP_LOOP_C_182 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100100");
        state_var_NS <= COMP_LOOP_C_183;
      WHEN COMP_LOOP_C_183 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100101");
        state_var_NS <= COMP_LOOP_C_184;
      WHEN COMP_LOOP_C_184 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100110");
        state_var_NS <= COMP_LOOP_C_185;
      WHEN COMP_LOOP_C_185 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101100111");
        state_var_NS <= COMP_LOOP_C_186;
      WHEN COMP_LOOP_C_186 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101000");
        state_var_NS <= COMP_LOOP_C_187;
      WHEN COMP_LOOP_C_187 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101001");
        state_var_NS <= COMP_LOOP_C_188;
      WHEN COMP_LOOP_C_188 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101010");
        state_var_NS <= COMP_LOOP_C_189;
      WHEN COMP_LOOP_C_189 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101011");
        state_var_NS <= COMP_LOOP_C_190;
      WHEN COMP_LOOP_C_190 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101100");
        state_var_NS <= COMP_LOOP_C_191;
      WHEN COMP_LOOP_C_191 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101101");
        state_var_NS <= COMP_LOOP_C_192;
      WHEN COMP_LOOP_C_192 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101110");
        state_var_NS <= COMP_LOOP_C_193;
      WHEN COMP_LOOP_C_193 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101101111");
        state_var_NS <= COMP_LOOP_C_194;
      WHEN COMP_LOOP_C_194 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110000");
        state_var_NS <= COMP_LOOP_C_195;
      WHEN COMP_LOOP_C_195 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110001");
        IF ( COMP_LOOP_C_195_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_196;
        END IF;
      WHEN COMP_LOOP_C_196 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110010");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_0;
      WHEN COMP_LOOP_4_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110011");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_1;
      WHEN COMP_LOOP_4_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110100");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_2;
      WHEN COMP_LOOP_4_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110101");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_3;
      WHEN COMP_LOOP_4_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110110");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_4;
      WHEN COMP_LOOP_4_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101110111");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_5;
      WHEN COMP_LOOP_4_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111000");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_6;
      WHEN COMP_LOOP_4_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111001");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_7;
      WHEN COMP_LOOP_4_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111010");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_8;
      WHEN COMP_LOOP_4_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111011");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_9;
      WHEN COMP_LOOP_4_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111100");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_10;
      WHEN COMP_LOOP_4_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111101");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_11;
      WHEN COMP_LOOP_4_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111110");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_12;
      WHEN COMP_LOOP_4_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0101111111");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_13;
      WHEN COMP_LOOP_4_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000000");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_14;
      WHEN COMP_LOOP_4_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000001");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_15;
      WHEN COMP_LOOP_4_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000010");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_16;
      WHEN COMP_LOOP_4_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000011");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_17;
      WHEN COMP_LOOP_4_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000100");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_18;
      WHEN COMP_LOOP_4_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000101");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_19;
      WHEN COMP_LOOP_4_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000110");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_20;
      WHEN COMP_LOOP_4_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110000111");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_21;
      WHEN COMP_LOOP_4_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001000");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_22;
      WHEN COMP_LOOP_4_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001001");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_23;
      WHEN COMP_LOOP_4_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001010");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_24;
      WHEN COMP_LOOP_4_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001011");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_25;
      WHEN COMP_LOOP_4_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001100");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_26;
      WHEN COMP_LOOP_4_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001101");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_27;
      WHEN COMP_LOOP_4_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001110");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_28;
      WHEN COMP_LOOP_4_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110001111");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_29;
      WHEN COMP_LOOP_4_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010000");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_30;
      WHEN COMP_LOOP_4_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010001");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_31;
      WHEN COMP_LOOP_4_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010010");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_32;
      WHEN COMP_LOOP_4_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010011");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_33;
      WHEN COMP_LOOP_4_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010100");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_34;
      WHEN COMP_LOOP_4_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010101");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_35;
      WHEN COMP_LOOP_4_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010110");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_36;
      WHEN COMP_LOOP_4_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110010111");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_37;
      WHEN COMP_LOOP_4_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011000");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_38;
      WHEN COMP_LOOP_4_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011001");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_39;
      WHEN COMP_LOOP_4_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011010");
        state_var_NS <= COMP_LOOP_4_modExp_1_while_C_40;
      WHEN COMP_LOOP_4_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011011");
        IF ( COMP_LOOP_4_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_197;
        ELSE
          state_var_NS <= COMP_LOOP_4_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_197 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011100");
        state_var_NS <= COMP_LOOP_C_198;
      WHEN COMP_LOOP_C_198 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011101");
        state_var_NS <= COMP_LOOP_C_199;
      WHEN COMP_LOOP_C_199 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011110");
        state_var_NS <= COMP_LOOP_C_200;
      WHEN COMP_LOOP_C_200 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110011111");
        state_var_NS <= COMP_LOOP_C_201;
      WHEN COMP_LOOP_C_201 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100000");
        state_var_NS <= COMP_LOOP_C_202;
      WHEN COMP_LOOP_C_202 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100001");
        state_var_NS <= COMP_LOOP_C_203;
      WHEN COMP_LOOP_C_203 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100010");
        state_var_NS <= COMP_LOOP_C_204;
      WHEN COMP_LOOP_C_204 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100011");
        state_var_NS <= COMP_LOOP_C_205;
      WHEN COMP_LOOP_C_205 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100100");
        state_var_NS <= COMP_LOOP_C_206;
      WHEN COMP_LOOP_C_206 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100101");
        state_var_NS <= COMP_LOOP_C_207;
      WHEN COMP_LOOP_C_207 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100110");
        state_var_NS <= COMP_LOOP_C_208;
      WHEN COMP_LOOP_C_208 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110100111");
        state_var_NS <= COMP_LOOP_C_209;
      WHEN COMP_LOOP_C_209 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101000");
        state_var_NS <= COMP_LOOP_C_210;
      WHEN COMP_LOOP_C_210 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101001");
        state_var_NS <= COMP_LOOP_C_211;
      WHEN COMP_LOOP_C_211 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101010");
        state_var_NS <= COMP_LOOP_C_212;
      WHEN COMP_LOOP_C_212 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101011");
        state_var_NS <= COMP_LOOP_C_213;
      WHEN COMP_LOOP_C_213 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101100");
        state_var_NS <= COMP_LOOP_C_214;
      WHEN COMP_LOOP_C_214 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101101");
        state_var_NS <= COMP_LOOP_C_215;
      WHEN COMP_LOOP_C_215 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101110");
        state_var_NS <= COMP_LOOP_C_216;
      WHEN COMP_LOOP_C_216 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110101111");
        state_var_NS <= COMP_LOOP_C_217;
      WHEN COMP_LOOP_C_217 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110000");
        state_var_NS <= COMP_LOOP_C_218;
      WHEN COMP_LOOP_C_218 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110001");
        state_var_NS <= COMP_LOOP_C_219;
      WHEN COMP_LOOP_C_219 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110010");
        state_var_NS <= COMP_LOOP_C_220;
      WHEN COMP_LOOP_C_220 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110011");
        state_var_NS <= COMP_LOOP_C_221;
      WHEN COMP_LOOP_C_221 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110100");
        state_var_NS <= COMP_LOOP_C_222;
      WHEN COMP_LOOP_C_222 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110101");
        state_var_NS <= COMP_LOOP_C_223;
      WHEN COMP_LOOP_C_223 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110110");
        state_var_NS <= COMP_LOOP_C_224;
      WHEN COMP_LOOP_C_224 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110110111");
        state_var_NS <= COMP_LOOP_C_225;
      WHEN COMP_LOOP_C_225 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111000");
        state_var_NS <= COMP_LOOP_C_226;
      WHEN COMP_LOOP_C_226 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111001");
        state_var_NS <= COMP_LOOP_C_227;
      WHEN COMP_LOOP_C_227 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111010");
        state_var_NS <= COMP_LOOP_C_228;
      WHEN COMP_LOOP_C_228 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111011");
        state_var_NS <= COMP_LOOP_C_229;
      WHEN COMP_LOOP_C_229 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111100");
        state_var_NS <= COMP_LOOP_C_230;
      WHEN COMP_LOOP_C_230 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111101");
        state_var_NS <= COMP_LOOP_C_231;
      WHEN COMP_LOOP_C_231 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111110");
        state_var_NS <= COMP_LOOP_C_232;
      WHEN COMP_LOOP_C_232 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0110111111");
        state_var_NS <= COMP_LOOP_C_233;
      WHEN COMP_LOOP_C_233 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000000");
        state_var_NS <= COMP_LOOP_C_234;
      WHEN COMP_LOOP_C_234 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000001");
        state_var_NS <= COMP_LOOP_C_235;
      WHEN COMP_LOOP_C_235 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000010");
        state_var_NS <= COMP_LOOP_C_236;
      WHEN COMP_LOOP_C_236 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000011");
        state_var_NS <= COMP_LOOP_C_237;
      WHEN COMP_LOOP_C_237 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000100");
        state_var_NS <= COMP_LOOP_C_238;
      WHEN COMP_LOOP_C_238 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000101");
        state_var_NS <= COMP_LOOP_C_239;
      WHEN COMP_LOOP_C_239 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000110");
        state_var_NS <= COMP_LOOP_C_240;
      WHEN COMP_LOOP_C_240 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111000111");
        state_var_NS <= COMP_LOOP_C_241;
      WHEN COMP_LOOP_C_241 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001000");
        state_var_NS <= COMP_LOOP_C_242;
      WHEN COMP_LOOP_C_242 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001001");
        state_var_NS <= COMP_LOOP_C_243;
      WHEN COMP_LOOP_C_243 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001010");
        state_var_NS <= COMP_LOOP_C_244;
      WHEN COMP_LOOP_C_244 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001011");
        state_var_NS <= COMP_LOOP_C_245;
      WHEN COMP_LOOP_C_245 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001100");
        state_var_NS <= COMP_LOOP_C_246;
      WHEN COMP_LOOP_C_246 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001101");
        state_var_NS <= COMP_LOOP_C_247;
      WHEN COMP_LOOP_C_247 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001110");
        state_var_NS <= COMP_LOOP_C_248;
      WHEN COMP_LOOP_C_248 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111001111");
        state_var_NS <= COMP_LOOP_C_249;
      WHEN COMP_LOOP_C_249 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010000");
        state_var_NS <= COMP_LOOP_C_250;
      WHEN COMP_LOOP_C_250 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010001");
        state_var_NS <= COMP_LOOP_C_251;
      WHEN COMP_LOOP_C_251 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010010");
        state_var_NS <= COMP_LOOP_C_252;
      WHEN COMP_LOOP_C_252 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010011");
        state_var_NS <= COMP_LOOP_C_253;
      WHEN COMP_LOOP_C_253 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010100");
        state_var_NS <= COMP_LOOP_C_254;
      WHEN COMP_LOOP_C_254 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010101");
        state_var_NS <= COMP_LOOP_C_255;
      WHEN COMP_LOOP_C_255 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010110");
        state_var_NS <= COMP_LOOP_C_256;
      WHEN COMP_LOOP_C_256 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111010111");
        state_var_NS <= COMP_LOOP_C_257;
      WHEN COMP_LOOP_C_257 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011000");
        state_var_NS <= COMP_LOOP_C_258;
      WHEN COMP_LOOP_C_258 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011001");
        state_var_NS <= COMP_LOOP_C_259;
      WHEN COMP_LOOP_C_259 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011010");
        state_var_NS <= COMP_LOOP_C_260;
      WHEN COMP_LOOP_C_260 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011011");
        IF ( COMP_LOOP_C_260_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_261;
        END IF;
      WHEN COMP_LOOP_C_261 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011100");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_0;
      WHEN COMP_LOOP_5_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011101");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_1;
      WHEN COMP_LOOP_5_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011110");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_2;
      WHEN COMP_LOOP_5_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111011111");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_3;
      WHEN COMP_LOOP_5_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100000");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_4;
      WHEN COMP_LOOP_5_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100001");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_5;
      WHEN COMP_LOOP_5_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100010");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_6;
      WHEN COMP_LOOP_5_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100011");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_7;
      WHEN COMP_LOOP_5_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100100");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_8;
      WHEN COMP_LOOP_5_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100101");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_9;
      WHEN COMP_LOOP_5_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100110");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_10;
      WHEN COMP_LOOP_5_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111100111");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_11;
      WHEN COMP_LOOP_5_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101000");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_12;
      WHEN COMP_LOOP_5_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101001");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_13;
      WHEN COMP_LOOP_5_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101010");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_14;
      WHEN COMP_LOOP_5_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101011");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_15;
      WHEN COMP_LOOP_5_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101100");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_16;
      WHEN COMP_LOOP_5_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101101");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_17;
      WHEN COMP_LOOP_5_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101110");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_18;
      WHEN COMP_LOOP_5_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111101111");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_19;
      WHEN COMP_LOOP_5_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110000");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_20;
      WHEN COMP_LOOP_5_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110001");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_21;
      WHEN COMP_LOOP_5_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110010");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_22;
      WHEN COMP_LOOP_5_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110011");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_23;
      WHEN COMP_LOOP_5_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110100");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_24;
      WHEN COMP_LOOP_5_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110101");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_25;
      WHEN COMP_LOOP_5_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110110");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_26;
      WHEN COMP_LOOP_5_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111110111");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_27;
      WHEN COMP_LOOP_5_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111000");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_28;
      WHEN COMP_LOOP_5_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111001");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_29;
      WHEN COMP_LOOP_5_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111010");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_30;
      WHEN COMP_LOOP_5_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111011");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_31;
      WHEN COMP_LOOP_5_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111100");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_32;
      WHEN COMP_LOOP_5_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111101");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_33;
      WHEN COMP_LOOP_5_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111110");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_34;
      WHEN COMP_LOOP_5_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0111111111");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_35;
      WHEN COMP_LOOP_5_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000000");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_36;
      WHEN COMP_LOOP_5_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000001");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_37;
      WHEN COMP_LOOP_5_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000010");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_38;
      WHEN COMP_LOOP_5_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000011");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_39;
      WHEN COMP_LOOP_5_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000100");
        state_var_NS <= COMP_LOOP_5_modExp_1_while_C_40;
      WHEN COMP_LOOP_5_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000101");
        IF ( COMP_LOOP_5_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_262;
        ELSE
          state_var_NS <= COMP_LOOP_5_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_262 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000110");
        state_var_NS <= COMP_LOOP_C_263;
      WHEN COMP_LOOP_C_263 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000111");
        state_var_NS <= COMP_LOOP_C_264;
      WHEN COMP_LOOP_C_264 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001000");
        state_var_NS <= COMP_LOOP_C_265;
      WHEN COMP_LOOP_C_265 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001001");
        state_var_NS <= COMP_LOOP_C_266;
      WHEN COMP_LOOP_C_266 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001010");
        state_var_NS <= COMP_LOOP_C_267;
      WHEN COMP_LOOP_C_267 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001011");
        state_var_NS <= COMP_LOOP_C_268;
      WHEN COMP_LOOP_C_268 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001100");
        state_var_NS <= COMP_LOOP_C_269;
      WHEN COMP_LOOP_C_269 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001101");
        state_var_NS <= COMP_LOOP_C_270;
      WHEN COMP_LOOP_C_270 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001110");
        state_var_NS <= COMP_LOOP_C_271;
      WHEN COMP_LOOP_C_271 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000001111");
        state_var_NS <= COMP_LOOP_C_272;
      WHEN COMP_LOOP_C_272 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010000");
        state_var_NS <= COMP_LOOP_C_273;
      WHEN COMP_LOOP_C_273 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010001");
        state_var_NS <= COMP_LOOP_C_274;
      WHEN COMP_LOOP_C_274 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010010");
        state_var_NS <= COMP_LOOP_C_275;
      WHEN COMP_LOOP_C_275 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010011");
        state_var_NS <= COMP_LOOP_C_276;
      WHEN COMP_LOOP_C_276 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010100");
        state_var_NS <= COMP_LOOP_C_277;
      WHEN COMP_LOOP_C_277 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010101");
        state_var_NS <= COMP_LOOP_C_278;
      WHEN COMP_LOOP_C_278 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010110");
        state_var_NS <= COMP_LOOP_C_279;
      WHEN COMP_LOOP_C_279 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000010111");
        state_var_NS <= COMP_LOOP_C_280;
      WHEN COMP_LOOP_C_280 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011000");
        state_var_NS <= COMP_LOOP_C_281;
      WHEN COMP_LOOP_C_281 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011001");
        state_var_NS <= COMP_LOOP_C_282;
      WHEN COMP_LOOP_C_282 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011010");
        state_var_NS <= COMP_LOOP_C_283;
      WHEN COMP_LOOP_C_283 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011011");
        state_var_NS <= COMP_LOOP_C_284;
      WHEN COMP_LOOP_C_284 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011100");
        state_var_NS <= COMP_LOOP_C_285;
      WHEN COMP_LOOP_C_285 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011101");
        state_var_NS <= COMP_LOOP_C_286;
      WHEN COMP_LOOP_C_286 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011110");
        state_var_NS <= COMP_LOOP_C_287;
      WHEN COMP_LOOP_C_287 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000011111");
        state_var_NS <= COMP_LOOP_C_288;
      WHEN COMP_LOOP_C_288 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100000");
        state_var_NS <= COMP_LOOP_C_289;
      WHEN COMP_LOOP_C_289 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100001");
        state_var_NS <= COMP_LOOP_C_290;
      WHEN COMP_LOOP_C_290 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100010");
        state_var_NS <= COMP_LOOP_C_291;
      WHEN COMP_LOOP_C_291 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100011");
        state_var_NS <= COMP_LOOP_C_292;
      WHEN COMP_LOOP_C_292 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100100");
        state_var_NS <= COMP_LOOP_C_293;
      WHEN COMP_LOOP_C_293 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100101");
        state_var_NS <= COMP_LOOP_C_294;
      WHEN COMP_LOOP_C_294 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100110");
        state_var_NS <= COMP_LOOP_C_295;
      WHEN COMP_LOOP_C_295 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000100111");
        state_var_NS <= COMP_LOOP_C_296;
      WHEN COMP_LOOP_C_296 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101000");
        state_var_NS <= COMP_LOOP_C_297;
      WHEN COMP_LOOP_C_297 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101001");
        state_var_NS <= COMP_LOOP_C_298;
      WHEN COMP_LOOP_C_298 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101010");
        state_var_NS <= COMP_LOOP_C_299;
      WHEN COMP_LOOP_C_299 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101011");
        state_var_NS <= COMP_LOOP_C_300;
      WHEN COMP_LOOP_C_300 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101100");
        state_var_NS <= COMP_LOOP_C_301;
      WHEN COMP_LOOP_C_301 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101101");
        state_var_NS <= COMP_LOOP_C_302;
      WHEN COMP_LOOP_C_302 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101110");
        state_var_NS <= COMP_LOOP_C_303;
      WHEN COMP_LOOP_C_303 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000101111");
        state_var_NS <= COMP_LOOP_C_304;
      WHEN COMP_LOOP_C_304 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110000");
        state_var_NS <= COMP_LOOP_C_305;
      WHEN COMP_LOOP_C_305 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110001");
        state_var_NS <= COMP_LOOP_C_306;
      WHEN COMP_LOOP_C_306 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110010");
        state_var_NS <= COMP_LOOP_C_307;
      WHEN COMP_LOOP_C_307 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110011");
        state_var_NS <= COMP_LOOP_C_308;
      WHEN COMP_LOOP_C_308 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110100");
        state_var_NS <= COMP_LOOP_C_309;
      WHEN COMP_LOOP_C_309 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110101");
        state_var_NS <= COMP_LOOP_C_310;
      WHEN COMP_LOOP_C_310 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110110");
        state_var_NS <= COMP_LOOP_C_311;
      WHEN COMP_LOOP_C_311 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000110111");
        state_var_NS <= COMP_LOOP_C_312;
      WHEN COMP_LOOP_C_312 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111000");
        state_var_NS <= COMP_LOOP_C_313;
      WHEN COMP_LOOP_C_313 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111001");
        state_var_NS <= COMP_LOOP_C_314;
      WHEN COMP_LOOP_C_314 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111010");
        state_var_NS <= COMP_LOOP_C_315;
      WHEN COMP_LOOP_C_315 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111011");
        state_var_NS <= COMP_LOOP_C_316;
      WHEN COMP_LOOP_C_316 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111100");
        state_var_NS <= COMP_LOOP_C_317;
      WHEN COMP_LOOP_C_317 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111101");
        state_var_NS <= COMP_LOOP_C_318;
      WHEN COMP_LOOP_C_318 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111110");
        state_var_NS <= COMP_LOOP_C_319;
      WHEN COMP_LOOP_C_319 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000111111");
        state_var_NS <= COMP_LOOP_C_320;
      WHEN COMP_LOOP_C_320 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000000");
        state_var_NS <= COMP_LOOP_C_321;
      WHEN COMP_LOOP_C_321 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000001");
        state_var_NS <= COMP_LOOP_C_322;
      WHEN COMP_LOOP_C_322 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000010");
        state_var_NS <= COMP_LOOP_C_323;
      WHEN COMP_LOOP_C_323 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000011");
        state_var_NS <= COMP_LOOP_C_324;
      WHEN COMP_LOOP_C_324 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000100");
        state_var_NS <= COMP_LOOP_C_325;
      WHEN COMP_LOOP_C_325 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000101");
        IF ( COMP_LOOP_C_325_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_326;
        END IF;
      WHEN COMP_LOOP_C_326 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000110");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_0;
      WHEN COMP_LOOP_6_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001000111");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_1;
      WHEN COMP_LOOP_6_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001000");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_2;
      WHEN COMP_LOOP_6_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001001");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_3;
      WHEN COMP_LOOP_6_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001010");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_4;
      WHEN COMP_LOOP_6_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001011");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_5;
      WHEN COMP_LOOP_6_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001100");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_6;
      WHEN COMP_LOOP_6_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001101");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_7;
      WHEN COMP_LOOP_6_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001110");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_8;
      WHEN COMP_LOOP_6_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001001111");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_9;
      WHEN COMP_LOOP_6_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010000");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_10;
      WHEN COMP_LOOP_6_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010001");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_11;
      WHEN COMP_LOOP_6_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010010");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_12;
      WHEN COMP_LOOP_6_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010011");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_13;
      WHEN COMP_LOOP_6_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010100");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_14;
      WHEN COMP_LOOP_6_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010101");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_15;
      WHEN COMP_LOOP_6_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010110");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_16;
      WHEN COMP_LOOP_6_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001010111");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_17;
      WHEN COMP_LOOP_6_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011000");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_18;
      WHEN COMP_LOOP_6_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011001");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_19;
      WHEN COMP_LOOP_6_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011010");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_20;
      WHEN COMP_LOOP_6_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011011");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_21;
      WHEN COMP_LOOP_6_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011100");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_22;
      WHEN COMP_LOOP_6_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011101");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_23;
      WHEN COMP_LOOP_6_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011110");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_24;
      WHEN COMP_LOOP_6_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001011111");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_25;
      WHEN COMP_LOOP_6_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100000");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_26;
      WHEN COMP_LOOP_6_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100001");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_27;
      WHEN COMP_LOOP_6_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100010");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_28;
      WHEN COMP_LOOP_6_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100011");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_29;
      WHEN COMP_LOOP_6_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100100");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_30;
      WHEN COMP_LOOP_6_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100101");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_31;
      WHEN COMP_LOOP_6_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100110");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_32;
      WHEN COMP_LOOP_6_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001100111");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_33;
      WHEN COMP_LOOP_6_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101000");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_34;
      WHEN COMP_LOOP_6_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101001");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_35;
      WHEN COMP_LOOP_6_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101010");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_36;
      WHEN COMP_LOOP_6_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101011");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_37;
      WHEN COMP_LOOP_6_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101100");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_38;
      WHEN COMP_LOOP_6_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101101");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_39;
      WHEN COMP_LOOP_6_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101110");
        state_var_NS <= COMP_LOOP_6_modExp_1_while_C_40;
      WHEN COMP_LOOP_6_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001101111");
        IF ( COMP_LOOP_6_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_327;
        ELSE
          state_var_NS <= COMP_LOOP_6_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_327 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110000");
        state_var_NS <= COMP_LOOP_C_328;
      WHEN COMP_LOOP_C_328 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110001");
        state_var_NS <= COMP_LOOP_C_329;
      WHEN COMP_LOOP_C_329 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110010");
        state_var_NS <= COMP_LOOP_C_330;
      WHEN COMP_LOOP_C_330 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110011");
        state_var_NS <= COMP_LOOP_C_331;
      WHEN COMP_LOOP_C_331 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110100");
        state_var_NS <= COMP_LOOP_C_332;
      WHEN COMP_LOOP_C_332 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110101");
        state_var_NS <= COMP_LOOP_C_333;
      WHEN COMP_LOOP_C_333 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110110");
        state_var_NS <= COMP_LOOP_C_334;
      WHEN COMP_LOOP_C_334 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001110111");
        state_var_NS <= COMP_LOOP_C_335;
      WHEN COMP_LOOP_C_335 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111000");
        state_var_NS <= COMP_LOOP_C_336;
      WHEN COMP_LOOP_C_336 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111001");
        state_var_NS <= COMP_LOOP_C_337;
      WHEN COMP_LOOP_C_337 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111010");
        state_var_NS <= COMP_LOOP_C_338;
      WHEN COMP_LOOP_C_338 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111011");
        state_var_NS <= COMP_LOOP_C_339;
      WHEN COMP_LOOP_C_339 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111100");
        state_var_NS <= COMP_LOOP_C_340;
      WHEN COMP_LOOP_C_340 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111101");
        state_var_NS <= COMP_LOOP_C_341;
      WHEN COMP_LOOP_C_341 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111110");
        state_var_NS <= COMP_LOOP_C_342;
      WHEN COMP_LOOP_C_342 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1001111111");
        state_var_NS <= COMP_LOOP_C_343;
      WHEN COMP_LOOP_C_343 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000000");
        state_var_NS <= COMP_LOOP_C_344;
      WHEN COMP_LOOP_C_344 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000001");
        state_var_NS <= COMP_LOOP_C_345;
      WHEN COMP_LOOP_C_345 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000010");
        state_var_NS <= COMP_LOOP_C_346;
      WHEN COMP_LOOP_C_346 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000011");
        state_var_NS <= COMP_LOOP_C_347;
      WHEN COMP_LOOP_C_347 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000100");
        state_var_NS <= COMP_LOOP_C_348;
      WHEN COMP_LOOP_C_348 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000101");
        state_var_NS <= COMP_LOOP_C_349;
      WHEN COMP_LOOP_C_349 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000110");
        state_var_NS <= COMP_LOOP_C_350;
      WHEN COMP_LOOP_C_350 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010000111");
        state_var_NS <= COMP_LOOP_C_351;
      WHEN COMP_LOOP_C_351 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001000");
        state_var_NS <= COMP_LOOP_C_352;
      WHEN COMP_LOOP_C_352 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001001");
        state_var_NS <= COMP_LOOP_C_353;
      WHEN COMP_LOOP_C_353 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001010");
        state_var_NS <= COMP_LOOP_C_354;
      WHEN COMP_LOOP_C_354 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001011");
        state_var_NS <= COMP_LOOP_C_355;
      WHEN COMP_LOOP_C_355 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001100");
        state_var_NS <= COMP_LOOP_C_356;
      WHEN COMP_LOOP_C_356 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001101");
        state_var_NS <= COMP_LOOP_C_357;
      WHEN COMP_LOOP_C_357 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001110");
        state_var_NS <= COMP_LOOP_C_358;
      WHEN COMP_LOOP_C_358 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010001111");
        state_var_NS <= COMP_LOOP_C_359;
      WHEN COMP_LOOP_C_359 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010000");
        state_var_NS <= COMP_LOOP_C_360;
      WHEN COMP_LOOP_C_360 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010001");
        state_var_NS <= COMP_LOOP_C_361;
      WHEN COMP_LOOP_C_361 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010010");
        state_var_NS <= COMP_LOOP_C_362;
      WHEN COMP_LOOP_C_362 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010011");
        state_var_NS <= COMP_LOOP_C_363;
      WHEN COMP_LOOP_C_363 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010100");
        state_var_NS <= COMP_LOOP_C_364;
      WHEN COMP_LOOP_C_364 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010101");
        state_var_NS <= COMP_LOOP_C_365;
      WHEN COMP_LOOP_C_365 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010110");
        state_var_NS <= COMP_LOOP_C_366;
      WHEN COMP_LOOP_C_366 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010010111");
        state_var_NS <= COMP_LOOP_C_367;
      WHEN COMP_LOOP_C_367 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011000");
        state_var_NS <= COMP_LOOP_C_368;
      WHEN COMP_LOOP_C_368 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011001");
        state_var_NS <= COMP_LOOP_C_369;
      WHEN COMP_LOOP_C_369 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011010");
        state_var_NS <= COMP_LOOP_C_370;
      WHEN COMP_LOOP_C_370 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011011");
        state_var_NS <= COMP_LOOP_C_371;
      WHEN COMP_LOOP_C_371 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011100");
        state_var_NS <= COMP_LOOP_C_372;
      WHEN COMP_LOOP_C_372 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011101");
        state_var_NS <= COMP_LOOP_C_373;
      WHEN COMP_LOOP_C_373 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011110");
        state_var_NS <= COMP_LOOP_C_374;
      WHEN COMP_LOOP_C_374 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010011111");
        state_var_NS <= COMP_LOOP_C_375;
      WHEN COMP_LOOP_C_375 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100000");
        state_var_NS <= COMP_LOOP_C_376;
      WHEN COMP_LOOP_C_376 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100001");
        state_var_NS <= COMP_LOOP_C_377;
      WHEN COMP_LOOP_C_377 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100010");
        state_var_NS <= COMP_LOOP_C_378;
      WHEN COMP_LOOP_C_378 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100011");
        state_var_NS <= COMP_LOOP_C_379;
      WHEN COMP_LOOP_C_379 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100100");
        state_var_NS <= COMP_LOOP_C_380;
      WHEN COMP_LOOP_C_380 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100101");
        state_var_NS <= COMP_LOOP_C_381;
      WHEN COMP_LOOP_C_381 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100110");
        state_var_NS <= COMP_LOOP_C_382;
      WHEN COMP_LOOP_C_382 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010100111");
        state_var_NS <= COMP_LOOP_C_383;
      WHEN COMP_LOOP_C_383 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101000");
        state_var_NS <= COMP_LOOP_C_384;
      WHEN COMP_LOOP_C_384 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101001");
        state_var_NS <= COMP_LOOP_C_385;
      WHEN COMP_LOOP_C_385 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101010");
        state_var_NS <= COMP_LOOP_C_386;
      WHEN COMP_LOOP_C_386 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101011");
        state_var_NS <= COMP_LOOP_C_387;
      WHEN COMP_LOOP_C_387 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101100");
        state_var_NS <= COMP_LOOP_C_388;
      WHEN COMP_LOOP_C_388 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101101");
        state_var_NS <= COMP_LOOP_C_389;
      WHEN COMP_LOOP_C_389 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101110");
        state_var_NS <= COMP_LOOP_C_390;
      WHEN COMP_LOOP_C_390 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010101111");
        IF ( COMP_LOOP_C_390_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_391;
        END IF;
      WHEN COMP_LOOP_C_391 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110000");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_0;
      WHEN COMP_LOOP_7_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110001");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_1;
      WHEN COMP_LOOP_7_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110010");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_2;
      WHEN COMP_LOOP_7_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110011");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_3;
      WHEN COMP_LOOP_7_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110100");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_4;
      WHEN COMP_LOOP_7_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110101");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_5;
      WHEN COMP_LOOP_7_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110110");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_6;
      WHEN COMP_LOOP_7_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010110111");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_7;
      WHEN COMP_LOOP_7_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111000");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_8;
      WHEN COMP_LOOP_7_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111001");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_9;
      WHEN COMP_LOOP_7_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111010");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_10;
      WHEN COMP_LOOP_7_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111011");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_11;
      WHEN COMP_LOOP_7_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111100");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_12;
      WHEN COMP_LOOP_7_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111101");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_13;
      WHEN COMP_LOOP_7_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111110");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_14;
      WHEN COMP_LOOP_7_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1010111111");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_15;
      WHEN COMP_LOOP_7_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000000");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_16;
      WHEN COMP_LOOP_7_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000001");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_17;
      WHEN COMP_LOOP_7_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000010");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_18;
      WHEN COMP_LOOP_7_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000011");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_19;
      WHEN COMP_LOOP_7_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000100");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_20;
      WHEN COMP_LOOP_7_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000101");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_21;
      WHEN COMP_LOOP_7_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000110");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_22;
      WHEN COMP_LOOP_7_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011000111");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_23;
      WHEN COMP_LOOP_7_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001000");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_24;
      WHEN COMP_LOOP_7_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001001");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_25;
      WHEN COMP_LOOP_7_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001010");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_26;
      WHEN COMP_LOOP_7_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001011");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_27;
      WHEN COMP_LOOP_7_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001100");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_28;
      WHEN COMP_LOOP_7_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001101");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_29;
      WHEN COMP_LOOP_7_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001110");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_30;
      WHEN COMP_LOOP_7_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011001111");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_31;
      WHEN COMP_LOOP_7_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010000");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_32;
      WHEN COMP_LOOP_7_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010001");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_33;
      WHEN COMP_LOOP_7_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010010");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_34;
      WHEN COMP_LOOP_7_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010011");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_35;
      WHEN COMP_LOOP_7_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010100");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_36;
      WHEN COMP_LOOP_7_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010101");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_37;
      WHEN COMP_LOOP_7_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010110");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_38;
      WHEN COMP_LOOP_7_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011010111");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_39;
      WHEN COMP_LOOP_7_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011000");
        state_var_NS <= COMP_LOOP_7_modExp_1_while_C_40;
      WHEN COMP_LOOP_7_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011001");
        IF ( COMP_LOOP_7_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_392;
        ELSE
          state_var_NS <= COMP_LOOP_7_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_392 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011010");
        state_var_NS <= COMP_LOOP_C_393;
      WHEN COMP_LOOP_C_393 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011011");
        state_var_NS <= COMP_LOOP_C_394;
      WHEN COMP_LOOP_C_394 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011100");
        state_var_NS <= COMP_LOOP_C_395;
      WHEN COMP_LOOP_C_395 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011101");
        state_var_NS <= COMP_LOOP_C_396;
      WHEN COMP_LOOP_C_396 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011110");
        state_var_NS <= COMP_LOOP_C_397;
      WHEN COMP_LOOP_C_397 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011011111");
        state_var_NS <= COMP_LOOP_C_398;
      WHEN COMP_LOOP_C_398 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100000");
        state_var_NS <= COMP_LOOP_C_399;
      WHEN COMP_LOOP_C_399 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100001");
        state_var_NS <= COMP_LOOP_C_400;
      WHEN COMP_LOOP_C_400 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100010");
        state_var_NS <= COMP_LOOP_C_401;
      WHEN COMP_LOOP_C_401 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100011");
        state_var_NS <= COMP_LOOP_C_402;
      WHEN COMP_LOOP_C_402 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100100");
        state_var_NS <= COMP_LOOP_C_403;
      WHEN COMP_LOOP_C_403 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100101");
        state_var_NS <= COMP_LOOP_C_404;
      WHEN COMP_LOOP_C_404 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100110");
        state_var_NS <= COMP_LOOP_C_405;
      WHEN COMP_LOOP_C_405 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011100111");
        state_var_NS <= COMP_LOOP_C_406;
      WHEN COMP_LOOP_C_406 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101000");
        state_var_NS <= COMP_LOOP_C_407;
      WHEN COMP_LOOP_C_407 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101001");
        state_var_NS <= COMP_LOOP_C_408;
      WHEN COMP_LOOP_C_408 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101010");
        state_var_NS <= COMP_LOOP_C_409;
      WHEN COMP_LOOP_C_409 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101011");
        state_var_NS <= COMP_LOOP_C_410;
      WHEN COMP_LOOP_C_410 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101100");
        state_var_NS <= COMP_LOOP_C_411;
      WHEN COMP_LOOP_C_411 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101101");
        state_var_NS <= COMP_LOOP_C_412;
      WHEN COMP_LOOP_C_412 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101110");
        state_var_NS <= COMP_LOOP_C_413;
      WHEN COMP_LOOP_C_413 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011101111");
        state_var_NS <= COMP_LOOP_C_414;
      WHEN COMP_LOOP_C_414 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110000");
        state_var_NS <= COMP_LOOP_C_415;
      WHEN COMP_LOOP_C_415 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110001");
        state_var_NS <= COMP_LOOP_C_416;
      WHEN COMP_LOOP_C_416 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110010");
        state_var_NS <= COMP_LOOP_C_417;
      WHEN COMP_LOOP_C_417 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110011");
        state_var_NS <= COMP_LOOP_C_418;
      WHEN COMP_LOOP_C_418 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110100");
        state_var_NS <= COMP_LOOP_C_419;
      WHEN COMP_LOOP_C_419 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110101");
        state_var_NS <= COMP_LOOP_C_420;
      WHEN COMP_LOOP_C_420 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110110");
        state_var_NS <= COMP_LOOP_C_421;
      WHEN COMP_LOOP_C_421 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011110111");
        state_var_NS <= COMP_LOOP_C_422;
      WHEN COMP_LOOP_C_422 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111000");
        state_var_NS <= COMP_LOOP_C_423;
      WHEN COMP_LOOP_C_423 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111001");
        state_var_NS <= COMP_LOOP_C_424;
      WHEN COMP_LOOP_C_424 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111010");
        state_var_NS <= COMP_LOOP_C_425;
      WHEN COMP_LOOP_C_425 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111011");
        state_var_NS <= COMP_LOOP_C_426;
      WHEN COMP_LOOP_C_426 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111100");
        state_var_NS <= COMP_LOOP_C_427;
      WHEN COMP_LOOP_C_427 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111101");
        state_var_NS <= COMP_LOOP_C_428;
      WHEN COMP_LOOP_C_428 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111110");
        state_var_NS <= COMP_LOOP_C_429;
      WHEN COMP_LOOP_C_429 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1011111111");
        state_var_NS <= COMP_LOOP_C_430;
      WHEN COMP_LOOP_C_430 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000000");
        state_var_NS <= COMP_LOOP_C_431;
      WHEN COMP_LOOP_C_431 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000001");
        state_var_NS <= COMP_LOOP_C_432;
      WHEN COMP_LOOP_C_432 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000010");
        state_var_NS <= COMP_LOOP_C_433;
      WHEN COMP_LOOP_C_433 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000011");
        state_var_NS <= COMP_LOOP_C_434;
      WHEN COMP_LOOP_C_434 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000100");
        state_var_NS <= COMP_LOOP_C_435;
      WHEN COMP_LOOP_C_435 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000101");
        state_var_NS <= COMP_LOOP_C_436;
      WHEN COMP_LOOP_C_436 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000110");
        state_var_NS <= COMP_LOOP_C_437;
      WHEN COMP_LOOP_C_437 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100000111");
        state_var_NS <= COMP_LOOP_C_438;
      WHEN COMP_LOOP_C_438 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001000");
        state_var_NS <= COMP_LOOP_C_439;
      WHEN COMP_LOOP_C_439 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001001");
        state_var_NS <= COMP_LOOP_C_440;
      WHEN COMP_LOOP_C_440 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001010");
        state_var_NS <= COMP_LOOP_C_441;
      WHEN COMP_LOOP_C_441 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001011");
        state_var_NS <= COMP_LOOP_C_442;
      WHEN COMP_LOOP_C_442 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001100");
        state_var_NS <= COMP_LOOP_C_443;
      WHEN COMP_LOOP_C_443 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001101");
        state_var_NS <= COMP_LOOP_C_444;
      WHEN COMP_LOOP_C_444 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001110");
        state_var_NS <= COMP_LOOP_C_445;
      WHEN COMP_LOOP_C_445 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100001111");
        state_var_NS <= COMP_LOOP_C_446;
      WHEN COMP_LOOP_C_446 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010000");
        state_var_NS <= COMP_LOOP_C_447;
      WHEN COMP_LOOP_C_447 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010001");
        state_var_NS <= COMP_LOOP_C_448;
      WHEN COMP_LOOP_C_448 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010010");
        state_var_NS <= COMP_LOOP_C_449;
      WHEN COMP_LOOP_C_449 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010011");
        state_var_NS <= COMP_LOOP_C_450;
      WHEN COMP_LOOP_C_450 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010100");
        state_var_NS <= COMP_LOOP_C_451;
      WHEN COMP_LOOP_C_451 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010101");
        state_var_NS <= COMP_LOOP_C_452;
      WHEN COMP_LOOP_C_452 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010110");
        state_var_NS <= COMP_LOOP_C_453;
      WHEN COMP_LOOP_C_453 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100010111");
        state_var_NS <= COMP_LOOP_C_454;
      WHEN COMP_LOOP_C_454 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011000");
        state_var_NS <= COMP_LOOP_C_455;
      WHEN COMP_LOOP_C_455 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011001");
        IF ( COMP_LOOP_C_455_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_456;
        END IF;
      WHEN COMP_LOOP_C_456 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011010");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_0;
      WHEN COMP_LOOP_8_modExp_1_while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011011");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_1;
      WHEN COMP_LOOP_8_modExp_1_while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011100");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_2;
      WHEN COMP_LOOP_8_modExp_1_while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011101");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_3;
      WHEN COMP_LOOP_8_modExp_1_while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011110");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_4;
      WHEN COMP_LOOP_8_modExp_1_while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100011111");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_5;
      WHEN COMP_LOOP_8_modExp_1_while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100000");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_6;
      WHEN COMP_LOOP_8_modExp_1_while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100001");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_7;
      WHEN COMP_LOOP_8_modExp_1_while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100010");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_8;
      WHEN COMP_LOOP_8_modExp_1_while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100011");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_9;
      WHEN COMP_LOOP_8_modExp_1_while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100100");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_10;
      WHEN COMP_LOOP_8_modExp_1_while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100101");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_11;
      WHEN COMP_LOOP_8_modExp_1_while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100110");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_12;
      WHEN COMP_LOOP_8_modExp_1_while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100100111");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_13;
      WHEN COMP_LOOP_8_modExp_1_while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101000");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_14;
      WHEN COMP_LOOP_8_modExp_1_while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101001");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_15;
      WHEN COMP_LOOP_8_modExp_1_while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101010");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_16;
      WHEN COMP_LOOP_8_modExp_1_while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101011");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_17;
      WHEN COMP_LOOP_8_modExp_1_while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101100");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_18;
      WHEN COMP_LOOP_8_modExp_1_while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101101");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_19;
      WHEN COMP_LOOP_8_modExp_1_while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101110");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_20;
      WHEN COMP_LOOP_8_modExp_1_while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100101111");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_21;
      WHEN COMP_LOOP_8_modExp_1_while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110000");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_22;
      WHEN COMP_LOOP_8_modExp_1_while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110001");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_23;
      WHEN COMP_LOOP_8_modExp_1_while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110010");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_24;
      WHEN COMP_LOOP_8_modExp_1_while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110011");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_25;
      WHEN COMP_LOOP_8_modExp_1_while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110100");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_26;
      WHEN COMP_LOOP_8_modExp_1_while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110101");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_27;
      WHEN COMP_LOOP_8_modExp_1_while_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110110");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_28;
      WHEN COMP_LOOP_8_modExp_1_while_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100110111");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_29;
      WHEN COMP_LOOP_8_modExp_1_while_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111000");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_30;
      WHEN COMP_LOOP_8_modExp_1_while_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111001");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_31;
      WHEN COMP_LOOP_8_modExp_1_while_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111010");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_32;
      WHEN COMP_LOOP_8_modExp_1_while_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111011");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_33;
      WHEN COMP_LOOP_8_modExp_1_while_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111100");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_34;
      WHEN COMP_LOOP_8_modExp_1_while_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111101");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_35;
      WHEN COMP_LOOP_8_modExp_1_while_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111110");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_36;
      WHEN COMP_LOOP_8_modExp_1_while_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1100111111");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_37;
      WHEN COMP_LOOP_8_modExp_1_while_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000000");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_38;
      WHEN COMP_LOOP_8_modExp_1_while_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000001");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_39;
      WHEN COMP_LOOP_8_modExp_1_while_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000010");
        state_var_NS <= COMP_LOOP_8_modExp_1_while_C_40;
      WHEN COMP_LOOP_8_modExp_1_while_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000011");
        IF ( COMP_LOOP_8_modExp_1_while_C_40_tr0 = '1' ) THEN
          state_var_NS <= COMP_LOOP_C_457;
        ELSE
          state_var_NS <= COMP_LOOP_8_modExp_1_while_C_0;
        END IF;
      WHEN COMP_LOOP_C_457 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000100");
        state_var_NS <= COMP_LOOP_C_458;
      WHEN COMP_LOOP_C_458 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000101");
        state_var_NS <= COMP_LOOP_C_459;
      WHEN COMP_LOOP_C_459 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000110");
        state_var_NS <= COMP_LOOP_C_460;
      WHEN COMP_LOOP_C_460 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101000111");
        state_var_NS <= COMP_LOOP_C_461;
      WHEN COMP_LOOP_C_461 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001000");
        state_var_NS <= COMP_LOOP_C_462;
      WHEN COMP_LOOP_C_462 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001001");
        state_var_NS <= COMP_LOOP_C_463;
      WHEN COMP_LOOP_C_463 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001010");
        state_var_NS <= COMP_LOOP_C_464;
      WHEN COMP_LOOP_C_464 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001011");
        state_var_NS <= COMP_LOOP_C_465;
      WHEN COMP_LOOP_C_465 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001100");
        state_var_NS <= COMP_LOOP_C_466;
      WHEN COMP_LOOP_C_466 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001101");
        state_var_NS <= COMP_LOOP_C_467;
      WHEN COMP_LOOP_C_467 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001110");
        state_var_NS <= COMP_LOOP_C_468;
      WHEN COMP_LOOP_C_468 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101001111");
        state_var_NS <= COMP_LOOP_C_469;
      WHEN COMP_LOOP_C_469 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010000");
        state_var_NS <= COMP_LOOP_C_470;
      WHEN COMP_LOOP_C_470 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010001");
        state_var_NS <= COMP_LOOP_C_471;
      WHEN COMP_LOOP_C_471 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010010");
        state_var_NS <= COMP_LOOP_C_472;
      WHEN COMP_LOOP_C_472 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010011");
        state_var_NS <= COMP_LOOP_C_473;
      WHEN COMP_LOOP_C_473 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010100");
        state_var_NS <= COMP_LOOP_C_474;
      WHEN COMP_LOOP_C_474 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010101");
        state_var_NS <= COMP_LOOP_C_475;
      WHEN COMP_LOOP_C_475 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010110");
        state_var_NS <= COMP_LOOP_C_476;
      WHEN COMP_LOOP_C_476 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101010111");
        state_var_NS <= COMP_LOOP_C_477;
      WHEN COMP_LOOP_C_477 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011000");
        state_var_NS <= COMP_LOOP_C_478;
      WHEN COMP_LOOP_C_478 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011001");
        state_var_NS <= COMP_LOOP_C_479;
      WHEN COMP_LOOP_C_479 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011010");
        state_var_NS <= COMP_LOOP_C_480;
      WHEN COMP_LOOP_C_480 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011011");
        state_var_NS <= COMP_LOOP_C_481;
      WHEN COMP_LOOP_C_481 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011100");
        state_var_NS <= COMP_LOOP_C_482;
      WHEN COMP_LOOP_C_482 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011101");
        state_var_NS <= COMP_LOOP_C_483;
      WHEN COMP_LOOP_C_483 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011110");
        state_var_NS <= COMP_LOOP_C_484;
      WHEN COMP_LOOP_C_484 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101011111");
        state_var_NS <= COMP_LOOP_C_485;
      WHEN COMP_LOOP_C_485 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100000");
        state_var_NS <= COMP_LOOP_C_486;
      WHEN COMP_LOOP_C_486 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100001");
        state_var_NS <= COMP_LOOP_C_487;
      WHEN COMP_LOOP_C_487 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100010");
        state_var_NS <= COMP_LOOP_C_488;
      WHEN COMP_LOOP_C_488 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100011");
        state_var_NS <= COMP_LOOP_C_489;
      WHEN COMP_LOOP_C_489 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100100");
        state_var_NS <= COMP_LOOP_C_490;
      WHEN COMP_LOOP_C_490 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100101");
        state_var_NS <= COMP_LOOP_C_491;
      WHEN COMP_LOOP_C_491 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100110");
        state_var_NS <= COMP_LOOP_C_492;
      WHEN COMP_LOOP_C_492 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101100111");
        state_var_NS <= COMP_LOOP_C_493;
      WHEN COMP_LOOP_C_493 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101000");
        state_var_NS <= COMP_LOOP_C_494;
      WHEN COMP_LOOP_C_494 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101001");
        state_var_NS <= COMP_LOOP_C_495;
      WHEN COMP_LOOP_C_495 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101010");
        state_var_NS <= COMP_LOOP_C_496;
      WHEN COMP_LOOP_C_496 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101011");
        state_var_NS <= COMP_LOOP_C_497;
      WHEN COMP_LOOP_C_497 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101100");
        state_var_NS <= COMP_LOOP_C_498;
      WHEN COMP_LOOP_C_498 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101101");
        state_var_NS <= COMP_LOOP_C_499;
      WHEN COMP_LOOP_C_499 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101110");
        state_var_NS <= COMP_LOOP_C_500;
      WHEN COMP_LOOP_C_500 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101101111");
        state_var_NS <= COMP_LOOP_C_501;
      WHEN COMP_LOOP_C_501 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110000");
        state_var_NS <= COMP_LOOP_C_502;
      WHEN COMP_LOOP_C_502 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110001");
        state_var_NS <= COMP_LOOP_C_503;
      WHEN COMP_LOOP_C_503 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110010");
        state_var_NS <= COMP_LOOP_C_504;
      WHEN COMP_LOOP_C_504 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110011");
        state_var_NS <= COMP_LOOP_C_505;
      WHEN COMP_LOOP_C_505 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110100");
        state_var_NS <= COMP_LOOP_C_506;
      WHEN COMP_LOOP_C_506 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110101");
        state_var_NS <= COMP_LOOP_C_507;
      WHEN COMP_LOOP_C_507 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110110");
        state_var_NS <= COMP_LOOP_C_508;
      WHEN COMP_LOOP_C_508 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101110111");
        state_var_NS <= COMP_LOOP_C_509;
      WHEN COMP_LOOP_C_509 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111000");
        state_var_NS <= COMP_LOOP_C_510;
      WHEN COMP_LOOP_C_510 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111001");
        state_var_NS <= COMP_LOOP_C_511;
      WHEN COMP_LOOP_C_511 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111010");
        state_var_NS <= COMP_LOOP_C_512;
      WHEN COMP_LOOP_C_512 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111011");
        state_var_NS <= COMP_LOOP_C_513;
      WHEN COMP_LOOP_C_513 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111100");
        state_var_NS <= COMP_LOOP_C_514;
      WHEN COMP_LOOP_C_514 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111101");
        state_var_NS <= COMP_LOOP_C_515;
      WHEN COMP_LOOP_C_515 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111110");
        state_var_NS <= COMP_LOOP_C_516;
      WHEN COMP_LOOP_C_516 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1101111111");
        state_var_NS <= COMP_LOOP_C_517;
      WHEN COMP_LOOP_C_517 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1110000000");
        state_var_NS <= COMP_LOOP_C_518;
      WHEN COMP_LOOP_C_518 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1110000001");
        state_var_NS <= COMP_LOOP_C_519;
      WHEN COMP_LOOP_C_519 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1110000010");
        state_var_NS <= COMP_LOOP_C_520;
      WHEN COMP_LOOP_C_520 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1110000011");
        IF ( COMP_LOOP_C_520_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN VEC_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1110000100");
        IF ( VEC_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= STAGE_LOOP_C_9;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN STAGE_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1110000101");
        IF ( STAGE_LOOP_C_9_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= STAGE_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1110000110");
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

END v41;

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
    vec_rsc_triosy_0_4_lz : OUT STD_LOGIC;
    vec_rsc_triosy_0_5_lz : OUT STD_LOGIC;
    vec_rsc_triosy_0_6_lz : OUT STD_LOGIC;
    vec_rsc_triosy_0_7_lz : OUT STD_LOGIC;
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
    vec_rsc_0_4_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_5_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_6_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_7_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsc_0_0_i_adra_d_pff : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_i_da_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_1_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_2_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_3_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_4_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_5_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_6_i_wea_d_pff : OUT STD_LOGIC;
    vec_rsc_0_7_i_wea_d_pff : OUT STD_LOGIC
  );
END inPlaceNTT_DIT_core;

ARCHITECTURE v41 OF inPlaceNTT_DIT_core IS
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
  SIGNAL or_dcpl_3 : STD_LOGIC;
  SIGNAL or_tmp_5 : STD_LOGIC;
  SIGNAL or_tmp_9 : STD_LOGIC;
  SIGNAL or_tmp_13 : STD_LOGIC;
  SIGNAL not_tmp_29 : STD_LOGIC;
  SIGNAL or_tmp_58 : STD_LOGIC;
  SIGNAL or_tmp_60 : STD_LOGIC;
  SIGNAL mux_tmp_77 : STD_LOGIC;
  SIGNAL or_tmp_63 : STD_LOGIC;
  SIGNAL not_tmp_46 : STD_LOGIC;
  SIGNAL mux_tmp_81 : STD_LOGIC;
  SIGNAL mux_tmp_83 : STD_LOGIC;
  SIGNAL nor_tmp_12 : STD_LOGIC;
  SIGNAL and_tmp_2 : STD_LOGIC;
  SIGNAL or_tmp_71 : STD_LOGIC;
  SIGNAL or_tmp_72 : STD_LOGIC;
  SIGNAL or_tmp_73 : STD_LOGIC;
  SIGNAL nor_tmp_13 : STD_LOGIC;
  SIGNAL mux_tmp_164 : STD_LOGIC;
  SIGNAL nor_tmp_21 : STD_LOGIC;
  SIGNAL not_tmp_82 : STD_LOGIC;
  SIGNAL mux_tmp_229 : STD_LOGIC;
  SIGNAL mux_tmp_390 : STD_LOGIC;
  SIGNAL not_tmp_121 : STD_LOGIC;
  SIGNAL and_dcpl_15 : STD_LOGIC;
  SIGNAL and_dcpl_16 : STD_LOGIC;
  SIGNAL and_dcpl_18 : STD_LOGIC;
  SIGNAL and_dcpl_23 : STD_LOGIC;
  SIGNAL and_dcpl_26 : STD_LOGIC;
  SIGNAL and_dcpl_33 : STD_LOGIC;
  SIGNAL not_tmp_129 : STD_LOGIC;
  SIGNAL and_dcpl_49 : STD_LOGIC;
  SIGNAL and_dcpl_50 : STD_LOGIC;
  SIGNAL and_dcpl_53 : STD_LOGIC;
  SIGNAL and_dcpl_57 : STD_LOGIC;
  SIGNAL and_dcpl_58 : STD_LOGIC;
  SIGNAL and_dcpl_61 : STD_LOGIC;
  SIGNAL or_dcpl_39 : STD_LOGIC;
  SIGNAL and_dcpl_63 : STD_LOGIC;
  SIGNAL and_dcpl_64 : STD_LOGIC;
  SIGNAL and_dcpl_65 : STD_LOGIC;
  SIGNAL and_dcpl_66 : STD_LOGIC;
  SIGNAL and_dcpl_67 : STD_LOGIC;
  SIGNAL and_dcpl_68 : STD_LOGIC;
  SIGNAL and_dcpl_69 : STD_LOGIC;
  SIGNAL and_dcpl_70 : STD_LOGIC;
  SIGNAL and_dcpl_71 : STD_LOGIC;
  SIGNAL and_dcpl_72 : STD_LOGIC;
  SIGNAL and_dcpl_75 : STD_LOGIC;
  SIGNAL and_dcpl_76 : STD_LOGIC;
  SIGNAL and_dcpl_77 : STD_LOGIC;
  SIGNAL and_dcpl_78 : STD_LOGIC;
  SIGNAL and_dcpl_79 : STD_LOGIC;
  SIGNAL and_dcpl_81 : STD_LOGIC;
  SIGNAL and_dcpl_82 : STD_LOGIC;
  SIGNAL and_dcpl_90 : STD_LOGIC;
  SIGNAL and_dcpl_91 : STD_LOGIC;
  SIGNAL and_dcpl_96 : STD_LOGIC;
  SIGNAL and_dcpl_97 : STD_LOGIC;
  SIGNAL and_dcpl_98 : STD_LOGIC;
  SIGNAL and_dcpl_102 : STD_LOGIC;
  SIGNAL and_dcpl_103 : STD_LOGIC;
  SIGNAL and_dcpl_104 : STD_LOGIC;
  SIGNAL and_dcpl_108 : STD_LOGIC;
  SIGNAL and_dcpl_109 : STD_LOGIC;
  SIGNAL and_dcpl_115 : STD_LOGIC;
  SIGNAL and_dcpl_116 : STD_LOGIC;
  SIGNAL and_dcpl_122 : STD_LOGIC;
  SIGNAL and_dcpl_124 : STD_LOGIC;
  SIGNAL and_dcpl_126 : STD_LOGIC;
  SIGNAL and_dcpl_133 : STD_LOGIC;
  SIGNAL and_dcpl_134 : STD_LOGIC;
  SIGNAL mux_tmp_469 : STD_LOGIC;
  SIGNAL not_tmp_166 : STD_LOGIC;
  SIGNAL mux_tmp_472 : STD_LOGIC;
  SIGNAL mux_tmp_473 : STD_LOGIC;
  SIGNAL mux_tmp_488 : STD_LOGIC;
  SIGNAL not_tmp_170 : STD_LOGIC;
  SIGNAL not_tmp_171 : STD_LOGIC;
  SIGNAL mux_tmp_504 : STD_LOGIC;
  SIGNAL not_tmp_177 : STD_LOGIC;
  SIGNAL not_tmp_178 : STD_LOGIC;
  SIGNAL mux_tmp_523 : STD_LOGIC;
  SIGNAL mux_tmp_539 : STD_LOGIC;
  SIGNAL not_tmp_189 : STD_LOGIC;
  SIGNAL mux_tmp_542 : STD_LOGIC;
  SIGNAL not_tmp_190 : STD_LOGIC;
  SIGNAL mux_tmp_558 : STD_LOGIC;
  SIGNAL mux_tmp_574 : STD_LOGIC;
  SIGNAL not_tmp_201 : STD_LOGIC;
  SIGNAL not_tmp_202 : STD_LOGIC;
  SIGNAL mux_tmp_593 : STD_LOGIC;
  SIGNAL mux_tmp_609 : STD_LOGIC;
  SIGNAL not_tmp_214 : STD_LOGIC;
  SIGNAL mux_tmp_616 : STD_LOGIC;
  SIGNAL mux_tmp_620 : STD_LOGIC;
  SIGNAL mux_tmp_628 : STD_LOGIC;
  SIGNAL mux_tmp_644 : STD_LOGIC;
  SIGNAL not_tmp_225 : STD_LOGIC;
  SIGNAL not_tmp_226 : STD_LOGIC;
  SIGNAL mux_tmp_663 : STD_LOGIC;
  SIGNAL mux_tmp_679 : STD_LOGIC;
  SIGNAL not_tmp_237 : STD_LOGIC;
  SIGNAL mux_tmp_686 : STD_LOGIC;
  SIGNAL not_tmp_239 : STD_LOGIC;
  SIGNAL mux_tmp_698 : STD_LOGIC;
  SIGNAL mux_tmp_714 : STD_LOGIC;
  SIGNAL not_tmp_249 : STD_LOGIC;
  SIGNAL not_tmp_250 : STD_LOGIC;
  SIGNAL mux_tmp_733 : STD_LOGIC;
  SIGNAL and_dcpl_150 : STD_LOGIC;
  SIGNAL or_tmp_672 : STD_LOGIC;
  SIGNAL or_tmp_677 : STD_LOGIC;
  SIGNAL or_tmp_679 : STD_LOGIC;
  SIGNAL nor_tmp_166 : STD_LOGIC;
  SIGNAL or_tmp_681 : STD_LOGIC;
  SIGNAL mux_tmp_760 : STD_LOGIC;
  SIGNAL or_tmp_682 : STD_LOGIC;
  SIGNAL mux_tmp_773 : STD_LOGIC;
  SIGNAL mux_tmp_777 : STD_LOGIC;
  SIGNAL nor_tmp_168 : STD_LOGIC;
  SIGNAL not_tmp_276 : STD_LOGIC;
  SIGNAL mux_tmp_814 : STD_LOGIC;
  SIGNAL mux_tmp_823 : STD_LOGIC;
  SIGNAL mux_tmp_825 : STD_LOGIC;
  SIGNAL mux_tmp_833 : STD_LOGIC;
  SIGNAL or_tmp_737 : STD_LOGIC;
  SIGNAL mux_tmp_860 : STD_LOGIC;
  SIGNAL or_tmp_738 : STD_LOGIC;
  SIGNAL mux_tmp_865 : STD_LOGIC;
  SIGNAL and_dcpl_151 : STD_LOGIC;
  SIGNAL not_tmp_309 : STD_LOGIC;
  SIGNAL and_dcpl_152 : STD_LOGIC;
  SIGNAL and_dcpl_156 : STD_LOGIC;
  SIGNAL and_dcpl_157 : STD_LOGIC;
  SIGNAL mux_tmp_898 : STD_LOGIC;
  SIGNAL mux_tmp_899 : STD_LOGIC;
  SIGNAL mux_tmp_900 : STD_LOGIC;
  SIGNAL or_tmp_783 : STD_LOGIC;
  SIGNAL mux_tmp_912 : STD_LOGIC;
  SIGNAL mux_tmp_1013 : STD_LOGIC;
  SIGNAL or_dcpl_56 : STD_LOGIC;
  SIGNAL mux_tmp_1037 : STD_LOGIC;
  SIGNAL nor_tmp_223 : STD_LOGIC;
  SIGNAL and_dcpl_174 : STD_LOGIC;
  SIGNAL and_dcpl_176 : STD_LOGIC;
  SIGNAL and_dcpl_177 : STD_LOGIC;
  SIGNAL not_tmp_375 : STD_LOGIC;
  SIGNAL or_dcpl_62 : STD_LOGIC;
  SIGNAL not_tmp_384 : STD_LOGIC;
  SIGNAL or_tmp_966 : STD_LOGIC;
  SIGNAL not_tmp_390 : STD_LOGIC;
  SIGNAL or_tmp_970 : STD_LOGIC;
  SIGNAL or_tmp_992 : STD_LOGIC;
  SIGNAL or_tmp_993 : STD_LOGIC;
  SIGNAL mux_tmp_1175 : STD_LOGIC;
  SIGNAL mux_tmp_1179 : STD_LOGIC;
  SIGNAL mux_tmp_1182 : STD_LOGIC;
  SIGNAL mux_tmp_1184 : STD_LOGIC;
  SIGNAL mux_tmp_1187 : STD_LOGIC;
  SIGNAL mux_tmp_1189 : STD_LOGIC;
  SIGNAL mux_tmp_1190 : STD_LOGIC;
  SIGNAL mux_tmp_1191 : STD_LOGIC;
  SIGNAL mux_tmp_1192 : STD_LOGIC;
  SIGNAL mux_tmp_1199 : STD_LOGIC;
  SIGNAL mux_tmp_1203 : STD_LOGIC;
  SIGNAL not_tmp_414 : STD_LOGIC;
  SIGNAL mux_tmp_1208 : STD_LOGIC;
  SIGNAL or_tmp_1034 : STD_LOGIC;
  SIGNAL and_dcpl_191 : STD_LOGIC;
  SIGNAL or_tmp_1050 : STD_LOGIC;
  SIGNAL mux_tmp_1272 : STD_LOGIC;
  SIGNAL mux_tmp_1276 : STD_LOGIC;
  SIGNAL mux_tmp_1277 : STD_LOGIC;
  SIGNAL mux_tmp_1288 : STD_LOGIC;
  SIGNAL and_dcpl_192 : STD_LOGIC;
  SIGNAL and_dcpl_194 : STD_LOGIC;
  SIGNAL not_tmp_458 : STD_LOGIC;
  SIGNAL mux_tmp_1329 : STD_LOGIC;
  SIGNAL mux_tmp_1331 : STD_LOGIC;
  SIGNAL mux_tmp_1332 : STD_LOGIC;
  SIGNAL or_tmp_1128 : STD_LOGIC;
  SIGNAL mux_tmp_1341 : STD_LOGIC;
  SIGNAL mux_tmp_1345 : STD_LOGIC;
  SIGNAL mux_tmp_1348 : STD_LOGIC;
  SIGNAL mux_tmp_1351 : STD_LOGIC;
  SIGNAL or_tmp_1137 : STD_LOGIC;
  SIGNAL mux_tmp_1353 : STD_LOGIC;
  SIGNAL mux_tmp_1355 : STD_LOGIC;
  SIGNAL or_tmp_1142 : STD_LOGIC;
  SIGNAL not_tmp_496 : STD_LOGIC;
  SIGNAL or_tmp_1157 : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_11_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_2_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_k_9_3_sva_5_0 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL VEC_LOOP_j_sva_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm : STD_LOGIC;
  SIGNAL operator_64_false_slc_modExp_exp_0_1_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_10_cse_12_1_1_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_4_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_2_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_6_sva : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_11_psp_sva : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_14_psp_sva : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_13_psp_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_2_sva_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL modExp_while_and_1_rgt : STD_LOGIC;
  SIGNAL and_244_m1c : STD_LOGIC;
  SIGNAL and_250_m1c : STD_LOGIC;
  SIGNAL and_185_m1c : STD_LOGIC;
  SIGNAL or_294_cse : STD_LOGIC;
  SIGNAL nor_115_cse : STD_LOGIC;
  SIGNAL or_521_cse : STD_LOGIC;
  SIGNAL and_336_cse : STD_LOGIC;
  SIGNAL reg_vec_rsc_triosy_0_7_obj_ld_cse : STD_LOGIC;
  SIGNAL and_316_cse : STD_LOGIC;
  SIGNAL or_722_cse : STD_LOGIC;
  SIGNAL or_730_cse : STD_LOGIC;
  SIGNAL nor_397_cse : STD_LOGIC;
  SIGNAL nor_398_cse : STD_LOGIC;
  SIGNAL or_857_cse : STD_LOGIC;
  SIGNAL nand_82_cse : STD_LOGIC;
  SIGNAL or_1161_cse : STD_LOGIC;
  SIGNAL nor_400_cse : STD_LOGIC;
  SIGNAL modulo_result_mux_1_cse : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_293_cse : STD_LOGIC;
  SIGNAL and_398_cse : STD_LOGIC;
  SIGNAL and_292_cse : STD_LOGIC;
  SIGNAL or_831_cse : STD_LOGIC;
  SIGNAL or_91_cse : STD_LOGIC;
  SIGNAL or_90_cse : STD_LOGIC;
  SIGNAL nor_401_cse : STD_LOGIC;
  SIGNAL or_5_cse : STD_LOGIC;
  SIGNAL or_217_cse : STD_LOGIC;
  SIGNAL or_157_cse : STD_LOGIC;
  SIGNAL nand_245_cse : STD_LOGIC;
  SIGNAL nor_265_cse : STD_LOGIC;
  SIGNAL mux_483_cse : STD_LOGIC;
  SIGNAL nand_232_cse : STD_LOGIC;
  SIGNAL or_1379_cse : STD_LOGIC;
  SIGNAL or_277_cse : STD_LOGIC;
  SIGNAL nor_112_cse : STD_LOGIC;
  SIGNAL nor_114_cse : STD_LOGIC;
  SIGNAL nor_122_cse : STD_LOGIC;
  SIGNAL mux_995_cse : STD_LOGIC;
  SIGNAL and_434_cse : STD_LOGIC;
  SIGNAL or_29_cse : STD_LOGIC;
  SIGNAL and_312_cse : STD_LOGIC;
  SIGNAL or_823_cse : STD_LOGIC;
  SIGNAL or_843_cse : STD_LOGIC;
  SIGNAL nor_692_cse : STD_LOGIC;
  SIGNAL or_1275_cse : STD_LOGIC;
  SIGNAL and_433_cse : STD_LOGIC;
  SIGNAL or_1156_cse : STD_LOGIC;
  SIGNAL or_119_cse : STD_LOGIC;
  SIGNAL nand_240_cse : STD_LOGIC;
  SIGNAL or_731_cse : STD_LOGIC;
  SIGNAL nor_365_cse : STD_LOGIC;
  SIGNAL mux_477_cse : STD_LOGIC;
  SIGNAL nor_624_cse : STD_LOGIC;
  SIGNAL nor_594_cse : STD_LOGIC;
  SIGNAL mux_445_cse : STD_LOGIC;
  SIGNAL nand_244_cse : STD_LOGIC;
  SIGNAL mux_417_cse : STD_LOGIC;
  SIGNAL mux_903_cse : STD_LOGIC;
  SIGNAL mux_919_cse : STD_LOGIC;
  SIGNAL mux_923_cse : STD_LOGIC;
  SIGNAL mux_929_cse : STD_LOGIC;
  SIGNAL mux_937_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_nor_97_cse : STD_LOGIC;
  SIGNAL mux_446_cse : STD_LOGIC;
  SIGNAL mux_438_cse : STD_LOGIC;
  SIGNAL mux_928_cse : STD_LOGIC;
  SIGNAL mux_82_cse : STD_LOGIC;
  SIGNAL mux_1026_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_psp_sva_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_psp_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL mux_453_itm : STD_LOGIC;
  SIGNAL mux_1151_itm : STD_LOGIC;
  SIGNAL mux_1209_itm : STD_LOGIC;
  SIGNAL mux_1289_itm : STD_LOGIC;
  SIGNAL and_dcpl_218 : STD_LOGIC;
  SIGNAL and_dcpl_223 : STD_LOGIC;
  SIGNAL not_tmp_519 : STD_LOGIC;
  SIGNAL mux_tmp_1422 : STD_LOGIC;
  SIGNAL mux_tmp_1425 : STD_LOGIC;
  SIGNAL not_tmp_524 : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL and_dcpl_246 : STD_LOGIC;
  SIGNAL nor_tmp_272 : STD_LOGIC;
  SIGNAL and_dcpl_247 : STD_LOGIC;
  SIGNAL and_dcpl_248 : STD_LOGIC;
  SIGNAL and_dcpl_256 : STD_LOGIC;
  SIGNAL and_dcpl_262 : STD_LOGIC;
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL and_dcpl_265 : STD_LOGIC;
  SIGNAL and_dcpl_267 : STD_LOGIC;
  SIGNAL and_dcpl_271 : STD_LOGIC;
  SIGNAL and_dcpl_277 : STD_LOGIC;
  SIGNAL and_dcpl_278 : STD_LOGIC;
  SIGNAL and_dcpl_280 : STD_LOGIC;
  SIGNAL and_dcpl_284 : STD_LOGIC;
  SIGNAL and_dcpl_289 : STD_LOGIC;
  SIGNAL z_out_3 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL and_dcpl_291 : STD_LOGIC;
  SIGNAL and_dcpl_298 : STD_LOGIC;
  SIGNAL and_dcpl_300 : STD_LOGIC;
  SIGNAL and_dcpl_305 : STD_LOGIC;
  SIGNAL and_dcpl_309 : STD_LOGIC;
  SIGNAL and_dcpl_312 : STD_LOGIC;
  SIGNAL and_dcpl_313 : STD_LOGIC;
  SIGNAL and_dcpl_318 : STD_LOGIC;
  SIGNAL and_dcpl_324 : STD_LOGIC;
  SIGNAL and_dcpl_326 : STD_LOGIC;
  SIGNAL and_dcpl_330 : STD_LOGIC;
  SIGNAL z_out_4 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_dcpl_342 : STD_LOGIC;
  SIGNAL and_dcpl_355 : STD_LOGIC;
  SIGNAL and_dcpl_359 : STD_LOGIC;
  SIGNAL and_dcpl_360 : STD_LOGIC;
  SIGNAL and_dcpl_410 : STD_LOGIC;
  SIGNAL and_dcpl_411 : STD_LOGIC;
  SIGNAL and_dcpl_442 : STD_LOGIC;
  SIGNAL z_out_7 : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL and_dcpl_451 : STD_LOGIC;
  SIGNAL and_dcpl_460 : STD_LOGIC;
  SIGNAL and_dcpl_467 : STD_LOGIC;
  SIGNAL z_out_8 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL r_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_psp_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL modExp_base_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_result_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_exp_1_7_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_6_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_5_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_4_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_3_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_2_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_1_1_sva : STD_LOGIC;
  SIGNAL modExp_exp_1_0_1_sva_1 : STD_LOGIC;
  SIGNAL tmp_10_lpi_4_dfm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_1_mul_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL operator_64_false_slc_modExp_exp_63_1_itm : STD_LOGIC_VECTOR (62 DOWNTO
      0);
  SIGNAL COMP_LOOP_COMP_LOOP_nor_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_4_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_5_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_6_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_nor_1_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_12_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_1_acc_8_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_and_30_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_32_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_58_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_124_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_125_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_i_3_0_sva_mx0c1 : STD_LOGIC;
  SIGNAL STAGE_LOOP_i_3_0_sva_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL COMP_LOOP_1_acc_5_mut_mx0w5 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_psp_sva_mx0w0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL VEC_LOOP_j_sva_11_0_mx0c1 : STD_LOGIC;
  SIGNAL modExp_result_sva_mx0c0 : STD_LOGIC;
  SIGNAL modExp_base_sva_mx0c1 : STD_LOGIC;
  SIGNAL modulo_qr_sva_1_mx1w1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL operator_64_false_slc_modExp_exp_63_1_3 : STD_LOGIC_VECTOR (62 DOWNTO 0);
  SIGNAL tmp_10_lpi_4_dfm_mx0c1 : STD_LOGIC;
  SIGNAL tmp_10_lpi_4_dfm_mx0c2 : STD_LOGIC;
  SIGNAL tmp_10_lpi_4_dfm_mx0c3 : STD_LOGIC;
  SIGNAL tmp_10_lpi_4_dfm_mx0c4 : STD_LOGIC;
  SIGNAL tmp_10_lpi_4_dfm_mx0c5 : STD_LOGIC;
  SIGNAL tmp_10_lpi_4_dfm_mx0c6 : STD_LOGIC;
  SIGNAL tmp_10_lpi_4_dfm_mx0c7 : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_211 : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_213 : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_215 : STD_LOGIC;
  SIGNAL and_243_m1c : STD_LOGIC;
  SIGNAL modExp_result_and_rgt : STD_LOGIC;
  SIGNAL modExp_result_and_1_rgt : STD_LOGIC;
  SIGNAL modExp_exp_sva_rsp_1 : STD_LOGIC_VECTOR (62 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_and_11_cse : STD_LOGIC;
  SIGNAL modExp_while_or_1_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_12_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_37_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_13_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_or_3_cse : STD_LOGIC;
  SIGNAL or_718_cse : STD_LOGIC;
  SIGNAL or_1312_cse : STD_LOGIC;
  SIGNAL or_798_cse : STD_LOGIC;
  SIGNAL nor_tmp_273 : STD_LOGIC;
  SIGNAL mux_tmp_1456 : STD_LOGIC;
  SIGNAL or_tmp_1262 : STD_LOGIC;
  SIGNAL or_tmp_1267 : STD_LOGIC;
  SIGNAL or_tmp_1269 : STD_LOGIC;
  SIGNAL or_tmp_1273 : STD_LOGIC;
  SIGNAL or_tmp_1274 : STD_LOGIC;
  SIGNAL not_tmp_621 : STD_LOGIC;
  SIGNAL operator_64_false_operator_64_false_mux_rgt : STD_LOGIC_VECTOR (64 DOWNTO
      0);
  SIGNAL operator_64_false_acc_mut_64 : STD_LOGIC;
  SIGNAL operator_64_false_acc_mut_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL or_1470_cse : STD_LOGIC;
  SIGNAL or_1516_cse : STD_LOGIC;
  SIGNAL and_721_cse : STD_LOGIC;
  SIGNAL or_1483_cse : STD_LOGIC;
  SIGNAL nor_813_cse : STD_LOGIC;
  SIGNAL and_303_cse : STD_LOGIC;
  SIGNAL or_750_cse : STD_LOGIC;
  SIGNAL nor_820_cse : STD_LOGIC;
  SIGNAL mux_1001_cse : STD_LOGIC;
  SIGNAL mux_1014_cse : STD_LOGIC;
  SIGNAL mux_1460_cse : STD_LOGIC;
  SIGNAL mux_936_cse : STD_LOGIC;
  SIGNAL mux_1447_cse : STD_LOGIC;
  SIGNAL COMP_LOOP_or_39_itm : STD_LOGIC;
  SIGNAL operator_64_false_1_nor_1_itm : STD_LOGIC;
  SIGNAL COMP_LOOP_or_43_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_acc_itm_2_1 : STD_LOGIC;
  SIGNAL z_out_6_12_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL nor_379_cse : STD_LOGIC;
  SIGNAL nor_797_cse : STD_LOGIC;

  SIGNAL or_1380_nl : STD_LOGIC;
  SIGNAL or_1381_nl : STD_LOGIC;
  SIGNAL modulo_result_or_nl : STD_LOGIC;
  SIGNAL mux_856_nl : STD_LOGIC;
  SIGNAL mux_855_nl : STD_LOGIC;
  SIGNAL mux_854_nl : STD_LOGIC;
  SIGNAL nor_392_nl : STD_LOGIC;
  SIGNAL mux_853_nl : STD_LOGIC;
  SIGNAL mux_852_nl : STD_LOGIC;
  SIGNAL or_767_nl : STD_LOGIC;
  SIGNAL or_766_nl : STD_LOGIC;
  SIGNAL or_764_nl : STD_LOGIC;
  SIGNAL nor_393_nl : STD_LOGIC;
  SIGNAL mux_851_nl : STD_LOGIC;
  SIGNAL nor_394_nl : STD_LOGIC;
  SIGNAL mux_850_nl : STD_LOGIC;
  SIGNAL nor_395_nl : STD_LOGIC;
  SIGNAL mux_849_nl : STD_LOGIC;
  SIGNAL nor_396_nl : STD_LOGIC;
  SIGNAL mux_802_nl : STD_LOGIC;
  SIGNAL mux_801_nl : STD_LOGIC;
  SIGNAL mux_800_nl : STD_LOGIC;
  SIGNAL mux_799_nl : STD_LOGIC;
  SIGNAL mux_798_nl : STD_LOGIC;
  SIGNAL mux_797_nl : STD_LOGIC;
  SIGNAL mux_796_nl : STD_LOGIC;
  SIGNAL or_733_nl : STD_LOGIC;
  SIGNAL mux_795_nl : STD_LOGIC;
  SIGNAL mux_794_nl : STD_LOGIC;
  SIGNAL mux_793_nl : STD_LOGIC;
  SIGNAL mux_792_nl : STD_LOGIC;
  SIGNAL mux_791_nl : STD_LOGIC;
  SIGNAL mux_790_nl : STD_LOGIC;
  SIGNAL mux_789_nl : STD_LOGIC;
  SIGNAL mux_788_nl : STD_LOGIC;
  SIGNAL mux_787_nl : STD_LOGIC;
  SIGNAL mux_786_nl : STD_LOGIC;
  SIGNAL mux_785_nl : STD_LOGIC;
  SIGNAL mux_784_nl : STD_LOGIC;
  SIGNAL mux_783_nl : STD_LOGIC;
  SIGNAL mux_782_nl : STD_LOGIC;
  SIGNAL mux_781_nl : STD_LOGIC;
  SIGNAL mux_780_nl : STD_LOGIC;
  SIGNAL mux_779_nl : STD_LOGIC;
  SIGNAL mux_778_nl : STD_LOGIC;
  SIGNAL mux_776_nl : STD_LOGIC;
  SIGNAL mux_775_nl : STD_LOGIC;
  SIGNAL or_728_nl : STD_LOGIC;
  SIGNAL mux_774_nl : STD_LOGIC;
  SIGNAL or_727_nl : STD_LOGIC;
  SIGNAL mux_771_nl : STD_LOGIC;
  SIGNAL mux_770_nl : STD_LOGIC;
  SIGNAL mux_769_nl : STD_LOGIC;
  SIGNAL mux_768_nl : STD_LOGIC;
  SIGNAL mux_767_nl : STD_LOGIC;
  SIGNAL or_726_nl : STD_LOGIC;
  SIGNAL mux_766_nl : STD_LOGIC;
  SIGNAL mux_765_nl : STD_LOGIC;
  SIGNAL mux_764_nl : STD_LOGIC;
  SIGNAL mux_763_nl : STD_LOGIC;
  SIGNAL mux_762_nl : STD_LOGIC;
  SIGNAL mux_761_nl : STD_LOGIC;
  SIGNAL mux_759_nl : STD_LOGIC;
  SIGNAL mux_758_nl : STD_LOGIC;
  SIGNAL mux_757_nl : STD_LOGIC;
  SIGNAL mux_756_nl : STD_LOGIC;
  SIGNAL mux_755_nl : STD_LOGIC;
  SIGNAL mux_754_nl : STD_LOGIC;
  SIGNAL mux_753_nl : STD_LOGIC;
  SIGNAL mux_752_nl : STD_LOGIC;
  SIGNAL or_716_nl : STD_LOGIC;
  SIGNAL mux_751_nl : STD_LOGIC;
  SIGNAL mux_750_nl : STD_LOGIC;
  SIGNAL or_715_nl : STD_LOGIC;
  SIGNAL mux_848_nl : STD_LOGIC;
  SIGNAL mux_847_nl : STD_LOGIC;
  SIGNAL mux_846_nl : STD_LOGIC;
  SIGNAL mux_845_nl : STD_LOGIC;
  SIGNAL mux_844_nl : STD_LOGIC;
  SIGNAL mux_843_nl : STD_LOGIC;
  SIGNAL mux_842_nl : STD_LOGIC;
  SIGNAL mux_841_nl : STD_LOGIC;
  SIGNAL mux_840_nl : STD_LOGIC;
  SIGNAL mux_839_nl : STD_LOGIC;
  SIGNAL or_754_nl : STD_LOGIC;
  SIGNAL mux_838_nl : STD_LOGIC;
  SIGNAL or_753_nl : STD_LOGIC;
  SIGNAL mux_837_nl : STD_LOGIC;
  SIGNAL mux_836_nl : STD_LOGIC;
  SIGNAL mux_835_nl : STD_LOGIC;
  SIGNAL mux_834_nl : STD_LOGIC;
  SIGNAL or_751_nl : STD_LOGIC;
  SIGNAL mux_832_nl : STD_LOGIC;
  SIGNAL or_748_nl : STD_LOGIC;
  SIGNAL mux_831_nl : STD_LOGIC;
  SIGNAL mux_830_nl : STD_LOGIC;
  SIGNAL mux_829_nl : STD_LOGIC;
  SIGNAL mux_828_nl : STD_LOGIC;
  SIGNAL mux_826_nl : STD_LOGIC;
  SIGNAL or_745_nl : STD_LOGIC;
  SIGNAL mux_824_nl : STD_LOGIC;
  SIGNAL mux_821_nl : STD_LOGIC;
  SIGNAL mux_820_nl : STD_LOGIC;
  SIGNAL mux_819_nl : STD_LOGIC;
  SIGNAL mux_818_nl : STD_LOGIC;
  SIGNAL mux_817_nl : STD_LOGIC;
  SIGNAL mux_816_nl : STD_LOGIC;
  SIGNAL mux_815_nl : STD_LOGIC;
  SIGNAL mux_813_nl : STD_LOGIC;
  SIGNAL mux_812_nl : STD_LOGIC;
  SIGNAL or_740_nl : STD_LOGIC;
  SIGNAL mux_811_nl : STD_LOGIC;
  SIGNAL mux_810_nl : STD_LOGIC;
  SIGNAL mux_809_nl : STD_LOGIC;
  SIGNAL nand_127_nl : STD_LOGIC;
  SIGNAL or_737_nl : STD_LOGIC;
  SIGNAL mux_808_nl : STD_LOGIC;
  SIGNAL mux_807_nl : STD_LOGIC;
  SIGNAL mux_806_nl : STD_LOGIC;
  SIGNAL mux_880_nl : STD_LOGIC;
  SIGNAL mux_879_nl : STD_LOGIC;
  SIGNAL mux_878_nl : STD_LOGIC;
  SIGNAL mux_877_nl : STD_LOGIC;
  SIGNAL nor_377_nl : STD_LOGIC;
  SIGNAL mux_876_nl : STD_LOGIC;
  SIGNAL mux_875_nl : STD_LOGIC;
  SIGNAL nor_378_nl : STD_LOGIC;
  SIGNAL mux_874_nl : STD_LOGIC;
  SIGNAL mux_873_nl : STD_LOGIC;
  SIGNAL mux_872_nl : STD_LOGIC;
  SIGNAL or_789_nl : STD_LOGIC;
  SIGNAL or_788_nl : STD_LOGIC;
  SIGNAL mux_871_nl : STD_LOGIC;
  SIGNAL mux_870_nl : STD_LOGIC;
  SIGNAL mux_869_nl : STD_LOGIC;
  SIGNAL nor_380_nl : STD_LOGIC;
  SIGNAL nor_382_nl : STD_LOGIC;
  SIGNAL mux_868_nl : STD_LOGIC;
  SIGNAL mux_867_nl : STD_LOGIC;
  SIGNAL nor_383_nl : STD_LOGIC;
  SIGNAL mux_866_nl : STD_LOGIC;
  SIGNAL mux_864_nl : STD_LOGIC;
  SIGNAL mux_863_nl : STD_LOGIC;
  SIGNAL mux_862_nl : STD_LOGIC;
  SIGNAL mux_861_nl : STD_LOGIC;
  SIGNAL and_304_nl : STD_LOGIC;
  SIGNAL and_305_nl : STD_LOGIC;
  SIGNAL and_306_nl : STD_LOGIC;
  SIGNAL and_307_nl : STD_LOGIC;
  SIGNAL mux_859_nl : STD_LOGIC;
  SIGNAL mux_858_nl : STD_LOGIC;
  SIGNAL and_446_nl : STD_LOGIC;
  SIGNAL nor_389_nl : STD_LOGIC;
  SIGNAL mux_857_nl : STD_LOGIC;
  SIGNAL nor_390_nl : STD_LOGIC;
  SIGNAL nor_391_nl : STD_LOGIC;
  SIGNAL and_56_nl : STD_LOGIC;
  SIGNAL and_55_nl : STD_LOGIC;
  SIGNAL and_57_nl : STD_LOGIC;
  SIGNAL mux_444_nl : STD_LOGIC;
  SIGNAL and_54_nl : STD_LOGIC;
  SIGNAL modExp_while_if_mux1h_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_while_if_or_nl : STD_LOGIC;
  SIGNAL mux_1111_nl : STD_LOGIC;
  SIGNAL mux_1110_nl : STD_LOGIC;
  SIGNAL mux_1109_nl : STD_LOGIC;
  SIGNAL mux_1108_nl : STD_LOGIC;
  SIGNAL mux_1107_nl : STD_LOGIC;
  SIGNAL nor_333_nl : STD_LOGIC;
  SIGNAL nor_335_nl : STD_LOGIC;
  SIGNAL nor_336_nl : STD_LOGIC;
  SIGNAL and_274_nl : STD_LOGIC;
  SIGNAL mux_1106_nl : STD_LOGIC;
  SIGNAL and_275_nl : STD_LOGIC;
  SIGNAL mux_1105_nl : STD_LOGIC;
  SIGNAL nor_337_nl : STD_LOGIC;
  SIGNAL nor_338_nl : STD_LOGIC;
  SIGNAL nor_339_nl : STD_LOGIC;
  SIGNAL modExp_1_while_and_16_nl : STD_LOGIC;
  SIGNAL modExp_1_while_and_18_nl : STD_LOGIC;
  SIGNAL mux_954_nl : STD_LOGIC;
  SIGNAL mux_953_nl : STD_LOGIC;
  SIGNAL mux_952_nl : STD_LOGIC;
  SIGNAL mux_951_nl : STD_LOGIC;
  SIGNAL mux_950_nl : STD_LOGIC;
  SIGNAL mux_949_nl : STD_LOGIC;
  SIGNAL mux_1005_nl : STD_LOGIC;
  SIGNAL mux_1004_nl : STD_LOGIC;
  SIGNAL mux_1003_nl : STD_LOGIC;
  SIGNAL mux_1002_nl : STD_LOGIC;
  SIGNAL mux_1000_nl : STD_LOGIC;
  SIGNAL mux_999_nl : STD_LOGIC;
  SIGNAL mux_998_nl : STD_LOGIC;
  SIGNAL mux_997_nl : STD_LOGIC;
  SIGNAL mux_996_nl : STD_LOGIC;
  SIGNAL mux_992_nl : STD_LOGIC;
  SIGNAL mux_991_nl : STD_LOGIC;
  SIGNAL mux_990_nl : STD_LOGIC;
  SIGNAL mux_989_nl : STD_LOGIC;
  SIGNAL mux_988_nl : STD_LOGIC;
  SIGNAL mux_987_nl : STD_LOGIC;
  SIGNAL and_176_nl : STD_LOGIC;
  SIGNAL mux_984_nl : STD_LOGIC;
  SIGNAL mux_982_nl : STD_LOGIC;
  SIGNAL mux_981_nl : STD_LOGIC;
  SIGNAL mux_979_nl : STD_LOGIC;
  SIGNAL mux_978_nl : STD_LOGIC;
  SIGNAL mux_977_nl : STD_LOGIC;
  SIGNAL mux_975_nl : STD_LOGIC;
  SIGNAL mux_974_nl : STD_LOGIC;
  SIGNAL mux_973_nl : STD_LOGIC;
  SIGNAL mux_972_nl : STD_LOGIC;
  SIGNAL mux_971_nl : STD_LOGIC;
  SIGNAL mux_970_nl : STD_LOGIC;
  SIGNAL mux_968_nl : STD_LOGIC;
  SIGNAL mux_967_nl : STD_LOGIC;
  SIGNAL mux_966_nl : STD_LOGIC;
  SIGNAL mux_965_nl : STD_LOGIC;
  SIGNAL mux_964_nl : STD_LOGIC;
  SIGNAL mux_963_nl : STD_LOGIC;
  SIGNAL mux_962_nl : STD_LOGIC;
  SIGNAL mux_961_nl : STD_LOGIC;
  SIGNAL mux_959_nl : STD_LOGIC;
  SIGNAL or_1466_nl : STD_LOGIC;
  SIGNAL mux_1493_nl : STD_LOGIC;
  SIGNAL mux_1492_nl : STD_LOGIC;
  SIGNAL mux_1491_nl : STD_LOGIC;
  SIGNAL mux_1490_nl : STD_LOGIC;
  SIGNAL mux_1489_nl : STD_LOGIC;
  SIGNAL mux_1488_nl : STD_LOGIC;
  SIGNAL mux_1487_nl : STD_LOGIC;
  SIGNAL nor_815_nl : STD_LOGIC;
  SIGNAL mux_1486_nl : STD_LOGIC;
  SIGNAL mux_1485_nl : STD_LOGIC;
  SIGNAL mux_1484_nl : STD_LOGIC;
  SIGNAL mux_1483_nl : STD_LOGIC;
  SIGNAL nor_835_nl : STD_LOGIC;
  SIGNAL or_1473_nl : STD_LOGIC;
  SIGNAL mux_1481_nl : STD_LOGIC;
  SIGNAL mux_1480_nl : STD_LOGIC;
  SIGNAL mux_1479_nl : STD_LOGIC;
  SIGNAL mux_1478_nl : STD_LOGIC;
  SIGNAL mux_1477_nl : STD_LOGIC;
  SIGNAL nor_836_nl : STD_LOGIC;
  SIGNAL mux_1476_nl : STD_LOGIC;
  SIGNAL mux_1473_nl : STD_LOGIC;
  SIGNAL mux_1472_nl : STD_LOGIC;
  SIGNAL mux_1471_nl : STD_LOGIC;
  SIGNAL mux_1470_nl : STD_LOGIC;
  SIGNAL mux_1469_nl : STD_LOGIC;
  SIGNAL mux_1468_nl : STD_LOGIC;
  SIGNAL mux_1467_nl : STD_LOGIC;
  SIGNAL mux_1466_nl : STD_LOGIC;
  SIGNAL mux_1465_nl : STD_LOGIC;
  SIGNAL mux_1464_nl : STD_LOGIC;
  SIGNAL and_720_nl : STD_LOGIC;
  SIGNAL mux_1463_nl : STD_LOGIC;
  SIGNAL mux_1462_nl : STD_LOGIC;
  SIGNAL mux_1461_nl : STD_LOGIC;
  SIGNAL mux_1459_nl : STD_LOGIC;
  SIGNAL mux_1458_nl : STD_LOGIC;
  SIGNAL mux_1456_nl : STD_LOGIC;
  SIGNAL mux_1455_nl : STD_LOGIC;
  SIGNAL mux_1454_nl : STD_LOGIC;
  SIGNAL mux_1453_nl : STD_LOGIC;
  SIGNAL mux_1452_nl : STD_LOGIC;
  SIGNAL mux_1451_nl : STD_LOGIC;
  SIGNAL mux_1450_nl : STD_LOGIC;
  SIGNAL mux_1448_nl : STD_LOGIC;
  SIGNAL mux_1519_nl : STD_LOGIC;
  SIGNAL mux_1518_nl : STD_LOGIC;
  SIGNAL mux_1517_nl : STD_LOGIC;
  SIGNAL mux_1516_nl : STD_LOGIC;
  SIGNAL mux_1515_nl : STD_LOGIC;
  SIGNAL nor_828_nl : STD_LOGIC;
  SIGNAL and_715_nl : STD_LOGIC;
  SIGNAL mux_1514_nl : STD_LOGIC;
  SIGNAL nor_829_nl : STD_LOGIC;
  SIGNAL nor_830_nl : STD_LOGIC;
  SIGNAL and_716_nl : STD_LOGIC;
  SIGNAL mux_1513_nl : STD_LOGIC;
  SIGNAL or_1504_nl : STD_LOGIC;
  SIGNAL nor_831_nl : STD_LOGIC;
  SIGNAL mux_1512_nl : STD_LOGIC;
  SIGNAL mux_1511_nl : STD_LOGIC;
  SIGNAL mux_1510_nl : STD_LOGIC;
  SIGNAL mux_1509_nl : STD_LOGIC;
  SIGNAL and_717_nl : STD_LOGIC;
  SIGNAL or_1502_nl : STD_LOGIC;
  SIGNAL and_718_nl : STD_LOGIC;
  SIGNAL mux_1508_nl : STD_LOGIC;
  SIGNAL mux_1507_nl : STD_LOGIC;
  SIGNAL nand_268_nl : STD_LOGIC;
  SIGNAL or_1498_nl : STD_LOGIC;
  SIGNAL mux_1506_nl : STD_LOGIC;
  SIGNAL mux_1505_nl : STD_LOGIC;
  SIGNAL or_1494_nl : STD_LOGIC;
  SIGNAL mux_1504_nl : STD_LOGIC;
  SIGNAL or_1492_nl : STD_LOGIC;
  SIGNAL mux_1503_nl : STD_LOGIC;
  SIGNAL mux_1502_nl : STD_LOGIC;
  SIGNAL nor_832_nl : STD_LOGIC;
  SIGNAL nor_833_nl : STD_LOGIC;
  SIGNAL nor_834_nl : STD_LOGIC;
  SIGNAL mux_1501_nl : STD_LOGIC;
  SIGNAL mux_1500_nl : STD_LOGIC;
  SIGNAL mux_1499_nl : STD_LOGIC;
  SIGNAL or_1485_nl : STD_LOGIC;
  SIGNAL mux_1498_nl : STD_LOGIC;
  SIGNAL mux_1497_nl : STD_LOGIC;
  SIGNAL or_1484_nl : STD_LOGIC;
  SIGNAL or_1481_nl : STD_LOGIC;
  SIGNAL mux_1496_nl : STD_LOGIC;
  SIGNAL or_1478_nl : STD_LOGIC;
  SIGNAL mux_1495_nl : STD_LOGIC;
  SIGNAL mux_1494_nl : STD_LOGIC;
  SIGNAL or_1476_nl : STD_LOGIC;
  SIGNAL or_844_nl : STD_LOGIC;
  SIGNAL or_1460_nl : STD_LOGIC;
  SIGNAL mux_1015_nl : STD_LOGIC;
  SIGNAL or_845_nl : STD_LOGIC;
  SIGNAL or_841_nl : STD_LOGIC;
  SIGNAL mux_1522_nl : STD_LOGIC;
  SIGNAL nor_825_nl : STD_LOGIC;
  SIGNAL nor_826_nl : STD_LOGIC;
  SIGNAL nor_827_nl : STD_LOGIC;
  SIGNAL mux_1035_nl : STD_LOGIC;
  SIGNAL mux_1034_nl : STD_LOGIC;
  SIGNAL mux_1029_nl : STD_LOGIC;
  SIGNAL and_286_nl : STD_LOGIC;
  SIGNAL or_864_nl : STD_LOGIC;
  SIGNAL mux_1134_nl : STD_LOGIC;
  SIGNAL nor_327_nl : STD_LOGIC;
  SIGNAL mux_1133_nl : STD_LOGIC;
  SIGNAL mux_1132_nl : STD_LOGIC;
  SIGNAL nor_329_nl : STD_LOGIC;
  SIGNAL mux_1131_nl : STD_LOGIC;
  SIGNAL or_982_nl : STD_LOGIC;
  SIGNAL or_980_nl : STD_LOGIC;
  SIGNAL nor_330_nl : STD_LOGIC;
  SIGNAL mux_57_nl : STD_LOGIC;
  SIGNAL mux_56_nl : STD_LOGIC;
  SIGNAL nand_238_nl : STD_LOGIC;
  SIGNAL mux_55_nl : STD_LOGIC;
  SIGNAL nor_721_nl : STD_LOGIC;
  SIGNAL nor_722_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_and_2_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_1_acc_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL nor_808_nl : STD_LOGIC;
  SIGNAL and_714_nl : STD_LOGIC;
  SIGNAL mux_1155_nl : STD_LOGIC;
  SIGNAL mux_1154_nl : STD_LOGIC;
  SIGNAL or_1266_nl : STD_LOGIC;
  SIGNAL nor_323_nl : STD_LOGIC;
  SIGNAL mux_1153_nl : STD_LOGIC;
  SIGNAL or_1025_nl : STD_LOGIC;
  SIGNAL or_1023_nl : STD_LOGIC;
  SIGNAL mux_1152_nl : STD_LOGIC;
  SIGNAL or_1021_nl : STD_LOGIC;
  SIGNAL mux_1157_nl : STD_LOGIC;
  SIGNAL or_1032_nl : STD_LOGIC;
  SIGNAL mux_1160_nl : STD_LOGIC;
  SIGNAL mux_1159_nl : STD_LOGIC;
  SIGNAL nand_112_nl : STD_LOGIC;
  SIGNAL mux_1158_nl : STD_LOGIC;
  SIGNAL mux_1162_nl : STD_LOGIC;
  SIGNAL mux_1161_nl : STD_LOGIC;
  SIGNAL and_208_nl : STD_LOGIC;
  SIGNAL and_207_nl : STD_LOGIC;
  SIGNAL or_1038_nl : STD_LOGIC;
  SIGNAL or_1043_nl : STD_LOGIC;
  SIGNAL mux_1164_nl : STD_LOGIC;
  SIGNAL and_211_nl : STD_LOGIC;
  SIGNAL and_210_nl : STD_LOGIC;
  SIGNAL and_212_nl : STD_LOGIC;
  SIGNAL and_214_nl : STD_LOGIC;
  SIGNAL mux_1167_nl : STD_LOGIC;
  SIGNAL or_1046_nl : STD_LOGIC;
  SIGNAL or_1045_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_or_2_nl : STD_LOGIC;
  SIGNAL mux_1212_nl : STD_LOGIC;
  SIGNAL mux_1211_nl : STD_LOGIC;
  SIGNAL mux_1210_nl : STD_LOGIC;
  SIGNAL mux_1205_nl : STD_LOGIC;
  SIGNAL mux_1204_nl : STD_LOGIC;
  SIGNAL or_1066_nl : STD_LOGIC;
  SIGNAL mux_1202_nl : STD_LOGIC;
  SIGNAL mux_1201_nl : STD_LOGIC;
  SIGNAL mux_1200_nl : STD_LOGIC;
  SIGNAL mux_1198_nl : STD_LOGIC;
  SIGNAL or_1064_nl : STD_LOGIC;
  SIGNAL mux_1197_nl : STD_LOGIC;
  SIGNAL mux_1196_nl : STD_LOGIC;
  SIGNAL mux_1195_nl : STD_LOGIC;
  SIGNAL mux_1194_nl : STD_LOGIC;
  SIGNAL mux_1193_nl : STD_LOGIC;
  SIGNAL or_1063_nl : STD_LOGIC;
  SIGNAL mux_1188_nl : STD_LOGIC;
  SIGNAL mux_1183_nl : STD_LOGIC;
  SIGNAL mux_1181_nl : STD_LOGIC;
  SIGNAL mux_1180_nl : STD_LOGIC;
  SIGNAL mux_1176_nl : STD_LOGIC;
  SIGNAL nor_318_nl : STD_LOGIC;
  SIGNAL mux_1173_nl : STD_LOGIC;
  SIGNAL mux_1171_nl : STD_LOGIC;
  SIGNAL or_1401_nl : STD_LOGIC;
  SIGNAL mux_1170_nl : STD_LOGIC;
  SIGNAL or_964_nl : STD_LOGIC;
  SIGNAL or_1052_nl : STD_LOGIC;
  SIGNAL nand_243_nl : STD_LOGIC;
  SIGNAL mux_1169_nl : STD_LOGIC;
  SIGNAL nor_320_nl : STD_LOGIC;
  SIGNAL nor_321_nl : STD_LOGIC;
  SIGNAL mux_1215_nl : STD_LOGIC;
  SIGNAL and_267_nl : STD_LOGIC;
  SIGNAL mux_1214_nl : STD_LOGIC;
  SIGNAL nor_314_nl : STD_LOGIC;
  SIGNAL nor_315_nl : STD_LOGIC;
  SIGNAL and_268_nl : STD_LOGIC;
  SIGNAL mux_1213_nl : STD_LOGIC;
  SIGNAL nor_316_nl : STD_LOGIC;
  SIGNAL nor_317_nl : STD_LOGIC;
  SIGNAL mux_1257_nl : STD_LOGIC;
  SIGNAL nor_308_nl : STD_LOGIC;
  SIGNAL nor_309_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux_42_nl : STD_LOGIC;
  SIGNAL and_222_nl : STD_LOGIC;
  SIGNAL mux_1263_nl : STD_LOGIC;
  SIGNAL mux_1262_nl : STD_LOGIC;
  SIGNAL nand_109_nl : STD_LOGIC;
  SIGNAL mux_1261_nl : STD_LOGIC;
  SIGNAL or_1103_nl : STD_LOGIC;
  SIGNAL mux_1260_nl : STD_LOGIC;
  SIGNAL or_1101_nl : STD_LOGIC;
  SIGNAL or_1100_nl : STD_LOGIC;
  SIGNAL mux_1259_nl : STD_LOGIC;
  SIGNAL mux_1258_nl : STD_LOGIC;
  SIGNAL or_1098_nl : STD_LOGIC;
  SIGNAL mux_1218_nl : STD_LOGIC;
  SIGNAL nor_312_nl : STD_LOGIC;
  SIGNAL mux_1217_nl : STD_LOGIC;
  SIGNAL or_1078_nl : STD_LOGIC;
  SIGNAL or_1077_nl : STD_LOGIC;
  SIGNAL nor_313_nl : STD_LOGIC;
  SIGNAL mux_1216_nl : STD_LOGIC;
  SIGNAL or_1074_nl : STD_LOGIC;
  SIGNAL or_1073_nl : STD_LOGIC;
  SIGNAL mux_1266_nl : STD_LOGIC;
  SIGNAL nand_242_nl : STD_LOGIC;
  SIGNAL mux_1265_nl : STD_LOGIC;
  SIGNAL nor_305_nl : STD_LOGIC;
  SIGNAL nor_306_nl : STD_LOGIC;
  SIGNAL mux_1264_nl : STD_LOGIC;
  SIGNAL or_1109_nl : STD_LOGIC;
  SIGNAL or_1108_nl : STD_LOGIC;
  SIGNAL or_1400_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_32_nl : STD_LOGIC;
  SIGNAL mux_1295_nl : STD_LOGIC;
  SIGNAL mux_1294_nl : STD_LOGIC;
  SIGNAL and_259_nl : STD_LOGIC;
  SIGNAL mux_1293_nl : STD_LOGIC;
  SIGNAL nor_299_nl : STD_LOGIC;
  SIGNAL mux_1292_nl : STD_LOGIC;
  SIGNAL nor_300_nl : STD_LOGIC;
  SIGNAL nor_301_nl : STD_LOGIC;
  SIGNAL nor_302_nl : STD_LOGIC;
  SIGNAL mux_1291_nl : STD_LOGIC;
  SIGNAL or_1119_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_46_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_48_nl : STD_LOGIC;
  SIGNAL mux_1308_nl : STD_LOGIC;
  SIGNAL mux_1307_nl : STD_LOGIC;
  SIGNAL mux_1306_nl : STD_LOGIC;
  SIGNAL mux_1305_nl : STD_LOGIC;
  SIGNAL mux_1304_nl : STD_LOGIC;
  SIGNAL mux_1303_nl : STD_LOGIC;
  SIGNAL mux_1311_nl : STD_LOGIC;
  SIGNAL nand_192_nl : STD_LOGIC;
  SIGNAL mux_1310_nl : STD_LOGIC;
  SIGNAL nor_296_nl : STD_LOGIC;
  SIGNAL nor_297_nl : STD_LOGIC;
  SIGNAL or_1300_nl : STD_LOGIC;
  SIGNAL mux_1309_nl : STD_LOGIC;
  SIGNAL nand_106_nl : STD_LOGIC;
  SIGNAL or_1140_nl : STD_LOGIC;
  SIGNAL mux_1314_nl : STD_LOGIC;
  SIGNAL or_1308_nl : STD_LOGIC;
  SIGNAL mux_1313_nl : STD_LOGIC;
  SIGNAL or_1154_nl : STD_LOGIC;
  SIGNAL or_1152_nl : STD_LOGIC;
  SIGNAL or_1309_nl : STD_LOGIC;
  SIGNAL mux_1312_nl : STD_LOGIC;
  SIGNAL or_1150_nl : STD_LOGIC;
  SIGNAL or_1148_nl : STD_LOGIC;
  SIGNAL mux_1321_nl : STD_LOGIC;
  SIGNAL mux_1320_nl : STD_LOGIC;
  SIGNAL or_1168_nl : STD_LOGIC;
  SIGNAL nand_86_nl : STD_LOGIC;
  SIGNAL mux_1319_nl : STD_LOGIC;
  SIGNAL nor_292_nl : STD_LOGIC;
  SIGNAL mux_1318_nl : STD_LOGIC;
  SIGNAL or_1166_nl : STD_LOGIC;
  SIGNAL or_1165_nl : STD_LOGIC;
  SIGNAL nor_293_nl : STD_LOGIC;
  SIGNAL or_1162_nl : STD_LOGIC;
  SIGNAL mux_1317_nl : STD_LOGIC;
  SIGNAL mux_1316_nl : STD_LOGIC;
  SIGNAL or_1160_nl : STD_LOGIC;
  SIGNAL or_1158_nl : STD_LOGIC;
  SIGNAL mux_1315_nl : STD_LOGIC;
  SIGNAL or_1157_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_15_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_16_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_17_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_18_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_19_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_20_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_21_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_22_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_26_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_27_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_7_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_8_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_9_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_10_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_11_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_12_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_13_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_14_nl : STD_LOGIC;
  SIGNAL nor_746_nl : STD_LOGIC;
  SIGNAL mux_74_nl : STD_LOGIC;
  SIGNAL mux_73_nl : STD_LOGIC;
  SIGNAL mux_72_nl : STD_LOGIC;
  SIGNAL mux_71_nl : STD_LOGIC;
  SIGNAL or_1391_nl : STD_LOGIC;
  SIGNAL or_1392_nl : STD_LOGIC;
  SIGNAL or_1393_nl : STD_LOGIC;
  SIGNAL or_1394_nl : STD_LOGIC;
  SIGNAL mux_70_nl : STD_LOGIC;
  SIGNAL or_1395_nl : STD_LOGIC;
  SIGNAL mux_69_nl : STD_LOGIC;
  SIGNAL or_1396_nl : STD_LOGIC;
  SIGNAL or_1397_nl : STD_LOGIC;
  SIGNAL mux_68_nl : STD_LOGIC;
  SIGNAL or_56_nl : STD_LOGIC;
  SIGNAL or_54_nl : STD_LOGIC;
  SIGNAL mux_1383_nl : STD_LOGIC;
  SIGNAL mux_1382_nl : STD_LOGIC;
  SIGNAL mux_1381_nl : STD_LOGIC;
  SIGNAL mux_1380_nl : STD_LOGIC;
  SIGNAL mux_1379_nl : STD_LOGIC;
  SIGNAL mux_1378_nl : STD_LOGIC;
  SIGNAL mux_1377_nl : STD_LOGIC;
  SIGNAL mux_1376_nl : STD_LOGIC;
  SIGNAL mux_1375_nl : STD_LOGIC;
  SIGNAL mux_1374_nl : STD_LOGIC;
  SIGNAL mux_1373_nl : STD_LOGIC;
  SIGNAL mux_1372_nl : STD_LOGIC;
  SIGNAL mux_1371_nl : STD_LOGIC;
  SIGNAL mux_1370_nl : STD_LOGIC;
  SIGNAL mux_1369_nl : STD_LOGIC;
  SIGNAL mux_1368_nl : STD_LOGIC;
  SIGNAL mux_1367_nl : STD_LOGIC;
  SIGNAL and_253_nl : STD_LOGIC;
  SIGNAL mux_1366_nl : STD_LOGIC;
  SIGNAL mux_1365_nl : STD_LOGIC;
  SIGNAL mux_1364_nl : STD_LOGIC;
  SIGNAL or_1207_nl : STD_LOGIC;
  SIGNAL mux_1363_nl : STD_LOGIC;
  SIGNAL mux_1362_nl : STD_LOGIC;
  SIGNAL or_1206_nl : STD_LOGIC;
  SIGNAL mux_1361_nl : STD_LOGIC;
  SIGNAL mux_1360_nl : STD_LOGIC;
  SIGNAL mux_1359_nl : STD_LOGIC;
  SIGNAL mux_1358_nl : STD_LOGIC;
  SIGNAL mux_1357_nl : STD_LOGIC;
  SIGNAL mux_1356_nl : STD_LOGIC;
  SIGNAL mux_1354_nl : STD_LOGIC;
  SIGNAL or_1201_nl : STD_LOGIC;
  SIGNAL mux_1352_nl : STD_LOGIC;
  SIGNAL mux_1349_nl : STD_LOGIC;
  SIGNAL mux_1346_nl : STD_LOGIC;
  SIGNAL mux_1343_nl : STD_LOGIC;
  SIGNAL mux_1342_nl : STD_LOGIC;
  SIGNAL mux_1339_nl : STD_LOGIC;
  SIGNAL mux_1338_nl : STD_LOGIC;
  SIGNAL mux_1337_nl : STD_LOGIC;
  SIGNAL or_1196_nl : STD_LOGIC;
  SIGNAL nand_98_nl : STD_LOGIC;
  SIGNAL or_1192_nl : STD_LOGIC;
  SIGNAL mux_1336_nl : STD_LOGIC;
  SIGNAL nand_99_nl : STD_LOGIC;
  SIGNAL or_1191_nl : STD_LOGIC;
  SIGNAL mux_1335_nl : STD_LOGIC;
  SIGNAL mux_1334_nl : STD_LOGIC;
  SIGNAL mux_1333_nl : STD_LOGIC;
  SIGNAL nand_183_nl : STD_LOGIC;
  SIGNAL and_432_nl : STD_LOGIC;
  SIGNAL and_60_nl : STD_LOGIC;
  SIGNAL or_263_nl : STD_LOGIC;
  SIGNAL or_261_nl : STD_LOGIC;
  SIGNAL nor_640_nl : STD_LOGIC;
  SIGNAL nor_641_nl : STD_LOGIC;
  SIGNAL or_270_nl : STD_LOGIC;
  SIGNAL or_269_nl : STD_LOGIC;
  SIGNAL or_275_nl : STD_LOGIC;
  SIGNAL or_273_nl : STD_LOGIC;
  SIGNAL or_1376_nl : STD_LOGIC;
  SIGNAL or_1377_nl : STD_LOGIC;
  SIGNAL mux_481_nl : STD_LOGIC;
  SIGNAL nor_630_nl : STD_LOGIC;
  SIGNAL nor_631_nl : STD_LOGIC;
  SIGNAL or_297_nl : STD_LOGIC;
  SIGNAL or_296_nl : STD_LOGIC;
  SIGNAL or_324_nl : STD_LOGIC;
  SIGNAL or_322_nl : STD_LOGIC;
  SIGNAL nor_610_nl : STD_LOGIC;
  SIGNAL nor_611_nl : STD_LOGIC;
  SIGNAL nor_608_nl : STD_LOGIC;
  SIGNAL nor_609_nl : STD_LOGIC;
  SIGNAL or_355_nl : STD_LOGIC;
  SIGNAL or_354_nl : STD_LOGIC;
  SIGNAL or_382_nl : STD_LOGIC;
  SIGNAL or_380_nl : STD_LOGIC;
  SIGNAL nor_580_nl : STD_LOGIC;
  SIGNAL nor_581_nl : STD_LOGIC;
  SIGNAL or_389_nl : STD_LOGIC;
  SIGNAL or_388_nl : STD_LOGIC;
  SIGNAL nor_578_nl : STD_LOGIC;
  SIGNAL nor_579_nl : STD_LOGIC;
  SIGNAL or_412_nl : STD_LOGIC;
  SIGNAL or_411_nl : STD_LOGIC;
  SIGNAL or_438_nl : STD_LOGIC;
  SIGNAL or_436_nl : STD_LOGIC;
  SIGNAL nor_550_nl : STD_LOGIC;
  SIGNAL nor_551_nl : STD_LOGIC;
  SIGNAL nor_548_nl : STD_LOGIC;
  SIGNAL nor_549_nl : STD_LOGIC;
  SIGNAL or_465_nl : STD_LOGIC;
  SIGNAL or_464_nl : STD_LOGIC;
  SIGNAL or_490_nl : STD_LOGIC;
  SIGNAL or_488_nl : STD_LOGIC;
  SIGNAL nor_520_nl : STD_LOGIC;
  SIGNAL nor_521_nl : STD_LOGIC;
  SIGNAL or_504_nl : STD_LOGIC;
  SIGNAL or_503_nl : STD_LOGIC;
  SIGNAL or_514_nl : STD_LOGIC;
  SIGNAL or_512_nl : STD_LOGIC;
  SIGNAL or_524_nl : STD_LOGIC;
  SIGNAL or_523_nl : STD_LOGIC;
  SIGNAL or_550_nl : STD_LOGIC;
  SIGNAL or_548_nl : STD_LOGIC;
  SIGNAL nor_490_nl : STD_LOGIC;
  SIGNAL nor_491_nl : STD_LOGIC;
  SIGNAL nor_488_nl : STD_LOGIC;
  SIGNAL nor_489_nl : STD_LOGIC;
  SIGNAL or_581_nl : STD_LOGIC;
  SIGNAL or_580_nl : STD_LOGIC;
  SIGNAL or_607_nl : STD_LOGIC;
  SIGNAL or_605_nl : STD_LOGIC;
  SIGNAL nor_460_nl : STD_LOGIC;
  SIGNAL nor_461_nl : STD_LOGIC;
  SIGNAL or_621_nl : STD_LOGIC;
  SIGNAL or_620_nl : STD_LOGIC;
  SIGNAL nor_458_nl : STD_LOGIC;
  SIGNAL nor_459_nl : STD_LOGIC;
  SIGNAL or_637_nl : STD_LOGIC;
  SIGNAL or_636_nl : STD_LOGIC;
  SIGNAL or_662_nl : STD_LOGIC;
  SIGNAL nand_136_nl : STD_LOGIC;
  SIGNAL nor_430_nl : STD_LOGIC;
  SIGNAL and_447_nl : STD_LOGIC;
  SIGNAL nor_428_nl : STD_LOGIC;
  SIGNAL nor_429_nl : STD_LOGIC;
  SIGNAL nand_131_nl : STD_LOGIC;
  SIGNAL or_688_nl : STD_LOGIC;
  SIGNAL mux_822_nl : STD_LOGIC;
  SIGNAL and_310_nl : STD_LOGIC;
  SIGNAL mux_887_nl : STD_LOGIC;
  SIGNAL mux_886_nl : STD_LOGIC;
  SIGNAL nand_194_nl : STD_LOGIC;
  SIGNAL mux_885_nl : STD_LOGIC;
  SIGNAL and_301_nl : STD_LOGIC;
  SIGNAL mux_884_nl : STD_LOGIC;
  SIGNAL nor_371_nl : STD_LOGIC;
  SIGNAL nor_372_nl : STD_LOGIC;
  SIGNAL nor_373_nl : STD_LOGIC;
  SIGNAL or_1313_nl : STD_LOGIC;
  SIGNAL mux_883_nl : STD_LOGIC;
  SIGNAL mux_882_nl : STD_LOGIC;
  SIGNAL or_797_nl : STD_LOGIC;
  SIGNAL nand_66_nl : STD_LOGIC;
  SIGNAL mux_881_nl : STD_LOGIC;
  SIGNAL nor_375_nl : STD_LOGIC;
  SIGNAL nor_376_nl : STD_LOGIC;
  SIGNAL mux_892_nl : STD_LOGIC;
  SIGNAL and_298_nl : STD_LOGIC;
  SIGNAL mux_891_nl : STD_LOGIC;
  SIGNAL nor_366_nl : STD_LOGIC;
  SIGNAL nor_367_nl : STD_LOGIC;
  SIGNAL nor_368_nl : STD_LOGIC;
  SIGNAL mux_890_nl : STD_LOGIC;
  SIGNAL mux_889_nl : STD_LOGIC;
  SIGNAL or_811_nl : STD_LOGIC;
  SIGNAL nand_69_nl : STD_LOGIC;
  SIGNAL mux_888_nl : STD_LOGIC;
  SIGNAL and_299_nl : STD_LOGIC;
  SIGNAL nor_369_nl : STD_LOGIC;
  SIGNAL mux_895_nl : STD_LOGIC;
  SIGNAL mux_894_nl : STD_LOGIC;
  SIGNAL nor_750_nl : STD_LOGIC;
  SIGNAL and_296_nl : STD_LOGIC;
  SIGNAL nand_191_nl : STD_LOGIC;
  SIGNAL mux_1118_nl : STD_LOGIC;
  SIGNAL mux_1117_nl : STD_LOGIC;
  SIGNAL nor_667_nl : STD_LOGIC;
  SIGNAL mux_1116_nl : STD_LOGIC;
  SIGNAL or_953_nl : STD_LOGIC;
  SIGNAL or_952_nl : STD_LOGIC;
  SIGNAL nor_668_nl : STD_LOGIC;
  SIGNAL mux_1115_nl : STD_LOGIC;
  SIGNAL nor_669_nl : STD_LOGIC;
  SIGNAL mux_1114_nl : STD_LOGIC;
  SIGNAL nor_670_nl : STD_LOGIC;
  SIGNAL mux_1113_nl : STD_LOGIC;
  SIGNAL or_946_nl : STD_LOGIC;
  SIGNAL or_945_nl : STD_LOGIC;
  SIGNAL mux_1112_nl : STD_LOGIC;
  SIGNAL nor_671_nl : STD_LOGIC;
  SIGNAL nor_672_nl : STD_LOGIC;
  SIGNAL and_198_nl : STD_LOGIC;
  SIGNAL mux_1150_nl : STD_LOGIC;
  SIGNAL or_1017_nl : STD_LOGIC;
  SIGNAL or_1015_nl : STD_LOGIC;
  SIGNAL mux_1172_nl : STD_LOGIC;
  SIGNAL mux_1174_nl : STD_LOGIC;
  SIGNAL mux_1177_nl : STD_LOGIC;
  SIGNAL mux_1186_nl : STD_LOGIC;
  SIGNAL mux_1185_nl : STD_LOGIC;
  SIGNAL or_1062_nl : STD_LOGIC;
  SIGNAL mux_1207_nl : STD_LOGIC;
  SIGNAL mux_1206_nl : STD_LOGIC;
  SIGNAL mux_1271_nl : STD_LOGIC;
  SIGNAL mux_1269_nl : STD_LOGIC;
  SIGNAL mux_1267_nl : STD_LOGIC;
  SIGNAL or_73_nl : STD_LOGIC;
  SIGNAL mux_90_nl : STD_LOGIC;
  SIGNAL mux_1274_nl : STD_LOGIC;
  SIGNAL mux_87_nl : STD_LOGIC;
  SIGNAL mux_1287_nl : STD_LOGIC;
  SIGNAL mux_1286_nl : STD_LOGIC;
  SIGNAL mux_1285_nl : STD_LOGIC;
  SIGNAL mux_1284_nl : STD_LOGIC;
  SIGNAL mux_1283_nl : STD_LOGIC;
  SIGNAL mux_1282_nl : STD_LOGIC;
  SIGNAL mux_1281_nl : STD_LOGIC;
  SIGNAL mux_1280_nl : STD_LOGIC;
  SIGNAL mux_1279_nl : STD_LOGIC;
  SIGNAL mux_1278_nl : STD_LOGIC;
  SIGNAL mux_1302_nl : STD_LOGIC;
  SIGNAL mux_1301_nl : STD_LOGIC;
  SIGNAL mux_1300_nl : STD_LOGIC;
  SIGNAL nor_661_nl : STD_LOGIC;
  SIGNAL nor_662_nl : STD_LOGIC;
  SIGNAL mux_1299_nl : STD_LOGIC;
  SIGNAL nor_663_nl : STD_LOGIC;
  SIGNAL mux_1298_nl : STD_LOGIC;
  SIGNAL nor_664_nl : STD_LOGIC;
  SIGNAL mux_1297_nl : STD_LOGIC;
  SIGNAL or_1132_nl : STD_LOGIC;
  SIGNAL mux_1296_nl : STD_LOGIC;
  SIGNAL nor_665_nl : STD_LOGIC;
  SIGNAL nor_666_nl : STD_LOGIC;
  SIGNAL mux_1330_nl : STD_LOGIC;
  SIGNAL mux_1340_nl : STD_LOGIC;
  SIGNAL mux_1344_nl : STD_LOGIC;
  SIGNAL nor_683_nl : STD_LOGIC;
  SIGNAL mux_1347_nl : STD_LOGIC;
  SIGNAL or_1199_nl : STD_LOGIC;
  SIGNAL mux_1350_nl : STD_LOGIC;
  SIGNAL nor_282_nl : STD_LOGIC;
  SIGNAL and_256_nl : STD_LOGIC;
  SIGNAL and_251_nl : STD_LOGIC;
  SIGNAL mux_1389_nl : STD_LOGIC;
  SIGNAL and_252_nl : STD_LOGIC;
  SIGNAL mux_1388_nl : STD_LOGIC;
  SIGNAL nor_277_nl : STD_LOGIC;
  SIGNAL nor_278_nl : STD_LOGIC;
  SIGNAL nor_279_nl : STD_LOGIC;
  SIGNAL mux_1387_nl : STD_LOGIC;
  SIGNAL or_1215_nl : STD_LOGIC;
  SIGNAL or_1214_nl : STD_LOGIC;
  SIGNAL nor_280_nl : STD_LOGIC;
  SIGNAL mux_1386_nl : STD_LOGIC;
  SIGNAL or_1212_nl : STD_LOGIC;
  SIGNAL mux_1385_nl : STD_LOGIC;
  SIGNAL nand_182_nl : STD_LOGIC;
  SIGNAL or_1209_nl : STD_LOGIC;
  SIGNAL mux_1025_nl : STD_LOGIC;
  SIGNAL mux_1024_nl : STD_LOGIC;
  SIGNAL mux_1023_nl : STD_LOGIC;
  SIGNAL or_859_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_acc_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL mux_1396_nl : STD_LOGIC;
  SIGNAL nor_273_nl : STD_LOGIC;
  SIGNAL mux_1395_nl : STD_LOGIC;
  SIGNAL nand_89_nl : STD_LOGIC;
  SIGNAL mux_1394_nl : STD_LOGIC;
  SIGNAL nor_274_nl : STD_LOGIC;
  SIGNAL nor_275_nl : STD_LOGIC;
  SIGNAL or_1228_nl : STD_LOGIC;
  SIGNAL mux_1393_nl : STD_LOGIC;
  SIGNAL or_1227_nl : STD_LOGIC;
  SIGNAL nor_276_nl : STD_LOGIC;
  SIGNAL mux_1392_nl : STD_LOGIC;
  SIGNAL mux_1391_nl : STD_LOGIC;
  SIGNAL or_1224_nl : STD_LOGIC;
  SIGNAL or_1222_nl : STD_LOGIC;
  SIGNAL and_98_nl : STD_LOGIC;
  SIGNAL nor_740_nl : STD_LOGIC;
  SIGNAL mux_461_nl : STD_LOGIC;
  SIGNAL mux_460_nl : STD_LOGIC;
  SIGNAL nand_235_nl : STD_LOGIC;
  SIGNAL mux_459_nl : STD_LOGIC;
  SIGNAL nor_655_nl : STD_LOGIC;
  SIGNAL nor_656_nl : STD_LOGIC;
  SIGNAL mux_458_nl : STD_LOGIC;
  SIGNAL or_1386_nl : STD_LOGIC;
  SIGNAL or_1387_nl : STD_LOGIC;
  SIGNAL mux_457_nl : STD_LOGIC;
  SIGNAL or_1388_nl : STD_LOGIC;
  SIGNAL mux_456_nl : STD_LOGIC;
  SIGNAL mux_455_nl : STD_LOGIC;
  SIGNAL or_234_nl : STD_LOGIC;
  SIGNAL or_233_nl : STD_LOGIC;
  SIGNAL or_232_nl : STD_LOGIC;
  SIGNAL or_1389_nl : STD_LOGIC;
  SIGNAL and_103_nl : STD_LOGIC;
  SIGNAL mux_462_nl : STD_LOGIC;
  SIGNAL nor_653_nl : STD_LOGIC;
  SIGNAL nor_654_nl : STD_LOGIC;
  SIGNAL and_110_nl : STD_LOGIC;
  SIGNAL mux_463_nl : STD_LOGIC;
  SIGNAL nor_651_nl : STD_LOGIC;
  SIGNAL nor_652_nl : STD_LOGIC;
  SIGNAL and_116_nl : STD_LOGIC;
  SIGNAL mux_464_nl : STD_LOGIC;
  SIGNAL nor_649_nl : STD_LOGIC;
  SIGNAL nor_650_nl : STD_LOGIC;
  SIGNAL and_121_nl : STD_LOGIC;
  SIGNAL mux_465_nl : STD_LOGIC;
  SIGNAL nor_647_nl : STD_LOGIC;
  SIGNAL and_449_nl : STD_LOGIC;
  SIGNAL and_127_nl : STD_LOGIC;
  SIGNAL mux_466_nl : STD_LOGIC;
  SIGNAL nor_645_nl : STD_LOGIC;
  SIGNAL nor_646_nl : STD_LOGIC;
  SIGNAL and_135_nl : STD_LOGIC;
  SIGNAL mux_467_nl : STD_LOGIC;
  SIGNAL nor_643_nl : STD_LOGIC;
  SIGNAL nor_644_nl : STD_LOGIC;
  SIGNAL and_145_nl : STD_LOGIC;
  SIGNAL mux_468_nl : STD_LOGIC;
  SIGNAL and_382_nl : STD_LOGIC;
  SIGNAL nor_642_nl : STD_LOGIC;
  SIGNAL mux_487_nl : STD_LOGIC;
  SIGNAL mux_486_nl : STD_LOGIC;
  SIGNAL mux_485_nl : STD_LOGIC;
  SIGNAL mux_484_nl : STD_LOGIC;
  SIGNAL or_1375_nl : STD_LOGIC;
  SIGNAL mux_482_nl : STD_LOGIC;
  SIGNAL or_1378_nl : STD_LOGIC;
  SIGNAL mux_480_nl : STD_LOGIC;
  SIGNAL mux_479_nl : STD_LOGIC;
  SIGNAL nand_233_nl : STD_LOGIC;
  SIGNAL mux_478_nl : STD_LOGIC;
  SIGNAL or_1382_nl : STD_LOGIC;
  SIGNAL mux_476_nl : STD_LOGIC;
  SIGNAL mux_475_nl : STD_LOGIC;
  SIGNAL mux_474_nl : STD_LOGIC;
  SIGNAL or_1383_nl : STD_LOGIC;
  SIGNAL or_1384_nl : STD_LOGIC;
  SIGNAL mux_471_nl : STD_LOGIC;
  SIGNAL nand_234_nl : STD_LOGIC;
  SIGNAL or_1385_nl : STD_LOGIC;
  SIGNAL or_260_nl : STD_LOGIC;
  SIGNAL mux_502_nl : STD_LOGIC;
  SIGNAL mux_501_nl : STD_LOGIC;
  SIGNAL mux_500_nl : STD_LOGIC;
  SIGNAL mux_499_nl : STD_LOGIC;
  SIGNAL nor_612_nl : STD_LOGIC;
  SIGNAL nor_613_nl : STD_LOGIC;
  SIGNAL nor_614_nl : STD_LOGIC;
  SIGNAL and_377_nl : STD_LOGIC;
  SIGNAL mux_498_nl : STD_LOGIC;
  SIGNAL nor_615_nl : STD_LOGIC;
  SIGNAL nor_616_nl : STD_LOGIC;
  SIGNAL mux_497_nl : STD_LOGIC;
  SIGNAL nor_617_nl : STD_LOGIC;
  SIGNAL nor_618_nl : STD_LOGIC;
  SIGNAL mux_496_nl : STD_LOGIC;
  SIGNAL or_311_nl : STD_LOGIC;
  SIGNAL or_309_nl : STD_LOGIC;
  SIGNAL mux_495_nl : STD_LOGIC;
  SIGNAL mux_494_nl : STD_LOGIC;
  SIGNAL nor_619_nl : STD_LOGIC;
  SIGNAL and_378_nl : STD_LOGIC;
  SIGNAL mux_493_nl : STD_LOGIC;
  SIGNAL mux_492_nl : STD_LOGIC;
  SIGNAL nor_620_nl : STD_LOGIC;
  SIGNAL nor_621_nl : STD_LOGIC;
  SIGNAL nor_622_nl : STD_LOGIC;
  SIGNAL mux_491_nl : STD_LOGIC;
  SIGNAL mux_490_nl : STD_LOGIC;
  SIGNAL mux_489_nl : STD_LOGIC;
  SIGNAL nor_623_nl : STD_LOGIC;
  SIGNAL nor_625_nl : STD_LOGIC;
  SIGNAL nor_626_nl : STD_LOGIC;
  SIGNAL mux_522_nl : STD_LOGIC;
  SIGNAL mux_521_nl : STD_LOGIC;
  SIGNAL mux_520_nl : STD_LOGIC;
  SIGNAL mux_519_nl : STD_LOGIC;
  SIGNAL or_1366_nl : STD_LOGIC;
  SIGNAL mux_517_nl : STD_LOGIC;
  SIGNAL nand_228_nl : STD_LOGIC;
  SIGNAL mux_515_nl : STD_LOGIC;
  SIGNAL mux_514_nl : STD_LOGIC;
  SIGNAL nand_229_nl : STD_LOGIC;
  SIGNAL mux_513_nl : STD_LOGIC;
  SIGNAL or_1372_nl : STD_LOGIC;
  SIGNAL mux_511_nl : STD_LOGIC;
  SIGNAL mux_510_nl : STD_LOGIC;
  SIGNAL mux_509_nl : STD_LOGIC;
  SIGNAL or_1373_nl : STD_LOGIC;
  SIGNAL nand_230_nl : STD_LOGIC;
  SIGNAL mux_506_nl : STD_LOGIC;
  SIGNAL nand_231_nl : STD_LOGIC;
  SIGNAL or_1374_nl : STD_LOGIC;
  SIGNAL or_321_nl : STD_LOGIC;
  SIGNAL mux_537_nl : STD_LOGIC;
  SIGNAL mux_536_nl : STD_LOGIC;
  SIGNAL mux_535_nl : STD_LOGIC;
  SIGNAL mux_534_nl : STD_LOGIC;
  SIGNAL nor_582_nl : STD_LOGIC;
  SIGNAL nor_583_nl : STD_LOGIC;
  SIGNAL nor_584_nl : STD_LOGIC;
  SIGNAL and_370_nl : STD_LOGIC;
  SIGNAL mux_533_nl : STD_LOGIC;
  SIGNAL nor_585_nl : STD_LOGIC;
  SIGNAL nor_586_nl : STD_LOGIC;
  SIGNAL mux_532_nl : STD_LOGIC;
  SIGNAL nor_587_nl : STD_LOGIC;
  SIGNAL nor_588_nl : STD_LOGIC;
  SIGNAL mux_531_nl : STD_LOGIC;
  SIGNAL or_369_nl : STD_LOGIC;
  SIGNAL or_367_nl : STD_LOGIC;
  SIGNAL mux_530_nl : STD_LOGIC;
  SIGNAL mux_529_nl : STD_LOGIC;
  SIGNAL nor_589_nl : STD_LOGIC;
  SIGNAL and_371_nl : STD_LOGIC;
  SIGNAL mux_528_nl : STD_LOGIC;
  SIGNAL mux_527_nl : STD_LOGIC;
  SIGNAL nor_590_nl : STD_LOGIC;
  SIGNAL nor_591_nl : STD_LOGIC;
  SIGNAL nor_592_nl : STD_LOGIC;
  SIGNAL mux_526_nl : STD_LOGIC;
  SIGNAL mux_525_nl : STD_LOGIC;
  SIGNAL mux_524_nl : STD_LOGIC;
  SIGNAL nor_593_nl : STD_LOGIC;
  SIGNAL nor_595_nl : STD_LOGIC;
  SIGNAL nor_596_nl : STD_LOGIC;
  SIGNAL mux_557_nl : STD_LOGIC;
  SIGNAL mux_556_nl : STD_LOGIC;
  SIGNAL mux_555_nl : STD_LOGIC;
  SIGNAL mux_554_nl : STD_LOGIC;
  SIGNAL nand_222_nl : STD_LOGIC;
  SIGNAL mux_552_nl : STD_LOGIC;
  SIGNAL or_1359_nl : STD_LOGIC;
  SIGNAL mux_550_nl : STD_LOGIC;
  SIGNAL mux_549_nl : STD_LOGIC;
  SIGNAL nand_224_nl : STD_LOGIC;
  SIGNAL mux_548_nl : STD_LOGIC;
  SIGNAL or_1363_nl : STD_LOGIC;
  SIGNAL mux_546_nl : STD_LOGIC;
  SIGNAL mux_545_nl : STD_LOGIC;
  SIGNAL mux_544_nl : STD_LOGIC;
  SIGNAL nand_225_nl : STD_LOGIC;
  SIGNAL or_1364_nl : STD_LOGIC;
  SIGNAL mux_541_nl : STD_LOGIC;
  SIGNAL nand_226_nl : STD_LOGIC;
  SIGNAL or_1365_nl : STD_LOGIC;
  SIGNAL or_379_nl : STD_LOGIC;
  SIGNAL mux_572_nl : STD_LOGIC;
  SIGNAL mux_571_nl : STD_LOGIC;
  SIGNAL mux_570_nl : STD_LOGIC;
  SIGNAL mux_569_nl : STD_LOGIC;
  SIGNAL nor_552_nl : STD_LOGIC;
  SIGNAL nor_553_nl : STD_LOGIC;
  SIGNAL nor_554_nl : STD_LOGIC;
  SIGNAL and_363_nl : STD_LOGIC;
  SIGNAL mux_568_nl : STD_LOGIC;
  SIGNAL nor_555_nl : STD_LOGIC;
  SIGNAL nor_556_nl : STD_LOGIC;
  SIGNAL mux_567_nl : STD_LOGIC;
  SIGNAL nor_557_nl : STD_LOGIC;
  SIGNAL nor_558_nl : STD_LOGIC;
  SIGNAL mux_566_nl : STD_LOGIC;
  SIGNAL or_425_nl : STD_LOGIC;
  SIGNAL or_423_nl : STD_LOGIC;
  SIGNAL mux_565_nl : STD_LOGIC;
  SIGNAL mux_564_nl : STD_LOGIC;
  SIGNAL nor_559_nl : STD_LOGIC;
  SIGNAL and_364_nl : STD_LOGIC;
  SIGNAL mux_563_nl : STD_LOGIC;
  SIGNAL mux_562_nl : STD_LOGIC;
  SIGNAL nor_560_nl : STD_LOGIC;
  SIGNAL nor_561_nl : STD_LOGIC;
  SIGNAL nor_562_nl : STD_LOGIC;
  SIGNAL mux_561_nl : STD_LOGIC;
  SIGNAL mux_560_nl : STD_LOGIC;
  SIGNAL nor_563_nl : STD_LOGIC;
  SIGNAL mux_559_nl : STD_LOGIC;
  SIGNAL nor_564_nl : STD_LOGIC;
  SIGNAL nor_566_nl : STD_LOGIC;
  SIGNAL mux_592_nl : STD_LOGIC;
  SIGNAL mux_591_nl : STD_LOGIC;
  SIGNAL mux_590_nl : STD_LOGIC;
  SIGNAL mux_589_nl : STD_LOGIC;
  SIGNAL nand_215_nl : STD_LOGIC;
  SIGNAL mux_587_nl : STD_LOGIC;
  SIGNAL nand_217_nl : STD_LOGIC;
  SIGNAL mux_585_nl : STD_LOGIC;
  SIGNAL mux_584_nl : STD_LOGIC;
  SIGNAL nand_218_nl : STD_LOGIC;
  SIGNAL mux_583_nl : STD_LOGIC;
  SIGNAL or_1355_nl : STD_LOGIC;
  SIGNAL mux_581_nl : STD_LOGIC;
  SIGNAL mux_580_nl : STD_LOGIC;
  SIGNAL mux_579_nl : STD_LOGIC;
  SIGNAL nand_219_nl : STD_LOGIC;
  SIGNAL nand_220_nl : STD_LOGIC;
  SIGNAL mux_576_nl : STD_LOGIC;
  SIGNAL nand_221_nl : STD_LOGIC;
  SIGNAL or_1356_nl : STD_LOGIC;
  SIGNAL or_435_nl : STD_LOGIC;
  SIGNAL mux_607_nl : STD_LOGIC;
  SIGNAL mux_606_nl : STD_LOGIC;
  SIGNAL mux_605_nl : STD_LOGIC;
  SIGNAL mux_604_nl : STD_LOGIC;
  SIGNAL nor_522_nl : STD_LOGIC;
  SIGNAL nor_523_nl : STD_LOGIC;
  SIGNAL nor_524_nl : STD_LOGIC;
  SIGNAL and_354_nl : STD_LOGIC;
  SIGNAL mux_603_nl : STD_LOGIC;
  SIGNAL nor_525_nl : STD_LOGIC;
  SIGNAL nor_526_nl : STD_LOGIC;
  SIGNAL mux_602_nl : STD_LOGIC;
  SIGNAL nor_527_nl : STD_LOGIC;
  SIGNAL nor_528_nl : STD_LOGIC;
  SIGNAL mux_601_nl : STD_LOGIC;
  SIGNAL or_478_nl : STD_LOGIC;
  SIGNAL or_476_nl : STD_LOGIC;
  SIGNAL mux_600_nl : STD_LOGIC;
  SIGNAL mux_599_nl : STD_LOGIC;
  SIGNAL nor_529_nl : STD_LOGIC;
  SIGNAL and_355_nl : STD_LOGIC;
  SIGNAL mux_598_nl : STD_LOGIC;
  SIGNAL mux_597_nl : STD_LOGIC;
  SIGNAL nor_530_nl : STD_LOGIC;
  SIGNAL nor_531_nl : STD_LOGIC;
  SIGNAL nor_532_nl : STD_LOGIC;
  SIGNAL mux_596_nl : STD_LOGIC;
  SIGNAL mux_595_nl : STD_LOGIC;
  SIGNAL nor_533_nl : STD_LOGIC;
  SIGNAL mux_594_nl : STD_LOGIC;
  SIGNAL nor_534_nl : STD_LOGIC;
  SIGNAL nor_536_nl : STD_LOGIC;
  SIGNAL mux_627_nl : STD_LOGIC;
  SIGNAL mux_626_nl : STD_LOGIC;
  SIGNAL mux_625_nl : STD_LOGIC;
  SIGNAL or_1339_nl : STD_LOGIC;
  SIGNAL or_1340_nl : STD_LOGIC;
  SIGNAL mux_624_nl : STD_LOGIC;
  SIGNAL nand_212_nl : STD_LOGIC;
  SIGNAL or_1341_nl : STD_LOGIC;
  SIGNAL mux_623_nl : STD_LOGIC;
  SIGNAL mux_622_nl : STD_LOGIC;
  SIGNAL mux_621_nl : STD_LOGIC;
  SIGNAL or_1342_nl : STD_LOGIC;
  SIGNAL mux_618_nl : STD_LOGIC;
  SIGNAL or_1345_nl : STD_LOGIC;
  SIGNAL mux_615_nl : STD_LOGIC;
  SIGNAL mux_614_nl : STD_LOGIC;
  SIGNAL nand_214_nl : STD_LOGIC;
  SIGNAL mux_612_nl : STD_LOGIC;
  SIGNAL or_1349_nl : STD_LOGIC;
  SIGNAL mux_610_nl : STD_LOGIC;
  SIGNAL nor_128_nl : STD_LOGIC;
  SIGNAL mux_642_nl : STD_LOGIC;
  SIGNAL mux_641_nl : STD_LOGIC;
  SIGNAL mux_640_nl : STD_LOGIC;
  SIGNAL mux_639_nl : STD_LOGIC;
  SIGNAL nor_492_nl : STD_LOGIC;
  SIGNAL nor_493_nl : STD_LOGIC;
  SIGNAL nor_494_nl : STD_LOGIC;
  SIGNAL and_349_nl : STD_LOGIC;
  SIGNAL mux_638_nl : STD_LOGIC;
  SIGNAL nor_495_nl : STD_LOGIC;
  SIGNAL nor_496_nl : STD_LOGIC;
  SIGNAL mux_637_nl : STD_LOGIC;
  SIGNAL nor_497_nl : STD_LOGIC;
  SIGNAL nor_498_nl : STD_LOGIC;
  SIGNAL mux_636_nl : STD_LOGIC;
  SIGNAL or_538_nl : STD_LOGIC;
  SIGNAL or_536_nl : STD_LOGIC;
  SIGNAL mux_635_nl : STD_LOGIC;
  SIGNAL mux_634_nl : STD_LOGIC;
  SIGNAL nor_499_nl : STD_LOGIC;
  SIGNAL and_350_nl : STD_LOGIC;
  SIGNAL mux_633_nl : STD_LOGIC;
  SIGNAL mux_632_nl : STD_LOGIC;
  SIGNAL nor_500_nl : STD_LOGIC;
  SIGNAL nor_501_nl : STD_LOGIC;
  SIGNAL nor_502_nl : STD_LOGIC;
  SIGNAL mux_631_nl : STD_LOGIC;
  SIGNAL mux_630_nl : STD_LOGIC;
  SIGNAL mux_629_nl : STD_LOGIC;
  SIGNAL nor_503_nl : STD_LOGIC;
  SIGNAL nor_505_nl : STD_LOGIC;
  SIGNAL nor_506_nl : STD_LOGIC;
  SIGNAL mux_662_nl : STD_LOGIC;
  SIGNAL mux_661_nl : STD_LOGIC;
  SIGNAL mux_660_nl : STD_LOGIC;
  SIGNAL or_1330_nl : STD_LOGIC;
  SIGNAL nand_207_nl : STD_LOGIC;
  SIGNAL mux_659_nl : STD_LOGIC;
  SIGNAL nand_208_nl : STD_LOGIC;
  SIGNAL or_1331_nl : STD_LOGIC;
  SIGNAL mux_658_nl : STD_LOGIC;
  SIGNAL mux_657_nl : STD_LOGIC;
  SIGNAL mux_656_nl : STD_LOGIC;
  SIGNAL or_1332_nl : STD_LOGIC;
  SIGNAL mux_653_nl : STD_LOGIC;
  SIGNAL nand_210_nl : STD_LOGIC;
  SIGNAL mux_650_nl : STD_LOGIC;
  SIGNAL mux_649_nl : STD_LOGIC;
  SIGNAL nand_211_nl : STD_LOGIC;
  SIGNAL mux_647_nl : STD_LOGIC;
  SIGNAL or_1338_nl : STD_LOGIC;
  SIGNAL mux_645_nl : STD_LOGIC;
  SIGNAL nor_135_nl : STD_LOGIC;
  SIGNAL mux_677_nl : STD_LOGIC;
  SIGNAL mux_676_nl : STD_LOGIC;
  SIGNAL mux_675_nl : STD_LOGIC;
  SIGNAL mux_674_nl : STD_LOGIC;
  SIGNAL nor_462_nl : STD_LOGIC;
  SIGNAL nor_463_nl : STD_LOGIC;
  SIGNAL nor_464_nl : STD_LOGIC;
  SIGNAL and_342_nl : STD_LOGIC;
  SIGNAL mux_673_nl : STD_LOGIC;
  SIGNAL nor_465_nl : STD_LOGIC;
  SIGNAL nor_466_nl : STD_LOGIC;
  SIGNAL mux_672_nl : STD_LOGIC;
  SIGNAL nor_467_nl : STD_LOGIC;
  SIGNAL nor_468_nl : STD_LOGIC;
  SIGNAL mux_671_nl : STD_LOGIC;
  SIGNAL or_595_nl : STD_LOGIC;
  SIGNAL or_593_nl : STD_LOGIC;
  SIGNAL mux_670_nl : STD_LOGIC;
  SIGNAL mux_669_nl : STD_LOGIC;
  SIGNAL nor_469_nl : STD_LOGIC;
  SIGNAL and_343_nl : STD_LOGIC;
  SIGNAL mux_668_nl : STD_LOGIC;
  SIGNAL mux_667_nl : STD_LOGIC;
  SIGNAL nor_470_nl : STD_LOGIC;
  SIGNAL nor_471_nl : STD_LOGIC;
  SIGNAL nor_472_nl : STD_LOGIC;
  SIGNAL mux_666_nl : STD_LOGIC;
  SIGNAL mux_665_nl : STD_LOGIC;
  SIGNAL mux_664_nl : STD_LOGIC;
  SIGNAL nor_473_nl : STD_LOGIC;
  SIGNAL nor_475_nl : STD_LOGIC;
  SIGNAL nor_476_nl : STD_LOGIC;
  SIGNAL mux_697_nl : STD_LOGIC;
  SIGNAL mux_696_nl : STD_LOGIC;
  SIGNAL mux_695_nl : STD_LOGIC;
  SIGNAL nand_202_nl : STD_LOGIC;
  SIGNAL or_1321_nl : STD_LOGIC;
  SIGNAL mux_694_nl : STD_LOGIC;
  SIGNAL nand_203_nl : STD_LOGIC;
  SIGNAL or_1322_nl : STD_LOGIC;
  SIGNAL mux_693_nl : STD_LOGIC;
  SIGNAL mux_692_nl : STD_LOGIC;
  SIGNAL mux_691_nl : STD_LOGIC;
  SIGNAL nand_204_nl : STD_LOGIC;
  SIGNAL mux_688_nl : STD_LOGIC;
  SIGNAL or_1325_nl : STD_LOGIC;
  SIGNAL mux_685_nl : STD_LOGIC;
  SIGNAL mux_684_nl : STD_LOGIC;
  SIGNAL nand_206_nl : STD_LOGIC;
  SIGNAL mux_682_nl : STD_LOGIC;
  SIGNAL or_1329_nl : STD_LOGIC;
  SIGNAL mux_680_nl : STD_LOGIC;
  SIGNAL nor_143_nl : STD_LOGIC;
  SIGNAL mux_712_nl : STD_LOGIC;
  SIGNAL mux_711_nl : STD_LOGIC;
  SIGNAL mux_710_nl : STD_LOGIC;
  SIGNAL mux_709_nl : STD_LOGIC;
  SIGNAL nor_432_nl : STD_LOGIC;
  SIGNAL nor_433_nl : STD_LOGIC;
  SIGNAL nor_434_nl : STD_LOGIC;
  SIGNAL and_334_nl : STD_LOGIC;
  SIGNAL mux_708_nl : STD_LOGIC;
  SIGNAL nor_435_nl : STD_LOGIC;
  SIGNAL nor_436_nl : STD_LOGIC;
  SIGNAL mux_707_nl : STD_LOGIC;
  SIGNAL nor_437_nl : STD_LOGIC;
  SIGNAL nor_438_nl : STD_LOGIC;
  SIGNAL mux_706_nl : STD_LOGIC;
  SIGNAL or_650_nl : STD_LOGIC;
  SIGNAL or_648_nl : STD_LOGIC;
  SIGNAL mux_705_nl : STD_LOGIC;
  SIGNAL mux_704_nl : STD_LOGIC;
  SIGNAL nor_439_nl : STD_LOGIC;
  SIGNAL and_335_nl : STD_LOGIC;
  SIGNAL mux_703_nl : STD_LOGIC;
  SIGNAL mux_702_nl : STD_LOGIC;
  SIGNAL nor_440_nl : STD_LOGIC;
  SIGNAL nor_441_nl : STD_LOGIC;
  SIGNAL nor_442_nl : STD_LOGIC;
  SIGNAL mux_701_nl : STD_LOGIC;
  SIGNAL mux_700_nl : STD_LOGIC;
  SIGNAL nor_443_nl : STD_LOGIC;
  SIGNAL mux_699_nl : STD_LOGIC;
  SIGNAL nor_444_nl : STD_LOGIC;
  SIGNAL nor_446_nl : STD_LOGIC;
  SIGNAL mux_732_nl : STD_LOGIC;
  SIGNAL mux_731_nl : STD_LOGIC;
  SIGNAL mux_730_nl : STD_LOGIC;
  SIGNAL nand_195_nl : STD_LOGIC;
  SIGNAL nand_196_nl : STD_LOGIC;
  SIGNAL mux_729_nl : STD_LOGIC;
  SIGNAL nand_197_nl : STD_LOGIC;
  SIGNAL or_1314_nl : STD_LOGIC;
  SIGNAL mux_728_nl : STD_LOGIC;
  SIGNAL mux_727_nl : STD_LOGIC;
  SIGNAL mux_726_nl : STD_LOGIC;
  SIGNAL nand_198_nl : STD_LOGIC;
  SIGNAL mux_723_nl : STD_LOGIC;
  SIGNAL nand_200_nl : STD_LOGIC;
  SIGNAL mux_720_nl : STD_LOGIC;
  SIGNAL mux_719_nl : STD_LOGIC;
  SIGNAL nand_201_nl : STD_LOGIC;
  SIGNAL mux_717_nl : STD_LOGIC;
  SIGNAL or_1320_nl : STD_LOGIC;
  SIGNAL mux_715_nl : STD_LOGIC;
  SIGNAL and_333_nl : STD_LOGIC;
  SIGNAL mux_747_nl : STD_LOGIC;
  SIGNAL mux_746_nl : STD_LOGIC;
  SIGNAL mux_745_nl : STD_LOGIC;
  SIGNAL mux_744_nl : STD_LOGIC;
  SIGNAL nor_404_nl : STD_LOGIC;
  SIGNAL and_321_nl : STD_LOGIC;
  SIGNAL nor_405_nl : STD_LOGIC;
  SIGNAL and_322_nl : STD_LOGIC;
  SIGNAL mux_743_nl : STD_LOGIC;
  SIGNAL and_323_nl : STD_LOGIC;
  SIGNAL nor_406_nl : STD_LOGIC;
  SIGNAL mux_742_nl : STD_LOGIC;
  SIGNAL nor_407_nl : STD_LOGIC;
  SIGNAL nor_408_nl : STD_LOGIC;
  SIGNAL mux_741_nl : STD_LOGIC;
  SIGNAL or_702_nl : STD_LOGIC;
  SIGNAL or_700_nl : STD_LOGIC;
  SIGNAL mux_740_nl : STD_LOGIC;
  SIGNAL mux_739_nl : STD_LOGIC;
  SIGNAL nor_409_nl : STD_LOGIC;
  SIGNAL and_324_nl : STD_LOGIC;
  SIGNAL mux_738_nl : STD_LOGIC;
  SIGNAL mux_737_nl : STD_LOGIC;
  SIGNAL nor_410_nl : STD_LOGIC;
  SIGNAL nor_411_nl : STD_LOGIC;
  SIGNAL nor_412_nl : STD_LOGIC;
  SIGNAL mux_736_nl : STD_LOGIC;
  SIGNAL mux_735_nl : STD_LOGIC;
  SIGNAL nor_413_nl : STD_LOGIC;
  SIGNAL mux_734_nl : STD_LOGIC;
  SIGNAL nor_414_nl : STD_LOGIC;
  SIGNAL nor_415_nl : STD_LOGIC;
  SIGNAL nor_416_nl : STD_LOGIC;
  SIGNAL mux_1418_nl : STD_LOGIC;
  SIGNAL nor_789_nl : STD_LOGIC;
  SIGNAL mux_1417_nl : STD_LOGIC;
  SIGNAL or_1409_nl : STD_LOGIC;
  SIGNAL or_1407_nl : STD_LOGIC;
  SIGNAL mux_1416_nl : STD_LOGIC;
  SIGNAL and_709_nl : STD_LOGIC;
  SIGNAL and_710_nl : STD_LOGIC;
  SIGNAL mux_1415_nl : STD_LOGIC;
  SIGNAL and_711_nl : STD_LOGIC;
  SIGNAL nor_790_nl : STD_LOGIC;
  SIGNAL and_712_nl : STD_LOGIC;
  SIGNAL mux_1414_nl : STD_LOGIC;
  SIGNAL nor_791_nl : STD_LOGIC;
  SIGNAL mux_1444_nl : STD_LOGIC;
  SIGNAL nand_259_nl : STD_LOGIC;
  SIGNAL or_1403_nl : STD_LOGIC;
  SIGNAL nor_792_nl : STD_LOGIC;
  SIGNAL mux_1429_nl : STD_LOGIC;
  SIGNAL nor_784_nl : STD_LOGIC;
  SIGNAL mux_1428_nl : STD_LOGIC;
  SIGNAL nor_785_nl : STD_LOGIC;
  SIGNAL mux_1427_nl : STD_LOGIC;
  SIGNAL nand_249_nl : STD_LOGIC;
  SIGNAL or_1425_nl : STD_LOGIC;
  SIGNAL and_708_nl : STD_LOGIC;
  SIGNAL mux_1426_nl : STD_LOGIC;
  SIGNAL and_713_nl : STD_LOGIC;
  SIGNAL nor_787_nl : STD_LOGIC;
  SIGNAL nor_788_nl : STD_LOGIC;
  SIGNAL mux_1424_nl : STD_LOGIC;
  SIGNAL mux_1423_nl : STD_LOGIC;
  SIGNAL or_1420_nl : STD_LOGIC;
  SIGNAL nand_247_nl : STD_LOGIC;
  SIGNAL or_1415_nl : STD_LOGIC;
  SIGNAL mux_1421_nl : STD_LOGIC;
  SIGNAL mux_1420_nl : STD_LOGIC;
  SIGNAL mux_1437_nl : STD_LOGIC;
  SIGNAL mux_1436_nl : STD_LOGIC;
  SIGNAL mux_1435_nl : STD_LOGIC;
  SIGNAL mux_1434_nl : STD_LOGIC;
  SIGNAL mux_1433_nl : STD_LOGIC;
  SIGNAL or_1456_nl : STD_LOGIC;
  SIGNAL nand_nl : STD_LOGIC;
  SIGNAL or_1457_nl : STD_LOGIC;
  SIGNAL nand_256_nl : STD_LOGIC;
  SIGNAL mux_1432_nl : STD_LOGIC;
  SIGNAL nor_775_nl : STD_LOGIC;
  SIGNAL mux_1431_nl : STD_LOGIC;
  SIGNAL nor_776_nl : STD_LOGIC;
  SIGNAL nor_777_nl : STD_LOGIC;
  SIGNAL mux_1443_nl : STD_LOGIC;
  SIGNAL mux_1442_nl : STD_LOGIC;
  SIGNAL mux_1441_nl : STD_LOGIC;
  SIGNAL nor_779_nl : STD_LOGIC;
  SIGNAL mux_1440_nl : STD_LOGIC;
  SIGNAL nor_780_nl : STD_LOGIC;
  SIGNAL and_nl : STD_LOGIC;
  SIGNAL mux_1439_nl : STD_LOGIC;
  SIGNAL nor_781_nl : STD_LOGIC;
  SIGNAL nor_782_nl : STD_LOGIC;
  SIGNAL nor_783_nl : STD_LOGIC;
  SIGNAL mux_1438_nl : STD_LOGIC;
  SIGNAL nand_262_nl : STD_LOGIC;
  SIGNAL or_1442_nl : STD_LOGIC;
  SIGNAL mux_1038_nl : STD_LOGIC;
  SIGNAL modExp_while_mux1h_3_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_725_nl : STD_LOGIC;
  SIGNAL and_726_nl : STD_LOGIC;
  SIGNAL modExp_while_mux_1_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_while_or_2_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux_45_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_727_nl : STD_LOGIC;
  SIGNAL acc_1_nl : STD_LOGIC_VECTOR (65 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_or_6_nl : STD_LOGIC_VECTOR (55 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_46_nl : STD_LOGIC_VECTOR (55 DOWNTO 0);
  SIGNAL COMP_LOOP_mux1h_268_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_269_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_270_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_271_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_272_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_273_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_274_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_275_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_48_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_COMP_LOOP_nand_1_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_47_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_not_199_nl : STD_LOGIC;
  SIGNAL acc_2_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL operator_64_false_1_operator_64_false_1_or_2_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_operator_64_false_1_or_3_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux_1_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_3_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL operator_64_false_1_or_4_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_operator_64_false_1_and_1_nl : STD_LOGIC;
  SIGNAL operator_64_false_1_mux1h_4_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL operator_64_false_1_or_5_nl : STD_LOGIC;
  SIGNAL acc_3_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_or_7_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_mux_9_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL COMP_LOOP_or_49_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_mux_10_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_or_8_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_or_9_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_or_10_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_58_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_mux_11_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_59_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_or_50_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL COMP_LOOP_mux1h_276_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL and_728_nl : STD_LOGIC;
  SIGNAL and_729_nl : STD_LOGIC;
  SIGNAL and_730_nl : STD_LOGIC;
  SIGNAL and_731_nl : STD_LOGIC;
  SIGNAL and_732_nl : STD_LOGIC;
  SIGNAL and_733_nl : STD_LOGIC;
  SIGNAL and_734_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_or_51_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_2_nl : STD_LOGIC_VECTOR (52 DOWNTO 0);
  SIGNAL COMP_LOOP_not_200_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux_48_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_and_220_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL not_2902_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_or_11_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_3_nl : STD_LOGIC_VECTOR (51 DOWNTO 0);
  SIGNAL COMP_LOOP_or_52_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_mux1h_277_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_COMP_LOOP_and_221_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL COMP_LOOP_nor_109_nl : STD_LOGIC;
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
      STAGE_LOOP_C_8_tr0 : IN STD_LOGIC;
      modExp_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_1_tr0 : IN STD_LOGIC;
      COMP_LOOP_1_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_65_tr0 : IN STD_LOGIC;
      COMP_LOOP_2_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_130_tr0 : IN STD_LOGIC;
      COMP_LOOP_3_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_195_tr0 : IN STD_LOGIC;
      COMP_LOOP_4_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_260_tr0 : IN STD_LOGIC;
      COMP_LOOP_5_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_325_tr0 : IN STD_LOGIC;
      COMP_LOOP_6_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_390_tr0 : IN STD_LOGIC;
      COMP_LOOP_7_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_455_tr0 : IN STD_LOGIC;
      COMP_LOOP_8_modExp_1_while_C_40_tr0 : IN STD_LOGIC;
      COMP_LOOP_C_520_tr0 : IN STD_LOGIC;
      VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
      STAGE_LOOP_C_9_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (9 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_8_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_65_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_40_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_130_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_3_modExp_1_while_C_40_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_195_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_4_modExp_1_while_C_40_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_260_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_5_modExp_1_while_C_40_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_325_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_6_modExp_1_while_C_40_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_390_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_7_modExp_1_while_C_40_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_455_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_8_modExp_1_while_C_40_tr0 :
      STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0 : STD_LOGIC;

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

  FUNCTION MUX1HOT_v_11_3_2(input_2 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
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
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_3_6_2(input_5 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(5 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
      tmp := (OTHERS=>sel( 5));
      result := result or ( input_5 and tmp);
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

  FUNCTION MUX1HOT_v_6_3_2(input_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_6_4_2(input_3 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(5 DOWNTO 0);

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

  FUNCTION MUX1HOT_v_9_11_2(input_10 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(10 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 8));
      result := result or ( input_8 and tmp);
      tmp := (OTHERS=>sel( 9));
      result := result or ( input_9 and tmp);
      tmp := (OTHERS=>sel( 10));
      result := result or ( input_10 and tmp);
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

  FUNCTION MUX_v_3_2_2(input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);

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

  FUNCTION MUX_v_52_2_2(input_0 : STD_LOGIC_VECTOR(51 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(51 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(51 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_53_2_2(input_0 : STD_LOGIC_VECTOR(52 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(52 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(52 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_56_2_2(input_0 : STD_LOGIC_VECTOR(55 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(55 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(55 DOWNTO 0);

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

  FUNCTION MUX_v_6_2_2(input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);

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

  vec_rsc_triosy_0_7_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_7_lz
    );
  vec_rsc_triosy_0_6_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_6_lz
    );
  vec_rsc_triosy_0_5_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_5_lz
    );
  vec_rsc_triosy_0_4_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_4_lz
    );
  vec_rsc_triosy_0_3_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_3_lz
    );
  vec_rsc_triosy_0_2_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_2_lz
    );
  vec_rsc_triosy_0_1_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_1_lz
    );
  vec_rsc_triosy_0_0_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => vec_rsc_triosy_0_0_lz
    );
  p_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
      lz => p_rsc_triosy_lz
    );
  r_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_0_7_obj_ld_cse,
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
      STAGE_LOOP_C_8_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_8_tr0,
      modExp_while_C_40_tr0 => COMP_LOOP_COMP_LOOP_and_11_itm,
      COMP_LOOP_C_1_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0,
      COMP_LOOP_1_modExp_1_while_C_40_tr0 => COMP_LOOP_COMP_LOOP_and_11_itm,
      COMP_LOOP_C_65_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_65_tr0,
      COMP_LOOP_2_modExp_1_while_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_130_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_130_tr0,
      COMP_LOOP_3_modExp_1_while_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_3_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_195_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_195_tr0,
      COMP_LOOP_4_modExp_1_while_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_4_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_260_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_260_tr0,
      COMP_LOOP_5_modExp_1_while_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_5_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_325_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_325_tr0,
      COMP_LOOP_6_modExp_1_while_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_6_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_390_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_390_tr0,
      COMP_LOOP_7_modExp_1_while_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_7_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_455_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_455_tr0,
      COMP_LOOP_8_modExp_1_while_C_40_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_8_modExp_1_while_C_40_tr0,
      COMP_LOOP_C_520_tr0 => COMP_LOOP_COMP_LOOP_and_2_itm,
      VEC_LOOP_C_0_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_9_tr0 => inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0
    );
  fsm_output <= inPlaceNTT_DIT_core_core_fsm_inst_fsm_output;
  inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_8_tr0 <= NOT (z_out_7(64));
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 <= NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_65_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_40_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_130_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_3_modExp_1_while_C_40_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_195_tr0 <= NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_4_modExp_1_while_C_40_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_260_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_5_modExp_1_while_C_40_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_325_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_6_modExp_1_while_C_40_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_390_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_7_modExp_1_while_C_40_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_455_tr0 <= NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_8_modExp_1_while_C_40_tr0 <= NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 <= z_out_1(12);
  inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0 <= NOT STAGE_LOOP_acc_itm_2_1;

  or_1380_nl <= (fsm_output(6)) OR (fsm_output(3)) OR (fsm_output(5)) OR nand_245_cse;
  or_1381_nl <= (NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR (fsm_output(5))
      OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  mux_477_cse <= MUX_s_1_2_2(or_1380_nl, or_1381_nl, fsm_output(4));
  or_294_cse <= (COMP_LOOP_acc_13_psp_sva(0)) OR (NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm)
      OR (VEC_LOOP_j_sva_11_0(1));
  nor_624_cse <= NOT((fsm_output(9)) OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 5)/=STD_LOGIC_VECTOR'("10")) OR not_tmp_170);
  nor_594_cse <= NOT((fsm_output(9)) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 5)/=STD_LOGIC_VECTOR'("10")) OR not_tmp_170);
  nor_115_cse <= NOT((COMP_LOOP_acc_13_psp_sva(0)) OR (NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm)
      OR (NOT (VEC_LOOP_j_sva_11_0(1))));
  or_521_cse <= (NOT (COMP_LOOP_acc_13_psp_sva(0))) OR (NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm)
      OR (VEC_LOOP_j_sva_11_0(1));
  and_336_cse <= (COMP_LOOP_acc_13_psp_sva(0)) AND COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm
      AND (VEC_LOOP_j_sva_11_0(1));
  and_316_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11"));
  or_722_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"));
  or_730_cse <= (fsm_output(0)) OR (fsm_output(7));
  nor_397_cse <= NOT((fsm_output(6)) OR (fsm_output(9)) OR (NOT (fsm_output(1)))
      OR (NOT (fsm_output(3))) OR (fsm_output(5)));
  nor_398_cse <= NOT(CONV_SL_1_1(fsm_output(9 DOWNTO 1)/=STD_LOGIC_VECTOR'("000011010")));
  nor_400_cse <= NOT((NOT (fsm_output(7))) OR (fsm_output(0)));
  nor_401_cse <= NOT((fsm_output(0)) OR (fsm_output(9)));
  and_312_cse <= (fsm_output(7)) AND (fsm_output(9));
  or_1275_cse <= (NOT (fsm_output(0))) OR (fsm_output(9));
  or_731_cse <= (NOT (fsm_output(6))) OR (fsm_output(8));
  or_718_cse <= (fsm_output(8)) OR (fsm_output(0)) OR (NOT (fsm_output(7)));
  and_303_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  nor_379_cse <= NOT((fsm_output(0)) OR (fsm_output(4)));
  or_217_cse <= CONV_SL_1_1(fsm_output(6 DOWNTO 3)/=STD_LOGIC_VECTOR'("0000"));
  and_56_nl <= (fsm_output(7)) AND or_217_cse;
  and_55_nl <= (fsm_output(7)) AND or_5_cse;
  mux_445_cse <= MUX_s_1_2_2(and_56_nl, and_55_nl, fsm_output(1));
  and_57_nl <= (fsm_output(8)) AND mux_445_cse;
  mux_446_cse <= MUX_s_1_2_2(not_tmp_129, and_57_nl, fsm_output(9));
  or_831_cse <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("01"));
  mux_995_cse <= MUX_s_1_2_2((NOT (fsm_output(7))), (fsm_output(7)), fsm_output(8));
  mux_1001_cse <= MUX_s_1_2_2(mux_tmp_898, or_tmp_71, fsm_output(0));
  nor_333_nl <= NOT((NOT (fsm_output(6))) OR (NOT (fsm_output(9))) OR (fsm_output(1))
      OR (NOT (fsm_output(3))) OR (fsm_output(5)));
  mux_1107_nl <= MUX_s_1_2_2(nor_333_nl, nor_397_cse, fsm_output(8));
  nor_335_nl <= NOT((fsm_output(8)) OR (fsm_output(6)) OR (fsm_output(9)) OR (fsm_output(1))
      OR (fsm_output(3)) OR (NOT (fsm_output(5))));
  mux_1108_nl <= MUX_s_1_2_2(mux_1107_nl, nor_335_nl, fsm_output(7));
  nor_336_nl <= NOT((NOT (fsm_output(7))) OR (fsm_output(8)) OR (fsm_output(6)) OR
      (NOT (fsm_output(9))) OR (NOT (fsm_output(1))) OR (fsm_output(3)) OR (NOT (fsm_output(5))));
  mux_1109_nl <= MUX_s_1_2_2(mux_1108_nl, nor_336_nl, fsm_output(4));
  nor_337_nl <= NOT((NOT (fsm_output(9))) OR (fsm_output(1)) OR (NOT (fsm_output(3)))
      OR (fsm_output(5)));
  nor_338_nl <= NOT((fsm_output(9)) OR (fsm_output(1)) OR (fsm_output(3)) OR (NOT
      (fsm_output(5))));
  mux_1105_nl <= MUX_s_1_2_2(nor_337_nl, nor_338_nl, fsm_output(6));
  and_275_nl <= (fsm_output(8)) AND mux_1105_nl;
  nor_339_nl <= NOT((NOT (fsm_output(8))) OR (NOT (fsm_output(6))) OR (fsm_output(9))
      OR (NOT (fsm_output(1))) OR (NOT (fsm_output(3))) OR (fsm_output(5)));
  mux_1106_nl <= MUX_s_1_2_2(and_275_nl, nor_339_nl, fsm_output(7));
  and_274_nl <= (fsm_output(4)) AND mux_1106_nl;
  mux_1110_nl <= MUX_s_1_2_2(mux_1109_nl, and_274_nl, fsm_output(2));
  mux_1111_nl <= MUX_s_1_2_2(mux_1110_nl, nor_398_cse, fsm_output(0));
  modExp_while_if_or_nl <= and_dcpl_150 OR (mux_1111_nl AND COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm);
  modExp_1_while_and_16_nl <= (NOT (modulo_result_rem_cmp_z(63))) AND COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm
      AND and_dcpl_174;
  modExp_1_while_and_18_nl <= (modulo_result_rem_cmp_z(63)) AND COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm
      AND and_dcpl_174;
  modExp_while_if_mux1h_nl <= MUX1HOT_v_64_5_2(z_out, STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000001"),
      modulo_result_rem_cmp_z, modulo_qr_sva_1_mx1w1, COMP_LOOP_1_acc_5_mut_mx0w5,
      STD_LOGIC_VECTOR'( modExp_while_if_or_nl & COMP_LOOP_nor_97_cse & modExp_1_while_and_16_nl
      & modExp_1_while_and_18_nl & and_dcpl_151));
  mux_949_nl <= MUX_s_1_2_2((NOT or_tmp_71), mux_tmp_898, or_731_cse);
  mux_1005_nl <= MUX_s_1_2_2(mux_923_cse, mux_tmp_900, fsm_output(6));
  mux_950_nl <= MUX_s_1_2_2(mux_949_nl, mux_1005_nl, fsm_output(1));
  mux_1002_nl <= MUX_s_1_2_2((NOT or_tmp_71), mux_1001_cse, fsm_output(8));
  mux_1003_nl <= MUX_s_1_2_2(mux_919_cse, mux_1002_nl, fsm_output(6));
  mux_1000_nl <= MUX_s_1_2_2(mux_937_cse, (fsm_output(8)), fsm_output(6));
  mux_1004_nl <= MUX_s_1_2_2(mux_1003_nl, mux_1000_nl, fsm_output(1));
  mux_951_nl <= MUX_s_1_2_2(mux_950_nl, mux_1004_nl, fsm_output(2));
  mux_952_nl <= MUX_s_1_2_2(mux_951_nl, mux_1460_cse, fsm_output(5));
  mux_996_nl <= MUX_s_1_2_2(mux_995_cse, mux_937_cse, fsm_output(6));
  mux_991_nl <= MUX_s_1_2_2((NOT (fsm_output(7))), and_312_cse, fsm_output(8));
  mux_992_nl <= MUX_s_1_2_2(mux_991_nl, mux_929_cse, fsm_output(6));
  mux_997_nl <= MUX_s_1_2_2(mux_996_nl, mux_992_nl, fsm_output(1));
  mux_998_nl <= MUX_s_1_2_2(mux_997_nl, mux_1447_cse, fsm_output(2));
  mux_999_nl <= MUX_s_1_2_2(mux_928_cse, mux_998_nl, fsm_output(5));
  mux_953_nl <= MUX_s_1_2_2(mux_952_nl, mux_999_nl, fsm_output(4));
  and_176_nl <= (fsm_output(8)) AND or_tmp_783;
  mux_987_nl <= MUX_s_1_2_2(mux_929_cse, and_176_nl, fsm_output(6));
  mux_988_nl <= MUX_s_1_2_2(mux_987_nl, mux_928_cse, or_722_cse);
  mux_981_nl <= MUX_s_1_2_2(mux_903_cse, mux_923_cse, fsm_output(6));
  mux_977_nl <= MUX_s_1_2_2(mux_tmp_898, or_tmp_72, fsm_output(0));
  mux_978_nl <= MUX_s_1_2_2(mux_977_nl, (fsm_output(7)), fsm_output(8));
  mux_979_nl <= MUX_s_1_2_2(mux_978_nl, mux_919_cse, fsm_output(6));
  mux_982_nl <= MUX_s_1_2_2(mux_981_nl, mux_979_nl, fsm_output(1));
  mux_984_nl <= MUX_s_1_2_2(mux_1460_cse, mux_982_nl, fsm_output(2));
  mux_989_nl <= MUX_s_1_2_2(mux_988_nl, mux_984_nl, fsm_output(5));
  mux_970_nl <= MUX_s_1_2_2((NOT mux_tmp_898), or_tmp_783, fsm_output(0));
  mux_971_nl <= MUX_s_1_2_2(mux_970_nl, (fsm_output(9)), fsm_output(8));
  mux_972_nl <= MUX_s_1_2_2(mux_971_nl, mux_tmp_912, fsm_output(6));
  mux_967_nl <= MUX_s_1_2_2(or_tmp_783, and_312_cse, fsm_output(8));
  mux_966_nl <= MUX_s_1_2_2((NOT or_tmp_72), or_823_cse, fsm_output(8));
  mux_968_nl <= MUX_s_1_2_2(mux_967_nl, mux_966_nl, fsm_output(6));
  mux_973_nl <= MUX_s_1_2_2(mux_972_nl, mux_968_nl, fsm_output(1));
  mux_963_nl <= MUX_s_1_2_2(or_823_cse, and_312_cse, fsm_output(8));
  mux_962_nl <= MUX_s_1_2_2((NOT (fsm_output(7))), (fsm_output(7)), or_831_cse);
  mux_964_nl <= MUX_s_1_2_2(mux_963_nl, mux_962_nl, fsm_output(6));
  mux_959_nl <= MUX_s_1_2_2(and_312_cse, mux_tmp_898, fsm_output(8));
  mux_961_nl <= MUX_s_1_2_2(mux_903_cse, mux_959_nl, fsm_output(6));
  mux_965_nl <= MUX_s_1_2_2(mux_964_nl, mux_961_nl, fsm_output(1));
  mux_974_nl <= MUX_s_1_2_2(mux_973_nl, mux_965_nl, fsm_output(2));
  mux_975_nl <= MUX_s_1_2_2(mux_974_nl, mux_1447_cse, fsm_output(5));
  mux_990_nl <= MUX_s_1_2_2(mux_989_nl, mux_975_nl, fsm_output(4));
  mux_954_nl <= MUX_s_1_2_2(mux_953_nl, mux_990_nl, fsm_output(3));
  operator_64_false_operator_64_false_mux_rgt <= MUX_v_65_2_2(('0' & modExp_while_if_mux1h_nl),
      z_out_2, mux_954_nl);
  or_1470_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  or_1516_cse <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00"));
  and_721_cse <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)=STD_LOGIC_VECTOR'("11"));
  nor_813_cse <= NOT((fsm_output(6)) OR (NOT (fsm_output(8))));
  or_1466_nl <= nor_813_cse OR (fsm_output(9));
  mux_1460_cse <= MUX_s_1_2_2((NOT (fsm_output(7))), (fsm_output(7)), or_1466_nl);
  mux_1447_cse <= MUX_s_1_2_2(mux_tmp_900, mux_tmp_899, fsm_output(6));
  or_1483_cse <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00"));
  nor_820_cse <= NOT(COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm OR (NOT (fsm_output(8))));
  or_843_cse <= (NOT (fsm_output(3))) OR (fsm_output(1)) OR (fsm_output(4)) OR (fsm_output(5));
  or_857_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  and_293_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)=STD_LOGIC_VECTOR'("11"));
  and_292_cse <= CONV_SL_1_1(fsm_output(5 DOWNTO 4)=STD_LOGIC_VECTOR'("11"));
  or_844_nl <= (fsm_output(3)) OR (NOT((fsm_output(1)) AND (fsm_output(4)) AND (fsm_output(5))));
  mux_1014_cse <= MUX_s_1_2_2(or_844_nl, or_843_cse, fsm_output(0));
  and_185_m1c <= and_dcpl_103 AND and_dcpl_72;
  or_5_cse <= CONV_SL_1_1(fsm_output(6 DOWNTO 2)/=STD_LOGIC_VECTOR'("00000"));
  modExp_result_and_rgt <= (NOT modExp_while_and_1_rgt) AND and_185_m1c;
  modExp_result_and_1_rgt <= modExp_while_and_1_rgt AND and_185_m1c;
  COMP_LOOP_COMP_LOOP_and_11_cse <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)=STD_LOGIC_VECTOR'("101"));
  modExp_while_or_1_cse <= and_dcpl_90 OR and_dcpl_98 OR and_dcpl_104 OR and_dcpl_109
      OR and_dcpl_116 OR and_dcpl_126 OR and_dcpl_134;
  COMP_LOOP_COMP_LOOP_and_37_cse <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)=STD_LOGIC_VECTOR'("011"));
  nor_692_cse <= NOT(CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000")));
  or_157_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  and_398_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11"));
  nor_308_nl <= NOT((fsm_output(4)) OR (fsm_output(3)) OR (NOT (fsm_output(7))) OR
      (fsm_output(5)));
  nor_309_nl <= NOT((fsm_output(4)) OR (NOT (fsm_output(3))) OR (fsm_output(7)) OR
      (NOT (fsm_output(5))));
  mux_1257_nl <= MUX_s_1_2_2(nor_308_nl, nor_309_nl, fsm_output(9));
  nand_82_cse <= NOT((fsm_output(6)) AND mux_1257_nl);
  or_1161_cse <= (fsm_output(1)) OR (fsm_output(6)) OR (fsm_output(9)) OR (NOT (fsm_output(8)))
      OR (fsm_output(2)) OR (fsm_output(7));
  or_1156_cse <= (NOT (fsm_output(8))) OR (fsm_output(2)) OR (fsm_output(7));
  or_1168_nl <= (fsm_output(4)) OR (NOT (fsm_output(1))) OR (NOT (fsm_output(6)))
      OR (NOT (fsm_output(9))) OR (fsm_output(8)) OR (NOT (fsm_output(2))) OR (fsm_output(7));
  or_1166_nl <= (fsm_output(8)) OR (NOT (fsm_output(2))) OR (fsm_output(7));
  or_1165_nl <= (fsm_output(8)) OR (fsm_output(2)) OR (NOT (fsm_output(7)));
  mux_1318_nl <= MUX_s_1_2_2(or_1166_nl, or_1165_nl, fsm_output(9));
  nor_292_nl <= NOT((fsm_output(6)) OR mux_1318_nl);
  nor_293_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(9)) OR (NOT (fsm_output(8)))
      OR (fsm_output(2)) OR (fsm_output(7)));
  mux_1319_nl <= MUX_s_1_2_2(nor_292_nl, nor_293_nl, fsm_output(1));
  nand_86_nl <= NOT((fsm_output(4)) AND mux_1319_nl);
  mux_1320_nl <= MUX_s_1_2_2(or_1168_nl, nand_86_nl, fsm_output(5));
  or_1160_nl <= (NOT (fsm_output(6))) OR (fsm_output(9)) OR (NOT((fsm_output(8))
      AND (fsm_output(2)) AND (fsm_output(7))));
  or_1157_nl <= (fsm_output(8)) OR (NOT((fsm_output(2)) AND (fsm_output(7))));
  mux_1315_nl <= MUX_s_1_2_2(or_1157_nl, or_1156_cse, fsm_output(9));
  or_1158_nl <= (fsm_output(6)) OR mux_1315_nl;
  mux_1316_nl <= MUX_s_1_2_2(or_1160_nl, or_1158_nl, fsm_output(1));
  mux_1317_nl <= MUX_s_1_2_2(or_1161_cse, mux_1316_nl, fsm_output(4));
  or_1162_nl <= (fsm_output(5)) OR mux_1317_nl;
  mux_1321_nl <= MUX_s_1_2_2(mux_1320_nl, or_1162_nl, fsm_output(3));
  COMP_LOOP_nor_97_cse <= NOT(mux_1321_nl OR (fsm_output(0)));
  modulo_result_mux_1_cse <= MUX_v_64_2_2(modulo_result_rem_cmp_z, modulo_qr_sva_1_mx1w1,
      modulo_result_rem_cmp_z(63));
  nand_245_cse <= NOT((fsm_output(7)) AND (fsm_output(9)));
  or_29_cse <= (fsm_output(7)) OR (NOT (fsm_output(1))) OR (NOT (fsm_output(9)))
      OR (fsm_output(6)) OR (NOT (fsm_output(8)));
  nand_244_cse <= NOT(nand_245_cse AND (fsm_output(8)));
  mux_417_cse <= MUX_s_1_2_2(not_tmp_121, or_1483_cse, fsm_output(7));
  mux_438_cse <= MUX_s_1_2_2(or_tmp_73, mux_tmp_390, fsm_output(6));
  nor_265_cse <= NOT((fsm_output(2)) OR (NOT (fsm_output(4))));
  COMP_LOOP_or_3_cse <= and_dcpl_77 OR and_dcpl_90 OR and_dcpl_98 OR and_dcpl_104
      OR and_dcpl_109 OR and_dcpl_116 OR and_dcpl_126 OR and_dcpl_134;
  COMP_LOOP_COMP_LOOP_and_12_cse <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110"));
  COMP_LOOP_COMP_LOOP_and_13_cse <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  STAGE_LOOP_i_3_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_i_3_0_sva)
      + UNSIGNED'( "0001"), 4));
  COMP_LOOP_acc_psp_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_11_0(11
      DOWNTO 3)) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_3_sva_5_0),
      6), 9), 9));
  COMP_LOOP_1_acc_5_mut_mx0w5 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(tmp_10_lpi_4_dfm)
      + SIGNED(modulo_result_mux_1_cse), 64));
  modExp_while_and_1_rgt <= (modulo_result_rem_cmp_z(63)) AND operator_64_false_slc_modExp_exp_0_1_itm;
  modulo_qr_sva_1_mx1w1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(modulo_result_rem_cmp_z)
      + UNSIGNED(p_sva), 64));
  operator_64_false_slc_modExp_exp_63_1_3 <= MUX_v_63_2_2((operator_66_true_div_cmp_z(63
      DOWNTO 1)), ('0' & (modExp_exp_sva_rsp_1(62 DOWNTO 1))), or_dcpl_56);
  COMP_LOOP_acc_1_cse_2_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_11_0)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_3_sva_5_0 & STD_LOGIC_VECTOR'(
      "001")), 9), 12), 12));
  COMP_LOOP_COMP_LOOP_and_211 <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO
      0)=STD_LOGIC_VECTOR'("001"));
  COMP_LOOP_COMP_LOOP_and_213 <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO
      0)=STD_LOGIC_VECTOR'("010"));
  COMP_LOOP_COMP_LOOP_and_215 <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO
      0)=STD_LOGIC_VECTOR'("100"));
  or_dcpl_3 <= (NOT COMP_LOOP_COMP_LOOP_and_11_itm) OR (z_out_7(64));
  or_tmp_5 <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("01"));
  or_tmp_9 <= (NOT (fsm_output(0))) OR (fsm_output(7));
  or_tmp_13 <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("10"));
  nand_240_cse <= NOT((fsm_output(6)) AND (fsm_output(0)));
  not_tmp_29 <= NOT((fsm_output(6)) AND (fsm_output(8)));
  or_tmp_58 <= (fsm_output(5)) OR and_398_cse;
  or_tmp_60 <= CONV_SL_1_1(fsm_output(5 DOWNTO 2)/=STD_LOGIC_VECTOR'("0000"));
  mux_tmp_77 <= MUX_s_1_2_2((NOT and_292_cse), or_tmp_58, fsm_output(6));
  or_tmp_63 <= and_721_cse OR (fsm_output(4));
  not_tmp_46 <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00")));
  mux_tmp_81 <= MUX_s_1_2_2(not_tmp_46, (fsm_output(4)), fsm_output(5));
  mux_82_cse <= MUX_s_1_2_2(or_tmp_60, mux_tmp_81, fsm_output(6));
  mux_tmp_83 <= MUX_s_1_2_2(mux_82_cse, mux_tmp_77, fsm_output(7));
  nor_tmp_12 <= or_1516_cse AND (fsm_output(4));
  and_tmp_2 <= (fsm_output(5)) AND nor_tmp_12;
  or_tmp_71 <= (NOT (fsm_output(9))) OR (fsm_output(7));
  or_tmp_72 <= (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_tmp_73 <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("10"));
  or_90_cse <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("10"));
  or_91_cse <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("01"));
  nor_tmp_13 <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("11"));
  mux_tmp_164 <= MUX_s_1_2_2(or_90_cse, or_91_cse, fsm_output(6));
  and_434_cse <= (fsm_output(9)) AND (fsm_output(6));
  and_433_cse <= CONV_SL_1_1(fsm_output(6 DOWNTO 4)=STD_LOGIC_VECTOR'("111"));
  nor_tmp_21 <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("111"));
  not_tmp_82 <= NOT(CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00")));
  and_432_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)=STD_LOGIC_VECTOR'("11"));
  mux_tmp_229 <= MUX_s_1_2_2(not_tmp_82, and_432_nl, fsm_output(7));
  or_119_cse <= (fsm_output(6)) OR (fsm_output(9));
  mux_tmp_390 <= MUX_s_1_2_2((NOT (fsm_output(8))), or_1483_cse, fsm_output(7));
  not_tmp_121 <= NOT(CONV_SL_1_1(fsm_output(9 DOWNTO 8)=STD_LOGIC_VECTOR'("11")));
  and_dcpl_15 <= NOT((fsm_output(7)) OR (fsm_output(1)));
  and_dcpl_16 <= and_dcpl_15 AND (fsm_output(8));
  and_dcpl_18 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_23 <= not_tmp_46 AND (fsm_output(2));
  and_dcpl_26 <= (fsm_output(9)) AND (NOT (fsm_output(0)));
  and_dcpl_33 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")));
  not_tmp_129 <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 1)/=STD_LOGIC_VECTOR'("00000000")));
  and_60_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)=STD_LOGIC_VECTOR'("11")) AND mux_445_cse;
  mux_453_itm <= MUX_s_1_2_2(mux_446_cse, and_60_nl, fsm_output(0));
  and_dcpl_49 <= and_dcpl_15 AND (NOT (fsm_output(8)));
  and_dcpl_50 <= and_dcpl_49 AND nor_401_cse;
  and_dcpl_53 <= not_tmp_46 AND (NOT (fsm_output(2)));
  and_dcpl_57 <= (fsm_output(7)) AND (NOT (fsm_output(1)));
  and_dcpl_58 <= and_dcpl_57 AND (fsm_output(8));
  and_dcpl_61 <= and_dcpl_23 AND and_dcpl_33;
  or_dcpl_39 <= or_157_cse OR (fsm_output(5));
  and_dcpl_63 <= (NOT (fsm_output(9))) AND (fsm_output(0));
  and_dcpl_64 <= (NOT (fsm_output(7))) AND (fsm_output(1));
  and_dcpl_65 <= and_dcpl_64 AND (NOT (fsm_output(8)));
  and_dcpl_66 <= and_dcpl_65 AND and_dcpl_63;
  and_dcpl_67 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_68 <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_69 <= and_dcpl_68 AND (NOT (fsm_output(2)));
  and_dcpl_70 <= and_dcpl_69 AND and_dcpl_67;
  and_dcpl_71 <= and_dcpl_70 AND and_dcpl_66;
  and_dcpl_72 <= and_dcpl_65 AND nor_401_cse;
  and_dcpl_75 <= and_398_cse AND (fsm_output(2));
  and_dcpl_76 <= and_dcpl_75 AND and_dcpl_18;
  and_dcpl_77 <= and_dcpl_76 AND and_dcpl_72;
  and_dcpl_78 <= and_dcpl_57 AND (NOT (fsm_output(8)));
  and_dcpl_79 <= and_dcpl_78 AND nor_401_cse;
  and_dcpl_81 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("010"));
  and_dcpl_82 <= and_dcpl_81 AND and_dcpl_33;
  and_dcpl_90 <= and_dcpl_81 AND and_dcpl_18 AND and_dcpl_79;
  and_dcpl_91 <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_96 <= and_dcpl_64 AND (fsm_output(8));
  and_dcpl_97 <= and_dcpl_96 AND nor_401_cse;
  and_dcpl_98 <= and_dcpl_70 AND and_dcpl_97;
  and_dcpl_102 <= and_dcpl_58 AND nor_401_cse;
  and_dcpl_103 <= and_dcpl_75 AND and_dcpl_33;
  and_dcpl_104 <= and_dcpl_103 AND and_dcpl_102;
  and_dcpl_108 <= and_dcpl_65 AND and_dcpl_26;
  and_dcpl_109 <= and_dcpl_61 AND and_dcpl_108;
  and_dcpl_115 <= and_dcpl_69 AND CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11"));
  and_dcpl_116 <= and_dcpl_115 AND and_dcpl_49 AND and_dcpl_26;
  and_dcpl_122 <= (fsm_output(7)) AND (fsm_output(1)) AND (NOT (fsm_output(8)));
  and_dcpl_124 <= and_398_cse AND (NOT (fsm_output(2)));
  and_dcpl_126 <= and_dcpl_124 AND and_dcpl_18 AND and_dcpl_122 AND and_dcpl_26;
  and_dcpl_133 <= and_dcpl_23 AND and_dcpl_18;
  and_dcpl_134 <= and_dcpl_133 AND and_dcpl_16 AND and_dcpl_26;
  or_263_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_261_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_469 <= MUX_s_1_2_2(or_263_nl, or_261_nl, fsm_output(3));
  nor_640_nl <= NOT((NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("000")) OR (fsm_output(5)) OR nand_245_cse);
  nor_641_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("000")) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  not_tmp_166 <= MUX_s_1_2_2(nor_640_nl, nor_641_nl, fsm_output(6));
  or_270_nl <= (fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7));
  or_269_nl <= (NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7));
  mux_tmp_472 <= MUX_s_1_2_2(or_270_nl, or_269_nl, fsm_output(4));
  or_275_nl <= (VEC_LOOP_j_sva_11_0(2)) OR (fsm_output(6)) OR (NOT (fsm_output(3)))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_273_nl <= (fsm_output(6)) OR (fsm_output(3)) OR (COMP_LOOP_acc_13_psp_sva(0))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_473 <= MUX_s_1_2_2(or_275_nl, or_273_nl, fsm_output(4));
  or_1376_nl <= (NOT (fsm_output(6))) OR (fsm_output(3)) OR (fsm_output(5)) OR (NOT
      (fsm_output(9))) OR (fsm_output(7));
  or_1377_nl <= (fsm_output(6)) OR (NOT (fsm_output(3))) OR (fsm_output(5)) OR (fsm_output(9))
      OR (NOT (fsm_output(7)));
  mux_483_cse <= MUX_s_1_2_2(or_1376_nl, or_1377_nl, fsm_output(4));
  nor_630_nl <= NOT((NOT (fsm_output(3))) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)));
  nor_631_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR (fsm_output(9)) OR
      (fsm_output(7)));
  mux_481_nl <= MUX_s_1_2_2(nor_630_nl, nor_631_nl, fsm_output(6));
  nand_232_cse <= NOT((fsm_output(4)) AND mux_481_nl);
  or_1379_cse <= (fsm_output(4)) OR (fsm_output(6)) OR (NOT((fsm_output(3)) AND (fsm_output(5))
      AND (fsm_output(9)) AND (fsm_output(7))));
  or_277_cse <= (fsm_output(3)) OR (fsm_output(5)) OR (fsm_output(9)) OR (fsm_output(7));
  or_297_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110"));
  or_296_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_488 <= MUX_s_1_2_2(or_297_nl, or_296_nl, fsm_output(9));
  not_tmp_170 <= NOT((fsm_output(4)) AND (fsm_output(3)) AND (fsm_output(7)));
  not_tmp_171 <= NOT((fsm_output(3)) AND (fsm_output(7)));
  or_324_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_322_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_504 <= MUX_s_1_2_2(or_324_nl, or_322_nl, fsm_output(3));
  nor_610_nl <= NOT((NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("001")) OR (fsm_output(5)) OR nand_245_cse);
  nor_611_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("001")) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  not_tmp_177 <= MUX_s_1_2_2(nor_610_nl, nor_611_nl, fsm_output(6));
  nor_608_nl <= NOT((fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)));
  nor_609_nl <= NOT((NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7)));
  not_tmp_178 <= MUX_s_1_2_2(nor_608_nl, nor_609_nl, fsm_output(4));
  or_355_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110"));
  or_354_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_523 <= MUX_s_1_2_2(or_355_nl, or_354_nl, fsm_output(9));
  or_382_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_380_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_539 <= MUX_s_1_2_2(or_382_nl, or_380_nl, fsm_output(3));
  nor_580_nl <= NOT((NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("010")) OR (fsm_output(5)) OR nand_245_cse);
  nor_581_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("010")) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  not_tmp_189 <= MUX_s_1_2_2(nor_580_nl, nor_581_nl, fsm_output(6));
  or_389_nl <= (fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7));
  or_388_nl <= (NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7));
  mux_tmp_542 <= MUX_s_1_2_2(or_389_nl, or_388_nl, fsm_output(4));
  nor_578_nl <= NOT((VEC_LOOP_j_sva_11_0(2)) OR (fsm_output(6)) OR (NOT (fsm_output(3)))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  nor_579_nl <= NOT((fsm_output(6)) OR (fsm_output(3)) OR (COMP_LOOP_acc_13_psp_sva(0))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7)));
  not_tmp_190 <= MUX_s_1_2_2(nor_578_nl, nor_579_nl, fsm_output(4));
  nor_112_cse <= NOT((fsm_output(2)) OR CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("10")));
  nor_114_cse <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10")));
  or_412_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110"));
  or_411_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_558 <= MUX_s_1_2_2(or_412_nl, or_411_nl, fsm_output(9));
  or_438_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_436_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_574 <= MUX_s_1_2_2(or_438_nl, or_436_nl, fsm_output(3));
  nor_550_nl <= NOT((NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("011")) OR (fsm_output(5)) OR nand_245_cse);
  nor_551_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("011")) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  not_tmp_201 <= MUX_s_1_2_2(nor_550_nl, nor_551_nl, fsm_output(6));
  nor_548_nl <= NOT((fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)));
  nor_549_nl <= NOT((NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7)));
  not_tmp_202 <= MUX_s_1_2_2(nor_548_nl, nor_549_nl, fsm_output(4));
  nor_122_cse <= NOT((fsm_output(2)) OR CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("11")));
  or_465_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110"));
  or_464_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_593 <= MUX_s_1_2_2(or_465_nl, or_464_nl, fsm_output(9));
  or_490_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_488_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_609 <= MUX_s_1_2_2(or_490_nl, or_488_nl, fsm_output(3));
  nor_520_nl <= NOT((NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("100")) OR (fsm_output(5)) OR nand_245_cse);
  nor_521_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("100")) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  not_tmp_214 <= MUX_s_1_2_2(nor_520_nl, nor_521_nl, fsm_output(6));
  or_504_nl <= (fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7));
  or_503_nl <= (NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7));
  mux_tmp_616 <= MUX_s_1_2_2(or_504_nl, or_503_nl, fsm_output(4));
  or_514_nl <= (NOT (VEC_LOOP_j_sva_11_0(2))) OR (fsm_output(6)) OR (NOT (fsm_output(3)))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_512_nl <= (fsm_output(6)) OR (fsm_output(3)) OR (NOT (COMP_LOOP_acc_13_psp_sva(0)))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_620 <= MUX_s_1_2_2(or_514_nl, or_512_nl, fsm_output(4));
  or_524_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110"));
  or_523_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_628 <= MUX_s_1_2_2(or_524_nl, or_523_nl, fsm_output(9));
  or_550_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_548_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_644 <= MUX_s_1_2_2(or_550_nl, or_548_nl, fsm_output(3));
  nor_490_nl <= NOT((NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("101")) OR (fsm_output(5)) OR nand_245_cse);
  nor_491_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("101")) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  not_tmp_225 <= MUX_s_1_2_2(nor_490_nl, nor_491_nl, fsm_output(6));
  nor_488_nl <= NOT((fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)));
  nor_489_nl <= NOT((NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7)));
  not_tmp_226 <= MUX_s_1_2_2(nor_488_nl, nor_489_nl, fsm_output(4));
  or_581_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110"));
  or_580_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_663 <= MUX_s_1_2_2(or_581_nl, or_580_nl, fsm_output(9));
  or_607_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  or_605_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7));
  mux_tmp_679 <= MUX_s_1_2_2(or_607_nl, or_605_nl, fsm_output(3));
  nor_460_nl <= NOT((NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("110")) OR (fsm_output(5)) OR nand_245_cse);
  nor_461_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(5))) OR CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("110")) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  not_tmp_237 <= MUX_s_1_2_2(nor_460_nl, nor_461_nl, fsm_output(6));
  or_621_nl <= (fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7));
  or_620_nl <= (NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7));
  mux_tmp_686 <= MUX_s_1_2_2(or_621_nl, or_620_nl, fsm_output(4));
  nor_458_nl <= NOT((NOT (VEC_LOOP_j_sva_11_0(2))) OR (fsm_output(6)) OR (NOT (fsm_output(3)))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  nor_459_nl <= NOT((fsm_output(6)) OR (fsm_output(3)) OR (NOT (COMP_LOOP_acc_13_psp_sva(0)))
      OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9))) OR (fsm_output(7)));
  not_tmp_239 <= MUX_s_1_2_2(nor_458_nl, nor_459_nl, fsm_output(4));
  or_637_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110"));
  or_636_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_698 <= MUX_s_1_2_2(or_637_nl, or_636_nl, fsm_output(9));
  or_662_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111"))
      OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT (fsm_output(7)));
  nand_136_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"))
      AND (fsm_output(5)) AND (fsm_output(9)) AND (NOT (fsm_output(7))));
  mux_tmp_714 <= MUX_s_1_2_2(or_662_nl, nand_136_nl, fsm_output(3));
  nor_430_nl <= NOT((NOT((fsm_output(3)) AND CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2
      DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND (NOT (fsm_output(5))))) OR nand_245_cse);
  and_447_nl <= (NOT (fsm_output(3))) AND (fsm_output(5)) AND CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2
      DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND (NOT (fsm_output(9))) AND (fsm_output(7));
  not_tmp_249 <= MUX_s_1_2_2(nor_430_nl, and_447_nl, fsm_output(6));
  nor_428_nl <= NOT((fsm_output(6)) OR (fsm_output(3)) OR CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR (fsm_output(5)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)));
  nor_429_nl <= NOT((NOT (fsm_output(6))) OR (NOT (fsm_output(3))) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR (fsm_output(5)) OR (fsm_output(9)) OR
      (fsm_output(7)));
  not_tmp_250 <= MUX_s_1_2_2(nor_428_nl, nor_429_nl, fsm_output(4));
  nand_131_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_4_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"))
      AND CONV_SL_1_1(fsm_output(7 DOWNTO 3)=STD_LOGIC_VECTOR'("01110")));
  or_688_nl <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00011"));
  mux_tmp_733 <= MUX_s_1_2_2(nand_131_nl, or_688_nl, fsm_output(9));
  and_dcpl_150 <= and_dcpl_82 AND and_dcpl_72;
  or_tmp_672 <= nor_813_cse OR (fsm_output(7));
  or_tmp_677 <= (fsm_output(8)) OR (fsm_output(0)) OR (fsm_output(7));
  or_tmp_679 <= (NOT((NOT (fsm_output(8))) OR (fsm_output(0)))) OR (fsm_output(7));
  nor_tmp_166 <= (fsm_output(0)) AND (fsm_output(7));
  or_tmp_681 <= (fsm_output(8)) OR (NOT nor_tmp_166);
  mux_tmp_760 <= MUX_s_1_2_2(or_90_cse, or_tmp_681, fsm_output(6));
  or_tmp_682 <= (NOT (fsm_output(8))) OR (fsm_output(0)) OR (fsm_output(7));
  mux_tmp_773 <= MUX_s_1_2_2(or_90_cse, mux_995_cse, fsm_output(6));
  mux_tmp_777 <= MUX_s_1_2_2((NOT mux_995_cse), or_90_cse, fsm_output(6));
  nor_tmp_168 <= ((NOT (fsm_output(8))) OR (fsm_output(0))) AND (fsm_output(7));
  not_tmp_276 <= MUX_s_1_2_2((fsm_output(8)), (NOT (fsm_output(8))), fsm_output(9));
  mux_tmp_814 <= MUX_s_1_2_2((fsm_output(8)), or_831_cse, fsm_output(7));
  mux_822_nl <= MUX_s_1_2_2(not_tmp_276, (fsm_output(8)), fsm_output(7));
  mux_tmp_823 <= MUX_s_1_2_2(mux_822_nl, or_831_cse, fsm_output(6));
  mux_tmp_825 <= MUX_s_1_2_2(mux_tmp_390, mux_tmp_814, fsm_output(6));
  or_750_cse <= (fsm_output(0)) OR (fsm_output(9)) OR (NOT (fsm_output(8)));
  mux_tmp_833 <= MUX_s_1_2_2(not_tmp_121, or_750_cse, fsm_output(7));
  or_tmp_737 <= (fsm_output(9)) OR (NOT (fsm_output(6)));
  mux_tmp_860 <= MUX_s_1_2_2((NOT or_tmp_737), and_434_cse, fsm_output(4));
  or_tmp_738 <= (fsm_output(4)) OR (NOT and_434_cse);
  and_310_nl <= (fsm_output(0)) AND (fsm_output(4));
  mux_tmp_865 <= MUX_s_1_2_2((NOT or_tmp_737), (fsm_output(6)), and_310_nl);
  or_1312_cse <= (fsm_output(4)) OR (NOT (fsm_output(1))) OR (fsm_output(6)) OR (NOT
      (fsm_output(9))) OR (NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(7)));
  or_798_cse <= (fsm_output(1)) OR (NOT (fsm_output(6))) OR (fsm_output(9)) OR (fsm_output(2))
      OR (NOT (fsm_output(8))) OR (fsm_output(7));
  nor_371_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(8)) OR (fsm_output(7)));
  nor_372_nl <= NOT((fsm_output(2)) OR (fsm_output(8)) OR (NOT (fsm_output(7))));
  mux_884_nl <= MUX_s_1_2_2(nor_371_nl, nor_372_nl, fsm_output(9));
  and_301_nl <= (fsm_output(6)) AND mux_884_nl;
  nor_373_nl <= NOT((fsm_output(6)) OR (fsm_output(9)) OR (fsm_output(2)) OR (NOT(CONV_SL_1_1(fsm_output(8
      DOWNTO 7)=STD_LOGIC_VECTOR'("11")))));
  mux_885_nl <= MUX_s_1_2_2(and_301_nl, nor_373_nl, fsm_output(1));
  nand_194_nl <= NOT((fsm_output(4)) AND mux_885_nl);
  mux_886_nl <= MUX_s_1_2_2(or_1312_cse, nand_194_nl, fsm_output(5));
  or_797_nl <= (fsm_output(6)) OR (NOT (fsm_output(9))) OR (NOT (fsm_output(2)))
      OR (fsm_output(8)) OR (fsm_output(7));
  nor_375_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(7))));
  nor_376_nl <= NOT((fsm_output(2)) OR (NOT (fsm_output(8))) OR (fsm_output(7)));
  mux_881_nl <= MUX_s_1_2_2(nor_375_nl, nor_376_nl, fsm_output(9));
  nand_66_nl <= NOT((fsm_output(6)) AND mux_881_nl);
  mux_882_nl <= MUX_s_1_2_2(or_797_nl, nand_66_nl, fsm_output(1));
  mux_883_nl <= MUX_s_1_2_2(or_798_cse, mux_882_nl, fsm_output(4));
  or_1313_nl <= (fsm_output(5)) OR mux_883_nl;
  mux_887_nl <= MUX_s_1_2_2(mux_886_nl, or_1313_nl, fsm_output(3));
  and_dcpl_151 <= NOT(mux_887_nl OR (fsm_output(0)));
  nor_365_cse <= NOT((NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)) OR (NOT (fsm_output(1))) OR (NOT (fsm_output(6))) OR (fsm_output(8)));
  nor_366_nl <= NOT((fsm_output(7)) OR (NOT((fsm_output(1)) AND (fsm_output(6)) AND
      (fsm_output(8)))));
  nor_367_nl <= NOT((NOT (fsm_output(7))) OR (fsm_output(1)) OR (fsm_output(6)) OR
      (fsm_output(8)));
  mux_891_nl <= MUX_s_1_2_2(nor_366_nl, nor_367_nl, fsm_output(9));
  and_298_nl <= nor_265_cse AND mux_891_nl;
  mux_892_nl <= MUX_s_1_2_2(nor_365_cse, and_298_nl, fsm_output(5));
  or_811_nl <= (fsm_output(9)) OR (fsm_output(7)) OR (fsm_output(1)) OR (fsm_output(6))
      OR (NOT (fsm_output(8)));
  mux_889_nl <= MUX_s_1_2_2(or_811_nl, or_29_cse, fsm_output(4));
  and_299_nl <= (fsm_output(6)) AND (fsm_output(8));
  nor_369_nl <= NOT((fsm_output(6)) OR (fsm_output(8)));
  mux_888_nl <= MUX_s_1_2_2(and_299_nl, nor_369_nl, fsm_output(1));
  nand_69_nl <= NOT((NOT((NOT (fsm_output(4))) OR (fsm_output(9)) OR (NOT (fsm_output(7)))))
      AND mux_888_nl);
  mux_890_nl <= MUX_s_1_2_2(mux_889_nl, nand_69_nl, fsm_output(2));
  nor_368_nl <= NOT((fsm_output(5)) OR mux_890_nl);
  not_tmp_309 <= MUX_s_1_2_2(mux_892_nl, nor_368_nl, fsm_output(3));
  and_dcpl_152 <= not_tmp_309 AND (fsm_output(0));
  mux_894_nl <= MUX_s_1_2_2((fsm_output(3)), (NOT (fsm_output(3))), or_722_cse);
  nor_750_nl <= NOT((NOT(CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"))))
      OR (fsm_output(3)));
  mux_895_nl <= MUX_s_1_2_2(mux_894_nl, nor_750_nl, fsm_output(0));
  and_dcpl_156 <= mux_895_nl AND (NOT (fsm_output(4))) AND and_dcpl_33 AND (NOT (fsm_output(7)))
      AND not_tmp_82;
  and_dcpl_157 <= and_dcpl_49 AND and_dcpl_63;
  mux_tmp_898 <= MUX_s_1_2_2((NOT (fsm_output(7))), (fsm_output(7)), fsm_output(9));
  mux_tmp_899 <= MUX_s_1_2_2((NOT mux_tmp_898), (fsm_output(9)), fsm_output(8));
  mux_tmp_900 <= MUX_s_1_2_2((NOT or_tmp_71), mux_tmp_898, fsm_output(8));
  mux_903_cse <= MUX_s_1_2_2((NOT (fsm_output(7))), (fsm_output(7)), or_1483_cse);
  or_823_cse <= (NOT((NOT (fsm_output(0))) OR (fsm_output(9)))) OR (fsm_output(7));
  or_tmp_783 <= (fsm_output(9)) OR (fsm_output(7));
  mux_tmp_912 <= MUX_s_1_2_2((NOT or_tmp_72), or_tmp_783, fsm_output(8));
  mux_919_cse <= MUX_s_1_2_2(mux_tmp_898, or_tmp_72, fsm_output(8));
  and_296_nl <= (fsm_output(8)) AND (fsm_output(0));
  mux_923_cse <= MUX_s_1_2_2(mux_tmp_898, or_tmp_72, and_296_nl);
  mux_928_cse <= MUX_s_1_2_2(mux_tmp_899, mux_tmp_912, fsm_output(6));
  mux_929_cse <= MUX_s_1_2_2((NOT and_312_cse), (fsm_output(9)), fsm_output(8));
  mux_936_cse <= MUX_s_1_2_2(or_tmp_783, (fsm_output(9)), fsm_output(0));
  mux_937_cse <= MUX_s_1_2_2((NOT mux_936_cse), or_tmp_72, fsm_output(8));
  nand_191_nl <= NOT((fsm_output(1)) AND (fsm_output(5)) AND (NOT (fsm_output(3)))
      AND (fsm_output(4)));
  mux_tmp_1013 <= MUX_s_1_2_2(nand_191_nl, or_843_cse, fsm_output(0));
  or_dcpl_56 <= CONV_SL_1_1(fsm_output(8 DOWNTO 1)/=STD_LOGIC_VECTOR'("00000100"))
      OR or_1275_cse;
  mux_tmp_1037 <= MUX_s_1_2_2((NOT or_tmp_63), nor_tmp_12, fsm_output(5));
  nor_tmp_223 <= (fsm_output(7)) AND (fsm_output(4));
  or_953_nl <= (NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)) OR (fsm_output(4));
  or_952_nl <= (fsm_output(2)) OR (NOT (fsm_output(8))) OR (fsm_output(9)) OR (fsm_output(7))
      OR (NOT (fsm_output(4)));
  mux_1116_nl <= MUX_s_1_2_2(or_953_nl, or_952_nl, fsm_output(5));
  nor_667_nl <= NOT((fsm_output(6)) OR mux_1116_nl);
  nor_669_nl <= NOT((fsm_output(7)) OR (fsm_output(4)));
  mux_1115_nl <= MUX_s_1_2_2(nor_669_nl, nor_tmp_223, fsm_output(9));
  nor_668_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(5)) OR (fsm_output(2)) OR
      (fsm_output(8)) OR (NOT mux_1115_nl));
  mux_1117_nl <= MUX_s_1_2_2(nor_667_nl, nor_668_nl, fsm_output(3));
  or_946_nl <= (NOT (fsm_output(8))) OR (NOT (fsm_output(9))) OR (fsm_output(7))
      OR (fsm_output(4));
  or_945_nl <= (fsm_output(8)) OR (fsm_output(9)) OR (NOT (fsm_output(7))) OR (fsm_output(4));
  mux_1113_nl <= MUX_s_1_2_2(or_946_nl, or_945_nl, fsm_output(2));
  nor_670_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR mux_1113_nl);
  nor_671_nl <= NOT((fsm_output(5)) OR (fsm_output(2)) OR (NOT (fsm_output(8))) OR
      (fsm_output(9)) OR (NOT nor_tmp_223));
  nor_672_nl <= NOT((NOT (fsm_output(5))) OR (NOT (fsm_output(2))) OR (fsm_output(8))
      OR (NOT (fsm_output(9))) OR (fsm_output(7)) OR (fsm_output(4)));
  mux_1112_nl <= MUX_s_1_2_2(nor_671_nl, nor_672_nl, fsm_output(6));
  mux_1114_nl <= MUX_s_1_2_2(nor_670_nl, mux_1112_nl, fsm_output(3));
  mux_1118_nl <= MUX_s_1_2_2(mux_1117_nl, mux_1114_nl, fsm_output(1));
  and_dcpl_174 <= mux_1118_nl AND (fsm_output(0));
  and_dcpl_176 <= and_dcpl_68 AND (fsm_output(2)) AND and_dcpl_67;
  and_dcpl_177 <= and_dcpl_176 AND and_dcpl_157;
  not_tmp_375 <= NOT((fsm_output(2)) AND (fsm_output(4)));
  or_dcpl_62 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("100"));
  not_tmp_384 <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 6)/=STD_LOGIC_VECTOR'("000"))
      OR and_tmp_2);
  or_1017_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000")) OR
      and_dcpl_75;
  or_1015_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000")) OR
      and_398_cse;
  mux_1150_nl <= MUX_s_1_2_2(or_1017_nl, or_1015_nl, fsm_output(1));
  and_198_nl <= (fsm_output(8)) AND mux_1150_nl;
  mux_1151_itm <= MUX_s_1_2_2(not_tmp_384, and_198_nl, fsm_output(9));
  or_tmp_966 <= (fsm_output(5)) OR and_dcpl_75;
  not_tmp_390 <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"))
      OR and_tmp_2);
  or_tmp_970 <= (fsm_output(6)) OR and_tmp_2;
  or_tmp_992 <= (fsm_output(5)) OR (fsm_output(2)) OR (NOT and_398_cse);
  mux_1172_nl <= MUX_s_1_2_2((NOT or_tmp_992), or_tmp_60, fsm_output(6));
  or_tmp_993 <= (fsm_output(7)) OR mux_1172_nl;
  mux_1174_nl <= MUX_s_1_2_2(and_dcpl_53, or_tmp_63, fsm_output(5));
  mux_tmp_1175 <= MUX_s_1_2_2(or_tmp_60, mux_1174_nl, fsm_output(6));
  mux_1177_nl <= MUX_s_1_2_2(and_292_cse, or_tmp_992, fsm_output(6));
  mux_tmp_1179 <= MUX_s_1_2_2((NOT mux_82_cse), mux_1177_nl, fsm_output(7));
  mux_tmp_1182 <= MUX_s_1_2_2((NOT or_tmp_58), or_tmp_966, fsm_output(6));
  mux_tmp_1184 <= MUX_s_1_2_2((NOT or_tmp_966), or_tmp_966, fsm_output(6));
  mux_1185_nl <= MUX_s_1_2_2(or_157_cse, or_dcpl_62, fsm_output(5));
  or_1062_nl <= CONV_SL_1_1(fsm_output(5 DOWNTO 2)/=STD_LOGIC_VECTOR'("1100"));
  mux_1186_nl <= MUX_s_1_2_2(mux_1185_nl, or_1062_nl, fsm_output(6));
  mux_tmp_1187 <= MUX_s_1_2_2(mux_1186_nl, mux_tmp_1184, fsm_output(7));
  mux_tmp_1189 <= MUX_s_1_2_2((NOT or_tmp_966), or_tmp_60, fsm_output(6));
  mux_tmp_1190 <= MUX_s_1_2_2((NOT and_tmp_2), or_tmp_966, fsm_output(6));
  mux_tmp_1191 <= MUX_s_1_2_2(mux_tmp_1190, mux_tmp_1189, fsm_output(7));
  mux_tmp_1192 <= MUX_s_1_2_2((NOT (fsm_output(5))), or_dcpl_39, fsm_output(6));
  mux_tmp_1199 <= MUX_s_1_2_2(or_dcpl_39, mux_tmp_81, fsm_output(6));
  mux_tmp_1203 <= MUX_s_1_2_2((NOT or_tmp_966), (fsm_output(5)), fsm_output(6));
  not_tmp_414 <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 3)=STD_LOGIC_VECTOR'("111")));
  mux_1207_nl <= MUX_s_1_2_2(not_tmp_414, (fsm_output(5)), fsm_output(6));
  mux_tmp_1208 <= MUX_s_1_2_2(mux_1207_nl, mux_tmp_1192, fsm_output(7));
  mux_1206_nl <= MUX_s_1_2_2(mux_tmp_1190, mux_tmp_1192, fsm_output(7));
  mux_1209_itm <= MUX_s_1_2_2(mux_tmp_1208, mux_1206_nl, fsm_output(1));
  or_tmp_1034 <= (NOT (fsm_output(9))) OR (fsm_output(4)) OR (fsm_output(3)) OR (fsm_output(7))
      OR (fsm_output(5));
  and_dcpl_191 <= and_dcpl_176 AND and_dcpl_50;
  or_tmp_1050 <= (fsm_output(7)) OR mux_tmp_1189;
  mux_1269_nl <= MUX_s_1_2_2(mux_tmp_1175, mux_tmp_77, fsm_output(7));
  mux_1271_nl <= MUX_s_1_2_2(mux_tmp_83, mux_1269_nl, fsm_output(1));
  or_73_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00")) OR (NOT
      or_tmp_58);
  mux_1267_nl <= MUX_s_1_2_2(or_tmp_1050, or_73_nl, fsm_output(1));
  mux_tmp_1272 <= MUX_s_1_2_2(mux_1271_nl, mux_1267_nl, fsm_output(8));
  mux_90_nl <= MUX_s_1_2_2((NOT mux_tmp_81), and_tmp_2, fsm_output(6));
  mux_tmp_1276 <= MUX_s_1_2_2(mux_90_nl, mux_tmp_1184, fsm_output(7));
  mux_87_nl <= MUX_s_1_2_2((NOT mux_tmp_81), and_292_cse, fsm_output(6));
  mux_1274_nl <= MUX_s_1_2_2(mux_87_nl, mux_tmp_1182, fsm_output(7));
  mux_tmp_1277 <= MUX_s_1_2_2(mux_tmp_1276, mux_1274_nl, fsm_output(1));
  mux_1284_nl <= MUX_s_1_2_2((NOT mux_tmp_1037), and_tmp_2, fsm_output(6));
  mux_1285_nl <= MUX_s_1_2_2(mux_1284_nl, mux_tmp_1203, fsm_output(7));
  mux_1286_nl <= MUX_s_1_2_2(mux_1285_nl, mux_tmp_1276, fsm_output(1));
  mux_1287_nl <= MUX_s_1_2_2(mux_1209_itm, (NOT mux_1286_nl), fsm_output(8));
  mux_1281_nl <= MUX_s_1_2_2(mux_tmp_1199, mux_tmp_1190, fsm_output(7));
  mux_1282_nl <= MUX_s_1_2_2(mux_1281_nl, mux_tmp_83, fsm_output(1));
  mux_1283_nl <= MUX_s_1_2_2(mux_1282_nl, or_tmp_1050, fsm_output(8));
  mux_tmp_1288 <= MUX_s_1_2_2(mux_1287_nl, mux_1283_nl, fsm_output(9));
  mux_1278_nl <= MUX_s_1_2_2(mux_tmp_1208, mux_tmp_1191, fsm_output(1));
  mux_1279_nl <= MUX_s_1_2_2(mux_1278_nl, (NOT mux_tmp_1277), fsm_output(8));
  mux_1280_nl <= MUX_s_1_2_2(mux_1279_nl, mux_tmp_1272, fsm_output(9));
  mux_1289_itm <= MUX_s_1_2_2(mux_tmp_1288, mux_1280_nl, fsm_output(0));
  and_dcpl_192 <= not_tmp_309 AND (NOT (fsm_output(0)));
  nor_661_nl <= NOT((fsm_output(6)) OR (fsm_output(5)) OR (NOT (fsm_output(9))) OR
      (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(8)));
  mux_1299_nl <= MUX_s_1_2_2((NOT (fsm_output(8))), (fsm_output(8)), fsm_output(2));
  nor_662_nl <= NOT((fsm_output(6)) OR (NOT (fsm_output(5))) OR (fsm_output(9)) OR
      (fsm_output(7)) OR mux_1299_nl);
  mux_1300_nl <= MUX_s_1_2_2(nor_661_nl, nor_662_nl, fsm_output(4));
  nor_663_nl <= NOT((NOT (fsm_output(4))) OR (NOT (fsm_output(6))) OR (fsm_output(5))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(8)));
  mux_1301_nl <= MUX_s_1_2_2(mux_1300_nl, nor_663_nl, fsm_output(3));
  or_1132_nl <= (NOT (fsm_output(7))) OR (NOT (fsm_output(2))) OR (fsm_output(8));
  mux_1297_nl <= MUX_s_1_2_2(or_1132_nl, or_1156_cse, fsm_output(9));
  nor_664_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("100"))
      OR mux_1297_nl);
  nor_665_nl <= NOT((NOT (fsm_output(6))) OR (NOT (fsm_output(5))) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)) OR (NOT (fsm_output(2))) OR (fsm_output(8)));
  nor_666_nl <= NOT((fsm_output(6)) OR (fsm_output(5)) OR (fsm_output(9)) OR (NOT
      (fsm_output(7))) OR (fsm_output(2)) OR (NOT (fsm_output(8))));
  mux_1296_nl <= MUX_s_1_2_2(nor_665_nl, nor_666_nl, fsm_output(4));
  mux_1298_nl <= MUX_s_1_2_2(nor_664_nl, mux_1296_nl, fsm_output(3));
  mux_1302_nl <= MUX_s_1_2_2(mux_1301_nl, mux_1298_nl, fsm_output(1));
  and_dcpl_194 <= mux_1302_nl AND (fsm_output(0));
  not_tmp_458 <= NOT((fsm_output(1)) AND (fsm_output(4)));
  mux_tmp_1329 <= MUX_s_1_2_2((NOT (fsm_output(6))), (fsm_output(6)), fsm_output(7));
  mux_tmp_1331 <= MUX_s_1_2_2(or_tmp_13, or_tmp_5, fsm_output(9));
  mux_1330_nl <= MUX_s_1_2_2((NOT mux_tmp_1329), or_857_cse, fsm_output(9));
  mux_tmp_1332 <= MUX_s_1_2_2(mux_tmp_1331, mux_1330_nl, fsm_output(8));
  or_tmp_1128 <= (NOT (fsm_output(7))) OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_1340_nl <= MUX_s_1_2_2(and_293_cse, mux_tmp_1329, fsm_output(9));
  mux_tmp_1341 <= MUX_s_1_2_2((NOT mux_1340_nl), mux_tmp_1331, fsm_output(8));
  nor_683_nl <= NOT((NOT (fsm_output(0))) OR (fsm_output(6)));
  mux_1344_nl <= MUX_s_1_2_2(nor_683_nl, (fsm_output(6)), fsm_output(7));
  mux_tmp_1345 <= MUX_s_1_2_2(mux_1344_nl, mux_tmp_1329, fsm_output(1));
  or_1199_nl <= (NOT((fsm_output(0)) OR (fsm_output(7)))) OR (fsm_output(6));
  mux_1347_nl <= MUX_s_1_2_2(or_1199_nl, or_tmp_13, fsm_output(1));
  mux_tmp_1348 <= MUX_s_1_2_2(mux_1347_nl, or_tmp_5, fsm_output(9));
  mux_1350_nl <= MUX_s_1_2_2(or_tmp_5, (NOT (fsm_output(6))), fsm_output(9));
  mux_tmp_1351 <= MUX_s_1_2_2(mux_1350_nl, or_119_cse, fsm_output(8));
  or_tmp_1137 <= (fsm_output(7)) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  mux_tmp_1353 <= MUX_s_1_2_2(or_tmp_5, or_tmp_1137, fsm_output(1));
  nor_282_nl <= NOT(nor_tmp_166 OR (fsm_output(6)));
  and_256_nl <= or_730_cse AND (fsm_output(6));
  mux_tmp_1355 <= MUX_s_1_2_2(nor_282_nl, and_256_nl, fsm_output(1));
  or_tmp_1142 <= (fsm_output(7)) OR nand_240_cse;
  nor_277_nl <= NOT((fsm_output(9)) OR (NOT((fsm_output(8)) AND (fsm_output(6)) AND
      (fsm_output(5)))));
  nor_278_nl <= NOT((fsm_output(9)) OR (fsm_output(8)) OR (fsm_output(6)) OR (NOT
      (fsm_output(5))));
  mux_1388_nl <= MUX_s_1_2_2(nor_277_nl, nor_278_nl, fsm_output(1));
  and_252_nl <= (fsm_output(4)) AND mux_1388_nl;
  or_1215_nl <= (NOT (fsm_output(9))) OR (fsm_output(8)) OR (NOT (fsm_output(6)))
      OR (fsm_output(5));
  or_1214_nl <= (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(6)) OR (fsm_output(5));
  mux_1387_nl <= MUX_s_1_2_2(or_1215_nl, or_1214_nl, fsm_output(1));
  nor_279_nl <= NOT((fsm_output(4)) OR mux_1387_nl);
  mux_1389_nl <= MUX_s_1_2_2(and_252_nl, nor_279_nl, fsm_output(2));
  and_251_nl <= (fsm_output(7)) AND mux_1389_nl;
  or_1212_nl <= (NOT (fsm_output(4))) OR (NOT (fsm_output(1))) OR (NOT (fsm_output(9)))
      OR (fsm_output(8)) OR (NOT (fsm_output(6))) OR (fsm_output(5));
  nand_182_nl <= NOT((fsm_output(1)) AND (fsm_output(9)) AND (fsm_output(8)) AND
      (NOT (fsm_output(6))) AND (fsm_output(5)));
  or_1209_nl <= (fsm_output(1)) OR (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(6))
      OR (fsm_output(5));
  mux_1385_nl <= MUX_s_1_2_2(nand_182_nl, or_1209_nl, fsm_output(4));
  mux_1386_nl <= MUX_s_1_2_2(or_1212_nl, mux_1385_nl, fsm_output(2));
  nor_280_nl <= NOT((fsm_output(7)) OR mux_1386_nl);
  not_tmp_496 <= MUX_s_1_2_2(and_251_nl, nor_280_nl, fsm_output(3));
  or_tmp_1157 <= NOT((fsm_output(9)) AND (fsm_output(4)) AND (fsm_output(6)) AND
      (NOT (fsm_output(8))));
  STAGE_LOOP_i_3_0_sva_mx0c1 <= and_dcpl_61 AND and_dcpl_58 AND (fsm_output(9)) AND
      (fsm_output(0));
  VEC_LOOP_j_sva_11_0_mx0c1 <= and_dcpl_61 AND and_dcpl_58 AND and_dcpl_26;
  mux_1024_nl <= MUX_s_1_2_2(nor_692_cse, mux_tmp_229, or_1470_cse);
  mux_1025_nl <= MUX_s_1_2_2(nor_692_cse, mux_1024_nl, fsm_output(2));
  mux_1023_nl <= MUX_s_1_2_2(mux_tmp_229, nor_tmp_21, or_722_cse);
  mux_1026_cse <= MUX_s_1_2_2(mux_1025_nl, mux_1023_nl, fsm_output(3));
  or_859_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("000"));
  modExp_result_sva_mx0c0 <= MUX_s_1_2_2(mux_1026_cse, nor_tmp_21, or_859_nl);
  modExp_base_sva_mx0c1 <= and_dcpl_70 AND and_dcpl_72;
  tmp_10_lpi_4_dfm_mx0c1 <= and_dcpl_103 AND and_dcpl_122 AND nor_401_cse;
  tmp_10_lpi_4_dfm_mx0c2 <= and_dcpl_82 AND and_dcpl_16 AND nor_401_cse;
  tmp_10_lpi_4_dfm_mx0c3 <= and_dcpl_115 AND and_dcpl_97;
  tmp_10_lpi_4_dfm_mx0c4 <= and_dcpl_76 AND and_dcpl_102;
  tmp_10_lpi_4_dfm_mx0c5 <= and_dcpl_133 AND and_dcpl_108;
  tmp_10_lpi_4_dfm_mx0c6 <= and_dcpl_70 AND and_dcpl_78 AND and_dcpl_26;
  tmp_10_lpi_4_dfm_mx0c7 <= and_dcpl_124 AND and_dcpl_33 AND and_dcpl_96 AND and_dcpl_26;
  STAGE_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(STAGE_LOOP_i_3_0_sva_2(3
      DOWNTO 1)) + SIGNED'( "011"), 3));
  STAGE_LOOP_acc_itm_2_1 <= STAGE_LOOP_acc_nl(2);
  and_244_m1c <= and_dcpl_76 AND and_dcpl_66;
  nor_274_nl <= NOT((NOT (fsm_output(9))) OR (fsm_output(4)) OR not_tmp_29);
  nor_275_nl <= NOT((NOT (fsm_output(9))) OR (fsm_output(4)) OR (fsm_output(6)) OR
      (fsm_output(8)));
  mux_1394_nl <= MUX_s_1_2_2(nor_274_nl, nor_275_nl, fsm_output(1));
  nand_89_nl <= NOT((fsm_output(2)) AND mux_1394_nl);
  or_1227_nl <= (fsm_output(9)) OR (NOT (fsm_output(4))) OR (fsm_output(6)) OR (NOT
      (fsm_output(8)));
  mux_1393_nl <= MUX_s_1_2_2(or_tmp_1157, or_1227_nl, fsm_output(1));
  or_1228_nl <= (fsm_output(2)) OR mux_1393_nl;
  mux_1395_nl <= MUX_s_1_2_2(nand_89_nl, or_1228_nl, fsm_output(5));
  nor_273_nl <= NOT((fsm_output(7)) OR mux_1395_nl);
  or_1224_nl <= (fsm_output(9)) OR (fsm_output(4)) OR (NOT (fsm_output(6))) OR (fsm_output(8));
  mux_1391_nl <= MUX_s_1_2_2(or_1224_nl, or_tmp_1157, fsm_output(1));
  or_1222_nl <= (fsm_output(1)) OR (fsm_output(9)) OR (NOT (fsm_output(4))) OR (fsm_output(6))
      OR (NOT (fsm_output(8)));
  mux_1392_nl <= MUX_s_1_2_2(mux_1391_nl, or_1222_nl, fsm_output(2));
  nor_276_nl <= NOT((NOT (fsm_output(7))) OR (fsm_output(5)) OR mux_1392_nl);
  mux_1396_nl <= MUX_s_1_2_2(nor_273_nl, nor_276_nl, fsm_output(3));
  and_250_m1c <= mux_1396_nl AND (fsm_output(0));
  and_98_nl <= and_dcpl_82 AND and_dcpl_79;
  nor_655_nl <= NOT((fsm_output(8)) OR (NOT (fsm_output(2))) OR (NOT (fsm_output(7)))
      OR (fsm_output(5)));
  nor_656_nl <= NOT((NOT (fsm_output(8))) OR (fsm_output(2)) OR (fsm_output(7)) OR
      (fsm_output(5)));
  mux_459_nl <= MUX_s_1_2_2(nor_655_nl, nor_656_nl, fsm_output(9));
  nand_235_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11"))
      AND mux_459_nl);
  or_1386_nl <= (fsm_output(3)) OR (NOT (fsm_output(9))) OR (fsm_output(8)) OR (NOT
      (fsm_output(2))) OR (fsm_output(7)) OR (fsm_output(5));
  or_1387_nl <= (fsm_output(3)) OR (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(2))
      OR (fsm_output(7)) OR (NOT (fsm_output(5)));
  mux_458_nl <= MUX_s_1_2_2(or_1386_nl, or_1387_nl, fsm_output(4));
  mux_460_nl <= MUX_s_1_2_2(nand_235_nl, mux_458_nl, fsm_output(6));
  or_234_nl <= (NOT (fsm_output(8))) OR (NOT (fsm_output(2))) OR (fsm_output(7))
      OR (fsm_output(5));
  or_233_nl <= (NOT (fsm_output(8))) OR (fsm_output(2)) OR (NOT (fsm_output(7)))
      OR (fsm_output(5));
  mux_455_nl <= MUX_s_1_2_2(or_234_nl, or_233_nl, fsm_output(9));
  or_232_nl <= (NOT (fsm_output(9))) OR (fsm_output(8)) OR (NOT((fsm_output(2)) AND
      (fsm_output(7)) AND (fsm_output(5))));
  mux_456_nl <= MUX_s_1_2_2(mux_455_nl, or_232_nl, fsm_output(3));
  or_1388_nl <= (fsm_output(4)) OR mux_456_nl;
  or_1389_nl <= (NOT (fsm_output(4))) OR (NOT (fsm_output(3))) OR (fsm_output(9))
      OR (NOT (fsm_output(8))) OR (fsm_output(2)) OR (NOT (fsm_output(7))) OR (fsm_output(5));
  mux_457_nl <= MUX_s_1_2_2(or_1388_nl, or_1389_nl, fsm_output(6));
  mux_461_nl <= MUX_s_1_2_2(mux_460_nl, mux_457_nl, fsm_output(1));
  nor_740_nl <= NOT(mux_461_nl OR (fsm_output(0)));
  nor_653_nl <= NOT((NOT (fsm_output(1))) OR (NOT (fsm_output(6))) OR (NOT (fsm_output(5)))
      OR (fsm_output(2)) OR (fsm_output(3)));
  nor_654_nl <= NOT((fsm_output(1)) OR (fsm_output(6)) OR (fsm_output(5)) OR (NOT(CONV_SL_1_1(fsm_output(3
      DOWNTO 2)=STD_LOGIC_VECTOR'("11")))));
  mux_462_nl <= MUX_s_1_2_2(nor_653_nl, nor_654_nl, fsm_output(0));
  and_103_nl <= mux_462_nl AND (fsm_output(4)) AND (fsm_output(7)) AND not_tmp_82;
  nor_651_nl <= NOT((fsm_output(1)) OR (NOT((fsm_output(6)) AND (fsm_output(3)) AND
      (fsm_output(4)))));
  nor_652_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(6)) OR (fsm_output(3)) OR
      (fsm_output(4)));
  mux_463_nl <= MUX_s_1_2_2(nor_651_nl, nor_652_nl, fsm_output(0));
  and_110_nl <= mux_463_nl AND (fsm_output(2)) AND (NOT (fsm_output(5))) AND (NOT
      (fsm_output(7))) AND and_dcpl_91;
  nor_649_nl <= NOT((NOT (fsm_output(1))) OR (NOT (fsm_output(7))) OR (fsm_output(5))
      OR (NOT (fsm_output(2))) OR (fsm_output(4)));
  nor_650_nl <= NOT((fsm_output(1)) OR (fsm_output(7)) OR (NOT (fsm_output(5))) OR
      (fsm_output(2)) OR (NOT (fsm_output(4))));
  mux_464_nl <= MUX_s_1_2_2(nor_649_nl, nor_650_nl, fsm_output(0));
  and_116_nl <= mux_464_nl AND (NOT (fsm_output(3))) AND (fsm_output(6)) AND and_dcpl_91;
  nor_647_nl <= NOT((NOT (fsm_output(9))) OR (fsm_output(8)) OR (fsm_output(1)) OR
      (fsm_output(7)) OR (fsm_output(6)) OR (NOT (fsm_output(5))) OR (fsm_output(3)));
  and_449_nl <= (NOT (fsm_output(9))) AND (fsm_output(8)) AND (fsm_output(1)) AND
      (fsm_output(7)) AND (fsm_output(6)) AND (NOT (fsm_output(5))) AND (fsm_output(3));
  mux_465_nl <= MUX_s_1_2_2(nor_647_nl, and_449_nl, fsm_output(0));
  and_121_nl <= mux_465_nl AND (fsm_output(4)) AND (NOT (fsm_output(2)));
  nor_645_nl <= NOT((NOT (fsm_output(1))) OR (NOT (fsm_output(7))) OR (fsm_output(6))
      OR (fsm_output(2)) OR (NOT and_398_cse));
  nor_646_nl <= NOT((fsm_output(1)) OR (fsm_output(7)) OR (NOT (fsm_output(6))) OR
      (NOT (fsm_output(2))) OR (fsm_output(3)) OR (fsm_output(4)));
  mux_466_nl <= MUX_s_1_2_2(nor_645_nl, nor_646_nl, fsm_output(0));
  and_127_nl <= mux_466_nl AND (NOT (fsm_output(5))) AND (NOT (fsm_output(8))) AND
      (fsm_output(9));
  nor_643_nl <= NOT((NOT (fsm_output(8))) OR (fsm_output(1)) OR (fsm_output(7)) OR
      (fsm_output(5)) OR (fsm_output(3)));
  nor_644_nl <= NOT((fsm_output(8)) OR (NOT((fsm_output(1)) AND (fsm_output(7)) AND
      (fsm_output(5)) AND (fsm_output(3)))));
  mux_467_nl <= MUX_s_1_2_2(nor_643_nl, nor_644_nl, fsm_output(0));
  and_135_nl <= mux_467_nl AND (NOT (fsm_output(4))) AND (fsm_output(2)) AND (NOT
      (fsm_output(6))) AND (fsm_output(9));
  and_382_nl <= (fsm_output(1)) AND (fsm_output(6)) AND (fsm_output(5)) AND (fsm_output(2))
      AND (NOT (fsm_output(4)));
  nor_642_nl <= NOT((fsm_output(1)) OR (fsm_output(6)) OR (fsm_output(5)) OR (fsm_output(2))
      OR (NOT (fsm_output(4))));
  mux_468_nl <= MUX_s_1_2_2(and_382_nl, nor_642_nl, fsm_output(0));
  and_145_nl <= mux_468_nl AND (fsm_output(3)) AND (NOT (fsm_output(7))) AND (fsm_output(8))
      AND (fsm_output(9));
  vec_rsc_0_0_i_adra_d_pff <= MUX1HOT_v_9_11_2(COMP_LOOP_acc_psp_sva_1, (z_out_6_12_1(11
      DOWNTO 3)), COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_10_cse_12_1_1_sva(11 DOWNTO
      3)), (COMP_LOOP_acc_1_cse_2_sva(11 DOWNTO 3)), (COMP_LOOP_acc_11_psp_sva(10
      DOWNTO 2)), (COMP_LOOP_acc_1_cse_4_sva(11 DOWNTO 3)), (COMP_LOOP_acc_13_psp_sva(9
      DOWNTO 1)), (COMP_LOOP_acc_1_cse_6_sva(11 DOWNTO 3)), (COMP_LOOP_acc_14_psp_sva(10
      DOWNTO 2)), (COMP_LOOP_acc_1_cse_sva(11 DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_71
      & COMP_LOOP_or_3_cse & and_98_nl & nor_740_nl & and_103_nl & and_110_nl & and_116_nl
      & and_121_nl & and_127_nl & and_135_nl & and_145_nl));
  vec_rsc_0_0_i_da_d_pff <= modulo_result_mux_1_cse;
  or_1375_nl <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR mux_tmp_473;
  mux_484_nl <= MUX_s_1_2_2(or_1375_nl, mux_483_cse, fsm_output(2));
  or_1378_nl <= (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_472;
  mux_482_nl <= MUX_s_1_2_2(nand_232_cse, or_1378_nl, fsm_output(2));
  mux_485_nl <= MUX_s_1_2_2(mux_484_nl, mux_482_nl, fsm_output(8));
  nand_233_nl <= NOT((fsm_output(4)) AND not_tmp_166);
  mux_479_nl <= MUX_s_1_2_2(nand_233_nl, or_1379_cse, fsm_output(2));
  mux_476_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_469, fsm_output(6));
  or_1382_nl <= (fsm_output(4)) OR mux_476_nl;
  mux_478_nl <= MUX_s_1_2_2(mux_477_cse, or_1382_nl, fsm_output(2));
  mux_480_nl <= MUX_s_1_2_2(mux_479_nl, mux_478_nl, fsm_output(8));
  mux_486_nl <= MUX_s_1_2_2(mux_485_nl, mux_480_nl, fsm_output(1));
  or_1383_nl <= (fsm_output(2)) OR CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR mux_tmp_473;
  or_1384_nl <= (NOT (fsm_output(2))) OR (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_472;
  mux_474_nl <= MUX_s_1_2_2(or_1383_nl, or_1384_nl, fsm_output(8));
  nand_234_nl <= NOT(nor_265_cse AND not_tmp_166);
  or_1385_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_469;
  mux_471_nl <= MUX_s_1_2_2(nand_234_nl, or_1385_nl, fsm_output(8));
  mux_475_nl <= MUX_s_1_2_2(mux_474_nl, mux_471_nl, fsm_output(1));
  or_260_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"));
  mux_487_nl <= MUX_s_1_2_2(mux_486_nl, mux_475_nl, or_260_nl);
  vec_rsc_0_0_i_wea_d_pff <= NOT(mux_487_nl OR (fsm_output(0)));
  nor_612_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000")) OR (fsm_output(4))
      OR not_tmp_171);
  nor_613_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110")));
  mux_499_nl <= MUX_s_1_2_2(nor_612_nl, nor_613_nl, fsm_output(9));
  nor_614_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(5)) OR not_tmp_170);
  mux_500_nl <= MUX_s_1_2_2(mux_499_nl, nor_614_nl, fsm_output(1));
  nor_615_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01011")));
  nor_616_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_498_nl <= MUX_s_1_2_2(nor_615_nl, nor_616_nl, fsm_output(9));
  and_377_nl <= (fsm_output(1)) AND mux_498_nl;
  mux_501_nl <= MUX_s_1_2_2(mux_500_nl, and_377_nl, fsm_output(2));
  nor_617_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_311_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170;
  or_309_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_496_nl <= MUX_s_1_2_2(or_311_nl, or_309_nl, fsm_output(9));
  nor_618_nl <= NOT((fsm_output(1)) OR mux_496_nl);
  mux_497_nl <= MUX_s_1_2_2(nor_617_nl, nor_618_nl, fsm_output(2));
  mux_502_nl <= MUX_s_1_2_2(mux_501_nl, mux_497_nl, fsm_output(8));
  nor_619_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (VEC_LOOP_j_sva_11_0(0)) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_620_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170);
  nor_621_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_492_nl <= MUX_s_1_2_2(nor_620_nl, nor_621_nl, fsm_output(9));
  nor_622_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (fsm_output(9))) OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_171);
  mux_493_nl <= MUX_s_1_2_2(mux_492_nl, nor_622_nl, fsm_output(1));
  and_378_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_493_nl;
  mux_494_nl <= MUX_s_1_2_2(nor_619_nl, and_378_nl, fsm_output(2));
  nor_623_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_488);
  mux_489_nl <= MUX_s_1_2_2(nor_623_nl, nor_624_cse, fsm_output(1));
  nor_625_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_488);
  mux_490_nl <= MUX_s_1_2_2(mux_489_nl, nor_625_nl, or_294_cse);
  nor_626_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_491_nl <= MUX_s_1_2_2(mux_490_nl, nor_626_nl, fsm_output(2));
  mux_495_nl <= MUX_s_1_2_2(mux_494_nl, mux_491_nl, fsm_output(8));
  vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_502_nl, mux_495_nl,
      fsm_output(0));
  or_1366_nl <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR mux_tmp_473;
  mux_519_nl <= MUX_s_1_2_2(or_1366_nl, mux_483_cse, fsm_output(2));
  nand_228_nl <= NOT((VEC_LOOP_j_sva_11_0(0)) AND not_tmp_178);
  mux_517_nl <= MUX_s_1_2_2(nand_232_cse, nand_228_nl, fsm_output(2));
  mux_520_nl <= MUX_s_1_2_2(mux_519_nl, mux_517_nl, fsm_output(8));
  nand_229_nl <= NOT((fsm_output(4)) AND not_tmp_177);
  mux_514_nl <= MUX_s_1_2_2(nand_229_nl, or_1379_cse, fsm_output(2));
  mux_511_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_504, fsm_output(6));
  or_1372_nl <= (fsm_output(4)) OR mux_511_nl;
  mux_513_nl <= MUX_s_1_2_2(mux_477_cse, or_1372_nl, fsm_output(2));
  mux_515_nl <= MUX_s_1_2_2(mux_514_nl, mux_513_nl, fsm_output(8));
  mux_521_nl <= MUX_s_1_2_2(mux_520_nl, mux_515_nl, fsm_output(1));
  or_1373_nl <= (fsm_output(2)) OR CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR mux_tmp_473;
  nand_230_nl <= NOT((fsm_output(2)) AND (VEC_LOOP_j_sva_11_0(0)) AND not_tmp_178);
  mux_509_nl <= MUX_s_1_2_2(or_1373_nl, nand_230_nl, fsm_output(8));
  nand_231_nl <= NOT(nor_265_cse AND not_tmp_177);
  or_1374_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_504;
  mux_506_nl <= MUX_s_1_2_2(nand_231_nl, or_1374_nl, fsm_output(8));
  mux_510_nl <= MUX_s_1_2_2(mux_509_nl, mux_506_nl, fsm_output(1));
  or_321_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"));
  mux_522_nl <= MUX_s_1_2_2(mux_521_nl, mux_510_nl, or_321_nl);
  vec_rsc_0_1_i_wea_d_pff <= NOT(mux_522_nl OR (fsm_output(0)));
  nor_582_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")) OR (fsm_output(4))
      OR not_tmp_171);
  nor_583_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110")));
  mux_534_nl <= MUX_s_1_2_2(nor_582_nl, nor_583_nl, fsm_output(9));
  nor_584_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(5)) OR not_tmp_170);
  mux_535_nl <= MUX_s_1_2_2(mux_534_nl, nor_584_nl, fsm_output(1));
  nor_585_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01011")));
  nor_586_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_533_nl <= MUX_s_1_2_2(nor_585_nl, nor_586_nl, fsm_output(9));
  and_370_nl <= (fsm_output(1)) AND mux_533_nl;
  mux_536_nl <= MUX_s_1_2_2(mux_535_nl, and_370_nl, fsm_output(2));
  nor_587_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_369_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170;
  or_367_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_531_nl <= MUX_s_1_2_2(or_369_nl, or_367_nl, fsm_output(9));
  nor_588_nl <= NOT((fsm_output(1)) OR mux_531_nl);
  mux_532_nl <= MUX_s_1_2_2(nor_587_nl, nor_588_nl, fsm_output(2));
  mux_537_nl <= MUX_s_1_2_2(mux_536_nl, mux_532_nl, fsm_output(8));
  nor_589_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (NOT (VEC_LOOP_j_sva_11_0(0)))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_590_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170);
  nor_591_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_527_nl <= MUX_s_1_2_2(nor_590_nl, nor_591_nl, fsm_output(9));
  nor_592_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (fsm_output(9))) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_171);
  mux_528_nl <= MUX_s_1_2_2(mux_527_nl, nor_592_nl, fsm_output(1));
  and_371_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_528_nl;
  mux_529_nl <= MUX_s_1_2_2(nor_589_nl, and_371_nl, fsm_output(2));
  nor_593_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_523);
  mux_524_nl <= MUX_s_1_2_2(nor_593_nl, nor_594_cse, fsm_output(1));
  nor_595_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_523);
  mux_525_nl <= MUX_s_1_2_2(mux_524_nl, nor_595_nl, or_294_cse);
  nor_596_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_526_nl <= MUX_s_1_2_2(mux_525_nl, nor_596_nl, fsm_output(2));
  mux_530_nl <= MUX_s_1_2_2(mux_529_nl, mux_526_nl, fsm_output(8));
  vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_537_nl, mux_530_nl,
      fsm_output(0));
  nand_222_nl <= NOT(nor_114_cse AND not_tmp_190);
  mux_554_nl <= MUX_s_1_2_2(nand_222_nl, mux_483_cse, fsm_output(2));
  or_1359_nl <= (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_542;
  mux_552_nl <= MUX_s_1_2_2(nand_232_cse, or_1359_nl, fsm_output(2));
  mux_555_nl <= MUX_s_1_2_2(mux_554_nl, mux_552_nl, fsm_output(8));
  nand_224_nl <= NOT((fsm_output(4)) AND not_tmp_189);
  mux_549_nl <= MUX_s_1_2_2(nand_224_nl, or_1379_cse, fsm_output(2));
  mux_546_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_539, fsm_output(6));
  or_1363_nl <= (fsm_output(4)) OR mux_546_nl;
  mux_548_nl <= MUX_s_1_2_2(mux_477_cse, or_1363_nl, fsm_output(2));
  mux_550_nl <= MUX_s_1_2_2(mux_549_nl, mux_548_nl, fsm_output(8));
  mux_556_nl <= MUX_s_1_2_2(mux_555_nl, mux_550_nl, fsm_output(1));
  nand_225_nl <= NOT(nor_112_cse AND not_tmp_190);
  or_1364_nl <= (NOT (fsm_output(2))) OR (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_542;
  mux_544_nl <= MUX_s_1_2_2(nand_225_nl, or_1364_nl, fsm_output(8));
  nand_226_nl <= NOT(nor_265_cse AND not_tmp_189);
  or_1365_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_539;
  mux_541_nl <= MUX_s_1_2_2(nand_226_nl, or_1365_nl, fsm_output(8));
  mux_545_nl <= MUX_s_1_2_2(mux_544_nl, mux_541_nl, fsm_output(1));
  or_379_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"));
  mux_557_nl <= MUX_s_1_2_2(mux_556_nl, mux_545_nl, or_379_nl);
  vec_rsc_0_2_i_wea_d_pff <= NOT(mux_557_nl OR (fsm_output(0)));
  nor_552_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010")) OR (fsm_output(4))
      OR not_tmp_171);
  nor_553_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110")));
  mux_569_nl <= MUX_s_1_2_2(nor_552_nl, nor_553_nl, fsm_output(9));
  nor_554_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(5)) OR not_tmp_170);
  mux_570_nl <= MUX_s_1_2_2(mux_569_nl, nor_554_nl, fsm_output(1));
  nor_555_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01011")));
  nor_556_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_568_nl <= MUX_s_1_2_2(nor_555_nl, nor_556_nl, fsm_output(9));
  and_363_nl <= (fsm_output(1)) AND mux_568_nl;
  mux_571_nl <= MUX_s_1_2_2(mux_570_nl, and_363_nl, fsm_output(2));
  nor_557_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_425_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170;
  or_423_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_566_nl <= MUX_s_1_2_2(or_425_nl, or_423_nl, fsm_output(9));
  nor_558_nl <= NOT((fsm_output(1)) OR mux_566_nl);
  mux_567_nl <= MUX_s_1_2_2(nor_557_nl, nor_558_nl, fsm_output(2));
  mux_572_nl <= MUX_s_1_2_2(mux_571_nl, mux_567_nl, fsm_output(8));
  nor_559_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (VEC_LOOP_j_sva_11_0(0)) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_560_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170);
  nor_561_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_562_nl <= MUX_s_1_2_2(nor_560_nl, nor_561_nl, fsm_output(9));
  nor_562_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (fsm_output(9))) OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_171);
  mux_563_nl <= MUX_s_1_2_2(mux_562_nl, nor_562_nl, fsm_output(1));
  and_364_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_563_nl;
  mux_564_nl <= MUX_s_1_2_2(nor_559_nl, and_364_nl, fsm_output(2));
  nor_563_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_558);
  nor_564_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_558);
  mux_559_nl <= MUX_s_1_2_2(nor_564_nl, nor_624_cse, fsm_output(1));
  mux_560_nl <= MUX_s_1_2_2(nor_563_nl, mux_559_nl, nor_115_cse);
  nor_566_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_561_nl <= MUX_s_1_2_2(mux_560_nl, nor_566_nl, fsm_output(2));
  mux_565_nl <= MUX_s_1_2_2(mux_564_nl, mux_561_nl, fsm_output(8));
  vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_572_nl, mux_565_nl,
      fsm_output(0));
  nand_215_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND not_tmp_190);
  mux_589_nl <= MUX_s_1_2_2(nand_215_nl, mux_483_cse, fsm_output(2));
  nand_217_nl <= NOT((VEC_LOOP_j_sva_11_0(0)) AND not_tmp_202);
  mux_587_nl <= MUX_s_1_2_2(nand_232_cse, nand_217_nl, fsm_output(2));
  mux_590_nl <= MUX_s_1_2_2(mux_589_nl, mux_587_nl, fsm_output(8));
  nand_218_nl <= NOT((fsm_output(4)) AND not_tmp_201);
  mux_584_nl <= MUX_s_1_2_2(nand_218_nl, or_1379_cse, fsm_output(2));
  mux_581_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_574, fsm_output(6));
  or_1355_nl <= (fsm_output(4)) OR mux_581_nl;
  mux_583_nl <= MUX_s_1_2_2(mux_477_cse, or_1355_nl, fsm_output(2));
  mux_585_nl <= MUX_s_1_2_2(mux_584_nl, mux_583_nl, fsm_output(8));
  mux_591_nl <= MUX_s_1_2_2(mux_590_nl, mux_585_nl, fsm_output(1));
  nand_219_nl <= NOT(nor_122_cse AND not_tmp_190);
  nand_220_nl <= NOT((fsm_output(2)) AND (VEC_LOOP_j_sva_11_0(0)) AND not_tmp_202);
  mux_579_nl <= MUX_s_1_2_2(nand_219_nl, nand_220_nl, fsm_output(8));
  nand_221_nl <= NOT(nor_265_cse AND not_tmp_201);
  or_1356_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_574;
  mux_576_nl <= MUX_s_1_2_2(nand_221_nl, or_1356_nl, fsm_output(8));
  mux_580_nl <= MUX_s_1_2_2(mux_579_nl, mux_576_nl, fsm_output(1));
  or_435_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"));
  mux_592_nl <= MUX_s_1_2_2(mux_591_nl, mux_580_nl, or_435_nl);
  vec_rsc_0_3_i_wea_d_pff <= NOT(mux_592_nl OR (fsm_output(0)));
  nor_522_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011")) OR (fsm_output(4))
      OR not_tmp_171);
  nor_523_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110")));
  mux_604_nl <= MUX_s_1_2_2(nor_522_nl, nor_523_nl, fsm_output(9));
  nor_524_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(5)) OR not_tmp_170);
  mux_605_nl <= MUX_s_1_2_2(mux_604_nl, nor_524_nl, fsm_output(1));
  nor_525_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01011")));
  nor_526_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_603_nl <= MUX_s_1_2_2(nor_525_nl, nor_526_nl, fsm_output(9));
  and_354_nl <= (fsm_output(1)) AND mux_603_nl;
  mux_606_nl <= MUX_s_1_2_2(mux_605_nl, and_354_nl, fsm_output(2));
  nor_527_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_478_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170;
  or_476_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_601_nl <= MUX_s_1_2_2(or_478_nl, or_476_nl, fsm_output(9));
  nor_528_nl <= NOT((fsm_output(1)) OR mux_601_nl);
  mux_602_nl <= MUX_s_1_2_2(nor_527_nl, nor_528_nl, fsm_output(2));
  mux_607_nl <= MUX_s_1_2_2(mux_606_nl, mux_602_nl, fsm_output(8));
  nor_529_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (NOT (VEC_LOOP_j_sva_11_0(0)))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_530_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170);
  nor_531_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_597_nl <= MUX_s_1_2_2(nor_530_nl, nor_531_nl, fsm_output(9));
  nor_532_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (fsm_output(9))) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_171);
  mux_598_nl <= MUX_s_1_2_2(mux_597_nl, nor_532_nl, fsm_output(1));
  and_355_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_598_nl;
  mux_599_nl <= MUX_s_1_2_2(nor_529_nl, and_355_nl, fsm_output(2));
  nor_533_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_593);
  nor_534_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_593);
  mux_594_nl <= MUX_s_1_2_2(nor_534_nl, nor_594_cse, fsm_output(1));
  mux_595_nl <= MUX_s_1_2_2(nor_533_nl, mux_594_nl, nor_115_cse);
  nor_536_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("01")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_596_nl <= MUX_s_1_2_2(mux_595_nl, nor_536_nl, fsm_output(2));
  mux_600_nl <= MUX_s_1_2_2(mux_599_nl, mux_596_nl, fsm_output(8));
  vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_607_nl, mux_600_nl,
      fsm_output(0));
  or_1339_nl <= (fsm_output(2)) OR CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR mux_tmp_620;
  or_1340_nl <= (NOT (fsm_output(2))) OR (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_616;
  mux_625_nl <= MUX_s_1_2_2(or_1339_nl, or_1340_nl, fsm_output(8));
  nand_212_nl <= NOT(nor_265_cse AND not_tmp_214);
  or_1341_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_609;
  mux_624_nl <= MUX_s_1_2_2(nand_212_nl, or_1341_nl, fsm_output(8));
  mux_626_nl <= MUX_s_1_2_2(mux_625_nl, mux_624_nl, fsm_output(1));
  or_1342_nl <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR mux_tmp_620;
  mux_621_nl <= MUX_s_1_2_2(or_1342_nl, mux_483_cse, fsm_output(2));
  or_1345_nl <= (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_616;
  mux_618_nl <= MUX_s_1_2_2(nand_232_cse, or_1345_nl, fsm_output(2));
  mux_622_nl <= MUX_s_1_2_2(mux_621_nl, mux_618_nl, fsm_output(8));
  nand_214_nl <= NOT((fsm_output(4)) AND not_tmp_214);
  mux_614_nl <= MUX_s_1_2_2(nand_214_nl, or_1379_cse, fsm_output(2));
  mux_610_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_609, fsm_output(6));
  or_1349_nl <= (fsm_output(4)) OR mux_610_nl;
  mux_612_nl <= MUX_s_1_2_2(mux_477_cse, or_1349_nl, fsm_output(2));
  mux_615_nl <= MUX_s_1_2_2(mux_614_nl, mux_612_nl, fsm_output(8));
  mux_623_nl <= MUX_s_1_2_2(mux_622_nl, mux_615_nl, fsm_output(1));
  nor_128_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100")));
  mux_627_nl <= MUX_s_1_2_2(mux_626_nl, mux_623_nl, nor_128_nl);
  vec_rsc_0_4_i_wea_d_pff <= NOT(mux_627_nl OR (fsm_output(0)));
  nor_492_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100")) OR (fsm_output(4))
      OR not_tmp_171);
  nor_493_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110")));
  mux_639_nl <= MUX_s_1_2_2(nor_492_nl, nor_493_nl, fsm_output(9));
  nor_494_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(5)) OR not_tmp_170);
  mux_640_nl <= MUX_s_1_2_2(mux_639_nl, nor_494_nl, fsm_output(1));
  nor_495_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01011")));
  nor_496_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_638_nl <= MUX_s_1_2_2(nor_495_nl, nor_496_nl, fsm_output(9));
  and_349_nl <= (fsm_output(1)) AND mux_638_nl;
  mux_641_nl <= MUX_s_1_2_2(mux_640_nl, and_349_nl, fsm_output(2));
  nor_497_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_538_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170;
  or_536_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_636_nl <= MUX_s_1_2_2(or_538_nl, or_536_nl, fsm_output(9));
  nor_498_nl <= NOT((fsm_output(1)) OR mux_636_nl);
  mux_637_nl <= MUX_s_1_2_2(nor_497_nl, nor_498_nl, fsm_output(2));
  mux_642_nl <= MUX_s_1_2_2(mux_641_nl, mux_637_nl, fsm_output(8));
  nor_499_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (VEC_LOOP_j_sva_11_0(0)) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_500_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170);
  nor_501_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_632_nl <= MUX_s_1_2_2(nor_500_nl, nor_501_nl, fsm_output(9));
  nor_502_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (fsm_output(9))) OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_171);
  mux_633_nl <= MUX_s_1_2_2(mux_632_nl, nor_502_nl, fsm_output(1));
  and_350_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_633_nl;
  mux_634_nl <= MUX_s_1_2_2(nor_499_nl, and_350_nl, fsm_output(2));
  nor_503_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_628);
  mux_629_nl <= MUX_s_1_2_2(nor_503_nl, nor_624_cse, fsm_output(1));
  nor_505_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_628);
  mux_630_nl <= MUX_s_1_2_2(mux_629_nl, nor_505_nl, or_521_cse);
  nor_506_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_631_nl <= MUX_s_1_2_2(mux_630_nl, nor_506_nl, fsm_output(2));
  mux_635_nl <= MUX_s_1_2_2(mux_634_nl, mux_631_nl, fsm_output(8));
  vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_642_nl, mux_635_nl,
      fsm_output(0));
  or_1330_nl <= (fsm_output(2)) OR CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR mux_tmp_620;
  nand_207_nl <= NOT((fsm_output(2)) AND (VEC_LOOP_j_sva_11_0(0)) AND not_tmp_226);
  mux_660_nl <= MUX_s_1_2_2(or_1330_nl, nand_207_nl, fsm_output(8));
  nand_208_nl <= NOT(nor_265_cse AND not_tmp_225);
  or_1331_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_644;
  mux_659_nl <= MUX_s_1_2_2(nand_208_nl, or_1331_nl, fsm_output(8));
  mux_661_nl <= MUX_s_1_2_2(mux_660_nl, mux_659_nl, fsm_output(1));
  or_1332_nl <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR mux_tmp_620;
  mux_656_nl <= MUX_s_1_2_2(or_1332_nl, mux_483_cse, fsm_output(2));
  nand_210_nl <= NOT((VEC_LOOP_j_sva_11_0(0)) AND not_tmp_226);
  mux_653_nl <= MUX_s_1_2_2(nand_232_cse, nand_210_nl, fsm_output(2));
  mux_657_nl <= MUX_s_1_2_2(mux_656_nl, mux_653_nl, fsm_output(8));
  nand_211_nl <= NOT((fsm_output(4)) AND not_tmp_225);
  mux_649_nl <= MUX_s_1_2_2(nand_211_nl, or_1379_cse, fsm_output(2));
  mux_645_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_644, fsm_output(6));
  or_1338_nl <= (fsm_output(4)) OR mux_645_nl;
  mux_647_nl <= MUX_s_1_2_2(mux_477_cse, or_1338_nl, fsm_output(2));
  mux_650_nl <= MUX_s_1_2_2(mux_649_nl, mux_647_nl, fsm_output(8));
  mux_658_nl <= MUX_s_1_2_2(mux_657_nl, mux_650_nl, fsm_output(1));
  nor_135_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")));
  mux_662_nl <= MUX_s_1_2_2(mux_661_nl, mux_658_nl, nor_135_nl);
  vec_rsc_0_5_i_wea_d_pff <= NOT(mux_662_nl OR (fsm_output(0)));
  nor_462_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")) OR (fsm_output(4))
      OR not_tmp_171);
  nor_463_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110")));
  mux_674_nl <= MUX_s_1_2_2(nor_462_nl, nor_463_nl, fsm_output(9));
  nor_464_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(5)) OR not_tmp_170);
  mux_675_nl <= MUX_s_1_2_2(mux_674_nl, nor_464_nl, fsm_output(1));
  nor_465_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01011")));
  nor_466_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_673_nl <= MUX_s_1_2_2(nor_465_nl, nor_466_nl, fsm_output(9));
  and_342_nl <= (fsm_output(1)) AND mux_673_nl;
  mux_676_nl <= MUX_s_1_2_2(mux_675_nl, and_342_nl, fsm_output(2));
  nor_467_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_595_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170;
  or_593_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_671_nl <= MUX_s_1_2_2(or_595_nl, or_593_nl, fsm_output(9));
  nor_468_nl <= NOT((fsm_output(1)) OR mux_671_nl);
  mux_672_nl <= MUX_s_1_2_2(nor_467_nl, nor_468_nl, fsm_output(2));
  mux_677_nl <= MUX_s_1_2_2(mux_676_nl, mux_672_nl, fsm_output(8));
  nor_469_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (NOT (VEC_LOOP_j_sva_11_0(0)))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_470_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170);
  nor_471_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_667_nl <= MUX_s_1_2_2(nor_470_nl, nor_471_nl, fsm_output(9));
  nor_472_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (fsm_output(9))) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_171);
  mux_668_nl <= MUX_s_1_2_2(mux_667_nl, nor_472_nl, fsm_output(1));
  and_343_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_668_nl;
  mux_669_nl <= MUX_s_1_2_2(nor_469_nl, and_343_nl, fsm_output(2));
  nor_473_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_663);
  mux_664_nl <= MUX_s_1_2_2(nor_473_nl, nor_594_cse, fsm_output(1));
  nor_475_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_663);
  mux_665_nl <= MUX_s_1_2_2(mux_664_nl, nor_475_nl, or_521_cse);
  nor_476_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("10")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_666_nl <= MUX_s_1_2_2(mux_665_nl, nor_476_nl, fsm_output(2));
  mux_670_nl <= MUX_s_1_2_2(mux_669_nl, mux_666_nl, fsm_output(8));
  vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_677_nl, mux_670_nl,
      fsm_output(0));
  nand_202_nl <= NOT(nor_112_cse AND not_tmp_239);
  or_1321_nl <= (NOT (fsm_output(2))) OR (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_686;
  mux_695_nl <= MUX_s_1_2_2(nand_202_nl, or_1321_nl, fsm_output(8));
  nand_203_nl <= NOT(nor_265_cse AND not_tmp_237);
  or_1322_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_679;
  mux_694_nl <= MUX_s_1_2_2(nand_203_nl, or_1322_nl, fsm_output(8));
  mux_696_nl <= MUX_s_1_2_2(mux_695_nl, mux_694_nl, fsm_output(1));
  nand_204_nl <= NOT(nor_114_cse AND not_tmp_239);
  mux_691_nl <= MUX_s_1_2_2(nand_204_nl, mux_483_cse, fsm_output(2));
  or_1325_nl <= (VEC_LOOP_j_sva_11_0(0)) OR mux_tmp_686;
  mux_688_nl <= MUX_s_1_2_2(nand_232_cse, or_1325_nl, fsm_output(2));
  mux_692_nl <= MUX_s_1_2_2(mux_691_nl, mux_688_nl, fsm_output(8));
  nand_206_nl <= NOT((fsm_output(4)) AND not_tmp_237);
  mux_684_nl <= MUX_s_1_2_2(nand_206_nl, or_1379_cse, fsm_output(2));
  mux_680_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_679, fsm_output(6));
  or_1329_nl <= (fsm_output(4)) OR mux_680_nl;
  mux_682_nl <= MUX_s_1_2_2(mux_477_cse, or_1329_nl, fsm_output(2));
  mux_685_nl <= MUX_s_1_2_2(mux_684_nl, mux_682_nl, fsm_output(8));
  mux_693_nl <= MUX_s_1_2_2(mux_692_nl, mux_685_nl, fsm_output(1));
  nor_143_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110")));
  mux_697_nl <= MUX_s_1_2_2(mux_696_nl, mux_693_nl, nor_143_nl);
  vec_rsc_0_6_i_wea_d_pff <= NOT(mux_697_nl OR (fsm_output(0)));
  nor_432_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110")) OR (fsm_output(4))
      OR not_tmp_171);
  nor_433_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01110")));
  mux_709_nl <= MUX_s_1_2_2(nor_432_nl, nor_433_nl, fsm_output(9));
  nor_434_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(5)) OR not_tmp_170);
  mux_710_nl <= MUX_s_1_2_2(mux_709_nl, nor_434_nl, fsm_output(1));
  nor_435_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01011")));
  nor_436_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_708_nl <= MUX_s_1_2_2(nor_435_nl, nor_436_nl, fsm_output(9));
  and_334_nl <= (fsm_output(1)) AND mux_708_nl;
  mux_711_nl <= MUX_s_1_2_2(mux_710_nl, and_334_nl, fsm_output(2));
  nor_437_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(5)))
      OR (NOT (fsm_output(4))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_650_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170;
  or_648_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_706_nl <= MUX_s_1_2_2(or_650_nl, or_648_nl, fsm_output(9));
  nor_438_nl <= NOT((fsm_output(1)) OR mux_706_nl);
  mux_707_nl <= MUX_s_1_2_2(nor_437_nl, nor_438_nl, fsm_output(2));
  mux_712_nl <= MUX_s_1_2_2(mux_711_nl, mux_707_nl, fsm_output(8));
  nor_439_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (VEC_LOOP_j_sva_11_0(0)) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_440_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR not_tmp_170);
  nor_441_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_702_nl <= MUX_s_1_2_2(nor_440_nl, nor_441_nl, fsm_output(9));
  nor_442_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (NOT (fsm_output(9))) OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("010")) OR not_tmp_171);
  mux_703_nl <= MUX_s_1_2_2(mux_702_nl, nor_442_nl, fsm_output(1));
  and_335_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_703_nl;
  mux_704_nl <= MUX_s_1_2_2(nor_439_nl, and_335_nl, fsm_output(2));
  nor_443_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_698);
  nor_444_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_698);
  mux_699_nl <= MUX_s_1_2_2(nor_444_nl, nor_624_cse, fsm_output(1));
  mux_700_nl <= MUX_s_1_2_2(nor_443_nl, mux_699_nl, and_336_cse);
  nor_446_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (VEC_LOOP_j_sva_11_0(0)) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_701_nl <= MUX_s_1_2_2(mux_700_nl, nor_446_nl, fsm_output(2));
  mux_705_nl <= MUX_s_1_2_2(mux_704_nl, mux_701_nl, fsm_output(8));
  vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_712_nl, mux_705_nl,
      fsm_output(0));
  nand_195_nl <= NOT(nor_122_cse AND not_tmp_239);
  nand_196_nl <= NOT((fsm_output(2)) AND (VEC_LOOP_j_sva_11_0(0)) AND not_tmp_250);
  mux_730_nl <= MUX_s_1_2_2(nand_195_nl, nand_196_nl, fsm_output(8));
  nand_197_nl <= NOT(nor_265_cse AND not_tmp_249);
  or_1314_nl <= (NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(6)))
      OR mux_tmp_714;
  mux_729_nl <= MUX_s_1_2_2(nand_197_nl, or_1314_nl, fsm_output(8));
  mux_731_nl <= MUX_s_1_2_2(mux_730_nl, mux_729_nl, fsm_output(1));
  nand_198_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND not_tmp_239);
  mux_726_nl <= MUX_s_1_2_2(nand_198_nl, mux_483_cse, fsm_output(2));
  nand_200_nl <= NOT((VEC_LOOP_j_sva_11_0(0)) AND not_tmp_250);
  mux_723_nl <= MUX_s_1_2_2(nand_232_cse, nand_200_nl, fsm_output(2));
  mux_727_nl <= MUX_s_1_2_2(mux_726_nl, mux_723_nl, fsm_output(8));
  nand_201_nl <= NOT((fsm_output(4)) AND not_tmp_249);
  mux_719_nl <= MUX_s_1_2_2(nand_201_nl, or_1379_cse, fsm_output(2));
  mux_715_nl <= MUX_s_1_2_2(or_277_cse, mux_tmp_714, fsm_output(6));
  or_1320_nl <= (fsm_output(4)) OR mux_715_nl;
  mux_717_nl <= MUX_s_1_2_2(mux_477_cse, or_1320_nl, fsm_output(2));
  mux_720_nl <= MUX_s_1_2_2(mux_719_nl, mux_717_nl, fsm_output(8));
  mux_728_nl <= MUX_s_1_2_2(mux_727_nl, mux_720_nl, fsm_output(1));
  and_333_nl <= CONV_SL_1_1(COMP_LOOP_acc_10_cse_12_1_1_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  mux_732_nl <= MUX_s_1_2_2(mux_731_nl, mux_728_nl, and_333_nl);
  vec_rsc_0_7_i_wea_d_pff <= NOT(mux_732_nl OR (fsm_output(0)));
  nor_404_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("100")) OR not_tmp_171);
  and_321_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)=STD_LOGIC_VECTOR'("01110"));
  mux_744_nl <= MUX_s_1_2_2(nor_404_nl, and_321_nl, fsm_output(9));
  nor_405_nl <= NOT((NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"))
      AND (fsm_output(9)) AND (fsm_output(6)) AND (fsm_output(4)) AND (NOT (fsm_output(5)))))
      OR not_tmp_171);
  mux_745_nl <= MUX_s_1_2_2(mux_744_nl, nor_405_nl, fsm_output(1));
  and_323_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)=STD_LOGIC_VECTOR'("01011"));
  nor_406_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_743_nl <= MUX_s_1_2_2(and_323_nl, nor_406_nl, fsm_output(9));
  and_322_nl <= (fsm_output(1)) AND mux_743_nl;
  mux_746_nl <= MUX_s_1_2_2(mux_745_nl, and_322_nl, fsm_output(2));
  nor_407_nl <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(4)))
      OR (NOT (fsm_output(5))) OR (fsm_output(3)) OR (fsm_output(7)));
  or_702_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111")) OR
      CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("001")) OR not_tmp_171;
  or_700_nl <= CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111")) OR
      CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000"));
  mux_741_nl <= MUX_s_1_2_2(or_702_nl, or_700_nl, fsm_output(9));
  nor_408_nl <= NOT((fsm_output(1)) OR mux_741_nl);
  mux_742_nl <= MUX_s_1_2_2(nor_407_nl, nor_408_nl, fsm_output(2));
  mux_747_nl <= MUX_s_1_2_2(mux_746_nl, mux_742_nl, fsm_output(8));
  nor_409_nl <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("11"))
      OR (NOT (fsm_output(1))) OR (fsm_output(9)) OR (NOT (VEC_LOOP_j_sva_11_0(0)))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00110")));
  nor_410_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111"))
      OR CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("001")) OR not_tmp_171);
  nor_411_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_1_cse_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("111"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("01000")));
  mux_737_nl <= MUX_s_1_2_2(nor_410_nl, nor_411_nl, fsm_output(9));
  nor_412_nl <= NOT(CONV_SL_1_1(COMP_LOOP_acc_14_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (NOT (fsm_output(9))) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(7
      DOWNTO 3)/=STD_LOGIC_VECTOR'("10101")));
  mux_738_nl <= MUX_s_1_2_2(mux_737_nl, nor_412_nl, fsm_output(1));
  and_324_nl <= COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm AND mux_738_nl;
  mux_739_nl <= MUX_s_1_2_2(nor_409_nl, and_324_nl, fsm_output(2));
  nor_413_nl <= NOT((fsm_output(1)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR mux_tmp_733);
  nor_414_nl <= NOT((NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR mux_tmp_733);
  nor_415_nl <= NOT((fsm_output(9)) OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(6
      DOWNTO 4)/=STD_LOGIC_VECTOR'("101")) OR not_tmp_171);
  mux_734_nl <= MUX_s_1_2_2(nor_414_nl, nor_415_nl, fsm_output(1));
  mux_735_nl <= MUX_s_1_2_2(nor_413_nl, mux_734_nl, and_336_cse);
  nor_416_nl <= NOT((NOT COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) OR CONV_SL_1_1(COMP_LOOP_acc_11_psp_sva(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("11")) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (NOT (VEC_LOOP_j_sva_11_0(0))) OR CONV_SL_1_1(fsm_output(7 DOWNTO 3)/=STD_LOGIC_VECTOR'("00000")));
  mux_736_nl <= MUX_s_1_2_2(mux_735_nl, nor_416_nl, fsm_output(2));
  mux_740_nl <= MUX_s_1_2_2(mux_739_nl, mux_736_nl, fsm_output(8));
  vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d <= MUX_s_1_2_2(mux_747_nl, mux_740_nl,
      fsm_output(0));
  and_dcpl_218 <= (fsm_output(3)) AND (NOT (fsm_output(5))) AND (NOT (fsm_output(2)));
  and_dcpl_223 <= nor_692_cse AND (fsm_output(1)) AND (NOT (fsm_output(6)));
  or_1409_nl <= (NOT((fsm_output(9)) AND (fsm_output(1)) AND (fsm_output(2)) AND
      (NOT (fsm_output(8))))) OR nand_240_cse;
  or_1407_nl <= (fsm_output(9)) OR (fsm_output(1)) OR (fsm_output(2)) OR (NOT (fsm_output(8)))
      OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_1417_nl <= MUX_s_1_2_2(or_1409_nl, or_1407_nl, fsm_output(3));
  nor_789_nl <= NOT((fsm_output(5)) OR mux_1417_nl);
  and_709_nl <= (fsm_output(3)) AND (fsm_output(9)) AND (fsm_output(1)) AND (NOT
      (fsm_output(2))) AND (fsm_output(8)) AND (fsm_output(0)) AND (NOT (fsm_output(6)));
  and_711_nl <= (fsm_output(8)) AND (fsm_output(0)) AND (fsm_output(6));
  nor_790_nl <= NOT((fsm_output(8)) OR (fsm_output(0)) OR (fsm_output(6)));
  mux_1415_nl <= MUX_s_1_2_2(and_711_nl, nor_790_nl, fsm_output(2));
  and_710_nl <= (NOT((fsm_output(3)) OR (fsm_output(9)) OR (NOT (fsm_output(1)))))
      AND mux_1415_nl;
  mux_1416_nl <= MUX_s_1_2_2(and_709_nl, and_710_nl, fsm_output(5));
  mux_1418_nl <= MUX_s_1_2_2(nor_789_nl, mux_1416_nl, fsm_output(4));
  nand_259_nl <= NOT((fsm_output(2)) AND (fsm_output(8)) AND (fsm_output(0)) AND
      (fsm_output(6)));
  or_1403_nl <= (NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(0)))
      OR (fsm_output(6));
  mux_1444_nl <= MUX_s_1_2_2(nand_259_nl, or_1403_nl, fsm_output(1));
  nor_791_nl <= NOT((NOT (fsm_output(3))) OR (fsm_output(9)) OR mux_1444_nl);
  nor_792_nl <= NOT((fsm_output(3)) OR (NOT (fsm_output(9))) OR (fsm_output(1)) OR
      (fsm_output(2)) OR (fsm_output(8)) OR (NOT (fsm_output(0))) OR (fsm_output(6)));
  mux_1414_nl <= MUX_s_1_2_2(nor_791_nl, nor_792_nl, fsm_output(5));
  and_712_nl <= (fsm_output(4)) AND mux_1414_nl;
  not_tmp_519 <= MUX_s_1_2_2(mux_1418_nl, and_712_nl, fsm_output(7));
  mux_tmp_1422 <= MUX_s_1_2_2(or_718_cse, or_tmp_677, fsm_output(6));
  mux_tmp_1425 <= MUX_s_1_2_2(or_tmp_682, or_718_cse, fsm_output(6));
  nor_784_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(4)) OR (NOT (fsm_output(9)))
      OR (NOT (fsm_output(1))) OR (NOT (fsm_output(6))) OR (NOT (fsm_output(8)))
      OR (fsm_output(0)) OR (fsm_output(7)));
  nand_249_nl <= NOT((fsm_output(1)) AND (NOT mux_tmp_1425));
  or_1425_nl <= (fsm_output(1)) OR (fsm_output(8)) OR (fsm_output(0)) OR (fsm_output(7));
  mux_1427_nl <= MUX_s_1_2_2(nand_249_nl, or_1425_nl, fsm_output(9));
  nor_785_nl <= NOT((fsm_output(4)) OR mux_1427_nl);
  and_713_nl <= (fsm_output(1)) AND (fsm_output(8)) AND (NOT (fsm_output(0))) AND
      (fsm_output(7));
  nor_787_nl <= NOT((fsm_output(1)) OR mux_tmp_1425);
  mux_1426_nl <= MUX_s_1_2_2(and_713_nl, nor_787_nl, fsm_output(9));
  and_708_nl <= (fsm_output(4)) AND mux_1426_nl;
  mux_1428_nl <= MUX_s_1_2_2(nor_785_nl, and_708_nl, fsm_output(2));
  mux_1429_nl <= MUX_s_1_2_2(nor_784_nl, mux_1428_nl, fsm_output(3));
  or_1420_nl <= (fsm_output(9)) OR (fsm_output(1)) OR mux_tmp_1422;
  nand_247_nl <= NOT((fsm_output(9)) AND (fsm_output(1)) AND (NOT mux_tmp_1422));
  mux_1423_nl <= MUX_s_1_2_2(or_1420_nl, nand_247_nl, fsm_output(4));
  mux_1420_nl <= MUX_s_1_2_2(or_tmp_9, or_730_cse, fsm_output(8));
  mux_1421_nl <= MUX_s_1_2_2(mux_1420_nl, or_tmp_682, fsm_output(6));
  or_1415_nl <= (NOT (fsm_output(4))) OR (fsm_output(9)) OR (fsm_output(1)) OR mux_1421_nl;
  mux_1424_nl <= MUX_s_1_2_2(mux_1423_nl, or_1415_nl, fsm_output(2));
  nor_788_nl <= NOT((fsm_output(3)) OR mux_1424_nl);
  not_tmp_524 <= MUX_s_1_2_2(mux_1429_nl, nor_788_nl, fsm_output(5));
  or_1456_nl <= (NOT (fsm_output(9))) OR (fsm_output(6)) OR (fsm_output(8)) OR (NOT
      (fsm_output(2)));
  nand_nl <= NOT((fsm_output(9)) AND (fsm_output(6)) AND (fsm_output(8)) AND (NOT
      (fsm_output(2))));
  mux_1433_nl <= MUX_s_1_2_2(or_1456_nl, nand_nl, fsm_output(1));
  or_1457_nl <= (NOT (fsm_output(1))) OR (fsm_output(9)) OR (NOT (fsm_output(6)))
      OR (fsm_output(8)) OR (NOT (fsm_output(2)));
  mux_1434_nl <= MUX_s_1_2_2(mux_1433_nl, or_1457_nl, fsm_output(7));
  mux_1435_nl <= MUX_s_1_2_2(or_798_cse, mux_1434_nl, fsm_output(4));
  mux_1436_nl <= MUX_s_1_2_2(or_1312_cse, mux_1435_nl, fsm_output(3));
  nor_775_nl <= NOT((fsm_output(1)) OR (fsm_output(9)) OR (NOT (fsm_output(6))) OR
      (fsm_output(8)) OR (NOT (fsm_output(2))));
  nor_776_nl <= NOT((NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (fsm_output(8))
      OR (fsm_output(2)));
  nor_777_nl <= NOT((fsm_output(9)) OR (fsm_output(6)) OR (NOT (fsm_output(8))) OR
      (fsm_output(2)));
  mux_1431_nl <= MUX_s_1_2_2(nor_776_nl, nor_777_nl, fsm_output(1));
  mux_1432_nl <= MUX_s_1_2_2(nor_775_nl, mux_1431_nl, fsm_output(7));
  nand_256_nl <= NOT((NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("10"))))
      AND mux_1432_nl);
  mux_1437_nl <= MUX_s_1_2_2(mux_1436_nl, nand_256_nl, fsm_output(5));
  and_dcpl_246 <= NOT(mux_1437_nl OR (fsm_output(0)));
  nor_tmp_272 <= (fsm_output(1)) AND (fsm_output(4));
  nor_780_nl <= NOT((fsm_output(1)) OR (fsm_output(4)));
  mux_1440_nl <= MUX_s_1_2_2(nor_780_nl, nor_tmp_272, fsm_output(9));
  nor_779_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT((fsm_output(8)) AND mux_1440_nl)));
  nor_781_nl <= NOT(CONV_SL_1_1(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT nor_tmp_272));
  nor_782_nl <= NOT((NOT (fsm_output(8))) OR (fsm_output(9)) OR (fsm_output(1)) OR
      (NOT (fsm_output(4))));
  mux_1439_nl <= MUX_s_1_2_2(nor_781_nl, nor_782_nl, fsm_output(6));
  and_nl <= (fsm_output(7)) AND mux_1439_nl;
  mux_1441_nl <= MUX_s_1_2_2(nor_779_nl, and_nl, fsm_output(2));
  mux_1442_nl <= MUX_s_1_2_2(nor_365_cse, mux_1441_nl, fsm_output(3));
  nand_262_nl <= NOT((fsm_output(6)) AND (fsm_output(8)) AND (NOT (fsm_output(9)))
      AND nor_tmp_272);
  or_1442_nl <= (fsm_output(6)) OR (fsm_output(8)) OR (NOT (fsm_output(9))) OR (fsm_output(1))
      OR (NOT (fsm_output(4)));
  mux_1438_nl <= MUX_s_1_2_2(nand_262_nl, or_1442_nl, fsm_output(7));
  nor_783_nl <= NOT(CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00"))
      OR mux_1438_nl);
  mux_1443_nl <= MUX_s_1_2_2(mux_1442_nl, nor_783_nl, fsm_output(5));
  and_dcpl_247 <= mux_1443_nl AND (fsm_output(0));
  and_dcpl_248 <= (NOT (fsm_output(6))) AND (fsm_output(0));
  and_dcpl_256 <= nor_692_cse AND CONV_SL_1_1(fsm_output(5 DOWNTO 1)=STD_LOGIC_VECTOR'("00000"))
      AND and_dcpl_248;
  and_dcpl_262 <= nor_692_cse AND CONV_SL_1_1(fsm_output(5 DOWNTO 1)=STD_LOGIC_VECTOR'("11010"))
      AND and_dcpl_248;
  and_dcpl_265 <= (NOT (fsm_output(2))) AND (fsm_output(4)) AND (fsm_output(1));
  and_dcpl_267 <= (NOT (fsm_output(3))) AND (fsm_output(5));
  and_dcpl_271 <= nor_692_cse AND and_dcpl_267 AND and_dcpl_265 AND (NOT (fsm_output(6)))
      AND (fsm_output(0));
  and_dcpl_277 <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("010")) AND
      and_dcpl_267 AND and_dcpl_265 AND (NOT (fsm_output(6))) AND (NOT (fsm_output(0)));
  and_dcpl_278 <= (fsm_output(6)) AND (NOT (fsm_output(0)));
  and_dcpl_280 <= (fsm_output(3)) AND (NOT (fsm_output(5)));
  and_dcpl_284 <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("101")) AND
      and_dcpl_280 AND and_dcpl_265 AND and_dcpl_278;
  and_dcpl_289 <= nor_692_cse AND and_dcpl_280 AND (fsm_output(2)) AND (fsm_output(4))
      AND (fsm_output(1)) AND and_dcpl_278;
  and_dcpl_291 <= (NOT (fsm_output(2))) AND (fsm_output(4));
  and_dcpl_298 <= nor_692_cse AND and_dcpl_267 AND and_dcpl_291 AND (fsm_output(1))
      AND (NOT (fsm_output(6))) AND (fsm_output(0));
  and_dcpl_300 <= (fsm_output(2)) AND (fsm_output(4));
  and_dcpl_305 <= nor_692_cse AND and_dcpl_280 AND and_dcpl_300 AND (fsm_output(1))
      AND and_dcpl_278;
  and_dcpl_309 <= (fsm_output(7)) AND (NOT (fsm_output(9)));
  and_dcpl_312 <= and_dcpl_309 AND (NOT (fsm_output(8))) AND and_dcpl_280 AND (NOT
      (fsm_output(2))) AND (NOT (fsm_output(4))) AND (NOT (fsm_output(1))) AND and_dcpl_278;
  and_dcpl_313 <= NOT((fsm_output(6)) OR (fsm_output(0)));
  and_dcpl_318 <= and_dcpl_309 AND (fsm_output(8)) AND and_dcpl_280 AND and_dcpl_300
      AND (NOT (fsm_output(1))) AND and_dcpl_313;
  and_dcpl_324 <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("100"));
  and_dcpl_326 <= and_dcpl_324 AND CONV_SL_1_1(fsm_output(5 DOWNTO 1)=STD_LOGIC_VECTOR'("00011"))
      AND and_dcpl_313;
  and_dcpl_330 <= and_dcpl_324 AND and_dcpl_267 AND and_dcpl_291 AND (NOT (fsm_output(1)))
      AND and_dcpl_278;
  and_dcpl_342 <= and_dcpl_291 AND (fsm_output(1));
  and_dcpl_355 <= (fsm_output(2)) AND (NOT (fsm_output(4)));
  nor_797_cse <= NOT((fsm_output(3)) OR (fsm_output(5)));
  and_dcpl_359 <= CONV_SL_1_1(fsm_output(9 DOWNTO 8)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_360 <= and_dcpl_359 AND (NOT (fsm_output(7)));
  and_dcpl_410 <= (NOT (fsm_output(7))) AND (fsm_output(9));
  and_dcpl_411 <= and_dcpl_410 AND (NOT (fsm_output(8)));
  and_dcpl_442 <= NOT(CONV_SL_1_1(fsm_output/=STD_LOGIC_VECTOR'("0000001001")));
  and_dcpl_451 <= nor_692_cse AND CONV_SL_1_1(fsm_output(6 DOWNTO 0)=STD_LOGIC_VECTOR'("0110011"));
  and_dcpl_460 <= CONV_SL_1_1(fsm_output=STD_LOGIC_VECTOR'("1101000100"));
  and_dcpl_467 <= nor_692_cse AND CONV_SL_1_1(fsm_output(6 DOWNTO 0)=STD_LOGIC_VECTOR'("0001010"));
  and_243_m1c <= and_dcpl_76 AND and_dcpl_157;
  nor_tmp_273 <= ((NOT (fsm_output(1))) OR (fsm_output(9))) AND (fsm_output(7));
  mux_tmp_1456 <= MUX_s_1_2_2(mux_tmp_898, or_tmp_72, and_303_cse);
  or_tmp_1262 <= (fsm_output(0)) OR (fsm_output(9));
  or_tmp_1267 <= (fsm_output(8)) OR (fsm_output(0)) OR (NOT (fsm_output(9)));
  or_tmp_1269 <= nor_820_cse OR (fsm_output(0)) OR (fsm_output(9));
  or_tmp_1273 <= (NOT (fsm_output(6))) OR (NOT (fsm_output(8))) OR (fsm_output(0))
      OR (fsm_output(9));
  or_tmp_1274 <= (fsm_output(6)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR
      (NOT (fsm_output(8))) OR (NOT (fsm_output(0))) OR (fsm_output(9));
  not_tmp_621 <= NOT((fsm_output(0)) AND (fsm_output(9)));
  COMP_LOOP_or_39_itm <= and_dcpl_247 OR and_dcpl_262;
  operator_64_false_1_nor_1_itm <= NOT(and_dcpl_271 OR and_dcpl_284 OR and_dcpl_289);
  COMP_LOOP_or_43_itm <= and_dcpl_305 OR and_dcpl_312 OR and_dcpl_318 OR and_dcpl_326
      OR and_dcpl_330;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( mux_453_itm = '1' ) THEN
        p_sva <= p_rsci_idat;
        r_sva <= r_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((and_dcpl_53 AND and_dcpl_33 AND and_dcpl_50) OR STAGE_LOOP_i_3_0_sva_mx0c1)
          = '1' ) THEN
        STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(STD_LOGIC_VECTOR'( "0001"), STAGE_LOOP_i_3_0_sva_2,
            STAGE_LOOP_i_3_0_sva_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_vec_rsc_triosy_0_7_obj_ld_cse <= '0';
        COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm <= '0';
        modExp_exp_1_0_1_sva_1 <= '0';
        modExp_exp_1_7_1_sva <= '0';
        modExp_exp_1_2_1_sva <= '0';
        modExp_exp_1_1_1_sva <= '0';
        COMP_LOOP_COMP_LOOP_nor_1_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_12_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_124_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_125_itm <= '0';
      ELSE
        reg_vec_rsc_triosy_0_7_obj_ld_cse <= and_dcpl_23 AND and_dcpl_33 AND (fsm_output(7))
            AND (NOT (fsm_output(1))) AND (fsm_output(8)) AND (fsm_output(9)) AND
            (fsm_output(0)) AND (NOT STAGE_LOOP_acc_itm_2_1);
        COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm <= (operator_64_false_1_mux1h_nl AND
            (mux_1171_nl OR CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))))
            OR (mux_1215_nl AND CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10")));
        modExp_exp_1_0_1_sva_1 <= (COMP_LOOP_mux_42_nl AND (NOT(mux_1218_nl AND (fsm_output(2))
            AND (NOT (fsm_output(0)))))) OR (NOT(mux_1266_nl OR (fsm_output(2)) OR
            (fsm_output(0))));
        modExp_exp_1_7_1_sva <= COMP_LOOP_mux1h_32_nl AND (NOT(mux_1295_nl AND (fsm_output(0))));
        modExp_exp_1_2_1_sva <= COMP_LOOP_mux1h_46_nl AND (NOT and_dcpl_191);
        modExp_exp_1_1_1_sva <= (COMP_LOOP_mux1h_48_nl AND (mux_1311_nl OR (fsm_output(9))))
            OR (NOT(mux_1314_nl OR (fsm_output(0))));
        COMP_LOOP_COMP_LOOP_nor_1_itm <= NOT(CONV_SL_1_1(z_out_6_12_1(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000")));
        COMP_LOOP_COMP_LOOP_and_12_itm <= MUX_s_1_2_2(COMP_LOOP_COMP_LOOP_and_12_cse,
            COMP_LOOP_COMP_LOOP_and_11_cse, modExp_while_or_1_cse);
        COMP_LOOP_COMP_LOOP_and_124_itm <= MUX_s_1_2_2(COMP_LOOP_COMP_LOOP_and_13_cse,
            COMP_LOOP_COMP_LOOP_and_12_cse, modExp_while_or_1_cse);
        COMP_LOOP_COMP_LOOP_and_125_itm <= MUX_s_1_2_2(COMP_LOOP_COMP_LOOP_and_37_cse,
            COMP_LOOP_COMP_LOOP_and_13_cse, modExp_while_or_1_cse);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      modulo_result_rem_cmp_a <= MUX1HOT_v_64_5_2(z_out, operator_64_false_acc_mut_63_0,
          COMP_LOOP_1_acc_8_itm, COMP_LOOP_1_mul_mut, COMP_LOOP_1_acc_5_mut_mx0w5,
          STD_LOGIC_VECTOR'( modulo_result_or_nl & (NOT mux_802_nl) & (NOT mux_848_nl)
          & mux_880_nl & and_dcpl_151));
      modulo_result_rem_cmp_b <= p_sva;
      operator_66_true_div_cmp_a <= MUX_v_65_2_2(z_out_2, (operator_64_false_acc_mut_64
          & operator_64_false_acc_mut_63_0), and_dcpl_156);
      operator_66_true_div_cmp_b_9_0 <= MUX_v_10_2_2(STAGE_LOOP_lshift_psp_sva_mx0w0,
          STAGE_LOOP_lshift_psp_sva, and_dcpl_156);
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (MUX_s_1_2_2(mux_446_cse, mux_444_nl, fsm_output(0))) = '1' ) THEN
        STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( mux_1493_nl = '0' ) THEN
        operator_64_false_acc_mut_64 <= operator_64_false_operator_64_false_mux_rgt(64);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (MUX_s_1_2_2(mux_1519_nl, mux_1503_nl, fsm_output(5))) = '1' ) THEN
        operator_64_false_acc_mut_63_0 <= operator_64_false_operator_64_false_mux_rgt(63
            DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        VEC_LOOP_j_sva_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( ((NOT(mux_tmp_1013 OR (fsm_output(2)) OR (fsm_output(6)) OR (fsm_output(7))
          OR (NOT not_tmp_82))) OR VEC_LOOP_j_sva_11_0_mx0c1) = '1' ) THEN
        VEC_LOOP_j_sva_11_0 <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"), (z_out_1(11
            DOWNTO 0)), VEC_LOOP_j_sva_11_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_k_9_3_sva_5_0 <= STD_LOGIC_VECTOR'( "000000");
      ELSIF ( (MUX_s_1_2_2(mux_1522_nl, nor_827_nl, fsm_output(6))) = '1' ) THEN
        COMP_LOOP_k_9_3_sva_5_0 <= MUX_v_6_2_2(STD_LOGIC_VECTOR'("000000"), (z_out_8(5
            DOWNTO 0)), or_1460_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((operator_64_false_slc_modExp_exp_0_1_itm OR modExp_result_sva_mx0c0
          OR (NOT mux_1035_nl)) AND (modExp_result_sva_mx0c0 OR modExp_result_and_rgt
          OR modExp_result_and_1_rgt)) = '1' ) THEN
        modExp_result_sva <= MUX1HOT_v_64_3_2(STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000001"),
            modulo_result_rem_cmp_z, modulo_qr_sva_1_mx1w1, STD_LOGIC_VECTOR'( modExp_result_sva_mx0c0
            & modExp_result_and_rgt & modExp_result_and_1_rgt));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((and_dcpl_82 AND and_dcpl_157) OR modExp_base_sva_mx0c1) = '1' ) THEN
        modExp_base_sva <= MUX_v_64_2_2(r_sva, modulo_result_mux_1_cse, modExp_base_sva_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        operator_64_false_slc_modExp_exp_0_1_itm <= '0';
      ELSIF ( ((NOT(mux_tmp_1013 OR (fsm_output(2)) OR (fsm_output(6)) OR (fsm_output(7))
          OR (fsm_output(8)) OR (fsm_output(9)))) AND or_dcpl_3) = '1' ) THEN
        operator_64_false_slc_modExp_exp_0_1_itm <= MUX_s_1_2_2((operator_66_true_div_cmp_z(0)),
            (modExp_exp_sva_rsp_1(0)), or_dcpl_56);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( or_dcpl_3 = '1' ) THEN
        operator_64_false_slc_modExp_exp_63_1_itm <= operator_64_false_slc_modExp_exp_63_1_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_COMP_LOOP_and_11_itm <= '0';
      ELSIF ( (and_dcpl_150 OR and_dcpl_177 OR and_dcpl_77 OR and_dcpl_90 OR and_dcpl_98
          OR and_dcpl_104 OR and_dcpl_109 OR and_dcpl_116 OR and_dcpl_126 OR and_dcpl_134)
          = '1' ) THEN
        COMP_LOOP_COMP_LOOP_and_11_itm <= MUX1HOT_s_1_4_2((NOT (z_out_8(63))), (NOT
            (z_out_2(8))), COMP_LOOP_COMP_LOOP_and_11_cse, COMP_LOOP_COMP_LOOP_and_37_cse,
            STD_LOGIC_VECTOR'( and_dcpl_150 & and_dcpl_177 & and_dcpl_77 & modExp_while_or_1_cse));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((and_dcpl_82 AND and_dcpl_66) OR mux_1134_nl OR and_dcpl_151) = '1' )
          THEN
        COMP_LOOP_1_acc_8_itm <= MUX_v_64_2_2(z_out, (z_out_2(63 DOWNTO 0)), and_dcpl_151);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(or_dcpl_62 OR (NOT (fsm_output(5))) OR (fsm_output(6)) OR (fsm_output(7))
          OR (NOT (fsm_output(1))) OR (fsm_output(8)) OR or_1275_cse)) = '1' ) THEN
        COMP_LOOP_acc_psp_sva <= COMP_LOOP_acc_psp_sva_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_COMP_LOOP_nor_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_58_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_30_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_32_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_4_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_5_itm <= '0';
        COMP_LOOP_COMP_LOOP_and_6_itm <= '0';
      ELSIF ( mux_1151_itm = '1' ) THEN
        COMP_LOOP_COMP_LOOP_nor_itm <= NOT(CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO
            0)/=STD_LOGIC_VECTOR'("000")));
        COMP_LOOP_COMP_LOOP_and_58_itm <= (z_out_8(0)) AND (VEC_LOOP_j_sva_11_0(0))
            AND (NOT (z_out_8(1)));
        COMP_LOOP_COMP_LOOP_and_30_itm <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva_1(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011"));
        COMP_LOOP_COMP_LOOP_and_32_itm <= CONV_SL_1_1(COMP_LOOP_acc_1_cse_2_sva_1(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101"));
        COMP_LOOP_COMP_LOOP_and_4_itm <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO
            0)=STD_LOGIC_VECTOR'("101"));
        COMP_LOOP_COMP_LOOP_and_5_itm <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO
            0)=STD_LOGIC_VECTOR'("110"));
        COMP_LOOP_COMP_LOOP_and_6_itm <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO
            0)=STD_LOGIC_VECTOR'("111"));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_COMP_LOOP_and_2_itm <= '0';
      ELSIF ( (MUX_s_1_2_2(nor_808_nl, and_714_nl, fsm_output(8))) = '1' ) THEN
        COMP_LOOP_COMP_LOOP_and_2_itm <= MUX_s_1_2_2(COMP_LOOP_COMP_LOOP_and_2_nl,
            (NOT (COMP_LOOP_1_acc_nl(9))), and_dcpl_134);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_11_psp_sva <= STD_LOGIC_VECTOR'( "00000000000");
      ELSIF ( (mux_1157_nl OR (fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_11_psp_sva <= z_out_8(10 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_2_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (NOT(mux_1160_nl AND not_tmp_82)) = '1' ) THEN
        COMP_LOOP_acc_1_cse_2_sva <= COMP_LOOP_acc_1_cse_2_sva_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_4_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (mux_1162_nl OR (fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_1_cse_4_sva <= z_out_1(11 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_13_psp_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (MUX_s_1_2_2(not_tmp_384, or_1038_nl, fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_13_psp_sva <= z_out_4;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_6_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (MUX_s_1_2_2(not_tmp_384, or_1043_nl, fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_1_cse_6_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_11_0)
            + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_3_sva_5_0 & STD_LOGIC_VECTOR'(
            "101")), 9), 12), 12));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_14_psp_sva <= STD_LOGIC_VECTOR'( "00000000000");
      ELSIF ( (MUX_s_1_2_2(not_tmp_384, and_212_nl, fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_14_psp_sva <= z_out_7(10 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_1_cse_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (MUX_s_1_2_2(not_tmp_384, and_214_nl, fsm_output(9))) = '1' ) THEN
        COMP_LOOP_acc_1_cse_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_11_0)
            + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_3_sva_5_0 & STD_LOGIC_VECTOR'(
            "111")), 9), 12), 12));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_1_6_1_sva <= '0';
        modExp_exp_1_5_1_sva <= '0';
        modExp_exp_1_4_1_sva <= '0';
        modExp_exp_1_3_1_sva <= '0';
      ELSIF ( mux_1289_itm = '1' ) THEN
        modExp_exp_1_6_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_3_sva_5_0(3)), modExp_exp_1_7_1_sva,
            (COMP_LOOP_k_9_3_sva_5_0(4)), STD_LOGIC_VECTOR'( and_dcpl_191 & and_dcpl_194
            & and_dcpl_192));
        modExp_exp_1_5_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_3_sva_5_0(2)), modExp_exp_1_6_1_sva,
            (COMP_LOOP_k_9_3_sva_5_0(3)), STD_LOGIC_VECTOR'( and_dcpl_191 & and_dcpl_194
            & and_dcpl_192));
        modExp_exp_1_4_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_3_sva_5_0(1)), modExp_exp_1_5_1_sva,
            (COMP_LOOP_k_9_3_sva_5_0(2)), STD_LOGIC_VECTOR'( and_dcpl_191 & and_dcpl_194
            & and_dcpl_192));
        modExp_exp_1_3_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_3_sva_5_0(0)), modExp_exp_1_4_1_sva,
            (COMP_LOOP_k_9_3_sva_5_0(1)), STD_LOGIC_VECTOR'( and_dcpl_191 & and_dcpl_194
            & and_dcpl_192));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (and_dcpl_191 OR tmp_10_lpi_4_dfm_mx0c1 OR tmp_10_lpi_4_dfm_mx0c2 OR tmp_10_lpi_4_dfm_mx0c3
          OR tmp_10_lpi_4_dfm_mx0c4 OR tmp_10_lpi_4_dfm_mx0c5 OR tmp_10_lpi_4_dfm_mx0c6
          OR tmp_10_lpi_4_dfm_mx0c7) = '1' ) THEN
        tmp_10_lpi_4_dfm <= MUX1HOT_v_64_8_2(vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d,
            vec_rsc_0_2_i_qa_d, vec_rsc_0_3_i_qa_d, vec_rsc_0_4_i_qa_d, vec_rsc_0_5_i_qa_d,
            vec_rsc_0_6_i_qa_d, vec_rsc_0_7_i_qa_d, STD_LOGIC_VECTOR'( COMP_LOOP_or_15_nl
            & COMP_LOOP_or_16_nl & COMP_LOOP_or_17_nl & COMP_LOOP_or_18_nl & COMP_LOOP_or_19_nl
            & COMP_LOOP_or_20_nl & COMP_LOOP_or_21_nl & COMP_LOOP_or_22_nl));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (MUX_s_1_2_2(mux_1383_nl, mux_1360_nl, fsm_output(2))) = '1' ) THEN
        COMP_LOOP_1_mul_mut <= MUX1HOT_v_64_12_2(modExp_result_sva, modulo_result_rem_cmp_z,
            modulo_qr_sva_1_mx1w1, vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, vec_rsc_0_2_i_qa_d,
            vec_rsc_0_3_i_qa_d, vec_rsc_0_4_i_qa_d, vec_rsc_0_5_i_qa_d, vec_rsc_0_6_i_qa_d,
            vec_rsc_0_7_i_qa_d, z_out, STD_LOGIC_VECTOR'( COMP_LOOP_nor_97_cse &
            COMP_LOOP_or_26_nl & COMP_LOOP_or_27_nl & COMP_LOOP_or_7_nl & COMP_LOOP_or_8_nl
            & COMP_LOOP_or_9_nl & COMP_LOOP_or_10_nl & COMP_LOOP_or_11_nl & COMP_LOOP_or_12_nl
            & COMP_LOOP_or_13_nl & COMP_LOOP_or_14_nl & nor_746_nl));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        COMP_LOOP_acc_10_cse_12_1_1_sva <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( COMP_LOOP_or_3_cse = '1' ) THEN
        COMP_LOOP_acc_10_cse_12_1_1_sva <= z_out_6_12_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (and_dcpl_77 OR and_dcpl_152 OR and_dcpl_90 OR and_dcpl_104 OR and_dcpl_109
          OR and_dcpl_116) = '1' ) THEN
        COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm <= MUX_s_1_2_2((z_out_4(9)), (z_out_2(8)),
            and_dcpl_152);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        modExp_exp_sva_rsp_1 <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (mux_1038_nl OR CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"))
          OR (NOT not_tmp_82)) = '1' ) THEN
        modExp_exp_sva_rsp_1 <= operator_64_false_slc_modExp_exp_63_1_3;
      END IF;
    END IF;
  END PROCESS;
  or_767_nl <= (NOT (fsm_output(9))) OR (fsm_output(1)) OR (NOT (fsm_output(3)))
      OR (fsm_output(5));
  or_766_nl <= (fsm_output(9)) OR (fsm_output(1)) OR (fsm_output(3)) OR (NOT (fsm_output(5)));
  mux_852_nl <= MUX_s_1_2_2(or_767_nl, or_766_nl, fsm_output(6));
  or_764_nl <= (NOT (fsm_output(6))) OR (fsm_output(9)) OR (NOT (fsm_output(1)))
      OR (NOT (fsm_output(3))) OR (fsm_output(5));
  mux_853_nl <= MUX_s_1_2_2(mux_852_nl, or_764_nl, fsm_output(7));
  nor_392_nl <= NOT((fsm_output(8)) OR mux_853_nl);
  nor_393_nl <= NOT((NOT (fsm_output(8))) OR (fsm_output(7)) OR (NOT (fsm_output(6)))
      OR (NOT (fsm_output(9))) OR (NOT (fsm_output(1))) OR (fsm_output(3)) OR (fsm_output(5)));
  mux_854_nl <= MUX_s_1_2_2(nor_392_nl, nor_393_nl, fsm_output(2));
  nor_394_nl <= NOT((fsm_output(8)) OR (fsm_output(7)) OR (NOT (fsm_output(6))) OR
      (NOT (fsm_output(9))) OR (NOT (fsm_output(1))) OR (fsm_output(3)) OR (NOT (fsm_output(5))));
  nor_395_nl <= NOT((NOT (fsm_output(7))) OR (NOT (fsm_output(6))) OR (NOT (fsm_output(9)))
      OR (fsm_output(1)) OR (NOT (fsm_output(3))) OR (fsm_output(5)));
  nor_396_nl <= NOT((fsm_output(6)) OR (fsm_output(9)) OR (fsm_output(1)) OR (fsm_output(3))
      OR (NOT (fsm_output(5))));
  mux_849_nl <= MUX_s_1_2_2(nor_396_nl, nor_397_cse, fsm_output(7));
  mux_850_nl <= MUX_s_1_2_2(nor_395_nl, mux_849_nl, fsm_output(8));
  mux_851_nl <= MUX_s_1_2_2(nor_394_nl, mux_850_nl, fsm_output(2));
  mux_855_nl <= MUX_s_1_2_2(mux_854_nl, mux_851_nl, fsm_output(4));
  mux_856_nl <= MUX_s_1_2_2(mux_855_nl, nor_398_cse, fsm_output(0));
  modulo_result_or_nl <= and_dcpl_150 OR and_dcpl_152 OR mux_856_nl;
  mux_797_nl <= MUX_s_1_2_2(or_91_cse, (NOT or_90_cse), fsm_output(6));
  or_733_nl <= (fsm_output(8)) OR nor_tmp_166;
  mux_796_nl <= MUX_s_1_2_2((NOT nor_tmp_168), or_733_nl, fsm_output(6));
  mux_798_nl <= MUX_s_1_2_2(mux_797_nl, mux_796_nl, and_316_cse);
  mux_799_nl <= MUX_s_1_2_2(mux_798_nl, mux_tmp_164, fsm_output(5));
  mux_792_nl <= MUX_s_1_2_2((NOT or_tmp_682), nor_tmp_168, fsm_output(6));
  mux_791_nl <= MUX_s_1_2_2(nor_tmp_166, nor_tmp_13, fsm_output(6));
  mux_793_nl <= MUX_s_1_2_2(mux_792_nl, mux_791_nl, fsm_output(1));
  mux_789_nl <= MUX_s_1_2_2((NOT or_tmp_9), (fsm_output(7)), or_731_cse);
  mux_790_nl <= MUX_s_1_2_2(mux_789_nl, mux_tmp_773, fsm_output(1));
  mux_794_nl <= MUX_s_1_2_2(mux_793_nl, mux_790_nl, fsm_output(2));
  mux_795_nl <= MUX_s_1_2_2(mux_tmp_777, (NOT mux_794_nl), fsm_output(5));
  mux_800_nl <= MUX_s_1_2_2(mux_799_nl, mux_795_nl, fsm_output(4));
  mux_783_nl <= MUX_s_1_2_2(or_730_cse, or_tmp_9, fsm_output(8));
  mux_784_nl <= MUX_s_1_2_2((NOT nor_tmp_13), mux_783_nl, fsm_output(6));
  mux_781_nl <= MUX_s_1_2_2(or_tmp_9, (NOT (fsm_output(7))), fsm_output(8));
  mux_782_nl <= MUX_s_1_2_2(mux_781_nl, or_90_cse, fsm_output(6));
  mux_785_nl <= MUX_s_1_2_2(mux_784_nl, mux_782_nl, fsm_output(1));
  mux_786_nl <= MUX_s_1_2_2(mux_785_nl, mux_tmp_777, fsm_output(2));
  mux_787_nl <= MUX_s_1_2_2(mux_786_nl, mux_tmp_164, fsm_output(5));
  or_728_nl <= (fsm_output(0)) OR (NOT (fsm_output(7)));
  mux_775_nl <= MUX_s_1_2_2((fsm_output(7)), or_728_nl, fsm_output(8));
  mux_776_nl <= MUX_s_1_2_2(mux_775_nl, or_90_cse, fsm_output(6));
  mux_778_nl <= MUX_s_1_2_2(mux_tmp_777, mux_776_nl, fsm_output(1));
  or_727_nl <= (fsm_output(6)) OR or_tmp_679;
  mux_774_nl <= MUX_s_1_2_2(or_727_nl, mux_tmp_760, fsm_output(1));
  mux_779_nl <= MUX_s_1_2_2(mux_778_nl, mux_774_nl, fsm_output(2));
  mux_780_nl <= MUX_s_1_2_2(mux_779_nl, (NOT mux_tmp_773), fsm_output(5));
  mux_788_nl <= MUX_s_1_2_2(mux_787_nl, mux_780_nl, fsm_output(4));
  mux_801_nl <= MUX_s_1_2_2(mux_800_nl, mux_788_nl, fsm_output(3));
  or_726_nl <= (NOT((NOT (fsm_output(6))) OR (fsm_output(8)))) OR (fsm_output(7));
  mux_766_nl <= MUX_s_1_2_2((fsm_output(7)), or_tmp_682, fsm_output(6));
  mux_767_nl <= MUX_s_1_2_2(or_726_nl, mux_766_nl, fsm_output(1));
  mux_764_nl <= MUX_s_1_2_2(or_tmp_677, or_tmp_681, fsm_output(6));
  mux_763_nl <= MUX_s_1_2_2(or_tmp_681, or_91_cse, fsm_output(6));
  mux_765_nl <= MUX_s_1_2_2(mux_764_nl, mux_763_nl, fsm_output(1));
  mux_768_nl <= MUX_s_1_2_2(mux_767_nl, mux_765_nl, fsm_output(2));
  mux_769_nl <= MUX_s_1_2_2(mux_768_nl, or_tmp_672, fsm_output(5));
  mux_761_nl <= MUX_s_1_2_2(mux_tmp_760, mux_tmp_164, or_722_cse);
  mux_762_nl <= MUX_s_1_2_2(or_91_cse, mux_761_nl, fsm_output(5));
  mux_770_nl <= MUX_s_1_2_2(mux_769_nl, mux_762_nl, fsm_output(4));
  mux_756_nl <= MUX_s_1_2_2(or_tmp_679, or_tmp_677, fsm_output(6));
  mux_757_nl <= MUX_s_1_2_2(or_tmp_672, mux_756_nl, and_316_cse);
  mux_758_nl <= MUX_s_1_2_2(or_91_cse, mux_757_nl, fsm_output(5));
  mux_752_nl <= MUX_s_1_2_2(or_91_cse, or_718_cse, fsm_output(6));
  or_716_nl <= (NOT (fsm_output(6))) OR (NOT (fsm_output(0))) OR (fsm_output(7));
  mux_753_nl <= MUX_s_1_2_2(mux_752_nl, or_716_nl, fsm_output(1));
  or_715_nl <= (fsm_output(8)) OR (NOT (fsm_output(0))) OR (fsm_output(7));
  mux_750_nl <= MUX_s_1_2_2(or_715_nl, (fsm_output(7)), fsm_output(6));
  mux_751_nl <= MUX_s_1_2_2(mux_750_nl, or_tmp_672, fsm_output(1));
  mux_754_nl <= MUX_s_1_2_2(mux_753_nl, mux_751_nl, fsm_output(2));
  mux_755_nl <= MUX_s_1_2_2(mux_754_nl, mux_tmp_164, fsm_output(5));
  mux_759_nl <= MUX_s_1_2_2(mux_758_nl, mux_755_nl, fsm_output(4));
  mux_771_nl <= MUX_s_1_2_2(mux_770_nl, mux_759_nl, fsm_output(3));
  mux_802_nl <= MUX_s_1_2_2(mux_801_nl, mux_771_nl, fsm_output(9));
  mux_842_nl <= MUX_s_1_2_2(or_831_cse, (NOT (fsm_output(8))), fsm_output(7));
  mux_843_nl <= MUX_s_1_2_2(mux_842_nl, or_tmp_73, fsm_output(6));
  mux_841_nl <= MUX_s_1_2_2(or_831_cse, or_tmp_73, fsm_output(6));
  mux_844_nl <= MUX_s_1_2_2(mux_843_nl, mux_841_nl, fsm_output(1));
  or_754_nl <= (NOT (fsm_output(7))) OR (fsm_output(0)) OR (NOT (fsm_output(9)))
      OR (fsm_output(8));
  mux_839_nl <= MUX_s_1_2_2(nand_244_cse, or_754_nl, fsm_output(6));
  or_753_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("011"));
  mux_838_nl <= MUX_s_1_2_2(mux_tmp_833, or_753_nl, fsm_output(6));
  mux_840_nl <= MUX_s_1_2_2(mux_839_nl, mux_838_nl, fsm_output(1));
  mux_845_nl <= MUX_s_1_2_2(mux_844_nl, mux_840_nl, fsm_output(2));
  mux_846_nl <= MUX_s_1_2_2(mux_845_nl, mux_tmp_823, fsm_output(5));
  or_751_nl <= and_312_cse OR (fsm_output(8));
  mux_834_nl <= MUX_s_1_2_2(or_751_nl, mux_tmp_833, fsm_output(6));
  or_748_nl <= (NOT(nor_400_cse OR (fsm_output(9)))) OR (fsm_output(8));
  mux_832_nl <= MUX_s_1_2_2(or_748_nl, mux_417_cse, fsm_output(6));
  mux_835_nl <= MUX_s_1_2_2(mux_834_nl, mux_832_nl, fsm_output(1));
  mux_836_nl <= MUX_s_1_2_2(mux_835_nl, mux_438_cse, fsm_output(2));
  mux_837_nl <= MUX_s_1_2_2(mux_tmp_825, mux_836_nl, fsm_output(5));
  mux_847_nl <= MUX_s_1_2_2(mux_846_nl, mux_837_nl, fsm_output(4));
  or_745_nl <= nor_401_cse OR (fsm_output(8));
  mux_826_nl <= MUX_s_1_2_2(or_745_nl, or_831_cse, fsm_output(7));
  mux_828_nl <= MUX_s_1_2_2(mux_417_cse, mux_826_nl, fsm_output(6));
  mux_829_nl <= MUX_s_1_2_2(mux_828_nl, mux_tmp_825, or_722_cse);
  mux_820_nl <= MUX_s_1_2_2(not_tmp_276, or_1483_cse, or_730_cse);
  mux_821_nl <= MUX_s_1_2_2(mux_820_nl, nand_244_cse, fsm_output(6));
  mux_824_nl <= MUX_s_1_2_2(mux_tmp_823, mux_821_nl, and_316_cse);
  mux_830_nl <= MUX_s_1_2_2(mux_829_nl, mux_824_nl, fsm_output(5));
  mux_815_nl <= MUX_s_1_2_2(or_831_cse, or_1483_cse, fsm_output(7));
  mux_816_nl <= MUX_s_1_2_2(mux_815_nl, mux_tmp_814, fsm_output(6));
  mux_812_nl <= MUX_s_1_2_2(or_831_cse, (fsm_output(8)), fsm_output(7));
  or_740_nl <= (fsm_output(7)) OR ((fsm_output(0)) AND (fsm_output(9))) OR (fsm_output(8));
  mux_813_nl <= MUX_s_1_2_2(mux_812_nl, or_740_nl, fsm_output(6));
  mux_817_nl <= MUX_s_1_2_2(mux_816_nl, mux_813_nl, fsm_output(1));
  nand_127_nl <= NOT(or_1275_cse AND (fsm_output(8)));
  mux_809_nl <= MUX_s_1_2_2(nand_127_nl, or_tmp_73, fsm_output(7));
  mux_808_nl <= MUX_s_1_2_2((fsm_output(9)), or_831_cse, fsm_output(0));
  or_737_nl <= (fsm_output(7)) OR mux_808_nl;
  mux_810_nl <= MUX_s_1_2_2(mux_809_nl, or_737_nl, fsm_output(6));
  mux_806_nl <= MUX_s_1_2_2(not_tmp_276, or_tmp_73, fsm_output(7));
  mux_807_nl <= MUX_s_1_2_2(mux_806_nl, or_831_cse, fsm_output(6));
  mux_811_nl <= MUX_s_1_2_2(mux_810_nl, mux_807_nl, fsm_output(1));
  mux_818_nl <= MUX_s_1_2_2(mux_817_nl, mux_811_nl, fsm_output(2));
  mux_819_nl <= MUX_s_1_2_2(mux_818_nl, mux_438_cse, fsm_output(5));
  mux_831_nl <= MUX_s_1_2_2(mux_830_nl, mux_819_nl, fsm_output(4));
  mux_848_nl <= MUX_s_1_2_2(mux_847_nl, mux_831_nl, fsm_output(3));
  nor_377_nl <= NOT((NOT (fsm_output(4))) OR (NOT (fsm_output(9))) OR (fsm_output(6)));
  nor_378_nl <= NOT(nor_379_cse OR (fsm_output(9)) OR (NOT (fsm_output(6))));
  mux_875_nl <= MUX_s_1_2_2(nor_378_nl, mux_tmp_865, fsm_output(1));
  mux_876_nl <= MUX_s_1_2_2(mux_875_nl, mux_tmp_860, fsm_output(2));
  mux_877_nl <= MUX_s_1_2_2(nor_377_nl, mux_876_nl, fsm_output(5));
  or_789_nl <= (NOT (fsm_output(9))) OR (fsm_output(6));
  mux_872_nl <= MUX_s_1_2_2(or_789_nl, or_tmp_737, fsm_output(4));
  or_788_nl <= (NOT (fsm_output(4))) OR (fsm_output(9)) OR (NOT (fsm_output(6)));
  mux_873_nl <= MUX_s_1_2_2(mux_872_nl, or_788_nl, and_316_cse);
  mux_874_nl <= MUX_s_1_2_2(mux_873_nl, or_tmp_738, fsm_output(5));
  mux_878_nl <= MUX_s_1_2_2(mux_877_nl, (NOT mux_874_nl), fsm_output(7));
  nor_380_nl <= NOT((NOT((fsm_output(1)) OR (fsm_output(0)) OR (fsm_output(4))))
      OR (NOT (fsm_output(9))) OR (fsm_output(6)));
  nor_382_nl <= NOT((fsm_output(4)) OR (NOT (fsm_output(9))) OR (fsm_output(6)));
  mux_869_nl <= MUX_s_1_2_2(nor_380_nl, nor_382_nl, fsm_output(2));
  mux_870_nl <= MUX_s_1_2_2(mux_869_nl, mux_tmp_860, fsm_output(5));
  nor_383_nl <= NOT((NOT(and_303_cse OR (fsm_output(4)))) OR (fsm_output(9)) OR (NOT
      (fsm_output(6))));
  mux_866_nl <= MUX_s_1_2_2(mux_tmp_865, mux_tmp_860, fsm_output(1));
  mux_867_nl <= MUX_s_1_2_2(nor_383_nl, mux_866_nl, fsm_output(2));
  mux_868_nl <= MUX_s_1_2_2(mux_867_nl, (NOT or_tmp_738), fsm_output(5));
  mux_871_nl <= MUX_s_1_2_2(mux_870_nl, mux_868_nl, fsm_output(7));
  mux_879_nl <= MUX_s_1_2_2(mux_878_nl, mux_871_nl, fsm_output(3));
  and_304_nl <= ((NOT (fsm_output(4))) OR (fsm_output(9))) AND (fsm_output(6));
  and_305_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  mux_861_nl <= MUX_s_1_2_2(mux_tmp_860, and_304_nl, and_305_nl);
  and_306_nl <= (fsm_output(2)) AND (NOT((NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))))
      OR (NOT (fsm_output(4))) OR (fsm_output(9)) OR (fsm_output(6))));
  mux_862_nl <= MUX_s_1_2_2(mux_861_nl, and_306_nl, fsm_output(5));
  and_307_nl <= (fsm_output(5)) AND (NOT((or_722_cse AND (fsm_output(4))) OR (fsm_output(9))
      OR (fsm_output(6))));
  mux_863_nl <= MUX_s_1_2_2(mux_862_nl, and_307_nl, fsm_output(7));
  and_446_nl <= (NOT(or_722_cse AND (fsm_output(4)))) AND and_434_cse;
  nor_389_nl <= NOT((NOT (fsm_output(4))) OR (fsm_output(9)) OR (fsm_output(6)));
  mux_858_nl <= MUX_s_1_2_2(and_446_nl, nor_389_nl, fsm_output(5));
  nor_390_nl <= NOT((NOT (fsm_output(2))) OR (NOT (fsm_output(1))) OR (NOT (fsm_output(0)))
      OR (NOT (fsm_output(4))) OR (fsm_output(9)) OR (fsm_output(6)));
  nor_391_nl <= NOT((fsm_output(4)) OR (fsm_output(9)) OR (fsm_output(6)));
  mux_857_nl <= MUX_s_1_2_2(nor_390_nl, nor_391_nl, fsm_output(5));
  mux_859_nl <= MUX_s_1_2_2(mux_858_nl, mux_857_nl, fsm_output(7));
  mux_864_nl <= MUX_s_1_2_2(mux_863_nl, mux_859_nl, fsm_output(3));
  mux_880_nl <= MUX_s_1_2_2(mux_879_nl, mux_864_nl, fsm_output(8));
  operator_64_false_1_or_2_nl <= and_dcpl_71 OR and_dcpl_126;
  or_1066_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR or_tmp_63;
  mux_1204_nl <= MUX_s_1_2_2(or_1066_nl, mux_tmp_1203, fsm_output(7));
  mux_1205_nl <= MUX_s_1_2_2(mux_1204_nl, mux_tmp_1187, fsm_output(1));
  mux_1210_nl <= MUX_s_1_2_2(mux_1209_itm, (NOT mux_1205_nl), fsm_output(8));
  mux_1200_nl <= MUX_s_1_2_2((NOT mux_tmp_1199), or_tmp_970, fsm_output(7));
  mux_1201_nl <= MUX_s_1_2_2(mux_1200_nl, mux_tmp_1179, fsm_output(1));
  or_1064_nl <= (fsm_output(7)) OR ((fsm_output(6)) AND or_tmp_60);
  mux_1198_nl <= MUX_s_1_2_2(or_1064_nl, or_tmp_993, fsm_output(1));
  mux_1202_nl <= MUX_s_1_2_2((NOT mux_1201_nl), mux_1198_nl, fsm_output(8));
  mux_1211_nl <= MUX_s_1_2_2(mux_1210_nl, mux_1202_nl, fsm_output(9));
  or_1063_nl <= (fsm_output(5)) OR and_dcpl_81;
  mux_1193_nl <= MUX_s_1_2_2((NOT and_tmp_2), or_1063_nl, fsm_output(6));
  mux_1194_nl <= MUX_s_1_2_2(mux_1193_nl, mux_tmp_1192, fsm_output(7));
  mux_1195_nl <= MUX_s_1_2_2(mux_1194_nl, mux_tmp_1191, fsm_output(1));
  mux_1183_nl <= MUX_s_1_2_2(or_217_cse, mux_tmp_1182, fsm_output(7));
  mux_1188_nl <= MUX_s_1_2_2(mux_tmp_1187, mux_1183_nl, fsm_output(1));
  mux_1196_nl <= MUX_s_1_2_2(mux_1195_nl, (NOT mux_1188_nl), fsm_output(8));
  nor_318_nl <= NOT((fsm_output(6)) OR and_292_cse);
  mux_1176_nl <= MUX_s_1_2_2(mux_tmp_1175, nor_318_nl, fsm_output(7));
  mux_1180_nl <= MUX_s_1_2_2((NOT mux_tmp_1179), mux_1176_nl, fsm_output(1));
  mux_1173_nl <= MUX_s_1_2_2(or_tmp_993, or_857_cse, fsm_output(1));
  mux_1181_nl <= MUX_s_1_2_2(mux_1180_nl, mux_1173_nl, fsm_output(8));
  mux_1197_nl <= MUX_s_1_2_2(mux_1196_nl, mux_1181_nl, fsm_output(9));
  mux_1212_nl <= MUX_s_1_2_2(mux_1211_nl, mux_1197_nl, fsm_output(0));
  operator_64_false_1_mux1h_nl <= MUX1HOT_s_1_4_2((z_out_3(6)), modExp_exp_1_0_1_sva_1,
      COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm, (z_out_3(7)), STD_LOGIC_VECTOR'( operator_64_false_1_or_2_nl
      & and_dcpl_174 & (NOT mux_1212_nl) & and_dcpl_98));
  or_964_nl <= (fsm_output(9)) OR not_tmp_375;
  or_1052_nl <= (NOT (fsm_output(9))) OR (fsm_output(2)) OR (NOT (fsm_output(4)));
  mux_1170_nl <= MUX_s_1_2_2(or_964_nl, or_1052_nl, fsm_output(7));
  or_1401_nl <= (NOT (fsm_output(5))) OR (fsm_output(8)) OR (fsm_output(6)) OR mux_1170_nl;
  nor_320_nl <= NOT((fsm_output(7)) OR (fsm_output(9)) OR (fsm_output(2)) OR (fsm_output(4)));
  nor_321_nl <= NOT((NOT (fsm_output(7))) OR (fsm_output(9)) OR not_tmp_375);
  mux_1169_nl <= MUX_s_1_2_2(nor_320_nl, nor_321_nl, fsm_output(6));
  nand_243_nl <= NOT((NOT((fsm_output(5)) OR (NOT (fsm_output(8))))) AND mux_1169_nl);
  mux_1171_nl <= MUX_s_1_2_2(or_1401_nl, nand_243_nl, fsm_output(3));
  nor_314_nl <= NOT((NOT (fsm_output(2))) OR (fsm_output(8)) OR (NOT (fsm_output(9)))
      OR (fsm_output(7)) OR (fsm_output(5)));
  nor_315_nl <= NOT((fsm_output(2)) OR (NOT (fsm_output(8))) OR (fsm_output(9)) OR
      (fsm_output(7)) OR (NOT (fsm_output(5))));
  mux_1214_nl <= MUX_s_1_2_2(nor_314_nl, nor_315_nl, fsm_output(4));
  and_267_nl <= (fsm_output(6)) AND mux_1214_nl;
  nor_316_nl <= NOT((NOT (fsm_output(8))) OR (NOT (fsm_output(9))) OR (fsm_output(7))
      OR (fsm_output(5)));
  nor_317_nl <= NOT((fsm_output(8)) OR (fsm_output(9)) OR (NOT (fsm_output(7))) OR
      (fsm_output(5)));
  mux_1213_nl <= MUX_s_1_2_2(nor_316_nl, nor_317_nl, fsm_output(2));
  and_268_nl <= (NOT((fsm_output(6)) OR (NOT (fsm_output(4))))) AND mux_1213_nl;
  mux_1215_nl <= MUX_s_1_2_2(and_267_nl, and_268_nl, fsm_output(3));
  nand_109_nl <= NOT((NOT (fsm_output(1))) AND (fsm_output(6)) AND (fsm_output(9))
      AND (fsm_output(4)) AND (fsm_output(3)) AND (fsm_output(7)) AND (NOT (fsm_output(5))));
  or_1103_nl <= (fsm_output(6)) OR (fsm_output(9)) OR (NOT (fsm_output(4))) OR (fsm_output(3))
      OR (fsm_output(7)) OR (NOT (fsm_output(5)));
  or_1101_nl <= (fsm_output(9)) OR (NOT (fsm_output(4))) OR (NOT (fsm_output(3)))
      OR (NOT (fsm_output(7))) OR (fsm_output(5));
  mux_1260_nl <= MUX_s_1_2_2(or_1101_nl, or_tmp_1034, fsm_output(6));
  mux_1261_nl <= MUX_s_1_2_2(or_1103_nl, mux_1260_nl, fsm_output(1));
  mux_1262_nl <= MUX_s_1_2_2(nand_109_nl, mux_1261_nl, fsm_output(8));
  or_1098_nl <= (fsm_output(9)) OR (NOT (fsm_output(4))) OR (NOT (fsm_output(3)))
      OR (fsm_output(7)) OR (fsm_output(5));
  mux_1258_nl <= MUX_s_1_2_2(or_tmp_1034, or_1098_nl, fsm_output(6));
  mux_1259_nl <= MUX_s_1_2_2(mux_1258_nl, nand_82_cse, fsm_output(1));
  or_1100_nl <= (fsm_output(8)) OR mux_1259_nl;
  mux_1263_nl <= MUX_s_1_2_2(mux_1262_nl, or_1100_nl, fsm_output(2));
  and_222_nl <= (NOT mux_1263_nl) AND (fsm_output(0));
  COMP_LOOP_mux_42_nl <= MUX_s_1_2_2(modExp_exp_1_0_1_sva_1, modExp_exp_1_1_1_sva,
      and_222_nl);
  or_1078_nl <= (NOT (fsm_output(9))) OR (NOT (fsm_output(6))) OR (NOT (fsm_output(1)))
      OR (fsm_output(8)) OR (fsm_output(5));
  or_1077_nl <= (fsm_output(9)) OR (fsm_output(6)) OR (fsm_output(1)) OR (fsm_output(8))
      OR (NOT (fsm_output(5)));
  mux_1217_nl <= MUX_s_1_2_2(or_1078_nl, or_1077_nl, fsm_output(4));
  nor_312_nl <= NOT((fsm_output(7)) OR mux_1217_nl);
  or_1074_nl <= (NOT (fsm_output(1))) OR (fsm_output(8)) OR (fsm_output(5));
  or_1073_nl <= (fsm_output(1)) OR (NOT (fsm_output(8))) OR (fsm_output(5));
  mux_1216_nl <= MUX_s_1_2_2(or_1074_nl, or_1073_nl, fsm_output(6));
  nor_313_nl <= NOT((NOT (fsm_output(7))) OR (NOT (fsm_output(4))) OR (fsm_output(9))
      OR mux_1216_nl);
  mux_1218_nl <= MUX_s_1_2_2(nor_312_nl, nor_313_nl, fsm_output(3));
  nor_305_nl <= NOT((NOT (fsm_output(5))) OR (NOT (fsm_output(1))) OR (fsm_output(9))
      OR (NOT((fsm_output(6)) AND (fsm_output(4)))));
  or_1109_nl <= (fsm_output(9)) OR (fsm_output(6)) OR (fsm_output(4));
  or_1108_nl <= (NOT (fsm_output(9))) OR (fsm_output(6)) OR (NOT (fsm_output(4)));
  mux_1264_nl <= MUX_s_1_2_2(or_1109_nl, or_1108_nl, fsm_output(1));
  nor_306_nl <= NOT((fsm_output(5)) OR mux_1264_nl);
  mux_1265_nl <= MUX_s_1_2_2(nor_305_nl, nor_306_nl, fsm_output(3));
  nand_242_nl <= NOT((fsm_output(8)) AND mux_1265_nl);
  or_1400_nl <= (fsm_output(8)) OR (fsm_output(3)) OR (NOT (fsm_output(5))) OR (fsm_output(1))
      OR (NOT (fsm_output(9))) OR (fsm_output(6)) OR (NOT (fsm_output(4)));
  mux_1266_nl <= MUX_s_1_2_2(nand_242_nl, or_1400_nl, fsm_output(7));
  COMP_LOOP_mux1h_32_nl <= MUX1HOT_s_1_4_2((COMP_LOOP_k_9_3_sva_5_0(4)), modExp_exp_1_1_1_sva,
      modExp_exp_1_7_1_sva, (COMP_LOOP_k_9_3_sva_5_0(5)), STD_LOGIC_VECTOR'( and_dcpl_191
      & and_dcpl_177 & (NOT mux_1289_itm) & and_dcpl_192));
  and_259_nl <= (NOT (fsm_output(1))) AND (fsm_output(6)) AND (fsm_output(9)) AND
      (fsm_output(4)) AND (fsm_output(3)) AND (fsm_output(7)) AND (NOT (fsm_output(5)));
  nor_299_nl <= NOT((fsm_output(6)) OR (fsm_output(9)) OR (NOT (fsm_output(4))) OR
      (fsm_output(3)) OR (fsm_output(7)) OR (NOT (fsm_output(5))));
  nor_300_nl <= NOT((fsm_output(9)) OR (NOT (fsm_output(4))) OR (NOT (fsm_output(3)))
      OR (NOT (fsm_output(7))) OR (fsm_output(5)));
  nor_301_nl <= NOT((NOT (fsm_output(9))) OR (fsm_output(4)) OR (fsm_output(3)) OR
      (fsm_output(7)) OR (fsm_output(5)));
  mux_1292_nl <= MUX_s_1_2_2(nor_300_nl, nor_301_nl, fsm_output(6));
  mux_1293_nl <= MUX_s_1_2_2(nor_299_nl, mux_1292_nl, fsm_output(1));
  mux_1294_nl <= MUX_s_1_2_2(and_259_nl, mux_1293_nl, fsm_output(8));
  or_1119_nl <= (fsm_output(6)) OR (NOT (fsm_output(9))) OR (fsm_output(4)) OR (fsm_output(3))
      OR (fsm_output(7)) OR (fsm_output(5));
  mux_1291_nl <= MUX_s_1_2_2(or_1119_nl, nand_82_cse, fsm_output(1));
  nor_302_nl <= NOT((fsm_output(8)) OR mux_1291_nl);
  mux_1295_nl <= MUX_s_1_2_2(mux_1294_nl, nor_302_nl, fsm_output(2));
  COMP_LOOP_mux1h_46_nl <= MUX1HOT_s_1_3_2(modExp_exp_1_3_1_sva, modExp_exp_1_2_1_sva,
      (COMP_LOOP_k_9_3_sva_5_0(0)), STD_LOGIC_VECTOR'( and_dcpl_194 & (NOT mux_1289_itm)
      & and_dcpl_192));
  mux_1303_nl <= MUX_s_1_2_2(not_tmp_414, or_tmp_966, fsm_output(6));
  mux_1304_nl <= MUX_s_1_2_2(mux_1303_nl, mux_tmp_1192, fsm_output(7));
  mux_1305_nl <= MUX_s_1_2_2(mux_1304_nl, mux_tmp_1191, fsm_output(1));
  mux_1306_nl <= MUX_s_1_2_2(mux_1305_nl, (NOT mux_tmp_1277), fsm_output(8));
  mux_1307_nl <= MUX_s_1_2_2(mux_1306_nl, mux_tmp_1272, fsm_output(9));
  mux_1308_nl <= MUX_s_1_2_2(mux_tmp_1288, mux_1307_nl, fsm_output(0));
  COMP_LOOP_mux1h_48_nl <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_3_sva_5_0(5)), modExp_exp_1_2_1_sva,
      modExp_exp_1_1_1_sva, STD_LOGIC_VECTOR'( and_dcpl_191 & and_dcpl_194 & (NOT
      mux_1308_nl)));
  nor_296_nl <= NOT((NOT (fsm_output(5))) OR (fsm_output(7)) OR (NOT (fsm_output(6)))
      OR (fsm_output(0)) OR not_tmp_458);
  nor_297_nl <= NOT((fsm_output(5)) OR (fsm_output(7)) OR (fsm_output(6)) OR (fsm_output(0))
      OR (fsm_output(1)) OR (fsm_output(4)));
  mux_1310_nl <= MUX_s_1_2_2(nor_296_nl, nor_297_nl, fsm_output(3));
  nand_192_nl <= NOT((fsm_output(8)) AND mux_1310_nl);
  nand_106_nl <= NOT((fsm_output(6)) AND (fsm_output(0)) AND (NOT (fsm_output(1)))
      AND (fsm_output(4)));
  or_1140_nl <= (fsm_output(6)) OR (fsm_output(0)) OR not_tmp_458;
  mux_1309_nl <= MUX_s_1_2_2(nand_106_nl, or_1140_nl, fsm_output(7));
  or_1300_nl <= (fsm_output(8)) OR (NOT (fsm_output(3))) OR (fsm_output(5)) OR mux_1309_nl;
  mux_1311_nl <= MUX_s_1_2_2(nand_192_nl, or_1300_nl, fsm_output(2));
  or_1154_nl <= (NOT (fsm_output(1))) OR (fsm_output(7)) OR (NOT (fsm_output(9)))
      OR (fsm_output(4)) OR (NOT((fsm_output(2)) AND (fsm_output(6))));
  or_1152_nl <= (fsm_output(1)) OR (NOT (fsm_output(7))) OR (NOT (fsm_output(9)))
      OR (NOT (fsm_output(4))) OR (fsm_output(2)) OR (fsm_output(6));
  mux_1313_nl <= MUX_s_1_2_2(or_1154_nl, or_1152_nl, fsm_output(5));
  or_1308_nl <= (fsm_output(8)) OR mux_1313_nl;
  or_1150_nl <= (NOT (fsm_output(7))) OR (fsm_output(9)) OR (NOT((fsm_output(4))
      AND (fsm_output(2)) AND (fsm_output(6))));
  or_1148_nl <= (fsm_output(7)) OR (NOT (fsm_output(9))) OR (NOT (fsm_output(4)))
      OR (fsm_output(2)) OR (fsm_output(6));
  mux_1312_nl <= MUX_s_1_2_2(or_1150_nl, or_1148_nl, fsm_output(1));
  or_1309_nl <= (NOT (fsm_output(8))) OR (fsm_output(5)) OR mux_1312_nl;
  mux_1314_nl <= MUX_s_1_2_2(or_1308_nl, or_1309_nl, fsm_output(3));
  and_54_nl <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("11")) AND or_5_cse;
  mux_444_nl <= MUX_s_1_2_2(not_tmp_129, and_54_nl, fsm_output(9));
  nor_815_nl <= NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01")));
  mux_1487_nl <= MUX_s_1_2_2(mux_tmp_898, and_312_cse, nor_815_nl);
  mux_1488_nl <= MUX_s_1_2_2(mux_1487_nl, mux_tmp_1456, fsm_output(8));
  mux_1489_nl <= MUX_s_1_2_2(mux_1488_nl, mux_tmp_900, fsm_output(6));
  mux_1484_nl <= MUX_s_1_2_2(mux_tmp_898, (NOT mux_936_cse), fsm_output(1));
  mux_1485_nl <= MUX_s_1_2_2(mux_1484_nl, or_tmp_72, fsm_output(8));
  nor_835_nl <= NOT((fsm_output(1)) OR (NOT (fsm_output(9))) OR (fsm_output(7)));
  or_1473_nl <= (fsm_output(1)) OR mux_1001_cse;
  mux_1483_nl <= MUX_s_1_2_2(nor_835_nl, or_1473_nl, fsm_output(8));
  mux_1486_nl <= MUX_s_1_2_2(mux_1485_nl, mux_1483_nl, fsm_output(6));
  mux_1490_nl <= MUX_s_1_2_2(mux_1489_nl, mux_1486_nl, fsm_output(2));
  mux_1478_nl <= MUX_s_1_2_2(and_312_cse, mux_tmp_898, fsm_output(1));
  mux_1479_nl <= MUX_s_1_2_2((NOT mux_1478_nl), (fsm_output(9)), fsm_output(8));
  nor_836_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(9)) OR (NOT (fsm_output(7))));
  mux_1477_nl <= MUX_s_1_2_2(nor_836_nl, or_tmp_783, fsm_output(8));
  mux_1480_nl <= MUX_s_1_2_2(mux_1479_nl, mux_1477_nl, fsm_output(6));
  mux_1481_nl <= MUX_s_1_2_2(mux_1480_nl, mux_928_cse, fsm_output(2));
  mux_1491_nl <= MUX_s_1_2_2(mux_1490_nl, mux_1481_nl, fsm_output(3));
  mux_1470_nl <= MUX_s_1_2_2((NOT mux_tmp_898), or_tmp_783, or_1470_cse);
  mux_1469_nl <= MUX_s_1_2_2((fsm_output(9)), and_312_cse, fsm_output(1));
  mux_1471_nl <= MUX_s_1_2_2(mux_1470_nl, mux_1469_nl, fsm_output(8));
  mux_1467_nl <= MUX_s_1_2_2(or_tmp_783, or_823_cse, fsm_output(1));
  mux_1468_nl <= MUX_s_1_2_2((NOT or_tmp_72), mux_1467_nl, fsm_output(8));
  mux_1472_nl <= MUX_s_1_2_2(mux_1471_nl, mux_1468_nl, fsm_output(6));
  mux_1464_nl <= MUX_s_1_2_2(or_823_cse, mux_tmp_898, fsm_output(1));
  and_720_nl <= ((fsm_output(1)) OR (fsm_output(9))) AND (fsm_output(7));
  mux_1465_nl <= MUX_s_1_2_2(mux_1464_nl, and_720_nl, fsm_output(8));
  mux_1463_nl <= MUX_s_1_2_2(nor_tmp_273, mux_tmp_898, fsm_output(8));
  mux_1466_nl <= MUX_s_1_2_2(mux_1465_nl, mux_1463_nl, fsm_output(6));
  mux_1473_nl <= MUX_s_1_2_2(mux_1472_nl, mux_1466_nl, fsm_output(2));
  mux_1476_nl <= MUX_s_1_2_2(mux_928_cse, mux_1473_nl, fsm_output(3));
  mux_1492_nl <= MUX_s_1_2_2(mux_1491_nl, mux_1476_nl, fsm_output(4));
  mux_1458_nl <= MUX_s_1_2_2(mux_tmp_1456, (fsm_output(7)), fsm_output(8));
  mux_1455_nl <= MUX_s_1_2_2(mux_tmp_898, or_tmp_72, or_1470_cse);
  mux_1456_nl <= MUX_s_1_2_2(mux_tmp_898, mux_1455_nl, fsm_output(8));
  mux_1459_nl <= MUX_s_1_2_2(mux_1458_nl, mux_1456_nl, fsm_output(6));
  mux_1461_nl <= MUX_s_1_2_2(mux_1460_cse, mux_1459_nl, and_721_cse);
  mux_1452_nl <= MUX_s_1_2_2((NOT (fsm_output(7))), nor_tmp_273, fsm_output(8));
  mux_1450_nl <= MUX_s_1_2_2(mux_936_cse, and_312_cse, fsm_output(1));
  mux_1448_nl <= MUX_s_1_2_2(or_tmp_72, (fsm_output(9)), fsm_output(1));
  mux_1451_nl <= MUX_s_1_2_2((NOT mux_1450_nl), mux_1448_nl, fsm_output(8));
  mux_1453_nl <= MUX_s_1_2_2(mux_1452_nl, mux_1451_nl, fsm_output(6));
  mux_1454_nl <= MUX_s_1_2_2(mux_1453_nl, mux_1447_cse, or_1516_cse);
  mux_1462_nl <= MUX_s_1_2_2(mux_1461_nl, mux_1454_nl, fsm_output(4));
  mux_1493_nl <= MUX_s_1_2_2(mux_1492_nl, mux_1462_nl, fsm_output(5));
  nor_828_nl <= NOT((fsm_output(6)) OR (fsm_output(8)) OR (NOT (fsm_output(0))) OR
      (fsm_output(9)));
  and_715_nl <= (fsm_output(6)) AND COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm AND (fsm_output(8))
      AND (fsm_output(0)) AND (fsm_output(9));
  mux_1515_nl <= MUX_s_1_2_2(nor_828_nl, and_715_nl, fsm_output(1));
  nor_829_nl <= NOT((fsm_output(6)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR (fsm_output(8)) OR not_tmp_621);
  nor_830_nl <= NOT((NOT (fsm_output(6))) OR (fsm_output(8)) OR (fsm_output(0)) OR
      (NOT (fsm_output(9))));
  mux_1514_nl <= MUX_s_1_2_2(nor_829_nl, nor_830_nl, fsm_output(1));
  mux_1516_nl <= MUX_s_1_2_2(mux_1515_nl, mux_1514_nl, fsm_output(2));
  or_1504_nl <= (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (fsm_output(8)) OR
      (NOT (fsm_output(0))) OR (fsm_output(9));
  mux_1513_nl <= MUX_s_1_2_2(or_tmp_1267, or_1504_nl, fsm_output(6));
  and_716_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11")) AND (NOT
      mux_1513_nl);
  mux_1517_nl <= MUX_s_1_2_2(mux_1516_nl, and_716_nl, fsm_output(7));
  mux_1509_nl <= MUX_s_1_2_2((NOT (fsm_output(9))), (fsm_output(9)), fsm_output(0));
  mux_1510_nl <= MUX_s_1_2_2(mux_1509_nl, or_tmp_1262, fsm_output(8));
  and_717_nl <= (fsm_output(6)) AND COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm;
  mux_1511_nl <= MUX_s_1_2_2(or_750_cse, mux_1510_nl, and_717_nl);
  or_1502_nl <= (fsm_output(6)) OR or_tmp_1269;
  mux_1512_nl <= MUX_s_1_2_2(mux_1511_nl, or_1502_nl, fsm_output(1));
  nor_831_nl <= NOT((fsm_output(7)) OR (fsm_output(2)) OR mux_1512_nl);
  mux_1518_nl <= MUX_s_1_2_2(mux_1517_nl, nor_831_nl, fsm_output(3));
  nand_268_nl <= NOT((fsm_output(1)) AND (fsm_output(8)) AND (NOT (fsm_output(0)))
      AND (fsm_output(9)));
  or_1498_nl <= (fsm_output(1)) OR (fsm_output(6)) OR nor_820_cse OR (fsm_output(0))
      OR (NOT (fsm_output(9)));
  mux_1507_nl <= MUX_s_1_2_2(nand_268_nl, or_1498_nl, fsm_output(2));
  or_1494_nl <= (NOT (fsm_output(6))) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm)
      OR (fsm_output(8)) OR not_tmp_621;
  mux_1505_nl <= MUX_s_1_2_2(or_1494_nl, or_tmp_1274, fsm_output(1));
  or_1492_nl <= ((NOT((fsm_output(6)) AND COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm))
      AND (fsm_output(8))) OR (fsm_output(0)) OR (fsm_output(9));
  mux_1504_nl <= MUX_s_1_2_2(or_tmp_1273, or_1492_nl, fsm_output(1));
  mux_1506_nl <= MUX_s_1_2_2(mux_1505_nl, mux_1504_nl, fsm_output(2));
  mux_1508_nl <= MUX_s_1_2_2(mux_1507_nl, mux_1506_nl, fsm_output(7));
  and_718_nl <= (fsm_output(3)) AND (NOT mux_1508_nl);
  mux_1519_nl <= MUX_s_1_2_2(mux_1518_nl, and_718_nl, fsm_output(4));
  nor_832_nl <= NOT((NOT (fsm_output(7))) OR (fsm_output(2)) OR (fsm_output(1)) OR
      (fsm_output(6)) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (fsm_output(8))
      OR (fsm_output(0)) OR (fsm_output(9)));
  nor_833_nl <= NOT((fsm_output(7)) OR (NOT (fsm_output(2))) OR (NOT (fsm_output(1)))
      OR (NOT (fsm_output(6))) OR (NOT COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm) OR (fsm_output(8))
      OR not_tmp_621);
  mux_1502_nl <= MUX_s_1_2_2(nor_832_nl, nor_833_nl, fsm_output(3));
  mux_1499_nl <= MUX_s_1_2_2(or_tmp_1274, or_tmp_1273, fsm_output(1));
  or_1484_nl <= (fsm_output(8)) OR (fsm_output(0)) OR (fsm_output(9));
  mux_1497_nl <= MUX_s_1_2_2(or_1484_nl, or_1483_cse, COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm);
  mux_1498_nl <= MUX_s_1_2_2(mux_1497_nl, or_tmp_1269, fsm_output(6));
  or_1485_nl <= (fsm_output(1)) OR mux_1498_nl;
  mux_1500_nl <= MUX_s_1_2_2(mux_1499_nl, or_1485_nl, fsm_output(2));
  or_1476_nl <= (fsm_output(0)) OR (NOT (fsm_output(9)));
  mux_1494_nl <= MUX_s_1_2_2(or_1476_nl, or_tmp_1262, fsm_output(8));
  mux_1495_nl <= MUX_s_1_2_2(or_750_cse, mux_1494_nl, COMP_LOOP_slc_COMP_LOOP_acc_12_7_itm);
  or_1478_nl <= (fsm_output(6)) OR mux_1495_nl;
  mux_1496_nl <= MUX_s_1_2_2(or_tmp_1267, or_1478_nl, fsm_output(1));
  or_1481_nl <= (fsm_output(2)) OR mux_1496_nl;
  mux_1501_nl <= MUX_s_1_2_2(mux_1500_nl, or_1481_nl, fsm_output(7));
  nor_834_nl <= NOT((fsm_output(3)) OR mux_1501_nl);
  mux_1503_nl <= MUX_s_1_2_2(mux_1502_nl, nor_834_nl, fsm_output(4));
  or_845_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)/=STD_LOGIC_VECTOR'("000")) OR mux_1014_cse;
  or_841_nl <= (NOT (fsm_output(7))) OR (NOT (fsm_output(8))) OR (NOT (fsm_output(9)))
      OR (fsm_output(0)) OR (fsm_output(3)) OR (fsm_output(1)) OR (fsm_output(4))
      OR (fsm_output(5));
  mux_1015_nl <= MUX_s_1_2_2(or_845_nl, or_841_nl, fsm_output(2));
  or_1460_nl <= mux_1015_nl OR (fsm_output(6));
  nor_825_nl <= NOT((fsm_output(7)) OR (fsm_output(2)) OR (fsm_output(9)) OR mux_1014_cse);
  nor_826_nl <= NOT((NOT (fsm_output(7))) OR (NOT (fsm_output(2))) OR (NOT (fsm_output(9)))
      OR (fsm_output(0)) OR (fsm_output(3)) OR (fsm_output(1)) OR (fsm_output(4))
      OR (fsm_output(5)));
  mux_1522_nl <= MUX_s_1_2_2(nor_825_nl, nor_826_nl, fsm_output(8));
  nor_827_nl <= NOT((NOT (fsm_output(8))) OR (fsm_output(7)) OR (NOT (fsm_output(2)))
      OR (NOT (fsm_output(9))) OR (fsm_output(0)) OR (fsm_output(3)) OR (fsm_output(1))
      OR (fsm_output(4)) OR (fsm_output(5)));
  and_286_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 0)=STD_LOGIC_VECTOR'("1110"));
  mux_1029_nl <= MUX_s_1_2_2(nor_tmp_21, mux_tmp_229, and_286_nl);
  mux_1034_nl <= MUX_s_1_2_2(mux_1026_cse, mux_1029_nl, fsm_output(4));
  or_864_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"));
  mux_1035_nl <= MUX_s_1_2_2(mux_1034_nl, nor_tmp_21, or_864_nl);
  nor_327_nl <= NOT(CONV_SL_1_1(fsm_output(9 DOWNTO 1)/=STD_LOGIC_VECTOR'("000011011")));
  or_982_nl <= (NOT (fsm_output(1))) OR (fsm_output(9)) OR not_tmp_29;
  or_980_nl <= (fsm_output(1)) OR (NOT (fsm_output(9))) OR (fsm_output(6)) OR (fsm_output(8));
  mux_1131_nl <= MUX_s_1_2_2(or_982_nl, or_980_nl, fsm_output(7));
  nor_329_nl <= NOT((NOT (fsm_output(4))) OR (fsm_output(2)) OR mux_1131_nl);
  mux_1132_nl <= MUX_s_1_2_2(nor_365_cse, nor_329_nl, fsm_output(5));
  nor_721_nl <= NOT((fsm_output(9)) OR not_tmp_29);
  nor_722_nl <= NOT((fsm_output(9)) OR (fsm_output(6)) OR (fsm_output(8)));
  mux_55_nl <= MUX_s_1_2_2(nor_721_nl, nor_722_nl, fsm_output(1));
  nand_238_nl <= NOT((fsm_output(7)) AND mux_55_nl);
  mux_56_nl <= MUX_s_1_2_2(or_29_cse, nand_238_nl, fsm_output(2));
  mux_57_nl <= MUX_s_1_2_2(or_1161_cse, mux_56_nl, fsm_output(4));
  nor_330_nl <= NOT((fsm_output(5)) OR mux_57_nl);
  mux_1133_nl <= MUX_s_1_2_2(mux_1132_nl, nor_330_nl, fsm_output(3));
  mux_1134_nl <= MUX_s_1_2_2(nor_327_nl, mux_1133_nl, fsm_output(0));
  COMP_LOOP_COMP_LOOP_and_2_nl <= CONV_SL_1_1(VEC_LOOP_j_sva_11_0(2 DOWNTO 0)=STD_LOGIC_VECTOR'("011"));
  COMP_LOOP_1_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED((z_out_8(6 DOWNTO 0))
      & STD_LOGIC_VECTOR'( "000")) + SIGNED('1' & (NOT (STAGE_LOOP_lshift_psp_sva(9
      DOWNTO 1)))) + SIGNED'( "0000000001"), 10));
  nor_808_nl <= NOT((fsm_output(9)) OR (fsm_output(7)) OR (fsm_output(6)) OR (CONV_SL_1_1(fsm_output(5
      DOWNTO 4)=STD_LOGIC_VECTOR'("11")) AND or_1516_cse));
  or_1266_nl <= (fsm_output(5)) OR (CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11"))
      AND or_722_cse);
  or_1025_nl <= (fsm_output(3)) OR and_316_cse;
  mux_1153_nl <= MUX_s_1_2_2(or_1025_nl, or_1516_cse, fsm_output(0));
  nor_323_nl <= NOT(CONV_SL_1_1(fsm_output(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00"))
      OR mux_1153_nl);
  mux_1154_nl <= MUX_s_1_2_2(or_1266_nl, nor_323_nl, fsm_output(6));
  or_1021_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 1)/=STD_LOGIC_VECTOR'("000"));
  mux_1152_nl <= MUX_s_1_2_2(or_1516_cse, or_1021_nl, fsm_output(0));
  or_1023_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("000")) OR
      mux_1152_nl;
  mux_1155_nl <= MUX_s_1_2_2(mux_1154_nl, or_1023_nl, fsm_output(7));
  and_714_nl <= (fsm_output(9)) AND mux_1155_nl;
  or_1032_nl <= (fsm_output(7)) OR ((fsm_output(6)) AND or_tmp_966);
  mux_1157_nl <= MUX_s_1_2_2(not_tmp_390, or_1032_nl, fsm_output(8));
  nand_112_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11"))
      AND nor_tmp_12);
  mux_1159_nl <= MUX_s_1_2_2(or_tmp_970, nand_112_nl, fsm_output(7));
  mux_1158_nl <= MUX_s_1_2_2(or_tmp_970, (NOT and_433_cse), fsm_output(7));
  mux_1160_nl <= MUX_s_1_2_2(mux_1159_nl, mux_1158_nl, fsm_output(1));
  and_208_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)=STD_LOGIC_VECTOR'("11")) AND or_dcpl_39;
  and_207_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)=STD_LOGIC_VECTOR'("11")) AND or_tmp_60;
  mux_1161_nl <= MUX_s_1_2_2(and_208_nl, and_207_nl, fsm_output(1));
  mux_1162_nl <= MUX_s_1_2_2(not_tmp_390, mux_1161_nl, fsm_output(8));
  or_1038_nl <= CONV_SL_1_1(fsm_output(8 DOWNTO 6)/=STD_LOGIC_VECTOR'("000")) OR
      and_292_cse;
  and_211_nl <= (fsm_output(7)) AND (CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR and_dcpl_75);
  and_210_nl <= (fsm_output(7)) AND (CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR and_398_cse);
  mux_1164_nl <= MUX_s_1_2_2(and_211_nl, and_210_nl, fsm_output(1));
  or_1043_nl <= (fsm_output(8)) OR mux_1164_nl;
  and_212_nl <= (fsm_output(8)) AND (CONV_SL_1_1(fsm_output(7 DOWNTO 2)/=STD_LOGIC_VECTOR'("000000")));
  or_1046_nl <= (fsm_output(7)) OR and_433_cse;
  or_1045_nl <= (fsm_output(7)) OR (CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11"))
      AND or_tmp_63);
  mux_1167_nl <= MUX_s_1_2_2(or_1046_nl, or_1045_nl, fsm_output(1));
  and_214_nl <= (fsm_output(8)) AND mux_1167_nl;
  COMP_LOOP_or_15_nl <= (COMP_LOOP_COMP_LOOP_nor_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_and_6_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_and_5_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_and_4_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_and_32_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_and_2_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_and_30_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_and_58_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_16_nl <= (COMP_LOOP_COMP_LOOP_and_58_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_nor_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_and_6_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_and_5_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_and_4_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_and_32_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_and_2_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_and_30_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_17_nl <= (COMP_LOOP_COMP_LOOP_and_30_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_and_58_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_nor_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_and_6_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_and_5_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_and_4_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_and_32_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_and_2_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_18_nl <= (COMP_LOOP_COMP_LOOP_and_2_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_and_30_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_and_58_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_nor_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_and_6_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_and_5_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_and_4_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_and_32_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_19_nl <= (COMP_LOOP_COMP_LOOP_and_32_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_and_2_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_and_30_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_and_58_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_nor_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_and_6_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_and_5_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_and_4_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_20_nl <= (COMP_LOOP_COMP_LOOP_and_4_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_and_32_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_and_2_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_and_30_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_and_58_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_nor_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_and_6_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_and_5_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_21_nl <= (COMP_LOOP_COMP_LOOP_and_5_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_and_4_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_and_32_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_and_2_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_and_30_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_and_58_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_nor_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_and_6_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_22_nl <= (COMP_LOOP_COMP_LOOP_and_6_itm AND and_dcpl_191) OR (COMP_LOOP_COMP_LOOP_and_5_itm
      AND tmp_10_lpi_4_dfm_mx0c1) OR (COMP_LOOP_COMP_LOOP_and_4_itm AND tmp_10_lpi_4_dfm_mx0c2)
      OR (COMP_LOOP_COMP_LOOP_and_32_itm AND tmp_10_lpi_4_dfm_mx0c3) OR (COMP_LOOP_COMP_LOOP_and_2_itm
      AND tmp_10_lpi_4_dfm_mx0c4) OR (COMP_LOOP_COMP_LOOP_and_30_itm AND tmp_10_lpi_4_dfm_mx0c5)
      OR (COMP_LOOP_COMP_LOOP_and_58_itm AND tmp_10_lpi_4_dfm_mx0c6) OR (COMP_LOOP_COMP_LOOP_nor_itm
      AND tmp_10_lpi_4_dfm_mx0c7);
  COMP_LOOP_or_26_nl <= ((NOT (modulo_result_rem_cmp_z(63))) AND and_243_m1c) OR
      (not_tmp_496 AND (fsm_output(0)) AND (NOT (modulo_result_rem_cmp_z(63))));
  COMP_LOOP_or_27_nl <= ((modulo_result_rem_cmp_z(63)) AND and_243_m1c) OR (not_tmp_496
      AND (fsm_output(0)) AND (modulo_result_rem_cmp_z(63)));
  COMP_LOOP_or_7_nl <= (COMP_LOOP_COMP_LOOP_nor_1_itm AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_nor_1_itm
      AND and_250_m1c);
  COMP_LOOP_or_8_nl <= (COMP_LOOP_COMP_LOOP_and_211 AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_and_211
      AND and_250_m1c);
  COMP_LOOP_or_9_nl <= (COMP_LOOP_COMP_LOOP_and_213 AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_and_213
      AND and_250_m1c);
  COMP_LOOP_or_10_nl <= (COMP_LOOP_COMP_LOOP_and_125_itm AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_and_11_itm
      AND and_250_m1c);
  COMP_LOOP_or_11_nl <= (COMP_LOOP_COMP_LOOP_and_215 AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_and_215
      AND and_250_m1c);
  COMP_LOOP_or_12_nl <= (COMP_LOOP_COMP_LOOP_and_11_itm AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_and_12_itm
      AND and_250_m1c);
  COMP_LOOP_or_13_nl <= (COMP_LOOP_COMP_LOOP_and_12_itm AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_and_124_itm
      AND and_250_m1c);
  COMP_LOOP_or_14_nl <= (COMP_LOOP_COMP_LOOP_and_124_itm AND and_244_m1c) OR (COMP_LOOP_COMP_LOOP_and_125_itm
      AND and_250_m1c);
  or_1391_nl <= (NOT (fsm_output(5))) OR (fsm_output(1)) OR (fsm_output(9)) OR (fsm_output(8))
      OR (NOT (fsm_output(6)));
  or_1392_nl <= (fsm_output(5)) OR (fsm_output(1)) OR (NOT (fsm_output(9))) OR (fsm_output(8))
      OR (fsm_output(6));
  mux_71_nl <= MUX_s_1_2_2(or_1391_nl, or_1392_nl, fsm_output(3));
  or_1393_nl <= (NOT (fsm_output(3))) OR (fsm_output(5)) OR (NOT (fsm_output(1)))
      OR (fsm_output(9)) OR (fsm_output(8)) OR (NOT (fsm_output(6)));
  mux_72_nl <= MUX_s_1_2_2(mux_71_nl, or_1393_nl, fsm_output(7));
  or_1394_nl <= (fsm_output(7)) OR (fsm_output(3)) OR (NOT (fsm_output(5))) OR (NOT
      (fsm_output(1))) OR (NOT (fsm_output(9))) OR (fsm_output(8)) OR (NOT (fsm_output(6)));
  mux_73_nl <= MUX_s_1_2_2(mux_72_nl, or_1394_nl, fsm_output(4));
  or_1395_nl <= (fsm_output(7)) OR (fsm_output(3)) OR (fsm_output(5)) OR (NOT((fsm_output(1))
      AND (fsm_output(9)) AND (fsm_output(8)) AND (fsm_output(6))));
  or_1396_nl <= (fsm_output(3)) OR (NOT (fsm_output(5))) OR (fsm_output(1)) OR (fsm_output(9))
      OR (NOT (fsm_output(8))) OR (fsm_output(6));
  or_56_nl <= (NOT (fsm_output(9))) OR (fsm_output(8)) OR (NOT (fsm_output(6)));
  or_54_nl <= (fsm_output(9)) OR (NOT (fsm_output(8))) OR (fsm_output(6));
  mux_68_nl <= MUX_s_1_2_2(or_56_nl, or_54_nl, fsm_output(1));
  or_1397_nl <= (NOT (fsm_output(3))) OR (fsm_output(5)) OR mux_68_nl;
  mux_69_nl <= MUX_s_1_2_2(or_1396_nl, or_1397_nl, fsm_output(7));
  mux_70_nl <= MUX_s_1_2_2(or_1395_nl, mux_69_nl, fsm_output(4));
  mux_74_nl <= MUX_s_1_2_2(mux_73_nl, mux_70_nl, fsm_output(2));
  nor_746_nl <= NOT(mux_74_nl OR (fsm_output(0)));
  mux_1379_nl <= MUX_s_1_2_2((NOT and_293_cse), (fsm_output(6)), fsm_output(9));
  mux_1380_nl <= MUX_s_1_2_2(mux_1379_nl, or_tmp_5, fsm_output(8));
  mux_1381_nl <= MUX_s_1_2_2(mux_1380_nl, mux_tmp_1341, fsm_output(4));
  mux_1375_nl <= MUX_s_1_2_2(or_tmp_1142, or_tmp_5, fsm_output(1));
  mux_1376_nl <= MUX_s_1_2_2(mux_1375_nl, (NOT (fsm_output(6))), fsm_output(9));
  mux_1377_nl <= MUX_s_1_2_2(mux_1376_nl, or_119_cse, fsm_output(8));
  mux_1372_nl <= MUX_s_1_2_2(or_tmp_1128, or_tmp_1142, fsm_output(1));
  mux_1373_nl <= MUX_s_1_2_2(mux_tmp_1353, mux_1372_nl, fsm_output(9));
  mux_1371_nl <= MUX_s_1_2_2((NOT mux_tmp_1355), or_857_cse, fsm_output(9));
  mux_1374_nl <= MUX_s_1_2_2(mux_1373_nl, mux_1371_nl, fsm_output(8));
  mux_1378_nl <= MUX_s_1_2_2(mux_1377_nl, mux_1374_nl, fsm_output(4));
  mux_1382_nl <= MUX_s_1_2_2(mux_1381_nl, mux_1378_nl, fsm_output(5));
  and_253_nl <= (fsm_output(1)) AND (fsm_output(7)) AND (fsm_output(0)) AND (fsm_output(6));
  mux_1367_nl <= MUX_s_1_2_2(and_253_nl, mux_tmp_1345, fsm_output(9));
  mux_1368_nl <= MUX_s_1_2_2((NOT mux_1367_nl), mux_tmp_1348, fsm_output(8));
  or_1207_nl <= (fsm_output(7)) OR (fsm_output(0)) OR (fsm_output(6));
  mux_1364_nl <= MUX_s_1_2_2((NOT mux_tmp_1329), or_1207_nl, fsm_output(1));
  mux_1365_nl <= MUX_s_1_2_2((NOT and_293_cse), mux_1364_nl, fsm_output(9));
  or_1206_nl <= (fsm_output(7)) OR (NOT (fsm_output(0))) OR (fsm_output(6));
  mux_1362_nl <= MUX_s_1_2_2(or_tmp_1137, or_1206_nl, fsm_output(1));
  mux_1363_nl <= MUX_s_1_2_2(or_tmp_13, mux_1362_nl, fsm_output(9));
  mux_1366_nl <= MUX_s_1_2_2(mux_1365_nl, mux_1363_nl, fsm_output(8));
  mux_1369_nl <= MUX_s_1_2_2(mux_1368_nl, mux_1366_nl, fsm_output(4));
  mux_1361_nl <= MUX_s_1_2_2(mux_tmp_1351, mux_tmp_1332, fsm_output(4));
  mux_1370_nl <= MUX_s_1_2_2(mux_1369_nl, mux_1361_nl, fsm_output(5));
  mux_1383_nl <= MUX_s_1_2_2(mux_1382_nl, mux_1370_nl, fsm_output(3));
  mux_1356_nl <= MUX_s_1_2_2(and_293_cse, mux_tmp_1355, fsm_output(9));
  or_1201_nl <= (NOT (fsm_output(1))) OR (fsm_output(7)) OR nand_240_cse;
  mux_1354_nl <= MUX_s_1_2_2(mux_tmp_1353, or_1201_nl, fsm_output(9));
  mux_1357_nl <= MUX_s_1_2_2((NOT mux_1356_nl), mux_1354_nl, fsm_output(8));
  mux_1358_nl <= MUX_s_1_2_2(mux_1357_nl, mux_tmp_1341, fsm_output(4));
  mux_1346_nl <= MUX_s_1_2_2((NOT mux_tmp_1345), or_857_cse, fsm_output(9));
  mux_1349_nl <= MUX_s_1_2_2(mux_tmp_1348, mux_1346_nl, fsm_output(8));
  mux_1352_nl <= MUX_s_1_2_2(mux_tmp_1351, mux_1349_nl, fsm_output(4));
  mux_1359_nl <= MUX_s_1_2_2(mux_1358_nl, mux_1352_nl, fsm_output(5));
  or_1196_nl <= (NOT (fsm_output(7))) OR (fsm_output(0)) OR (NOT (fsm_output(6)));
  mux_1337_nl <= MUX_s_1_2_2(or_1196_nl, or_tmp_1128, fsm_output(1));
  nand_98_nl <= NOT(((fsm_output(1)) OR (NOT (fsm_output(7))) OR (fsm_output(0)))
      AND (fsm_output(6)));
  mux_1338_nl <= MUX_s_1_2_2(mux_1337_nl, nand_98_nl, fsm_output(9));
  nand_99_nl <= NOT((fsm_output(7)) AND (fsm_output(0)) AND (fsm_output(6)));
  or_1191_nl <= nor_400_cse OR (fsm_output(6));
  mux_1336_nl <= MUX_s_1_2_2(nand_99_nl, or_1191_nl, fsm_output(1));
  or_1192_nl <= (fsm_output(9)) OR mux_1336_nl;
  mux_1339_nl <= MUX_s_1_2_2(mux_1338_nl, or_1192_nl, fsm_output(8));
  mux_1342_nl <= MUX_s_1_2_2(mux_tmp_1341, mux_1339_nl, fsm_output(4));
  nand_183_nl <= NOT((NOT((fsm_output(1)) AND (fsm_output(7)) AND (fsm_output(0))))
      AND (fsm_output(6)));
  mux_1333_nl <= MUX_s_1_2_2(or_tmp_5, nand_183_nl, fsm_output(9));
  mux_1334_nl <= MUX_s_1_2_2(mux_1333_nl, or_119_cse, fsm_output(8));
  mux_1335_nl <= MUX_s_1_2_2(mux_1334_nl, mux_tmp_1332, fsm_output(4));
  mux_1343_nl <= MUX_s_1_2_2(mux_1342_nl, mux_1335_nl, fsm_output(5));
  mux_1360_nl <= MUX_s_1_2_2(mux_1359_nl, mux_1343_nl, fsm_output(3));
  mux_1038_nl <= MUX_s_1_2_2(mux_tmp_1037, mux_tmp_81, fsm_output(1));
  and_725_nl <= and_dcpl_223 AND and_dcpl_218 AND (NOT (fsm_output(4))) AND (fsm_output(0));
  and_726_nl <= and_dcpl_223 AND and_dcpl_218 AND nor_379_cse;
  modExp_while_mux1h_3_nl <= MUX1HOT_v_64_4_2(modExp_base_sva, modExp_result_sva,
      COMP_LOOP_1_mul_mut, operator_64_false_acc_mut_63_0, STD_LOGIC_VECTOR'( and_725_nl
      & and_726_nl & not_tmp_519 & not_tmp_524));
  modExp_while_or_2_nl <= not_tmp_519 OR not_tmp_524;
  modExp_while_mux_1_nl <= MUX_v_64_2_2(modExp_base_sva, COMP_LOOP_1_mul_mut, modExp_while_or_2_nl);
  z_out <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(modExp_while_mux1h_3_nl)
      * UNSIGNED(modExp_while_mux_1_nl)), 64));
  and_727_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("111")) AND
      nor_797_cse AND (NOT (fsm_output(4))) AND (fsm_output(2)) AND (NOT (fsm_output(1)))
      AND and_dcpl_313;
  COMP_LOOP_mux_45_nl <= MUX_v_10_2_2(('0' & COMP_LOOP_k_9_3_sva_5_0 & STD_LOGIC_VECTOR'(
      "011")), STAGE_LOOP_lshift_psp_sva, and_727_nl);
  z_out_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_11_0),
      12), 13) + CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux_45_nl), 13), 13));
  COMP_LOOP_mux_46_nl <= MUX_v_56_2_2((tmp_10_lpi_4_dfm(63 DOWNTO 8)), (p_sva(63
      DOWNTO 8)), and_dcpl_256);
  COMP_LOOP_COMP_LOOP_or_6_nl <= MUX_v_56_2_2(COMP_LOOP_mux_46_nl, STD_LOGIC_VECTOR'("11111111111111111111111111111111111111111111111111111111"),
      COMP_LOOP_or_39_itm);
  COMP_LOOP_mux1h_268_nl <= MUX1HOT_s_1_4_2((tmp_10_lpi_4_dfm(7)), (NOT modExp_exp_1_7_1_sva),
      (p_sva(7)), (NOT modExp_exp_1_1_1_sva), STD_LOGIC_VECTOR'( and_dcpl_246 & and_dcpl_247
      & and_dcpl_256 & and_dcpl_262));
  COMP_LOOP_mux1h_269_nl <= MUX1HOT_s_1_4_2((tmp_10_lpi_4_dfm(6)), (NOT modExp_exp_1_6_1_sva),
      (p_sva(6)), (NOT modExp_exp_1_7_1_sva), STD_LOGIC_VECTOR'( and_dcpl_246 & and_dcpl_247
      & and_dcpl_256 & and_dcpl_262));
  COMP_LOOP_mux1h_270_nl <= MUX1HOT_s_1_4_2((tmp_10_lpi_4_dfm(5)), (NOT modExp_exp_1_5_1_sva),
      (p_sva(5)), (NOT modExp_exp_1_6_1_sva), STD_LOGIC_VECTOR'( and_dcpl_246 & and_dcpl_247
      & and_dcpl_256 & and_dcpl_262));
  COMP_LOOP_mux1h_271_nl <= MUX1HOT_s_1_4_2((tmp_10_lpi_4_dfm(4)), (NOT modExp_exp_1_4_1_sva),
      (p_sva(4)), (NOT modExp_exp_1_5_1_sva), STD_LOGIC_VECTOR'( and_dcpl_246 & and_dcpl_247
      & and_dcpl_256 & and_dcpl_262));
  COMP_LOOP_mux1h_272_nl <= MUX1HOT_s_1_4_2((tmp_10_lpi_4_dfm(3)), (NOT modExp_exp_1_3_1_sva),
      (p_sva(3)), (NOT modExp_exp_1_4_1_sva), STD_LOGIC_VECTOR'( and_dcpl_246 & and_dcpl_247
      & and_dcpl_256 & and_dcpl_262));
  COMP_LOOP_mux1h_273_nl <= MUX1HOT_s_1_4_2((tmp_10_lpi_4_dfm(2)), (NOT modExp_exp_1_2_1_sva),
      (p_sva(2)), (NOT modExp_exp_1_3_1_sva), STD_LOGIC_VECTOR'( and_dcpl_246 & and_dcpl_247
      & and_dcpl_256 & and_dcpl_262));
  COMP_LOOP_mux1h_274_nl <= MUX1HOT_s_1_4_2((tmp_10_lpi_4_dfm(1)), (NOT modExp_exp_1_1_1_sva),
      (p_sva(1)), (NOT modExp_exp_1_2_1_sva), STD_LOGIC_VECTOR'( and_dcpl_246 & and_dcpl_247
      & and_dcpl_256 & and_dcpl_262));
  COMP_LOOP_mux1h_275_nl <= MUX1HOT_s_1_3_2((tmp_10_lpi_4_dfm(0)), (NOT modExp_exp_1_0_1_sva_1),
      (p_sva(0)), STD_LOGIC_VECTOR'( and_dcpl_246 & COMP_LOOP_or_39_itm & and_dcpl_256));
  COMP_LOOP_or_48_nl <= (NOT(and_dcpl_247 OR and_dcpl_256 OR and_dcpl_262)) OR and_dcpl_246;
  COMP_LOOP_mux_47_nl <= MUX_v_64_2_2(modulo_result_mux_1_cse, STD_LOGIC_VECTOR'(
      "1111111111111111111111111111111111111111111111111111111111111110"), COMP_LOOP_or_39_itm);
  COMP_LOOP_not_199_nl <= NOT and_dcpl_256;
  COMP_LOOP_COMP_LOOP_COMP_LOOP_nand_1_nl <= NOT(MUX_v_64_2_2(STD_LOGIC_VECTOR'("0000000000000000000000000000000000000000000000000000000000000000"),
      COMP_LOOP_mux_47_nl, COMP_LOOP_not_199_nl));
  acc_1_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_or_6_nl
      & COMP_LOOP_mux1h_268_nl & COMP_LOOP_mux1h_269_nl & COMP_LOOP_mux1h_270_nl
      & COMP_LOOP_mux1h_271_nl & COMP_LOOP_mux1h_272_nl & COMP_LOOP_mux1h_273_nl
      & COMP_LOOP_mux1h_274_nl & COMP_LOOP_mux1h_275_nl & COMP_LOOP_or_48_nl), 65),
      66) + CONV_UNSIGNED(CONV_SIGNED(SIGNED(COMP_LOOP_COMP_LOOP_COMP_LOOP_nand_1_nl
      & '1'), 65), 66), 66));
  z_out_2 <= acc_1_nl(65 DOWNTO 1);
  operator_64_false_1_operator_64_false_1_or_2_nl <= operator_64_false_1_nor_1_itm
      OR and_dcpl_277;
  operator_64_false_1_mux_1_nl <= MUX_s_1_2_2((NOT (STAGE_LOOP_lshift_psp_sva(9))),
      (STAGE_LOOP_lshift_psp_sva(9)), and_dcpl_289);
  operator_64_false_1_operator_64_false_1_or_3_nl <= operator_64_false_1_mux_1_nl
      OR and_dcpl_271 OR and_dcpl_284;
  operator_64_false_1_mux1h_3_nl <= MUX1HOT_v_6_4_2((NOT COMP_LOOP_k_9_3_sva_5_0),
      (NOT (STAGE_LOOP_lshift_psp_sva(8 DOWNTO 3))), (NOT (STAGE_LOOP_lshift_psp_sva(9
      DOWNTO 4))), (STAGE_LOOP_lshift_psp_sva(8 DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_271
      & and_dcpl_277 & and_dcpl_284 & and_dcpl_289));
  operator_64_false_1_or_4_nl <= (NOT(and_dcpl_271 OR and_dcpl_289)) OR and_dcpl_277
      OR and_dcpl_284;
  operator_64_false_1_operator_64_false_1_and_1_nl <= (COMP_LOOP_k_9_3_sva_5_0(5))
      AND operator_64_false_1_nor_1_itm;
  operator_64_false_1_or_5_nl <= and_dcpl_284 OR and_dcpl_289;
  operator_64_false_1_mux1h_4_nl <= MUX1HOT_v_6_3_2(STD_LOGIC_VECTOR'( "000001"),
      ((COMP_LOOP_k_9_3_sva_5_0(4 DOWNTO 0)) & '0'), COMP_LOOP_k_9_3_sva_5_0, STD_LOGIC_VECTOR'(
      and_dcpl_271 & and_dcpl_277 & operator_64_false_1_or_5_nl));
  acc_2_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(operator_64_false_1_operator_64_false_1_or_2_nl
      & operator_64_false_1_operator_64_false_1_or_3_nl & operator_64_false_1_mux1h_3_nl
      & operator_64_false_1_or_4_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(operator_64_false_1_operator_64_false_1_and_1_nl
      & operator_64_false_1_mux1h_4_nl & '1'), 8), 9), 9));
  z_out_3 <= acc_2_nl(8 DOWNTO 1);
  COMP_LOOP_COMP_LOOP_or_7_nl <= (VEC_LOOP_j_sva_11_0(11)) OR and_dcpl_305 OR and_dcpl_312
      OR and_dcpl_318 OR and_dcpl_326 OR and_dcpl_330;
  COMP_LOOP_COMP_LOOP_mux_9_nl <= MUX_v_9_2_2((VEC_LOOP_j_sva_11_0(10 DOWNTO 2)),
      (NOT (STAGE_LOOP_lshift_psp_sva(9 DOWNTO 1))), COMP_LOOP_or_43_itm);
  COMP_LOOP_or_49_nl <= (NOT and_dcpl_298) OR and_dcpl_305 OR and_dcpl_312 OR and_dcpl_318
      OR and_dcpl_326 OR and_dcpl_330;
  COMP_LOOP_COMP_LOOP_mux_10_nl <= MUX_v_6_2_2((STD_LOGIC_VECTOR'( "00") & (COMP_LOOP_k_9_3_sva_5_0(5
      DOWNTO 2))), COMP_LOOP_k_9_3_sva_5_0, COMP_LOOP_or_43_itm);
  COMP_LOOP_COMP_LOOP_or_8_nl <= ((COMP_LOOP_k_9_3_sva_5_0(1)) AND (NOT(and_dcpl_305
      OR and_dcpl_312))) OR and_dcpl_318 OR and_dcpl_326 OR and_dcpl_330;
  COMP_LOOP_COMP_LOOP_or_9_nl <= ((COMP_LOOP_k_9_3_sva_5_0(0)) AND (NOT(and_dcpl_305
      OR and_dcpl_318 OR and_dcpl_326))) OR and_dcpl_312 OR and_dcpl_330;
  COMP_LOOP_COMP_LOOP_or_10_nl <= (NOT(and_dcpl_312 OR and_dcpl_318 OR and_dcpl_330))
      OR and_dcpl_298 OR and_dcpl_305 OR and_dcpl_326;
  acc_3_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_or_7_nl
      & COMP_LOOP_COMP_LOOP_mux_9_nl & COMP_LOOP_or_49_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_mux_10_nl
      & COMP_LOOP_COMP_LOOP_or_8_nl & COMP_LOOP_COMP_LOOP_or_9_nl & COMP_LOOP_COMP_LOOP_or_10_nl
      & '1'), 10), 11), 11));
  z_out_4 <= acc_3_nl(10 DOWNTO 1);
  and_728_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("001")) AND
      and_dcpl_280 AND (NOT (fsm_output(2))) AND (NOT (fsm_output(4))) AND (NOT (fsm_output(1)))
      AND and_dcpl_278;
  and_729_nl <= and_dcpl_91 AND (NOT (fsm_output(7))) AND and_dcpl_267 AND and_dcpl_342
      AND and_dcpl_313;
  and_730_nl <= and_dcpl_91 AND (fsm_output(7)) AND and_dcpl_280 AND (fsm_output(2))
      AND (fsm_output(4)) AND (NOT (fsm_output(1))) AND and_dcpl_313;
  and_731_nl <= and_dcpl_360 AND nor_797_cse AND and_dcpl_355 AND (fsm_output(1))
      AND and_dcpl_313;
  and_732_nl <= and_dcpl_360 AND and_dcpl_267 AND and_dcpl_291 AND (NOT (fsm_output(1)))
      AND and_dcpl_278;
  and_733_nl <= and_dcpl_359 AND (fsm_output(7)) AND and_dcpl_280 AND and_dcpl_342
      AND and_dcpl_278;
  COMP_LOOP_mux1h_276_nl <= MUX1HOT_v_3_6_2(STD_LOGIC_VECTOR'( "001"), STD_LOGIC_VECTOR'(
      "010"), STD_LOGIC_VECTOR'( "011"), STD_LOGIC_VECTOR'( "100"), STD_LOGIC_VECTOR'(
      "101"), STD_LOGIC_VECTOR'( "110"), STD_LOGIC_VECTOR'( and_728_nl & and_729_nl
      & and_730_nl & and_731_nl & and_732_nl & and_733_nl));
  and_734_nl <= CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("110")) AND
      nor_797_cse AND and_dcpl_355 AND (NOT (fsm_output(1))) AND and_dcpl_278;
  COMP_LOOP_or_50_nl <= MUX_v_3_2_2(COMP_LOOP_mux1h_276_nl, STD_LOGIC_VECTOR'("111"),
      and_734_nl);
  COMP_LOOP_acc_59_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_lshift_psp_sva)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_9_3_sva_5_0 & COMP_LOOP_or_50_nl),
      9), 10), 10));
  COMP_LOOP_or_51_nl <= (and_dcpl_309 AND (NOT (fsm_output(8))) AND and_dcpl_280
      AND (NOT((fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(1)))) AND and_dcpl_278)
      OR (CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("010")) AND and_dcpl_267
      AND and_dcpl_342 AND and_dcpl_313) OR and_dcpl_318 OR (and_dcpl_411 AND nor_797_cse
      AND and_dcpl_355 AND (fsm_output(1)) AND and_dcpl_313) OR (and_dcpl_411 AND
      and_dcpl_267 AND and_dcpl_291 AND (NOT (fsm_output(1))) AND and_dcpl_278) OR
      (CONV_SL_1_1(fsm_output(9 DOWNTO 7)=STD_LOGIC_VECTOR'("101")) AND and_dcpl_280
      AND and_dcpl_342 AND and_dcpl_278) OR (and_dcpl_410 AND (fsm_output(8)) AND
      nor_797_cse AND and_dcpl_355 AND (NOT (fsm_output(1))) AND and_dcpl_278);
  COMP_LOOP_COMP_LOOP_mux_11_nl <= MUX_v_10_2_2(((z_out_3(6 DOWNTO 0)) & (STAGE_LOOP_lshift_psp_sva(2
      DOWNTO 0))), STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_acc_59_nl),
      10)), COMP_LOOP_or_51_nl);
  COMP_LOOP_acc_58_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_sva_11_0),
      12), 13) + CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_mux_11_nl), 13), 13));
  z_out_6_12_1 <= COMP_LOOP_acc_58_nl(12 DOWNTO 1);
  COMP_LOOP_not_200_nl <= NOT and_dcpl_442;
  COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_2_nl <= NOT(MUX_v_53_2_2((operator_66_true_div_cmp_z(63
      DOWNTO 11)), STD_LOGIC_VECTOR'("11111111111111111111111111111111111111111111111111111"),
      COMP_LOOP_not_200_nl));
  COMP_LOOP_mux_48_nl <= MUX_v_11_2_2((VEC_LOOP_j_sva_11_0(11 DOWNTO 1)), (NOT (operator_66_true_div_cmp_z(10
      DOWNTO 0))), and_dcpl_442);
  not_2902_nl <= NOT and_dcpl_442;
  COMP_LOOP_COMP_LOOP_and_220_nl <= MUX_v_6_2_2(STD_LOGIC_VECTOR'("000000"), COMP_LOOP_k_9_3_sva_5_0,
      not_2902_nl);
  z_out_7 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(and_dcpl_442 & COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_2_nl
      & COMP_LOOP_mux_48_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_and_220_nl
      & (NOT and_dcpl_442) & '1'), 8), 65), 65));
  COMP_LOOP_COMP_LOOP_or_11_nl <= (NOT(and_dcpl_451 OR and_dcpl_460)) OR and_dcpl_467;
  COMP_LOOP_or_52_nl <= and_dcpl_451 OR and_dcpl_460;
  COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_3_nl <= NOT(MUX_v_52_2_2((operator_64_false_slc_modExp_exp_63_1_itm(62
      DOWNTO 11)), STD_LOGIC_VECTOR'("1111111111111111111111111111111111111111111111111111"),
      COMP_LOOP_or_52_nl));
  COMP_LOOP_mux1h_277_nl <= MUX1HOT_v_11_3_2((VEC_LOOP_j_sva_11_0(11 DOWNTO 1)),
      (STD_LOGIC_VECTOR'( "00000") & COMP_LOOP_k_9_3_sva_5_0), (NOT (operator_64_false_slc_modExp_exp_63_1_itm(10
      DOWNTO 0))), STD_LOGIC_VECTOR'( and_dcpl_451 & and_dcpl_460 & and_dcpl_467));
  COMP_LOOP_nor_109_nl <= NOT(and_dcpl_460 OR and_dcpl_467);
  COMP_LOOP_COMP_LOOP_and_221_nl <= MUX_v_6_2_2(STD_LOGIC_VECTOR'("000000"), COMP_LOOP_k_9_3_sva_5_0,
      COMP_LOOP_nor_109_nl);
  z_out_8 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_or_11_nl
      & COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_3_nl & COMP_LOOP_mux1h_277_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_COMP_LOOP_and_221_nl
      & STD_LOGIC_VECTOR'( "01")), 8), 64), 64));
END v41;

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
    vec_rsc_0_0_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_0_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_wea : OUT STD_LOGIC;
    vec_rsc_0_0_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    vec_rsc_0_1_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_1_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_wea : OUT STD_LOGIC;
    vec_rsc_0_1_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    vec_rsc_0_2_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_2_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_2_wea : OUT STD_LOGIC;
    vec_rsc_0_2_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_2_lz : OUT STD_LOGIC;
    vec_rsc_0_3_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_3_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_3_wea : OUT STD_LOGIC;
    vec_rsc_0_3_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_3_lz : OUT STD_LOGIC;
    vec_rsc_0_4_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_4_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_4_wea : OUT STD_LOGIC;
    vec_rsc_0_4_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_4_lz : OUT STD_LOGIC;
    vec_rsc_0_5_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_5_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_5_wea : OUT STD_LOGIC;
    vec_rsc_0_5_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_5_lz : OUT STD_LOGIC;
    vec_rsc_0_6_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_6_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_6_wea : OUT STD_LOGIC;
    vec_rsc_0_6_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_6_lz : OUT STD_LOGIC;
    vec_rsc_0_7_adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    vec_rsc_0_7_da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_7_wea : OUT STD_LOGIC;
    vec_rsc_0_7_qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_0_7_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC
  );
END inPlaceNTT_DIT;

ARCHITECTURE v41 OF inPlaceNTT_DIT IS
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
  SIGNAL vec_rsc_0_4_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_5_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_6_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_7_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_adra_d_iff : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da_d_iff : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_2_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_3_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_4_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_5_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_6_i_wea_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_7_i_wea_d_iff : STD_LOGIC;

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_0_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_1_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_2_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_3_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_8_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_4_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_9_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_5_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_10_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_6_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_11_9_64_512_512_64_1_gen
    PORT(
      qa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea : OUT STD_LOGIC;
      da : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      adra : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      adra_d : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      da_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      qa_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wea_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rwA_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_7_i_qa : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_da : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_adra : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_adra_d : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_da_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_qa_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT inPlaceNTT_DIT_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_2_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_3_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_4_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_5_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_6_lz : OUT STD_LOGIC;
      vec_rsc_triosy_0_7_lz : OUT STD_LOGIC;
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
      vec_rsc_0_4_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_5_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_6_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_7_i_qa_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsc_0_0_i_adra_d_pff : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      vec_rsc_0_0_i_da_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_1_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_2_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_3_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_4_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_5_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_6_i_wea_d_pff : OUT STD_LOGIC;
      vec_rsc_0_7_i_wea_d_pff : OUT STD_LOGIC
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
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_4_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_5_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_6_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_7_i_qa_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff : STD_LOGIC_VECTOR (8
      DOWNTO 0);
  SIGNAL inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff : STD_LOGIC_VECTOR (63 DOWNTO
      0);

BEGIN
  vec_rsc_0_0_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_9_64_512_512_64_1_gen
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

  vec_rsc_0_1_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_9_64_512_512_64_1_gen
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

  vec_rsc_0_2_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_6_9_64_512_512_64_1_gen
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

  vec_rsc_0_3_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_7_9_64_512_512_64_1_gen
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

  vec_rsc_0_4_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_8_9_64_512_512_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_4_i_qa,
      wea => vec_rsc_0_4_wea,
      da => vec_rsc_0_4_i_da,
      adra => vec_rsc_0_4_i_adra,
      adra_d => vec_rsc_0_4_i_adra_d,
      da_d => vec_rsc_0_4_i_da_d,
      qa_d => vec_rsc_0_4_i_qa_d_1,
      wea_d => vec_rsc_0_4_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_4_i_wea_d_iff
    );
  vec_rsc_0_4_i_qa <= vec_rsc_0_4_qa;
  vec_rsc_0_4_da <= vec_rsc_0_4_i_da;
  vec_rsc_0_4_adra <= vec_rsc_0_4_i_adra;
  vec_rsc_0_4_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_4_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_4_i_qa_d <= vec_rsc_0_4_i_qa_d_1;

  vec_rsc_0_5_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_9_9_64_512_512_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_5_i_qa,
      wea => vec_rsc_0_5_wea,
      da => vec_rsc_0_5_i_da,
      adra => vec_rsc_0_5_i_adra,
      adra_d => vec_rsc_0_5_i_adra_d,
      da_d => vec_rsc_0_5_i_da_d,
      qa_d => vec_rsc_0_5_i_qa_d_1,
      wea_d => vec_rsc_0_5_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_5_i_wea_d_iff
    );
  vec_rsc_0_5_i_qa <= vec_rsc_0_5_qa;
  vec_rsc_0_5_da <= vec_rsc_0_5_i_da;
  vec_rsc_0_5_adra <= vec_rsc_0_5_i_adra;
  vec_rsc_0_5_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_5_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_5_i_qa_d <= vec_rsc_0_5_i_qa_d_1;

  vec_rsc_0_6_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_10_9_64_512_512_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_6_i_qa,
      wea => vec_rsc_0_6_wea,
      da => vec_rsc_0_6_i_da,
      adra => vec_rsc_0_6_i_adra,
      adra_d => vec_rsc_0_6_i_adra_d,
      da_d => vec_rsc_0_6_i_da_d,
      qa_d => vec_rsc_0_6_i_qa_d_1,
      wea_d => vec_rsc_0_6_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_6_i_wea_d_iff
    );
  vec_rsc_0_6_i_qa <= vec_rsc_0_6_qa;
  vec_rsc_0_6_da <= vec_rsc_0_6_i_da;
  vec_rsc_0_6_adra <= vec_rsc_0_6_i_adra;
  vec_rsc_0_6_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_6_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_6_i_qa_d <= vec_rsc_0_6_i_qa_d_1;

  vec_rsc_0_7_i : inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_11_9_64_512_512_64_1_gen
    PORT MAP(
      qa => vec_rsc_0_7_i_qa,
      wea => vec_rsc_0_7_wea,
      da => vec_rsc_0_7_i_da,
      adra => vec_rsc_0_7_i_adra,
      adra_d => vec_rsc_0_7_i_adra_d,
      da_d => vec_rsc_0_7_i_da_d,
      qa_d => vec_rsc_0_7_i_qa_d_1,
      wea_d => vec_rsc_0_7_i_wea_d_iff,
      rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d => vec_rsc_0_7_i_wea_d_iff
    );
  vec_rsc_0_7_i_qa <= vec_rsc_0_7_qa;
  vec_rsc_0_7_da <= vec_rsc_0_7_i_da;
  vec_rsc_0_7_adra <= vec_rsc_0_7_i_adra;
  vec_rsc_0_7_i_adra_d <= vec_rsc_0_0_i_adra_d_iff;
  vec_rsc_0_7_i_da_d <= vec_rsc_0_0_i_da_d_iff;
  vec_rsc_0_7_i_qa_d <= vec_rsc_0_7_i_qa_d_1;

  inPlaceNTT_DIT_core_inst : inPlaceNTT_DIT_core
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_triosy_0_0_lz => vec_rsc_triosy_0_0_lz,
      vec_rsc_triosy_0_1_lz => vec_rsc_triosy_0_1_lz,
      vec_rsc_triosy_0_2_lz => vec_rsc_triosy_0_2_lz,
      vec_rsc_triosy_0_3_lz => vec_rsc_triosy_0_3_lz,
      vec_rsc_triosy_0_4_lz => vec_rsc_triosy_0_4_lz,
      vec_rsc_triosy_0_5_lz => vec_rsc_triosy_0_5_lz,
      vec_rsc_triosy_0_6_lz => vec_rsc_triosy_0_6_lz,
      vec_rsc_triosy_0_7_lz => vec_rsc_triosy_0_7_lz,
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
      vec_rsc_0_4_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_4_i_qa_d,
      vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_5_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_5_i_qa_d,
      vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_6_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_6_i_qa_d,
      vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_7_i_qa_d => inPlaceNTT_DIT_core_inst_vec_rsc_0_7_i_qa_d,
      vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d => vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_0_i_adra_d_pff => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff,
      vec_rsc_0_0_i_da_d_pff => inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff,
      vec_rsc_0_0_i_wea_d_pff => vec_rsc_0_0_i_wea_d_iff,
      vec_rsc_0_1_i_wea_d_pff => vec_rsc_0_1_i_wea_d_iff,
      vec_rsc_0_2_i_wea_d_pff => vec_rsc_0_2_i_wea_d_iff,
      vec_rsc_0_3_i_wea_d_pff => vec_rsc_0_3_i_wea_d_iff,
      vec_rsc_0_4_i_wea_d_pff => vec_rsc_0_4_i_wea_d_iff,
      vec_rsc_0_5_i_wea_d_pff => vec_rsc_0_5_i_wea_d_iff,
      vec_rsc_0_6_i_wea_d_pff => vec_rsc_0_6_i_wea_d_iff,
      vec_rsc_0_7_i_wea_d_pff => vec_rsc_0_7_i_wea_d_iff
    );
  inPlaceNTT_DIT_core_inst_p_rsc_dat <= p_rsc_dat;
  inPlaceNTT_DIT_core_inst_r_rsc_dat <= r_rsc_dat;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_qa_d <= vec_rsc_0_0_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_1_i_qa_d <= vec_rsc_0_1_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_2_i_qa_d <= vec_rsc_0_2_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_3_i_qa_d <= vec_rsc_0_3_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_4_i_qa_d <= vec_rsc_0_4_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_5_i_qa_d <= vec_rsc_0_5_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_6_i_qa_d <= vec_rsc_0_6_i_qa_d;
  inPlaceNTT_DIT_core_inst_vec_rsc_0_7_i_qa_d <= vec_rsc_0_7_i_qa_d;
  vec_rsc_0_0_i_adra_d_iff <= inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_adra_d_pff;
  vec_rsc_0_0_i_da_d_iff <= inPlaceNTT_DIT_core_inst_vec_rsc_0_0_i_da_d_pff;

END v41;



