library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_sum is
    Port ( clk : in std_logic;
           a : in std_logic_vector (3 downto 0);
           b : in std_logic_vector (3 downto 0);
           sel : in std_logic;
           an : out std_logic_vector (3 downto 0);
           seg : out std_logic_vector (6 downto 0);
           e : out std_logic);
end four_sum;

architecture Behavioral of four_sum is

    constant seconds_002: integer := 100000;
    
    signal c0, c1, c2, c3, s3: std_logic;
    signal current_b, s: std_logic_vector (3 downto 0);
    signal seg7_a, seg7_b, seg7_s: std_logic_vector (6 downto 0);
    
    signal clk_real: std_logic;
    signal cnt_50Hz: integer range 1 to seconds_002 := 1;
    signal display_selector: integer range 1 to 4 := 1;
    
    component one_sum
        Port ( a : in std_logic;
               b : in std_logic;
               cin : in std_logic;
               s : out std_logic;
               cout : out std_logic);
    end component;
    
    component two_complement
        Port ( a : in std_logic_vector (3 downto 0);
               sel: in std_logic;
               s : out std_logic_vector (3 downto 0));
    end component;
    
    component overflow_detector
        Port ( a : in std_logic;
               b : in std_logic;
               c : in std_logic;
               e : out std_logic);
    end component;
    
    component bcd_7seg
        Port ( input : in std_logic_vector (3 downto 0);
               segmt : out std_logic_vector (6 downto 0));
    end component;
    
begin
    
    handle_s: bcd_7seg port map(input=>s, segmt=>seg7_s);
    handle_a: bcd_7seg port map(input=>a, segmt=>seg7_a);
    handle_b: bcd_7seg port map(input=>b, segmt=>seg7_b);
    
    handle_two_complement: two_complement port map(a=>b, sel=>sel, s=>current_b);
    
    sum0: one_sum port map(a=>a(0), b=>current_b(0), cin=>'0', s=>s(0), cout=>c0);
    sum1: one_sum port map(a=>a(1), b=>current_b(1), cin=>c0, s=>s(1), cout=>c1);
    sum2: one_sum port map(a=>a(2), b=>current_b(2), cin=>c1, s=>s(2), cout=>c2);
    sum3: one_sum port map(a=>a(3), b=>current_b(3), cin=>c2, s=>s3, cout=>c3);
    
    s(3) <= s3;
    has_overflow: overflow_detector port map(a=>a(3), b=>current_b(3), c=>s3, e=>e);

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
            case display_selector is
                when 1 => an <= "0111"; seg <= seg7_a;
                when 2 => an <= "1011"; seg <= seg7_b;
                when 3 => an <= "1111"; seg <= "1111111";
                when 4 => an <= "1110"; seg <= seg7_s;
                when others => an <= "1111"; seg <= "1111111";
            end case;
            display_selector <= display_selector + 1;
        end if;
    end process;
    
end Behavioral;
