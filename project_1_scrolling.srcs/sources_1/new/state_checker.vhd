----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2025 01:09:49 AM
-- Design Name: 
-- Module Name: state_checker - Behavioral
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

entity state_checker is
  --  Port ( );
  port (
    slow_clk      : in  STD_LOGIC;
    rst_btnC      : in  STD_LOGIC;
    lock          : in  STD_LOGIC;
    scroll_pos    : in  INTEGER range 0 to 18;
    current_state : out INTEGER range 0 to 2
  );
end entity;

architecture Behavioral of state_checker is

  constant ENTER : integer := 0;
  constant PASS  : integer := 1;
  constant FAIL  : integer := 2;

  signal temp_state        : integer range 0 to 2 := ENTER; -- Initially ENTER
  signal lock_prev         : std_logic            := '1';   -- Track previous lock state
  signal check_lock_change : std_logic            := '0';   -- Detect lock state change

begin
  process (slow_clk)
  begin

    if (rst_btnC = '1') then
      temp_state <= 0;
      lock_prev <= '1';
      check_lock_change <= '0';

    elsif (slow_clk'event and rising_edge(slow_clk)) then
      -- Detect lock state change
      if (temp_state = ENTER and lock /= lock_prev) then
        check_lock_change <= '1';
      end if;
      lock_prev <= lock; -- Update previous lock state

      case temp_state is
        when ENTER => -- ENTER CODE (default state)
          if (check_lock_change = '1' and scroll_pos = 18) then
            if (lock = '1') then
              temp_state <= 2; -- FAIL state
            else
              temp_state <= 1; -- PASS state
            end if;
            check_lock_change <= '0'; -- Reset after transition
          end if;

        when PASS => -- PASS state
          if (scroll_pos = 18) then
            temp_state <= 0; -- Return to ENTER CODE
            check_lock_change <= '0'; -- Reset lock tracking
          end if;

        when FAIL => -- FAIL state
          if (scroll_pos = 18) then
            temp_state <= 0; -- Return to ENTER CODE
            check_lock_change <= '0'; -- Reset lock tracking
          end if;

      end case;
    end if;

  end process;

  current_state <= temp_state;
end architecture;
