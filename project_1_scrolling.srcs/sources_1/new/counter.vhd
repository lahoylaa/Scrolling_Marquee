----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 07:45:44 PM
-- Design Name: 
-- Module Name: two_bit_counter - Behavioral
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

entity counter is
--  Port ( );
port(
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    count : out STD_LOGIC_VECTOR (3 downto 0)
);

end counter;

architecture Behavioral of counter is

signal temp : std_logic_vector (3 downto 0);

begin
    process(clk, reset)
     begin
      if(reset = '1') then
        temp <= "0000";
      elsif(clk'event and rising_edge(clk)) then
        temp <= temp + 1;
      end if;
    end process;
count <= temp;
end Behavioral;
