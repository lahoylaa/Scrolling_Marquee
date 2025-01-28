----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2025 07:50:53 PM
-- Design Name: 
-- Module Name: disp_counter - Behavioral
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

entity disp_counter is
--  Port ( );
Port(
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    dispVal : out STD_LOGIC_VECTOR(3 downto 0)
);
end disp_counter;

architecture Behavioral of disp_counter is

signal count : std_logic_vector(6 downto 0);
signal trigger : std_logic_vector(3 downto 0);

begin
process(clk)
begin
if(reset) then
trigger <= '0';
count <= "0000000";
elsif(clk'event and rising_edge(clk)) then
if (count = 125) then
 count <= "0000000";
 trigger <= trigger + 1;
else
 count <= count + 1;
end if;
end if;
end process;

dispVal <= trigger;


end Behavioral;
