----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/03/2025 01:50:19 AM
-- Design Name: 
-- Module Name: sequence_checker - Behavioral
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

entity sequence_checker is
  --  Port ( );
  port (
    scroll_pos     : in  INTEGER range 0 to 18;
    lock           : in  STD_LOGIC;
    sequence_state : out std_logic
   -- progress_state : out STD_LOGIC
  );
end entity;

architecture Behavioral of sequence_checker is
  signal current_mode  : std_logic := '1'; -- initially in a lock state
  --signal current_mode : integer range 0 to 2;
  signal sequence_done : std_logic := '0';
  signal lock_temp_state : std_logic := '1'; -- initially in lock state
  signal progress : std_logic := '0';
  signal pending_lock    : std_logic := '1'; -- Stores the new lock request

begin
  process (scroll_pos, lock)
  begin

  if(lock /= lock_temp_state) then
    pending_lock <= lock;
  end if;

    if (scroll_pos = 18) then
      sequence_done <= '1';
      --progress <= '0';
    end if;

    if (sequence_done = '1') then
      current_mode <= pending_lock;
      lock_temp_state <= pending_lock;
      sequence_done <= '0';
    end if;

    lock_temp_state <= lock;
  end process;

  sequence_state <= current_mode;
  --progress_state <= progress;

end architecture;
