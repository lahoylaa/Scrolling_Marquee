library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.NUMERIC_STD.all;

entity seven_seg_mux is
  port (
    active_digit : in  INTEGER range 0 to 7;  -- Controls which digit is active
    scroll_pos   : in  INTEGER range 0 to 24; -- Smoothly scrolls without jumps
    seg_an       : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data     : out STD_LOGIC_VECTOR(15 downto 0)
  );
end entity;

architecture Behavioral of seven_seg_mux is
  signal seg_data_0    : std_logic_vector(7 downto 0);
  signal seg_data_1    : std_logic_vector(7 downto 0);
  signal temp_seg_data : std_logic_vector(7 downto 0) := "11111111";
  type digit_array is array (0 to 24) of std_logic_vector(7 downto 0);
  signal digit_values : digit_array := (
    -- Padding for off output
    "11111111", -- _ (0)
    "11111111", -- _ (1)
    "11111111", -- _ (2)
    "11111111", -- _ (3)
    "11111111", -- _ (4)
    "11111111", -- _ (5)
    "11111111", -- _ (6)
    "11111111", -- _ (7)
    "10001000", -- A (8)
    "10000110", -- E (9)
    "10101111", -- r (10)
    "11000000", -- O (11)
    "10101011", -- n (12)
    "11111111", -- _ (13)
    "11000111", -- L (14)
    "10001000", -- A (15)
    "10001001", -- H (16)
    "11000000", -- O (17)
    "10010001", -- y (18)
    "11000111", -- L (19)
    "10001000", -- A (20)
    "10001001", -- H (21)
    "11000000", -- O (22)
    "10010001", -- y (23)
    "11111111" -- _  (24)
  );

begin
  -- Assign Segment Data for Active Digit
  process (active_digit, scroll_pos, temp_seg_data)
  begin

    -- Ensure a smooth transition by continuing scroll_pos without a hard reset
    temp_seg_data <= digit_values((scroll_pos + active_digit) mod 25);

    -- can use switch statements to match MUX layout but this is requires less lines
    if active_digit < 4 then
      seg_data_0 <= temp_seg_data;
      seg_data_1 <= (others => '1');
    else
      seg_data_1 <= temp_seg_data;
      seg_data_0 <= (others => '1');
    end if;
  end process;

  -- Enable Active Anode Based on `active_digit`
  seg_an <= not std_logic_vector(to_unsigned(2 ** active_digit, 8));

  -- Combine Segment Data for Final Output
  seg_data <= seg_data_1 & seg_data_0;

end architecture;
