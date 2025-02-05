library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.NUMERIC_STD.all;

entity seven_seg_mux is
  port (
    active_digit : in  INTEGER range 0 to 7;  -- Controls which digit is active
    scroll_pos   : in  INTEGER range 0 to 18; -- Smoothly scrolls without jumps
    state         : in  INTEGER range 0 to 2;
    seg_an       : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data     : out STD_LOGIC_VECTOR(15 downto 0)
  );
end entity;

architecture Behavioral of seven_seg_mux is

  signal seg_data_0    : std_logic_vector(7 downto 0);
  signal seg_data_1    : std_logic_vector(7 downto 0);
  signal temp_seg_data : std_logic_vector(7 downto 0) := "11111111";

  type digit_array is array (0 to 18) of std_logic_vector(7 downto 0);

  signal enter_values : digit_array := (
    -- Padding
    "11111111", "11111111", "11111111", "11111111",
    "11111111", "11111111", "11111111", "11111111",
    "10000110", -- E
    "10101011", -- n
    "11111000", -- t
    "10000110", -- E
    "10101111", -- r
    "11111111", -- _
    "11000110", -- C
    "11000000", -- O
    "10100001", -- D
    "10000110", -- E
    "11111111" -- Padding
  );

  signal pass_values : digit_array := (
    -- Padding
    "11111111", "11111111", "11111111", "11111111",
    "11111111", "11111111", "11111111", "11111111",
    "11000110", -- C
    "11000000", -- O
    "10100001", -- d
    "10000110", -- E
    "11111111", -- _
    "10001100", -- P
    "10001000", -- A
    "10010010", -- S
    "10010010", -- S
    "11111111", -- Padding
    "11111111"
  );

  signal fail_values : digit_array := (
    -- Padding
    "11111111", "11111111", "11111111", "11111111",
    "11111111", "11111111", "11111111", "11111111",
    "11000110", -- n C
    "11000000", -- O O
    "10100001", -- _ d
    "10000110", -- A E
    "11111111", -- C _
    "10001110", -- C F
    "10001000", -- E A
    "11111001", -- S I
    "11000111", -- S L
    "11111111", -- Padding
    "11111111"
  );

begin

  -- Assign Segment Data for Active Digit
  process (active_digit, scroll_pos, temp_seg_data, state)
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
