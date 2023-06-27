library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity two_complement is
    Port ( a : in std_logic_vector (3 downto 0);
           sel: in std_logic;
           s : out std_logic_vector (3 downto 0));
end two_complement;

architecture Behavioral of two_complement is

    signal reversed_a: std_logic_vector (3 downto 0);

    component one_complement
        Port ( a : in std_logic_vector (3 downto 0);
               sel : in std_logic;
               z : out std_logic_vector (3 downto 0));
    end component;

begin
    
    reverse_a: one_complement port map(a=>a, sel=>sel, z=>reversed_a);
    
    process (sel, reversed_a, a) 
    begin
        if (sel = '1') then
            s <= reversed_a + "0001";
        else
            s <= a;
        end if;
    end process;

end Behavioral;
