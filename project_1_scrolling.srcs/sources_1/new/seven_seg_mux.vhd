library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.NUMERIC_STD.all;

entity seven_seg_mux is
  port (
    slow_clk     : in  STD_LOGIC;
    active_digit : in  INTEGER range 0 to 7;  -- Controls which digit is active
    scroll_pos   : in  INTEGER range 0 to 18; -- Smoothly scrolls without jumps
    lock         : in  STD_LOGIC;
    seg_an       : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data     : out STD_LOGIC_VECTOR(15 downto 0)
  );
end entity;

architecture Behavioral of seven_seg_mux is

  signal state             : integer range 0 to 2 := 0;   -- ENTER state
  signal lock_prev         : std_logic := '1'; -- Track previous lock state
  signal check_lock_change : std_logic := '0'; -- Detect lock state change

  signal seg_data_0    : std_logic_vector(7 downto 0);
  signal seg_data_1    : std_logic_vector(7 downto 0);
  signal temp_seg_data : std_logic_vector(7 downto 0) := "11111111";

  type digit_array is array (0 to 18) of std_logic_vector(7 downto 0);

  signal enter_values : digit_array := (
    "11111111", "11111111", "11111111", "11111111",
    "11111111", "11111111", "11111111", "11111111",
    "10000110", "10101011", "10010010", "10000110",
    "10101111", "11111111", "11000110", "11000000",
    "10100001", "10000110", "11111111"
  );

  signal pass_values : digit_array := (
    "11111111", "11111111", "11111111", "11111111",
    "11111111", "11111111", "11111111", "11111111",
    "11000110", "11000000", "10100001", "10000110",
    "11111111", "10001100", "10001000", "10010010",
    "10010010", "11111111", "11111111"
  );

  signal fail_values : digit_array := (
    "11111111", "11111111", "11111111", "11111111",
    "11111111", "11111111", "11111111", "11111111",
    "10101011", "11000000", "11111111", "10001000",
    "11000110", "11000110", "10000110", "10010010",
    "10010010", "11111111", "11111111"
  );

begin

  -- State Machine to Control Display Messages
  process (slow_clk)
  begin
    if rising_edge(slow_clk) then

      -- Detect lock state change
      if (lock /= lock_prev) then
        check_lock_change <= '1';
      end if;
      lock_prev <= lock; -- Update previous lock state

      case state is
        when 0 =>  -- ENTER CODE (default state)
          if (check_lock_change = '1' and scroll_pos = 18) then
            if (lock = '1') then
              state <= 2;  -- FAIL state
            else
              state <= 1;  -- PASS state
            end if;
            check_lock_change <= '0'; -- Reset after transition
          end if;

        when 1 =>  -- PASS state
          if (scroll_pos = 18) then
            state <= 0;  -- Return to ENTER CODE
          end if;

        when 2 =>  -- FAIL state
          if (scroll_pos = 18) then
            state <= 0;  -- Return to ENTER CODE
          end if;

      end case;
    end if;
  end process;

  -- Assign Segment Data for Active Digit
  process (active_digit, scroll_pos, temp_seg_data)
  begin
    case state is
      when 0 => temp_seg_data <= enter_values((scroll_pos + active_digit) mod 19);
      when 1 => temp_seg_data <= pass_values((scroll_pos + active_digit) mod 19);
      when 2 => temp_seg_data <= fail_values((scroll_pos + active_digit) mod 19);
    end case;

    -- Control which digit gets data
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
