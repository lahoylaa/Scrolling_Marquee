----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2025 09:18:28 PM
-- Design Name: 
-- Module Name: switch_decoder - Behavioral
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

entity switch_decoder is
--  Port ( );
Port(
    switch : in STD_LOGIC_VECTOR(3 downto 0);
    btnIn : in STD_LOGIC;
    lock : out STD_LOGIC
);
end switch_decoder;

architecture Behavioral of switch_decoder is

constant CODE : std_logic_vector(3 downto 0) := "1010";
signal lock_signal : std_logic := '1'; -- 1 = lock 0 = unlock

begin
process(switch, btnIn)
begin
if(btnIn = '1') then
    case switch is
    when CODE => lock_signal <= '0';
    when others => lock_signal <= '1';
    end case;
end if;
end process;

lock <= lock_signal;

end Behavioral;
