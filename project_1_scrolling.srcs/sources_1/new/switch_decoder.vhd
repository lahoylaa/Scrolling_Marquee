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
    lock   : out STD_LOGIC
  );
end entity;

architecture Behavioral of switch_decoder is

  constant CODE : std_logic_vector(3 downto 0) := "1001";
  signal lock_signal : std_logic := '1';

begin
  process(switch, btnS)
  begin
    if (btnS = '1') then
      case switch is
        when CODE => lock_signal <= '0'; -- unlocked
        when others => lock_signal <= '1';
      end case;
    end if;
  end process;

  lock <= lock_signal;

end architecture;
