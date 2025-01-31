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
    scroll_pos   : in  INTEGER range 0 to 31;
    active_digit : in  INTEGER range 0 to 7;
    delay_active : out STD_LOGIC;
    full_off : out STD_LOGIC
  );
end entity;

architecture Behavioral of delay is

  signal delay_counter : integer range 0 to 199_999_999 := 0;
  signal delay_flag    : std_logic                      := '0';
  signal full_off_flag : std_logic := '0';

begin

  -- Delay Control Process
  process (clk_100MHz)
  begin
    if rising_edge(clk_100MHz) then
      if (scroll_pos = 31 and active_digit = 0) then
        delay_flag <= '1'; -- Start the 2-second blank delay
        delay_counter <= 0;
      elsif delay_flag = '1' then
        if delay_counter < 199_999_999 then -- counts to 2s
          delay_counter <= delay_counter + 1;
        else
          delay_flag <= '0';
          full_off_flag <= '1'; -- Turn everything off before restart
        end if;
      elsif full_off_flag = '1' then
        full_off_flag <= '0'; -- Reset and allow smooth restart
      end if;
    end if;
  end process;

  delay_active <= delay_flag;
  full_off <= full_off_flag;

end architecture;
