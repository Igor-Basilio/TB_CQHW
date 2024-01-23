library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rand_gen is
    Port ( clk : in std_logic;
           rand_num : out std_logic_vector (7 downto 0));
end rand_gen;

architecture behave of rand_gen is
  
    signal lfsr : std_logic_vector (7 downto 0) := "00000001"; -- Initial seed
    signal feedback : std_logic;
    
begin
  
    process(clk)
    begin
      if rising_edge(clk) then
        
            feedback <= lfsr(7) xor lfsr(5) xor lfsr(4) xor lfsr(3);
            lfsr <= lfsr(6 downto 0) & feedback;
            
      end if;
    end process;

    rand_num <= lfsr;
    
end behave;
