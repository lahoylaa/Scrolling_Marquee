----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2025 11:57:50 PM
-- Design Name: 
-- Module Name: scroll_pos_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;e:\Projects\FPGA\Scrolling_Marquee\project_1_scrolling.srcs\sim_1\new\scroll_pos_tb.vhd

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scroll_pos_tb is
--  Port ( );
end scroll_pos_tb;

architecture Behavioral of scroll_pos_tb is

-- Compenent
COMPONENT scroll_pos_decoder
PORT(slow_clk, rst_btnC, btnU : in STD_LOGIC; scroll_pos : out INTEGER range 0 to 23);
end COMPONENT;

signal slow_clk, rst_btnC, btnU : STD_LOGIC := '0';
signal scroll_pos_signal : INTEGER range 0 to 23;

-- Monitor procedure
PROCEDURE Monitor(ShouldBe: in INTEGER) is
VARIABLE lout : line;
begin
WRITE(lout, NOW, right, 10, ns);
WRITE(lout, string'("slow_clk -->"));
WRITE(lout, slow_clk);
WRITE(lout, string'("rst_btnC -->"));
WRITE(lout, rst_btnC);
WRITE(lout, string'("btnU -->"));
WRITE(lout, btnU);
WRITE(lout, string'("scroll_pos -->"));
WRITE(lout, scroll_pos_signal);
WRITELINE(OUTPUT, lout);
ASSERT scroll_pos_signal = ShouldBe REPORT "Test Failed" SEVERITY FAILURE;
end Monitor;

begin
S1: scroll_pos_decoder PORT MAP(slow_clk => slow_clk, rst_btnC => rst_btnC, btnU => btnU, scroll_pos => scroll_pos_signal);
stim_proc: process
begin
wait for 100 ns;
REPORT "Beginning the Scroll Position test" SEVERITY NOTE;

slow_clk <= '0'; rst_btnC <= '0'; btnU <= '0';
wait for 1 ns;
Monitor(0); -- Calling procedure Monitor

slow_clk <= '1'; rst_btnC <= '0'; btnU <= '0';
wait for 1 ns;
Monitor(1); -- Calling procedure Monitor

slow_clk <= '1'; rst_btnC <= '0'; btnU <= '1';
wait for 1 ns;
Monitor(0); -- Calling procedure Monitor

slow_clk <= '1'; rst_btnC <= '1'; btnU <= '1';
wait for 1 ns;
Monitor(1); -- Calling procedure Monitor
wait;

end process;
end Behavioral;
