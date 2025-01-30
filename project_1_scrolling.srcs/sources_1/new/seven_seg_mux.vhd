library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.NUMERIC_STD.all;

entity seven_seg_mux is
  port (
    --clk_100MHz  : in  STD_LOGIC;
    delay_active : in  STD_LOGIC;
    full_off     : in  STD_LOGIC;
    active_digit : in  INTEGER range 0 to 7;  -- Controls which digit is active
    scroll_pos   : in  INTEGER range 0 to 23; -- Smoothly scrolls without jumps
    seg_an       : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data     : out STD_LOGIC_VECTOR(15 downto 0)
  );
end entity;

architecture Behavioral of seven_seg_mux is
  signal seg_data_0    : std_logic_vector(7 downto 0);
  signal seg_data_1    : std_logic_vector(7 downto 0);
  signal temp_seg_data : std_logic_vector(7 downto 0);
  --signal delay_active   : std_logic := '0'; -- Handles 2-second delay
  signal delay_counter : integer range 0 to 199_999_999 := 0; -- 2-sec delay at 100MHz
  -- signal full_off       : std_logic := '0'; -- Turns OFF display before restart
  type digit_array is array (0 to 23) of std_logic_vector(7 downto 0);
  signal digit_values : digit_array := (
    -- Original message "LAHOYLAHOY"
    "10001000", -- A
    "10000110", -- E
    "10101111", -- r
    "11000000", -- O
    "10101011", -- n
    "11111111", -- _ (Blank)
    "11000111", -- L
    "10001000", -- A
    "10001001", -- H
    "11000000", -- O
    "10010001", -- y
    "11000111", -- L
    "10001000", -- A
    "10001001", -- H
    "11000000", -- O
    "10010001", -- y

    -- Extra padding (8 blank spaces for delay)
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111" -- _
  );

begin

  ---- Delay Control Process
  --process (clk_100MHz)
  --begin
  --  if rising_edge(clk_100MHz) then
  --    if (scroll_pos = 23 and active_digit = 7) then  
  --      delay_active <= '1'; -- Start the 2-second blank delay
  --      delay_counter <= 0;
  --    elsif delay_active = '1' then
  --      if delay_counter < 199_999_999 then
  --        delay_counter <= delay_counter + 1;
  --      else
  --        delay_active <= '0';
  --        full_off <= '1'; -- Turn everything off before restart
  --      end if;
  --    elsif full_off = '1' then
  --      full_off <= '0'; -- Reset and allow smooth restart
  --    end if;
  --  end if;
  --end process;
  -- Assign Segment Data for Active Digit
  process (active_digit, scroll_pos)
  begin
    if full_off = '1' then
      seg_data_0 <= (others => '1'); -- All segments off
      seg_data_1 <= (others => '1');
    else
      -- Ensure a smooth transition by continuing scroll_pos without a hard reset
      temp_seg_data <= digit_values((scroll_pos + active_digit) mod 24);

    -- can use switch statements to match MUX layout but this is requires less lines
      if active_digit < 4 then
        seg_data_0 <= temp_seg_data;
        seg_data_1 <= (others => '1');
      else
        seg_data_1 <= temp_seg_data;
        seg_data_0 <= (others => '1');
      end if;
    end if;
  end process;

  -- Enable Active Anode Based on `active_digit`
  seg_an <= not std_logic_vector(to_unsigned(2 ** active_digit, 8));

  -- Combine Segment Data for Final Output
  seg_data <= seg_data_1 & seg_data_0;

end architecture;
