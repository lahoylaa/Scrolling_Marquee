library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.numeric_std.all;

entity sixteen_segment_scroll is
  port (
    clk_100MHz : in  STD_LOGIC;                     -- Input clock
    rst_btnC   : in  STD_LOGIC;                     -- Reset signal
    seg_an     : out STD_LOGIC_VECTOR(7 downto 0); -- Digit enable signals
    seg_data   : out STD_LOGIC_VECTOR(15 downto 0)   -- Segment data (a-g and dp)
  );
end entity;

architecture Behavioral of sixteen_segment_scroll is

  signal seg_data_0 : std_logic_vector(7 downto 0); -- Segments for anodes 0-3
  signal seg_data_1 : std_logic_vector(7 downto 0); -- Segments for anodes 4-7
  signal active_group : std_logic;                 -- 0: Group 1 (digits 0–3), 1: Group 2 (digits 4–7)
  signal active_digit : integer range 0 to 7 := 0; -- Current active digit
  signal scroll_pos   : integer range 0 to 15 := 0; -- Scrolling position

  signal fast_clk       : std_logic := '0'; -- Fast clock for digit multiplexing
  signal slow_clk       : std_logic := '0'; -- Slow clock for scrolling
  signal fast_clk_count : integer range 0 to 99_999 := 0;
  signal slow_clk_count : integer range 0 to 50_000_000 := 0;

  type digit_array is array (0 to 15) of std_logic_vector(3 downto 0);
  signal digit_values : digit_array := (
    "0000", "0001", "0010", "0011", -- A, E, r, O
    "0100", "0101", "0110", "0111", -- n, _, L, A
    "1000", "1001", "1010", "1011", -- H, O, y, L
    "1100", "1101", "1110", "1111"  -- A, H, O, y
  );

  -- Seven-segment decoder with decimal point control
  function digit_to_seven_seg(value : std_logic_vector(3 downto 0)) return std_logic_vector is
    variable seg : std_logic_vector(7 downto 0);
  begin
    case value is
      when "0000" => seg := "10001000"; -- A
      when "0001" => seg := "10000110"; -- E
      when "0010" => seg := "10101111"; -- r
      when "0011" => seg := "11000000"; -- O
      when "0100" => seg := "10101011"; -- n
      when "0101" => seg := "11111111"; -- _
      when "0110" => seg := "11000111"; -- L
      when "0111" => seg := "10001000"; -- A
      when "1000" => seg := "10001001"; -- H
      when "1001" => seg := "11000000"; -- O
      when "1010" => seg := "10010001"; -- y
      when "1011" => seg := "11000111"; -- L
      when "1100" => seg := "10001000"; -- A
      when "1101" => seg := "10001001"; -- H
      when "1110" => seg := "11000000"; -- O
      when "1111" => seg := "10010001"; -- y
      when others => seg := "11111111"; -- Blank/off
    end case;
    return seg;
  end function;

begin

  -- Slow Clock for Scrolling
  process (clk_100MHz, rst_btnC)
  begin
    if rst_btnC = '1' then
      slow_clk_count <= 0;
      slow_clk <= '0';
    elsif rising_edge(clk_100MHz) then
      if slow_clk_count = 49_999_999 then
        slow_clk_count <= 0;
        slow_clk <= not slow_clk;
      else
        slow_clk_count <= slow_clk_count + 1;
      end if;
    end if;
  end process;

  -- Fast Clock for Multiplexing
  process (clk_100MHz, rst_btnC)
  begin
    if rst_btnC = '1' then
      fast_clk_count <= 0;
      fast_clk <= '0';
    elsif rising_edge(clk_100MHz) then
      if fast_clk_count = 99_999 then
        fast_clk_count <= 0;
        fast_clk <= not fast_clk;
      else
        fast_clk_count <= fast_clk_count + 1;
      end if;
    end if;
  end process;

  -- Update Scroll Position
  process (slow_clk, rst_btnC)
  begin
    if rst_btnC = '1' then
      scroll_pos <= 0;
    elsif rising_edge(slow_clk) then
      scroll_pos <= (scroll_pos + 1) mod 16; -- Scroll through 16 characters
    end if;
  end process;

  -- Update Active Digit
  process (fast_clk, rst_btnC)
  begin
    if rst_btnC = '1' then
      active_digit <= 0;
    elsif rising_edge(fast_clk) then
      active_digit <= (active_digit + 1) mod 8; -- Cycle through 8 digits
    end if;
  end process;

  -- Determine Active Group
  active_group <= '0' when active_digit < 4 else '1';

  -- Assign Segment Data
  process (active_digit, scroll_pos, digit_values)
  begin
    if active_group = '0' then
      seg_data_0 <= digit_to_seven_seg(digit_values((scroll_pos + active_digit) mod 16));
      seg_data_1 <= (others => '1'); -- Disable Group 2
    else
      seg_data_1 <= digit_to_seven_seg(digit_values((scroll_pos + active_digit) mod 16));
      seg_data_0 <= (others => '1'); -- Disable Group 1
    end if;
  end process;

  -- Enable Active Anode
  seg_an <= not std_logic_vector(to_unsigned(2 ** active_digit, 8));

  -- Output Segment Data
  seg_data <= seg_data_1 & seg_data_0;


end Behavioral;

