----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2025 02:42:07 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
  --  Port ( );
  port (
    SegSelect : in  STD_LOGIC_VECTOR(2 downto 0);
    SegIn     : in  STD_LOGIC_VECTOR(7 downto 0);
    AnodeOut  : out STD_LOGIC_VECTOR(7 downto 0);
    SegOut    : out STD_LOGIC_VECTOR(7 downto 0)
  );
end entity;

architecture Behavioral of mux is

  signal temp : std_logic_vector(7 downto 0);

begin
  process (SegSelect)
  begin
    case SegSelect is
      when "000" => temp <= SegIn;
                    AnodeOut <= "11111110";
      when "001" => temp <= "11111111";
                    AnodeOut <= "11111101";
      when "010" => temp <= SegIn;
                    AnodeOut <= "11111011";
      when "011" => temp <= "11111111";
                    AnodeOut <= "11110111";
      when "100" => temp <= SegIn;
                    AnodeOut <= "11101111";
      when "101" => temp <= "11111111";
                    AnodeOut <= "11011111";
      when "110" => temp <= SegIn;
                    AnodeOut <= "10111111";
      when "111" => temp <= "11111111";
                    AnodeOut <= "01111111";
    end case;

  end process;

  SegOut    <= temp;
  SegOutTwo <= temp;

end architecture;
