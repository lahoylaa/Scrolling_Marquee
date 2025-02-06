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
  use IEEE.NUMERIC_STD.all;

entity led_decoder is
  port (
    lock       : in  INTEGER range 0 to 17;
    led_clk    : in  STD_LOGIC;
    scroll_pos : in  INTEGER range 0 to 18; -- Now integer to track scrolling
    state      : in  INTEGER range 0 to 2;
    led_data   : out STD_LOGIC_VECTOR(5 downto 0)
  );
end entity;

architecture Behavioral of led_decoder is

  -- Define States
  constant ENTER : integer := 0;
  constant PASS  : integer := 1;
  constant FAIL  : integer := 2;

  -- Define Colors
  constant BLUE   : std_logic_vector(5 downto 0) := "001001";
  constant RED    : std_logic_vector(5 downto 0) := "100100";
  constant GREEN  : std_logic_vector(5 downto 0) := "010010";
  constant OFF    : std_logic_vector(5 downto 0) := "000000";
  constant PURPLE : std_logic_vector(5 downto 0) := std_logic_vector(unsigned(BLUE) or unsigned(RED));

  -- Internal Signals
  signal temp_led_data     : std_logic_vector(5 downto 0) := OFF;
  signal blink_state       : std_logic := '0';
  signal lock_prev         : integer range 0 to 17 := 0;
  signal transition_active : std_logic := '0';

begin
  process (led_clk)
  begin
    if rising_edge(led_clk) then
      blink_state <= not blink_state;

      -- Detect lock state change to start transition blinking
      if (lock /= lock_prev and state = 0) then
        transition_active <= '1'; -- Activate transition blinking
      end if;

      -- Stop transition blinking when ENTER sequence finishes
      if scroll_pos = 18 then
        transition_active <= '0';
      end if;

      -- Handle LED colors based on state
      if transition_active = '1' then

        if (blink_state = '1') then
          temp_led_data <= BLUE;
        else
          temp_led_data <= OFF;
        end if;

      else
        case state is
          when ENTER =>

            if (blink_state = '1') then
              temp_led_data <= PURPLE; -- ENTER (idle) state
            else
              temp_led_data <= OFF;
            end if;
          when PASS =>
            if (blink_state = '1') then
              temp_led_data <= GREEN; -- PASS (blinking green)
            else
              temp_led_data <= OFF;
            end if;
          when FAIL =>

            if (blink_state = '1') then
              temp_led_data <= RED; -- FAIL (blinking red)
            else
              temp_led_data <= OFF;
            end if;

          when others => temp_led_data <= OFF;
        end case;
      end if;

      -- -- Blink LEDs
      -- if (blink_state = '1') then
      --   temp_led_data <= temp_led_data;
      -- else
      --   temp_led_data <= OFF;
      -- end if;
      -- Update the prev lock
      lock_prev <= lock;
    end if;
  end process;

  -- Output LED Data
  led_data <= temp_led_data;

end architecture;
