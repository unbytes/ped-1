library IEEE;
use IEEE.std_logic_1164.all;

entity main is
    Port ( clk : in std_logic;
           an : out std_logic_vector (3 downto 0);
           seg : out std_logic_vector (6 downto 0));
end main;

architecture Behavioral of main is

    constant seconds_2: integer := 200000000;

    component bcd_7seg
        Port ( num : in std_logic_vector (3 downto 0);
               seg : out std_logic_vector (6 downto 0));
    end component;
    
    component mux
        Port ( clk : in std_logic;
               sel : in integer range 1 to 3;
               an : out STD_LOGIC_VECTOR (3 downto 0);
               num : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal clk_change: std_logic;
    signal cnt_05Hz: integer range 1 to seconds_2 := 1;
    signal project_state: integer range 1 to 3 := 1;
    signal s_num: std_logic_vector (3 downto 0);

begin
    
    clock_05Hz: process(clk)
    begin
        if rising_edge(clk) then
            if cnt_05Hz = seconds_2 then
                cnt_05Hz <= 1;
                clk_change <= not clk_change;
            else
                cnt_05Hz <= cnt_05Hz + 1;            
            end if;
        end if;
    end process;
    
    handle_state_change: process(clk_change)
    begin
        if rising_edge(clk_change) then
            project_state <= project_state + 1;
        end if;
    end process;
    
    multiplexer: mux port map(clk=>clk, sel=>project_state, an=>an, num=>s_num);
    handle_7seg: bcd_7seg port map(num=>s_num, seg=>seg);

end Behavioral;
