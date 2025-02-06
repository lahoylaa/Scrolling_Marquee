----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2025 02:57:04 PM
-- Design Name: 
-- Module Name: btn_debouncer_tb - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
  use std.textio.all;
  use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity btn_debouncer_tb is
--  Port ( );
end btn_debouncer_tb;

architecture Behavioral of btn_debouncer_tb is

component btn_debouncer
  port (
    btn_in  : in  STD_LOGIC;
    clk     : in  STD_LOGIC;
    reset   : in  STD_LOGIC;
    btn_out : out STD_LOGIC
  );
  end component;

signal btn_in, clk, reset, btn_out_signal : std_logic;

  -- Monitor procedure
  procedure Monitor(ShouldBe : in STD_LOGIC) is
    variable lout : line;
  begin
    WRITE(lout, NOW, right, 10, ns);
    WRITE(lout, string'(" btn_in --> "));
    WRITE(lout, btn_in);
    WRITE(lout, string'(" clk --> "));
    WRITE(lout, clk);
       WRITE(lout, string'(" reset --> "));
    WRITE(lout, reset);
    WRITE(lout, string'(" Expected (btn_out) --> "));
    WRITE(lout, ShouldBe); -- Expected active digit
    WRITE(lout, string'(" btn_out --> "));
    WRITE(lout, btn_out_signal); -- Measured active_digit
    WRITELINE(OUTPUT, lout);
    assert btn_out_signal = ShouldBe report "Test Failed (btn_out mismatch)" severity FAILURE;
  end procedure;

begin
B1: btn_debouncer
port map (
    btn_in => btn_in,
    clk => clk,
    reset => reset,
    btn_out => btn_out_signal
);

stim_proc: process
begin
wait for 100 ns;
report "Beginning the Button Debouncer Testbench" severity NOTE;

-- Test case 1 : Initial Values
btn_in <= '0';
clk <= '0';
reset <= '0';
wait for 10 ns;
Monitor('0');

-- Test case 2 : Button Input
btn_in <= '1';
clk <= '1';
reset <= '0';
wait for 10 ns;
Monitor('1');

-- Test case 3 : Reset
btn_in <= '1';
clk <= '1';
reset <= '1';
wait for 10 ns;
Monitor('0');

-- Test case 4 : Force Fail
btn_in <= '1';
clk <= '1';
reset <= '1';
wait for 10 ns;
Monitor('1');

wait;
end process;

end Behavioral;
