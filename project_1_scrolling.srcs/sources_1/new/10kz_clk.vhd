----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 07:46:49 PM
-- Design Name: 
-- Module Name: 10kz_clk - Behavioral
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

entity ten_khz_clk is
--  Port ( );
Port(
    clk_100MHz : in STD_LOGIC;
    rst_btnC : in STD_LOGIC;
    fast_clkout : out STD_LOGIC
);
end ten_khz_clk;

architecture Behavioral of ten_khz_clk is

signal fast_clk_count : integer range 0 to 100_000 := 0;
signal fast_clk : std_logic;

begin
  -- Fast Clock for Multiplexing
  process (clk_100MHz, rst_btnC)
  begin
    if rst_btnC = '1' then
      fast_clk_count <= 0;
      fast_clk <= '0';
    elsif rising_edge(clk_100MHz) then
      if fast_clk_count = 99_999 then
        fast_clk_count <= 0;
        fast_clk <= not fast_clk;
      else
        fast_clk_count <= fast_clk_count + 1;
      end if;
    end if;
  end process;

fast_clkout <= fast_clk;

end Behavioral;
