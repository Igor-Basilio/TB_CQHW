
Library IEEE;
USE IEEE.std_logic_1164.all;
LIBRARY work;
USE work.main_package.all;
USE work.types_package.all;

entity interferometro is

  port( reset, clk : std_logic ;
        ctrl : std_logic_vector( 2 downto 0  ) ;
        a : in matrix2 ;
        o : out matrix2
        );
    
end interferometro;

architecture behave of interferometro is

  signal q : matrix2;
  
begin

  proc : process ( clk, q, reset, a, ctrl )

  begin

    if ( reset = '0' ) then
       q <= a;
    elsif ( rising_edge(clk) ) then
      
       if ( ctrl= "001" ) then
              q <= hadamard(q);
       elsif ( ctrl= "010" ) then
              q <= fasec(q);
       end if;
       
    end if;
             
       o <= q;

  end process proc;

end behave;
