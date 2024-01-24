
Library IEEE;
USE IEEE.std_logic_1164.all;
LIBRARY work;
USE work.main_package.all;
USE work.types_package.all;
library ieee_proposed;
USE ieee_proposed.math_utility_pkg.all;
USE ieee_proposed.fixed_pkg.all;
USE ieee_proposed.float_pkg.all;

entity Bernstein_Vazirani is

  port( reset, clk : in std_logic;
        secret_number : in std_logic_vector( 7 downto 0 );
        ctrl : in std_logic_vector( 3 downto 0 );
        result : out std_logic_vector( 7 downto 0 );
        result_had : out matrix2_array( 8 downto 0 ) 
      );
    
end Bernstein_Vazirani;

architecture behave of Bernstein_Vazirani is

  signal q : std_logic_vector( 7 downto 0 ) ;
  signal matrix_array : matrix2_array( q'length downto 0 ) ;
  signal matrix_array4 : matrix4_array( q'length downto 0 ) ;
  
begin

  q <= secret_number;

  result_had <= matrix_array;
  
  -- Initialize all qbits ( length of the secret_number + 1 )
  -- To start state | Phy > = | 0 > = ( 1, 0 )
  main : process( clk )

  begin

    if rising_edge( clk ) then
      
      if ctrl = "0000" then

        for i in matrix_array'range loop

          matrix_array(i).c0.r <= to_float(1);
          matrix_array(i).c0.i <= to_float(0);
          matrix_array(i).c1.r <= to_float(0);
          matrix_array(i).c1.i <= to_float(0);
          
        end loop;

      elsif ctrl = "0001" then
      
        -- Hadamard applied to all ( n - 1 ) qbits
        -- Given that the last qbit needs the X gate first
        for i in q'length - 1 downto 0 loop     
          matrix_array(i) <= hadamard( matrix_array(i) );
        end loop;

        matrix_array( q'length ) <=
          hadamard ( X_gate ( matrix_array( q'length ) ) ) ;

      end if ;

      --- Não testei VVVVV
    --   -- Applyin Controlled Not on all active Bits on the
    --   -- Secret number
    --   for i in q'length - 1 downto 0 loop

    --     if q(i) = '1' then

    --       matrix_array4(i) <= CX_gate( matrix_array(i), matrix_array( q'length ) );
          
    --     end if;
        
    --   end loop;

    --   for i in q'length - 1 downto 0 loop
        
    --     if q(i) = '1' then
          
    --       matrix_array4(i) <= hadamard4( matrix_array4(i) );
          
    --     end if;
        
    --   end loop;
     
     end if;
    
  end process;
  
end behave;
