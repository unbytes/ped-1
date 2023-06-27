library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity overflow_detector is
    Port ( a : in std_logic;
           b : in std_logic;
           c : in std_logic;
           e : out std_logic);
end overflow_detector;

architecture Behavioral of overflow_detector is

begin

    e <= ((not a) and (not b) and c) or (a and b and (not c));

end Behavioral;
