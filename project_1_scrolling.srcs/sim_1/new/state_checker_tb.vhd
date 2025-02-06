----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2025 02:57:26 PM
-- Design Name: 
-- Module Name: state_checker_tb - Behavioral
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

entity state_checker_tb is
  --  Port ( );
end entity;

architecture Behavioral of state_checker_tb is

  component state_checker
    port (
      slow_clk      : in  STD_LOGIC;
      rst_btnC      : in  STD_LOGIC;
      lock          : in  INTEGER range 0 to 17;
      scroll_pos    : in  INTEGER range 0 to 18;
      current_state : out INTEGER range 0 to 2
    );
  end component;

  signal slow_clk, rst_btnC   : std_logic;
  signal lock                 : integer range 0 to 17;
  signal scroll_pos           : integer range 0 to 18;
  signal current_state_signal : integer range 0 to 2;

  -- Monitor procedure
  procedure Monitor(ShouldBe : in INTEGER) is
    variable lout : line;
  begin
    WRITE(lout, NOW, right, 10, ns);
    WRITE(lout, string'(" slow_clk --> "));
    WRITE(lout, slow_clk);
    WRITE(lout, string'(" rst_btnC --> "));
    WRITE(lout, rst_btnC);
    WRITE(lout, string'(" lock --> "));
    WRITE(lout, lock);
    WRITE(lout, string'(" scroll_pos --> "));
    WRITE(lout, scroll_pos);
    WRITE(lout, string'(" Expected (current_state) --> "));
    WRITE(lout, ShouldBe); -- Expected scroll_pos
    WRITE(lout, string'(" current_state --> "));
    WRITE(lout, current_state_signal); -- Measured scroll_pos
    WRITELINE(OUTPUT, lout);
    assert current_state_signal = ShouldBe report "Test Failed (current_state mismatch)" severity FAILURE;
  end procedure;

begin
  S1: state_checker
    port map (
      slow_clk      => slow_clk,
      rst_btnC      => rst_btnC,
      lock          => lock,
      scroll_pos    => scroll_pos,
      current_state => current_state_signal
    );

  stim_proc: process
  begin
    wait for 100 ns;
    report "Beginning the State Checker Testbench" severity NOTE;

    -- Test case 1 : Initial values
    slow_clk <= '0';
    rst_btnC <= '0';
    lock <= 0;
    scroll_pos <= 0;
    wait for 10 ns;
    Monitor(0);

    -- Test case 2 : ENTER State
    slow_clk <= '1';
    rst_btnC <= '0';
    lock <= 0;
    scroll_pos <= 0;
    wait for 10 ns;
    Monitor(0);

    -- Test case 3 : PASS State
    slow_clk <= '0';
    rst_btnC <= '0';
    lock <= 0;
    scroll_pos <= 0;
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '1';
    rst_btnC <= '0';
    lock <= 1;
    scroll_pos <= 18;
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '0';
    rst_btnC <= '0';
    lock <= 1;
    scroll_pos <= 0;
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '1';
    rst_btnC <= '0';
    lock <= 1;
    scroll_pos <= 18;
    wait for 10 ns;
    Monitor(1);

    -- Test case 4 : FAIL State
    slow_clk <= '0';
    rst_btnC <= '0';
    lock <= 0;
    scroll_pos <= 0;
    wait for 10 ns;
    Monitor(1);

    slow_clk <= '1';
    rst_btnC <= '0';
    lock <= 0;
    scroll_pos <= 18;
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '0';
    rst_btnC <= '0';
    lock <= 2;
    scroll_pos <= 0;
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '1';
    rst_btnC <= '0';
    lock <= 2;
    scroll_pos <= 18;
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '0';
    rst_btnC <= '0';
    lock <= 2;
    scroll_pos <= 0;
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '1';
    rst_btnC <= '0';
    lock <= 2;
    scroll_pos <= 18;
    wait for 10 ns;
    Monitor(2);

    -- Test case 5 : Reset
    slow_clk <= '0';
    rst_btnC <= '1';
    lock <= 1;
    scroll_pos <= 18;
    wait for 10 ns;
    Monitor(0);

    -- Test case 6 : Force Fail 
    slow_clk <= '1';
    rst_btnC <= '1';
    lock <= 1;
    scroll_pos <= 18;
    wait for 10 ns;
    Monitor(2);

    wait;
  end process;
end architecture;
