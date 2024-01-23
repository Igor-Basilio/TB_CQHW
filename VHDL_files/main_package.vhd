
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library ieee_proposed;
USE ieee_proposed.math_utility_pkg.all;
USE ieee_proposed.fixed_pkg.all;
USE ieee_proposed.float_pkg.all;
LIBRARY work;
USE work.types_package.all;

-- * * * * * * * --
-- Main package * --
-- * * * * * * * --

PACKAGE main_package IS

  -- Matrix constant values for the gates  
  constant fasec_m : matrix4 := ((r => to_float(1), i => to_float(0)), 
                                 (r => to_float(0), i => to_float(0)), 
                                 (r => to_float(0), i => to_float(0)), 
                                 (r => to_float(0), i => to_float(1)));

  constant hadamard_m : matrix4 := ((r => to_float(1), i => to_float(0)), 
                                    (r => to_float(0), i => to_float(0)), 
                                    (r => to_float(0), i => to_float(0)), 
                                    (r => to_float(0), i => to_float(1)));
  
  constant xgate_m : matrix4 := ((r => to_float(0), i => to_float(0)), 
                                 (r => to_float(1), i => to_float(0)), 
                                 (r => to_float(1), i => to_float(0)), 
                                 (r => to_float(0), i => to_float(1)));
  
  constant identity_m : matrix4 := ((r => to_float(1), i => to_float(0)), 
                                    (r => to_float(0), i => to_float(0)), 
                                    (r => to_float(0), i => to_float(0)), 
                                    (r => to_float(1), i => to_float(0)));
  
  constant zgate_m : matrix4 := ((r => to_float(1), i => to_float(0)), 
                                 (r => to_float(0), i => to_float(0)), 
                                 (r => to_float(0), i => to_float(0)), 
                                 (r => to_float(-1), i => to_float(0)));
  
  constant ygate_m : matrix4 := ((r => to_float(0), i => to_float(0)), 
                                 (r => to_float(0), i => to_float(-1)), 
                                 (r => to_float(0), i => to_float(1)), 
                                 (r => to_float(0), i => to_float(0)));
      
  -- Operators Overload for Complex Multiplication
  function "*" (a: qcomplex; b: qcomplex) return qcomplex;
  function "+" (a: qcomplex; b: qcomplex) return qcomplex;
  function "-" (a: qcomplex; b: qcomplex) return qcomplex;
  
  -- Quantum Gates
  function Z_gate ( q: matrix2 ) return matrix2 ;
  function Y_gate ( q: matrix2 ) return matrix2 ;
  function hadamard ( q: matrix2 ) return matrix2 ;
  function fasec ( q: matrix2 ) return matrix2 ;
  function X_gate ( q: matrix2 ) return matrix2 ;
  function CX_gate ( control: matrix2; target: matrix2 ) return matrix4 ;
  function hadamard4 ( q: matrix4 ) return matrix4 ;

  -- Components / Quantum Algorithms

  component Bernstein_Vazirani is

  port( reset, clk : std_logic;
        secret_number : in std_logic_vector( 7 downto 0 );
        result : out std_logic_vector( 7 downto 0 )
      );
    
  end component;
    
  component interferometro is

  port( reset, clk : std_logic ;
        ctrl : std_logic_vector( 2 downto 0  );
        a : in matrix2;
        o : out matrix2
        );
    
  end component;
  
end main_package;

