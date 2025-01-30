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

entity active_digit_tb is
--  Port ( );
end active_digit_tb;

architecture Behavioral of active_digit_tb is

-- Component
COMPONENT active_digit_decoder
PORT(fast_clk, rst_btnC : in STD_LOGIC; active_digit : out INTEGER range 0 to 7);
end COMPONENT;

signal fast_clk, rst_btnC : STD_LOGIC := '0';
signal active_digit_signal : INTEGER range 0 to 7;

-- Monitor procedure
PROCEDURE Monitor(ShouldBe: in INTEGER) is
VARIABLE lout : line;
begin
WRITE(lout, NOW, right, 10, ns);
WRITE(lout, string'("fast_clk -->"));
WRITE(lout, fast_clk);
WRITE(lout, string'("rst_btnC -->"));
WRITE(lout, rst_btnC);
WRITE(lout, string'("active_digit -->"));
WRITE(lout, active_digit_signal);
WRITELINE(OUTPUT, lout);
ASSERT active_digit_signal = ShouldBe REPORT "Test Failed" SEVERITY FAILURE;
end Monitor;

begin
S1: active_digit_decoder PORT MAP(fast_clk => fast_clk, rst_btnC => rst_btnC, active_digit => active_digit_signal);
stim_proc: process
begin
wait for 100 ns;
REPORT "Beginning the Scroll Position test" SEVERITY NOTE;

fast_clk <= '0'; rst_btnC <= '0';
wait for 1 ns;
Monitor(0); -- Calling procedure Monitor

fast_clk <= '1'; rst_btnC <= '0';
wait for 1 ns;
Monitor(1); -- Calling procedure Monitor

fast_clk <= '1'; rst_btnC <= '0';
wait for 1 ns;
Monitor(0); -- Calling procedure Monitor

fast_clk <= '1'; rst_btnC <= '1';
wait for 1 ns;
Monitor(1); -- Calling procedure Monitor
wait;

end process;

end Behavioral;
