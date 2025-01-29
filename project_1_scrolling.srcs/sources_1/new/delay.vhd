----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2025 09:52:23 AM
-- Design Name: 
-- Module Name: delay - Behavioral
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
  use IEEE.STD_LOGIC_ARITH.all;
  use IEEE.STD_LOGIC_UNSIGNED.all;
  use IEEE.numeric_std.all;

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --use IEEE.NUMERIC_STD.ALL;
  -- Uncomment the following library declaration if instantiating
  -- any Xilinx leaf cells in this code.
  --library UNISIM;
  --use UNISIM.VComponents.all;

entity delay is
  --  Port ( );
  port (
    clk_100MHz   : in  STD_LOGIC;
    scroll_pos   : in  INTEGER range 0 to 15;
    active_digit : in  INTEGER range 0 to 7;
    delay_active : out STD_LOGIC
  );
end entity;

architecture Behavioral of delay is

  signal delay_counter : integer range 0 to 199_999_999 := 0;
  signal delay_flag    : std_logic                      := '0';

begin

  process (clk_100MHz)
  begin
    if rising_edge(clk_100MHz) then
      if (scroll_pos = 15 and active_digit = 7) then
        delay_flag <= '1';
        delay_counter <= 0;
      end if;

      if (delay_flag = '1') then
        if (delay_counter < 199_999_999) then
          delay_counter <= delay_counter + 1;
        else
          delay_flag <= '0';
        end if;
      end if;
    end if;
  end process;

  delay_active <= delay_flag;

end architecture;