package body main_package is

  -- Operators Implementation

  function "+" (a: qcomplex; b: qcomplex) return qcomplex is
    
    variable result: qcomplex;
    
    begin

    result.r := a.r + b.r;
    result.i := a.i + b.i;

    return result;

  end function;

  function "-" (a: qcomplex; b: qcomplex) return qcomplex is
    
    variable result: qcomplex;
    
    begin

    result.r := a.r - b.r;
    result.i := a.i - b.i;

    return result;

  end function;

  function "*" (a: qcomplex; b: qcomplex) return qcomplex is
    
    variable result: qcomplex;
    
    begin
    
    result.r := a.r * b.r - a.i * b.i;
    result.i := a.r * b.i + a.i * b.r;
    return result;
    
  end function;

  -- Gates Implementation

  function Z_gate ( q: matrix2 ) return matrix2 is
    
    variable rs : matrix2;
      
    begin
    
    -- fasec is defined as matrix4 in the start of the package
    -- Doing the multiplication P * Q 
    
    rs.c0 := zgate_m.c0 * q.c0 + zgate_m.c1 * q.c1;

    rs.c1 := zgate_m.c2 * q.c0 + zgate_m.c3 * q.c1 ;
    
    return rs;

  end Z_gate;
    
  function Y_gate ( q: matrix2 ) return matrix2 is
    
    variable rs : matrix2;
      
    begin
    
    -- fasec is defined as matrix4 in the start of the package
    -- Doing the multiplication P * Q 
    
    rs.c0 := ygate_m.c0 * q.c0 + ygate_m.c1 * q.c1;

    rs.c1 := ygate_m.c2 * q.c0 + ygate_m.c3 * q.c1 ;
    
    return rs;
       
  end Y_gate;
  
  function hadamard4 ( q: matrix4 ) return matrix4 is

    variable result : matrix4 ;
    variable identity : matrix4 ;
    variable tensor : matrix16 ;
    
    begin

      -- Tensor product between identity and hadamard
      tensor(0) := hadamard_m.c0 * identity_m.c0;
      tensor(1) := hadamard_m.c0 * identity_m.c1;            
      tensor(2) := hadamard_m.c0 * identity_m.c2;
      tensor(3) := hadamard_m.c0 * identity_m.c3;
      tensor(4) := hadamard_m.c1 * identity_m.c0;
      tensor(5) := hadamard_m.c1 * identity_m.c1;
      tensor(6) := hadamard_m.c1 * identity_m.c2;
      tensor(7) := hadamard_m.c1 * identity_m.c3;
      tensor(8) := hadamard_m.c2 * identity_m.c0;
      tensor(9) := hadamard_m.c2 * identity_m.c1;
      tensor(10):= hadamard_m.c2 * identity_m.c2;
      tensor(11):= hadamard_m.c2 * identity_m.c3;
      tensor(12):= hadamard_m.c3 * identity_m.c0;
      tensor(13):= hadamard_m.c3 * identity_m.c1;
      tensor(14):= hadamard_m.c3 * identity_m.c2;
      tensor(15):= hadamard_m.c3 * identity_m.c3;

      -- Applying hadamard4 on qbits
      result.c0 := q.c0 * tensor(0) + q.c1 * tensor(1)
                   + q.c2 * tensor(2) + q.c3 * tensor(3) ;
      
      result.c1 := q.c0 * tensor(4) + q.c1 * tensor(5)
                   + q.c2 * tensor(6) + q.c3 * tensor(7) ;
      
      result.c2 := q.c0 * tensor(8) + q.c1 * tensor(9)
                   + q.c2 * tensor(10) + q.c3 * tensor(11) ;

      result.c3 := q.c0 * tensor(12) + q.c1 * tensor(13)
                   + q.c2 * tensor(14) + q.c3 * tensor(15) ;
    
      
    return result;
    
  end hadamard4;
  
  function CX_gate ( control: matrix2; target: matrix2 ) return matrix4 is

    variable cx : matrix16 ;
    variable tensor : matrix4 ;
    variable result : matrix4 ;
    
  begin
    
    for i in matrix16'range loop      
      cx(i).r := to_float(0);  -- Initialize the real part
      cx(i).i := to_float(0);  -- Initialize the imaginary part
    end loop;
    
    cx(0).r := to_float(1) ;
    cx(5).r := to_float(1) ;
    cx(11).r := to_float(1) ;
    cx(14).r := to_float(1) ;
    
    -- Tensor product of control * target
    
    tensor.c0 := target.c0 * control.c0;
    tensor.c1 := target.c0 * control.c1;

    tensor.c2 := target.c1 * control.c0;
    tensor.c3 := target.c1 * control.c1;
        
    -- Dot product between Cx and Tensor

    result.c0 := tensor.c0 * cx(0) + tensor.c1 * cx(1)
                 + tensor.c2 * cx(2) + tensor.c3 * cx(3) ;
    
    result.c1 := tensor.c0 * cx(4) + tensor.c1 * cx(5)
                 + tensor.c2 * cx(6) + tensor.c3 * cx(7) ;
    
    result.c2 := tensor.c0 * cx(8) + tensor.c1 * cx(9)
                 + tensor.c2 * cx(10) + tensor.c3 * cx(11) ;

    result.c3 := tensor.c0 * cx(12) + tensor.c1 * cx(13)
                 + tensor.c2 * cx(14) + tensor.c3 * cx(15) ;
    
    
    return result;
      
  end CX_gate;
  
  function fasec ( q: matrix2 ) return matrix2 is
    
    variable rs : matrix2;
    
    begin
    
    -- fasec is defined as matrix4 in the start of the package
    -- Doing the multiplication P * Q 
    
    rs.c0 := fasec_m.c0 * q.c0 + fasec_m.c1 * q.c1;

    rs.c1 := fasec_m.c2 * q.c0 + fasec_m.c3 * q.c1 ;
    
    return rs;

  end fasec;

  function X_gate ( q: matrix2 ) return matrix2 is
    
    variable rs : matrix2;
    
    begin
   
    -- xgate is defined in the start of the package as a matrix 4
    -- Doing the multiplication X * Q 
        
    rs.c0 := xgate_m.c0 * q.c0 + xgate_m.c1 * q.c1;

    rs.c1 := xgate_m.c2 * q.c0 + xgate_m.c3 * q.c1 ;
    
    return rs;

  end X_gate;
  
  function hadamard ( q: matrix2 ) return matrix2 is
    
    variable rs : matrix2;
    
    begin
    
      -- hadamard_m is defined in the start of the package as a matrix4 
      -- Doing the multiplication H * Q
      -- Complex multiplication : ( ac - bd ) + ( ad + cb ) * i
      -- Of two complex numbers ( a + bi ) * ( c + di )
      -- ** Defined in the operator overloaded functions **
    
      rs.c0 := hadamard_m.c0 * q.c0 + hadamard_m.c1 * q.c1;

      rs.c1 := hadamard_m.c2 * q.c0 + hadamard_m.c3 * q.c1 ;
    
      return rs;

  end hadamard;

end main_package;
