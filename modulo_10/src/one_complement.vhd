library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity one_complement is
    Port ( a : in std_logic_vector (3 downto 0);
           sel : in std_logic;
           z : out std_logic_vector (3 downto 0));
end one_complement;

architecture Behavioral of one_complement is

begin

    process (sel, a) 
    begin
        if (sel = '1') then
            z <= not a;
        else
            z <= a;
        end if;
    end process;

end Behavioral;
