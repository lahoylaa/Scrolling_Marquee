----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2025 08:38:01 AM
-- Design Name: 
-- Module Name: active_digit_tb - Behavioral
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

entity active_digit_tb is
end entity;

architecture Behavioral of active_digit_tb is

  -- Component
  component active_digit_decoder
    port (
      fast_clk, rst_btnC : in  STD_LOGIC;
      active_digit       : out INTEGER range 0 to 7
    );
  end component;

  signal fast_clk, rst_btnC  : STD_LOGIC := '0';
  signal active_digit_signal : INTEGER range 0 to 7;

  -- Monitor procedure
  procedure Monitor(ShouldBe : in INTEGER) is
    variable lout : line;
  begin
    WRITE(lout, NOW, right, 10, ns);
    WRITE(lout, string'(" fast_clk --> "));
    WRITE(lout, fast_clk);
    WRITE(lout, string'(" rst_btnC --> "));
    WRITE(lout, rst_btnC);
    WRITE(lout, string'(" Expected (active_digit) --> "));
    WRITE(lout, ShouldBe); -- Expected active digit
    WRITE(lout, string'(" active_digit --> "));
    WRITE(lout, active_digit_signal); -- Measured active_digit
    WRITELINE(OUTPUT, lout);
    assert active_digit_signal = ShouldBe report "Test Failed (active_digit mismatch)" severity FAILURE;
  end procedure;

begin
  S1: active_digit_decoder
    port map (
      fast_clk     => fast_clk,
      rst_btnC     => rst_btnC,
      active_digit => active_digit_signal
    );

  stim_proc: process
  begin
    wait for 100 ns;
    report "Beginning the Active Digit Testbench" severity NOTE;

    -- Test case 1 : Initial values
    fast_clk <= '0';
    rst_btnC <= '0';
    wait for 1 ns;
    Monitor(0); -- Calling procedure Monitor

    -- Test case 2 : fast_clk high
    fast_clk <= '1';
    rst_btnC <= '0';
    wait for 1 ns;
    Monitor(1); -- Calling procedure Monitor

    -- Test case 3: fast_clk remains high
    fast_clk <= '1';
    rst_btnC <= '0';
    wait for 1 ns;
    Monitor(1); -- Calling procedure Monitor

    -- Test case 4: fast_clk low
    fast_clk <= '0';
    rst_btnC <= '0';
    wait for 1 ns;
    Monitor(1); -- Calling procedure Monitor

    -- Test case 5: rst_btnC high
    fast_clk <= '0';
    rst_btnC <= '1';
    wait for 1 ns;
    Monitor(0); -- Calling procedure Monitor

    -- Test case 6: Force Failure
    fast_clk <= '1';
    rst_btnC <= '1';
    wait for 1 ns;
    Monitor(3); -- Calling procedure Monitor

    wait;
  end process;

end architecture;
