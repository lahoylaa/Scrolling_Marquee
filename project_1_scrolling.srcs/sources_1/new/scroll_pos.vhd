----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 09:38:40 PM
-- Design Name: 
-- Module Name: scroll_pos - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scroll_pos_decoder is
--  Port ( );
Port(
    slow_clk : in STD_LOGIC;
    rst_btnC : in STD_LOGIC;
    scroll_pos : out INTEGER range 0 to 15
);
end scroll_pos_decoder;

architecture Behavioral of scroll_pos_decoder is
 signal scroll_pos_counter : integer range 0 to 15 := 0;

begin
  -- Update Scroll Position
  process (slow_clk, rst_btnC)
  begin
    if rst_btnC = '1' then
      scroll_pos_counter <= 0;
    elsif rising_edge(slow_clk) then
      scroll_pos_counter <= (scroll_pos_counter + 1) mod 16; -- Scroll through 16 characters
    end if;
  end process;

scroll_pos <= scroll_pos_counter;

end Behavioral;
