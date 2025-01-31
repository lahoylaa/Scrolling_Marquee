----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 09:40:27 PM
-- Design Name: 
-- Module Name: active_digit - Behavioral
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

entity active_digit_decoder is
  --  Port ( );
  port (
    fast_clk     : in  STD_LOGIC;
    rst_btnC     : in  STD_LOGIC;
    active_digit : out INTEGER range 0 to 7
  );
end entity;

architecture Behavioral of active_digit_decoder is

  signal digit_counter : integer range 0 to 7 := 0;

begin
  -- Update Active Digit
  process (fast_clk, rst_btnC)
  begin
    if rst_btnC = '1' then
      digit_counter <= 0;
    elsif rising_edge(fast_clk) then
      digit_counter <= (digit_counter + 1) mod 8; -- Cycle through 8 digits
    end if;
  end process;

  active_digit <= digit_counter;

end architecture;
