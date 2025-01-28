----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 08:14:45 PM
-- Design Name: 
-- Module Name: bcd_sevenseg - Behavioral
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

entity bcd_sevenseg is
--  Port ( );
port(
    push_btn : in STD_LOGIC;
    switch : in STD_LOGIC_VECTOR (3 downto 0);
    segment_out : out STD_LOGIC_VECTOR (6 downto 0)
);

end bcd_sevenseg;

architecture Behavioral of bcd_sevenseg is

signal temp : std_logic_vector (6 downto 0) := "1111111";
--signal dispVal : std_logic_vector (3 downto 0);

begin
 process(push_btn, switch)
  begin
  if(push_btn = '1') then
    case switch is -- change this to switch the bits they are reversed
      when "0000" => temp <= "0001000"; -- A
      when "0001" => temp <= "0000110"; -- E
      when "0010" => temp <= "0000111"; -- r
      when "0011" => temp <= "1000000"; -- O
      when "0100" => temp <= "0101011"; -- n
      when "0101" => temp <= "1111111"; -- _
      when "0110" => temp <= "1000111"; -- L
      when "0111" => temp <= "0001000"; -- A
      when "1000" => temp <= "0001001"; -- H
      when "1001" => temp <= "1000000"; -- O
      when "1010" => temp <= "0010001"; -- y
      when "1011" => temp <= "1000111"; -- L
      when "1100" => temp <= "0001000"; -- A
      when "1101" => temp <= "0001001"; -- H
      when "1110" => temp <= "1000000"; -- 0
      when "1111" => temp <= "0010001"; -- y
      
        --when "0000" => temp <= "1000000"; --0
        --when "0001" => temp <= "1111001"; --1
        --when "0010" => temp <= "0100100"; --2
        --when "0011" => temp <= "0110000"; --3
        --when "0100" => temp <= "0011001"; --4
        --when "0101" => temp <= "0010010"; --5
        --when "0110" => temp <= "0000010"; --6
        --when "0111" => temp <= "1111000"; --7
        --when "1000" => temp <= "0000000"; --8
        --when "1001" => temp <= "0011000"; --9
        --when "1010" => temp <= "0001000"; --A
        --when "1011" => temp <= "0000011"; --B trying with b (lowercase)
        --when "1100" => temp <= "1000110"; --C
        --when "1101" => temp <= "0100001"; --D trying with d (lowercase)
        --when "1110" => temp <= "0000110"; --E
        --when "1111" => temp <= "0001110"; --F
        --when others => temp <= "1010101"; --NULL
    end case;
  end if;
 end process;

segment_out <= temp;
  
end Behavioral;
