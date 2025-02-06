----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2025 02:56:26 PM
-- Design Name: 
-- Module Name: switch_decoder_tb - Behavioral
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
  use std.textio.all;
  use ieee.std_logic_textio.all;

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --use IEEE.NUMERIC_STD.ALL;
  -- Uncomment the following library declaration if instantiating
  -- any Xilinx leaf cells in this code.
  --library UNISIM;
  --use UNISIM.VComponents.all;

entity switch_decoder_tb is
  --  Port ( );
end entity;

architecture Behavioral of switch_decoder_tb is

  component switch_decoder
    port (
      switch : in  STD_LOGIC_VECTOR(3 downto 0);
      btnS   : in  STD_LOGIC;
      lock   : out INTEGER range 0 to 17
    );
  end component;

  signal switch      : std_logic_vector(3 downto 0);
  signal btnS        : std_logic;
  signal lock_signal : integer range 0 to 17;

  -- Monitor procedure
  procedure Monitor(ShouldBe : in INTEGER) is
    variable lout : line;
  begin
    WRITE(lout, NOW, right, 10, ns);
    WRITE(lout, string'(" switch --> "));
    WRITE(lout, switch);
    WRITE(lout, string'(" btnS --> "));
    WRITE(lout, btnS);
    WRITE(lout, string'(" Expected (lock) --> "));
    WRITE(lout, ShouldBe); -- Expected scroll_pos
    WRITE(lout, string'(" lock_signal --> "));
    WRITE(lout, lock_signal); -- Measured scroll_pos
    WRITELINE(OUTPUT, lout);
    assert lock_signal = ShouldBe report "Test Failed (lock mismatch)" severity FAILURE;
  end procedure;

begin
  SW1: switch_decoder
    port map (
      switch => switch,
      btnS   => btnS,
      lock   => lock_signal
    );

  stim_proc: process
  begin
    wait for 100 ns;
    report "Beginning the Switch Decoder Testbench" severity NOTE;

    -- Test case 1 : Initial value
    switch <= "0000";
    btnS <= '0';
    wait for 10 ns;
    Monitor(0);

    -- Test case 2 : switch input (btnS not pressed)
    switch <= "1111";
    btnS <= '0';
    wait for 10 ns;
    Monitor(0);

    -- Test case 3 : switch input (btnS pressed)
    switch <= "1111";
    btnS <= '1';
    wait for 10 ns;
    Monitor(17);

    -- Test case 4 : Force Fail
    switch <= "1111";
    btnS <= '1';
    wait for 10 ns;
    Monitor(0);

    wait;
  end process;

end architecture;
