library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.NUMERIC_STD.all;

entity seven_seg_mux is
  port (
    active_digit : in  INTEGER range 0 to 7;  -- Controls which digit is active
    scroll_pos   : in  INTEGER range 0 to 18; -- Smoothly scrolls without jumps
    sequence_state : in std_logic;
    seg_an       : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data     : out STD_LOGIC_VECTOR(15 downto 0)
  );
end entity;

architecture Behavioral of seven_seg_mux is
  signal seg_data_0    : std_logic_vector(7 downto 0);
  signal seg_data_1    : std_logic_vector(7 downto 0);
  signal temp_seg_data : std_logic_vector(7 downto 0);

  -- LED test
  signal temp_led_data : std_logic_vector(5 downto 0);

  -- test
  signal lock_hold      : std_logic;
  signal unlock_counter : INTEGER range 0 to 10 := 0;
  signal current_mode   : std_logic             := '1';
  signal sequence_done  : std_logic             := '0';
  signal lock_stable   : std_logic := '1';  -- Holds the previous lock state

  type digit_array is array (0 to 18) of std_logic_vector(7 downto 0);

  signal digit_values : digit_array := (
    -- -- Extra padding (8 blank spaces for delay)
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "10010001", -- y
    "10000110", -- E
    "10010010", -- S
    "11111111", -- _
    "10001000", -- A
    "11000110", -- C
    "11000110", -- C
    "10000110", -- E
    "10010010", -- S
    "10010010", -- S
    "11111111" -- _ 
  );

  signal lock_digits : digit_array := (
    -- -- Extra padding (8 blank spaces for delay)
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "10101011", -- n
    "11000000", -- O
    "11111111", -- _
    "10001000", -- A
    "11000110", -- C
    "11000110", -- C
    "10000110", -- E
    "10010010", -- S
    "10010010", -- S
    "11111111", -- _
    "11111111" -- _ 
  );

begin

 ---- Detect when the NO ACCESS sequence has completed
 --process (scroll_pos, lock)
 --begin
 --  -- If we reach the last position of the NO ACCESS sequence, mark it as done
 --  if scroll_pos = 18 then
 --    sequence_done <= '1';
 --  end if;

 --  -- Only change mode **after** sequence finishes
 --  if sequence_done = '1' then
 --    lock_stable <= lock;
 --    current_mode <= lock;
 --    sequence_done <= '0'; -- Reset for next cycle
 --  end if;
 --end process;

  -- Assign Segment Data for Active Digit
  process (active_digit, scroll_pos, sequence_state)
  begin

    if (sequence_state = '1') then -- Locked
      temp_seg_data <= lock_digits((scroll_pos + active_digit) mod 19);

      -- Ensure a smooth transition by continuing scroll_pos without a hard reset
      -- temp_seg_data <= lock_digits((scroll_pos + active_digit) mod 19);

    else -- Unlocked
      temp_seg_data <= digit_values((scroll_pos + active_digit) mod 19);

      -- Ensure a smooth transition by continuing scroll_pos without a hard reset
      --temp_seg_data <= digit_values((scroll_pos + active_digit) mod 19);
    end if;

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
