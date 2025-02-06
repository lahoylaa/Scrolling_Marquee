----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2025 08:51:08 PM
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
  use IEEE.STD_LOGIC_1164.all;

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --use IEEE.NUMERIC_STD.ALL;
  -- Uncomment the following library declaration if instantiating
  -- any Xilinx leaf cells in this code.
  --library UNISIM;
  --use UNISIM.VComponents.all;

entity switch_decoder is
  --  Port ( );
  port (
    switch : in  STD_LOGIC_VECTOR(3 downto 0);
    btnS   : in  STD_LOGIC;
    lock   : out INTEGER range 0 to 17
  );
end entity;

architecture Behavioral of switch_decoder is

  signal temp : integer range 0 to 17;

begin
  process (switch, btnS)
  begin
    if (btnS = '1') then
      case switch is
        when "0000" => temp <= 2;
        when "0001" => temp <= 3; 
        when "0010" => temp <= 4;
        when "0011" => temp <= 5;
        when "0100" => temp <= 6;
        when "0101" => temp <= 7;
        when "0110" => temp <= 8;
        when "0111" => temp <= 9;
        when "1000" => temp <= 10;
        when "1001" => temp <= 1; -- unlock everything else locked
        when "1010" => temp <= 12;
        when "1011" => temp <= 13;
        when "1100" => temp <= 14;
        when "1101" => temp <= 15;
        when "1110" => temp <= 16;
        when "1111" => temp <= 17;
        when others => temp <= 0;
      end case;
    end if;
  end process;

  lock <= temp;

end architecture;
