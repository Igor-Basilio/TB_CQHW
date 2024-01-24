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
  signal ctrl : std_logic_vector( 3 downto 0 ) ;
  signal a : matrix2 ;
  signal secret_number : std_logic_vector( 7 downto 0) := "01010010";
  
  -- Outputs
  
  signal o : matrix2;
  signal result : std_logic_vector( 7 downto 0 );
  signal result_had : matrix2_array( secret_number'length downto 0 );
  signal result_hadreal : matrix2_realarray ( secret_number'length downto 0 );
    
  -- Internal Counter

  signal counter : integer := 0;
  
   -- * * * * * * * * * * --
  -- Start of architecture --   
   -- * * * * * * * * * * --
  
  begin
    
  UUT : Bernstein_Vazirani port map ( reset, clk, secret_number, ctrl, result, result_had );
  
  reset <= '1' , '0' after 10 ns, 
                 '1' after 20 ns;

  tr : for i in result_hadreal'length - 1 downto 0 generate
    
    result_hadreal(i) <= complex_toreal( result_had(i) );

  end generate;
  
  clock : process
  begin
    clk <= '0' , '1' after 5 ns;
    wait for 10 ns;
  end process;

   -- * * * * * * * * * * --
   -- Start of test bench --   
   -- * * * * * * * * * * --
    
  test_bench : process
    
  begin
    
    while( counter <= 1000 ) loop

          ctrl <= "0000";
          wait until rising_edge(clk);

          ctrl <= "0001";
          wait until rising_edge(clk);
          
          counter <= counter + 1;
          
    end loop;   

    wait;
  end process;
  
end arq;
