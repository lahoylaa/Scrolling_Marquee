----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 07:46:25 PM
-- Design Name: 
-- Module Name: half_second_clk - Behavioral
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

entity half_second_clk is
--  Port ( );
Port(
    clk_100MHz : in STD_LOGIC;
    rst_btnC : in STD_LOGIC;
    slow_clkout : out STD_LOGIC
);
end half_second_clk;

architecture Behavioral of half_second_clk is

signal slow_clk_count : integer range 0 to 50_000_000 := 0;
signal slow_clk : std_logic;

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

slow_clkout <= slow_clk;

end Behavioral;
