library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( clk : in std_logic;
           sel : in integer range 1 to 3;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           num : out STD_LOGIC_VECTOR (3 downto 0));
end mux;

architecture Behavioral of mux is

    constant seconds_002: integer := 2000000;
    
    signal clk_real: std_logic;
    signal cnt_50Hz: integer range 1 to seconds_002 := 1;
    signal display_selector: integer range 1 to 4 := 1;
    signal s_an, s_num: std_logic_vector (3 downto 0);

begin

    clock_50Hz: process(clk)
    begin
        if rising_edge(clk) then
            if cnt_50Hz = seconds_002 then
                cnt_50Hz <= 1;
                clk_real <= not clk_real;
            else
                cnt_50Hz <= cnt_50Hz + 1;            
            end if;
        end if;
    end process;

    process(clk_real)
    begin
        if rising_edge(clk_real) then
            if sel = 1 then
                case display_selector is
                    when 1 => s_an <= "1110"; s_num <= "0011";
                    when 2 => s_an <= "1101"; s_num <= "0000";
                    when 3 => s_an <= "1011"; s_num <= "0111";
                    when 4 => s_an <= "0111"; s_num <= "1000";
                    when others => null;
                end case;
            elsif sel = 2 then
                case display_selector is
                    when 1 => s_an <= "1110"; s_num <= "1001";
                    when 2 => s_an <= "1101"; s_num <= "0000";
                    when 3 => s_an <= "1110"; s_num <= "1001";
                    when 4 => s_an <= "1101"; s_num <= "0000";
                    when others => null;
                end case;
            else
                s_an <= "1111";
                s_num <= "0000";
            end if;
            display_selector <= display_selector + 1;
        end if;
    end process;
    
    an <= s_an;
    num <= s_num;

end Behavioral;
