
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

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_out_dreg_v2.vhd 
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
PACKAGE mgc_out_dreg_pkg_v2 IS

COMPONENT mgc_out_dreg_v2
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

END mgc_out_dreg_pkg_v2;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY mgc_out_dreg_v2 IS
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END mgc_out_dreg_v2;

ARCHITECTURE beh OF mgc_out_dreg_v2 IS
BEGIN

  z <= d;

END beh;

--------> ../td_ccore_solutions/modulo_dev_0dc217f8ce5f309b848fa994f59fa3f66234_0/rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.5c/896140 Production Release
--  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
-- 
--  Generated by:   yl7897@newnano.poly.edu
--  Generated date: Wed Aug 18 22:11:41 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    modulo_dev_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_out_dreg_pkg_v2.ALL;
USE work.mgc_comps.ALL;


ENTITY modulo_dev_core IS
  PORT(
    base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    return_rsc_z : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    ccs_ccore_start_rsc_dat : IN STD_LOGIC;
    ccs_ccore_clk : IN STD_LOGIC;
    ccs_ccore_srst : IN STD_LOGIC;
    ccs_ccore_en : IN STD_LOGIC
  );
END modulo_dev_core;

ARCHITECTURE v1 OF modulo_dev_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL base_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL return_rsci_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL ccs_ccore_start_rsci_idat : STD_LOGIC;
  SIGNAL rem_2_cmp_z : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_2_cmp_1_z : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_2_cmp_b_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_2_cmp_1_b_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_2_cmp_a_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_2_cmp_1_a_63_0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_dcpl : STD_LOGIC;
  SIGNAL rem_2cyc : STD_LOGIC;
  SIGNAL rem_2cyc_st_2 : STD_LOGIC;
  SIGNAL result_sva_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_3_cse : STD_LOGIC;
  SIGNAL and_5_cse : STD_LOGIC;
  SIGNAL main_stage_0_2 : STD_LOGIC;
  SIGNAL main_stage_0_3 : STD_LOGIC;
  SIGNAL m_buf_sva_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_buf_sva_2 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_buf_sva_3 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL asn_itm_1 : STD_LOGIC;
  SIGNAL asn_itm_2 : STD_LOGIC;
  SIGNAL and_8_cse : STD_LOGIC;
  SIGNAL and_7_cse : STD_LOGIC;

  SIGNAL qelse_acc_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL mux_2_nl : STD_LOGIC;
  SIGNAL base_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL base_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL m_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL return_rsci_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL return_rsci_z : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL ccs_ccore_start_rsci_dat : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL ccs_ccore_start_rsci_idat_1 : STD_LOGIC_VECTOR (0 DOWNTO 0);

  SIGNAL rem_2_cmp_a : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_2_cmp_b : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_2_cmp_z_1 : STD_LOGIC_VECTOR (64 DOWNTO 0);

  SIGNAL rem_2_cmp_1_a : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_2_cmp_1_b : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_2_cmp_1_z_1 : STD_LOGIC_VECTOR (64 DOWNTO 0);

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

BEGIN
  base_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 1,
      width => 64
      )
    PORT MAP(
      dat => base_rsci_dat,
      idat => base_rsci_idat_1
    );
  base_rsci_dat <= base_rsc_dat;
  base_rsci_idat <= base_rsci_idat_1;

  m_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 2,
      width => 64
      )
    PORT MAP(
      dat => m_rsci_dat,
      idat => m_rsci_idat_1
    );
  m_rsci_dat <= m_rsc_dat;
  m_rsci_idat <= m_rsci_idat_1;

  return_rsci : work.mgc_out_dreg_pkg_v2.mgc_out_dreg_v2
    GENERIC MAP(
      rscid => 3,
      width => 64
      )
    PORT MAP(
      d => return_rsci_d_1,
      z => return_rsci_z
    );
  return_rsci_d_1 <= return_rsci_d;
  return_rsc_z <= return_rsci_z;

  ccs_ccore_start_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 8,
      width => 1
      )
    PORT MAP(
      dat => ccs_ccore_start_rsci_dat,
      idat => ccs_ccore_start_rsci_idat_1
    );
  ccs_ccore_start_rsci_dat(0) <= ccs_ccore_start_rsc_dat;
  ccs_ccore_start_rsci_idat <= ccs_ccore_start_rsci_idat_1(0);

  rem_2_cmp : work.mgc_comps.mgc_rem
    GENERIC MAP(
      width_a => 65,
      width_b => 65,
      signd => 1
      )
    PORT MAP(
      a => rem_2_cmp_a,
      b => rem_2_cmp_b,
      z => rem_2_cmp_z_1
    );
  rem_2_cmp_a <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(rem_2_cmp_a_63_0),65));
  rem_2_cmp_b <= '0' & rem_2_cmp_b_63_0;
  rem_2_cmp_z <= rem_2_cmp_z_1;

  rem_2_cmp_1 : work.mgc_comps.mgc_rem
    GENERIC MAP(
      width_a => 65,
      width_b => 65,
      signd => 1
      )
    PORT MAP(
      a => rem_2_cmp_1_a,
      b => rem_2_cmp_1_b,
      z => rem_2_cmp_1_z_1
    );
  rem_2_cmp_1_a <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(rem_2_cmp_1_a_63_0),65));
  rem_2_cmp_1_b <= '0' & rem_2_cmp_1_b_63_0;
  rem_2_cmp_1_z <= rem_2_cmp_1_z_1;

  and_8_cse <= ccs_ccore_en AND main_stage_0_2 AND asn_itm_1;
  and_3_cse <= ccs_ccore_en AND rem_2cyc;
  and_5_cse <= ccs_ccore_en AND (NOT rem_2cyc);
  and_7_cse <= ccs_ccore_en AND ccs_ccore_start_rsci_idat;
  and_dcpl <= main_stage_0_3 AND asn_itm_2;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        return_rsci_d <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        asn_itm_2 <= '0';
        asn_itm_1 <= '0';
        main_stage_0_2 <= '0';
        main_stage_0_3 <= '0';
      ELSIF ( ccs_ccore_en = '1' ) THEN
        return_rsci_d <= MUX_v_64_2_2(result_sva_1, STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(qelse_acc_nl),
            64)), result_sva_1(63));
        asn_itm_2 <= asn_itm_1;
        asn_itm_1 <= ccs_ccore_start_rsci_idat;
        main_stage_0_2 <= '1';
        main_stage_0_3 <= main_stage_0_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        result_sva_1 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (ccs_ccore_en AND and_dcpl) = '1' ) THEN
        result_sva_1 <= MUX_v_64_2_2((rem_2_cmp_1_z(63 DOWNTO 0)), (rem_2_cmp_z(63
            DOWNTO 0)), rem_2cyc_st_2);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        m_buf_sva_3 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (ccs_ccore_en AND mux_2_nl AND and_dcpl) = '1' ) THEN
        m_buf_sva_3 <= m_buf_sva_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_2cyc_st_2 <= '0';
        m_buf_sva_2 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_8_cse = '1' ) THEN
        rem_2cyc_st_2 <= rem_2cyc;
        m_buf_sva_2 <= m_buf_sva_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_2_cmp_1_b_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        rem_2_cmp_1_a_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_3_cse = '1' ) THEN
        rem_2_cmp_1_b_63_0 <= m_rsci_idat;
        rem_2_cmp_1_a_63_0 <= base_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_2_cmp_b_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        rem_2_cmp_a_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_5_cse = '1' ) THEN
        rem_2_cmp_b_63_0 <= m_rsci_idat;
        rem_2_cmp_a_63_0 <= base_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_2cyc <= '0';
        m_buf_sva_1 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_7_cse = '1' ) THEN
        rem_2cyc <= NOT rem_2cyc;
        m_buf_sva_1 <= m_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  qelse_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(result_sva_1) + UNSIGNED(m_buf_sva_3),
      64));
  mux_2_nl <= MUX_s_1_2_2((rem_2_cmp_1_z(63)), (rem_2_cmp_z(63)), rem_2cyc_st_2);
END v1;

-- ------------------------------------------------------------------
--  Design Unit:    modulo_dev
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_out_dreg_pkg_v2.ALL;
USE work.mgc_comps.ALL;


ENTITY modulo_dev IS
  PORT(
    base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    return_rsc_z : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    ccs_ccore_start_rsc_dat : IN STD_LOGIC;
    ccs_ccore_clk : IN STD_LOGIC;
    ccs_ccore_srst : IN STD_LOGIC;
    ccs_ccore_en : IN STD_LOGIC
  );
END modulo_dev;

ARCHITECTURE v1 OF modulo_dev IS
  -- Default Constants

  COMPONENT modulo_dev_core
    PORT(
      base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      return_rsc_z : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      ccs_ccore_start_rsc_dat : IN STD_LOGIC;
      ccs_ccore_clk : IN STD_LOGIC;
      ccs_ccore_srst : IN STD_LOGIC;
      ccs_ccore_en : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL modulo_dev_core_inst_base_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_core_inst_m_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_core_inst_return_rsc_z : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
  modulo_dev_core_inst : modulo_dev_core
    PORT MAP(
      base_rsc_dat => modulo_dev_core_inst_base_rsc_dat,
      m_rsc_dat => modulo_dev_core_inst_m_rsc_dat,
      return_rsc_z => modulo_dev_core_inst_return_rsc_z,
      ccs_ccore_start_rsc_dat => ccs_ccore_start_rsc_dat,
      ccs_ccore_clk => ccs_ccore_clk,
      ccs_ccore_srst => ccs_ccore_srst,
      ccs_ccore_en => ccs_ccore_en
    );
  modulo_dev_core_inst_base_rsc_dat <= base_rsc_dat;
  modulo_dev_core_inst_m_rsc_dat <= m_rsc_dat;
  return_rsc_z <= modulo_dev_core_inst_return_rsc_z;

END v1;




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

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_shift_r_beh_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_shift_r_v5 IS
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
END mgc_shift_r_v5;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

ARCHITECTURE beh OF mgc_shift_r_v5 IS

  FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1 > arg2) THEN
      RETURN(arg1) ;
    ELSE
      RETURN(arg2) ;
    END IF;
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

  FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE)
  RETURN UNSIGNED IS
  BEGIN
    RETURN fshr_stdar(arg1, arg2, '0', olen);
  END;

  FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE)
  RETURN SIGNED IS
  BEGIN
    RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen);
  END;

BEGIN
UNSGNED:  IF signd_a = 0 GENERATE
    z <= std_logic_vector(fshr_stdar(unsigned(a), unsigned(s), width_z));
  END GENERATE;
SGNED:  IF signd_a /= 0 GENERATE
    z <= std_logic_vector(fshr_stdar(  signed(a), unsigned(s), width_z));
  END GENERATE;
END beh;

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
--  Generated date: Thu Aug 19 00:32:04 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_24_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_24_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_24_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_24_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_23_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_23_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_23_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_23_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_22_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_22_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_22_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_22_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_21_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_21_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_21_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_21_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_20_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_20_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_20_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_20_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_19_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_19_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_19_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_19_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_18_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_18_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_18_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_18_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_17_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_17_64_7_128_128_64_5_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_17_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_17_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_16_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_16_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_16_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_16_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_15_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_15_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_15_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_15_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_14_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_14_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_14_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_14_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_13_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_13_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_13_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_13_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_7_128_128_64_5_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_7_128_128_64_5_gen
    IS
  PORT(
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    we_d : IN STD_LOGIC;
    re_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_7_128_128_64_5_gen;

ARCHITECTURE v8 OF DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_7_128_128_64_5_gen
    IS
  -- Default Constants

BEGIN
  we <= (port_1_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
  q_d <= q;
  re <= (port_0_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    IDX_LOOP_C_33_tr0 : IN STD_LOGIC;
    IDX_LOOP_C_65_tr0 : IN STD_LOGIC;
    IDX_LOOP_C_97_tr0 : IN STD_LOGIC;
    IDX_LOOP_C_129_tr0 : IN STD_LOGIC;
    IDX_LOOP_C_161_tr0 : IN STD_LOGIC;
    IDX_LOOP_C_193_tr0 : IN STD_LOGIC;
    IDX_LOOP_C_225_tr0 : IN STD_LOGIC;
    IDX_LOOP_C_257_tr0 : IN STD_LOGIC;
    GROUP_LOOP_C_0_tr0 : IN STD_LOGIC;
    STAGE_LOOP_C_1_tr0 : IN STD_LOGIC
  );
END DIT_RELOOP_core_core_fsm;

ARCHITECTURE v8 OF DIT_RELOOP_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for DIT_RELOOP_core_core_fsm_1
  TYPE DIT_RELOOP_core_core_fsm_1_ST IS (main_C_0, STAGE_LOOP_C_0, IDX_LOOP_C_0,
      IDX_LOOP_C_1, IDX_LOOP_C_2, IDX_LOOP_C_3, IDX_LOOP_C_4, IDX_LOOP_C_5, IDX_LOOP_C_6,
      IDX_LOOP_C_7, IDX_LOOP_C_8, IDX_LOOP_C_9, IDX_LOOP_C_10, IDX_LOOP_C_11, IDX_LOOP_C_12,
      IDX_LOOP_C_13, IDX_LOOP_C_14, IDX_LOOP_C_15, IDX_LOOP_C_16, IDX_LOOP_C_17,
      IDX_LOOP_C_18, IDX_LOOP_C_19, IDX_LOOP_C_20, IDX_LOOP_C_21, IDX_LOOP_C_22,
      IDX_LOOP_C_23, IDX_LOOP_C_24, IDX_LOOP_C_25, IDX_LOOP_C_26, IDX_LOOP_C_27,
      IDX_LOOP_C_28, IDX_LOOP_C_29, IDX_LOOP_C_30, IDX_LOOP_C_31, IDX_LOOP_C_32,
      IDX_LOOP_C_33, IDX_LOOP_C_34, IDX_LOOP_C_35, IDX_LOOP_C_36, IDX_LOOP_C_37,
      IDX_LOOP_C_38, IDX_LOOP_C_39, IDX_LOOP_C_40, IDX_LOOP_C_41, IDX_LOOP_C_42,
      IDX_LOOP_C_43, IDX_LOOP_C_44, IDX_LOOP_C_45, IDX_LOOP_C_46, IDX_LOOP_C_47,
      IDX_LOOP_C_48, IDX_LOOP_C_49, IDX_LOOP_C_50, IDX_LOOP_C_51, IDX_LOOP_C_52,
      IDX_LOOP_C_53, IDX_LOOP_C_54, IDX_LOOP_C_55, IDX_LOOP_C_56, IDX_LOOP_C_57,
      IDX_LOOP_C_58, IDX_LOOP_C_59, IDX_LOOP_C_60, IDX_LOOP_C_61, IDX_LOOP_C_62,
      IDX_LOOP_C_63, IDX_LOOP_C_64, IDX_LOOP_C_65, IDX_LOOP_C_66, IDX_LOOP_C_67,
      IDX_LOOP_C_68, IDX_LOOP_C_69, IDX_LOOP_C_70, IDX_LOOP_C_71, IDX_LOOP_C_72,
      IDX_LOOP_C_73, IDX_LOOP_C_74, IDX_LOOP_C_75, IDX_LOOP_C_76, IDX_LOOP_C_77,
      IDX_LOOP_C_78, IDX_LOOP_C_79, IDX_LOOP_C_80, IDX_LOOP_C_81, IDX_LOOP_C_82,
      IDX_LOOP_C_83, IDX_LOOP_C_84, IDX_LOOP_C_85, IDX_LOOP_C_86, IDX_LOOP_C_87,
      IDX_LOOP_C_88, IDX_LOOP_C_89, IDX_LOOP_C_90, IDX_LOOP_C_91, IDX_LOOP_C_92,
      IDX_LOOP_C_93, IDX_LOOP_C_94, IDX_LOOP_C_95, IDX_LOOP_C_96, IDX_LOOP_C_97,
      IDX_LOOP_C_98, IDX_LOOP_C_99, IDX_LOOP_C_100, IDX_LOOP_C_101, IDX_LOOP_C_102,
      IDX_LOOP_C_103, IDX_LOOP_C_104, IDX_LOOP_C_105, IDX_LOOP_C_106, IDX_LOOP_C_107,
      IDX_LOOP_C_108, IDX_LOOP_C_109, IDX_LOOP_C_110, IDX_LOOP_C_111, IDX_LOOP_C_112,
      IDX_LOOP_C_113, IDX_LOOP_C_114, IDX_LOOP_C_115, IDX_LOOP_C_116, IDX_LOOP_C_117,
      IDX_LOOP_C_118, IDX_LOOP_C_119, IDX_LOOP_C_120, IDX_LOOP_C_121, IDX_LOOP_C_122,
      IDX_LOOP_C_123, IDX_LOOP_C_124, IDX_LOOP_C_125, IDX_LOOP_C_126, IDX_LOOP_C_127,
      IDX_LOOP_C_128, IDX_LOOP_C_129, IDX_LOOP_C_130, IDX_LOOP_C_131, IDX_LOOP_C_132,
      IDX_LOOP_C_133, IDX_LOOP_C_134, IDX_LOOP_C_135, IDX_LOOP_C_136, IDX_LOOP_C_137,
      IDX_LOOP_C_138, IDX_LOOP_C_139, IDX_LOOP_C_140, IDX_LOOP_C_141, IDX_LOOP_C_142,
      IDX_LOOP_C_143, IDX_LOOP_C_144, IDX_LOOP_C_145, IDX_LOOP_C_146, IDX_LOOP_C_147,
      IDX_LOOP_C_148, IDX_LOOP_C_149, IDX_LOOP_C_150, IDX_LOOP_C_151, IDX_LOOP_C_152,
      IDX_LOOP_C_153, IDX_LOOP_C_154, IDX_LOOP_C_155, IDX_LOOP_C_156, IDX_LOOP_C_157,
      IDX_LOOP_C_158, IDX_LOOP_C_159, IDX_LOOP_C_160, IDX_LOOP_C_161, IDX_LOOP_C_162,
      IDX_LOOP_C_163, IDX_LOOP_C_164, IDX_LOOP_C_165, IDX_LOOP_C_166, IDX_LOOP_C_167,
      IDX_LOOP_C_168, IDX_LOOP_C_169, IDX_LOOP_C_170, IDX_LOOP_C_171, IDX_LOOP_C_172,
      IDX_LOOP_C_173, IDX_LOOP_C_174, IDX_LOOP_C_175, IDX_LOOP_C_176, IDX_LOOP_C_177,
      IDX_LOOP_C_178, IDX_LOOP_C_179, IDX_LOOP_C_180, IDX_LOOP_C_181, IDX_LOOP_C_182,
      IDX_LOOP_C_183, IDX_LOOP_C_184, IDX_LOOP_C_185, IDX_LOOP_C_186, IDX_LOOP_C_187,
      IDX_LOOP_C_188, IDX_LOOP_C_189, IDX_LOOP_C_190, IDX_LOOP_C_191, IDX_LOOP_C_192,
      IDX_LOOP_C_193, IDX_LOOP_C_194, IDX_LOOP_C_195, IDX_LOOP_C_196, IDX_LOOP_C_197,
      IDX_LOOP_C_198, IDX_LOOP_C_199, IDX_LOOP_C_200, IDX_LOOP_C_201, IDX_LOOP_C_202,
      IDX_LOOP_C_203, IDX_LOOP_C_204, IDX_LOOP_C_205, IDX_LOOP_C_206, IDX_LOOP_C_207,
      IDX_LOOP_C_208, IDX_LOOP_C_209, IDX_LOOP_C_210, IDX_LOOP_C_211, IDX_LOOP_C_212,
      IDX_LOOP_C_213, IDX_LOOP_C_214, IDX_LOOP_C_215, IDX_LOOP_C_216, IDX_LOOP_C_217,
      IDX_LOOP_C_218, IDX_LOOP_C_219, IDX_LOOP_C_220, IDX_LOOP_C_221, IDX_LOOP_C_222,
      IDX_LOOP_C_223, IDX_LOOP_C_224, IDX_LOOP_C_225, IDX_LOOP_C_226, IDX_LOOP_C_227,
      IDX_LOOP_C_228, IDX_LOOP_C_229, IDX_LOOP_C_230, IDX_LOOP_C_231, IDX_LOOP_C_232,
      IDX_LOOP_C_233, IDX_LOOP_C_234, IDX_LOOP_C_235, IDX_LOOP_C_236, IDX_LOOP_C_237,
      IDX_LOOP_C_238, IDX_LOOP_C_239, IDX_LOOP_C_240, IDX_LOOP_C_241, IDX_LOOP_C_242,
      IDX_LOOP_C_243, IDX_LOOP_C_244, IDX_LOOP_C_245, IDX_LOOP_C_246, IDX_LOOP_C_247,
      IDX_LOOP_C_248, IDX_LOOP_C_249, IDX_LOOP_C_250, IDX_LOOP_C_251, IDX_LOOP_C_252,
      IDX_LOOP_C_253, IDX_LOOP_C_254, IDX_LOOP_C_255, IDX_LOOP_C_256, IDX_LOOP_C_257,
      GROUP_LOOP_C_0, STAGE_LOOP_C_1, main_C_1);

  SIGNAL state_var : DIT_RELOOP_core_core_fsm_1_ST;
  SIGNAL state_var_NS : DIT_RELOOP_core_core_fsm_1_ST;

BEGIN
  DIT_RELOOP_core_core_fsm_1 : PROCESS (IDX_LOOP_C_33_tr0, IDX_LOOP_C_65_tr0, IDX_LOOP_C_97_tr0,
      IDX_LOOP_C_129_tr0, IDX_LOOP_C_161_tr0, IDX_LOOP_C_193_tr0, IDX_LOOP_C_225_tr0,
      IDX_LOOP_C_257_tr0, GROUP_LOOP_C_0_tr0, STAGE_LOOP_C_1_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN STAGE_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000001");
        state_var_NS <= IDX_LOOP_C_0;
      WHEN IDX_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000010");
        state_var_NS <= IDX_LOOP_C_1;
      WHEN IDX_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000011");
        state_var_NS <= IDX_LOOP_C_2;
      WHEN IDX_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000100");
        state_var_NS <= IDX_LOOP_C_3;
      WHEN IDX_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000101");
        state_var_NS <= IDX_LOOP_C_4;
      WHEN IDX_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000110");
        state_var_NS <= IDX_LOOP_C_5;
      WHEN IDX_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000111");
        state_var_NS <= IDX_LOOP_C_6;
      WHEN IDX_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001000");
        state_var_NS <= IDX_LOOP_C_7;
      WHEN IDX_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001001");
        state_var_NS <= IDX_LOOP_C_8;
      WHEN IDX_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001010");
        state_var_NS <= IDX_LOOP_C_9;
      WHEN IDX_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001011");
        state_var_NS <= IDX_LOOP_C_10;
      WHEN IDX_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001100");
        state_var_NS <= IDX_LOOP_C_11;
      WHEN IDX_LOOP_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001101");
        state_var_NS <= IDX_LOOP_C_12;
      WHEN IDX_LOOP_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001110");
        state_var_NS <= IDX_LOOP_C_13;
      WHEN IDX_LOOP_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001111");
        state_var_NS <= IDX_LOOP_C_14;
      WHEN IDX_LOOP_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010000");
        state_var_NS <= IDX_LOOP_C_15;
      WHEN IDX_LOOP_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010001");
        state_var_NS <= IDX_LOOP_C_16;
      WHEN IDX_LOOP_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010010");
        state_var_NS <= IDX_LOOP_C_17;
      WHEN IDX_LOOP_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010011");
        state_var_NS <= IDX_LOOP_C_18;
      WHEN IDX_LOOP_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010100");
        state_var_NS <= IDX_LOOP_C_19;
      WHEN IDX_LOOP_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010101");
        state_var_NS <= IDX_LOOP_C_20;
      WHEN IDX_LOOP_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010110");
        state_var_NS <= IDX_LOOP_C_21;
      WHEN IDX_LOOP_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010111");
        state_var_NS <= IDX_LOOP_C_22;
      WHEN IDX_LOOP_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011000");
        state_var_NS <= IDX_LOOP_C_23;
      WHEN IDX_LOOP_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011001");
        state_var_NS <= IDX_LOOP_C_24;
      WHEN IDX_LOOP_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011010");
        state_var_NS <= IDX_LOOP_C_25;
      WHEN IDX_LOOP_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011011");
        state_var_NS <= IDX_LOOP_C_26;
      WHEN IDX_LOOP_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011100");
        state_var_NS <= IDX_LOOP_C_27;
      WHEN IDX_LOOP_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011101");
        state_var_NS <= IDX_LOOP_C_28;
      WHEN IDX_LOOP_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011110");
        state_var_NS <= IDX_LOOP_C_29;
      WHEN IDX_LOOP_C_29 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000011111");
        state_var_NS <= IDX_LOOP_C_30;
      WHEN IDX_LOOP_C_30 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100000");
        state_var_NS <= IDX_LOOP_C_31;
      WHEN IDX_LOOP_C_31 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100001");
        state_var_NS <= IDX_LOOP_C_32;
      WHEN IDX_LOOP_C_32 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100010");
        state_var_NS <= IDX_LOOP_C_33;
      WHEN IDX_LOOP_C_33 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100011");
        IF ( IDX_LOOP_C_33_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_34;
        END IF;
      WHEN IDX_LOOP_C_34 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100100");
        state_var_NS <= IDX_LOOP_C_35;
      WHEN IDX_LOOP_C_35 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100101");
        state_var_NS <= IDX_LOOP_C_36;
      WHEN IDX_LOOP_C_36 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100110");
        state_var_NS <= IDX_LOOP_C_37;
      WHEN IDX_LOOP_C_37 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100111");
        state_var_NS <= IDX_LOOP_C_38;
      WHEN IDX_LOOP_C_38 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101000");
        state_var_NS <= IDX_LOOP_C_39;
      WHEN IDX_LOOP_C_39 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101001");
        state_var_NS <= IDX_LOOP_C_40;
      WHEN IDX_LOOP_C_40 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101010");
        state_var_NS <= IDX_LOOP_C_41;
      WHEN IDX_LOOP_C_41 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101011");
        state_var_NS <= IDX_LOOP_C_42;
      WHEN IDX_LOOP_C_42 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101100");
        state_var_NS <= IDX_LOOP_C_43;
      WHEN IDX_LOOP_C_43 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101101");
        state_var_NS <= IDX_LOOP_C_44;
      WHEN IDX_LOOP_C_44 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101110");
        state_var_NS <= IDX_LOOP_C_45;
      WHEN IDX_LOOP_C_45 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000101111");
        state_var_NS <= IDX_LOOP_C_46;
      WHEN IDX_LOOP_C_46 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110000");
        state_var_NS <= IDX_LOOP_C_47;
      WHEN IDX_LOOP_C_47 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110001");
        state_var_NS <= IDX_LOOP_C_48;
      WHEN IDX_LOOP_C_48 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110010");
        state_var_NS <= IDX_LOOP_C_49;
      WHEN IDX_LOOP_C_49 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110011");
        state_var_NS <= IDX_LOOP_C_50;
      WHEN IDX_LOOP_C_50 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110100");
        state_var_NS <= IDX_LOOP_C_51;
      WHEN IDX_LOOP_C_51 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110101");
        state_var_NS <= IDX_LOOP_C_52;
      WHEN IDX_LOOP_C_52 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110110");
        state_var_NS <= IDX_LOOP_C_53;
      WHEN IDX_LOOP_C_53 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000110111");
        state_var_NS <= IDX_LOOP_C_54;
      WHEN IDX_LOOP_C_54 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111000");
        state_var_NS <= IDX_LOOP_C_55;
      WHEN IDX_LOOP_C_55 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111001");
        state_var_NS <= IDX_LOOP_C_56;
      WHEN IDX_LOOP_C_56 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111010");
        state_var_NS <= IDX_LOOP_C_57;
      WHEN IDX_LOOP_C_57 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111011");
        state_var_NS <= IDX_LOOP_C_58;
      WHEN IDX_LOOP_C_58 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111100");
        state_var_NS <= IDX_LOOP_C_59;
      WHEN IDX_LOOP_C_59 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111101");
        state_var_NS <= IDX_LOOP_C_60;
      WHEN IDX_LOOP_C_60 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111110");
        state_var_NS <= IDX_LOOP_C_61;
      WHEN IDX_LOOP_C_61 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000111111");
        state_var_NS <= IDX_LOOP_C_62;
      WHEN IDX_LOOP_C_62 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000000");
        state_var_NS <= IDX_LOOP_C_63;
      WHEN IDX_LOOP_C_63 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000001");
        state_var_NS <= IDX_LOOP_C_64;
      WHEN IDX_LOOP_C_64 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000010");
        state_var_NS <= IDX_LOOP_C_65;
      WHEN IDX_LOOP_C_65 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000011");
        IF ( IDX_LOOP_C_65_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_66;
        END IF;
      WHEN IDX_LOOP_C_66 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000100");
        state_var_NS <= IDX_LOOP_C_67;
      WHEN IDX_LOOP_C_67 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000101");
        state_var_NS <= IDX_LOOP_C_68;
      WHEN IDX_LOOP_C_68 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000110");
        state_var_NS <= IDX_LOOP_C_69;
      WHEN IDX_LOOP_C_69 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000111");
        state_var_NS <= IDX_LOOP_C_70;
      WHEN IDX_LOOP_C_70 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001000");
        state_var_NS <= IDX_LOOP_C_71;
      WHEN IDX_LOOP_C_71 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001001");
        state_var_NS <= IDX_LOOP_C_72;
      WHEN IDX_LOOP_C_72 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001010");
        state_var_NS <= IDX_LOOP_C_73;
      WHEN IDX_LOOP_C_73 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001011");
        state_var_NS <= IDX_LOOP_C_74;
      WHEN IDX_LOOP_C_74 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001100");
        state_var_NS <= IDX_LOOP_C_75;
      WHEN IDX_LOOP_C_75 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001101");
        state_var_NS <= IDX_LOOP_C_76;
      WHEN IDX_LOOP_C_76 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001110");
        state_var_NS <= IDX_LOOP_C_77;
      WHEN IDX_LOOP_C_77 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001001111");
        state_var_NS <= IDX_LOOP_C_78;
      WHEN IDX_LOOP_C_78 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010000");
        state_var_NS <= IDX_LOOP_C_79;
      WHEN IDX_LOOP_C_79 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010001");
        state_var_NS <= IDX_LOOP_C_80;
      WHEN IDX_LOOP_C_80 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010010");
        state_var_NS <= IDX_LOOP_C_81;
      WHEN IDX_LOOP_C_81 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010011");
        state_var_NS <= IDX_LOOP_C_82;
      WHEN IDX_LOOP_C_82 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010100");
        state_var_NS <= IDX_LOOP_C_83;
      WHEN IDX_LOOP_C_83 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010101");
        state_var_NS <= IDX_LOOP_C_84;
      WHEN IDX_LOOP_C_84 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010110");
        state_var_NS <= IDX_LOOP_C_85;
      WHEN IDX_LOOP_C_85 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001010111");
        state_var_NS <= IDX_LOOP_C_86;
      WHEN IDX_LOOP_C_86 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011000");
        state_var_NS <= IDX_LOOP_C_87;
      WHEN IDX_LOOP_C_87 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011001");
        state_var_NS <= IDX_LOOP_C_88;
      WHEN IDX_LOOP_C_88 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011010");
        state_var_NS <= IDX_LOOP_C_89;
      WHEN IDX_LOOP_C_89 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011011");
        state_var_NS <= IDX_LOOP_C_90;
      WHEN IDX_LOOP_C_90 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011100");
        state_var_NS <= IDX_LOOP_C_91;
      WHEN IDX_LOOP_C_91 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011101");
        state_var_NS <= IDX_LOOP_C_92;
      WHEN IDX_LOOP_C_92 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011110");
        state_var_NS <= IDX_LOOP_C_93;
      WHEN IDX_LOOP_C_93 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001011111");
        state_var_NS <= IDX_LOOP_C_94;
      WHEN IDX_LOOP_C_94 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100000");
        state_var_NS <= IDX_LOOP_C_95;
      WHEN IDX_LOOP_C_95 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100001");
        state_var_NS <= IDX_LOOP_C_96;
      WHEN IDX_LOOP_C_96 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100010");
        state_var_NS <= IDX_LOOP_C_97;
      WHEN IDX_LOOP_C_97 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100011");
        IF ( IDX_LOOP_C_97_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_98;
        END IF;
      WHEN IDX_LOOP_C_98 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100100");
        state_var_NS <= IDX_LOOP_C_99;
      WHEN IDX_LOOP_C_99 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100101");
        state_var_NS <= IDX_LOOP_C_100;
      WHEN IDX_LOOP_C_100 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100110");
        state_var_NS <= IDX_LOOP_C_101;
      WHEN IDX_LOOP_C_101 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001100111");
        state_var_NS <= IDX_LOOP_C_102;
      WHEN IDX_LOOP_C_102 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101000");
        state_var_NS <= IDX_LOOP_C_103;
      WHEN IDX_LOOP_C_103 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101001");
        state_var_NS <= IDX_LOOP_C_104;
      WHEN IDX_LOOP_C_104 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101010");
        state_var_NS <= IDX_LOOP_C_105;
      WHEN IDX_LOOP_C_105 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101011");
        state_var_NS <= IDX_LOOP_C_106;
      WHEN IDX_LOOP_C_106 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101100");
        state_var_NS <= IDX_LOOP_C_107;
      WHEN IDX_LOOP_C_107 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101101");
        state_var_NS <= IDX_LOOP_C_108;
      WHEN IDX_LOOP_C_108 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101110");
        state_var_NS <= IDX_LOOP_C_109;
      WHEN IDX_LOOP_C_109 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001101111");
        state_var_NS <= IDX_LOOP_C_110;
      WHEN IDX_LOOP_C_110 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110000");
        state_var_NS <= IDX_LOOP_C_111;
      WHEN IDX_LOOP_C_111 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110001");
        state_var_NS <= IDX_LOOP_C_112;
      WHEN IDX_LOOP_C_112 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110010");
        state_var_NS <= IDX_LOOP_C_113;
      WHEN IDX_LOOP_C_113 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110011");
        state_var_NS <= IDX_LOOP_C_114;
      WHEN IDX_LOOP_C_114 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110100");
        state_var_NS <= IDX_LOOP_C_115;
      WHEN IDX_LOOP_C_115 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110101");
        state_var_NS <= IDX_LOOP_C_116;
      WHEN IDX_LOOP_C_116 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110110");
        state_var_NS <= IDX_LOOP_C_117;
      WHEN IDX_LOOP_C_117 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001110111");
        state_var_NS <= IDX_LOOP_C_118;
      WHEN IDX_LOOP_C_118 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111000");
        state_var_NS <= IDX_LOOP_C_119;
      WHEN IDX_LOOP_C_119 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111001");
        state_var_NS <= IDX_LOOP_C_120;
      WHEN IDX_LOOP_C_120 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111010");
        state_var_NS <= IDX_LOOP_C_121;
      WHEN IDX_LOOP_C_121 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111011");
        state_var_NS <= IDX_LOOP_C_122;
      WHEN IDX_LOOP_C_122 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111100");
        state_var_NS <= IDX_LOOP_C_123;
      WHEN IDX_LOOP_C_123 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111101");
        state_var_NS <= IDX_LOOP_C_124;
      WHEN IDX_LOOP_C_124 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111110");
        state_var_NS <= IDX_LOOP_C_125;
      WHEN IDX_LOOP_C_125 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001111111");
        state_var_NS <= IDX_LOOP_C_126;
      WHEN IDX_LOOP_C_126 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000000");
        state_var_NS <= IDX_LOOP_C_127;
      WHEN IDX_LOOP_C_127 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000001");
        state_var_NS <= IDX_LOOP_C_128;
      WHEN IDX_LOOP_C_128 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000010");
        state_var_NS <= IDX_LOOP_C_129;
      WHEN IDX_LOOP_C_129 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000011");
        IF ( IDX_LOOP_C_129_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_130;
        END IF;
      WHEN IDX_LOOP_C_130 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000100");
        state_var_NS <= IDX_LOOP_C_131;
      WHEN IDX_LOOP_C_131 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000101");
        state_var_NS <= IDX_LOOP_C_132;
      WHEN IDX_LOOP_C_132 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000110");
        state_var_NS <= IDX_LOOP_C_133;
      WHEN IDX_LOOP_C_133 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000111");
        state_var_NS <= IDX_LOOP_C_134;
      WHEN IDX_LOOP_C_134 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001000");
        state_var_NS <= IDX_LOOP_C_135;
      WHEN IDX_LOOP_C_135 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001001");
        state_var_NS <= IDX_LOOP_C_136;
      WHEN IDX_LOOP_C_136 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001010");
        state_var_NS <= IDX_LOOP_C_137;
      WHEN IDX_LOOP_C_137 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001011");
        state_var_NS <= IDX_LOOP_C_138;
      WHEN IDX_LOOP_C_138 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001100");
        state_var_NS <= IDX_LOOP_C_139;
      WHEN IDX_LOOP_C_139 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001101");
        state_var_NS <= IDX_LOOP_C_140;
      WHEN IDX_LOOP_C_140 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001110");
        state_var_NS <= IDX_LOOP_C_141;
      WHEN IDX_LOOP_C_141 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010001111");
        state_var_NS <= IDX_LOOP_C_142;
      WHEN IDX_LOOP_C_142 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010000");
        state_var_NS <= IDX_LOOP_C_143;
      WHEN IDX_LOOP_C_143 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010001");
        state_var_NS <= IDX_LOOP_C_144;
      WHEN IDX_LOOP_C_144 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010010");
        state_var_NS <= IDX_LOOP_C_145;
      WHEN IDX_LOOP_C_145 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010011");
        state_var_NS <= IDX_LOOP_C_146;
      WHEN IDX_LOOP_C_146 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010100");
        state_var_NS <= IDX_LOOP_C_147;
      WHEN IDX_LOOP_C_147 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010101");
        state_var_NS <= IDX_LOOP_C_148;
      WHEN IDX_LOOP_C_148 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010110");
        state_var_NS <= IDX_LOOP_C_149;
      WHEN IDX_LOOP_C_149 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010010111");
        state_var_NS <= IDX_LOOP_C_150;
      WHEN IDX_LOOP_C_150 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011000");
        state_var_NS <= IDX_LOOP_C_151;
      WHEN IDX_LOOP_C_151 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011001");
        state_var_NS <= IDX_LOOP_C_152;
      WHEN IDX_LOOP_C_152 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011010");
        state_var_NS <= IDX_LOOP_C_153;
      WHEN IDX_LOOP_C_153 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011011");
        state_var_NS <= IDX_LOOP_C_154;
      WHEN IDX_LOOP_C_154 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011100");
        state_var_NS <= IDX_LOOP_C_155;
      WHEN IDX_LOOP_C_155 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011101");
        state_var_NS <= IDX_LOOP_C_156;
      WHEN IDX_LOOP_C_156 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011110");
        state_var_NS <= IDX_LOOP_C_157;
      WHEN IDX_LOOP_C_157 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010011111");
        state_var_NS <= IDX_LOOP_C_158;
      WHEN IDX_LOOP_C_158 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100000");
        state_var_NS <= IDX_LOOP_C_159;
      WHEN IDX_LOOP_C_159 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100001");
        state_var_NS <= IDX_LOOP_C_160;
      WHEN IDX_LOOP_C_160 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100010");
        state_var_NS <= IDX_LOOP_C_161;
      WHEN IDX_LOOP_C_161 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100011");
        IF ( IDX_LOOP_C_161_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_162;
        END IF;
      WHEN IDX_LOOP_C_162 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100100");
        state_var_NS <= IDX_LOOP_C_163;
      WHEN IDX_LOOP_C_163 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100101");
        state_var_NS <= IDX_LOOP_C_164;
      WHEN IDX_LOOP_C_164 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100110");
        state_var_NS <= IDX_LOOP_C_165;
      WHEN IDX_LOOP_C_165 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010100111");
        state_var_NS <= IDX_LOOP_C_166;
      WHEN IDX_LOOP_C_166 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101000");
        state_var_NS <= IDX_LOOP_C_167;
      WHEN IDX_LOOP_C_167 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101001");
        state_var_NS <= IDX_LOOP_C_168;
      WHEN IDX_LOOP_C_168 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101010");
        state_var_NS <= IDX_LOOP_C_169;
      WHEN IDX_LOOP_C_169 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101011");
        state_var_NS <= IDX_LOOP_C_170;
      WHEN IDX_LOOP_C_170 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101100");
        state_var_NS <= IDX_LOOP_C_171;
      WHEN IDX_LOOP_C_171 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101101");
        state_var_NS <= IDX_LOOP_C_172;
      WHEN IDX_LOOP_C_172 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101110");
        state_var_NS <= IDX_LOOP_C_173;
      WHEN IDX_LOOP_C_173 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010101111");
        state_var_NS <= IDX_LOOP_C_174;
      WHEN IDX_LOOP_C_174 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110000");
        state_var_NS <= IDX_LOOP_C_175;
      WHEN IDX_LOOP_C_175 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110001");
        state_var_NS <= IDX_LOOP_C_176;
      WHEN IDX_LOOP_C_176 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110010");
        state_var_NS <= IDX_LOOP_C_177;
      WHEN IDX_LOOP_C_177 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110011");
        state_var_NS <= IDX_LOOP_C_178;
      WHEN IDX_LOOP_C_178 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110100");
        state_var_NS <= IDX_LOOP_C_179;
      WHEN IDX_LOOP_C_179 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110101");
        state_var_NS <= IDX_LOOP_C_180;
      WHEN IDX_LOOP_C_180 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110110");
        state_var_NS <= IDX_LOOP_C_181;
      WHEN IDX_LOOP_C_181 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010110111");
        state_var_NS <= IDX_LOOP_C_182;
      WHEN IDX_LOOP_C_182 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111000");
        state_var_NS <= IDX_LOOP_C_183;
      WHEN IDX_LOOP_C_183 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111001");
        state_var_NS <= IDX_LOOP_C_184;
      WHEN IDX_LOOP_C_184 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111010");
        state_var_NS <= IDX_LOOP_C_185;
      WHEN IDX_LOOP_C_185 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111011");
        state_var_NS <= IDX_LOOP_C_186;
      WHEN IDX_LOOP_C_186 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111100");
        state_var_NS <= IDX_LOOP_C_187;
      WHEN IDX_LOOP_C_187 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111101");
        state_var_NS <= IDX_LOOP_C_188;
      WHEN IDX_LOOP_C_188 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111110");
        state_var_NS <= IDX_LOOP_C_189;
      WHEN IDX_LOOP_C_189 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010111111");
        state_var_NS <= IDX_LOOP_C_190;
      WHEN IDX_LOOP_C_190 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000000");
        state_var_NS <= IDX_LOOP_C_191;
      WHEN IDX_LOOP_C_191 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000001");
        state_var_NS <= IDX_LOOP_C_192;
      WHEN IDX_LOOP_C_192 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000010");
        state_var_NS <= IDX_LOOP_C_193;
      WHEN IDX_LOOP_C_193 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000011");
        IF ( IDX_LOOP_C_193_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_194;
        END IF;
      WHEN IDX_LOOP_C_194 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000100");
        state_var_NS <= IDX_LOOP_C_195;
      WHEN IDX_LOOP_C_195 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000101");
        state_var_NS <= IDX_LOOP_C_196;
      WHEN IDX_LOOP_C_196 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000110");
        state_var_NS <= IDX_LOOP_C_197;
      WHEN IDX_LOOP_C_197 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011000111");
        state_var_NS <= IDX_LOOP_C_198;
      WHEN IDX_LOOP_C_198 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001000");
        state_var_NS <= IDX_LOOP_C_199;
      WHEN IDX_LOOP_C_199 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001001");
        state_var_NS <= IDX_LOOP_C_200;
      WHEN IDX_LOOP_C_200 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001010");
        state_var_NS <= IDX_LOOP_C_201;
      WHEN IDX_LOOP_C_201 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001011");
        state_var_NS <= IDX_LOOP_C_202;
      WHEN IDX_LOOP_C_202 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001100");
        state_var_NS <= IDX_LOOP_C_203;
      WHEN IDX_LOOP_C_203 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001101");
        state_var_NS <= IDX_LOOP_C_204;
      WHEN IDX_LOOP_C_204 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001110");
        state_var_NS <= IDX_LOOP_C_205;
      WHEN IDX_LOOP_C_205 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011001111");
        state_var_NS <= IDX_LOOP_C_206;
      WHEN IDX_LOOP_C_206 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010000");
        state_var_NS <= IDX_LOOP_C_207;
      WHEN IDX_LOOP_C_207 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010001");
        state_var_NS <= IDX_LOOP_C_208;
      WHEN IDX_LOOP_C_208 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010010");
        state_var_NS <= IDX_LOOP_C_209;
      WHEN IDX_LOOP_C_209 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010011");
        state_var_NS <= IDX_LOOP_C_210;
      WHEN IDX_LOOP_C_210 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010100");
        state_var_NS <= IDX_LOOP_C_211;
      WHEN IDX_LOOP_C_211 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010101");
        state_var_NS <= IDX_LOOP_C_212;
      WHEN IDX_LOOP_C_212 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010110");
        state_var_NS <= IDX_LOOP_C_213;
      WHEN IDX_LOOP_C_213 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011010111");
        state_var_NS <= IDX_LOOP_C_214;
      WHEN IDX_LOOP_C_214 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011000");
        state_var_NS <= IDX_LOOP_C_215;
      WHEN IDX_LOOP_C_215 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011001");
        state_var_NS <= IDX_LOOP_C_216;
      WHEN IDX_LOOP_C_216 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011010");
        state_var_NS <= IDX_LOOP_C_217;
      WHEN IDX_LOOP_C_217 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011011");
        state_var_NS <= IDX_LOOP_C_218;
      WHEN IDX_LOOP_C_218 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011100");
        state_var_NS <= IDX_LOOP_C_219;
      WHEN IDX_LOOP_C_219 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011101");
        state_var_NS <= IDX_LOOP_C_220;
      WHEN IDX_LOOP_C_220 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011110");
        state_var_NS <= IDX_LOOP_C_221;
      WHEN IDX_LOOP_C_221 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011011111");
        state_var_NS <= IDX_LOOP_C_222;
      WHEN IDX_LOOP_C_222 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100000");
        state_var_NS <= IDX_LOOP_C_223;
      WHEN IDX_LOOP_C_223 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100001");
        state_var_NS <= IDX_LOOP_C_224;
      WHEN IDX_LOOP_C_224 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100010");
        state_var_NS <= IDX_LOOP_C_225;
      WHEN IDX_LOOP_C_225 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100011");
        IF ( IDX_LOOP_C_225_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_226;
        END IF;
      WHEN IDX_LOOP_C_226 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100100");
        state_var_NS <= IDX_LOOP_C_227;
      WHEN IDX_LOOP_C_227 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100101");
        state_var_NS <= IDX_LOOP_C_228;
      WHEN IDX_LOOP_C_228 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100110");
        state_var_NS <= IDX_LOOP_C_229;
      WHEN IDX_LOOP_C_229 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011100111");
        state_var_NS <= IDX_LOOP_C_230;
      WHEN IDX_LOOP_C_230 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101000");
        state_var_NS <= IDX_LOOP_C_231;
      WHEN IDX_LOOP_C_231 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101001");
        state_var_NS <= IDX_LOOP_C_232;
      WHEN IDX_LOOP_C_232 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101010");
        state_var_NS <= IDX_LOOP_C_233;
      WHEN IDX_LOOP_C_233 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101011");
        state_var_NS <= IDX_LOOP_C_234;
      WHEN IDX_LOOP_C_234 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101100");
        state_var_NS <= IDX_LOOP_C_235;
      WHEN IDX_LOOP_C_235 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101101");
        state_var_NS <= IDX_LOOP_C_236;
      WHEN IDX_LOOP_C_236 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101110");
        state_var_NS <= IDX_LOOP_C_237;
      WHEN IDX_LOOP_C_237 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011101111");
        state_var_NS <= IDX_LOOP_C_238;
      WHEN IDX_LOOP_C_238 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110000");
        state_var_NS <= IDX_LOOP_C_239;
      WHEN IDX_LOOP_C_239 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110001");
        state_var_NS <= IDX_LOOP_C_240;
      WHEN IDX_LOOP_C_240 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110010");
        state_var_NS <= IDX_LOOP_C_241;
      WHEN IDX_LOOP_C_241 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110011");
        state_var_NS <= IDX_LOOP_C_242;
      WHEN IDX_LOOP_C_242 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110100");
        state_var_NS <= IDX_LOOP_C_243;
      WHEN IDX_LOOP_C_243 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110101");
        state_var_NS <= IDX_LOOP_C_244;
      WHEN IDX_LOOP_C_244 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110110");
        state_var_NS <= IDX_LOOP_C_245;
      WHEN IDX_LOOP_C_245 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011110111");
        state_var_NS <= IDX_LOOP_C_246;
      WHEN IDX_LOOP_C_246 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111000");
        state_var_NS <= IDX_LOOP_C_247;
      WHEN IDX_LOOP_C_247 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111001");
        state_var_NS <= IDX_LOOP_C_248;
      WHEN IDX_LOOP_C_248 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111010");
        state_var_NS <= IDX_LOOP_C_249;
      WHEN IDX_LOOP_C_249 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111011");
        state_var_NS <= IDX_LOOP_C_250;
      WHEN IDX_LOOP_C_250 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111100");
        state_var_NS <= IDX_LOOP_C_251;
      WHEN IDX_LOOP_C_251 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111101");
        state_var_NS <= IDX_LOOP_C_252;
      WHEN IDX_LOOP_C_252 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111110");
        state_var_NS <= IDX_LOOP_C_253;
      WHEN IDX_LOOP_C_253 =>
        fsm_output <= STD_LOGIC_VECTOR'( "011111111");
        state_var_NS <= IDX_LOOP_C_254;
      WHEN IDX_LOOP_C_254 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000000");
        state_var_NS <= IDX_LOOP_C_255;
      WHEN IDX_LOOP_C_255 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000001");
        state_var_NS <= IDX_LOOP_C_256;
      WHEN IDX_LOOP_C_256 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000010");
        state_var_NS <= IDX_LOOP_C_257;
      WHEN IDX_LOOP_C_257 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000011");
        IF ( IDX_LOOP_C_257_tr0 = '1' ) THEN
          state_var_NS <= GROUP_LOOP_C_0;
        ELSE
          state_var_NS <= IDX_LOOP_C_0;
        END IF;
      WHEN GROUP_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000100");
        IF ( GROUP_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= STAGE_LOOP_C_1;
        ELSE
          state_var_NS <= IDX_LOOP_C_0;
        END IF;
      WHEN STAGE_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000101");
        IF ( STAGE_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= STAGE_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000110");
        state_var_NS <= main_C_0;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000");
        state_var_NS <= STAGE_LOOP_C_0;
    END CASE;
  END PROCESS DIT_RELOOP_core_core_fsm_1;

  DIT_RELOOP_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= main_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS DIT_RELOOP_core_core_fsm_1_REG;

END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_core_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_core_wait_dp IS
  PORT(
    ensig_cgo_iro : IN STD_LOGIC;
    ensig_cgo : IN STD_LOGIC;
    IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en : OUT STD_LOGIC
  );
END DIT_RELOOP_core_wait_dp;

ARCHITECTURE v8 OF DIT_RELOOP_core_wait_dp IS
  -- Default Constants

BEGIN
  IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en <= ensig_cgo OR ensig_cgo_iro;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP_core IS
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
    r_rsc_triosy_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_2_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_3_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_4_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_5_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_6_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_0_7_lz : OUT STD_LOGIC;
    vec_rsc_0_0_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_0_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_1_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_2_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_2_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_3_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_3_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_4_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_4_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_5_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_5_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_6_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_6_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_7_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_7_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_0_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_1_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_2_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_3_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_4_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_5_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_6_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_0_7_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_wadr_d_pff : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_0_i_d_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_0_i_re_d_pff : OUT STD_LOGIC;
    vec_rsc_0_1_i_wadr_d_pff : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_1_i_d_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_1_i_re_d_pff : OUT STD_LOGIC;
    vec_rsc_0_2_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_2_i_re_d_pff : OUT STD_LOGIC;
    vec_rsc_0_3_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_3_i_re_d_pff : OUT STD_LOGIC;
    vec_rsc_0_4_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_4_i_re_d_pff : OUT STD_LOGIC;
    vec_rsc_0_5_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_5_i_re_d_pff : OUT STD_LOGIC;
    vec_rsc_0_6_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_6_i_re_d_pff : OUT STD_LOGIC;
    vec_rsc_0_7_i_we_d_pff : OUT STD_LOGIC;
    vec_rsc_0_7_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_0_i_radr_d_pff : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_0_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_1_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_2_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_3_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_4_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_5_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_6_i_re_d_pff : OUT STD_LOGIC;
    twiddle_rsc_0_7_i_re_d_pff : OUT STD_LOGIC
  );
END DIT_RELOOP_core;

ARCHITECTURE v8 OF DIT_RELOOP_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL p_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a : STD_LOGIC_VECTOR (127 DOWNTO 0);
  SIGNAL IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_modulo_dev_cmp_return_rsc_z : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en : STD_LOGIC;
  SIGNAL fsm_output : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_acc_tmp : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL and_dcpl : STD_LOGIC;
  SIGNAL and_dcpl_1 : STD_LOGIC;
  SIGNAL or_tmp_2 : STD_LOGIC;
  SIGNAL or_tmp_3 : STD_LOGIC;
  SIGNAL or_tmp_4 : STD_LOGIC;
  SIGNAL and_dcpl_15 : STD_LOGIC;
  SIGNAL or_tmp_11 : STD_LOGIC;
  SIGNAL or_tmp_16 : STD_LOGIC;
  SIGNAL or_tmp_19 : STD_LOGIC;
  SIGNAL or_tmp_26 : STD_LOGIC;
  SIGNAL and_dcpl_55 : STD_LOGIC;
  SIGNAL and_dcpl_66 : STD_LOGIC;
  SIGNAL and_dcpl_93 : STD_LOGIC;
  SIGNAL and_dcpl_94 : STD_LOGIC;
  SIGNAL and_dcpl_95 : STD_LOGIC;
  SIGNAL and_dcpl_96 : STD_LOGIC;
  SIGNAL and_dcpl_97 : STD_LOGIC;
  SIGNAL and_dcpl_101 : STD_LOGIC;
  SIGNAL and_dcpl_102 : STD_LOGIC;
  SIGNAL and_dcpl_103 : STD_LOGIC;
  SIGNAL and_dcpl_104 : STD_LOGIC;
  SIGNAL and_dcpl_108 : STD_LOGIC;
  SIGNAL and_dcpl_109 : STD_LOGIC;
  SIGNAL and_dcpl_113 : STD_LOGIC;
  SIGNAL and_dcpl_114 : STD_LOGIC;
  SIGNAL and_dcpl_116 : STD_LOGIC;
  SIGNAL and_dcpl_117 : STD_LOGIC;
  SIGNAL and_dcpl_119 : STD_LOGIC;
  SIGNAL and_dcpl_120 : STD_LOGIC;
  SIGNAL and_dcpl_122 : STD_LOGIC;
  SIGNAL and_dcpl_123 : STD_LOGIC;
  SIGNAL and_dcpl_124 : STD_LOGIC;
  SIGNAL and_dcpl_125 : STD_LOGIC;
  SIGNAL and_dcpl_126 : STD_LOGIC;
  SIGNAL and_dcpl_127 : STD_LOGIC;
  SIGNAL and_dcpl_128 : STD_LOGIC;
  SIGNAL and_dcpl_129 : STD_LOGIC;
  SIGNAL and_dcpl_134 : STD_LOGIC;
  SIGNAL and_dcpl_135 : STD_LOGIC;
  SIGNAL and_dcpl_138 : STD_LOGIC;
  SIGNAL and_dcpl_151 : STD_LOGIC;
  SIGNAL and_dcpl_153 : STD_LOGIC;
  SIGNAL and_dcpl_154 : STD_LOGIC;
  SIGNAL and_dcpl_155 : STD_LOGIC;
  SIGNAL and_dcpl_157 : STD_LOGIC;
  SIGNAL and_dcpl_158 : STD_LOGIC;
  SIGNAL and_dcpl_159 : STD_LOGIC;
  SIGNAL not_tmp_162 : STD_LOGIC;
  SIGNAL not_tmp_164 : STD_LOGIC;
  SIGNAL and_dcpl_176 : STD_LOGIC;
  SIGNAL not_tmp_180 : STD_LOGIC;
  SIGNAL and_dcpl_179 : STD_LOGIC;
  SIGNAL and_dcpl_183 : STD_LOGIC;
  SIGNAL and_dcpl_184 : STD_LOGIC;
  SIGNAL and_dcpl_185 : STD_LOGIC;
  SIGNAL and_dcpl_187 : STD_LOGIC;
  SIGNAL and_dcpl_188 : STD_LOGIC;
  SIGNAL and_dcpl_190 : STD_LOGIC;
  SIGNAL and_dcpl_191 : STD_LOGIC;
  SIGNAL and_dcpl_193 : STD_LOGIC;
  SIGNAL and_dcpl_194 : STD_LOGIC;
  SIGNAL and_dcpl_198 : STD_LOGIC;
  SIGNAL and_dcpl_200 : STD_LOGIC;
  SIGNAL and_dcpl_202 : STD_LOGIC;
  SIGNAL and_dcpl_203 : STD_LOGIC;
  SIGNAL and_dcpl_204 : STD_LOGIC;
  SIGNAL or_dcpl_74 : STD_LOGIC;
  SIGNAL and_dcpl_207 : STD_LOGIC;
  SIGNAL and_dcpl_208 : STD_LOGIC;
  SIGNAL and_dcpl_210 : STD_LOGIC;
  SIGNAL and_dcpl_212 : STD_LOGIC;
  SIGNAL and_dcpl_214 : STD_LOGIC;
  SIGNAL and_dcpl_215 : STD_LOGIC;
  SIGNAL and_dcpl_216 : STD_LOGIC;
  SIGNAL or_dcpl_76 : STD_LOGIC;
  SIGNAL and_dcpl_217 : STD_LOGIC;
  SIGNAL and_dcpl_219 : STD_LOGIC;
  SIGNAL and_dcpl_220 : STD_LOGIC;
  SIGNAL and_dcpl_222 : STD_LOGIC;
  SIGNAL and_dcpl_224 : STD_LOGIC;
  SIGNAL and_dcpl_225 : STD_LOGIC;
  SIGNAL and_dcpl_227 : STD_LOGIC;
  SIGNAL and_dcpl_228 : STD_LOGIC;
  SIGNAL and_dcpl_230 : STD_LOGIC;
  SIGNAL and_dcpl_232 : STD_LOGIC;
  SIGNAL and_dcpl_234 : STD_LOGIC;
  SIGNAL or_dcpl_79 : STD_LOGIC;
  SIGNAL and_dcpl_235 : STD_LOGIC;
  SIGNAL nor_tmp_55 : STD_LOGIC;
  SIGNAL or_tmp_248 : STD_LOGIC;
  SIGNAL and_dcpl_241 : STD_LOGIC;
  SIGNAL and_dcpl_247 : STD_LOGIC;
  SIGNAL and_dcpl_249 : STD_LOGIC;
  SIGNAL and_dcpl_251 : STD_LOGIC;
  SIGNAL and_dcpl_252 : STD_LOGIC;
  SIGNAL and_dcpl_254 : STD_LOGIC;
  SIGNAL and_dcpl_256 : STD_LOGIC;
  SIGNAL and_dcpl_259 : STD_LOGIC;
  SIGNAL and_dcpl_261 : STD_LOGIC;
  SIGNAL and_dcpl_263 : STD_LOGIC;
  SIGNAL and_dcpl_265 : STD_LOGIC;
  SIGNAL and_dcpl_267 : STD_LOGIC;
  SIGNAL and_dcpl_271 : STD_LOGIC;
  SIGNAL or_dcpl_81 : STD_LOGIC;
  SIGNAL and_dcpl_275 : STD_LOGIC;
  SIGNAL and_dcpl_277 : STD_LOGIC;
  SIGNAL or_dcpl_83 : STD_LOGIC;
  SIGNAL and_dcpl_279 : STD_LOGIC;
  SIGNAL or_dcpl_84 : STD_LOGIC;
  SIGNAL and_dcpl_282 : STD_LOGIC;
  SIGNAL and_dcpl_284 : STD_LOGIC;
  SIGNAL and_dcpl_286 : STD_LOGIC;
  SIGNAL or_dcpl_85 : STD_LOGIC;
  SIGNAL and_dcpl_288 : STD_LOGIC;
  SIGNAL and_dcpl_293 : STD_LOGIC;
  SIGNAL and_dcpl_299 : STD_LOGIC;
  SIGNAL and_dcpl_306 : STD_LOGIC;
  SIGNAL and_dcpl_311 : STD_LOGIC;
  SIGNAL or_dcpl_87 : STD_LOGIC;
  SIGNAL and_dcpl_313 : STD_LOGIC;
  SIGNAL and_dcpl_315 : STD_LOGIC;
  SIGNAL and_dcpl_317 : STD_LOGIC;
  SIGNAL and_dcpl_319 : STD_LOGIC;
  SIGNAL and_dcpl_322 : STD_LOGIC;
  SIGNAL or_dcpl_90 : STD_LOGIC;
  SIGNAL and_dcpl_324 : STD_LOGIC;
  SIGNAL or_tmp_395 : STD_LOGIC;
  SIGNAL and_dcpl_331 : STD_LOGIC;
  SIGNAL and_dcpl_342 : STD_LOGIC;
  SIGNAL and_dcpl_345 : STD_LOGIC;
  SIGNAL and_dcpl_348 : STD_LOGIC;
  SIGNAL and_tmp_7 : STD_LOGIC;
  SIGNAL or_dcpl_103 : STD_LOGIC;
  SIGNAL and_dcpl_367 : STD_LOGIC;
  SIGNAL and_dcpl_368 : STD_LOGIC;
  SIGNAL and_tmp_9 : STD_LOGIC;
  SIGNAL and_dcpl_374 : STD_LOGIC;
  SIGNAL and_tmp_10 : STD_LOGIC;
  SIGNAL and_dcpl_377 : STD_LOGIC;
  SIGNAL and_tmp_11 : STD_LOGIC;
  SIGNAL and_dcpl_380 : STD_LOGIC;
  SIGNAL or_tmp_502 : STD_LOGIC;
  SIGNAL and_dcpl_383 : STD_LOGIC;
  SIGNAL or_tmp_505 : STD_LOGIC;
  SIGNAL mux_tmp_457 : STD_LOGIC;
  SIGNAL and_dcpl_386 : STD_LOGIC;
  SIGNAL and_dcpl_387 : STD_LOGIC;
  SIGNAL mux_tmp_461 : STD_LOGIC;
  SIGNAL and_dcpl_388 : STD_LOGIC;
  SIGNAL not_tmp_290 : STD_LOGIC;
  SIGNAL and_dcpl_390 : STD_LOGIC;
  SIGNAL not_tmp_292 : STD_LOGIC;
  SIGNAL not_tmp_296 : STD_LOGIC;
  SIGNAL not_tmp_298 : STD_LOGIC;
  SIGNAL or_tmp_516 : STD_LOGIC;
  SIGNAL and_dcpl_404 : STD_LOGIC;
  SIGNAL and_dcpl_407 : STD_LOGIC;
  SIGNAL and_dcpl_408 : STD_LOGIC;
  SIGNAL and_dcpl_413 : STD_LOGIC;
  SIGNAL and_dcpl_416 : STD_LOGIC;
  SIGNAL and_dcpl_417 : STD_LOGIC;
  SIGNAL and_dcpl_419 : STD_LOGIC;
  SIGNAL and_tmp_14 : STD_LOGIC;
  SIGNAL and_dcpl_423 : STD_LOGIC;
  SIGNAL and_dcpl_430 : STD_LOGIC;
  SIGNAL IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_idx1_acc_psp_8_sva_mx0w0 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL STAGE_LOOP_op_rshift_psp_1_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_f1_equal_tmp_3_mx0w0 : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_equal_tmp_2_mx0w0 : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_equal_tmp_1_mx0w0 : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_equal_tmp_mx0w0 : STD_LOGIC;
  SIGNAL GROUP_LOOP_j_10_0_sva_9_0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_idx1_acc_psp_3_sva_mx0w0 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_t_10_3_sva_6_0 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL IDX_LOOP_slc_IDX_LOOP_acc_8_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_equal_tmp_2 : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_equal_tmp : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_equal_tmp_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_equal_tmp_3 : STD_LOGIC;
  SIGNAL IDX_LOOP_idx1_acc_2_psp_sva_mx0w0 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_idx1_acc_psp_7_sva_mx0w0 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm : STD_LOGIC;
  SIGNAL STAGE_LOOP_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_90_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_97_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_104_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_34_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_41_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_48_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_160_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_153_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_146_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_216_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_209_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_202_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_idx2_9_0_2_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_9_0_4_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_9_0_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_9_0_6_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_30_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_44_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_51_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_107_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_100_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_86_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_163_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_156_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_142_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_212_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_198_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_219_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_32_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_39_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_53_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_109_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_88_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_95_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_165_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_151_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_144_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_207_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_200_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_221_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_94_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_78_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_86_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_42_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_50_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_58_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_114_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_122_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_130_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_16_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_24_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_8_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_idx2_acc_1_psp_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_acc_2_psp_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_acc_3_psp_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_acc_psp_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx1_acc_psp_7_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx1_acc_2_psp_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL IDX_LOOP_idx1_acc_psp_3_sva : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_9_0_2_sva_mx0w0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_acc_1_psp_sva_mx0w0 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_9_0_4_sva_mx0w0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_acc_2_psp_sva_mx0w0 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_9_0_6_sva_mx0w0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_9_0_sva_mx0w0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_idx2_acc_3_psp_sva_mx0w0 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL reg_IDX_LOOP_t_10_3_ftd_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7 : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL reg_IDX_LOOP_1_lshift_idiv_ftd_7 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL reg_twiddle_rsc_triosy_0_0_obj_ld_cse : STD_LOGIC;
  SIGNAL reg_ensig_cgo_cse : STD_LOGIC;
  SIGNAL or_676_cse : STD_LOGIC;
  SIGNAL or_680_cse : STD_LOGIC;
  SIGNAL and_509_cse : STD_LOGIC;
  SIGNAL reg_cse : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL reg_1_cse : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL reg_2_cse : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_513_cse : STD_LOGIC;
  SIGNAL or_200_cse : STD_LOGIC;
  SIGNAL nand_44_cse : STD_LOGIC;
  SIGNAL or_677_cse : STD_LOGIC;
  SIGNAL and_481_cse : STD_LOGIC;
  SIGNAL or_290_cse : STD_LOGIC;
  SIGNAL or_288_cse : STD_LOGIC;
  SIGNAL or_286_cse : STD_LOGIC;
  SIGNAL mux_256_cse : STD_LOGIC;
  SIGNAL nand_23_cse : STD_LOGIC;
  SIGNAL or_362_cse : STD_LOGIC;
  SIGNAL or_425_cse : STD_LOGIC;
  SIGNAL or_439_cse : STD_LOGIC;
  SIGNAL or_437_cse : STD_LOGIC;
  SIGNAL or_435_cse : STD_LOGIC;
  SIGNAL or_504_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_cse : STD_LOGIC;
  SIGNAL or_520_cse : STD_LOGIC;
  SIGNAL or_519_cse : STD_LOGIC;
  SIGNAL or_517_cse : STD_LOGIC;
  SIGNAL or_515_cse : STD_LOGIC;
  SIGNAL or_44_cse : STD_LOGIC;
  SIGNAL or_51_cse : STD_LOGIC;
  SIGNAL or_40_cse : STD_LOGIC;
  SIGNAL or_347_cse : STD_LOGIC;
  SIGNAL mux_293_cse : STD_LOGIC;
  SIGNAL mux_289_cse : STD_LOGIC;
  SIGNAL mux_286_cse : STD_LOGIC;
  SIGNAL and_448_cse : STD_LOGIC;
  SIGNAL or_47_cse : STD_LOGIC;
  SIGNAL or_90_cse : STD_LOGIC;
  SIGNAL mux_180_cse : STD_LOGIC;
  SIGNAL nor_302_rmff : STD_LOGIC;
  SIGNAL IDX_LOOP_modulo_dev_return_1_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL tmp_10_lpi_4_dfm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_idx1_acc_psp_8_sva : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL p_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_op_rshift_itm : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_dcpl_431 : STD_LOGIC;
  SIGNAL and_dcpl_436 : STD_LOGIC;
  SIGNAL and_dcpl_443 : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL and_dcpl_454 : STD_LOGIC;
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL and_dcpl_468 : STD_LOGIC;
  SIGNAL and_dcpl_469 : STD_LOGIC;
  SIGNAL and_dcpl_475 : STD_LOGIC;
  SIGNAL and_dcpl_476 : STD_LOGIC;
  SIGNAL and_dcpl_477 : STD_LOGIC;
  SIGNAL and_dcpl_479 : STD_LOGIC;
  SIGNAL and_dcpl_480 : STD_LOGIC;
  SIGNAL and_dcpl_482 : STD_LOGIC;
  SIGNAL and_dcpl_484 : STD_LOGIC;
  SIGNAL and_dcpl_491 : STD_LOGIC;
  SIGNAL and_dcpl_492 : STD_LOGIC;
  SIGNAL and_dcpl_493 : STD_LOGIC;
  SIGNAL and_dcpl_496 : STD_LOGIC;
  SIGNAL and_dcpl_498 : STD_LOGIC;
  SIGNAL and_dcpl_503 : STD_LOGIC;
  SIGNAL z_out_4 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_dcpl_509 : STD_LOGIC;
  SIGNAL and_dcpl_533 : STD_LOGIC;
  SIGNAL z_out_5 : STD_LOGIC_VECTOR (127 DOWNTO 0);
  SIGNAL and_dcpl_536 : STD_LOGIC;
  SIGNAL and_dcpl_544 : STD_LOGIC;
  SIGNAL and_dcpl_547 : STD_LOGIC;
  SIGNAL and_dcpl_551 : STD_LOGIC;
  SIGNAL and_dcpl_553 : STD_LOGIC;
  SIGNAL and_dcpl_555 : STD_LOGIC;
  SIGNAL and_dcpl_557 : STD_LOGIC;
  SIGNAL and_dcpl_559 : STD_LOGIC;
  SIGNAL and_dcpl_561 : STD_LOGIC;
  SIGNAL and_dcpl_563 : STD_LOGIC;
  SIGNAL z_out_6 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL and_dcpl_570 : STD_LOGIC;
  SIGNAL and_dcpl_571 : STD_LOGIC;
  SIGNAL and_dcpl_574 : STD_LOGIC;
  SIGNAL and_dcpl_577 : STD_LOGIC;
  SIGNAL and_dcpl_579 : STD_LOGIC;
  SIGNAL z_out_7 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_dcpl_587 : STD_LOGIC;
  SIGNAL and_dcpl_591 : STD_LOGIC;
  SIGNAL and_dcpl_593 : STD_LOGIC;
  SIGNAL z_out_8 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_dcpl_600 : STD_LOGIC;
  SIGNAL and_dcpl_601 : STD_LOGIC;
  SIGNAL and_dcpl_604 : STD_LOGIC;
  SIGNAL and_dcpl_607 : STD_LOGIC;
  SIGNAL and_dcpl_610 : STD_LOGIC;
  SIGNAL and_dcpl_612 : STD_LOGIC;
  SIGNAL and_dcpl_615 : STD_LOGIC;
  SIGNAL and_dcpl_618 : STD_LOGIC;
  SIGNAL and_dcpl_620 : STD_LOGIC;
  SIGNAL and_dcpl_622 : STD_LOGIC;
  SIGNAL STAGE_LOOP_gp_acc_psp_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL STAGE_LOOP_gp_lshift_psp_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL tmp_11_sva_3 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL tmp_11_sva_5 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL tmp_11_sva_7 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL tmp_11_sva_9 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL tmp_11_sva_29 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_mul_mut : STD_LOGIC_VECTOR (127 DOWNTO 0);
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_4_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_33_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_37_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_40_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_46_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_47_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_54_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_55_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_1_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_f1_and_39_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_41_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_43_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_47_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_49_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_51_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_55_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_57_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_59_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_63_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_65_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_66_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_67_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_2_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_12_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_89_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_93_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_96_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_102_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_103_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_110_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_111_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_3_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_f1_and_75_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_77_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_79_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_83_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_85_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_87_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_91_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_93_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_95_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_99_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_101_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_102_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_103_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_nor_12_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_4_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_145_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_21_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_149_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_152_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_158_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_159_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_166_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_167_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_5_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_f1_and_111_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_113_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_115_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_119_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_121_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_123_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_127_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_129_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_131_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_135_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_137_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_138_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_139_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_104_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_106_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_107_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_108_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_6_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_nor_28_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_201_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_205_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_208_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_214_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_222_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_223_itm : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_7_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva_mx0c1 : STD_LOGIC;
  SIGNAL STAGE_LOOP_i_3_0_sva_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL GROUP_LOOP_j_10_0_sva_9_0_mx0c0 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_1_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_2_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_mux1h_68_itm_mx0w0 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_modulo_dev_return_1_sva_mx0c1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_12_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_13_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_14_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_24_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_25_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_26_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_36_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_37_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_38_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_48_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_49_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_50_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_60_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_61_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_62_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_72_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_73_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_74_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_84_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_85_cse_1 : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_nor_86_cse_1 : STD_LOGIC;
  SIGNAL and_636_ssc : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_8_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_10_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_14_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_9_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_11_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_15_cse : STD_LOGIC;
  SIGNAL nor_175_cse : STD_LOGIC;
  SIGNAL nor_183_cse : STD_LOGIC;
  SIGNAL nor_191_cse : STD_LOGIC;
  SIGNAL nor_199_cse : STD_LOGIC;
  SIGNAL nor_207_cse : STD_LOGIC;
  SIGNAL nor_215_cse : STD_LOGIC;
  SIGNAL nor_223_cse : STD_LOGIC;
  SIGNAL and_489_cse : STD_LOGIC;
  SIGNAL nor_327_cse : STD_LOGIC;
  SIGNAL nor_326_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_69_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_70_cse : STD_LOGIC;
  SIGNAL or_tmp : STD_LOGIC;
  SIGNAL or_tmp_545 : STD_LOGIC;
  SIGNAL STAGE_LOOP_acc_itm_4_1 : STD_LOGIC;
  SIGNAL z_out_2_10 : STD_LOGIC;
  SIGNAL xnor_cse : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_64_tmp : STD_LOGIC;

  SIGNAL mux_187_nl : STD_LOGIC;
  SIGNAL nor_230_nl : STD_LOGIC;
  SIGNAL mux_189_nl : STD_LOGIC;
  SIGNAL mux_188_nl : STD_LOGIC;
  SIGNAL or_199_nl : STD_LOGIC;
  SIGNAL mux_192_nl : STD_LOGIC;
  SIGNAL mux_191_nl : STD_LOGIC;
  SIGNAL or_203_nl : STD_LOGIC;
  SIGNAL mux_190_nl : STD_LOGIC;
  SIGNAL or_202_nl : STD_LOGIC;
  SIGNAL or_201_nl : STD_LOGIC;
  SIGNAL GROUP_LOOP_j_not_1_nl : STD_LOGIC;
  SIGNAL or_nl : STD_LOGIC;
  SIGNAL mux_182_nl : STD_LOGIC;
  SIGNAL or_690_nl : STD_LOGIC;
  SIGNAL or_691_nl : STD_LOGIC;
  SIGNAL mux_532_nl : STD_LOGIC;
  SIGNAL mux_531_nl : STD_LOGIC;
  SIGNAL or_697_nl : STD_LOGIC;
  SIGNAL mux_530_nl : STD_LOGIC;
  SIGNAL mux_459_nl : STD_LOGIC;
  SIGNAL mux_29_nl : STD_LOGIC;
  SIGNAL mux_461_nl : STD_LOGIC;
  SIGNAL mux_27_nl : STD_LOGIC;
  SIGNAL mux_465_nl : STD_LOGIC;
  SIGNAL mux_466_nl : STD_LOGIC;
  SIGNAL nor_300_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_3_acc_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL mux_468_nl : STD_LOGIC;
  SIGNAL nor_251_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_acc_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL mux_469_nl : STD_LOGIC;
  SIGNAL mux_473_nl : STD_LOGIC;
  SIGNAL mux_472_nl : STD_LOGIC;
  SIGNAL or_35_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_5_acc_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL mux_476_nl : STD_LOGIC;
  SIGNAL mux_475_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_6_acc_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL mux_478_nl : STD_LOGIC;
  SIGNAL mux_477_nl : STD_LOGIC;
  SIGNAL mux_480_nl : STD_LOGIC;
  SIGNAL nand_15_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_7_acc_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL mux_483_nl : STD_LOGIC;
  SIGNAL mux_482_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_acc_5_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL IDX_LOOP_f1_and_11_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_101_nl : STD_LOGIC;
  SIGNAL mux_490_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_13_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_102_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_14_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_103_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_15_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_111_nl : STD_LOGIC;
  SIGNAL and_169_nl : STD_LOGIC;
  SIGNAL mux_492_nl : STD_LOGIC;
  SIGNAL mux_493_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_19_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_113_nl : STD_LOGIC;
  SIGNAL mux_494_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_21_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_114_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_22_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_115_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_23_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_119_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_27_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_122_nl : STD_LOGIC;
  SIGNAL and_164_nl : STD_LOGIC;
  SIGNAL mux_495_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_29_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_127_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_3_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_129_nl : STD_LOGIC;
  SIGNAL and_166_nl : STD_LOGIC;
  SIGNAL mux_496_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_30_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_130_nl : STD_LOGIC;
  SIGNAL mux_497_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_31_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_135_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_5_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_137_nl : STD_LOGIC;
  SIGNAL and_412_nl : STD_LOGIC;
  SIGNAL mux_499_nl : STD_LOGIC;
  SIGNAL nor_117_nl : STD_LOGIC;
  SIGNAL mux_498_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_6_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_138_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_7_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_139_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_2_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_215_nl : STD_LOGIC;
  SIGNAL and_416_nl : STD_LOGIC;
  SIGNAL mux_501_nl : STD_LOGIC;
  SIGNAL nor_116_nl : STD_LOGIC;
  SIGNAL mux_500_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_51_nl : STD_LOGIC;
  SIGNAL mux_504_nl : STD_LOGIC;
  SIGNAL mux_509_nl : STD_LOGIC;
  SIGNAL nor_115_nl : STD_LOGIC;
  SIGNAL mux_508_nl : STD_LOGIC;
  SIGNAL or_633_nl : STD_LOGIC;
  SIGNAL mux_507_nl : STD_LOGIC;
  SIGNAL or_630_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_1_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_or_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_3_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_or_1_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_or_4_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_6_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_and_7_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_or_2_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_or_3_nl : STD_LOGIC;
  SIGNAL mux_513_nl : STD_LOGIC;
  SIGNAL mux_514_nl : STD_LOGIC;
  SIGNAL nor_114_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_208_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_201_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_209_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_202_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_210_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_203_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_211_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_204_nl : STD_LOGIC;
  SIGNAL mux_519_nl : STD_LOGIC;
  SIGNAL mux_518_nl : STD_LOGIC;
  SIGNAL mux_521_nl : STD_LOGIC;
  SIGNAL nor_113_nl : STD_LOGIC;
  SIGNAL mux_522_nl : STD_LOGIC;
  SIGNAL mux_526_nl : STD_LOGIC;
  SIGNAL mux_525_nl : STD_LOGIC;
  SIGNAL mux_527_nl : STD_LOGIC;
  SIGNAL mux_529_nl : STD_LOGIC;
  SIGNAL nor_260_nl : STD_LOGIC;
  SIGNAL mux_528_nl : STD_LOGIC;
  SIGNAL or_657_nl : STD_LOGIC;
  SIGNAL and_521_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_or_5_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_or_6_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_126_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_128_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_130_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_acc_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL nor_236_nl : STD_LOGIC;
  SIGNAL mux_463_nl : STD_LOGIC;
  SIGNAL mux_462_nl : STD_LOGIC;
  SIGNAL and_375_nl : STD_LOGIC;
  SIGNAL mux_464_nl : STD_LOGIC;
  SIGNAL mux_467_nl : STD_LOGIC;
  SIGNAL mux_471_nl : STD_LOGIC;
  SIGNAL mux_470_nl : STD_LOGIC;
  SIGNAL mux_474_nl : STD_LOGIC;
  SIGNAL mux_479_nl : STD_LOGIC;
  SIGNAL mux_485_nl : STD_LOGIC;
  SIGNAL mux_487_nl : STD_LOGIC;
  SIGNAL nand_14_nl : STD_LOGIC;
  SIGNAL mux_489_nl : STD_LOGIC;
  SIGNAL mux_491_nl : STD_LOGIC;
  SIGNAL or_587_nl : STD_LOGIC;
  SIGNAL mux_503_nl : STD_LOGIC;
  SIGNAL mux_502_nl : STD_LOGIC;
  SIGNAL mux_505_nl : STD_LOGIC;
  SIGNAL mux_506_nl : STD_LOGIC;
  SIGNAL mux_515_nl : STD_LOGIC;
  SIGNAL mux_516_nl : STD_LOGIC;
  SIGNAL mux_520_nl : STD_LOGIC;
  SIGNAL mux_524_nl : STD_LOGIC;
  SIGNAL nor_112_nl : STD_LOGIC;
  SIGNAL mux_523_nl : STD_LOGIC;
  SIGNAL and_359_nl : STD_LOGIC;
  SIGNAL and_360_nl : STD_LOGIC;
  SIGNAL and_361_nl : STD_LOGIC;
  SIGNAL and_362_nl : STD_LOGIC;
  SIGNAL and_363_nl : STD_LOGIC;
  SIGNAL and_364_nl : STD_LOGIC;
  SIGNAL and_247_nl : STD_LOGIC;
  SIGNAL and_248_nl : STD_LOGIC;
  SIGNAL and_249_nl : STD_LOGIC;
  SIGNAL and_250_nl : STD_LOGIC;
  SIGNAL and_246_nl : STD_LOGIC;
  SIGNAL mux_434_nl : STD_LOGIC;
  SIGNAL and_453_nl : STD_LOGIC;
  SIGNAL mux_433_nl : STD_LOGIC;
  SIGNAL nor_130_nl : STD_LOGIC;
  SIGNAL mux_432_nl : STD_LOGIC;
  SIGNAL or_549_nl : STD_LOGIC;
  SIGNAL or_548_nl : STD_LOGIC;
  SIGNAL mux_431_nl : STD_LOGIC;
  SIGNAL nor_131_nl : STD_LOGIC;
  SIGNAL nor_132_nl : STD_LOGIC;
  SIGNAL nor_133_nl : STD_LOGIC;
  SIGNAL mux_430_nl : STD_LOGIC;
  SIGNAL mux_429_nl : STD_LOGIC;
  SIGNAL mux_428_nl : STD_LOGIC;
  SIGNAL or_544_nl : STD_LOGIC;
  SIGNAL or_542_nl : STD_LOGIC;
  SIGNAL mux_427_nl : STD_LOGIC;
  SIGNAL or_541_nl : STD_LOGIC;
  SIGNAL or_540_nl : STD_LOGIC;
  SIGNAL mux_426_nl : STD_LOGIC;
  SIGNAL mux_425_nl : STD_LOGIC;
  SIGNAL or_539_nl : STD_LOGIC;
  SIGNAL or_538_nl : STD_LOGIC;
  SIGNAL mux_424_nl : STD_LOGIC;
  SIGNAL or_537_nl : STD_LOGIC;
  SIGNAL or_536_nl : STD_LOGIC;
  SIGNAL mux_451_nl : STD_LOGIC;
  SIGNAL mux_450_nl : STD_LOGIC;
  SIGNAL mux_449_nl : STD_LOGIC;
  SIGNAL mux_448_nl : STD_LOGIC;
  SIGNAL nor_128_nl : STD_LOGIC;
  SIGNAL or_570_nl : STD_LOGIC;
  SIGNAL mux_447_nl : STD_LOGIC;
  SIGNAL mux_446_nl : STD_LOGIC;
  SIGNAL or_568_nl : STD_LOGIC;
  SIGNAL or_566_nl : STD_LOGIC;
  SIGNAL mux_444_nl : STD_LOGIC;
  SIGNAL mux_443_nl : STD_LOGIC;
  SIGNAL mux_442_nl : STD_LOGIC;
  SIGNAL or_565_nl : STD_LOGIC;
  SIGNAL or_563_nl : STD_LOGIC;
  SIGNAL mux_440_nl : STD_LOGIC;
  SIGNAL mux_439_nl : STD_LOGIC;
  SIGNAL or_561_nl : STD_LOGIC;
  SIGNAL or_559_nl : STD_LOGIC;
  SIGNAL mux_437_nl : STD_LOGIC;
  SIGNAL mux_436_nl : STD_LOGIC;
  SIGNAL or_558_nl : STD_LOGIC;
  SIGNAL or_556_nl : STD_LOGIC;
  SIGNAL mux_435_nl : STD_LOGIC;
  SIGNAL or_554_nl : STD_LOGIC;
  SIGNAL or_552_nl : STD_LOGIC;
  SIGNAL and_345_nl : STD_LOGIC;
  SIGNAL and_347_nl : STD_LOGIC;
  SIGNAL and_348_nl : STD_LOGIC;
  SIGNAL and_350_nl : STD_LOGIC;
  SIGNAL and_351_nl : STD_LOGIC;
  SIGNAL and_353_nl : STD_LOGIC;
  SIGNAL and_354_nl : STD_LOGIC;
  SIGNAL and_356_nl : STD_LOGIC;
  SIGNAL and_190_nl : STD_LOGIC;
  SIGNAL and_193_nl : STD_LOGIC;
  SIGNAL and_196_nl : STD_LOGIC;
  SIGNAL and_199_nl : STD_LOGIC;
  SIGNAL and_186_nl : STD_LOGIC;
  SIGNAL mux_411_nl : STD_LOGIC;
  SIGNAL nor_138_nl : STD_LOGIC;
  SIGNAL mux_410_nl : STD_LOGIC;
  SIGNAL mux_409_nl : STD_LOGIC;
  SIGNAL or_512_nl : STD_LOGIC;
  SIGNAL or_510_nl : STD_LOGIC;
  SIGNAL or_509_nl : STD_LOGIC;
  SIGNAL nor_139_nl : STD_LOGIC;
  SIGNAL mux_407_nl : STD_LOGIC;
  SIGNAL mux_406_nl : STD_LOGIC;
  SIGNAL mux_405_nl : STD_LOGIC;
  SIGNAL or_506_nl : STD_LOGIC;
  SIGNAL mux_404_nl : STD_LOGIC;
  SIGNAL or_502_nl : STD_LOGIC;
  SIGNAL or_500_nl : STD_LOGIC;
  SIGNAL or_498_nl : STD_LOGIC;
  SIGNAL mux_403_nl : STD_LOGIC;
  SIGNAL mux_402_nl : STD_LOGIC;
  SIGNAL or_497_nl : STD_LOGIC;
  SIGNAL or_495_nl : STD_LOGIC;
  SIGNAL mux_401_nl : STD_LOGIC;
  SIGNAL or_493_nl : STD_LOGIC;
  SIGNAL or_491_nl : STD_LOGIC;
  SIGNAL mux_423_nl : STD_LOGIC;
  SIGNAL nand_10_nl : STD_LOGIC;
  SIGNAL mux_422_nl : STD_LOGIC;
  SIGNAL mux_421_nl : STD_LOGIC;
  SIGNAL nor_134_nl : STD_LOGIC;
  SIGNAL nor_135_nl : STD_LOGIC;
  SIGNAL mux_420_nl : STD_LOGIC;
  SIGNAL nor_136_nl : STD_LOGIC;
  SIGNAL nor_137_nl : STD_LOGIC;
  SIGNAL mux_419_nl : STD_LOGIC;
  SIGNAL mux_418_nl : STD_LOGIC;
  SIGNAL mux_417_nl : STD_LOGIC;
  SIGNAL mux_416_nl : STD_LOGIC;
  SIGNAL and_343_nl : STD_LOGIC;
  SIGNAL or_522_nl : STD_LOGIC;
  SIGNAL mux_415_nl : STD_LOGIC;
  SIGNAL and_454_nl : STD_LOGIC;
  SIGNAL nor_99_nl : STD_LOGIC;
  SIGNAL mux_414_nl : STD_LOGIC;
  SIGNAL mux_413_nl : STD_LOGIC;
  SIGNAL and_455_nl : STD_LOGIC;
  SIGNAL nor_97_nl : STD_LOGIC;
  SIGNAL mux_412_nl : STD_LOGIC;
  SIGNAL and_456_nl : STD_LOGIC;
  SIGNAL nor_95_nl : STD_LOGIC;
  SIGNAL and_334_nl : STD_LOGIC;
  SIGNAL and_335_nl : STD_LOGIC;
  SIGNAL and_338_nl : STD_LOGIC;
  SIGNAL and_339_nl : STD_LOGIC;
  SIGNAL and_340_nl : STD_LOGIC;
  SIGNAL and_341_nl : STD_LOGIC;
  SIGNAL mux_382_nl : STD_LOGIC;
  SIGNAL and_458_nl : STD_LOGIC;
  SIGNAL mux_381_nl : STD_LOGIC;
  SIGNAL and_459_nl : STD_LOGIC;
  SIGNAL mux_380_nl : STD_LOGIC;
  SIGNAL nor_142_nl : STD_LOGIC;
  SIGNAL nor_143_nl : STD_LOGIC;
  SIGNAL mux_379_nl : STD_LOGIC;
  SIGNAL nor_144_nl : STD_LOGIC;
  SIGNAL nor_145_nl : STD_LOGIC;
  SIGNAL nor_146_nl : STD_LOGIC;
  SIGNAL mux_378_nl : STD_LOGIC;
  SIGNAL mux_377_nl : STD_LOGIC;
  SIGNAL mux_376_nl : STD_LOGIC;
  SIGNAL or_465_nl : STD_LOGIC;
  SIGNAL or_463_nl : STD_LOGIC;
  SIGNAL mux_375_nl : STD_LOGIC;
  SIGNAL or_462_nl : STD_LOGIC;
  SIGNAL or_461_nl : STD_LOGIC;
  SIGNAL mux_374_nl : STD_LOGIC;
  SIGNAL mux_373_nl : STD_LOGIC;
  SIGNAL or_460_nl : STD_LOGIC;
  SIGNAL or_459_nl : STD_LOGIC;
  SIGNAL mux_372_nl : STD_LOGIC;
  SIGNAL or_458_nl : STD_LOGIC;
  SIGNAL or_457_nl : STD_LOGIC;
  SIGNAL mux_400_nl : STD_LOGIC;
  SIGNAL mux_399_nl : STD_LOGIC;
  SIGNAL mux_398_nl : STD_LOGIC;
  SIGNAL mux_397_nl : STD_LOGIC;
  SIGNAL mux_396_nl : STD_LOGIC;
  SIGNAL nor_140_nl : STD_LOGIC;
  SIGNAL mux_395_nl : STD_LOGIC;
  SIGNAL mux_394_nl : STD_LOGIC;
  SIGNAL nor_94_nl : STD_LOGIC;
  SIGNAL or_485_nl : STD_LOGIC;
  SIGNAL mux_392_nl : STD_LOGIC;
  SIGNAL mux_391_nl : STD_LOGIC;
  SIGNAL mux_390_nl : STD_LOGIC;
  SIGNAL or_483_nl : STD_LOGIC;
  SIGNAL nor_93_nl : STD_LOGIC;
  SIGNAL mux_388_nl : STD_LOGIC;
  SIGNAL mux_387_nl : STD_LOGIC;
  SIGNAL or_481_nl : STD_LOGIC;
  SIGNAL or_479_nl : STD_LOGIC;
  SIGNAL mux_385_nl : STD_LOGIC;
  SIGNAL mux_384_nl : STD_LOGIC;
  SIGNAL or_478_nl : STD_LOGIC;
  SIGNAL or_476_nl : STD_LOGIC;
  SIGNAL mux_383_nl : STD_LOGIC;
  SIGNAL or_474_nl : STD_LOGIC;
  SIGNAL or_472_nl : STD_LOGIC;
  SIGNAL and_313_nl : STD_LOGIC;
  SIGNAL and_315_nl : STD_LOGIC;
  SIGNAL and_318_nl : STD_LOGIC;
  SIGNAL and_320_nl : STD_LOGIC;
  SIGNAL and_324_nl : STD_LOGIC;
  SIGNAL and_326_nl : STD_LOGIC;
  SIGNAL and_329_nl : STD_LOGIC;
  SIGNAL and_331_nl : STD_LOGIC;
  SIGNAL mux_359_nl : STD_LOGIC;
  SIGNAL nor_151_nl : STD_LOGIC;
  SIGNAL mux_358_nl : STD_LOGIC;
  SIGNAL mux_357_nl : STD_LOGIC;
  SIGNAL or_432_nl : STD_LOGIC;
  SIGNAL nand_6_nl : STD_LOGIC;
  SIGNAL or_430_nl : STD_LOGIC;
  SIGNAL nor_152_nl : STD_LOGIC;
  SIGNAL mux_355_nl : STD_LOGIC;
  SIGNAL mux_354_nl : STD_LOGIC;
  SIGNAL mux_353_nl : STD_LOGIC;
  SIGNAL nand_16_nl : STD_LOGIC;
  SIGNAL mux_352_nl : STD_LOGIC;
  SIGNAL or_423_nl : STD_LOGIC;
  SIGNAL or_422_nl : STD_LOGIC;
  SIGNAL or_420_nl : STD_LOGIC;
  SIGNAL mux_351_nl : STD_LOGIC;
  SIGNAL mux_350_nl : STD_LOGIC;
  SIGNAL or_419_nl : STD_LOGIC;
  SIGNAL or_418_nl : STD_LOGIC;
  SIGNAL mux_349_nl : STD_LOGIC;
  SIGNAL or_416_nl : STD_LOGIC;
  SIGNAL or_415_nl : STD_LOGIC;
  SIGNAL mux_371_nl : STD_LOGIC;
  SIGNAL nand_7_nl : STD_LOGIC;
  SIGNAL mux_370_nl : STD_LOGIC;
  SIGNAL mux_369_nl : STD_LOGIC;
  SIGNAL nor_147_nl : STD_LOGIC;
  SIGNAL and_nl : STD_LOGIC;
  SIGNAL mux_368_nl : STD_LOGIC;
  SIGNAL and_525_nl : STD_LOGIC;
  SIGNAL and_526_nl : STD_LOGIC;
  SIGNAL mux_367_nl : STD_LOGIC;
  SIGNAL mux_366_nl : STD_LOGIC;
  SIGNAL mux_365_nl : STD_LOGIC;
  SIGNAL or_443_nl : STD_LOGIC;
  SIGNAL mux_364_nl : STD_LOGIC;
  SIGNAL and_308_nl : STD_LOGIC;
  SIGNAL nor_90_nl : STD_LOGIC;
  SIGNAL mux_363_nl : STD_LOGIC;
  SIGNAL and_460_nl : STD_LOGIC;
  SIGNAL nor_88_nl : STD_LOGIC;
  SIGNAL mux_362_nl : STD_LOGIC;
  SIGNAL mux_361_nl : STD_LOGIC;
  SIGNAL and_461_nl : STD_LOGIC;
  SIGNAL nor_86_nl : STD_LOGIC;
  SIGNAL mux_360_nl : STD_LOGIC;
  SIGNAL and_462_nl : STD_LOGIC;
  SIGNAL nor_84_nl : STD_LOGIC;
  SIGNAL and_299_nl : STD_LOGIC;
  SIGNAL and_300_nl : STD_LOGIC;
  SIGNAL and_301_nl : STD_LOGIC;
  SIGNAL and_302_nl : STD_LOGIC;
  SIGNAL and_305_nl : STD_LOGIC;
  SIGNAL and_306_nl : STD_LOGIC;
  SIGNAL mux_333_nl : STD_LOGIC;
  SIGNAL and_466_nl : STD_LOGIC;
  SIGNAL mux_332_nl : STD_LOGIC;
  SIGNAL nor_155_nl : STD_LOGIC;
  SIGNAL mux_331_nl : STD_LOGIC;
  SIGNAL or_391_nl : STD_LOGIC;
  SIGNAL or_390_nl : STD_LOGIC;
  SIGNAL mux_330_nl : STD_LOGIC;
  SIGNAL nor_156_nl : STD_LOGIC;
  SIGNAL nor_157_nl : STD_LOGIC;
  SIGNAL nor_158_nl : STD_LOGIC;
  SIGNAL mux_329_nl : STD_LOGIC;
  SIGNAL mux_328_nl : STD_LOGIC;
  SIGNAL mux_327_nl : STD_LOGIC;
  SIGNAL or_386_nl : STD_LOGIC;
  SIGNAL or_384_nl : STD_LOGIC;
  SIGNAL mux_326_nl : STD_LOGIC;
  SIGNAL or_383_nl : STD_LOGIC;
  SIGNAL or_382_nl : STD_LOGIC;
  SIGNAL mux_325_nl : STD_LOGIC;
  SIGNAL mux_324_nl : STD_LOGIC;
  SIGNAL or_381_nl : STD_LOGIC;
  SIGNAL or_380_nl : STD_LOGIC;
  SIGNAL mux_323_nl : STD_LOGIC;
  SIGNAL or_379_nl : STD_LOGIC;
  SIGNAL or_378_nl : STD_LOGIC;
  SIGNAL mux_348_nl : STD_LOGIC;
  SIGNAL mux_347_nl : STD_LOGIC;
  SIGNAL mux_346_nl : STD_LOGIC;
  SIGNAL mux_345_nl : STD_LOGIC;
  SIGNAL or_413_nl : STD_LOGIC;
  SIGNAL mux_344_nl : STD_LOGIC;
  SIGNAL nor_153_nl : STD_LOGIC;
  SIGNAL or_409_nl : STD_LOGIC;
  SIGNAL mux_343_nl : STD_LOGIC;
  SIGNAL mux_342_nl : STD_LOGIC;
  SIGNAL and_463_nl : STD_LOGIC;
  SIGNAL nor_79_nl : STD_LOGIC;
  SIGNAL or_406_nl : STD_LOGIC;
  SIGNAL mux_341_nl : STD_LOGIC;
  SIGNAL or_405_nl : STD_LOGIC;
  SIGNAL or_403_nl : STD_LOGIC;
  SIGNAL mux_340_nl : STD_LOGIC;
  SIGNAL mux_339_nl : STD_LOGIC;
  SIGNAL mux_338_nl : STD_LOGIC;
  SIGNAL mux_337_nl : STD_LOGIC;
  SIGNAL and_464_nl : STD_LOGIC;
  SIGNAL or_399_nl : STD_LOGIC;
  SIGNAL nor_77_nl : STD_LOGIC;
  SIGNAL mux_336_nl : STD_LOGIC;
  SIGNAL mux_335_nl : STD_LOGIC;
  SIGNAL or_398_nl : STD_LOGIC;
  SIGNAL and_465_nl : STD_LOGIC;
  SIGNAL nor_75_nl : STD_LOGIC;
  SIGNAL mux_334_nl : STD_LOGIC;
  SIGNAL or_396_nl : STD_LOGIC;
  SIGNAL or_394_nl : STD_LOGIC;
  SIGNAL and_277_nl : STD_LOGIC;
  SIGNAL and_279_nl : STD_LOGIC;
  SIGNAL and_283_nl : STD_LOGIC;
  SIGNAL and_285_nl : STD_LOGIC;
  SIGNAL and_286_nl : STD_LOGIC;
  SIGNAL and_288_nl : STD_LOGIC;
  SIGNAL and_292_nl : STD_LOGIC;
  SIGNAL and_294_nl : STD_LOGIC;
  SIGNAL mux_310_nl : STD_LOGIC;
  SIGNAL nor_163_nl : STD_LOGIC;
  SIGNAL mux_309_nl : STD_LOGIC;
  SIGNAL mux_308_nl : STD_LOGIC;
  SIGNAL or_354_nl : STD_LOGIC;
  SIGNAL or_353_nl : STD_LOGIC;
  SIGNAL or_352_nl : STD_LOGIC;
  SIGNAL nor_164_nl : STD_LOGIC;
  SIGNAL mux_306_nl : STD_LOGIC;
  SIGNAL mux_305_nl : STD_LOGIC;
  SIGNAL mux_304_nl : STD_LOGIC;
  SIGNAL or_349_nl : STD_LOGIC;
  SIGNAL mux_303_nl : STD_LOGIC;
  SIGNAL or_346_nl : STD_LOGIC;
  SIGNAL or_344_nl : STD_LOGIC;
  SIGNAL or_342_nl : STD_LOGIC;
  SIGNAL mux_302_nl : STD_LOGIC;
  SIGNAL mux_301_nl : STD_LOGIC;
  SIGNAL or_341_nl : STD_LOGIC;
  SIGNAL or_339_nl : STD_LOGIC;
  SIGNAL mux_300_nl : STD_LOGIC;
  SIGNAL or_338_nl : STD_LOGIC;
  SIGNAL or_336_nl : STD_LOGIC;
  SIGNAL mux_322_nl : STD_LOGIC;
  SIGNAL nand_4_nl : STD_LOGIC;
  SIGNAL mux_321_nl : STD_LOGIC;
  SIGNAL mux_320_nl : STD_LOGIC;
  SIGNAL nor_159_nl : STD_LOGIC;
  SIGNAL and_522_nl : STD_LOGIC;
  SIGNAL mux_319_nl : STD_LOGIC;
  SIGNAL and_523_nl : STD_LOGIC;
  SIGNAL and_524_nl : STD_LOGIC;
  SIGNAL mux_318_nl : STD_LOGIC;
  SIGNAL mux_317_nl : STD_LOGIC;
  SIGNAL mux_316_nl : STD_LOGIC;
  SIGNAL mux_315_nl : STD_LOGIC;
  SIGNAL and_273_nl : STD_LOGIC;
  SIGNAL or_364_nl : STD_LOGIC;
  SIGNAL mux_314_nl : STD_LOGIC;
  SIGNAL or_361_nl : STD_LOGIC;
  SIGNAL and_467_nl : STD_LOGIC;
  SIGNAL nor_71_nl : STD_LOGIC;
  SIGNAL mux_313_nl : STD_LOGIC;
  SIGNAL mux_312_nl : STD_LOGIC;
  SIGNAL or_359_nl : STD_LOGIC;
  SIGNAL and_468_nl : STD_LOGIC;
  SIGNAL nor_69_nl : STD_LOGIC;
  SIGNAL mux_311_nl : STD_LOGIC;
  SIGNAL or_357_nl : STD_LOGIC;
  SIGNAL and_469_nl : STD_LOGIC;
  SIGNAL nor_67_nl : STD_LOGIC;
  SIGNAL and_254_nl : STD_LOGIC;
  SIGNAL and_257_nl : STD_LOGIC;
  SIGNAL and_261_nl : STD_LOGIC;
  SIGNAL and_264_nl : STD_LOGIC;
  SIGNAL and_268_nl : STD_LOGIC;
  SIGNAL and_270_nl : STD_LOGIC;
  SIGNAL mux_282_nl : STD_LOGIC;
  SIGNAL and_478_nl : STD_LOGIC;
  SIGNAL mux_281_nl : STD_LOGIC;
  SIGNAL and_479_nl : STD_LOGIC;
  SIGNAL mux_280_nl : STD_LOGIC;
  SIGNAL nor_167_nl : STD_LOGIC;
  SIGNAL nor_168_nl : STD_LOGIC;
  SIGNAL mux_279_nl : STD_LOGIC;
  SIGNAL nor_169_nl : STD_LOGIC;
  SIGNAL nor_170_nl : STD_LOGIC;
  SIGNAL nor_171_nl : STD_LOGIC;
  SIGNAL mux_278_nl : STD_LOGIC;
  SIGNAL mux_277_nl : STD_LOGIC;
  SIGNAL mux_276_nl : STD_LOGIC;
  SIGNAL nand_31_nl : STD_LOGIC;
  SIGNAL or_313_nl : STD_LOGIC;
  SIGNAL mux_275_nl : STD_LOGIC;
  SIGNAL or_312_nl : STD_LOGIC;
  SIGNAL or_311_nl : STD_LOGIC;
  SIGNAL mux_274_nl : STD_LOGIC;
  SIGNAL mux_273_nl : STD_LOGIC;
  SIGNAL or_310_nl : STD_LOGIC;
  SIGNAL or_309_nl : STD_LOGIC;
  SIGNAL mux_272_nl : STD_LOGIC;
  SIGNAL or_308_nl : STD_LOGIC;
  SIGNAL or_307_nl : STD_LOGIC;
  SIGNAL mux_299_nl : STD_LOGIC;
  SIGNAL mux_298_nl : STD_LOGIC;
  SIGNAL mux_297_nl : STD_LOGIC;
  SIGNAL mux_296_nl : STD_LOGIC;
  SIGNAL or_674_nl : STD_LOGIC;
  SIGNAL nor_165_nl : STD_LOGIC;
  SIGNAL mux_295_nl : STD_LOGIC;
  SIGNAL mux_294_nl : STD_LOGIC;
  SIGNAL and_471_nl : STD_LOGIC;
  SIGNAL and_472_nl : STD_LOGIC;
  SIGNAL mux_292_nl : STD_LOGIC;
  SIGNAL mux_291_nl : STD_LOGIC;
  SIGNAL mux_290_nl : STD_LOGIC;
  SIGNAL and_473_nl : STD_LOGIC;
  SIGNAL and_474_nl : STD_LOGIC;
  SIGNAL mux_288_nl : STD_LOGIC;
  SIGNAL mux_287_nl : STD_LOGIC;
  SIGNAL and_475_nl : STD_LOGIC;
  SIGNAL and_476_nl : STD_LOGIC;
  SIGNAL mux_285_nl : STD_LOGIC;
  SIGNAL mux_284_nl : STD_LOGIC;
  SIGNAL nand_68_nl : STD_LOGIC;
  SIGNAL nand_69_nl : STD_LOGIC;
  SIGNAL mux_283_nl : STD_LOGIC;
  SIGNAL nand_67_nl : STD_LOGIC;
  SIGNAL nand_66_nl : STD_LOGIC;
  SIGNAL and_205_nl : STD_LOGIC;
  SIGNAL and_210_nl : STD_LOGIC;
  SIGNAL and_217_nl : STD_LOGIC;
  SIGNAL and_222_nl : STD_LOGIC;
  SIGNAL and_227_nl : STD_LOGIC;
  SIGNAL and_230_nl : STD_LOGIC;
  SIGNAL and_237_nl : STD_LOGIC;
  SIGNAL and_240_nl : STD_LOGIC;
  SIGNAL mux_259_nl : STD_LOGIC;
  SIGNAL nor_172_nl : STD_LOGIC;
  SIGNAL mux_258_nl : STD_LOGIC;
  SIGNAL mux_257_nl : STD_LOGIC;
  SIGNAL nand_41_nl : STD_LOGIC;
  SIGNAL nand_42_nl : STD_LOGIC;
  SIGNAL or_283_nl : STD_LOGIC;
  SIGNAL nor_173_nl : STD_LOGIC;
  SIGNAL mux_255_nl : STD_LOGIC;
  SIGNAL mux_254_nl : STD_LOGIC;
  SIGNAL mux_253_nl : STD_LOGIC;
  SIGNAL nand_43_nl : STD_LOGIC;
  SIGNAL mux_252_nl : STD_LOGIC;
  SIGNAL nand_45_nl : STD_LOGIC;
  SIGNAL or_280_nl : STD_LOGIC;
  SIGNAL or_278_nl : STD_LOGIC;
  SIGNAL mux_251_nl : STD_LOGIC;
  SIGNAL mux_250_nl : STD_LOGIC;
  SIGNAL nand_47_nl : STD_LOGIC;
  SIGNAL nand_48_nl : STD_LOGIC;
  SIGNAL mux_249_nl : STD_LOGIC;
  SIGNAL nand_49_nl : STD_LOGIC;
  SIGNAL nand_50_nl : STD_LOGIC;
  SIGNAL mux_271_nl : STD_LOGIC;
  SIGNAL mux_270_nl : STD_LOGIC;
  SIGNAL mux_269_nl : STD_LOGIC;
  SIGNAL nand_32_nl : STD_LOGIC;
  SIGNAL or_297_nl : STD_LOGIC;
  SIGNAL mux_268_nl : STD_LOGIC;
  SIGNAL or_295_nl : STD_LOGIC;
  SIGNAL or_293_nl : STD_LOGIC;
  SIGNAL mux_267_nl : STD_LOGIC;
  SIGNAL mux_266_nl : STD_LOGIC;
  SIGNAL mux_265_nl : STD_LOGIC;
  SIGNAL or_291_nl : STD_LOGIC;
  SIGNAL mux_264_nl : STD_LOGIC;
  SIGNAL and_480_nl : STD_LOGIC;
  SIGNAL mux_263_nl : STD_LOGIC;
  SIGNAL and_482_nl : STD_LOGIC;
  SIGNAL and_483_nl : STD_LOGIC;
  SIGNAL mux_262_nl : STD_LOGIC;
  SIGNAL mux_261_nl : STD_LOGIC;
  SIGNAL and_484_nl : STD_LOGIC;
  SIGNAL and_485_nl : STD_LOGIC;
  SIGNAL mux_260_nl : STD_LOGIC;
  SIGNAL and_486_nl : STD_LOGIC;
  SIGNAL and_487_nl : STD_LOGIC;
  SIGNAL mux_247_nl : STD_LOGIC;
  SIGNAL mux_246_nl : STD_LOGIC;
  SIGNAL nor_174_nl : STD_LOGIC;
  SIGNAL mux_241_nl : STD_LOGIC;
  SIGNAL mux_240_nl : STD_LOGIC;
  SIGNAL mux_239_nl : STD_LOGIC;
  SIGNAL nor_182_nl : STD_LOGIC;
  SIGNAL mux_237_nl : STD_LOGIC;
  SIGNAL mux_236_nl : STD_LOGIC;
  SIGNAL nor_186_nl : STD_LOGIC;
  SIGNAL mux_234_nl : STD_LOGIC;
  SIGNAL mux_233_nl : STD_LOGIC;
  SIGNAL mux_232_nl : STD_LOGIC;
  SIGNAL nor_190_nl : STD_LOGIC;
  SIGNAL mux_230_nl : STD_LOGIC;
  SIGNAL mux_229_nl : STD_LOGIC;
  SIGNAL nor_194_nl : STD_LOGIC;
  SIGNAL mux_226_nl : STD_LOGIC;
  SIGNAL mux_225_nl : STD_LOGIC;
  SIGNAL nor_198_nl : STD_LOGIC;
  SIGNAL mux_219_nl : STD_LOGIC;
  SIGNAL mux_218_nl : STD_LOGIC;
  SIGNAL nor_206_nl : STD_LOGIC;
  SIGNAL mux_213_nl : STD_LOGIC;
  SIGNAL mux_212_nl : STD_LOGIC;
  SIGNAL mux_211_nl : STD_LOGIC;
  SIGNAL and_520_nl : STD_LOGIC;
  SIGNAL mux_209_nl : STD_LOGIC;
  SIGNAL mux_208_nl : STD_LOGIC;
  SIGNAL nor_218_nl : STD_LOGIC;
  SIGNAL mux_206_nl : STD_LOGIC;
  SIGNAL mux_205_nl : STD_LOGIC;
  SIGNAL mux_204_nl : STD_LOGIC;
  SIGNAL nor_222_nl : STD_LOGIC;
  SIGNAL mux_202_nl : STD_LOGIC;
  SIGNAL mux_201_nl : STD_LOGIC;
  SIGNAL and_519_nl : STD_LOGIC;
  SIGNAL mux_198_nl : STD_LOGIC;
  SIGNAL mux_197_nl : STD_LOGIC;
  SIGNAL and_488_nl : STD_LOGIC;
  SIGNAL mux_nl : STD_LOGIC;
  SIGNAL or_698_nl : STD_LOGIC;
  SIGNAL nand_71_nl : STD_LOGIC;
  SIGNAL acc_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL IDX_LOOP_mux_25_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_IDX_LOOP_nand_1_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_IDX_LOOP_and_132_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL not_1293_nl : STD_LOGIC;
  SIGNAL STAGE_LOOP_gp_mux_5_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL acc_2_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL IDX_LOOP_mux_26_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL IDX_LOOP_mux_27_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_mux1h_102_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_719_nl : STD_LOGIC;
  SIGNAL and_720_nl : STD_LOGIC;
  SIGNAL and_721_nl : STD_LOGIC;
  SIGNAL and_722_nl : STD_LOGIC;
  SIGNAL and_723_nl : STD_LOGIC;
  SIGNAL and_724_nl : STD_LOGIC;
  SIGNAL and_725_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_mux_28_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_f1_mux1h_205_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_206_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_207_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_208_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_209_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_82_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_83_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_84_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_85_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_210_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_224_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_225_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_226_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_227_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_211_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_86_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_87_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_88_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_89_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_212_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_213_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_90_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_91_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_92_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_93_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_214_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_215_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_94_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_95_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_96_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_97_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_216_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_217_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_260_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_261_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_262_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f2_IDX_LOOP_f2_and_263_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_218_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_219_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_220_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_98_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_99_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_100_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_101_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_221_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_102_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_103_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_104_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_105_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_222_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_106_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_107_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_108_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_109_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_223_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_224_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_225_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_226_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_160_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_161_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_162_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_227_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_110_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_111_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_112_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_228_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_113_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_114_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_115_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_229_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_116_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_117_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_118_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_230_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_119_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_120_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_121_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_231_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_232_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_122_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_123_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_124_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_233_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_187_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_188_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_189_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_234_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_190_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_191_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_192_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_235_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_125_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_126_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_127_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_236_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_128_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_129_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_130_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_237_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_131_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_132_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_or_133_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_238_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_205_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_206_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_and_207_nl : STD_LOGIC;
  SIGNAL IDX_LOOP_f1_mux1h_239_nl : STD_LOGIC;
  SIGNAL p_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a_1 : STD_LOGIC_VECTOR (127 DOWNTO 0);
  SIGNAL IDX_LOOP_1_IDX_LOOP_rem_1_cmp_b : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT modulo_dev
    PORT (
      base_rsc_dat : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      m_rsc_dat : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      return_rsc_z : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      ccs_ccore_start_rsc_dat : IN STD_LOGIC;
      ccs_ccore_clk : IN STD_LOGIC;
      ccs_ccore_srst : IN STD_LOGIC;
      ccs_ccore_en : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL IDX_LOOP_1_modulo_dev_cmp_base_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_modulo_dev_cmp_return_rsc_z_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_start_rsc_dat : STD_LOGIC;

  SIGNAL STAGE_LOOP_op_rshift_rg_a : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL STAGE_LOOP_op_rshift_rg_s : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL STAGE_LOOP_op_rshift_rg_z : STD_LOGIC_VECTOR (9 DOWNTO 0);

  SIGNAL IDX_LOOP_1_lshift_rg_a : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL IDX_LOOP_1_lshift_rg_s : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL IDX_LOOP_1_lshift_rg_z : STD_LOGIC_VECTOR (9 DOWNTO 0);

  COMPONENT DIT_RELOOP_core_wait_dp
    PORT(
      ensig_cgo_iro : IN STD_LOGIC;
      ensig_cgo : IN STD_LOGIC;
      IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT DIT_RELOOP_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      IDX_LOOP_C_33_tr0 : IN STD_LOGIC;
      IDX_LOOP_C_65_tr0 : IN STD_LOGIC;
      IDX_LOOP_C_97_tr0 : IN STD_LOGIC;
      IDX_LOOP_C_129_tr0 : IN STD_LOGIC;
      IDX_LOOP_C_161_tr0 : IN STD_LOGIC;
      IDX_LOOP_C_193_tr0 : IN STD_LOGIC;
      IDX_LOOP_C_225_tr0 : IN STD_LOGIC;
      IDX_LOOP_C_257_tr0 : IN STD_LOGIC;
      GROUP_LOOP_C_0_tr0 : IN STD_LOGIC;
      STAGE_LOOP_C_1_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_33_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_65_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_97_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_129_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_161_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_193_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_225_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_257_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_GROUP_LOOP_C_0_tr0 : STD_LOGIC;
  SIGNAL DIT_RELOOP_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 : STD_LOGIC;

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

  FUNCTION MUX1HOT_v_64_11_2(input_10 : STD_LOGIC_VECTOR(63 DOWNTO 0);
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
  sel : STD_LOGIC_VECTOR(10 DOWNTO 0))
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
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_64_14_2(input_13 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_12 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_11 : STD_LOGIC_VECTOR(63 DOWNTO 0);
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
  sel : STD_LOGIC_VECTOR(13 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 12));
      result := result or ( input_12 and tmp);
      tmp := (OTHERS=>sel( 13));
      result := result or ( input_13 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_64_17_2(input_16 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_15 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_14 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_13 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_12 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_11 : STD_LOGIC_VECTOR(63 DOWNTO 0);
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
  sel : STD_LOGIC_VECTOR(16 DOWNTO 0))
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
      tmp := (OTHERS=>sel( 12));
      result := result or ( input_12 and tmp);
      tmp := (OTHERS=>sel( 13));
      result := result or ( input_13 and tmp);
      tmp := (OTHERS=>sel( 14));
      result := result or ( input_14 and tmp);
      tmp := (OTHERS=>sel( 15));
      result := result or ( input_15 and tmp);
      tmp := (OTHERS=>sel( 16));
      result := result or ( input_16 and tmp);
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

  FUNCTION MUX1HOT_v_7_12_2(input_11 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_10 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(11 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(6 DOWNTO 0);

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

  FUNCTION MUX_v_128_2_2(input_0 : STD_LOGIC_VECTOR(127 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(127 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(127 DOWNTO 0);

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

  FUNCTION minimum(arg1,arg2:INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1<arg2)THEN
      RETURN arg1;
    ELSE
      RETURN arg2;
    END IF;
  END;

  FUNCTION maximum(arg1,arg2:INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1>arg2)THEN
      RETURN arg1;
    ELSE
      RETURN arg2;
    END IF;
  END;

  FUNCTION READSLICE_64_65(input_val:STD_LOGIC_VECTOR(64 DOWNTO 0);index:INTEGER)
  RETURN STD_LOGIC_VECTOR IS
    CONSTANT min_sat_index:INTEGER:= maximum( index, 0 );
    CONSTANT sat_index:INTEGER:= minimum( min_sat_index, 1);
  BEGIN
    RETURN input_val(sat_index+63 DOWNTO sat_index);
  END;

BEGIN
  p_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 5,
      width => 64
      )
    PORT MAP(
      dat => p_rsci_dat,
      idat => p_rsci_idat_1
    );
  p_rsci_dat <= p_rsc_dat;
  p_rsci_idat <= p_rsci_idat_1;

  vec_rsc_triosy_0_7_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_7_lz
    );
  vec_rsc_triosy_0_6_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_6_lz
    );
  vec_rsc_triosy_0_5_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_5_lz
    );
  vec_rsc_triosy_0_4_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_4_lz
    );
  vec_rsc_triosy_0_3_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_3_lz
    );
  vec_rsc_triosy_0_2_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_2_lz
    );
  vec_rsc_triosy_0_1_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_1_lz
    );
  vec_rsc_triosy_0_0_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => vec_rsc_triosy_0_0_lz
    );
  p_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => p_rsc_triosy_lz
    );
  r_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => r_rsc_triosy_lz
    );
  twiddle_rsc_triosy_0_7_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_7_lz
    );
  twiddle_rsc_triosy_0_6_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_6_lz
    );
  twiddle_rsc_triosy_0_5_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_5_lz
    );
  twiddle_rsc_triosy_0_4_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_4_lz
    );
  twiddle_rsc_triosy_0_3_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_3_lz
    );
  twiddle_rsc_triosy_0_2_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_2_lz
    );
  twiddle_rsc_triosy_0_1_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_1_lz
    );
  twiddle_rsc_triosy_0_0_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_twiddle_rsc_triosy_0_0_obj_ld_cse,
      lz => twiddle_rsc_triosy_0_0_lz
    );
  IDX_LOOP_1_IDX_LOOP_rem_1_cmp : work.mgc_comps.mgc_rem
    GENERIC MAP(
      width_a => 128,
      width_b => 64,
      signd => 0
      )
    PORT MAP(
      a => IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a_1,
      b => IDX_LOOP_1_IDX_LOOP_rem_1_cmp_b,
      z => IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z_1
    );
  IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a_1 <= IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a;
  IDX_LOOP_1_IDX_LOOP_rem_1_cmp_b <= reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse;
  IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z <= IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z_1;

  IDX_LOOP_1_modulo_dev_cmp : modulo_dev
    PORT MAP(
      base_rsc_dat => IDX_LOOP_1_modulo_dev_cmp_base_rsc_dat,
      m_rsc_dat => IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat,
      return_rsc_z => IDX_LOOP_1_modulo_dev_cmp_return_rsc_z_1,
      ccs_ccore_start_rsc_dat => IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_start_rsc_dat,
      ccs_ccore_clk => clk,
      ccs_ccore_srst => rst,
      ccs_ccore_en => IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en
    );
  IDX_LOOP_1_modulo_dev_cmp_base_rsc_dat <= READSLICE_64_65(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED((MUX_v_64_2_2(z_out_4,
      tmp_10_lpi_4_dfm, and_dcpl_604 OR and_dcpl_607 OR and_dcpl_610 OR and_dcpl_612
      OR and_dcpl_615 OR and_dcpl_618 OR and_dcpl_620 OR and_dcpl_622)) & ((NOT and_dcpl_604)
      OR and_dcpl_601 OR and_dcpl_607 OR and_dcpl_610 OR and_dcpl_612 OR and_dcpl_615
      OR and_dcpl_618 OR and_dcpl_620 OR and_dcpl_622)) + UNSIGNED((MUX1HOT_v_64_4_2((NOT
      IDX_LOOP_modulo_dev_return_1_sva), IDX_LOOP_modulo_dev_return_1_sva, (NOT z_out_7),
      (NOT z_out_8), STD_LOGIC_VECTOR'( and_dcpl_601 & and_dcpl_604 & (and_dcpl_607
      OR and_dcpl_612 OR and_dcpl_618 OR and_dcpl_622) & (and_dcpl_610 OR and_dcpl_615
      OR and_dcpl_620)))) & '1'), 65)), 1);
  IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat <= p_sva;
  IDX_LOOP_1_modulo_dev_cmp_return_rsc_z <= IDX_LOOP_1_modulo_dev_cmp_return_rsc_z_1;
  IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_start_rsc_dat <= and_dcpl_103 AND (NOT (fsm_output(1)))
      AND (NOT (fsm_output(8)));

  STAGE_LOOP_op_rshift_rg : work.mgc_shift_comps_v5.mgc_shift_r_v5
    GENERIC MAP(
      width_a => 11,
      signd_a => 0,
      width_s => 4,
      width_z => 10
      )
    PORT MAP(
      a => STAGE_LOOP_op_rshift_rg_a,
      s => STAGE_LOOP_op_rshift_rg_s,
      z => STAGE_LOOP_op_rshift_rg_z
    );
  STAGE_LOOP_op_rshift_rg_a <= STD_LOGIC_VECTOR'( "10000000000");
  STAGE_LOOP_op_rshift_rg_s <= STAGE_LOOP_i_3_0_sva;
  STAGE_LOOP_op_rshift_itm <= STAGE_LOOP_op_rshift_rg_z;

  IDX_LOOP_1_lshift_rg : work.mgc_shift_comps_v5.mgc_shift_l_v5
    GENERIC MAP(
      width_a => 10,
      signd_a => 0,
      width_s => 4,
      width_z => 10
      )
    PORT MAP(
      a => IDX_LOOP_1_lshift_rg_a,
      s => IDX_LOOP_1_lshift_rg_s,
      z => IDX_LOOP_1_lshift_rg_z
    );
  IDX_LOOP_1_lshift_rg_a <= (MUX_v_7_2_2(STD_LOGIC_VECTOR'("0000000"), IDX_LOOP_t_10_3_sva_6_0,
      (NOT and_636_ssc))) & ((NOT(and_636_ssc OR and_dcpl_544 OR and_dcpl_547 OR
      and_dcpl_551 OR and_dcpl_553)) OR and_dcpl_555 OR and_dcpl_557 OR and_dcpl_561
      OR and_dcpl_563) & ((NOT(and_636_ssc OR and_dcpl_544 OR and_dcpl_547 OR and_dcpl_555
      OR and_dcpl_557)) OR and_dcpl_551 OR and_dcpl_553 OR and_dcpl_561 OR and_dcpl_563)
      & ((NOT(and_dcpl_544 OR and_dcpl_551 OR and_dcpl_555 OR and_dcpl_561)) OR and_636_ssc
      OR and_dcpl_547 OR and_dcpl_553 OR and_dcpl_557 OR and_dcpl_563);
  IDX_LOOP_1_lshift_rg_s <= MUX_v_4_2_2((z_out_1(3 DOWNTO 0)), STAGE_LOOP_gp_acc_psp_sva,
      and_dcpl_544 OR and_dcpl_547 OR and_dcpl_551 OR and_dcpl_553 OR and_dcpl_555
      OR and_dcpl_557 OR and_dcpl_561 OR and_dcpl_563);
  z_out_6 <= IDX_LOOP_1_lshift_rg_z;

  DIT_RELOOP_core_wait_dp_inst : DIT_RELOOP_core_wait_dp
    PORT MAP(
      ensig_cgo_iro => nor_302_rmff,
      ensig_cgo => reg_ensig_cgo_cse,
      IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en => IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en
    );
  DIT_RELOOP_core_core_fsm_inst : DIT_RELOOP_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => DIT_RELOOP_core_core_fsm_inst_fsm_output,
      IDX_LOOP_C_33_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_33_tr0,
      IDX_LOOP_C_65_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_65_tr0,
      IDX_LOOP_C_97_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_97_tr0,
      IDX_LOOP_C_129_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_129_tr0,
      IDX_LOOP_C_161_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_161_tr0,
      IDX_LOOP_C_193_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_193_tr0,
      IDX_LOOP_C_225_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_225_tr0,
      IDX_LOOP_C_257_tr0 => DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_257_tr0,
      GROUP_LOOP_C_0_tr0 => DIT_RELOOP_core_core_fsm_inst_GROUP_LOOP_C_0_tr0,
      STAGE_LOOP_C_1_tr0 => DIT_RELOOP_core_core_fsm_inst_STAGE_LOOP_C_1_tr0
    );
  fsm_output <= DIT_RELOOP_core_core_fsm_inst_fsm_output;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_33_tr0 <= NOT IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_65_tr0 <= NOT IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_97_tr0 <= NOT IDX_LOOP_slc_IDX_LOOP_acc_8_itm;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_129_tr0 <= NOT IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_161_tr0 <= NOT IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_193_tr0 <= NOT IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_225_tr0 <= NOT IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm;
  DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_257_tr0 <= NOT IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm;
  DIT_RELOOP_core_core_fsm_inst_GROUP_LOOP_C_0_tr0 <= NOT z_out_2_10;
  DIT_RELOOP_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 <= STAGE_LOOP_acc_itm_4_1;

  or_676_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 0)/=STD_LOGIC_VECTOR'("00000000"));
  mux_188_nl <= MUX_s_1_2_2((NOT (fsm_output(3))), (fsm_output(3)), fsm_output(2));
  or_199_nl <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("01"));
  mux_189_nl <= MUX_s_1_2_2(mux_188_nl, or_199_nl, or_680_cse);
  nor_302_rmff <= NOT(mux_189_nl OR (fsm_output(4)) OR (fsm_output(8)));
  or_200_cse <= CONV_SL_1_1(fsm_output(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"));
  mux_293_cse <= MUX_s_1_2_2((fsm_output(0)), nor_tmp_55, IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm);
  mux_289_cse <= MUX_s_1_2_2((fsm_output(0)), nor_tmp_55, IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm);
  mux_286_cse <= MUX_s_1_2_2((fsm_output(0)), nor_tmp_55, IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm);
  or_347_cse <= (IDX_LOOP_idx2_9_0_2_sva(1)) OR nand_23_cse;
  and_513_cse <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11"));
  or_90_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000")) OR or_tmp_3;
  mux_493_nl <= MUX_s_1_2_2(or_tmp_502, (NOT mux_tmp_461), fsm_output(7));
  IDX_LOOP_f1_or_69_cse <= NOT(mux_493_nl AND (NOT (fsm_output(8))));
  mux_494_nl <= MUX_s_1_2_2(not_tmp_296, mux_tmp_461, fsm_output(7));
  IDX_LOOP_f1_or_70_cse <= mux_494_nl OR (fsm_output(8));
  or_680_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  and_448_cse <= or_680_cse AND (fsm_output(2));
  IDX_LOOP_f2_IDX_LOOP_f2_nor_cse <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("00")) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  and_509_cse <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  IDX_LOOP_f2_and_8_cse <= (NOT (IDX_LOOP_idx2_acc_1_psp_sva(1))) AND and_dcpl_207;
  IDX_LOOP_f2_and_10_cse <= (IDX_LOOP_idx2_acc_2_psp_sva(0)) AND and_dcpl_219;
  IDX_LOOP_f2_and_14_cse <= (IDX_LOOP_idx2_acc_3_psp_sva(0)) AND and_dcpl_227;
  IDX_LOOP_f2_and_9_cse <= (IDX_LOOP_idx2_acc_1_psp_sva(1)) AND and_dcpl_207;
  IDX_LOOP_f2_and_11_cse <= (NOT (IDX_LOOP_idx2_acc_2_psp_sva(0))) AND and_dcpl_219;
  IDX_LOOP_f2_and_15_cse <= (NOT (IDX_LOOP_idx2_acc_3_psp_sva(0))) AND and_dcpl_227;
  IDX_LOOP_f1_or_64_tmp <= and_dcpl_247 OR and_dcpl_254 OR and_dcpl_261 OR and_dcpl_267;
  xnor_cse <= NOT((fsm_output(5)) XOR (fsm_output(7)));
  STAGE_LOOP_i_3_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_i_3_0_sva)
      + UNSIGNED'( "0001"), 4));
  IDX_LOOP_idx2_acc_tmp <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_psp_8_sva_mx0w0
      & (z_out_5(1 DOWNTO 0))) + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva(9 DOWNTO
      1)), 9));
  IDX_LOOP_idx1_acc_psp_8_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_5(8
      DOWNTO 2)) + UNSIGNED(IDX_LOOP_t_10_3_sva_6_0), 7));
  IDX_LOOP_idx2_9_0_2_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_psp_8_sva_mx0w0
      & (z_out_5(1 DOWNTO 0)) & '1') + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva),
      10));
  IDX_LOOP_f1_equal_tmp_mx0w0 <= NOT(CONV_SL_1_1(z_out_5(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f1_equal_tmp_1_mx0w0 <= CONV_SL_1_1(z_out_5(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  IDX_LOOP_f1_equal_tmp_2_mx0w0 <= CONV_SL_1_1(z_out_5(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"));
  IDX_LOOP_f1_equal_tmp_3_mx0w0 <= CONV_SL_1_1(z_out_5(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  IDX_LOOP_idx2_acc_1_psp_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_psp_3_sva_mx0w0)
      + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva(9 DOWNTO 1)), 9));
  IDX_LOOP_idx1_acc_psp_3_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_5(8
      DOWNTO 0)) + UNSIGNED(IDX_LOOP_t_10_3_sva_6_0 & STD_LOGIC_VECTOR'( "01")),
      9));
  IDX_LOOP_idx2_9_0_4_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_psp_3_sva_mx0w0
      & '1') + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva), 10));
  IDX_LOOP_idx2_acc_2_psp_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_2_psp_sva_mx0w0
      & (z_out_5(0))) + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva(9 DOWNTO 1)), 9));
  IDX_LOOP_idx1_acc_2_psp_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_5(8
      DOWNTO 1)) + UNSIGNED(IDX_LOOP_t_10_3_sva_6_0 & '1'), 8));
  IDX_LOOP_idx2_9_0_6_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_2_psp_sva_mx0w0
      & (z_out_5(0)) & '1') + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva), 10));
  IDX_LOOP_idx2_acc_3_psp_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_psp_7_sva_mx0w0)
      + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva(9 DOWNTO 1)), 9));
  IDX_LOOP_idx1_acc_psp_7_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_5(8
      DOWNTO 0)) + UNSIGNED(IDX_LOOP_t_10_3_sva_6_0 & STD_LOGIC_VECTOR'( "11")),
      9));
  IDX_LOOP_idx2_9_0_sva_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_idx1_acc_psp_7_sva_mx0w0
      & '1') + UNSIGNED(STAGE_LOOP_op_rshift_psp_1_sva), 10));
  IDX_LOOP_f2_nor_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_1_cse_1 <= NOT((IDX_LOOP_idx2_acc_psp_sva(1)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_f2_nor_2_cse_1 <= NOT((IDX_LOOP_idx2_acc_psp_sva(0)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_IDX_LOOP_and_126_nl <= CONV_SL_1_1(reg_IDX_LOOP_1_lshift_idiv_ftd_7=STD_LOGIC_VECTOR'("001"));
  IDX_LOOP_IDX_LOOP_and_128_nl <= CONV_SL_1_1(reg_IDX_LOOP_1_lshift_idiv_ftd_7=STD_LOGIC_VECTOR'("010"));
  IDX_LOOP_IDX_LOOP_and_130_nl <= CONV_SL_1_1(reg_IDX_LOOP_1_lshift_idiv_ftd_7=STD_LOGIC_VECTOR'("100"));
  IDX_LOOP_mux1h_68_itm_mx0w0 <= MUX1HOT_v_64_8_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_1_i_q_d,
      twiddle_rsc_0_2_i_q_d, twiddle_rsc_0_3_i_q_d, twiddle_rsc_0_4_i_q_d, twiddle_rsc_0_5_i_q_d,
      twiddle_rsc_0_6_i_q_d, twiddle_rsc_0_7_i_q_d, STD_LOGIC_VECTOR'( IDX_LOOP_IDX_LOOP_nor_12_itm
      & IDX_LOOP_IDX_LOOP_and_126_nl & IDX_LOOP_IDX_LOOP_and_128_nl & IDX_LOOP_IDX_LOOP_and_104_itm
      & IDX_LOOP_IDX_LOOP_and_130_nl & IDX_LOOP_IDX_LOOP_and_106_itm & IDX_LOOP_IDX_LOOP_and_107_itm
      & IDX_LOOP_IDX_LOOP_and_108_itm));
  IDX_LOOP_f2_nor_12_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_13_cse_1 <= NOT((IDX_LOOP_idx2_9_0_2_sva(2)) OR (IDX_LOOP_idx2_9_0_2_sva(0)));
  IDX_LOOP_f2_nor_14_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_24_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_25_cse_1 <= NOT((IDX_LOOP_idx2_acc_1_psp_sva(1)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_f2_nor_26_cse_1 <= NOT((IDX_LOOP_idx2_acc_1_psp_sva(0)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_f2_nor_36_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_37_cse_1 <= NOT((IDX_LOOP_idx2_9_0_4_sva(2)) OR (IDX_LOOP_idx2_9_0_4_sva(0)));
  IDX_LOOP_f2_nor_38_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_48_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_49_cse_1 <= NOT((IDX_LOOP_idx2_acc_2_psp_sva(1)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_f2_nor_50_cse_1 <= NOT((IDX_LOOP_idx2_acc_2_psp_sva(0)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_f2_nor_60_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_61_cse_1 <= NOT((IDX_LOOP_idx2_9_0_6_sva(2)) OR (IDX_LOOP_idx2_9_0_6_sva(0)));
  IDX_LOOP_f2_nor_62_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_72_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_73_cse_1 <= NOT((IDX_LOOP_idx2_acc_3_psp_sva(1)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_f2_nor_74_cse_1 <= NOT((IDX_LOOP_idx2_acc_3_psp_sva(0)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  IDX_LOOP_f2_nor_84_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")));
  IDX_LOOP_f2_nor_85_cse_1 <= NOT((IDX_LOOP_idx2_9_0_sva(2)) OR (IDX_LOOP_idx2_9_0_sva(0)));
  IDX_LOOP_f2_nor_86_cse_1 <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  STAGE_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT STAGE_LOOP_i_3_0_sva_2))
      + SIGNED'( "01011"), 5));
  STAGE_LOOP_acc_itm_4_1 <= STAGE_LOOP_acc_nl(4);
  and_dcpl <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_1 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("01"));
  or_tmp_2 <= CONV_SL_1_1(fsm_output(4 DOWNTO 0)/=STD_LOGIC_VECTOR'("00000"));
  or_tmp_3 <= and_509_cse OR CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("000"));
  or_tmp_4 <= CONV_SL_1_1(fsm_output(4 DOWNTO 1)/=STD_LOGIC_VECTOR'("0000"));
  and_dcpl_15 <= NOT(CONV_SL_1_1(fsm_output(8 DOWNTO 6)/=STD_LOGIC_VECTOR'("000")));
  or_tmp_11 <= and_448_cse OR CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_tmp_16 <= (CONV_SL_1_1(fsm_output(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11"))) OR CONV_SL_1_1(fsm_output(4
      DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_tmp_19 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")) OR or_tmp_3;
  or_40_cse <= (CONV_SL_1_1(fsm_output(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"))) OR
      CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_44_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("000"));
  or_47_cse <= (fsm_output(6)) OR or_tmp_3;
  or_51_cse <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_tmp_26 <= CONV_SL_1_1(fsm_output(7 DOWNTO 1)/=STD_LOGIC_VECTOR'("0000000"));
  and_dcpl_55 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_66 <= CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("01"));
  or_677_cse <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  nor_236_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000"))
      OR or_tmp_11);
  mux_180_cse <= MUX_s_1_2_2(or_tmp_26, nor_236_nl, fsm_output(8));
  and_dcpl_93 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_94 <= and_dcpl_93 AND and_dcpl;
  and_dcpl_95 <= NOT(CONV_SL_1_1(fsm_output(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_96 <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_97 <= and_dcpl_96 AND (NOT (fsm_output(2)));
  and_dcpl_101 <= and_dcpl_93 AND CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_102 <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_103 <= and_dcpl_96 AND (fsm_output(2));
  and_dcpl_104 <= and_dcpl_103 AND and_dcpl_102;
  and_dcpl_108 <= and_dcpl_103 AND and_dcpl_95;
  and_dcpl_109 <= and_dcpl_108 AND and_dcpl_94;
  and_dcpl_113 <= and_dcpl_1 AND and_dcpl;
  and_dcpl_114 <= and_dcpl_108 AND and_dcpl_113;
  and_dcpl_116 <= and_dcpl_55 AND and_dcpl;
  and_dcpl_117 <= and_dcpl_108 AND and_dcpl_116;
  and_dcpl_119 <= and_513_cse AND and_dcpl;
  and_dcpl_120 <= and_dcpl_108 AND and_dcpl_119;
  and_dcpl_122 <= and_dcpl_93 AND and_dcpl_66;
  and_dcpl_123 <= and_dcpl_108 AND and_dcpl_122;
  and_dcpl_124 <= and_dcpl_1 AND and_dcpl_66;
  and_dcpl_125 <= and_dcpl_108 AND and_dcpl_124;
  and_dcpl_126 <= and_dcpl_55 AND and_dcpl_66;
  and_dcpl_127 <= and_dcpl_108 AND and_dcpl_126;
  and_dcpl_128 <= and_513_cse AND and_dcpl_66;
  and_dcpl_129 <= and_dcpl_108 AND and_dcpl_128;
  and_dcpl_134 <= CONV_SL_1_1(fsm_output(4 DOWNTO 3)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_135 <= and_dcpl_134 AND (NOT (fsm_output(2)));
  and_dcpl_138 <= and_dcpl_135 AND and_dcpl_95;
  and_dcpl_151 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 4)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT and_dcpl));
  and_dcpl_153 <= CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"));
  and_dcpl_154 <= and_dcpl_97 AND and_dcpl_153;
  and_dcpl_155 <= and_dcpl_154 AND and_dcpl_94;
  and_dcpl_157 <= and_dcpl_97 AND and_509_cse;
  and_dcpl_158 <= and_dcpl_157 AND and_dcpl_94;
  and_dcpl_159 <= and_dcpl_104 AND and_dcpl_94;
  not_tmp_162 <= NOT((z_out_6(1)) AND (fsm_output(3)));
  not_tmp_164 <= NOT((z_out_6(0)) AND (fsm_output(3)));
  nand_44_cse <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111")));
  mux_256_cse <= MUX_s_1_2_2((reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1)), (IDX_LOOP_idx1_acc_2_psp_sva(0)),
      fsm_output(7));
  and_dcpl_176 <= and_dcpl_97 AND (fsm_output(1)) AND (NOT (fsm_output(8)));
  not_tmp_180 <= NOT((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND (fsm_output(0)));
  and_481_cse <= CONV_SL_1_1(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7=STD_LOGIC_VECTOR'("11"));
  or_290_cse <= (NOT (IDX_LOOP_idx1_acc_2_psp_sva(0))) OR (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)))
      OR (fsm_output(0));
  or_288_cse <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (fsm_output(0));
  or_286_cse <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (fsm_output(0));
  and_dcpl_179 <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)=STD_LOGIC_VECTOR'("01"));
  and_dcpl_183 <= and_dcpl_97 AND and_dcpl_102;
  and_dcpl_184 <= and_dcpl_183 AND and_dcpl_113;
  and_dcpl_185 <= and_dcpl_183 AND and_dcpl_116;
  and_dcpl_187 <= and_dcpl_183 AND and_dcpl_119;
  and_dcpl_188 <= and_dcpl_183 AND and_dcpl_122;
  and_dcpl_190 <= and_dcpl_183 AND and_dcpl_124;
  and_dcpl_191 <= and_dcpl_183 AND and_dcpl_126;
  and_dcpl_193 <= and_dcpl_183 AND and_dcpl_128;
  and_dcpl_194 <= and_dcpl_183 AND and_dcpl_101;
  and_dcpl_198 <= (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1)) AND CONV_SL_1_1(fsm_output(6
      DOWNTO 5)=STD_LOGIC_VECTOR'("01")) AND and_dcpl;
  and_dcpl_200 <= and_dcpl_97 AND and_dcpl_153 AND (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0));
  and_dcpl_202 <= (fsm_output(1)) AND (NOT (fsm_output(6)));
  and_dcpl_203 <= and_dcpl_202 AND (fsm_output(5));
  and_dcpl_204 <= and_dcpl_203 AND and_dcpl;
  or_dcpl_74 <= (fsm_output(0)) OR (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)));
  and_dcpl_207 <= and_dcpl_157 AND and_dcpl_116;
  and_dcpl_208 <= (IDX_LOOP_idx1_acc_psp_3_sva(0)) AND (fsm_output(6));
  and_dcpl_210 <= and_dcpl_208 AND (fsm_output(5)) AND and_dcpl;
  and_dcpl_212 <= and_dcpl_97 AND and_dcpl_153 AND (IDX_LOOP_idx1_acc_psp_3_sva(1));
  and_dcpl_214 <= (fsm_output(1)) AND (fsm_output(6));
  and_dcpl_215 <= and_dcpl_214 AND (fsm_output(5));
  and_dcpl_216 <= and_dcpl_215 AND and_dcpl;
  or_dcpl_76 <= (fsm_output(0)) OR (NOT (IDX_LOOP_idx1_acc_psp_3_sva(1)));
  and_dcpl_217 <= and_dcpl_97 AND (or_dcpl_76 OR (NOT (IDX_LOOP_idx1_acc_psp_3_sva(0))));
  and_dcpl_219 <= and_dcpl_157 AND and_dcpl_122;
  and_dcpl_220 <= (IDX_LOOP_idx1_acc_2_psp_sva(0)) AND (NOT (fsm_output(6)));
  and_dcpl_222 <= and_dcpl_220 AND (fsm_output(5)) AND and_dcpl_66;
  and_dcpl_224 <= and_dcpl_203 AND and_dcpl_66;
  and_dcpl_225 <= and_dcpl_97 AND (or_dcpl_74 OR (NOT (IDX_LOOP_idx1_acc_2_psp_sva(0))));
  and_dcpl_227 <= and_dcpl_157 AND and_dcpl_126;
  and_dcpl_228 <= (IDX_LOOP_idx1_acc_psp_7_sva(0)) AND (fsm_output(6));
  and_dcpl_230 <= and_dcpl_228 AND (fsm_output(5)) AND and_dcpl_66;
  and_dcpl_232 <= and_dcpl_97 AND and_dcpl_153 AND (IDX_LOOP_idx1_acc_psp_7_sva(1));
  and_dcpl_234 <= and_dcpl_215 AND and_dcpl_66;
  or_dcpl_79 <= (fsm_output(0)) OR (NOT (IDX_LOOP_idx1_acc_psp_7_sva(1)));
  and_dcpl_235 <= and_dcpl_97 AND (or_dcpl_79 OR (NOT (IDX_LOOP_idx1_acc_psp_7_sva(0))));
  nor_tmp_55 <= (fsm_output(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0));
  or_tmp_248 <= (fsm_output(0)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0));
  and_dcpl_241 <= and_dcpl_96 AND and_dcpl_179;
  and_dcpl_247 <= and_dcpl_157 AND and_dcpl_113;
  and_dcpl_249 <= and_dcpl_208 AND (NOT (fsm_output(5))) AND and_dcpl;
  and_dcpl_251 <= and_dcpl_214 AND (NOT (fsm_output(5)));
  and_dcpl_252 <= and_dcpl_251 AND and_dcpl;
  and_dcpl_254 <= and_dcpl_157 AND and_dcpl_119;
  and_dcpl_256 <= and_dcpl_220 AND (NOT (fsm_output(5))) AND and_dcpl_66;
  and_dcpl_259 <= and_dcpl_202 AND (NOT (fsm_output(5))) AND and_dcpl_66;
  and_dcpl_261 <= and_dcpl_157 AND and_dcpl_124;
  and_dcpl_263 <= and_dcpl_228 AND (NOT (fsm_output(5))) AND and_dcpl_66;
  and_dcpl_265 <= and_dcpl_251 AND and_dcpl_66;
  and_dcpl_267 <= and_dcpl_157 AND and_dcpl_128;
  nand_23_cse <= NOT((IDX_LOOP_idx2_9_0_2_sva(2)) AND (IDX_LOOP_idx2_9_0_2_sva(0)));
  or_362_cse <= CONV_SL_1_1(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7/=STD_LOGIC_VECTOR'("10"));
  and_dcpl_271 <= and_dcpl_97 AND and_dcpl_153 AND (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)));
  or_dcpl_81 <= (fsm_output(0)) OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0));
  and_dcpl_275 <= (NOT (IDX_LOOP_idx1_acc_psp_3_sva(0))) AND (fsm_output(6));
  and_dcpl_277 <= and_dcpl_275 AND (fsm_output(5)) AND and_dcpl;
  or_dcpl_83 <= or_dcpl_76 OR (IDX_LOOP_idx1_acc_psp_3_sva(0));
  and_dcpl_279 <= and_dcpl_97 AND or_dcpl_83;
  or_dcpl_84 <= or_dcpl_81 OR (NOT (IDX_LOOP_idx1_acc_2_psp_sva(0)));
  and_dcpl_282 <= and_dcpl_97 AND or_dcpl_84;
  and_dcpl_284 <= (NOT (IDX_LOOP_idx1_acc_psp_7_sva(0))) AND (fsm_output(6));
  and_dcpl_286 <= and_dcpl_284 AND (fsm_output(5)) AND and_dcpl_66;
  or_dcpl_85 <= or_dcpl_79 OR (IDX_LOOP_idx1_acc_psp_7_sva(0));
  and_dcpl_288 <= and_dcpl_97 AND or_dcpl_85;
  and_dcpl_293 <= and_dcpl_275 AND (NOT (fsm_output(5))) AND and_dcpl;
  and_dcpl_299 <= and_dcpl_284 AND (NOT (fsm_output(5))) AND and_dcpl_66;
  or_425_cse <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"));
  or_439_cse <= (IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)))
      OR (fsm_output(0));
  or_437_cse <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (fsm_output(0));
  or_435_cse <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (fsm_output(0));
  and_dcpl_306 <= (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1))) AND CONV_SL_1_1(fsm_output(6
      DOWNTO 5)=STD_LOGIC_VECTOR'("01")) AND and_dcpl;
  and_dcpl_311 <= and_dcpl_97 AND and_dcpl_153 AND (NOT (IDX_LOOP_idx1_acc_psp_3_sva(1)));
  or_dcpl_87 <= (fsm_output(0)) OR (IDX_LOOP_idx1_acc_psp_3_sva(1));
  and_dcpl_313 <= and_dcpl_97 AND (or_dcpl_87 OR (NOT (IDX_LOOP_idx1_acc_psp_3_sva(0))));
  and_dcpl_315 <= NOT((IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (fsm_output(6)));
  and_dcpl_317 <= and_dcpl_315 AND (fsm_output(5)) AND and_dcpl_66;
  and_dcpl_319 <= and_dcpl_97 AND (or_dcpl_74 OR (IDX_LOOP_idx1_acc_2_psp_sva(0)));
  and_dcpl_322 <= and_dcpl_97 AND and_dcpl_153 AND (NOT (IDX_LOOP_idx1_acc_psp_7_sva(1)));
  or_dcpl_90 <= (fsm_output(0)) OR (IDX_LOOP_idx1_acc_psp_7_sva(1));
  and_dcpl_324 <= and_dcpl_97 AND (or_dcpl_90 OR (NOT (IDX_LOOP_idx1_acc_psp_7_sva(0))));
  or_tmp_395 <= (fsm_output(0)) OR CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0));
  and_dcpl_331 <= and_dcpl_315 AND (NOT (fsm_output(5))) AND and_dcpl_66;
  or_504_cse <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"));
  or_520_cse <= CONV_SL_1_1(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7/=STD_LOGIC_VECTOR'("00"));
  or_519_cse <= (IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0))
      OR (fsm_output(0));
  or_517_cse <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (fsm_output(0));
  or_515_cse <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (fsm_output(0));
  and_dcpl_342 <= and_dcpl_97 AND (or_dcpl_87 OR (IDX_LOOP_idx1_acc_psp_3_sva(0)));
  and_dcpl_345 <= and_dcpl_97 AND (or_dcpl_81 OR (IDX_LOOP_idx1_acc_2_psp_sva(0)));
  and_dcpl_348 <= and_dcpl_97 AND (or_dcpl_90 OR (IDX_LOOP_idx1_acc_psp_7_sva(0)));
  and_tmp_7 <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")) AND or_44_cse;
  or_dcpl_103 <= or_44_cse OR (NOT (fsm_output(1))) OR (fsm_output(0)) OR (fsm_output(6))
      OR (fsm_output(5)) OR (fsm_output(7)) OR (fsm_output(8));
  and_375_nl <= (fsm_output(6)) AND or_tmp_4;
  mux_462_nl <= MUX_s_1_2_2(and_375_nl, (fsm_output(6)), fsm_output(5));
  mux_463_nl <= MUX_s_1_2_2(or_tmp_19, (NOT mux_462_nl), fsm_output(7));
  and_dcpl_367 <= mux_463_nl AND (NOT (fsm_output(8)));
  mux_464_nl <= MUX_s_1_2_2(or_tmp_19, (NOT and_tmp_7), fsm_output(7));
  and_dcpl_368 <= mux_464_nl AND (NOT (fsm_output(8)));
  and_tmp_9 <= (fsm_output(6)) AND or_tmp_2;
  mux_467_nl <= MUX_s_1_2_2(or_tmp_3, (NOT or_44_cse), fsm_output(5));
  and_dcpl_374 <= mux_467_nl AND and_dcpl_15;
  and_tmp_10 <= (fsm_output(6)) AND or_tmp_3;
  mux_470_nl <= MUX_s_1_2_2((NOT or_tmp_3), or_44_cse, fsm_output(6));
  mux_471_nl <= MUX_s_1_2_2(mux_470_nl, (fsm_output(6)), fsm_output(5));
  and_dcpl_377 <= (NOT mux_471_nl) AND and_dcpl;
  and_tmp_11 <= (fsm_output(6)) AND or_44_cse;
  mux_474_nl <= MUX_s_1_2_2(or_47_cse, (NOT and_tmp_11), fsm_output(5));
  and_dcpl_380 <= mux_474_nl AND and_dcpl;
  or_tmp_502 <= CONV_SL_1_1(fsm_output(6 DOWNTO 2)/=STD_LOGIC_VECTOR'("00000"));
  mux_479_nl <= MUX_s_1_2_2(or_tmp_19, (NOT or_tmp_502), fsm_output(7));
  and_dcpl_383 <= mux_479_nl AND (NOT (fsm_output(8)));
  or_tmp_505 <= (fsm_output(6)) OR (fsm_output(2)) OR (fsm_output(4)) OR (fsm_output(3));
  mux_tmp_457 <= MUX_s_1_2_2((fsm_output(6)), or_tmp_505, fsm_output(5));
  mux_485_nl <= MUX_s_1_2_2(or_tmp_19, (NOT mux_tmp_457), fsm_output(7));
  and_dcpl_386 <= mux_485_nl AND (NOT (fsm_output(8)));
  nand_14_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")) AND
      or_tmp_3);
  mux_487_nl <= MUX_s_1_2_2(or_tmp_19, nand_14_nl, fsm_output(7));
  and_dcpl_387 <= mux_487_nl AND (NOT (fsm_output(8)));
  mux_tmp_461 <= MUX_s_1_2_2(and_tmp_11, (fsm_output(6)), fsm_output(5));
  mux_489_nl <= MUX_s_1_2_2(or_tmp_19, (NOT mux_tmp_461), fsm_output(7));
  and_dcpl_388 <= mux_489_nl AND (NOT (fsm_output(8)));
  not_tmp_290 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR or_tmp_16);
  and_dcpl_390 <= NOT((NOT(or_tmp_502 XOR (fsm_output(7)))) OR (fsm_output(8)));
  or_587_nl <= CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"));
  mux_491_nl <= MUX_s_1_2_2((fsm_output(4)), or_51_cse, or_587_nl);
  not_tmp_292 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR mux_491_nl);
  not_tmp_296 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR or_tmp_11);
  not_tmp_298 <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR or_40_cse);
  or_tmp_516 <= CONV_SL_1_1(fsm_output(6 DOWNTO 3)/=STD_LOGIC_VECTOR'("0000"));
  mux_502_nl <= MUX_s_1_2_2((NOT or_tmp_11), or_44_cse, fsm_output(6));
  mux_503_nl <= MUX_s_1_2_2(mux_502_nl, (fsm_output(6)), fsm_output(5));
  and_dcpl_404 <= (NOT mux_503_nl) AND and_dcpl;
  mux_505_nl <= MUX_s_1_2_2(or_tmp_502, (NOT mux_tmp_457), fsm_output(7));
  and_dcpl_407 <= mux_505_nl AND (NOT (fsm_output(8)));
  mux_506_nl <= MUX_s_1_2_2(or_tmp_502, (NOT and_tmp_7), fsm_output(7));
  and_dcpl_408 <= mux_506_nl AND (NOT (fsm_output(8)));
  and_dcpl_413 <= and_dcpl_241 AND (fsm_output(0)) AND (fsm_output(5)) AND (NOT (fsm_output(8)));
  mux_515_nl <= MUX_s_1_2_2(not_tmp_296, mux_tmp_457, fsm_output(7));
  and_dcpl_416 <= NOT(mux_515_nl OR (fsm_output(8)));
  mux_516_nl <= MUX_s_1_2_2(not_tmp_296, and_tmp_7, fsm_output(7));
  and_dcpl_417 <= NOT(mux_516_nl OR (fsm_output(8)));
  mux_520_nl <= MUX_s_1_2_2(not_tmp_290, and_tmp_7, fsm_output(7));
  and_dcpl_419 <= NOT(mux_520_nl OR (fsm_output(8)));
  and_tmp_14 <= (fsm_output(6)) AND or_51_cse;
  mux_523_nl <= MUX_s_1_2_2((fsm_output(4)), or_51_cse, or_200_cse);
  nor_112_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR mux_523_nl);
  mux_524_nl <= MUX_s_1_2_2(nor_112_nl, and_tmp_7, fsm_output(7));
  and_dcpl_423 <= NOT(mux_524_nl OR (fsm_output(8)));
  and_dcpl_430 <= and_dcpl_97 AND or_677_cse AND and_509_cse AND (NOT (fsm_output(5)))
      AND (NOT (fsm_output(8)));
  STAGE_LOOP_i_3_0_sva_mx0c1 <= and_dcpl_104 AND and_dcpl_101;
  GROUP_LOOP_j_10_0_sva_9_0_mx0c0 <= and_dcpl_183 AND and_dcpl_94;
  IDX_LOOP_modulo_dev_return_1_sva_mx0c1 <= and_dcpl_135 AND and_dcpl_102 AND (NOT
      (fsm_output(8)));
  and_359_nl <= and_dcpl_311 AND and_dcpl_293;
  and_360_nl <= and_dcpl_342 AND and_dcpl_252;
  and_361_nl <= and_dcpl_271 AND and_dcpl_331;
  and_362_nl <= and_dcpl_345 AND and_dcpl_259;
  and_363_nl <= and_dcpl_322 AND and_dcpl_299;
  and_364_nl <= and_dcpl_348 AND and_dcpl_265;
  vec_rsc_0_0_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO
      2)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx1_acc_2_psp_sva(7 DOWNTO 1)), (IDX_LOOP_idx2_acc_2_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_7_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_acc_3_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_dcpl_158 & and_dcpl_247 &
      and_359_nl & and_360_nl & and_dcpl_254 & and_361_nl & and_362_nl & and_dcpl_261
      & and_363_nl & and_364_nl & and_dcpl_267));
  and_247_nl <= and_dcpl_154 AND and_dcpl_113;
  and_248_nl <= and_dcpl_154 AND and_dcpl_119;
  and_249_nl <= and_dcpl_154 AND and_dcpl_124;
  and_250_nl <= and_dcpl_154 AND and_dcpl_128;
  vec_rsc_0_0_i_wadr_d_pff <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_psp_sva(8 DOWNTO
      2)), IDX_LOOP_idx1_acc_psp_8_sva, (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_1_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx2_acc_2_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx1_acc_2_psp_sva(7
      DOWNTO 1)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_3_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx1_acc_psp_7_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_184 & and_247_nl & and_dcpl_185 & and_dcpl_187
      & and_248_nl & and_dcpl_188 & and_dcpl_190 & and_249_nl & and_dcpl_191 & and_dcpl_193
      & and_250_nl & and_dcpl_194));
  and_246_nl <= and_dcpl_241 AND (NOT (fsm_output(0))) AND (fsm_output(5)) AND (NOT
      (fsm_output(8)));
  vec_rsc_0_0_i_d_d_pff <= MUX_v_64_2_2(IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z, IDX_LOOP_modulo_dev_return_1_sva,
      and_246_nl);
  or_549_nl <= (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1)) OR (fsm_output(8));
  or_548_nl <= (IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (fsm_output(8));
  mux_432_nl <= MUX_s_1_2_2(or_549_nl, or_548_nl, fsm_output(7));
  nor_130_nl <= NOT((reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) OR mux_432_nl);
  nor_131_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (fsm_output(8)));
  nor_132_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (fsm_output(8)));
  mux_431_nl <= MUX_s_1_2_2(nor_131_nl, nor_132_nl, fsm_output(7));
  mux_433_nl <= MUX_s_1_2_2(nor_130_nl, mux_431_nl, fsm_output(6));
  and_453_nl <= (fsm_output(1)) AND (fsm_output(5)) AND mux_433_nl;
  or_544_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT (fsm_output(8)));
  or_542_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (fsm_output(8));
  mux_428_nl <= MUX_s_1_2_2(or_544_nl, or_542_nl, fsm_output(7));
  or_541_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (fsm_output(8));
  or_540_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (fsm_output(8));
  mux_427_nl <= MUX_s_1_2_2(or_541_nl, or_540_nl, fsm_output(7));
  mux_429_nl <= MUX_s_1_2_2(mux_428_nl, mux_427_nl, fsm_output(6));
  or_539_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_538_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_425_nl <= MUX_s_1_2_2(or_539_nl, or_538_nl, fsm_output(7));
  or_537_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_536_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_424_nl <= MUX_s_1_2_2(or_537_nl, or_536_nl, fsm_output(7));
  mux_426_nl <= MUX_s_1_2_2(mux_425_nl, mux_424_nl, fsm_output(6));
  mux_430_nl <= MUX_s_1_2_2(mux_429_nl, mux_426_nl, fsm_output(5));
  nor_133_nl <= NOT((fsm_output(1)) OR mux_430_nl);
  mux_434_nl <= MUX_s_1_2_2(and_453_nl, nor_133_nl, fsm_output(0));
  vec_rsc_0_0_i_we_d_pff <= mux_434_nl AND and_dcpl_97;
  nor_128_nl <= NOT((fsm_output(0)) OR IDX_LOOP_f2_IDX_LOOP_f2_nor_cse);
  or_570_nl <= (fsm_output(0)) OR CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0));
  mux_448_nl <= MUX_s_1_2_2(nor_128_nl, or_570_nl, or_520_cse);
  or_568_nl <= (IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0));
  mux_446_nl <= MUX_s_1_2_2(mux_293_cse, or_tmp_248, or_568_nl);
  or_566_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  mux_447_nl <= MUX_s_1_2_2(mux_446_nl, or_519_cse, or_566_nl);
  mux_449_nl <= MUX_s_1_2_2(mux_448_nl, mux_447_nl, fsm_output(7));
  or_565_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  mux_442_nl <= MUX_s_1_2_2(mux_289_cse, or_tmp_248, or_565_nl);
  or_563_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  mux_443_nl <= MUX_s_1_2_2(mux_442_nl, or_517_cse, or_563_nl);
  or_561_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  mux_439_nl <= MUX_s_1_2_2(mux_286_cse, or_tmp_248, or_561_nl);
  or_559_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  mux_440_nl <= MUX_s_1_2_2(mux_439_nl, or_515_cse, or_559_nl);
  mux_444_nl <= MUX_s_1_2_2(mux_443_nl, mux_440_nl, fsm_output(7));
  mux_450_nl <= MUX_s_1_2_2(mux_449_nl, mux_444_nl, fsm_output(6));
  or_558_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0)));
  or_556_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0)));
  mux_436_nl <= MUX_s_1_2_2(or_558_nl, or_556_nl, fsm_output(7));
  or_554_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_8_itm) OR (NOT (fsm_output(0)));
  or_552_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm) OR (NOT (fsm_output(0)));
  mux_435_nl <= MUX_s_1_2_2(or_554_nl, or_552_nl, fsm_output(7));
  mux_437_nl <= MUX_s_1_2_2(mux_436_nl, mux_435_nl, fsm_output(6));
  mux_451_nl <= MUX_s_1_2_2(mux_450_nl, mux_437_nl, fsm_output(5));
  vec_rsc_0_0_i_re_d_pff <= (NOT mux_451_nl) AND and_dcpl_176;
  and_345_nl <= and_dcpl_271 AND and_dcpl_306;
  and_347_nl <= and_dcpl_97 AND (or_dcpl_81 OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1)))
      AND and_dcpl_204;
  and_348_nl <= and_dcpl_311 AND and_dcpl_277;
  and_350_nl <= and_dcpl_342 AND and_dcpl_216;
  and_351_nl <= and_dcpl_271 AND and_dcpl_317;
  and_353_nl <= and_dcpl_345 AND and_dcpl_224;
  and_354_nl <= and_dcpl_322 AND and_dcpl_286;
  and_356_nl <= and_dcpl_348 AND and_dcpl_234;
  vec_rsc_0_1_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO
      2)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx2_acc_2_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx1_acc_2_psp_sva(7
      DOWNTO 1)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_3_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx1_acc_psp_7_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_345_nl & and_347_nl & and_dcpl_207
      & and_348_nl & and_350_nl & and_dcpl_219 & and_351_nl & and_353_nl & and_dcpl_227
      & and_354_nl & and_356_nl));
  and_190_nl <= and_dcpl_154 AND and_dcpl_116;
  and_193_nl <= and_dcpl_154 AND and_dcpl_122;
  and_196_nl <= and_dcpl_154 AND and_dcpl_126;
  and_199_nl <= and_dcpl_154 AND and_dcpl_101;
  vec_rsc_0_1_i_wadr_d_pff <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_psp_sva(8 DOWNTO
      2)), (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), IDX_LOOP_idx1_acc_psp_8_sva, (IDX_LOOP_idx2_acc_1_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_3_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_acc_2_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_6_sva(9
      DOWNTO 3)), (IDX_LOOP_idx1_acc_2_psp_sva(7 DOWNTO 1)), (IDX_LOOP_idx2_acc_3_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_7_sva(8
      DOWNTO 2)), STD_LOGIC_VECTOR'( and_dcpl_184 & and_dcpl_185 & and_190_nl & and_dcpl_187
      & and_dcpl_188 & and_193_nl & and_dcpl_190 & and_dcpl_191 & and_196_nl & and_dcpl_193
      & and_dcpl_194 & and_199_nl));
  and_186_nl <= (or_677_cse XOR (fsm_output(8))) AND and_dcpl_96 AND and_dcpl_179
      AND (NOT (fsm_output(0))) AND (NOT (fsm_output(5)));
  vec_rsc_0_1_i_d_d_pff <= MUX_v_64_2_2(IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z, IDX_LOOP_modulo_dev_return_1_sva,
      and_186_nl);
  or_512_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (fsm_output(7)));
  or_510_nl <= (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) OR mux_256_cse;
  mux_409_nl <= MUX_s_1_2_2(or_512_nl, or_510_nl, fsm_output(6));
  or_509_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  mux_410_nl <= MUX_s_1_2_2(mux_409_nl, or_509_nl, fsm_output(8));
  nor_138_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(5)) OR mux_410_nl);
  or_506_nl <= (NOT (fsm_output(7))) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO
      0)/=STD_LOGIC_VECTOR'("001"));
  or_502_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"));
  mux_404_nl <= MUX_s_1_2_2(or_504_cse, or_502_nl, fsm_output(7));
  mux_405_nl <= MUX_s_1_2_2(or_506_nl, mux_404_nl, fsm_output(6));
  or_500_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00")) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("001"));
  mux_406_nl <= MUX_s_1_2_2(mux_405_nl, or_500_nl, fsm_output(8));
  or_497_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  or_495_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  mux_402_nl <= MUX_s_1_2_2(or_497_nl, or_495_nl, fsm_output(7));
  or_493_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  or_491_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  mux_401_nl <= MUX_s_1_2_2(or_493_nl, or_491_nl, fsm_output(7));
  mux_403_nl <= MUX_s_1_2_2(mux_402_nl, mux_401_nl, fsm_output(6));
  or_498_nl <= (fsm_output(8)) OR mux_403_nl;
  mux_407_nl <= MUX_s_1_2_2(mux_406_nl, or_498_nl, fsm_output(5));
  nor_139_nl <= NOT((fsm_output(1)) OR mux_407_nl);
  mux_411_nl <= MUX_s_1_2_2(nor_138_nl, nor_139_nl, fsm_output(0));
  vec_rsc_0_1_i_we_d_pff <= mux_411_nl AND and_dcpl_97;
  nor_134_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (fsm_output(0)));
  nor_135_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0))));
  mux_421_nl <= MUX_s_1_2_2(nor_134_nl, nor_135_nl, fsm_output(7));
  nor_136_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0))));
  nor_137_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0))));
  mux_420_nl <= MUX_s_1_2_2(nor_136_nl, nor_137_nl, fsm_output(7));
  mux_422_nl <= MUX_s_1_2_2(mux_421_nl, mux_420_nl, fsm_output(6));
  nand_10_nl <= NOT((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND mux_422_nl);
  and_343_nl <= (fsm_output(0)) AND or_504_cse;
  mux_416_nl <= MUX_s_1_2_2((fsm_output(0)), and_343_nl, IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm);
  or_522_nl <= (fsm_output(0)) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001"));
  mux_417_nl <= MUX_s_1_2_2(mux_416_nl, or_522_nl, or_520_cse);
  and_454_nl <= ((IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0))
      OR (NOT IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm)) AND (fsm_output(0));
  nor_99_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")));
  mux_415_nl <= MUX_s_1_2_2(or_519_cse, and_454_nl, nor_99_nl);
  mux_418_nl <= MUX_s_1_2_2(mux_417_nl, mux_415_nl, fsm_output(7));
  and_455_nl <= (CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_8_itm)) AND (fsm_output(0));
  nor_97_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")));
  mux_413_nl <= MUX_s_1_2_2(or_517_cse, and_455_nl, nor_97_nl);
  and_456_nl <= (CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm)) AND (fsm_output(0));
  nor_95_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")));
  mux_412_nl <= MUX_s_1_2_2(or_515_cse, and_456_nl, nor_95_nl);
  mux_414_nl <= MUX_s_1_2_2(mux_413_nl, mux_412_nl, fsm_output(7));
  mux_419_nl <= MUX_s_1_2_2(mux_418_nl, mux_414_nl, fsm_output(6));
  mux_423_nl <= MUX_s_1_2_2(nand_10_nl, mux_419_nl, fsm_output(5));
  vec_rsc_0_1_i_re_d_pff <= (NOT mux_423_nl) AND and_dcpl_176;
  and_334_nl <= and_dcpl_311 AND and_dcpl_249;
  and_335_nl <= and_dcpl_313 AND and_dcpl_252;
  and_338_nl <= and_dcpl_200 AND and_dcpl_331;
  and_339_nl <= and_dcpl_319 AND and_dcpl_259;
  and_340_nl <= and_dcpl_322 AND and_dcpl_263;
  and_341_nl <= and_dcpl_324 AND and_dcpl_265;
  vec_rsc_0_2_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO
      2)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx1_acc_2_psp_sva(7 DOWNTO 1)), (IDX_LOOP_idx2_acc_2_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_7_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_acc_3_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_dcpl_158 & and_dcpl_247 &
      and_334_nl & and_335_nl & and_dcpl_254 & and_338_nl & and_339_nl & and_dcpl_261
      & and_340_nl & and_341_nl & and_dcpl_267));
  nor_142_nl <= NOT((reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1)) OR (fsm_output(8)));
  nor_143_nl <= NOT((IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (fsm_output(8)));
  mux_380_nl <= MUX_s_1_2_2(nor_142_nl, nor_143_nl, fsm_output(7));
  and_459_nl <= (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) AND mux_380_nl;
  nor_144_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (fsm_output(8)));
  nor_145_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (fsm_output(8)));
  mux_379_nl <= MUX_s_1_2_2(nor_144_nl, nor_145_nl, fsm_output(7));
  mux_381_nl <= MUX_s_1_2_2(and_459_nl, mux_379_nl, fsm_output(6));
  and_458_nl <= (fsm_output(1)) AND (fsm_output(5)) AND mux_381_nl;
  or_465_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT (fsm_output(8)));
  or_463_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (fsm_output(8));
  mux_376_nl <= MUX_s_1_2_2(or_465_nl, or_463_nl, fsm_output(7));
  or_462_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (fsm_output(8));
  or_461_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (fsm_output(8));
  mux_375_nl <= MUX_s_1_2_2(or_462_nl, or_461_nl, fsm_output(7));
  mux_377_nl <= MUX_s_1_2_2(mux_376_nl, mux_375_nl, fsm_output(6));
  or_460_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_459_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_373_nl <= MUX_s_1_2_2(or_460_nl, or_459_nl, fsm_output(7));
  or_458_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_457_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_372_nl <= MUX_s_1_2_2(or_458_nl, or_457_nl, fsm_output(7));
  mux_374_nl <= MUX_s_1_2_2(mux_373_nl, mux_372_nl, fsm_output(6));
  mux_378_nl <= MUX_s_1_2_2(mux_377_nl, mux_374_nl, fsm_output(5));
  nor_146_nl <= NOT((fsm_output(1)) OR mux_378_nl);
  mux_382_nl <= MUX_s_1_2_2(and_458_nl, nor_146_nl, fsm_output(0));
  vec_rsc_0_2_i_we_d_pff <= mux_382_nl AND and_dcpl_97;
  nor_140_nl <= NOT((fsm_output(0)) OR (NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("01")) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)))));
  mux_396_nl <= MUX_s_1_2_2(or_tmp_395, nor_140_nl, reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0));
  mux_397_nl <= MUX_s_1_2_2(mux_396_nl, or_tmp_395, reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1));
  nor_94_nl <= NOT((IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0))));
  mux_394_nl <= MUX_s_1_2_2(or_tmp_248, mux_293_cse, nor_94_nl);
  or_485_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"));
  mux_395_nl <= MUX_s_1_2_2(mux_394_nl, or_439_cse, or_485_nl);
  mux_398_nl <= MUX_s_1_2_2(mux_397_nl, mux_395_nl, fsm_output(7));
  or_483_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"));
  mux_390_nl <= MUX_s_1_2_2(mux_289_cse, or_tmp_248, or_483_nl);
  nor_93_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01")));
  mux_391_nl <= MUX_s_1_2_2(or_437_cse, mux_390_nl, nor_93_nl);
  or_481_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"));
  mux_387_nl <= MUX_s_1_2_2(mux_286_cse, or_tmp_248, or_481_nl);
  or_479_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"));
  mux_388_nl <= MUX_s_1_2_2(mux_387_nl, or_435_cse, or_479_nl);
  mux_392_nl <= MUX_s_1_2_2(mux_391_nl, mux_388_nl, fsm_output(7));
  mux_399_nl <= MUX_s_1_2_2(mux_398_nl, mux_392_nl, fsm_output(6));
  or_478_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0)));
  or_476_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0)));
  mux_384_nl <= MUX_s_1_2_2(or_478_nl, or_476_nl, fsm_output(7));
  or_474_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_8_itm) OR (NOT (fsm_output(0)));
  or_472_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm) OR (NOT (fsm_output(0)));
  mux_383_nl <= MUX_s_1_2_2(or_474_nl, or_472_nl, fsm_output(7));
  mux_385_nl <= MUX_s_1_2_2(mux_384_nl, mux_383_nl, fsm_output(6));
  mux_400_nl <= MUX_s_1_2_2(mux_399_nl, mux_385_nl, fsm_output(5));
  vec_rsc_0_2_i_re_d_pff <= (NOT mux_400_nl) AND and_dcpl_176;
  and_313_nl <= and_dcpl_200 AND and_dcpl_306;
  and_315_nl <= and_dcpl_97 AND (or_dcpl_74 OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1)))
      AND and_dcpl_204;
  and_318_nl <= and_dcpl_311 AND and_dcpl_210;
  and_320_nl <= and_dcpl_313 AND and_dcpl_216;
  and_324_nl <= and_dcpl_200 AND and_dcpl_317;
  and_326_nl <= and_dcpl_319 AND and_dcpl_224;
  and_329_nl <= and_dcpl_322 AND and_dcpl_230;
  and_331_nl <= and_dcpl_324 AND and_dcpl_234;
  vec_rsc_0_3_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO
      2)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx2_acc_2_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx1_acc_2_psp_sva(7
      DOWNTO 1)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_3_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx1_acc_psp_7_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_313_nl & and_315_nl & and_dcpl_207
      & and_318_nl & and_320_nl & and_dcpl_219 & and_324_nl & and_326_nl & and_dcpl_227
      & and_329_nl & and_331_nl));
  or_432_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (fsm_output(7)));
  nand_6_nl <= NOT((reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) AND (NOT mux_256_cse));
  mux_357_nl <= MUX_s_1_2_2(or_432_nl, nand_6_nl, fsm_output(6));
  or_430_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  mux_358_nl <= MUX_s_1_2_2(mux_357_nl, or_430_nl, fsm_output(8));
  nor_151_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(5)) OR mux_358_nl);
  nand_16_nl <= NOT((fsm_output(7)) AND CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO
      0)=STD_LOGIC_VECTOR'("011")));
  or_423_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"));
  mux_352_nl <= MUX_s_1_2_2(or_425_cse, or_423_nl, fsm_output(7));
  mux_353_nl <= MUX_s_1_2_2(nand_16_nl, mux_352_nl, fsm_output(6));
  or_422_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00")) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("011"));
  mux_354_nl <= MUX_s_1_2_2(mux_353_nl, or_422_nl, fsm_output(8));
  or_419_nl <= (IDX_LOOP_idx2_acc_psp_sva(1)) OR (NOT((IDX_LOOP_idx2_acc_psp_sva(0))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0))));
  or_418_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  mux_350_nl <= MUX_s_1_2_2(or_419_nl, or_418_nl, fsm_output(7));
  or_416_nl <= (IDX_LOOP_idx2_acc_1_psp_sva(1)) OR (NOT((IDX_LOOP_idx2_acc_1_psp_sva(0))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0))));
  or_415_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  mux_349_nl <= MUX_s_1_2_2(or_416_nl, or_415_nl, fsm_output(7));
  mux_351_nl <= MUX_s_1_2_2(mux_350_nl, mux_349_nl, fsm_output(6));
  or_420_nl <= (fsm_output(8)) OR mux_351_nl;
  mux_355_nl <= MUX_s_1_2_2(mux_354_nl, or_420_nl, fsm_output(5));
  nor_152_nl <= NOT((fsm_output(1)) OR mux_355_nl);
  mux_359_nl <= MUX_s_1_2_2(nor_151_nl, nor_152_nl, fsm_output(0));
  vec_rsc_0_3_i_we_d_pff <= mux_359_nl AND and_dcpl_97;
  nor_147_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (fsm_output(0)));
  and_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"))
      AND IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm AND (fsm_output(0));
  mux_369_nl <= MUX_s_1_2_2(nor_147_nl, and_nl, fsm_output(7));
  and_525_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"))
      AND IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm AND (fsm_output(0));
  and_526_nl <= IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm AND CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1
      DOWNTO 0)=STD_LOGIC_VECTOR'("01")) AND (fsm_output(0));
  mux_368_nl <= MUX_s_1_2_2(and_525_nl, and_526_nl, fsm_output(7));
  mux_370_nl <= MUX_s_1_2_2(mux_369_nl, mux_368_nl, fsm_output(6));
  nand_7_nl <= NOT((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND mux_370_nl);
  or_443_nl <= (fsm_output(0)) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011"));
  and_308_nl <= (fsm_output(0)) AND or_425_cse;
  mux_364_nl <= MUX_s_1_2_2((fsm_output(0)), and_308_nl, IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm);
  nor_90_nl <= NOT(CONV_SL_1_1(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7/=STD_LOGIC_VECTOR'("01")));
  mux_365_nl <= MUX_s_1_2_2(or_443_nl, mux_364_nl, nor_90_nl);
  and_460_nl <= ((IDX_LOOP_idx1_acc_2_psp_sva(0)) OR (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)))
      OR (NOT IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm)) AND (fsm_output(0));
  nor_88_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011")));
  mux_363_nl <= MUX_s_1_2_2(or_439_cse, and_460_nl, nor_88_nl);
  mux_366_nl <= MUX_s_1_2_2(mux_365_nl, mux_363_nl, fsm_output(7));
  and_461_nl <= (CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_8_itm)) AND (fsm_output(0));
  nor_86_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011")));
  mux_361_nl <= MUX_s_1_2_2(or_437_cse, and_461_nl, nor_86_nl);
  and_462_nl <= (CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm)) AND (fsm_output(0));
  nor_84_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011")));
  mux_360_nl <= MUX_s_1_2_2(or_435_cse, and_462_nl, nor_84_nl);
  mux_362_nl <= MUX_s_1_2_2(mux_361_nl, mux_360_nl, fsm_output(7));
  mux_367_nl <= MUX_s_1_2_2(mux_366_nl, mux_362_nl, fsm_output(6));
  mux_371_nl <= MUX_s_1_2_2(nand_7_nl, mux_367_nl, fsm_output(5));
  vec_rsc_0_3_i_re_d_pff <= (NOT mux_371_nl) AND and_dcpl_176;
  and_299_nl <= and_dcpl_212 AND and_dcpl_293;
  and_300_nl <= and_dcpl_279 AND and_dcpl_252;
  and_301_nl <= and_dcpl_271 AND and_dcpl_256;
  and_302_nl <= and_dcpl_282 AND and_dcpl_259;
  and_305_nl <= and_dcpl_232 AND and_dcpl_299;
  and_306_nl <= and_dcpl_288 AND and_dcpl_265;
  vec_rsc_0_4_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO
      2)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx1_acc_2_psp_sva(7 DOWNTO 1)), (IDX_LOOP_idx2_acc_2_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_7_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_acc_3_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_dcpl_158 & and_dcpl_247 &
      and_299_nl & and_300_nl & and_dcpl_254 & and_301_nl & and_302_nl & and_dcpl_261
      & and_305_nl & and_306_nl & and_dcpl_267));
  or_391_nl <= (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1))) OR (fsm_output(8));
  or_390_nl <= (NOT (IDX_LOOP_idx1_acc_2_psp_sva(0))) OR (fsm_output(8));
  mux_331_nl <= MUX_s_1_2_2(or_391_nl, or_390_nl, fsm_output(7));
  nor_155_nl <= NOT((reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) OR mux_331_nl);
  nor_156_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (fsm_output(8)));
  nor_157_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (fsm_output(8)));
  mux_330_nl <= MUX_s_1_2_2(nor_156_nl, nor_157_nl, fsm_output(7));
  mux_332_nl <= MUX_s_1_2_2(nor_155_nl, mux_330_nl, fsm_output(6));
  and_466_nl <= (fsm_output(1)) AND (fsm_output(5)) AND mux_332_nl;
  or_386_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT (fsm_output(8)));
  or_384_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (fsm_output(8));
  mux_327_nl <= MUX_s_1_2_2(or_386_nl, or_384_nl, fsm_output(7));
  or_383_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (fsm_output(8));
  or_382_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (fsm_output(8));
  mux_326_nl <= MUX_s_1_2_2(or_383_nl, or_382_nl, fsm_output(7));
  mux_328_nl <= MUX_s_1_2_2(mux_327_nl, mux_326_nl, fsm_output(6));
  or_381_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_380_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_324_nl <= MUX_s_1_2_2(or_381_nl, or_380_nl, fsm_output(7));
  or_379_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_378_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_323_nl <= MUX_s_1_2_2(or_379_nl, or_378_nl, fsm_output(7));
  mux_325_nl <= MUX_s_1_2_2(mux_324_nl, mux_323_nl, fsm_output(6));
  mux_329_nl <= MUX_s_1_2_2(mux_328_nl, mux_325_nl, fsm_output(5));
  nor_158_nl <= NOT((fsm_output(1)) OR mux_329_nl);
  mux_333_nl <= MUX_s_1_2_2(and_466_nl, nor_158_nl, fsm_output(0));
  vec_rsc_0_4_i_we_d_pff <= mux_333_nl AND and_dcpl_97;
  or_413_nl <= CONV_SL_1_1(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (fsm_output(0)));
  nor_153_nl <= NOT((NOT((IDX_LOOP_idx2_acc_tmp(0)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0))))
      OR (fsm_output(0)));
  or_409_nl <= (IDX_LOOP_idx2_acc_tmp(0)) OR (STAGE_LOOP_op_rshift_psp_1_sva(0))
      OR (fsm_output(0));
  mux_344_nl <= MUX_s_1_2_2(nor_153_nl, or_409_nl, or_362_cse);
  mux_345_nl <= MUX_s_1_2_2(or_413_nl, mux_344_nl, IDX_LOOP_idx2_acc_tmp(1));
  and_463_nl <= ((NOT IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)))
      AND (fsm_output(0));
  nor_79_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10")));
  mux_342_nl <= MUX_s_1_2_2(or_tmp_248, and_463_nl, nor_79_nl);
  or_406_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"));
  mux_343_nl <= MUX_s_1_2_2(mux_342_nl, or_dcpl_83, or_406_nl);
  mux_346_nl <= MUX_s_1_2_2(mux_345_nl, mux_343_nl, fsm_output(6));
  or_405_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0)));
  or_403_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_8_itm) OR (NOT (fsm_output(0)));
  mux_341_nl <= MUX_s_1_2_2(or_405_nl, or_403_nl, fsm_output(6));
  mux_347_nl <= MUX_s_1_2_2(mux_346_nl, mux_341_nl, fsm_output(5));
  and_464_nl <= ((NOT IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)))
      AND (fsm_output(0));
  or_399_nl <= (NOT (IDX_LOOP_idx1_acc_2_psp_sva(0))) OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0));
  mux_337_nl <= MUX_s_1_2_2(and_464_nl, or_tmp_248, or_399_nl);
  nor_77_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10")));
  mux_338_nl <= MUX_s_1_2_2(or_dcpl_84, mux_337_nl, nor_77_nl);
  or_398_nl <= (NOT (IDX_LOOP_idx2_acc_3_psp_sva(1))) OR (STAGE_LOOP_op_rshift_psp_1_sva(0))
      OR (fsm_output(0));
  and_465_nl <= ((NOT (IDX_LOOP_idx2_acc_3_psp_sva(1))) OR (NOT IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm)
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND (fsm_output(0));
  nor_75_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10")));
  mux_335_nl <= MUX_s_1_2_2(or_398_nl, and_465_nl, nor_75_nl);
  mux_336_nl <= MUX_s_1_2_2(mux_335_nl, or_dcpl_85, IDX_LOOP_idx2_acc_3_psp_sva(0));
  mux_339_nl <= MUX_s_1_2_2(mux_338_nl, mux_336_nl, fsm_output(6));
  or_396_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm) OR (NOT (fsm_output(0)));
  or_394_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm) OR (NOT (fsm_output(0)));
  mux_334_nl <= MUX_s_1_2_2(or_396_nl, or_394_nl, fsm_output(6));
  mux_340_nl <= MUX_s_1_2_2(mux_339_nl, mux_334_nl, fsm_output(5));
  mux_348_nl <= MUX_s_1_2_2(mux_347_nl, mux_340_nl, fsm_output(7));
  vec_rsc_0_4_i_re_d_pff <= (NOT mux_348_nl) AND and_dcpl_176;
  and_277_nl <= and_dcpl_271 AND and_dcpl_198;
  and_279_nl <= and_dcpl_97 AND (or_dcpl_81 OR (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1))))
      AND and_dcpl_204;
  and_283_nl <= and_dcpl_212 AND and_dcpl_277;
  and_285_nl <= and_dcpl_279 AND and_dcpl_216;
  and_286_nl <= and_dcpl_271 AND and_dcpl_222;
  and_288_nl <= and_dcpl_282 AND and_dcpl_224;
  and_292_nl <= and_dcpl_232 AND and_dcpl_286;
  and_294_nl <= and_dcpl_288 AND and_dcpl_234;
  vec_rsc_0_5_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO
      2)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx2_acc_2_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx1_acc_2_psp_sva(7
      DOWNTO 1)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_3_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx1_acc_psp_7_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_277_nl & and_279_nl & and_dcpl_207
      & and_283_nl & and_285_nl & and_dcpl_219 & and_286_nl & and_288_nl & and_dcpl_227
      & and_292_nl & and_294_nl));
  or_354_nl <= (IDX_LOOP_idx1_acc_psp_3_sva(0)) OR (NOT((IDX_LOOP_idx1_acc_psp_3_sva(1))
      AND (fsm_output(7))));
  or_353_nl <= (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) OR (NOT mux_256_cse);
  mux_308_nl <= MUX_s_1_2_2(or_354_nl, or_353_nl, fsm_output(6));
  or_352_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  mux_309_nl <= MUX_s_1_2_2(mux_308_nl, or_352_nl, fsm_output(8));
  nor_163_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(5)) OR mux_309_nl);
  or_349_nl <= (NOT (fsm_output(7))) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO
      0)/=STD_LOGIC_VECTOR'("101"));
  or_346_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101"));
  mux_303_nl <= MUX_s_1_2_2(or_347_cse, or_346_nl, fsm_output(7));
  mux_304_nl <= MUX_s_1_2_2(or_349_nl, mux_303_nl, fsm_output(6));
  or_344_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00")) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("101"));
  mux_305_nl <= MUX_s_1_2_2(mux_304_nl, or_344_nl, fsm_output(8));
  or_341_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  or_339_nl <= (IDX_LOOP_idx2_acc_2_psp_sva(0)) OR (NOT((IDX_LOOP_idx2_acc_2_psp_sva(1))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0))));
  mux_301_nl <= MUX_s_1_2_2(or_341_nl, or_339_nl, fsm_output(7));
  or_338_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  or_336_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(0)) OR (NOT((IDX_LOOP_idx2_acc_3_psp_sva(1))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0))));
  mux_300_nl <= MUX_s_1_2_2(or_338_nl, or_336_nl, fsm_output(7));
  mux_302_nl <= MUX_s_1_2_2(mux_301_nl, mux_300_nl, fsm_output(6));
  or_342_nl <= (fsm_output(8)) OR mux_302_nl;
  mux_306_nl <= MUX_s_1_2_2(mux_305_nl, or_342_nl, fsm_output(5));
  nor_164_nl <= NOT((fsm_output(1)) OR mux_306_nl);
  mux_310_nl <= MUX_s_1_2_2(nor_163_nl, nor_164_nl, fsm_output(0));
  vec_rsc_0_5_i_we_d_pff <= mux_310_nl AND and_dcpl_97;
  nor_159_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (fsm_output(0)));
  and_522_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"))
      AND IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm AND (fsm_output(0));
  mux_320_nl <= MUX_s_1_2_2(nor_159_nl, and_522_nl, fsm_output(7));
  and_523_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"))
      AND IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm AND (fsm_output(0));
  and_524_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"))
      AND IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm AND (fsm_output(0));
  mux_319_nl <= MUX_s_1_2_2(and_523_nl, and_524_nl, fsm_output(7));
  mux_321_nl <= MUX_s_1_2_2(mux_320_nl, mux_319_nl, fsm_output(6));
  nand_4_nl <= NOT((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND mux_321_nl);
  and_273_nl <= (fsm_output(0)) AND or_347_cse;
  mux_315_nl <= MUX_s_1_2_2((fsm_output(0)), and_273_nl, IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm);
  or_364_nl <= (fsm_output(0)) OR (IDX_LOOP_idx2_9_0_2_sva(1)) OR nand_23_cse;
  mux_316_nl <= MUX_s_1_2_2(mux_315_nl, or_364_nl, or_362_cse);
  or_361_nl <= (NOT (IDX_LOOP_idx1_acc_2_psp_sva(0))) OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0))
      OR (fsm_output(0));
  and_467_nl <= ((NOT (IDX_LOOP_idx1_acc_2_psp_sva(0))) OR (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0))
      OR (NOT IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm)) AND (fsm_output(0));
  nor_71_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")));
  mux_314_nl <= MUX_s_1_2_2(or_361_nl, and_467_nl, nor_71_nl);
  mux_317_nl <= MUX_s_1_2_2(mux_316_nl, mux_314_nl, fsm_output(7));
  or_359_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (fsm_output(0));
  and_468_nl <= (CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_8_itm)) AND (fsm_output(0));
  nor_69_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")));
  mux_312_nl <= MUX_s_1_2_2(or_359_nl, and_468_nl, nor_69_nl);
  or_357_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (fsm_output(0));
  and_469_nl <= (CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"))
      OR (NOT IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm)) AND (fsm_output(0));
  nor_67_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")));
  mux_311_nl <= MUX_s_1_2_2(or_357_nl, and_469_nl, nor_67_nl);
  mux_313_nl <= MUX_s_1_2_2(mux_312_nl, mux_311_nl, fsm_output(7));
  mux_318_nl <= MUX_s_1_2_2(mux_317_nl, mux_313_nl, fsm_output(6));
  mux_322_nl <= MUX_s_1_2_2(nand_4_nl, mux_318_nl, fsm_output(5));
  vec_rsc_0_5_i_re_d_pff <= (NOT mux_322_nl) AND and_dcpl_176;
  and_254_nl <= and_dcpl_212 AND and_dcpl_249;
  and_257_nl <= and_dcpl_217 AND and_dcpl_252;
  and_261_nl <= and_dcpl_200 AND and_dcpl_256;
  and_264_nl <= and_dcpl_225 AND and_dcpl_259;
  and_268_nl <= and_dcpl_232 AND and_dcpl_263;
  and_270_nl <= and_dcpl_235 AND and_dcpl_265;
  vec_rsc_0_6_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO
      2)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx1_acc_2_psp_sva(7 DOWNTO 1)), (IDX_LOOP_idx2_acc_2_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx1_acc_psp_7_sva(8
      DOWNTO 2)), (IDX_LOOP_idx2_acc_3_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_dcpl_158 & and_dcpl_247 &
      and_254_nl & and_257_nl & and_dcpl_254 & and_261_nl & and_264_nl & and_dcpl_261
      & and_268_nl & and_270_nl & and_dcpl_267));
  nor_167_nl <= NOT((NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1))) OR (fsm_output(8)));
  nor_168_nl <= NOT((NOT (IDX_LOOP_idx1_acc_2_psp_sva(0))) OR (fsm_output(8)));
  mux_280_nl <= MUX_s_1_2_2(nor_167_nl, nor_168_nl, fsm_output(7));
  and_479_nl <= (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) AND mux_280_nl;
  nor_169_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (fsm_output(8)));
  nor_170_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (fsm_output(8)));
  mux_279_nl <= MUX_s_1_2_2(nor_169_nl, nor_170_nl, fsm_output(7));
  mux_281_nl <= MUX_s_1_2_2(and_479_nl, mux_279_nl, fsm_output(6));
  and_478_nl <= (fsm_output(1)) AND (fsm_output(5)) AND mux_281_nl;
  nand_31_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110"))
      AND (fsm_output(8)));
  or_313_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR (fsm_output(8));
  mux_276_nl <= MUX_s_1_2_2(nand_31_nl, or_313_nl, fsm_output(7));
  or_312_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR (fsm_output(8));
  or_311_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110"))
      OR (fsm_output(8));
  mux_275_nl <= MUX_s_1_2_2(or_312_nl, or_311_nl, fsm_output(7));
  mux_277_nl <= MUX_s_1_2_2(mux_276_nl, mux_275_nl, fsm_output(6));
  or_310_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_309_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_273_nl <= MUX_s_1_2_2(or_310_nl, or_309_nl, fsm_output(7));
  or_308_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  or_307_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0)) OR (fsm_output(8));
  mux_272_nl <= MUX_s_1_2_2(or_308_nl, or_307_nl, fsm_output(7));
  mux_274_nl <= MUX_s_1_2_2(mux_273_nl, mux_272_nl, fsm_output(6));
  mux_278_nl <= MUX_s_1_2_2(mux_277_nl, mux_274_nl, fsm_output(5));
  nor_171_nl <= NOT((fsm_output(1)) OR mux_278_nl);
  mux_282_nl <= MUX_s_1_2_2(and_478_nl, nor_171_nl, fsm_output(0));
  vec_rsc_0_6_i_we_d_pff <= mux_282_nl AND and_dcpl_97;
  or_674_nl <= (fsm_output(0)) OR CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR (STAGE_LOOP_op_rshift_psp_1_sva(0));
  nor_165_nl <= NOT((fsm_output(0)) OR (NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO
      0)/=STD_LOGIC_VECTOR'("11")) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)))));
  mux_296_nl <= MUX_s_1_2_2(or_674_nl, nor_165_nl, and_481_cse);
  and_471_nl <= (IDX_LOOP_idx1_acc_2_psp_sva(0)) AND (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0));
  mux_294_nl <= MUX_s_1_2_2(or_tmp_248, mux_293_cse, and_471_nl);
  and_472_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  mux_295_nl <= MUX_s_1_2_2(or_290_cse, mux_294_nl, and_472_nl);
  mux_297_nl <= MUX_s_1_2_2(mux_296_nl, mux_295_nl, fsm_output(7));
  and_473_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  mux_290_nl <= MUX_s_1_2_2(or_tmp_248, mux_289_cse, and_473_nl);
  and_474_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  mux_291_nl <= MUX_s_1_2_2(or_288_cse, mux_290_nl, and_474_nl);
  and_475_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  mux_287_nl <= MUX_s_1_2_2(or_tmp_248, mux_286_cse, and_475_nl);
  and_476_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  mux_288_nl <= MUX_s_1_2_2(or_286_cse, mux_287_nl, and_476_nl);
  mux_292_nl <= MUX_s_1_2_2(mux_291_nl, mux_288_nl, fsm_output(7));
  mux_298_nl <= MUX_s_1_2_2(mux_297_nl, mux_292_nl, fsm_output(6));
  nand_68_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110"))
      AND IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm AND (fsm_output(0)));
  nand_69_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110"))
      AND IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm AND (fsm_output(0)));
  mux_284_nl <= MUX_s_1_2_2(nand_68_nl, nand_69_nl, fsm_output(7));
  nand_67_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110"))
      AND IDX_LOOP_slc_IDX_LOOP_acc_8_itm AND (fsm_output(0)));
  nand_66_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110"))
      AND IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm AND (fsm_output(0)));
  mux_283_nl <= MUX_s_1_2_2(nand_67_nl, nand_66_nl, fsm_output(7));
  mux_285_nl <= MUX_s_1_2_2(mux_284_nl, mux_283_nl, fsm_output(6));
  mux_299_nl <= MUX_s_1_2_2(mux_298_nl, mux_285_nl, fsm_output(5));
  vec_rsc_0_6_i_re_d_pff <= (NOT mux_299_nl) AND and_dcpl_176;
  and_205_nl <= and_dcpl_200 AND and_dcpl_198;
  and_210_nl <= and_dcpl_97 AND (or_dcpl_74 OR (NOT (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(1))))
      AND and_dcpl_204;
  and_217_nl <= and_dcpl_212 AND and_dcpl_210;
  and_222_nl <= and_dcpl_217 AND and_dcpl_216;
  and_227_nl <= and_dcpl_200 AND and_dcpl_222;
  and_230_nl <= and_dcpl_225 AND and_dcpl_224;
  and_237_nl <= and_dcpl_232 AND and_dcpl_230;
  and_240_nl <= and_dcpl_235 AND and_dcpl_234;
  vec_rsc_0_7_i_radr_d <= MUX1HOT_v_7_12_2((IDX_LOOP_idx2_acc_tmp(8 DOWNTO 2)), IDX_LOOP_idx1_acc_psp_8_sva,
      (IDX_LOOP_idx2_9_0_2_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_1_psp_sva(8 DOWNTO
      2)), (IDX_LOOP_idx1_acc_psp_3_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_4_sva(9
      DOWNTO 3)), (IDX_LOOP_idx2_acc_2_psp_sva(8 DOWNTO 2)), (IDX_LOOP_idx1_acc_2_psp_sva(7
      DOWNTO 1)), (IDX_LOOP_idx2_9_0_6_sva(9 DOWNTO 3)), (IDX_LOOP_idx2_acc_3_psp_sva(8
      DOWNTO 2)), (IDX_LOOP_idx1_acc_psp_7_sva(8 DOWNTO 2)), (IDX_LOOP_idx2_9_0_sva(9
      DOWNTO 3)), STD_LOGIC_VECTOR'( and_dcpl_155 & and_205_nl & and_210_nl & and_dcpl_207
      & and_217_nl & and_222_nl & and_dcpl_219 & and_227_nl & and_230_nl & and_dcpl_227
      & and_237_nl & and_240_nl));
  nand_41_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (fsm_output(7)));
  nand_42_nl <= NOT((reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0)) AND mux_256_cse);
  mux_257_nl <= MUX_s_1_2_2(nand_41_nl, nand_42_nl, fsm_output(6));
  or_283_nl <= CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"))
      OR CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00"));
  mux_258_nl <= MUX_s_1_2_2(mux_257_nl, or_283_nl, fsm_output(8));
  nor_172_nl <= NOT((NOT (fsm_output(1))) OR (fsm_output(5)) OR mux_258_nl);
  nand_43_nl <= NOT((fsm_output(7)) AND CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO
      0)=STD_LOGIC_VECTOR'("111")));
  nand_45_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111")));
  mux_252_nl <= MUX_s_1_2_2(nand_44_cse, nand_45_nl, fsm_output(7));
  mux_253_nl <= MUX_s_1_2_2(nand_43_nl, mux_252_nl, fsm_output(6));
  or_280_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 6)/=STD_LOGIC_VECTOR'("00")) OR CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
      DOWNTO 0)/=STD_LOGIC_VECTOR'("111"));
  mux_254_nl <= MUX_s_1_2_2(mux_253_nl, or_280_nl, fsm_output(8));
  nand_47_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  nand_48_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  mux_250_nl <= MUX_s_1_2_2(nand_47_nl, nand_48_nl, fsm_output(7));
  nand_49_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  nand_50_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)));
  mux_249_nl <= MUX_s_1_2_2(nand_49_nl, nand_50_nl, fsm_output(7));
  mux_251_nl <= MUX_s_1_2_2(mux_250_nl, mux_249_nl, fsm_output(6));
  or_278_nl <= (fsm_output(8)) OR mux_251_nl;
  mux_255_nl <= MUX_s_1_2_2(mux_254_nl, or_278_nl, fsm_output(5));
  nor_173_nl <= NOT((fsm_output(1)) OR mux_255_nl);
  mux_259_nl <= MUX_s_1_2_2(nor_172_nl, nor_173_nl, fsm_output(0));
  vec_rsc_0_7_i_we_d_pff <= mux_259_nl AND and_dcpl_97;
  nand_32_nl <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND (NOT (fsm_output(0))));
  or_297_nl <= (NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm)) OR not_tmp_180;
  mux_269_nl <= MUX_s_1_2_2(nand_32_nl, or_297_nl, fsm_output(7));
  or_295_nl <= (NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm)) OR not_tmp_180;
  or_293_nl <= (NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm)) OR not_tmp_180;
  mux_268_nl <= MUX_s_1_2_2(or_295_nl, or_293_nl, fsm_output(7));
  mux_270_nl <= MUX_s_1_2_2(mux_269_nl, mux_268_nl, fsm_output(6));
  or_291_nl <= (fsm_output(0)) OR nand_44_cse;
  and_480_nl <= (fsm_output(0)) AND nand_44_cse;
  mux_264_nl <= MUX_s_1_2_2((fsm_output(0)), and_480_nl, IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm);
  mux_265_nl <= MUX_s_1_2_2(or_291_nl, mux_264_nl, and_481_cse);
  and_482_nl <= (NOT((IDX_LOOP_idx1_acc_2_psp_sva(0)) AND (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7(0))
      AND IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm)) AND (fsm_output(0));
  and_483_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  mux_263_nl <= MUX_s_1_2_2(or_290_cse, and_482_nl, and_483_nl);
  mux_266_nl <= MUX_s_1_2_2(mux_265_nl, mux_263_nl, fsm_output(7));
  and_484_nl <= (NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_3_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND IDX_LOOP_slc_IDX_LOOP_acc_8_itm)) AND (fsm_output(0));
  and_485_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  mux_261_nl <= MUX_s_1_2_2(or_288_cse, and_484_nl, and_485_nl);
  and_486_nl <= (NOT(CONV_SL_1_1(IDX_LOOP_idx1_acc_psp_7_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm)) AND (fsm_output(0));
  and_487_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
  mux_260_nl <= MUX_s_1_2_2(or_286_cse, and_486_nl, and_487_nl);
  mux_262_nl <= MUX_s_1_2_2(mux_261_nl, mux_260_nl, fsm_output(7));
  mux_267_nl <= MUX_s_1_2_2(mux_266_nl, mux_262_nl, fsm_output(6));
  mux_271_nl <= MUX_s_1_2_2(mux_270_nl, mux_267_nl, fsm_output(5));
  vec_rsc_0_7_i_re_d_pff <= (NOT mux_271_nl) AND and_dcpl_176;
  twiddle_rsc_0_0_i_radr_d_pff <= z_out_6(9 DOWNTO 3);
  nor_175_cse <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000")) OR
      (fsm_output(3)));
  nor_174_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000")) OR
      (NOT (fsm_output(3))));
  mux_246_nl <= MUX_s_1_2_2(nor_174_nl, nor_175_cse, fsm_output(2));
  mux_247_nl <= MUX_s_1_2_2(mux_246_nl, nor_175_cse, fsm_output(1));
  twiddle_rsc_0_0_i_re_d_pff <= mux_247_nl AND and_dcpl_151;
  nor_183_cse <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")) OR
      (fsm_output(3)));
  nor_182_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("001")) OR
      (NOT (fsm_output(3))));
  mux_239_nl <= MUX_s_1_2_2(nor_182_nl, nor_183_cse, fsm_output(2));
  mux_240_nl <= MUX_s_1_2_2(mux_239_nl, nor_183_cse, fsm_output(1));
  nor_186_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00")) OR
      not_tmp_164);
  mux_236_nl <= MUX_s_1_2_2(nor_186_nl, nor_183_cse, fsm_output(2));
  mux_237_nl <= MUX_s_1_2_2(mux_236_nl, nor_183_cse, fsm_output(1));
  mux_241_nl <= MUX_s_1_2_2(mux_240_nl, mux_237_nl, fsm_output(0));
  twiddle_rsc_0_1_i_re_d_pff <= mux_241_nl AND and_dcpl_151;
  nor_191_cse <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010")) OR
      (fsm_output(3)));
  nor_190_nl <= NOT((z_out_6(2)) OR (z_out_6(0)) OR not_tmp_162);
  mux_232_nl <= MUX_s_1_2_2(nor_190_nl, nor_191_cse, fsm_output(2));
  mux_233_nl <= MUX_s_1_2_2(mux_232_nl, nor_191_cse, fsm_output(1));
  nor_194_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("010")) OR
      (NOT (fsm_output(3))));
  mux_229_nl <= MUX_s_1_2_2(nor_194_nl, nor_191_cse, fsm_output(2));
  mux_230_nl <= MUX_s_1_2_2(mux_229_nl, nor_191_cse, fsm_output(1));
  mux_234_nl <= MUX_s_1_2_2(mux_233_nl, mux_230_nl, fsm_output(0));
  twiddle_rsc_0_2_i_re_d_pff <= mux_234_nl AND and_dcpl_151;
  nor_199_cse <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("011")) OR
      (fsm_output(3)));
  nor_198_nl <= NOT((z_out_6(2)) OR (NOT(CONV_SL_1_1(z_out_6(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (fsm_output(3)))));
  mux_225_nl <= MUX_s_1_2_2(nor_198_nl, nor_199_cse, fsm_output(2));
  mux_226_nl <= MUX_s_1_2_2(mux_225_nl, nor_199_cse, fsm_output(1));
  twiddle_rsc_0_3_i_re_d_pff <= mux_226_nl AND and_dcpl_151;
  nor_207_cse <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100")) OR
      (fsm_output(3)));
  nor_206_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("100")) OR
      (NOT (fsm_output(3))));
  mux_218_nl <= MUX_s_1_2_2(nor_206_nl, nor_207_cse, fsm_output(2));
  mux_219_nl <= MUX_s_1_2_2(mux_218_nl, nor_207_cse, fsm_output(1));
  twiddle_rsc_0_4_i_re_d_pff <= mux_219_nl AND and_dcpl_151;
  nor_215_cse <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("101")) OR
      (fsm_output(3)));
  and_520_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND (fsm_output(3));
  mux_211_nl <= MUX_s_1_2_2(and_520_nl, nor_215_cse, fsm_output(2));
  mux_212_nl <= MUX_s_1_2_2(mux_211_nl, nor_215_cse, fsm_output(1));
  nor_218_nl <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10")) OR
      not_tmp_164);
  mux_208_nl <= MUX_s_1_2_2(nor_218_nl, nor_215_cse, fsm_output(2));
  mux_209_nl <= MUX_s_1_2_2(mux_208_nl, nor_215_cse, fsm_output(1));
  mux_213_nl <= MUX_s_1_2_2(mux_212_nl, mux_209_nl, fsm_output(0));
  twiddle_rsc_0_5_i_re_d_pff <= mux_213_nl AND and_dcpl_151;
  nor_223_cse <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("110")) OR
      (fsm_output(3)));
  nor_222_nl <= NOT((NOT (z_out_6(2))) OR (z_out_6(0)) OR not_tmp_162);
  mux_204_nl <= MUX_s_1_2_2(nor_222_nl, nor_223_cse, fsm_output(2));
  mux_205_nl <= MUX_s_1_2_2(mux_204_nl, nor_223_cse, fsm_output(1));
  and_519_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND (fsm_output(3));
  mux_201_nl <= MUX_s_1_2_2(and_519_nl, nor_223_cse, fsm_output(2));
  mux_202_nl <= MUX_s_1_2_2(mux_201_nl, nor_223_cse, fsm_output(1));
  mux_206_nl <= MUX_s_1_2_2(mux_205_nl, mux_202_nl, fsm_output(0));
  twiddle_rsc_0_6_i_re_d_pff <= mux_206_nl AND and_dcpl_151;
  and_489_cse <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND (NOT
      (fsm_output(3)));
  and_488_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND (fsm_output(3));
  mux_197_nl <= MUX_s_1_2_2(and_488_nl, and_489_cse, fsm_output(2));
  mux_198_nl <= MUX_s_1_2_2(mux_197_nl, and_489_cse, fsm_output(1));
  twiddle_rsc_0_7_i_re_d_pff <= mux_198_nl AND and_dcpl_151;
  and_dcpl_431 <= NOT((fsm_output(5)) OR (fsm_output(7)));
  and_dcpl_436 <= NOT((fsm_output(0)) OR (fsm_output(4)) OR (fsm_output(3)));
  and_dcpl_443 <= and_dcpl_436 AND (fsm_output(2)) AND (NOT (fsm_output(1))) AND
      (NOT (fsm_output(6))) AND (fsm_output(8)) AND and_dcpl_431;
  nor_327_cse <= NOT((fsm_output(6)) OR (fsm_output(8)));
  nor_326_cse <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 2)/=STD_LOGIC_VECTOR'("000")));
  and_dcpl_454 <= nor_326_cse AND CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"))
      AND nor_327_cse AND and_dcpl_431;
  and_dcpl_468 <= and_dcpl_96 AND (fsm_output(2)) AND (NOT (fsm_output(1))) AND (NOT
      (fsm_output(0))) AND (NOT (fsm_output(6))) AND (fsm_output(8)) AND and_dcpl_431;
  and_dcpl_469 <= (fsm_output(5)) AND (NOT (fsm_output(7)));
  and_dcpl_475 <= nor_326_cse AND CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  and_dcpl_476 <= and_dcpl_475 AND nor_327_cse AND and_dcpl_469;
  and_dcpl_477 <= (fsm_output(6)) AND (NOT (fsm_output(8)));
  and_dcpl_479 <= and_dcpl_475 AND and_dcpl_477 AND and_dcpl_469;
  and_dcpl_480 <= (fsm_output(5)) AND (fsm_output(7));
  and_dcpl_482 <= and_dcpl_475 AND nor_327_cse AND and_dcpl_480;
  and_dcpl_484 <= and_dcpl_475 AND and_dcpl_477 AND and_dcpl_480;
  and_dcpl_491 <= and_dcpl_96 AND CONV_SL_1_1(fsm_output(2 DOWNTO 0)=STD_LOGIC_VECTOR'("011"));
  and_dcpl_492 <= and_dcpl_491 AND and_dcpl_477 AND and_dcpl_431;
  and_dcpl_493 <= (NOT (fsm_output(5))) AND (fsm_output(7));
  and_dcpl_496 <= and_dcpl_491 AND nor_327_cse AND and_dcpl_493;
  and_dcpl_498 <= and_dcpl_491 AND and_dcpl_477 AND and_dcpl_493;
  and_dcpl_503 <= and_dcpl_96 AND (fsm_output(2)) AND and_dcpl_95 AND nor_327_cse
      AND and_dcpl_431;
  and_dcpl_509 <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 0)/=STD_LOGIC_VECTOR'("01000")));
  and_dcpl_533 <= CONV_SL_1_1(fsm_output(4 DOWNTO 0)=STD_LOGIC_VECTOR'("00010"))
      AND nor_327_cse AND and_dcpl_431;
  and_dcpl_536 <= nor_327_cse AND and_dcpl_431;
  and_dcpl_544 <= and_dcpl_97 AND and_dcpl_153 AND and_dcpl_536;
  and_dcpl_547 <= and_dcpl_97 AND and_509_cse AND and_dcpl_536;
  and_dcpl_551 <= and_dcpl_103 AND and_dcpl_95 AND and_dcpl_536;
  and_dcpl_553 <= and_dcpl_103 AND and_dcpl_102 AND and_dcpl_536;
  and_dcpl_555 <= and_dcpl_103 AND and_dcpl_153 AND and_dcpl_536;
  and_dcpl_557 <= and_dcpl_103 AND and_509_cse AND and_dcpl_536;
  and_dcpl_559 <= CONV_SL_1_1(fsm_output(4 DOWNTO 2)=STD_LOGIC_VECTOR'("010"));
  and_dcpl_561 <= and_dcpl_559 AND and_dcpl_95 AND and_dcpl_536;
  and_dcpl_563 <= and_dcpl_559 AND and_dcpl_102 AND and_dcpl_536;
  and_dcpl_570 <= and_dcpl_96 AND (fsm_output(2)) AND and_dcpl_95;
  and_dcpl_571 <= and_dcpl_570 AND nor_327_cse AND and_dcpl_469;
  and_dcpl_574 <= and_dcpl_570 AND and_dcpl_477 AND and_dcpl_469;
  and_dcpl_577 <= and_dcpl_570 AND nor_327_cse AND and_dcpl_480;
  and_dcpl_579 <= and_dcpl_570 AND and_dcpl_477 AND and_dcpl_480;
  and_dcpl_587 <= and_dcpl_570 AND and_dcpl_477 AND (NOT (fsm_output(5))) AND (NOT
      (fsm_output(7)));
  and_dcpl_591 <= and_dcpl_570 AND (NOT (fsm_output(6))) AND (NOT (fsm_output(8)))
      AND and_dcpl_493;
  and_dcpl_593 <= and_dcpl_570 AND and_dcpl_477 AND and_dcpl_493;
  and_dcpl_600 <= and_dcpl_103 AND CONV_SL_1_1(fsm_output(1 DOWNTO 0)=STD_LOGIC_VECTOR'("00"));
  and_dcpl_601 <= and_dcpl_600 AND nor_327_cse AND and_dcpl_431;
  and_dcpl_604 <= and_dcpl_103 AND (NOT (fsm_output(1))) AND (fsm_output(0)) AND
      (NOT (fsm_output(8)));
  and_dcpl_607 <= and_dcpl_600 AND nor_327_cse AND and_dcpl_469;
  and_dcpl_610 <= and_dcpl_600 AND and_dcpl_477 AND and_dcpl_431;
  and_dcpl_612 <= and_dcpl_600 AND and_dcpl_477 AND and_dcpl_469;
  and_dcpl_615 <= and_dcpl_600 AND nor_327_cse AND and_dcpl_493;
  and_dcpl_618 <= and_dcpl_600 AND nor_327_cse AND and_dcpl_480;
  and_dcpl_620 <= and_dcpl_600 AND and_dcpl_477 AND and_dcpl_493;
  and_dcpl_622 <= and_dcpl_600 AND and_dcpl_477 AND and_dcpl_480;
  and_636_ssc <= and_dcpl_97 AND and_dcpl_102 AND and_dcpl_536;
  or_tmp <= CONV_SL_1_1(fsm_output(8 DOWNTO 5)/=STD_LOGIC_VECTOR'("0111"));
  or_698_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"));
  nand_71_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")));
  mux_nl <= MUX_s_1_2_2(or_698_nl, nand_71_nl, fsm_output(7));
  or_tmp_545 <= (fsm_output(8)) OR mux_nl;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        STAGE_LOOP_i_3_0_sva <= STD_LOGIC_VECTOR'( "0000");
      ELSIF ( ((and_dcpl_97 AND and_dcpl_95 AND and_dcpl_94) OR STAGE_LOOP_i_3_0_sva_mx0c1)
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
        p_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( mux_187_nl = '0' ) THEN
        p_sva <= p_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        reg_ensig_cgo_cse <= '0';
        IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a <= STD_LOGIC_VECTOR'( "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
        reg_twiddle_rsc_triosy_0_0_obj_ld_cse <= '0';
        IDX_LOOP_IDX_LOOP_and_106_itm <= '0';
        IDX_LOOP_IDX_LOOP_and_107_itm <= '0';
        IDX_LOOP_IDX_LOOP_and_108_itm <= '0';
        IDX_LOOP_IDX_LOOP_nor_12_itm <= '0';
        reg_cse <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        reg_1_cse <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        reg_2_cse <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        tmp_11_sva_29 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        tmp_11_sva_3 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        tmp_11_sva_5 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        tmp_11_sva_7 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        tmp_11_sva_9 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        reg_IDX_LOOP_1_lshift_idiv_ftd_7 <= STD_LOGIC_VECTOR'( "000");
      ELSE
        reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse <= p_sva;
        reg_ensig_cgo_cse <= nor_302_rmff;
        IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a <= MUX_v_128_2_2(IDX_LOOP_1_mul_mut, z_out_5,
            mux_192_nl);
        reg_twiddle_rsc_triosy_0_0_obj_ld_cse <= and_dcpl_104 AND and_dcpl_93 AND
            CONV_SL_1_1(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("10")) AND STAGE_LOOP_acc_itm_4_1;
        IDX_LOOP_IDX_LOOP_and_106_itm <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("101"));
        IDX_LOOP_IDX_LOOP_and_107_itm <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("110"));
        IDX_LOOP_IDX_LOOP_and_108_itm <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("111"));
        IDX_LOOP_IDX_LOOP_nor_12_itm <= NOT(CONV_SL_1_1(z_out_6(2 DOWNTO 0)/=STD_LOGIC_VECTOR'("000")));
        reg_cse <= MUX_v_64_2_2(vec_rsc_0_7_i_q_d, vec_rsc_0_6_i_q_d, and_dcpl_430);
        reg_1_cse <= MUX_v_64_2_2(vec_rsc_0_1_i_q_d, vec_rsc_0_0_i_q_d, and_dcpl_430);
        reg_2_cse <= MUX1HOT_v_64_3_2(vec_rsc_0_3_i_q_d, vec_rsc_0_2_i_q_d, vec_rsc_0_4_i_q_d,
            STD_LOGIC_VECTOR'( and_dcpl_413 & IDX_LOOP_f2_or_5_nl & IDX_LOOP_f2_or_6_nl));
        tmp_11_sva_29 <= MUX_v_64_2_2(vec_rsc_0_5_i_q_d, vec_rsc_0_6_i_q_d, and_dcpl_430);
        tmp_11_sva_3 <= MUX_v_64_2_2(vec_rsc_0_3_i_q_d, vec_rsc_0_0_i_q_d, and_dcpl_430);
        tmp_11_sva_5 <= vec_rsc_0_5_i_q_d;
        tmp_11_sva_7 <= vec_rsc_0_7_i_q_d;
        tmp_11_sva_9 <= vec_rsc_0_1_i_q_d;
        reg_IDX_LOOP_1_lshift_idiv_ftd_7 <= z_out_6(2 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        STAGE_LOOP_op_rshift_psp_1_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( mux_180_cse = '0' ) THEN
        STAGE_LOOP_op_rshift_psp_1_sva <= STAGE_LOOP_op_rshift_itm;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        STAGE_LOOP_gp_lshift_psp_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( mux_180_cse = '0' ) THEN
        STAGE_LOOP_gp_lshift_psp_sva <= z_out_6;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        GROUP_LOOP_j_10_0_sva_9_0 <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (GROUP_LOOP_j_10_0_sva_9_0_mx0c0 OR (and_dcpl_108 AND and_dcpl_101))
          = '1' ) THEN
        GROUP_LOOP_j_10_0_sva_9_0 <= MUX_v_10_2_2(STD_LOGIC_VECTOR'("0000000000"),
            (z_out(9 DOWNTO 0)), GROUP_LOOP_j_not_1_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_t_10_3_sva_6_0 <= STD_LOGIC_VECTOR'( "0000000");
      ELSIF ( (MUX_s_1_2_2(mux_532_nl, or_tmp, fsm_output(4))) = '1' ) THEN
        IDX_LOOP_t_10_3_sva_6_0 <= MUX_v_7_2_2(STD_LOGIC_VECTOR'("0000000"), reg_IDX_LOOP_t_10_3_ftd_1,
            or_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        STAGE_LOOP_gp_acc_psp_sva <= STD_LOGIC_VECTOR'( "0000");
      ELSIF ( mux_180_cse = '0' ) THEN
        STAGE_LOOP_gp_acc_psp_sva <= z_out_1(3 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_acc_psp_sva <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( or_dcpl_103 = '0' ) THEN
        IDX_LOOP_idx2_acc_psp_sva <= IDX_LOOP_idx2_acc_tmp;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx1_acc_psp_8_sva <= STD_LOGIC_VECTOR'( "0000000");
      ELSIF ( (NOT((NOT mux_459_nl) AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_idx1_acc_psp_8_sva <= IDX_LOOP_idx1_acc_psp_8_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_9_0_2_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (NOT((NOT mux_461_nl) AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_idx2_9_0_2_sva <= IDX_LOOP_idx2_9_0_2_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm <= '0';
      ELSIF ( or_dcpl_103 = '0' ) THEN
        IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm <= z_out(10);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_equal_tmp <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f1_equal_tmp <= IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_equal_tmp_1 <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f1_equal_tmp_1 <= IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_equal_tmp_2 <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f1_equal_tmp_2 <= IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_equal_tmp_3 <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f1_equal_tmp_3 <= IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_acc_1_psp_sva <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (NOT(mux_465_nl AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_idx2_acc_1_psp_sva <= IDX_LOOP_idx2_acc_1_psp_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx1_acc_psp_3_sva <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (NOT(mux_466_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_idx1_acc_psp_3_sva <= IDX_LOOP_idx1_acc_psp_3_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm <= '0';
      ELSIF ( (NOT(((or_44_cse OR and_509_cse OR (fsm_output(5))) XOR (fsm_output(6)))
          AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm <= IDX_LOOP_3_acc_nl(10);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_4_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_4_itm <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)/=STD_LOGIC_VECTOR'("000")));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_30_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_30_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_32_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_32_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_33_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_33_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_34_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_34_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_37_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_37_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_39_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_39_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_40_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_40_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_41_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_41_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_44_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_44_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_46_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_46_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_47_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_47_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_48_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_48_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_51_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_51_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_53_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_53_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_54_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_54_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_55_itm <= '0';
      ELSIF ( and_dcpl_374 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_55_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_2_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_9_0_4_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (NOT(mux_468_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_idx2_9_0_4_sva <= IDX_LOOP_idx2_9_0_4_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_slc_IDX_LOOP_acc_8_itm <= '0';
      ELSIF ( (NOT(mux_469_nl AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_slc_IDX_LOOP_acc_8_itm <= IDX_LOOP_acc_nl(8);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_8_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_8_itm <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_39_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_39_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1))) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_41_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_41_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(0))) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_42_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_42_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)))
            AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_43_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_43_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_47_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_47_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1))) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_49_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_49_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(0))) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_50_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_50_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)))
            AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_55_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_55_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1))) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_58_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_58_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)))
            AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_59_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_59_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_63_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_63_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1))) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_66_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_66_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)))
            AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_67_itm <= '0';
      ELSIF ( and_dcpl_377 = '0' ) THEN
        IDX_LOOP_f1_and_67_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_acc_2_psp_sva <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (NOT(mux_473_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_idx2_acc_2_psp_sva <= IDX_LOOP_idx2_acc_2_psp_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx1_acc_2_psp_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( and_dcpl_367 = '0' ) THEN
        IDX_LOOP_idx1_acc_2_psp_sva <= IDX_LOOP_idx1_acc_2_psp_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm <= '0';
      ELSIF ( ((NOT(or_tmp_19 XOR (fsm_output(7)))) OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_5_slc_IDX_LOOP_acc_10_itm <= IDX_LOOP_5_acc_nl(10);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_12_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_12_itm <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)/=STD_LOGIC_VECTOR'("000")));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_88_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_88_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_89_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_89_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_93_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_93_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_95_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_95_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_96_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_96_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_97_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_97_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_100_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_100_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_102_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_102_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_103_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_103_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_104_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_104_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_107_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_107_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_109_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_109_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_110_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_110_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_111_itm <= '0';
      ELSIF ( and_dcpl_380 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_111_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_9_0_6_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (NOT(mux_476_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_idx2_9_0_6_sva <= IDX_LOOP_idx2_9_0_6_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm <= '0';
      ELSIF ( (NOT(mux_478_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_6_slc_IDX_LOOP_acc_10_itm <= IDX_LOOP_6_acc_nl(10);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_16_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_16_itm <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1
            DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_75_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_75_itm <= (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1))) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_77_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_77_itm <= (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(0))) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_78_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_78_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)))
            AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_79_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_79_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_83_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_83_itm <= (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1))) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_85_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_85_itm <= (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(0))) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_86_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_86_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)))
            AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_87_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_87_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_91_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_91_itm <= (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1))) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_93_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_93_itm <= (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(0))) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_94_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_94_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0)))
            AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_95_itm <= '0';
      ELSIF ( and_dcpl_383 = '0' ) THEN
        IDX_LOOP_f1_and_95_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_acc_3_psp_sva <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (NOT(mux_480_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_idx2_acc_3_psp_sva <= IDX_LOOP_idx2_acc_3_psp_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx1_acc_psp_7_sva <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (MUX_s_1_2_2((NOT or_90_cse), or_tmp_26, fsm_output(8))) = '1' ) THEN
        IDX_LOOP_idx1_acc_psp_7_sva <= IDX_LOOP_idx1_acc_psp_7_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm <= '0';
      ELSIF ( (NOT(mux_483_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_7_slc_IDX_LOOP_acc_10_itm <= IDX_LOOP_7_acc_nl(10);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_21_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_21_itm <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)/=STD_LOGIC_VECTOR'("000")));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_144_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_144_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_146_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_146_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_151_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_151_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_152_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_152_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_153_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_153_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_163_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_163_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_165_itm <= '0';
      ELSIF ( and_dcpl_386 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_165_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_idx2_9_0_sva <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (MUX_s_1_2_2((NOT or_90_cse), or_676_cse, fsm_output(8))) = '1' ) THEN
        IDX_LOOP_idx2_9_0_sva <= IDX_LOOP_idx2_9_0_sva_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm <= '0';
      ELSIF ( and_dcpl_387 = '0' ) THEN
        IDX_LOOP_slc_IDX_LOOP_acc_5_7_itm <= IDX_LOOP_acc_5_nl(7);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_24_itm <= '0';
      ELSIF ( and_dcpl_388 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_24_itm <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva_mx0w0(1
            DOWNTO 0)/=STD_LOGIC_VECTOR'("00")) OR (STAGE_LOOP_op_rshift_psp_1_sva(0)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_121_itm <= '0';
      ELSIF ( and_dcpl_388 = '0' ) THEN
        IDX_LOOP_f1_and_121_itm <= (IDX_LOOP_idx2_acc_3_psp_sva_mx0w0(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva_mx0w0(0))) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_123_itm <= '0';
      ELSIF ( and_dcpl_388 = '0' ) THEN
        IDX_LOOP_f1_and_123_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_131_itm <= '0';
      ELSIF ( and_dcpl_388 = '0' ) THEN
        IDX_LOOP_f1_and_131_itm <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva_mx0w0(1
            DOWNTO 0)=STD_LOGIC_VECTOR'("11")) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm <= '0';
      ELSIF ( (NOT(or_90_cse XOR (fsm_output(8)))) = '1' ) THEN
        IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm <= z_out_2_10;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_28_itm <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_nor_28_itm <= NOT(CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva_mx0w0(2
            DOWNTO 0)/=STD_LOGIC_VECTOR'("000")));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_208_itm <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_208_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_209_itm <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_209_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_214_itm <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_214_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_219_itm <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_219_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_222_itm <= '0';
      ELSIF ( and_dcpl_368 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_222_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva_mx0w0(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_101_itm <= '0';
      ELSIF ( (mux_490_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_f1_and_101_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_11_nl, IDX_LOOP_f1_and_101_nl,
            and_dcpl_159);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_102_itm <= '0';
      ELSIF ( and_dcpl_390 = '0' ) THEN
        IDX_LOOP_f1_and_102_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_13_nl, IDX_LOOP_f1_and_102_nl,
            and_dcpl_158);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_103_itm <= '0';
      ELSIF ( and_dcpl_390 = '0' ) THEN
        IDX_LOOP_f1_and_103_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_14_nl, IDX_LOOP_f1_and_103_nl,
            and_dcpl_158);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_111_itm <= '0';
      ELSIF ( (mux_492_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_f1_and_111_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_15_nl, IDX_LOOP_f1_and_111_nl,
            and_169_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_113_itm <= '0';
        IDX_LOOP_f1_and_115_itm <= '0';
        IDX_LOOP_f1_and_135_itm <= '0';
        IDX_LOOP_f1_and_138_itm <= '0';
        IDX_LOOP_f1_and_139_itm <= '0';
      ELSIF ( IDX_LOOP_f1_or_69_cse = '1' ) THEN
        IDX_LOOP_f1_and_113_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_19_nl, IDX_LOOP_f1_and_113_nl,
            and_dcpl_158);
        IDX_LOOP_f1_and_115_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_22_nl, IDX_LOOP_f1_and_115_nl,
            and_dcpl_158);
        IDX_LOOP_f1_and_135_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_31_nl, IDX_LOOP_f1_and_135_nl,
            and_dcpl_158);
        IDX_LOOP_f1_and_138_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_6_nl, IDX_LOOP_f1_and_138_nl,
            and_dcpl_158);
        IDX_LOOP_f1_and_139_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_7_nl, IDX_LOOP_f1_and_139_nl,
            and_dcpl_158);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_114_itm <= '0';
        IDX_LOOP_f1_and_119_itm <= '0';
        IDX_LOOP_f1_and_127_itm <= '0';
      ELSIF ( IDX_LOOP_f1_or_70_cse = '1' ) THEN
        IDX_LOOP_f1_and_114_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_21_nl, IDX_LOOP_f1_and_114_nl,
            and_dcpl_109);
        IDX_LOOP_f1_and_119_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_23_nl, IDX_LOOP_f1_and_119_nl,
            and_dcpl_109);
        IDX_LOOP_f1_and_127_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_29_nl, IDX_LOOP_f1_and_127_nl,
            and_dcpl_109);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_122_itm <= '0';
      ELSIF ( (mux_495_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_f1_and_122_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_27_nl, IDX_LOOP_f1_and_122_nl,
            and_164_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_129_itm <= '0';
      ELSIF ( (NOT(mux_496_nl AND (NOT (fsm_output(8))))) = '1' ) THEN
        IDX_LOOP_f1_and_129_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_3_nl, IDX_LOOP_f1_and_129_nl,
            and_166_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_130_itm <= '0';
      ELSIF ( (mux_497_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_f1_and_130_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_30_nl, IDX_LOOP_f1_and_130_nl,
            and_dcpl_159);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_137_itm <= '0';
      ELSIF ( (mux_499_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_f1_and_137_itm <= MUX_s_1_2_2(IDX_LOOP_f1_and_5_nl, IDX_LOOP_f1_and_137_nl,
            and_412_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_IDX_LOOP_and_104_itm <= '0';
      ELSIF ( (mux_501_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_IDX_LOOP_and_104_itm <= MUX_s_1_2_2(IDX_LOOP_IDX_LOOP_and_2_nl,
            IDX_LOOP_f2_IDX_LOOP_f2_and_215_nl, and_416_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_51_itm <= '0';
      ELSIF ( and_dcpl_404 = '0' ) THEN
        IDX_LOOP_f1_and_51_itm <= MUX_s_1_2_2(IDX_LOOP_f2_IDX_LOOP_f2_nor_cse, IDX_LOOP_f1_and_51_nl,
            and_dcpl_109);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_57_itm <= '0';
      ELSIF ( (NOT(((or_51_cse OR (fsm_output(2)) OR (fsm_output(5))) XOR (fsm_output(6)))
          AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_f1_and_57_itm <= (IDX_LOOP_idx2_acc_1_psp_sva(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva(0))) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_90_itm <= '0';
      ELSIF ( (NOT(mux_504_nl AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_90_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_99_itm <= '0';
      ELSIF ( and_dcpl_390 = '0' ) THEN
        IDX_LOOP_f1_and_99_itm <= (IDX_LOOP_idx2_acc_2_psp_sva(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva(1))) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_142_itm <= '0';
      ELSIF ( and_dcpl_407 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_142_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_149_itm <= '0';
      ELSIF ( and_dcpl_407 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_149_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_156_itm <= '0';
      ELSIF ( and_dcpl_407 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_156_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_159_itm <= '0';
      ELSIF ( and_dcpl_407 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_159_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_160_itm <= '0';
      ELSIF ( and_dcpl_407 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_160_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_166_itm <= '0';
      ELSIF ( and_dcpl_407 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_166_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_200_itm <= '0';
      ELSIF ( and_dcpl_408 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_200_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_223_itm <= '0';
      ELSIF ( and_dcpl_408 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_223_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_mux1h_5_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (mux_509_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_mux1h_5_itm <= IDX_LOOP_mux1h_68_itm_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_modulo_dev_return_1_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (and_dcpl_158 OR IDX_LOOP_modulo_dev_return_1_sva_mx0c1 OR and_dcpl_413
          OR and_dcpl_114 OR and_dcpl_207 OR and_dcpl_117 OR and_dcpl_120 OR and_dcpl_219
          OR and_dcpl_123 OR and_dcpl_125 OR and_dcpl_227 OR and_dcpl_127 OR and_dcpl_129)
          = '1' ) THEN
        IDX_LOOP_modulo_dev_return_1_sva <= MUX1HOT_v_64_11_2(vec_rsc_0_0_i_q_d,
            vec_rsc_0_1_i_q_d, vec_rsc_0_2_i_q_d, vec_rsc_0_3_i_q_d, vec_rsc_0_4_i_q_d,
            vec_rsc_0_5_i_q_d, vec_rsc_0_6_i_q_d, vec_rsc_0_7_i_q_d, IDX_LOOP_1_modulo_dev_cmp_return_rsc_z,
            z_out_7, z_out_8, STD_LOGIC_VECTOR'( IDX_LOOP_f2_and_nl & IDX_LOOP_f2_and_1_nl
            & IDX_LOOP_f2_or_nl & IDX_LOOP_f2_and_3_nl & IDX_LOOP_f2_or_1_nl & IDX_LOOP_f2_or_4_nl
            & IDX_LOOP_f2_and_6_nl & IDX_LOOP_f2_and_7_nl & IDX_LOOP_modulo_dev_return_1_sva_mx0c1
            & IDX_LOOP_f2_or_2_nl & IDX_LOOP_f2_or_3_nl));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_mux1h_1_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (NOT(mux_513_nl AND and_dcpl_15)) = '1' ) THEN
        IDX_LOOP_mux1h_1_itm <= IDX_LOOP_mux1h_68_itm_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f1_and_65_itm <= '0';
      ELSIF ( and_dcpl_404 = '0' ) THEN
        IDX_LOOP_f1_and_65_itm <= (IDX_LOOP_idx2_acc_1_psp_sva(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
            AND (NOT (IDX_LOOP_idx2_acc_1_psp_sva(0))) AND IDX_LOOP_f1_equal_tmp_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_86_itm <= '0';
      ELSIF ( (NOT((NOT mux_514_nl) AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_86_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_4_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_145_itm <= '0';
      ELSIF ( and_dcpl_416 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_145_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_158_itm <= '0';
      ELSIF ( and_dcpl_416 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_158_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_212_itm <= '0';
      ELSIF ( and_dcpl_417 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_212_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_221_itm <= '0';
      ELSIF ( and_dcpl_417 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_221_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        tmp_10_lpi_4_dfm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (and_dcpl_109 OR and_dcpl_247 OR and_dcpl_207 OR and_dcpl_254 OR and_dcpl_219
          OR and_dcpl_261 OR and_dcpl_227 OR and_dcpl_267) = '1' ) THEN
        tmp_10_lpi_4_dfm <= MUX1HOT_v_64_5_2(z_out_4, vec_rsc_0_1_i_q_d, vec_rsc_0_3_i_q_d,
            vec_rsc_0_5_i_q_d, vec_rsc_0_7_i_q_d, STD_LOGIC_VECTOR'( (NOT IDX_LOOP_f1_or_64_tmp)
            & IDX_LOOP_f1_and_208_nl & IDX_LOOP_f1_and_209_nl & IDX_LOOP_f1_and_210_nl
            & IDX_LOOP_f1_and_211_nl));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_mux1h_2_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (NOT((NOT mux_519_nl) AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_mux1h_2_itm <= IDX_LOOP_mux1h_68_itm_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_201_itm <= '0';
      ELSIF ( and_dcpl_419 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_201_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_202_itm <= '0';
      ELSIF ( and_dcpl_419 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_202_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_216_itm <= '0';
      ELSIF ( and_dcpl_419 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_216_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_mux1h_3_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (NOT((NOT mux_521_nl) AND and_dcpl)) = '1' ) THEN
        IDX_LOOP_mux1h_3_itm <= IDX_LOOP_mux1h_68_itm_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_167_itm <= '0';
      ELSIF ( (mux_522_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_167_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_6_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("111")) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_mux1h_4_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( ((NOT(or_tmp_516 XOR (fsm_output(7)))) OR (fsm_output(8))) = '1' )
          THEN
        IDX_LOOP_mux1h_4_itm <= IDX_LOOP_mux1h_68_itm_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_1_mul_mut <= STD_LOGIC_VECTOR'( "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( ((and_dcpl_135 AND xnor_cse AND and_dcpl_95 AND (NOT (fsm_output(6)))
          AND (NOT (fsm_output(8)))) OR (and_dcpl_138 AND and_dcpl_113) OR (and_dcpl_138
          AND and_dcpl_116) OR (and_dcpl_138 AND and_dcpl_119) OR (and_dcpl_138 AND
          and_dcpl_122) OR (and_dcpl_138 AND and_dcpl_126) OR (and_dcpl_138 AND and_dcpl_128))
          = '1' ) THEN
        IDX_LOOP_1_mul_mut <= z_out_5;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_205_itm <= '0';
      ELSIF ( and_dcpl_423 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_205_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_207_itm <= '0';
      ELSIF ( and_dcpl_423 = '0' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_207_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("101")) AND IDX_LOOP_f1_equal_tmp_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_mux1h_6_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (mux_526_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_mux1h_6_itm <= IDX_LOOP_mux1h_68_itm_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_198_itm <= '0';
      ELSIF ( (mux_527_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_f2_IDX_LOOP_f2_and_198_itm <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2
            DOWNTO 0)=STD_LOGIC_VECTOR'("011")) AND IDX_LOOP_f1_equal_tmp_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        IDX_LOOP_mux1h_7_itm <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (mux_529_nl OR (fsm_output(8))) = '1' ) THEN
        IDX_LOOP_mux1h_7_itm <= IDX_LOOP_mux1h_68_itm_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7 <= STD_LOGIC_VECTOR'( "00");
      ELSIF ( and_dcpl_367 = '0' ) THEN
        reg_IDX_LOOP_1_idx1_mul_sdt_ftd_7 <= z_out_5(1 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_IDX_LOOP_t_10_3_ftd_1 <= STD_LOGIC_VECTOR'( "0000000");
      ELSIF ( and_dcpl_387 = '0' ) THEN
        reg_IDX_LOOP_t_10_3_ftd_1 <= z_out_1(6 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  nor_230_nl <= NOT(CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000"))
      OR or_tmp_16);
  mux_187_nl <= MUX_s_1_2_2(or_676_cse, nor_230_nl, fsm_output(8));
  or_202_nl <= CONV_SL_1_1(fsm_output(7 DOWNTO 5)/=STD_LOGIC_VECTOR'("000"));
  mux_190_nl <= MUX_s_1_2_2((NOT (fsm_output(8))), (fsm_output(8)), or_202_nl);
  or_203_nl <= (fsm_output(3)) OR mux_190_nl;
  or_201_nl <= (NOT (fsm_output(3))) OR (fsm_output(8));
  mux_191_nl <= MUX_s_1_2_2(or_203_nl, or_201_nl, or_200_cse);
  mux_192_nl <= MUX_s_1_2_2(mux_191_nl, (fsm_output(8)), fsm_output(4));
  IDX_LOOP_f2_or_5_nl <= IDX_LOOP_f2_and_8_cse OR IDX_LOOP_f2_and_10_cse OR IDX_LOOP_f2_and_14_cse;
  IDX_LOOP_f2_or_6_nl <= IDX_LOOP_f2_and_9_cse OR IDX_LOOP_f2_and_11_cse OR IDX_LOOP_f2_and_15_cse;
  GROUP_LOOP_j_not_1_nl <= NOT GROUP_LOOP_j_10_0_sva_9_0_mx0c0;
  or_690_nl <= (NOT (fsm_output(0))) OR (fsm_output(2));
  or_691_nl <= (fsm_output(0)) OR (NOT (fsm_output(2)));
  mux_182_nl <= MUX_s_1_2_2(or_690_nl, or_691_nl, fsm_output(8));
  or_nl <= mux_182_nl OR (NOT and_dcpl_96) OR (fsm_output(1)) OR (fsm_output(6))
      OR (fsm_output(5)) OR (fsm_output(7));
  or_697_nl <= (NOT((fsm_output(1)) OR (fsm_output(8)))) OR CONV_SL_1_1(fsm_output(7
      DOWNTO 5)/=STD_LOGIC_VECTOR'("000"));
  mux_531_nl <= MUX_s_1_2_2(or_697_nl, or_tmp_545, fsm_output(2));
  mux_530_nl <= MUX_s_1_2_2(or_tmp_545, or_tmp, or_200_cse);
  mux_532_nl <= MUX_s_1_2_2(mux_531_nl, mux_530_nl, fsm_output(3));
  mux_29_nl <= MUX_s_1_2_2((NOT or_tmp_3), or_tmp_4, fsm_output(6));
  mux_459_nl <= MUX_s_1_2_2(mux_29_nl, (fsm_output(6)), fsm_output(5));
  mux_27_nl <= MUX_s_1_2_2((NOT or_tmp_3), or_tmp_2, fsm_output(6));
  mux_461_nl <= MUX_s_1_2_2(mux_27_nl, (fsm_output(6)), fsm_output(5));
  mux_465_nl <= MUX_s_1_2_2(or_47_cse, (NOT and_tmp_9), fsm_output(5));
  nor_300_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 1)/=STD_LOGIC_VECTOR'("000000")));
  mux_466_nl <= MUX_s_1_2_2(or_tmp_19, nor_300_nl, fsm_output(7));
  IDX_LOOP_3_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT STAGE_LOOP_op_rshift_psp_1_sva))
      + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_t_10_3_sva_6_0 & STD_LOGIC_VECTOR'(
      "010")), 10), 11) + SIGNED'( "00000000001"), 11));
  nor_251_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 0)/=STD_LOGIC_VECTOR'("0000000")));
  mux_468_nl <= MUX_s_1_2_2(or_tmp_19, nor_251_nl, fsm_output(7));
  IDX_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & (NOT (STAGE_LOOP_op_rshift_psp_1_sva(9
      DOWNTO 2)))) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_t_10_3_sva_6_0
      & '0'), 8), 9) + UNSIGNED'( "000000001"), 9));
  mux_469_nl <= MUX_s_1_2_2(or_47_cse, (NOT and_tmp_10), fsm_output(5));
  or_35_nl <= (fsm_output(6)) OR (fsm_output(1)) OR (fsm_output(0)) OR (fsm_output(2))
      OR (fsm_output(3)) OR (fsm_output(4));
  mux_472_nl <= MUX_s_1_2_2((fsm_output(6)), or_35_nl, fsm_output(5));
  mux_473_nl <= MUX_s_1_2_2(or_tmp_19, (NOT mux_472_nl), fsm_output(7));
  IDX_LOOP_5_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT STAGE_LOOP_op_rshift_psp_1_sva))
      + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_t_10_3_sva_6_0 & STD_LOGIC_VECTOR'(
      "100")), 10), 11) + SIGNED'( "00000000001"), 11));
  mux_475_nl <= MUX_s_1_2_2(and_tmp_9, (fsm_output(6)), fsm_output(5));
  mux_476_nl <= MUX_s_1_2_2(or_tmp_19, (NOT mux_475_nl), fsm_output(7));
  IDX_LOOP_6_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT STAGE_LOOP_op_rshift_psp_1_sva))
      + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_t_10_3_sva_6_0 & STD_LOGIC_VECTOR'(
      "101")), 10), 11) + SIGNED'( "00000000001"), 11));
  mux_477_nl <= MUX_s_1_2_2((fsm_output(6)), or_47_cse, fsm_output(5));
  mux_478_nl <= MUX_s_1_2_2(or_tmp_19, (NOT mux_477_nl), fsm_output(7));
  nand_15_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")) AND
      or_tmp_2);
  mux_480_nl <= MUX_s_1_2_2(or_tmp_19, nand_15_nl, fsm_output(7));
  IDX_LOOP_7_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT STAGE_LOOP_op_rshift_psp_1_sva))
      + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_t_10_3_sva_6_0 & STD_LOGIC_VECTOR'(
      "110")), 10), 11) + SIGNED'( "00000000001"), 11));
  mux_482_nl <= MUX_s_1_2_2(and_tmp_10, (fsm_output(6)), fsm_output(5));
  mux_483_nl <= MUX_s_1_2_2(or_tmp_19, (NOT mux_482_nl), fsm_output(7));
  IDX_LOOP_acc_5_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & (NOT (STAGE_LOOP_op_rshift_psp_1_sva(9
      DOWNTO 3)))) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_t_10_3_sva_6_0),
      7), 8) + UNSIGNED'( "00000001"), 8));
  IDX_LOOP_f1_and_11_nl <= (IDX_LOOP_idx2_acc_tmp(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(1))) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
  IDX_LOOP_f1_and_101_nl <= (IDX_LOOP_idx2_acc_2_psp_sva(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_2_psp_sva(0))) AND IDX_LOOP_f1_equal_tmp_1;
  mux_490_nl <= MUX_s_1_2_2(not_tmp_290, or_tmp_502, fsm_output(7));
  IDX_LOOP_f1_and_13_nl <= (IDX_LOOP_idx2_acc_tmp(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(0))) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
  IDX_LOOP_f1_and_102_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_and_14_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
  IDX_LOOP_f1_and_103_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_2_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_and_15_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp_1_mx0w0;
  IDX_LOOP_f1_and_111_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva(1))) AND IDX_LOOP_f1_equal_tmp_1;
  and_169_nl <= and_dcpl_135 AND and_dcpl_102 AND and_dcpl_94;
  mux_492_nl <= MUX_s_1_2_2(not_tmp_292, mux_tmp_461, fsm_output(7));
  IDX_LOOP_f1_and_19_nl <= (IDX_LOOP_idx2_acc_tmp(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(1))) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
  IDX_LOOP_f1_and_113_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva(0))) AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_and_22_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
  IDX_LOOP_f1_and_115_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_and_31_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
  IDX_LOOP_f1_and_135_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva(1))) AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f1_and_6_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_mx0w0;
  IDX_LOOP_f1_and_138_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f1_and_7_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp_mx0w0;
  IDX_LOOP_f1_and_139_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f1_and_21_nl <= (IDX_LOOP_idx2_acc_tmp(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(0))) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
  IDX_LOOP_f1_and_114_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_and_23_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp_2_mx0w0;
  IDX_LOOP_f1_and_119_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva(1))) AND IDX_LOOP_f1_equal_tmp_2;
  IDX_LOOP_f1_and_29_nl <= (IDX_LOOP_idx2_acc_tmp(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(0))) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
  IDX_LOOP_f1_and_127_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva(1))) AND IDX_LOOP_f1_equal_tmp_3;
  IDX_LOOP_f1_and_27_nl <= (IDX_LOOP_idx2_acc_tmp(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(1))) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
  IDX_LOOP_f1_and_122_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_2;
  and_164_nl <= and_dcpl_103 AND and_dcpl_153 AND and_dcpl_94;
  mux_495_nl <= MUX_s_1_2_2(not_tmp_298, mux_tmp_461, fsm_output(7));
  IDX_LOOP_f1_and_3_nl <= (IDX_LOOP_idx2_acc_tmp(0)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(1))) AND IDX_LOOP_f1_equal_tmp_mx0w0;
  IDX_LOOP_f1_and_129_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva(0))) AND IDX_LOOP_f1_equal_tmp_3;
  and_166_nl <= and_dcpl_103 AND and_509_cse AND and_dcpl_94;
  mux_496_nl <= MUX_s_1_2_2(or_tmp_516, (NOT mux_tmp_461), fsm_output(7));
  IDX_LOOP_f1_and_30_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_3_mx0w0;
  IDX_LOOP_f1_and_130_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_3_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (NOT (STAGE_LOOP_op_rshift_psp_1_sva(0))) AND IDX_LOOP_f1_equal_tmp_3;
  mux_497_nl <= MUX_s_1_2_2(not_tmp_290, mux_tmp_461, fsm_output(7));
  IDX_LOOP_f1_and_5_nl <= (IDX_LOOP_idx2_acc_tmp(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_tmp(0))) AND IDX_LOOP_f1_equal_tmp_mx0w0;
  IDX_LOOP_f1_and_137_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(1)) AND (STAGE_LOOP_op_rshift_psp_1_sva(0))
      AND (NOT (IDX_LOOP_idx2_acc_3_psp_sva(0))) AND IDX_LOOP_f1_equal_tmp;
  and_412_nl <= and_dcpl_135 AND and_509_cse AND and_dcpl_94;
  mux_498_nl <= MUX_s_1_2_2((fsm_output(4)), or_51_cse, fsm_output(2));
  nor_117_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR mux_498_nl);
  mux_499_nl <= MUX_s_1_2_2(nor_117_nl, mux_tmp_461, fsm_output(7));
  IDX_LOOP_IDX_LOOP_and_2_nl <= CONV_SL_1_1(z_out_6(2 DOWNTO 0)=STD_LOGIC_VECTOR'("011"));
  IDX_LOOP_f2_IDX_LOOP_f2_and_215_nl <= CONV_SL_1_1(IDX_LOOP_idx2_9_0_sva(2 DOWNTO
      0)=STD_LOGIC_VECTOR'("110")) AND IDX_LOOP_f1_equal_tmp_3;
  and_416_nl <= and_dcpl_134 AND (fsm_output(2)) AND and_dcpl_95 AND and_dcpl_94;
  mux_500_nl <= MUX_s_1_2_2((fsm_output(4)), or_51_cse, and_448_cse);
  nor_116_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR mux_500_nl);
  mux_501_nl <= MUX_s_1_2_2(nor_116_nl, and_tmp_7, fsm_output(7));
  IDX_LOOP_f1_and_51_nl <= CONV_SL_1_1(IDX_LOOP_idx2_acc_1_psp_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f1_equal_tmp;
  mux_504_nl <= MUX_s_1_2_2(or_tmp_505, (NOT and_tmp_11), fsm_output(5));
  or_633_nl <= (fsm_output(2)) OR (fsm_output(4));
  mux_508_nl <= MUX_s_1_2_2(or_633_nl, or_44_cse, or_680_cse);
  nor_115_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR mux_508_nl);
  or_630_nl <= (fsm_output(6)) OR (fsm_output(4)) OR (fsm_output(3));
  mux_507_nl <= MUX_s_1_2_2((fsm_output(6)), or_630_nl, fsm_output(5));
  mux_509_nl <= MUX_s_1_2_2(nor_115_nl, mux_507_nl, fsm_output(7));
  IDX_LOOP_f2_and_nl <= ((IDX_LOOP_f1_and_51_itm AND IDX_LOOP_f1_equal_tmp) OR (IDX_LOOP_f1_and_51_itm
      AND IDX_LOOP_f1_equal_tmp_1) OR (IDX_LOOP_f1_and_51_itm AND IDX_LOOP_f1_equal_tmp_2)
      OR (IDX_LOOP_f1_and_51_itm AND IDX_LOOP_f1_equal_tmp_3)) AND and_dcpl_158;
  IDX_LOOP_f2_and_1_nl <= (((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_cse_1
      AND IDX_LOOP_f1_equal_tmp_3)) AND and_dcpl_158;
  IDX_LOOP_f2_or_nl <= ((((IDX_LOOP_idx2_acc_psp_sva(0)) AND IDX_LOOP_f2_nor_1_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_acc_psp_sva(0)) AND IDX_LOOP_f2_nor_1_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_acc_psp_sva(0)) AND IDX_LOOP_f2_nor_1_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_acc_psp_sva(0)) AND IDX_LOOP_f2_nor_1_cse_1
      AND IDX_LOOP_f1_equal_tmp_3)) AND and_dcpl_158) OR IDX_LOOP_f2_and_8_cse OR
      IDX_LOOP_f2_and_10_cse OR IDX_LOOP_f2_and_14_cse;
  IDX_LOOP_f2_and_3_nl <= (IDX_LOOP_f1_and_129_itm OR IDX_LOOP_f1_and_101_itm OR
      IDX_LOOP_f1_and_113_itm OR IDX_LOOP_f1_and_122_itm) AND and_dcpl_158;
  IDX_LOOP_f2_or_1_nl <= ((((IDX_LOOP_idx2_acc_psp_sva(1)) AND IDX_LOOP_f2_nor_2_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_acc_psp_sva(1)) AND IDX_LOOP_f2_nor_2_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_acc_psp_sva(1)) AND IDX_LOOP_f2_nor_2_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_acc_psp_sva(1)) AND IDX_LOOP_f2_nor_2_cse_1
      AND IDX_LOOP_f1_equal_tmp_3)) AND and_dcpl_158) OR IDX_LOOP_f2_and_9_cse OR
      IDX_LOOP_f2_and_11_cse OR IDX_LOOP_f2_and_15_cse;
  IDX_LOOP_f2_or_4_nl <= ((IDX_LOOP_f1_and_137_itm OR IDX_LOOP_f1_and_102_itm OR
      IDX_LOOP_f1_and_114_itm OR IDX_LOOP_f1_and_127_itm) AND and_dcpl_158) OR and_dcpl_413;
  IDX_LOOP_f2_and_6_nl <= (IDX_LOOP_f1_and_138_itm OR IDX_LOOP_f1_and_103_itm OR
      IDX_LOOP_f1_and_115_itm OR IDX_LOOP_f1_and_130_itm) AND and_dcpl_158;
  IDX_LOOP_f2_and_7_nl <= (IDX_LOOP_f1_and_139_itm OR IDX_LOOP_f1_and_111_itm OR
      IDX_LOOP_f1_and_119_itm OR IDX_LOOP_f1_and_135_itm) AND and_dcpl_158;
  IDX_LOOP_f2_or_2_nl <= and_dcpl_114 OR and_dcpl_120 OR and_dcpl_125 OR and_dcpl_129;
  IDX_LOOP_f2_or_3_nl <= and_dcpl_117 OR and_dcpl_123 OR and_dcpl_127;
  mux_513_nl <= MUX_s_1_2_2(or_tmp_11, (NOT or_51_cse), fsm_output(5));
  nor_114_nl <= NOT((fsm_output(6)) OR or_tmp_11);
  mux_514_nl <= MUX_s_1_2_2(nor_114_nl, and_tmp_11, fsm_output(5));
  IDX_LOOP_f1_mux1h_201_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp, IDX_LOOP_f1_equal_tmp_3,
      IDX_LOOP_f1_equal_tmp_2, IDX_LOOP_f1_equal_tmp_1, STD_LOGIC_VECTOR'( and_dcpl_476
      & and_dcpl_479 & and_dcpl_482 & and_dcpl_484));
  IDX_LOOP_f1_and_208_nl <= IDX_LOOP_f1_mux1h_201_nl AND IDX_LOOP_f1_or_64_tmp;
  IDX_LOOP_f1_mux1h_202_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp_1, IDX_LOOP_f1_equal_tmp,
      IDX_LOOP_f1_equal_tmp_3, IDX_LOOP_f1_equal_tmp_2, STD_LOGIC_VECTOR'( and_dcpl_476
      & and_dcpl_479 & and_dcpl_482 & and_dcpl_484));
  IDX_LOOP_f1_and_209_nl <= IDX_LOOP_f1_mux1h_202_nl AND IDX_LOOP_f1_or_64_tmp;
  IDX_LOOP_f1_mux1h_203_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp_2, IDX_LOOP_f1_equal_tmp_1,
      IDX_LOOP_f1_equal_tmp, IDX_LOOP_f1_equal_tmp_3, STD_LOGIC_VECTOR'( and_dcpl_476
      & and_dcpl_479 & and_dcpl_482 & and_dcpl_484));
  IDX_LOOP_f1_and_210_nl <= IDX_LOOP_f1_mux1h_203_nl AND IDX_LOOP_f1_or_64_tmp;
  IDX_LOOP_f1_mux1h_204_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp_3, IDX_LOOP_f1_equal_tmp_2,
      IDX_LOOP_f1_equal_tmp_1, IDX_LOOP_f1_equal_tmp, STD_LOGIC_VECTOR'( and_dcpl_476
      & and_dcpl_479 & and_dcpl_482 & and_dcpl_484));
  IDX_LOOP_f1_and_211_nl <= IDX_LOOP_f1_mux1h_204_nl AND IDX_LOOP_f1_or_64_tmp;
  mux_518_nl <= MUX_s_1_2_2((NOT or_tmp_16), or_51_cse, fsm_output(6));
  mux_519_nl <= MUX_s_1_2_2(mux_518_nl, (fsm_output(6)), fsm_output(5));
  nor_113_nl <= NOT((fsm_output(6)) OR or_40_cse);
  mux_521_nl <= MUX_s_1_2_2(nor_113_nl, and_tmp_14, fsm_output(5));
  mux_522_nl <= MUX_s_1_2_2(not_tmp_298, mux_tmp_457, fsm_output(7));
  mux_525_nl <= MUX_s_1_2_2(and_tmp_14, (fsm_output(6)), fsm_output(5));
  mux_526_nl <= MUX_s_1_2_2(not_tmp_292, mux_525_nl, fsm_output(7));
  mux_527_nl <= MUX_s_1_2_2(not_tmp_292, and_tmp_7, fsm_output(7));
  or_657_nl <= and_509_cse OR (fsm_output(2));
  mux_528_nl <= MUX_s_1_2_2((fsm_output(4)), or_51_cse, or_657_nl);
  nor_260_nl <= NOT(CONV_SL_1_1(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))
      OR mux_528_nl);
  and_521_nl <= CONV_SL_1_1(fsm_output(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")) AND or_51_cse;
  mux_529_nl <= MUX_s_1_2_2(nor_260_nl, and_521_nl, fsm_output(7));
  IDX_LOOP_mux_25_nl <= MUX_v_10_2_2((NOT STAGE_LOOP_op_rshift_psp_1_sva), GROUP_LOOP_j_10_0_sva_9_0,
      and_dcpl_443);
  IDX_LOOP_IDX_LOOP_nand_1_nl <= NOT(and_dcpl_443 AND (NOT(and_dcpl_436 AND CONV_SL_1_1(fsm_output(2
      DOWNTO 1)=STD_LOGIC_VECTOR'("01")) AND nor_327_cse AND and_dcpl_431)));
  not_1293_nl <= NOT and_dcpl_443;
  IDX_LOOP_IDX_LOOP_and_132_nl <= MUX_v_7_2_2(STD_LOGIC_VECTOR'("0000000"), IDX_LOOP_t_10_3_sva_6_0,
      not_1293_nl);
  acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED((NOT and_dcpl_443) & IDX_LOOP_mux_25_nl
      & IDX_LOOP_IDX_LOOP_nand_1_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_IDX_LOOP_and_132_nl
      & STD_LOGIC_VECTOR'( "0011")), 11), 12), 12));
  z_out <= acc_nl(11 DOWNTO 1);
  STAGE_LOOP_gp_mux_5_nl <= MUX_v_7_2_2((STD_LOGIC_VECTOR'( "000") & STAGE_LOOP_i_3_0_sva),
      IDX_LOOP_t_10_3_sva_6_0, and_dcpl_454);
  z_out_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_gp_mux_5_nl),
      8) + CONV_UNSIGNED(CONV_SIGNED(SIGNED'( (NOT and_dcpl_454) & '1'), 2), 8),
      8));
  IDX_LOOP_mux_26_nl <= MUX_v_11_2_2((z_out_1 & STD_LOGIC_VECTOR'( "000")), z_out,
      and_dcpl_468);
  IDX_LOOP_mux_27_nl <= MUX_v_10_2_2((NOT STAGE_LOOP_op_rshift_psp_1_sva), (NOT STAGE_LOOP_gp_lshift_psp_sva),
      and_dcpl_468);
  acc_2_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(IDX_LOOP_mux_26_nl & '1') +
      UNSIGNED('1' & IDX_LOOP_mux_27_nl & '1'), 12));
  z_out_2_10 <= acc_2_nl(11);
  and_719_nl <= and_dcpl_509 AND nor_327_cse AND xnor_cse;
  and_720_nl <= and_dcpl_509 AND nor_327_cse AND and_dcpl_469;
  and_721_nl <= and_dcpl_509 AND and_dcpl_477 AND and_dcpl_431;
  and_722_nl <= and_dcpl_509 AND and_dcpl_477 AND and_dcpl_469;
  and_723_nl <= and_dcpl_509 AND nor_327_cse AND and_dcpl_493;
  and_724_nl <= and_dcpl_509 AND and_dcpl_477 AND and_dcpl_493;
  and_725_nl <= and_dcpl_509 AND and_dcpl_477 AND (fsm_output(5)) AND (fsm_output(7));
  IDX_LOOP_mux1h_102_nl <= MUX1HOT_v_64_8_2(IDX_LOOP_mux1h_5_itm, IDX_LOOP_mux1h_1_itm,
      IDX_LOOP_mux1h_2_itm, IDX_LOOP_mux1h_3_itm, IDX_LOOP_mux1h_4_itm, IDX_LOOP_mux1h_6_itm,
      IDX_LOOP_mux1h_7_itm, (STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000")
      & (GROUP_LOOP_j_10_0_sva_9_0(8 DOWNTO 0))), STD_LOGIC_VECTOR'( and_719_nl &
      and_720_nl & and_721_nl & and_722_nl & and_723_nl & and_724_nl & and_725_nl
      & and_dcpl_533));
  IDX_LOOP_mux_28_nl <= MUX_v_64_2_2(IDX_LOOP_1_modulo_dev_cmp_return_rsc_z, (STD_LOGIC_VECTOR'(
      "0000000000000000000000000000000000000000000000000000000") & (STAGE_LOOP_op_rshift_psp_1_sva(8
      DOWNTO 0))), and_dcpl_533);
  z_out_5 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(IDX_LOOP_mux1h_102_nl)
      * UNSIGNED(IDX_LOOP_mux_28_nl)), 128));
  IDX_LOOP_f1_mux1h_205_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp_3, IDX_LOOP_f1_equal_tmp_2,
      IDX_LOOP_f1_equal_tmp_1, IDX_LOOP_f1_equal_tmp, STD_LOGIC_VECTOR'( and_dcpl_492
      & and_dcpl_496 & and_dcpl_498 & and_dcpl_503));
  IDX_LOOP_f1_mux1h_206_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp, IDX_LOOP_f1_equal_tmp_3,
      IDX_LOOP_f1_equal_tmp_2, IDX_LOOP_f1_equal_tmp_1, STD_LOGIC_VECTOR'( and_dcpl_492
      & and_dcpl_496 & and_dcpl_498 & and_dcpl_503));
  IDX_LOOP_f1_mux1h_207_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp_1, IDX_LOOP_f1_equal_tmp,
      IDX_LOOP_f1_equal_tmp_3, IDX_LOOP_f1_equal_tmp_2, STD_LOGIC_VECTOR'( and_dcpl_492
      & and_dcpl_496 & and_dcpl_498 & and_dcpl_503));
  IDX_LOOP_f1_mux1h_208_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_equal_tmp_2, IDX_LOOP_f1_equal_tmp_1,
      IDX_LOOP_f1_equal_tmp, IDX_LOOP_f1_equal_tmp_3, STD_LOGIC_VECTOR'( and_dcpl_492
      & and_dcpl_496 & and_dcpl_498 & and_dcpl_503));
  z_out_4 <= MUX1HOT_v_64_4_2(vec_rsc_0_0_i_q_d, vec_rsc_0_2_i_q_d, vec_rsc_0_4_i_q_d,
      vec_rsc_0_6_i_q_d, STD_LOGIC_VECTOR'( IDX_LOOP_f1_mux1h_205_nl & IDX_LOOP_f1_mux1h_206_nl
      & IDX_LOOP_f1_mux1h_207_nl & IDX_LOOP_f1_mux1h_208_nl));
  IDX_LOOP_f1_or_82_nl <= (IDX_LOOP_f2_IDX_LOOP_f2_nor_4_itm AND IDX_LOOP_f1_equal_tmp)
      OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_4_itm AND IDX_LOOP_f1_equal_tmp_1) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_4_itm
      AND IDX_LOOP_f1_equal_tmp_2) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_4_itm AND IDX_LOOP_f1_equal_tmp_3);
  IDX_LOOP_f1_or_83_nl <= (IDX_LOOP_f2_IDX_LOOP_f2_nor_12_itm AND IDX_LOOP_f1_equal_tmp_3)
      OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_12_itm AND IDX_LOOP_f1_equal_tmp) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_12_itm
      AND IDX_LOOP_f1_equal_tmp_1) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_12_itm AND IDX_LOOP_f1_equal_tmp_2);
  IDX_LOOP_f1_or_84_nl <= (IDX_LOOP_f2_IDX_LOOP_f2_nor_21_itm AND IDX_LOOP_f1_equal_tmp_2)
      OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_21_itm AND IDX_LOOP_f1_equal_tmp_3) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_21_itm
      AND IDX_LOOP_f1_equal_tmp) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_21_itm AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_85_nl <= (IDX_LOOP_f2_IDX_LOOP_f2_nor_28_itm AND IDX_LOOP_f1_equal_tmp_1)
      OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_28_itm AND IDX_LOOP_f1_equal_tmp_2) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_28_itm
      AND IDX_LOOP_f1_equal_tmp_3) OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_28_itm AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_mux1h_209_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_or_82_nl, IDX_LOOP_f1_or_83_nl,
      IDX_LOOP_f1_or_84_nl, IDX_LOOP_f1_or_85_nl, STD_LOGIC_VECTOR'( and_dcpl_571
      & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f2_IDX_LOOP_f2_and_224_nl <= (IDX_LOOP_idx2_9_0_2_sva(0)) AND IDX_LOOP_f2_nor_12_cse_1
      AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f2_IDX_LOOP_f2_and_225_nl <= (IDX_LOOP_idx2_9_0_4_sva(0)) AND IDX_LOOP_f2_nor_36_cse_1
      AND IDX_LOOP_f1_equal_tmp_3;
  IDX_LOOP_f2_IDX_LOOP_f2_and_226_nl <= (IDX_LOOP_idx2_9_0_6_sva(0)) AND IDX_LOOP_f2_nor_60_cse_1
      AND IDX_LOOP_f1_equal_tmp_2;
  IDX_LOOP_f2_IDX_LOOP_f2_and_227_nl <= (IDX_LOOP_idx2_9_0_sva(0)) AND IDX_LOOP_f2_nor_84_cse_1
      AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_mux1h_210_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_224_nl,
      IDX_LOOP_f2_IDX_LOOP_f2_and_225_nl, IDX_LOOP_f2_IDX_LOOP_f2_and_226_nl, IDX_LOOP_f2_IDX_LOOP_f2_and_227_nl,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_or_86_nl <= ((IDX_LOOP_idx2_9_0_2_sva(1)) AND IDX_LOOP_f2_nor_13_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_9_0_2_sva(1)) AND IDX_LOOP_f2_nor_13_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_9_0_2_sva(1)) AND IDX_LOOP_f2_nor_13_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_9_0_2_sva(1)) AND IDX_LOOP_f2_nor_13_cse_1
      AND IDX_LOOP_f1_equal_tmp_3);
  IDX_LOOP_f1_or_87_nl <= ((IDX_LOOP_idx2_9_0_4_sva(1)) AND IDX_LOOP_f2_nor_37_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_9_0_4_sva(1)) AND IDX_LOOP_f2_nor_37_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_9_0_4_sva(1)) AND IDX_LOOP_f2_nor_37_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_9_0_4_sva(1)) AND IDX_LOOP_f2_nor_37_cse_1
      AND IDX_LOOP_f1_equal_tmp_2);
  IDX_LOOP_f1_or_88_nl <= ((IDX_LOOP_idx2_9_0_6_sva(1)) AND IDX_LOOP_f2_nor_61_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_9_0_6_sva(1)) AND IDX_LOOP_f2_nor_61_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_9_0_6_sva(1)) AND IDX_LOOP_f2_nor_61_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_9_0_6_sva(1)) AND IDX_LOOP_f2_nor_61_cse_1
      AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_89_nl <= ((IDX_LOOP_idx2_9_0_sva(1)) AND IDX_LOOP_f2_nor_85_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_9_0_sva(1)) AND IDX_LOOP_f2_nor_85_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_9_0_sva(1)) AND IDX_LOOP_f2_nor_85_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_9_0_sva(1)) AND IDX_LOOP_f2_nor_85_cse_1
      AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_mux1h_211_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_or_86_nl, IDX_LOOP_f1_or_87_nl,
      IDX_LOOP_f1_or_88_nl, IDX_LOOP_f1_or_89_nl, STD_LOGIC_VECTOR'( and_dcpl_571
      & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_212_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_30_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_86_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_142_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_198_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_or_90_nl <= ((IDX_LOOP_idx2_9_0_2_sva(2)) AND IDX_LOOP_f2_nor_14_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_9_0_2_sva(2)) AND IDX_LOOP_f2_nor_14_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_9_0_2_sva(2)) AND IDX_LOOP_f2_nor_14_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_9_0_2_sva(2)) AND IDX_LOOP_f2_nor_14_cse_1
      AND IDX_LOOP_f1_equal_tmp_3);
  IDX_LOOP_f1_or_91_nl <= ((IDX_LOOP_idx2_9_0_4_sva(2)) AND IDX_LOOP_f2_nor_38_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_9_0_4_sva(2)) AND IDX_LOOP_f2_nor_38_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_9_0_4_sva(2)) AND IDX_LOOP_f2_nor_38_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_9_0_4_sva(2)) AND IDX_LOOP_f2_nor_38_cse_1
      AND IDX_LOOP_f1_equal_tmp_2);
  IDX_LOOP_f1_or_92_nl <= ((IDX_LOOP_idx2_9_0_6_sva(2)) AND IDX_LOOP_f2_nor_62_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_9_0_6_sva(2)) AND IDX_LOOP_f2_nor_62_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_9_0_6_sva(2)) AND IDX_LOOP_f2_nor_62_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_9_0_6_sva(2)) AND IDX_LOOP_f2_nor_62_cse_1
      AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_93_nl <= ((IDX_LOOP_idx2_9_0_sva(2)) AND IDX_LOOP_f2_nor_86_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_9_0_sva(2)) AND IDX_LOOP_f2_nor_86_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_9_0_sva(2)) AND IDX_LOOP_f2_nor_86_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_9_0_sva(2)) AND IDX_LOOP_f2_nor_86_cse_1
      AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_mux1h_213_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_or_90_nl, IDX_LOOP_f1_or_91_nl,
      IDX_LOOP_f1_or_92_nl, IDX_LOOP_f1_or_93_nl, STD_LOGIC_VECTOR'( and_dcpl_571
      & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_214_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_32_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_88_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_144_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_200_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_or_94_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_33_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_40_itm
      OR IDX_LOOP_f2_IDX_LOOP_f2_and_47_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_54_itm;
  IDX_LOOP_f1_or_95_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_89_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_96_itm
      OR IDX_LOOP_f2_IDX_LOOP_f2_and_103_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_110_itm;
  IDX_LOOP_f1_or_96_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_145_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_152_itm
      OR IDX_LOOP_f2_IDX_LOOP_f2_and_159_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_166_itm;
  IDX_LOOP_f1_or_97_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_201_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_208_itm
      OR IDX_LOOP_IDX_LOOP_and_104_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_222_itm;
  IDX_LOOP_f1_mux1h_215_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_or_94_nl, IDX_LOOP_f1_or_95_nl,
      IDX_LOOP_f1_or_96_nl, IDX_LOOP_f1_or_97_nl, STD_LOGIC_VECTOR'( and_dcpl_571
      & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_216_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_34_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_90_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_146_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_202_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f2_IDX_LOOP_f2_and_260_nl <= (IDX_LOOP_idx2_9_0_2_sva(0)) AND IDX_LOOP_f2_nor_12_cse_1
      AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f2_IDX_LOOP_f2_and_261_nl <= (IDX_LOOP_idx2_9_0_4_sva(0)) AND IDX_LOOP_f2_nor_36_cse_1
      AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f2_IDX_LOOP_f2_and_262_nl <= (IDX_LOOP_idx2_9_0_6_sva(0)) AND IDX_LOOP_f2_nor_60_cse_1
      AND IDX_LOOP_f1_equal_tmp_3;
  IDX_LOOP_f2_IDX_LOOP_f2_and_263_nl <= (IDX_LOOP_idx2_9_0_sva(0)) AND IDX_LOOP_f2_nor_84_cse_1
      AND IDX_LOOP_f1_equal_tmp_2;
  IDX_LOOP_f1_mux1h_217_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_260_nl,
      IDX_LOOP_f2_IDX_LOOP_f2_and_261_nl, IDX_LOOP_f2_IDX_LOOP_f2_and_262_nl, IDX_LOOP_f2_IDX_LOOP_f2_and_263_nl,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_218_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_37_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_93_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_149_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_205_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_219_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_39_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_95_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_151_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_207_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_or_98_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_41_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_48_itm;
  IDX_LOOP_f1_or_99_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_97_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_104_itm;
  IDX_LOOP_f1_or_100_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_153_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_160_itm;
  IDX_LOOP_f1_or_101_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_209_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_216_itm;
  IDX_LOOP_f1_mux1h_220_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_or_98_nl, IDX_LOOP_f1_or_99_nl,
      IDX_LOOP_f1_or_100_nl, IDX_LOOP_f1_or_101_nl, STD_LOGIC_VECTOR'( and_dcpl_571
      & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_or_102_nl <= ((IDX_LOOP_idx2_9_0_2_sva(0)) AND IDX_LOOP_f2_nor_12_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_9_0_2_sva(0)) AND IDX_LOOP_f2_nor_12_cse_1
      AND IDX_LOOP_f1_equal_tmp_3);
  IDX_LOOP_f1_or_103_nl <= ((IDX_LOOP_idx2_9_0_4_sva(0)) AND IDX_LOOP_f2_nor_36_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_9_0_4_sva(0)) AND IDX_LOOP_f2_nor_36_cse_1
      AND IDX_LOOP_f1_equal_tmp_2);
  IDX_LOOP_f1_or_104_nl <= ((IDX_LOOP_idx2_9_0_6_sva(0)) AND IDX_LOOP_f2_nor_60_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_9_0_6_sva(0)) AND IDX_LOOP_f2_nor_60_cse_1
      AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_105_nl <= ((IDX_LOOP_idx2_9_0_sva(0)) AND IDX_LOOP_f2_nor_84_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_9_0_sva(0)) AND IDX_LOOP_f2_nor_84_cse_1
      AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_mux1h_221_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_or_102_nl, IDX_LOOP_f1_or_103_nl,
      IDX_LOOP_f1_or_104_nl, IDX_LOOP_f1_or_105_nl, STD_LOGIC_VECTOR'( and_dcpl_571
      & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_or_106_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_44_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_51_itm;
  IDX_LOOP_f1_or_107_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_100_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_107_itm;
  IDX_LOOP_f1_or_108_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_156_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_163_itm;
  IDX_LOOP_f1_or_109_nl <= IDX_LOOP_f2_IDX_LOOP_f2_and_212_itm OR IDX_LOOP_f2_IDX_LOOP_f2_and_219_itm;
  IDX_LOOP_f1_mux1h_222_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f1_or_106_nl, IDX_LOOP_f1_or_107_nl,
      IDX_LOOP_f1_or_108_nl, IDX_LOOP_f1_or_109_nl, STD_LOGIC_VECTOR'( and_dcpl_571
      & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_223_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_46_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_102_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_158_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_214_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_224_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_53_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_109_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_165_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_221_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  IDX_LOOP_f1_mux1h_225_nl <= MUX1HOT_s_1_4_2(IDX_LOOP_f2_IDX_LOOP_f2_and_55_itm,
      IDX_LOOP_f2_IDX_LOOP_f2_and_111_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_167_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_223_itm,
      STD_LOGIC_VECTOR'( and_dcpl_571 & and_dcpl_574 & and_dcpl_577 & and_dcpl_579));
  z_out_7 <= MUX1HOT_v_64_17_2(vec_rsc_0_0_i_q_d, vec_rsc_0_1_i_q_d, vec_rsc_0_2_i_q_d,
      tmp_11_sva_3, vec_rsc_0_4_i_q_d, tmp_11_sva_5, vec_rsc_0_6_i_q_d, tmp_11_sva_7,
      tmp_11_sva_9, vec_rsc_0_3_i_q_d, IDX_LOOP_modulo_dev_return_1_sva, reg_cse,
      reg_1_cse, reg_2_cse, vec_rsc_0_5_i_q_d, tmp_11_sva_29, vec_rsc_0_7_i_q_d,
      STD_LOGIC_VECTOR'( IDX_LOOP_f1_mux1h_209_nl & IDX_LOOP_f1_mux1h_210_nl & IDX_LOOP_f1_mux1h_211_nl
      & IDX_LOOP_f1_mux1h_212_nl & IDX_LOOP_f1_mux1h_213_nl & IDX_LOOP_f1_mux1h_214_nl
      & IDX_LOOP_f1_mux1h_215_nl & IDX_LOOP_f1_mux1h_216_nl & IDX_LOOP_f1_mux1h_217_nl
      & IDX_LOOP_f1_mux1h_218_nl & IDX_LOOP_f1_mux1h_219_nl & IDX_LOOP_f1_mux1h_220_nl
      & IDX_LOOP_f1_mux1h_221_nl & IDX_LOOP_f1_mux1h_222_nl & IDX_LOOP_f1_mux1h_223_nl
      & IDX_LOOP_f1_mux1h_224_nl & IDX_LOOP_f1_mux1h_225_nl));
  IDX_LOOP_f1_and_160_nl <= IDX_LOOP_f2_IDX_LOOP_f2_nor_8_itm AND IDX_LOOP_f1_equal_tmp_3;
  IDX_LOOP_f1_and_161_nl <= IDX_LOOP_f2_IDX_LOOP_f2_nor_16_itm AND IDX_LOOP_f1_equal_tmp_2;
  IDX_LOOP_f1_and_162_nl <= IDX_LOOP_f2_IDX_LOOP_f2_nor_24_itm AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_mux1h_226_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_and_160_nl, IDX_LOOP_f1_and_161_nl,
      IDX_LOOP_f1_and_162_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_110_nl <= ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_24_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_24_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_24_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_24_cse_1
      AND IDX_LOOP_f1_equal_tmp_2);
  IDX_LOOP_f1_or_111_nl <= ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_48_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_48_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_48_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_48_cse_1
      AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_112_nl <= ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_72_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_72_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_72_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((STAGE_LOOP_op_rshift_psp_1_sva(0)) AND IDX_LOOP_f2_nor_72_cse_1
      AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_mux1h_227_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_110_nl, IDX_LOOP_f1_or_111_nl,
      IDX_LOOP_f1_or_112_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_113_nl <= ((IDX_LOOP_idx2_acc_1_psp_sva(0)) AND IDX_LOOP_f2_nor_25_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_acc_1_psp_sva(1)) AND IDX_LOOP_f2_nor_26_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_acc_1_psp_sva(1)) AND IDX_LOOP_f2_nor_26_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_acc_1_psp_sva(0)) AND IDX_LOOP_f2_nor_25_cse_1
      AND IDX_LOOP_f1_equal_tmp_2);
  IDX_LOOP_f1_or_114_nl <= ((IDX_LOOP_idx2_acc_2_psp_sva(0)) AND IDX_LOOP_f2_nor_49_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_acc_2_psp_sva(1)) AND IDX_LOOP_f2_nor_50_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_acc_2_psp_sva(1)) AND IDX_LOOP_f2_nor_50_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_acc_2_psp_sva(0)) AND IDX_LOOP_f2_nor_49_cse_1
      AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_115_nl <= ((IDX_LOOP_idx2_acc_3_psp_sva(0)) AND IDX_LOOP_f2_nor_73_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_acc_3_psp_sva(1)) AND IDX_LOOP_f2_nor_74_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_acc_3_psp_sva(1)) AND IDX_LOOP_f2_nor_74_cse_1
      AND IDX_LOOP_f1_equal_tmp_1) OR ((IDX_LOOP_idx2_acc_3_psp_sva(0)) AND IDX_LOOP_f2_nor_73_cse_1
      AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_mux1h_228_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_113_nl, IDX_LOOP_f1_or_114_nl,
      IDX_LOOP_f1_or_115_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_116_nl <= IDX_LOOP_f1_and_39_itm OR IDX_LOOP_f1_and_47_itm OR IDX_LOOP_f1_and_55_itm
      OR IDX_LOOP_f1_and_63_itm;
  IDX_LOOP_f1_or_117_nl <= IDX_LOOP_f1_and_75_itm OR IDX_LOOP_f1_and_83_itm OR IDX_LOOP_f1_and_91_itm
      OR IDX_LOOP_f1_and_99_itm;
  IDX_LOOP_f1_or_118_nl <= IDX_LOOP_f1_and_111_itm OR IDX_LOOP_f1_and_119_itm OR
      IDX_LOOP_f1_and_127_itm OR IDX_LOOP_f1_and_135_itm;
  IDX_LOOP_f1_mux1h_229_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_116_nl, IDX_LOOP_f1_or_117_nl,
      IDX_LOOP_f1_or_118_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_119_nl <= IDX_LOOP_f1_and_41_itm OR IDX_LOOP_f1_and_49_itm OR IDX_LOOP_f1_and_57_itm
      OR IDX_LOOP_f1_and_65_itm;
  IDX_LOOP_f1_or_120_nl <= IDX_LOOP_f1_and_77_itm OR IDX_LOOP_f1_and_85_itm OR IDX_LOOP_f1_and_93_itm
      OR IDX_LOOP_f1_and_101_itm;
  IDX_LOOP_f1_or_121_nl <= IDX_LOOP_f1_and_113_itm OR IDX_LOOP_f1_and_121_itm OR
      IDX_LOOP_f1_and_129_itm OR IDX_LOOP_f1_and_137_itm;
  IDX_LOOP_f1_mux1h_230_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_119_nl, IDX_LOOP_f1_or_120_nl,
      IDX_LOOP_f1_or_121_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_mux1h_231_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_and_42_itm, IDX_LOOP_f1_and_78_itm,
      IDX_LOOP_f1_and_114_itm, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_122_nl <= IDX_LOOP_f1_and_43_itm OR IDX_LOOP_f1_and_51_itm OR IDX_LOOP_f1_and_59_itm
      OR IDX_LOOP_f1_and_67_itm;
  IDX_LOOP_f1_or_123_nl <= IDX_LOOP_f1_and_79_itm OR IDX_LOOP_f1_and_87_itm OR IDX_LOOP_f1_and_95_itm
      OR IDX_LOOP_f1_and_103_itm;
  IDX_LOOP_f1_or_124_nl <= IDX_LOOP_f1_and_115_itm OR IDX_LOOP_f1_and_123_itm OR
      IDX_LOOP_f1_and_131_itm OR IDX_LOOP_f1_and_139_itm;
  IDX_LOOP_f1_mux1h_232_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_122_nl, IDX_LOOP_f1_or_123_nl,
      IDX_LOOP_f1_or_124_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_and_187_nl <= IDX_LOOP_f2_IDX_LOOP_f2_nor_8_itm AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f1_and_188_nl <= IDX_LOOP_f2_IDX_LOOP_f2_nor_16_itm AND IDX_LOOP_f1_equal_tmp_3;
  IDX_LOOP_f1_and_189_nl <= IDX_LOOP_f2_IDX_LOOP_f2_nor_24_itm AND IDX_LOOP_f1_equal_tmp_2;
  IDX_LOOP_f1_mux1h_233_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_and_187_nl, IDX_LOOP_f1_and_188_nl,
      IDX_LOOP_f1_and_189_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_and_190_nl <= (IDX_LOOP_idx2_acc_1_psp_sva(0)) AND IDX_LOOP_f2_nor_25_cse_1
      AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f1_and_191_nl <= (IDX_LOOP_idx2_acc_2_psp_sva(0)) AND IDX_LOOP_f2_nor_49_cse_1
      AND IDX_LOOP_f1_equal_tmp_3;
  IDX_LOOP_f1_and_192_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(0)) AND IDX_LOOP_f2_nor_73_cse_1
      AND IDX_LOOP_f1_equal_tmp_2;
  IDX_LOOP_f1_mux1h_234_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_and_190_nl, IDX_LOOP_f1_and_191_nl,
      IDX_LOOP_f1_and_192_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_125_nl <= ((IDX_LOOP_idx2_acc_1_psp_sva(1)) AND IDX_LOOP_f2_nor_26_cse_1
      AND IDX_LOOP_f1_equal_tmp) OR ((IDX_LOOP_idx2_acc_1_psp_sva(0)) AND IDX_LOOP_f2_nor_25_cse_1
      AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_126_nl <= ((IDX_LOOP_idx2_acc_2_psp_sva(1)) AND IDX_LOOP_f2_nor_50_cse_1
      AND IDX_LOOP_f1_equal_tmp_3) OR ((IDX_LOOP_idx2_acc_2_psp_sva(0)) AND IDX_LOOP_f2_nor_49_cse_1
      AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_or_127_nl <= ((IDX_LOOP_idx2_acc_3_psp_sva(1)) AND IDX_LOOP_f2_nor_74_cse_1
      AND IDX_LOOP_f1_equal_tmp_2) OR ((IDX_LOOP_idx2_acc_3_psp_sva(0)) AND IDX_LOOP_f2_nor_73_cse_1
      AND IDX_LOOP_f1_equal_tmp_3);
  IDX_LOOP_f1_mux1h_235_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_125_nl, IDX_LOOP_f1_or_126_nl,
      IDX_LOOP_f1_or_127_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_128_nl <= IDX_LOOP_f1_and_50_itm OR IDX_LOOP_f1_and_58_itm;
  IDX_LOOP_f1_or_129_nl <= IDX_LOOP_f1_and_86_itm OR IDX_LOOP_f1_and_94_itm;
  IDX_LOOP_f1_or_130_nl <= IDX_LOOP_f1_and_122_itm OR IDX_LOOP_f1_and_130_itm;
  IDX_LOOP_f1_mux1h_236_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_128_nl, IDX_LOOP_f1_or_129_nl,
      IDX_LOOP_f1_or_130_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_or_131_nl <= (IDX_LOOP_f2_IDX_LOOP_f2_nor_8_itm AND IDX_LOOP_f1_equal_tmp_1)
      OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_8_itm AND IDX_LOOP_f1_equal_tmp_2);
  IDX_LOOP_f1_or_132_nl <= (IDX_LOOP_f2_IDX_LOOP_f2_nor_16_itm AND IDX_LOOP_f1_equal_tmp)
      OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_16_itm AND IDX_LOOP_f1_equal_tmp_1);
  IDX_LOOP_f1_or_133_nl <= (IDX_LOOP_f2_IDX_LOOP_f2_nor_24_itm AND IDX_LOOP_f1_equal_tmp_3)
      OR (IDX_LOOP_f2_IDX_LOOP_f2_nor_24_itm AND IDX_LOOP_f1_equal_tmp);
  IDX_LOOP_f1_mux1h_237_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_131_nl, IDX_LOOP_f1_or_132_nl,
      IDX_LOOP_f1_or_133_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_and_205_nl <= (IDX_LOOP_idx2_acc_1_psp_sva(1)) AND IDX_LOOP_f2_nor_26_cse_1
      AND IDX_LOOP_f1_equal_tmp_1;
  IDX_LOOP_f1_and_206_nl <= (IDX_LOOP_idx2_acc_2_psp_sva(1)) AND IDX_LOOP_f2_nor_50_cse_1
      AND IDX_LOOP_f1_equal_tmp;
  IDX_LOOP_f1_and_207_nl <= (IDX_LOOP_idx2_acc_3_psp_sva(1)) AND IDX_LOOP_f2_nor_74_cse_1
      AND IDX_LOOP_f1_equal_tmp_3;
  IDX_LOOP_f1_mux1h_238_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_and_205_nl, IDX_LOOP_f1_and_206_nl,
      IDX_LOOP_f1_and_207_nl, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  IDX_LOOP_f1_mux1h_239_nl <= MUX1HOT_s_1_3_2(IDX_LOOP_f1_and_66_itm, IDX_LOOP_f1_and_102_itm,
      IDX_LOOP_f1_and_138_itm, STD_LOGIC_VECTOR'( and_dcpl_587 & and_dcpl_591 & and_dcpl_593));
  z_out_8 <= MUX1HOT_v_64_14_2(vec_rsc_0_0_i_q_d, vec_rsc_0_1_i_q_d, reg_2_cse, vec_rsc_0_3_i_q_d,
      vec_rsc_0_5_i_q_d, tmp_11_sva_29, vec_rsc_0_7_i_q_d, tmp_11_sva_3, vec_rsc_0_2_i_q_d,
      IDX_LOOP_modulo_dev_return_1_sva, reg_cse, reg_1_cse, vec_rsc_0_4_i_q_d, vec_rsc_0_6_i_q_d,
      STD_LOGIC_VECTOR'( IDX_LOOP_f1_mux1h_226_nl & IDX_LOOP_f1_mux1h_227_nl & IDX_LOOP_f1_mux1h_228_nl
      & IDX_LOOP_f1_mux1h_229_nl & IDX_LOOP_f1_mux1h_230_nl & IDX_LOOP_f1_mux1h_231_nl
      & IDX_LOOP_f1_mux1h_232_nl & IDX_LOOP_f1_mux1h_233_nl & IDX_LOOP_f1_mux1h_234_nl
      & IDX_LOOP_f1_mux1h_235_nl & IDX_LOOP_f1_mux1h_236_nl & IDX_LOOP_f1_mux1h_237_nl
      & IDX_LOOP_f1_mux1h_238_nl & IDX_LOOP_f1_mux1h_239_nl));
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    DIT_RELOOP
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY DIT_RELOOP IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_0_0_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_0_re : OUT STD_LOGIC;
    vec_rsc_0_0_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_0_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_0_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    vec_rsc_0_1_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_1_re : OUT STD_LOGIC;
    vec_rsc_0_1_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_1_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_1_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    vec_rsc_0_2_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_2_re : OUT STD_LOGIC;
    vec_rsc_0_2_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_2_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_2_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_2_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_2_lz : OUT STD_LOGIC;
    vec_rsc_0_3_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_3_re : OUT STD_LOGIC;
    vec_rsc_0_3_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_3_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_3_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_3_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_3_lz : OUT STD_LOGIC;
    vec_rsc_0_4_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_4_re : OUT STD_LOGIC;
    vec_rsc_0_4_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_4_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_4_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_4_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_4_lz : OUT STD_LOGIC;
    vec_rsc_0_5_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_5_re : OUT STD_LOGIC;
    vec_rsc_0_5_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_5_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_5_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_5_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_5_lz : OUT STD_LOGIC;
    vec_rsc_0_6_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_6_re : OUT STD_LOGIC;
    vec_rsc_0_6_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_6_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_6_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_6_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_6_lz : OUT STD_LOGIC;
    vec_rsc_0_7_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_7_re : OUT STD_LOGIC;
    vec_rsc_0_7_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_7_wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    vec_rsc_0_7_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_0_7_we : OUT STD_LOGIC;
    vec_rsc_triosy_0_7_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC;
    twiddle_rsc_0_0_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_0_re : OUT STD_LOGIC;
    twiddle_rsc_0_0_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
    twiddle_rsc_0_1_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_1_re : OUT STD_LOGIC;
    twiddle_rsc_0_1_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC;
    twiddle_rsc_0_2_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_2_re : OUT STD_LOGIC;
    twiddle_rsc_0_2_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_2_lz : OUT STD_LOGIC;
    twiddle_rsc_0_3_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_3_re : OUT STD_LOGIC;
    twiddle_rsc_0_3_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_3_lz : OUT STD_LOGIC;
    twiddle_rsc_0_4_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_4_re : OUT STD_LOGIC;
    twiddle_rsc_0_4_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_4_lz : OUT STD_LOGIC;
    twiddle_rsc_0_5_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_5_re : OUT STD_LOGIC;
    twiddle_rsc_0_5_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_5_lz : OUT STD_LOGIC;
    twiddle_rsc_0_6_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_6_re : OUT STD_LOGIC;
    twiddle_rsc_0_6_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_6_lz : OUT STD_LOGIC;
    twiddle_rsc_0_7_radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    twiddle_rsc_0_7_re : OUT STD_LOGIC;
    twiddle_rsc_0_7_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_0_7_lz : OUT STD_LOGIC
  );
END DIT_RELOOP;

ARCHITECTURE v8 OF DIT_RELOOP IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL vec_rsc_0_0_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_2_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_3_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_4_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_5_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_6_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_7_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_wadr_d_iff : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_d_d_iff : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_0_i_re_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_wadr_d_iff : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_d_d_iff : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_1_i_re_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_2_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_2_i_re_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_3_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_3_i_re_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_4_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_4_i_re_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_5_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_5_i_re_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_6_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_6_i_re_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_7_i_we_d_iff : STD_LOGIC;
  SIGNAL vec_rsc_0_7_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_0_i_radr_d_iff : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_1_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_2_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_3_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_4_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_5_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_6_i_re_d_iff : STD_LOGIC;
  SIGNAL twiddle_rsc_0_7_i_re_d_iff : STD_LOGIC;

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_0_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_0_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_1_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_1_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_2_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_2_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_3_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_3_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_13_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_4_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_4_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_14_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_5_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_5_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_15_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_6_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_6_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_16_64_7_128_128_64_5_gen
    PORT(
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      we_d : IN STD_LOGIC;
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      port_1_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsc_0_7_i_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_wadr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_radr_d_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_wadr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsc_0_7_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_17_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_0_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_0_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_18_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_1_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_1_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_19_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_2_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_2_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_2_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_2_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_20_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_3_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_3_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_3_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_3_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_21_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_4_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_4_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_4_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_4_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_22_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_5_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_5_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_5_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_5_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_23_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_6_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_6_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_6_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_6_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_24_64_7_128_128_64_5_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      re_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      port_0_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsc_0_7_i_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsc_0_7_i_radr : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_7_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL twiddle_rsc_0_7_i_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT DIT_RELOOP_core
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
      r_rsc_triosy_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_0_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_1_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_2_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_3_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_4_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_5_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_6_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_0_7_lz : OUT STD_LOGIC;
      vec_rsc_0_0_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_0_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_1_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_2_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_2_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_3_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_3_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_4_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_4_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_5_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_5_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_6_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_6_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_7_i_radr_d : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_7_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_0_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_1_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_2_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_3_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_4_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_5_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_6_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsc_0_7_i_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_wadr_d_pff : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_0_i_d_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_0_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_0_i_re_d_pff : OUT STD_LOGIC;
      vec_rsc_0_1_i_wadr_d_pff : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      vec_rsc_0_1_i_d_d_pff : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsc_0_1_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_1_i_re_d_pff : OUT STD_LOGIC;
      vec_rsc_0_2_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_2_i_re_d_pff : OUT STD_LOGIC;
      vec_rsc_0_3_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_3_i_re_d_pff : OUT STD_LOGIC;
      vec_rsc_0_4_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_4_i_re_d_pff : OUT STD_LOGIC;
      vec_rsc_0_5_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_5_i_re_d_pff : OUT STD_LOGIC;
      vec_rsc_0_6_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_6_i_re_d_pff : OUT STD_LOGIC;
      vec_rsc_0_7_i_we_d_pff : OUT STD_LOGIC;
      vec_rsc_0_7_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_0_i_radr_d_pff : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      twiddle_rsc_0_0_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_1_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_2_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_3_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_4_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_5_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_6_i_re_d_pff : OUT STD_LOGIC;
      twiddle_rsc_0_7_i_re_d_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL DIT_RELOOP_core_inst_p_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_0_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_0_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_1_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_1_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_2_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_2_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_3_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_3_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_4_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_4_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_5_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_5_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_6_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_6_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_7_i_radr_d : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_7_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_0_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_1_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_2_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_3_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_4_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_5_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_6_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_7_i_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_0_i_wadr_d_pff : STD_LOGIC_VECTOR (6 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_0_i_d_d_pff : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_1_i_wadr_d_pff : STD_LOGIC_VECTOR (6 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_vec_rsc_0_1_i_d_d_pff : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL DIT_RELOOP_core_inst_twiddle_rsc_0_0_i_radr_d_pff : STD_LOGIC_VECTOR (6
      DOWNTO 0);

BEGIN
  vec_rsc_0_0_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_0_we,
      d => vec_rsc_0_0_i_d,
      wadr => vec_rsc_0_0_i_wadr,
      q => vec_rsc_0_0_i_q,
      re => vec_rsc_0_0_re,
      radr => vec_rsc_0_0_i_radr,
      radr_d => vec_rsc_0_0_i_radr_d_1,
      wadr_d => vec_rsc_0_0_i_wadr_d,
      d_d => vec_rsc_0_0_i_d_d,
      we_d => vec_rsc_0_0_i_we_d_iff,
      re_d => vec_rsc_0_0_i_re_d_iff,
      q_d => vec_rsc_0_0_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_0_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_0_i_we_d_iff
    );
  vec_rsc_0_0_d <= vec_rsc_0_0_i_d;
  vec_rsc_0_0_wadr <= vec_rsc_0_0_i_wadr;
  vec_rsc_0_0_i_q <= vec_rsc_0_0_q;
  vec_rsc_0_0_radr <= vec_rsc_0_0_i_radr;
  vec_rsc_0_0_i_radr_d_1 <= vec_rsc_0_0_i_radr_d;
  vec_rsc_0_0_i_wadr_d <= vec_rsc_0_0_i_wadr_d_iff;
  vec_rsc_0_0_i_d_d <= vec_rsc_0_0_i_d_d_iff;
  vec_rsc_0_0_i_q_d <= vec_rsc_0_0_i_q_d_1;

  vec_rsc_0_1_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_1_we,
      d => vec_rsc_0_1_i_d,
      wadr => vec_rsc_0_1_i_wadr,
      q => vec_rsc_0_1_i_q,
      re => vec_rsc_0_1_re,
      radr => vec_rsc_0_1_i_radr,
      radr_d => vec_rsc_0_1_i_radr_d_1,
      wadr_d => vec_rsc_0_1_i_wadr_d,
      d_d => vec_rsc_0_1_i_d_d,
      we_d => vec_rsc_0_1_i_we_d_iff,
      re_d => vec_rsc_0_1_i_re_d_iff,
      q_d => vec_rsc_0_1_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_1_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_1_i_we_d_iff
    );
  vec_rsc_0_1_d <= vec_rsc_0_1_i_d;
  vec_rsc_0_1_wadr <= vec_rsc_0_1_i_wadr;
  vec_rsc_0_1_i_q <= vec_rsc_0_1_q;
  vec_rsc_0_1_radr <= vec_rsc_0_1_i_radr;
  vec_rsc_0_1_i_radr_d_1 <= vec_rsc_0_1_i_radr_d;
  vec_rsc_0_1_i_wadr_d <= vec_rsc_0_1_i_wadr_d_iff;
  vec_rsc_0_1_i_d_d <= vec_rsc_0_1_i_d_d_iff;
  vec_rsc_0_1_i_q_d <= vec_rsc_0_1_i_q_d_1;

  vec_rsc_0_2_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_2_we,
      d => vec_rsc_0_2_i_d,
      wadr => vec_rsc_0_2_i_wadr,
      q => vec_rsc_0_2_i_q,
      re => vec_rsc_0_2_re,
      radr => vec_rsc_0_2_i_radr,
      radr_d => vec_rsc_0_2_i_radr_d_1,
      wadr_d => vec_rsc_0_2_i_wadr_d,
      d_d => vec_rsc_0_2_i_d_d,
      we_d => vec_rsc_0_2_i_we_d_iff,
      re_d => vec_rsc_0_2_i_re_d_iff,
      q_d => vec_rsc_0_2_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_2_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_2_i_we_d_iff
    );
  vec_rsc_0_2_d <= vec_rsc_0_2_i_d;
  vec_rsc_0_2_wadr <= vec_rsc_0_2_i_wadr;
  vec_rsc_0_2_i_q <= vec_rsc_0_2_q;
  vec_rsc_0_2_radr <= vec_rsc_0_2_i_radr;
  vec_rsc_0_2_i_radr_d_1 <= vec_rsc_0_2_i_radr_d;
  vec_rsc_0_2_i_wadr_d <= vec_rsc_0_0_i_wadr_d_iff;
  vec_rsc_0_2_i_d_d <= vec_rsc_0_0_i_d_d_iff;
  vec_rsc_0_2_i_q_d <= vec_rsc_0_2_i_q_d_1;

  vec_rsc_0_3_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_3_we,
      d => vec_rsc_0_3_i_d,
      wadr => vec_rsc_0_3_i_wadr,
      q => vec_rsc_0_3_i_q,
      re => vec_rsc_0_3_re,
      radr => vec_rsc_0_3_i_radr,
      radr_d => vec_rsc_0_3_i_radr_d_1,
      wadr_d => vec_rsc_0_3_i_wadr_d,
      d_d => vec_rsc_0_3_i_d_d,
      we_d => vec_rsc_0_3_i_we_d_iff,
      re_d => vec_rsc_0_3_i_re_d_iff,
      q_d => vec_rsc_0_3_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_3_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_3_i_we_d_iff
    );
  vec_rsc_0_3_d <= vec_rsc_0_3_i_d;
  vec_rsc_0_3_wadr <= vec_rsc_0_3_i_wadr;
  vec_rsc_0_3_i_q <= vec_rsc_0_3_q;
  vec_rsc_0_3_radr <= vec_rsc_0_3_i_radr;
  vec_rsc_0_3_i_radr_d_1 <= vec_rsc_0_3_i_radr_d;
  vec_rsc_0_3_i_wadr_d <= vec_rsc_0_1_i_wadr_d_iff;
  vec_rsc_0_3_i_d_d <= vec_rsc_0_1_i_d_d_iff;
  vec_rsc_0_3_i_q_d <= vec_rsc_0_3_i_q_d_1;

  vec_rsc_0_4_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_13_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_4_we,
      d => vec_rsc_0_4_i_d,
      wadr => vec_rsc_0_4_i_wadr,
      q => vec_rsc_0_4_i_q,
      re => vec_rsc_0_4_re,
      radr => vec_rsc_0_4_i_radr,
      radr_d => vec_rsc_0_4_i_radr_d_1,
      wadr_d => vec_rsc_0_4_i_wadr_d,
      d_d => vec_rsc_0_4_i_d_d,
      we_d => vec_rsc_0_4_i_we_d_iff,
      re_d => vec_rsc_0_4_i_re_d_iff,
      q_d => vec_rsc_0_4_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_4_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_4_i_we_d_iff
    );
  vec_rsc_0_4_d <= vec_rsc_0_4_i_d;
  vec_rsc_0_4_wadr <= vec_rsc_0_4_i_wadr;
  vec_rsc_0_4_i_q <= vec_rsc_0_4_q;
  vec_rsc_0_4_radr <= vec_rsc_0_4_i_radr;
  vec_rsc_0_4_i_radr_d_1 <= vec_rsc_0_4_i_radr_d;
  vec_rsc_0_4_i_wadr_d <= vec_rsc_0_0_i_wadr_d_iff;
  vec_rsc_0_4_i_d_d <= vec_rsc_0_0_i_d_d_iff;
  vec_rsc_0_4_i_q_d <= vec_rsc_0_4_i_q_d_1;

  vec_rsc_0_5_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_14_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_5_we,
      d => vec_rsc_0_5_i_d,
      wadr => vec_rsc_0_5_i_wadr,
      q => vec_rsc_0_5_i_q,
      re => vec_rsc_0_5_re,
      radr => vec_rsc_0_5_i_radr,
      radr_d => vec_rsc_0_5_i_radr_d_1,
      wadr_d => vec_rsc_0_5_i_wadr_d,
      d_d => vec_rsc_0_5_i_d_d,
      we_d => vec_rsc_0_5_i_we_d_iff,
      re_d => vec_rsc_0_5_i_re_d_iff,
      q_d => vec_rsc_0_5_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_5_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_5_i_we_d_iff
    );
  vec_rsc_0_5_d <= vec_rsc_0_5_i_d;
  vec_rsc_0_5_wadr <= vec_rsc_0_5_i_wadr;
  vec_rsc_0_5_i_q <= vec_rsc_0_5_q;
  vec_rsc_0_5_radr <= vec_rsc_0_5_i_radr;
  vec_rsc_0_5_i_radr_d_1 <= vec_rsc_0_5_i_radr_d;
  vec_rsc_0_5_i_wadr_d <= vec_rsc_0_1_i_wadr_d_iff;
  vec_rsc_0_5_i_d_d <= vec_rsc_0_1_i_d_d_iff;
  vec_rsc_0_5_i_q_d <= vec_rsc_0_5_i_q_d_1;

  vec_rsc_0_6_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_15_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_6_we,
      d => vec_rsc_0_6_i_d,
      wadr => vec_rsc_0_6_i_wadr,
      q => vec_rsc_0_6_i_q,
      re => vec_rsc_0_6_re,
      radr => vec_rsc_0_6_i_radr,
      radr_d => vec_rsc_0_6_i_radr_d_1,
      wadr_d => vec_rsc_0_6_i_wadr_d,
      d_d => vec_rsc_0_6_i_d_d,
      we_d => vec_rsc_0_6_i_we_d_iff,
      re_d => vec_rsc_0_6_i_re_d_iff,
      q_d => vec_rsc_0_6_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_6_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_6_i_we_d_iff
    );
  vec_rsc_0_6_d <= vec_rsc_0_6_i_d;
  vec_rsc_0_6_wadr <= vec_rsc_0_6_i_wadr;
  vec_rsc_0_6_i_q <= vec_rsc_0_6_q;
  vec_rsc_0_6_radr <= vec_rsc_0_6_i_radr;
  vec_rsc_0_6_i_radr_d_1 <= vec_rsc_0_6_i_radr_d;
  vec_rsc_0_6_i_wadr_d <= vec_rsc_0_0_i_wadr_d_iff;
  vec_rsc_0_6_i_d_d <= vec_rsc_0_0_i_d_d_iff;
  vec_rsc_0_6_i_q_d <= vec_rsc_0_6_i_q_d_1;

  vec_rsc_0_7_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_16_64_7_128_128_64_5_gen
    PORT MAP(
      we => vec_rsc_0_7_we,
      d => vec_rsc_0_7_i_d,
      wadr => vec_rsc_0_7_i_wadr,
      q => vec_rsc_0_7_i_q,
      re => vec_rsc_0_7_re,
      radr => vec_rsc_0_7_i_radr,
      radr_d => vec_rsc_0_7_i_radr_d_1,
      wadr_d => vec_rsc_0_7_i_wadr_d,
      d_d => vec_rsc_0_7_i_d_d,
      we_d => vec_rsc_0_7_i_we_d_iff,
      re_d => vec_rsc_0_7_i_re_d_iff,
      q_d => vec_rsc_0_7_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => vec_rsc_0_7_i_re_d_iff,
      port_1_w_ram_ir_internal_WMASK_B_d => vec_rsc_0_7_i_we_d_iff
    );
  vec_rsc_0_7_d <= vec_rsc_0_7_i_d;
  vec_rsc_0_7_wadr <= vec_rsc_0_7_i_wadr;
  vec_rsc_0_7_i_q <= vec_rsc_0_7_q;
  vec_rsc_0_7_radr <= vec_rsc_0_7_i_radr;
  vec_rsc_0_7_i_radr_d_1 <= vec_rsc_0_7_i_radr_d;
  vec_rsc_0_7_i_wadr_d <= vec_rsc_0_1_i_wadr_d_iff;
  vec_rsc_0_7_i_d_d <= vec_rsc_0_1_i_d_d_iff;
  vec_rsc_0_7_i_q_d <= vec_rsc_0_7_i_q_d_1;

  twiddle_rsc_0_0_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_17_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_0_i_q,
      re => twiddle_rsc_0_0_re,
      radr => twiddle_rsc_0_0_i_radr,
      radr_d => twiddle_rsc_0_0_i_radr_d,
      re_d => twiddle_rsc_0_0_i_re_d_iff,
      q_d => twiddle_rsc_0_0_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_0_i_re_d_iff
    );
  twiddle_rsc_0_0_i_q <= twiddle_rsc_0_0_q;
  twiddle_rsc_0_0_radr <= twiddle_rsc_0_0_i_radr;
  twiddle_rsc_0_0_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_0_i_q_d <= twiddle_rsc_0_0_i_q_d_1;

  twiddle_rsc_0_1_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_18_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_1_i_q,
      re => twiddle_rsc_0_1_re,
      radr => twiddle_rsc_0_1_i_radr,
      radr_d => twiddle_rsc_0_1_i_radr_d,
      re_d => twiddle_rsc_0_1_i_re_d_iff,
      q_d => twiddle_rsc_0_1_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_1_i_re_d_iff
    );
  twiddle_rsc_0_1_i_q <= twiddle_rsc_0_1_q;
  twiddle_rsc_0_1_radr <= twiddle_rsc_0_1_i_radr;
  twiddle_rsc_0_1_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_1_i_q_d <= twiddle_rsc_0_1_i_q_d_1;

  twiddle_rsc_0_2_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_19_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_2_i_q,
      re => twiddle_rsc_0_2_re,
      radr => twiddle_rsc_0_2_i_radr,
      radr_d => twiddle_rsc_0_2_i_radr_d,
      re_d => twiddle_rsc_0_2_i_re_d_iff,
      q_d => twiddle_rsc_0_2_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_2_i_re_d_iff
    );
  twiddle_rsc_0_2_i_q <= twiddle_rsc_0_2_q;
  twiddle_rsc_0_2_radr <= twiddle_rsc_0_2_i_radr;
  twiddle_rsc_0_2_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_2_i_q_d <= twiddle_rsc_0_2_i_q_d_1;

  twiddle_rsc_0_3_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_20_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_3_i_q,
      re => twiddle_rsc_0_3_re,
      radr => twiddle_rsc_0_3_i_radr,
      radr_d => twiddle_rsc_0_3_i_radr_d,
      re_d => twiddle_rsc_0_3_i_re_d_iff,
      q_d => twiddle_rsc_0_3_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_3_i_re_d_iff
    );
  twiddle_rsc_0_3_i_q <= twiddle_rsc_0_3_q;
  twiddle_rsc_0_3_radr <= twiddle_rsc_0_3_i_radr;
  twiddle_rsc_0_3_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_3_i_q_d <= twiddle_rsc_0_3_i_q_d_1;

  twiddle_rsc_0_4_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_21_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_4_i_q,
      re => twiddle_rsc_0_4_re,
      radr => twiddle_rsc_0_4_i_radr,
      radr_d => twiddle_rsc_0_4_i_radr_d,
      re_d => twiddle_rsc_0_4_i_re_d_iff,
      q_d => twiddle_rsc_0_4_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_4_i_re_d_iff
    );
  twiddle_rsc_0_4_i_q <= twiddle_rsc_0_4_q;
  twiddle_rsc_0_4_radr <= twiddle_rsc_0_4_i_radr;
  twiddle_rsc_0_4_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_4_i_q_d <= twiddle_rsc_0_4_i_q_d_1;

  twiddle_rsc_0_5_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_22_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_5_i_q,
      re => twiddle_rsc_0_5_re,
      radr => twiddle_rsc_0_5_i_radr,
      radr_d => twiddle_rsc_0_5_i_radr_d,
      re_d => twiddle_rsc_0_5_i_re_d_iff,
      q_d => twiddle_rsc_0_5_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_5_i_re_d_iff
    );
  twiddle_rsc_0_5_i_q <= twiddle_rsc_0_5_q;
  twiddle_rsc_0_5_radr <= twiddle_rsc_0_5_i_radr;
  twiddle_rsc_0_5_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_5_i_q_d <= twiddle_rsc_0_5_i_q_d_1;

  twiddle_rsc_0_6_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_23_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_6_i_q,
      re => twiddle_rsc_0_6_re,
      radr => twiddle_rsc_0_6_i_radr,
      radr_d => twiddle_rsc_0_6_i_radr_d,
      re_d => twiddle_rsc_0_6_i_re_d_iff,
      q_d => twiddle_rsc_0_6_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_6_i_re_d_iff
    );
  twiddle_rsc_0_6_i_q <= twiddle_rsc_0_6_q;
  twiddle_rsc_0_6_radr <= twiddle_rsc_0_6_i_radr;
  twiddle_rsc_0_6_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_6_i_q_d <= twiddle_rsc_0_6_i_q_d_1;

  twiddle_rsc_0_7_i : DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_24_64_7_128_128_64_5_gen
    PORT MAP(
      q => twiddle_rsc_0_7_i_q,
      re => twiddle_rsc_0_7_re,
      radr => twiddle_rsc_0_7_i_radr,
      radr_d => twiddle_rsc_0_7_i_radr_d,
      re_d => twiddle_rsc_0_7_i_re_d_iff,
      q_d => twiddle_rsc_0_7_i_q_d_1,
      port_0_r_ram_ir_internal_RMASK_B_d => twiddle_rsc_0_7_i_re_d_iff
    );
  twiddle_rsc_0_7_i_q <= twiddle_rsc_0_7_q;
  twiddle_rsc_0_7_radr <= twiddle_rsc_0_7_i_radr;
  twiddle_rsc_0_7_i_radr_d <= twiddle_rsc_0_0_i_radr_d_iff;
  twiddle_rsc_0_7_i_q_d <= twiddle_rsc_0_7_i_q_d_1;

  DIT_RELOOP_core_inst : DIT_RELOOP_core
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
      p_rsc_dat => DIT_RELOOP_core_inst_p_rsc_dat,
      p_rsc_triosy_lz => p_rsc_triosy_lz,
      r_rsc_triosy_lz => r_rsc_triosy_lz,
      twiddle_rsc_triosy_0_0_lz => twiddle_rsc_triosy_0_0_lz,
      twiddle_rsc_triosy_0_1_lz => twiddle_rsc_triosy_0_1_lz,
      twiddle_rsc_triosy_0_2_lz => twiddle_rsc_triosy_0_2_lz,
      twiddle_rsc_triosy_0_3_lz => twiddle_rsc_triosy_0_3_lz,
      twiddle_rsc_triosy_0_4_lz => twiddle_rsc_triosy_0_4_lz,
      twiddle_rsc_triosy_0_5_lz => twiddle_rsc_triosy_0_5_lz,
      twiddle_rsc_triosy_0_6_lz => twiddle_rsc_triosy_0_6_lz,
      twiddle_rsc_triosy_0_7_lz => twiddle_rsc_triosy_0_7_lz,
      vec_rsc_0_0_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_0_i_radr_d,
      vec_rsc_0_0_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_0_i_q_d,
      vec_rsc_0_1_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_1_i_radr_d,
      vec_rsc_0_1_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_1_i_q_d,
      vec_rsc_0_2_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_2_i_radr_d,
      vec_rsc_0_2_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_2_i_q_d,
      vec_rsc_0_3_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_3_i_radr_d,
      vec_rsc_0_3_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_3_i_q_d,
      vec_rsc_0_4_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_4_i_radr_d,
      vec_rsc_0_4_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_4_i_q_d,
      vec_rsc_0_5_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_5_i_radr_d,
      vec_rsc_0_5_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_5_i_q_d,
      vec_rsc_0_6_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_6_i_radr_d,
      vec_rsc_0_6_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_6_i_q_d,
      vec_rsc_0_7_i_radr_d => DIT_RELOOP_core_inst_vec_rsc_0_7_i_radr_d,
      vec_rsc_0_7_i_q_d => DIT_RELOOP_core_inst_vec_rsc_0_7_i_q_d,
      twiddle_rsc_0_0_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_0_i_q_d,
      twiddle_rsc_0_1_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_1_i_q_d,
      twiddle_rsc_0_2_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_2_i_q_d,
      twiddle_rsc_0_3_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_3_i_q_d,
      twiddle_rsc_0_4_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_4_i_q_d,
      twiddle_rsc_0_5_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_5_i_q_d,
      twiddle_rsc_0_6_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_6_i_q_d,
      twiddle_rsc_0_7_i_q_d => DIT_RELOOP_core_inst_twiddle_rsc_0_7_i_q_d,
      vec_rsc_0_0_i_wadr_d_pff => DIT_RELOOP_core_inst_vec_rsc_0_0_i_wadr_d_pff,
      vec_rsc_0_0_i_d_d_pff => DIT_RELOOP_core_inst_vec_rsc_0_0_i_d_d_pff,
      vec_rsc_0_0_i_we_d_pff => vec_rsc_0_0_i_we_d_iff,
      vec_rsc_0_0_i_re_d_pff => vec_rsc_0_0_i_re_d_iff,
      vec_rsc_0_1_i_wadr_d_pff => DIT_RELOOP_core_inst_vec_rsc_0_1_i_wadr_d_pff,
      vec_rsc_0_1_i_d_d_pff => DIT_RELOOP_core_inst_vec_rsc_0_1_i_d_d_pff,
      vec_rsc_0_1_i_we_d_pff => vec_rsc_0_1_i_we_d_iff,
      vec_rsc_0_1_i_re_d_pff => vec_rsc_0_1_i_re_d_iff,
      vec_rsc_0_2_i_we_d_pff => vec_rsc_0_2_i_we_d_iff,
      vec_rsc_0_2_i_re_d_pff => vec_rsc_0_2_i_re_d_iff,
      vec_rsc_0_3_i_we_d_pff => vec_rsc_0_3_i_we_d_iff,
      vec_rsc_0_3_i_re_d_pff => vec_rsc_0_3_i_re_d_iff,
      vec_rsc_0_4_i_we_d_pff => vec_rsc_0_4_i_we_d_iff,
      vec_rsc_0_4_i_re_d_pff => vec_rsc_0_4_i_re_d_iff,
      vec_rsc_0_5_i_we_d_pff => vec_rsc_0_5_i_we_d_iff,
      vec_rsc_0_5_i_re_d_pff => vec_rsc_0_5_i_re_d_iff,
      vec_rsc_0_6_i_we_d_pff => vec_rsc_0_6_i_we_d_iff,
      vec_rsc_0_6_i_re_d_pff => vec_rsc_0_6_i_re_d_iff,
      vec_rsc_0_7_i_we_d_pff => vec_rsc_0_7_i_we_d_iff,
      vec_rsc_0_7_i_re_d_pff => vec_rsc_0_7_i_re_d_iff,
      twiddle_rsc_0_0_i_radr_d_pff => DIT_RELOOP_core_inst_twiddle_rsc_0_0_i_radr_d_pff,
      twiddle_rsc_0_0_i_re_d_pff => twiddle_rsc_0_0_i_re_d_iff,
      twiddle_rsc_0_1_i_re_d_pff => twiddle_rsc_0_1_i_re_d_iff,
      twiddle_rsc_0_2_i_re_d_pff => twiddle_rsc_0_2_i_re_d_iff,
      twiddle_rsc_0_3_i_re_d_pff => twiddle_rsc_0_3_i_re_d_iff,
      twiddle_rsc_0_4_i_re_d_pff => twiddle_rsc_0_4_i_re_d_iff,
      twiddle_rsc_0_5_i_re_d_pff => twiddle_rsc_0_5_i_re_d_iff,
      twiddle_rsc_0_6_i_re_d_pff => twiddle_rsc_0_6_i_re_d_iff,
      twiddle_rsc_0_7_i_re_d_pff => twiddle_rsc_0_7_i_re_d_iff
    );
  DIT_RELOOP_core_inst_p_rsc_dat <= p_rsc_dat;
  vec_rsc_0_0_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_0_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_0_i_q_d <= vec_rsc_0_0_i_q_d;
  vec_rsc_0_1_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_1_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_1_i_q_d <= vec_rsc_0_1_i_q_d;
  vec_rsc_0_2_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_2_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_2_i_q_d <= vec_rsc_0_2_i_q_d;
  vec_rsc_0_3_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_3_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_3_i_q_d <= vec_rsc_0_3_i_q_d;
  vec_rsc_0_4_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_4_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_4_i_q_d <= vec_rsc_0_4_i_q_d;
  vec_rsc_0_5_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_5_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_5_i_q_d <= vec_rsc_0_5_i_q_d;
  vec_rsc_0_6_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_6_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_6_i_q_d <= vec_rsc_0_6_i_q_d;
  vec_rsc_0_7_i_radr_d <= DIT_RELOOP_core_inst_vec_rsc_0_7_i_radr_d;
  DIT_RELOOP_core_inst_vec_rsc_0_7_i_q_d <= vec_rsc_0_7_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_0_i_q_d <= twiddle_rsc_0_0_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_1_i_q_d <= twiddle_rsc_0_1_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_2_i_q_d <= twiddle_rsc_0_2_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_3_i_q_d <= twiddle_rsc_0_3_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_4_i_q_d <= twiddle_rsc_0_4_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_5_i_q_d <= twiddle_rsc_0_5_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_6_i_q_d <= twiddle_rsc_0_6_i_q_d;
  DIT_RELOOP_core_inst_twiddle_rsc_0_7_i_q_d <= twiddle_rsc_0_7_i_q_d;
  vec_rsc_0_0_i_wadr_d_iff <= DIT_RELOOP_core_inst_vec_rsc_0_0_i_wadr_d_pff;
  vec_rsc_0_0_i_d_d_iff <= DIT_RELOOP_core_inst_vec_rsc_0_0_i_d_d_pff;
  vec_rsc_0_1_i_wadr_d_iff <= DIT_RELOOP_core_inst_vec_rsc_0_1_i_wadr_d_pff;
  vec_rsc_0_1_i_d_d_iff <= DIT_RELOOP_core_inst_vec_rsc_0_1_i_d_d_pff;
  twiddle_rsc_0_0_i_radr_d_iff <= DIT_RELOOP_core_inst_twiddle_rsc_0_0_i_radr_d_pff;

END v8;



