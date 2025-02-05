----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 06:44:11 PM
-- Design Name: 
-- Module Name: clk_divide_125Hz - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_divide_125Hz is
--  Port ( );
port(
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    clkout : out STD_LOGIC
);

end clk_divide_125Hz;

architecture Behavioral of clk_divide_125Hz is

signal count : std_logic_vector (19 downto 0); -- 20 bits
signal clk_temp : std_logic;

begin
    process(clk, reset)
     begin
      if(reset = '1') then
        count <= "00000000000000000000";
        clk_temp <= '0';
      elsif(clk'event and rising_edge(clk)) then
        if(count = 200000) then
            count <= "00000000000000000000";
            clk_temp <= not clk_temp;
        else
            count <= count + 1;
            clk_temp <= clk_temp;
        end if;
      end if;
    end process;

clkout <= clk_temp;

end Behavioral;