library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.main_package.all;
use work.types_package.all;
library ieee_proposed;
USE ieee_proposed.math_utility_pkg.all;
USE ieee_proposed.float_pkg.all;
USE ieee_proposed.fixed_pkg.all;

entity tb is
end tb;

architecture arq of tb is
  
  -- Inputs

  signal reset, clk : std_logic ;
  signal ctrl : std_logic_vector( 2 downto 0 ) ;
  signal a : matrix2 ;
  signal secret_number : std_logic_vector( 7 downto 0) := "01010010";
  
  -- Outputs
  
  signal o : matrix2;
  signal result : std_logic_vector( 7 downto 0 );
  
  -- Signals to show floating point reals ( 32 bit )

  signal a_r, o_r : matrix2_real;

  signal a_v, o_v : matrix2_sulv;
  
  -- Internal Counter

  signal counter : integer := 0;
  
   -- * * * * * * * * * * --
  -- Start of architecture --   
   -- * * * * * * * * * * --
  
  begin
    
  UUT : Bernstein_Vazirani port map ( reset, clk, secret_number, result );
  
  reset <= '1' , '0' after 10 ns, 
                 '1' after 20 ns;

--  a.c0.r <= to_float(1);
 -- a.c0.i <= to_float(0);  -- | Phy > = | 0 > 

--  a.c1.r <= to_float(0);
 -- a.c1.i <= to_float(0);
  
  -- Conversion to FP for displaying purposes.
  
--  convert : process(  a, o, a_v, o_v )

--  begin

--    a_v.c0.r <= to_sulv( to_float64( a.c0.r ) );
 --   a_v.c0.i <= to_sulv( to_float64( a.c0.i ) );
 --   a_v.c1.r <= to_sulv( to_float64( a.c1.r ) );
 --   a_v.c1.i <= to_sulv( to_float64( a.c1.i ) );

--    o_v.c0.r <= to_sulv( to_float64( o.c0.r ) );
 --   o_v.c0.i <= to_sulv( to_float64( o.c0.i ) );
 --   o_v.c1.r <= to_sulv( to_float64( o.c1.r ) );
 --   o_v.c1.i <= to_sulv( to_float64( o.c1.i ) );
    
--    a_r.c0.r <= bitstoreal( a_v.c0.r );
 --   a_r.c0.i <= bitstoreal( a_v.c0.i );
 --   a_r.c1.r <= bitstoreal( a_v.c1.r );
 --   a_r.c1.i <= bitstoreal( a_v.c1.i );

 --   o_r.c0.r <= bitstoreal( o_v.c0.r );
 --   o_r.c0.i <= bitstoreal( o_v.c0.i );
--    o_r.c1.r <= bitstoreal( o_v.c1.r );
--    o_r.c1.i <= bitstoreal( o_v.c1.i );
    
--  end process;
    
  clock : process
  begin
    clk <= '1' , '0' after 5 ns;
    wait for 10 ns;
  end process;

   -- * * * * * * * * * * --
   -- Start of test bench --   
   -- * * * * * * * * * * --
    
  test_bench : process
    
  begin
    
    while( counter <= 1000 ) loop

          ctrl <= "001";
          wait until rising_edge(clk);

          ctrl <= "010";          
          wait until rising_edge(clk);
          
          counter <= counter + 1;
          
    end loop;   

    wait;
  end process;
  
end arq;
