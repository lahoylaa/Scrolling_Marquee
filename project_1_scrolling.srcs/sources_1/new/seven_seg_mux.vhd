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
    mode : in INTEGER range 0 to 1;
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

  signal state : integer range 0 to 2;

  type digit_array is array (0 to 18) of std_logic_vector(7 downto 0);
  type pass_array is array (0 to 18) of std_logic_vector(7 downto 0);
  type fail_array is array (0 to 18) of std_logic_vector(7 downto 0);
  type enter_array is array (0 to 18) of std_logic_vector(7 downto 0);

  signal enter_values : enter_array := (
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "11111111", -- _
    "10000110", -- E
    "10101011", -- n
    "10010010", -- t
    "10000110", -- e
    "10101111", -- r
    "11111111", -- _
    "11000110", -- C
    "11000000", -- O
    "10100001", -- D
    "10000110", -- E
    "11111111" -- _ 
  );

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
    "10010001", -- y C
    "10000110", -- E O
    "10010010", -- S D
    "11111111", -- _ E
    "10001000", -- A _
    "11000110", -- C P
    "11000110", -- C A
    "10000110", -- E S
    "10010010", -- S S
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

--process(state)
--begin
-- case state is
-- when 0 => -- ENTER
-- when 1 => -- PASS
-- 
-- when 2 => -- FAIL
-- end case;
--end process;

  -- Assign Segment Data for Active Digit
  process (active_digit, scroll_pos, sequence_state, mode)
  begin

    case mode is
    when 0 => -- ENTER state
    temp_seg_data <= enter_values((scroll_pos + active_digit) mod 19);

    when 1 => -- PASS state
        if (sequence_state = '1') then -- Locked
      temp_seg_data <= digit_values((scroll_pos + active_digit) mod 19);
    else -- 
      temp_seg_data <= digit_values((scroll_pos + active_digit) mod 19);
    end if;

    when 2 => -- FAIL state
        if (sequence_state = '1') then -- Locked
      temp_seg_data <= lock_digits((scroll_pos + active_digit) mod 19);
    else -- Unlocked
      temp_seg_data <= enter_values((scroll_pos + active_digit) mod 19);
    end if;
    end case;

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
