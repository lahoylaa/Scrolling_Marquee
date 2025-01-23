----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 11:51:22 PM
-- Design Name: 
-- Module Name: bcd_sevenseg_tb - Behavioral
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
use IEEe.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_sevenseg_tb is
--  Port ( );
end bcd_sevenseg_tb;

architecture Behavioral of bcd_sevenseg_tb is

component bcd_sevenseg
port(
    push_btn : in STD_LOGIC;
    switch : in STD_LOGIC_VECTOR (3 downto 0);
    segment_out : out STD_LOGIC_VECTOR (6 downto 0)
);
end component;

signal push_btn : STD_LOGIC := '0';
signal switch : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal segment_out : STD_LOGIC_VECTOR (6 downto 0);

begin
M1: bcd_sevenseg port map(push_btn => push_btn, switch => switch, segment_out => segment_out);
stim_proc: process
begin
    wait for 100 ns;
    wait for 10 ns;
    switch <= "0001";
    wait for 100 ns;
    push_btn <= '1';
    wait for 100 ns;
    push_btn <= '0';
    wait;
end process;

end Behavioral;
