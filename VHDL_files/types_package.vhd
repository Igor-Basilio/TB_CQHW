
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library ieee_proposed;
USE ieee_proposed.math_utility_pkg.all;
USE ieee_proposed.fixed_pkg.all;
USE ieee_proposed.float_pkg.all;

PACKAGE types_package IS

  type qcomplex is
  record              
    r : float32;
    i : float32;
  end record;

  type qreal is
  record
    r : real;
    i : real;
  end record;

  type matrix2_real is
  record
    c0 : qreal;
    c1 : qreal;
  end record;

  type qsulv is
  record
    r : std_ulogic_vector( 63 downto 0 );
    i : std_ulogic_vector( 63 downto 0 );
  end record;

  type matrix2_sulv is
  record
    c0 : qsulv;
    c1 : qsulv;
  end record;
  
  type matrix2 is 
  record
    c0: qcomplex;
    c1: qcomplex;
  end record;

  type matrix4 is
  record
    c0: qcomplex;
    c1: qcomplex;
    c2: qcomplex;
    c3: qcomplex;   
  end record;

  type matrix16 is array ( 0 to 15 ) of qcomplex ;

  type cx_return is
  record
    q: matrix2;
    e: matrix2;
  end record;
  
  type matrix2_array is array ( natural range <> ) of matrix2;
  type matrix4_array is array ( natural range <> ) of matrix4;
  
end types_package;
