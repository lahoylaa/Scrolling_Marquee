----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 09:42:29 PM
-- Design Name: 
-- Module Name: seven_seg_mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
  use IEEE.STD_LOGIC_1164.all;
    use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.numeric_std.all;

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --use IEEE.NUMERIC_STD.ALL;
  -- Uncomment the following library declaration if instantiating
  -- any Xilinx leaf cells in this code.
  --library UNISIM;
  --use UNISIM.VComponents.all;

entity seven_seg_mux is
  --  Port ( );
  port (
    active_digit : in  INTEGER range 0 to 7; -- acts the seg select
    scroll_pos   : in  INTEGER range 0 to 15;
    seg_an       : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data     : out STD_LOGIC_VECTOR(15 downto 0)
  );
end entity;

architecture Behavioral of seven_seg_mux is
  signal seg_data_0     : std_logic_vector(7 downto 0); -- Segments for digits 0-3
  signal seg_data_1     : std_logic_vector(7 downto 0); -- Segments for digits 4-7
  signal temp_seg_data  : std_logic_vector(7 downto 0); -- Temporary segment data
  signal scrolled_index : integer range 0 to 15;       -- Index for scrolling characters

  type digit_array is array (0 to 15) of std_logic_vector(7 downto 0);
  signal digit_values : digit_array := (
    "10001000", -- A
    "10000110", -- E
    "10101111", -- r
    "11000000", -- O
    "10101011", -- n
    "11111111", -- _
    "11000111", -- L
    "10001000", -- A
    "10001001", -- H
    "11000000", -- O
    "10010001", -- y
    "11000111", -- L
    "10001000", -- A
    "10001001", -- H
    "11000000", -- O
    "10010001"  -- y
  );

begin

  -- Calculate current digit to display
  temp_seg_data <= digit_values((scroll_pos + active_digit) mod 16);

  -- Assign Segment Data for Active Digit
  process(active_digit, temp_seg_data)
  begin
    case active_digit is
      when 0 => seg_data_0 <= temp_seg_data; seg_data_1 <= (others => '1'); -- Digit 0
      when 1 => seg_data_0 <= temp_seg_data; seg_data_1 <= (others => '1'); -- Digit 1
      when 2 => seg_data_0 <= temp_seg_data; seg_data_1 <= (others => '1'); -- Digit 2
      when 3 => seg_data_0 <= temp_seg_data; seg_data_1 <= (others => '1'); -- Digit 3
      when 4 => seg_data_1 <= temp_seg_data; seg_data_0 <= (others => '1'); -- Digit 4
      when 5 => seg_data_1 <= temp_seg_data; seg_data_0 <= (others => '1'); -- Digit 5
      when 6 => seg_data_1 <= temp_seg_data; seg_data_0 <= (others => '1'); -- Digit 6
      when 7 => seg_data_1 <= temp_seg_data; seg_data_0 <= (others => '1'); -- Digit 7
      when others =>
        seg_data_0 <= (others => '1'); -- Default to all segments off
        seg_data_1 <= (others => '1');
    end case;
  end process;

  -- Enable Active Anode Based on `active_digit`
  seg_an <= not std_logic_vector(to_unsigned(2 ** active_digit, 8));

  -- Combine Segment Data for Final Output
  seg_data <= seg_data_1 & seg_data_0;

end Behavioral;




          -- Assign Segment Data
      --process (active_digit, scroll_pos, digit_values)
      --begin
      --  if active_group = '0' then
      --    seg_data_0 <= digit_to_seven_seg(digit_values((scroll_pos + active_digit) mod 16));
      --    seg_data_1 <= (others => '1'); -- Disable Group 2
      --  else
      --    seg_data_1 <= digit_to_seven_seg(digit_values((scroll_pos + active_digit) mod 16));
      --    seg_data_0 <= (others => '1'); -- Disable Group 1
      --  end if;
      --end process;
      -- Enable Active Anode
