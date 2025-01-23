----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 11:36:56 PM
-- Design Name: 
-- Module Name: multiplexer - Behavioral
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

entity multiplexer is
--  Port ( );
port(
    Seg_select : in STD_LOGIC_VECTOR (1 downto 0);
    LeftSeg : in STD_LOGIC_VECTOR (6 downto 0);
    RightSeg : in STD_LOGIC_VECTOR (6 downto 0);
    Anode_out : out STD_LOGIC_VECTOR (3 downto 0);
    Seg_out : out STD_LOGIC_VECTOR (6 downto 0) 
);

end multiplexer;

architecture Behavioral of multiplexer is

signal segment : std_logic_vector (6 downto 0);
signal anode : std_logic_vector (3 downto 0);

begin
 process(Seg_select)
 begin
 case Seg_select is
    when "00" => segment <= "1111111"; anode <= "1110";
    when "01" => segment <= "1111111"; anode <= "1101";
    when "10" => segment <= LeftSeg; anode <= "1011";
    when "11" => segment <= RightSeg; anode <= "0111";
 end case;
 end process;

 Seg_out <= segment;
 Anode_out <= anode;

end Behavioral;
