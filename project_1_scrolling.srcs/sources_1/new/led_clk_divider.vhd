----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2025 03:49:09 PM
-- Design Name: 
-- Module Name: led_clk_divider - Behavioral
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

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --use IEEE.NUMERIC_STD.ALL;
  -- Uncomment the following library declaration if instantiating
  -- any Xilinx leaf cells in this code.
  --library UNISIM;
  --use UNISIM.VComponents.all;

entity led_clk_divider is
  --  Port ( );
  port (
    clk_100MHz : in  STD_LOGIC;
    rst_btnC   : in  STD_LOGIC;
    led_clkout : out STD_LOGIC
  );
end entity;

architecture Behavioral of led_clk_divider is

  signal led_clk       : std_logic;
  signal led_clk_count : integer range 0 to 25_000_000; -- 0.25s

begin
  process (clk_100MHz)
  begin
    if (rst_btnC = '1') then
      led_clk_count <= 0;
      led_clk <= '0';
    elsif (clk_100MHz'event and rising_edge(clk_100MHz)) then
      if (led_clk_count = 24_999_999) then
        led_clk_count <= 0;
        led_clk <= not led_clk;
      else
        led_clk_count <= led_clk_count + 1;
      end if;
    end if;
  end process;

  led_clkout <= led_clk;

end architecture;
