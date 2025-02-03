----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2025 01:05:15 PM
-- Design Name: 
-- Module Name: led_decoder - Behavioral
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

entity led_decoder is
  --  Port ( );
  port (
    lock     : in  STD_LOGIC;
    led_clk  : in  STD_LOGIC;
    --progress_state : in  STD_LOGIC;
    led_data : out STD_LOGIC_VECTOR(5 downto 0)
  );
end entity;

architecture Behavioral of led_decoder is

  signal temp_led_data : std_logic_vector(5 downto 0);
  signal blink_state   : std_logic := '0';
  signal lock_prev     : std_logic := '1';
  signal delay_counter : integer range 0 to 12;
  signal delay_state   : std_logic := '0';

begin
  process (led_clk, lock)
  begin

    -- blink the leds
    if (led_clk'event and rising_edge(led_clk)) then
      blink_state <= not blink_state;

      if (lock /= lock_prev) then
        delay_state <= '1';
        delay_counter <= 0;
      end if;

      if (delay_state = '1') then
        if (delay_counter < 11) then
          delay_counter <= delay_counter + 1;
          temp_led_data <= "001001"; -- Blue leds
        else
          delay_state <= '0';
        end if;

      elsif (lock = '1') then
        temp_led_data <= "100100"; -- Red leds
      else
        temp_led_data <= "010010"; -- Green leds
      end if;

      if (blink_state = '0') then
        temp_led_data <= "000000";
      end if;

      lock_prev <= lock;
    end if;

  end process;

  led_data <= temp_led_data;

end architecture;
