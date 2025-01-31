----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2025 10:29:00 AM
-- Design Name: 
-- Module Name: seven_segment_mux_tb - Behavioral
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

entity seven_segment_mux_tb is
--  Port ( );
end seven_segment_mux_tb;

architecture Behavioral of seven_segment_mux_tb is

-- Compenent
COMPONENT seven_segment_mux
PORT(delay_active, full_off : in STD_LOGIC;
active_digit : in INTEGER range 0 to 7;
scroll_pos : in INTEGER range 0 to 23;
seg_an : out std_logic_vector(7 downto 0);
seg_data : out std_logic_vector(15 downto 0)
);
end COMPONENT;

signal delay_active, full_off : STD_LOGIC := '0';
signal active_digit : INTEGER range 0 to 7 := 0;
signal scroll_pos : INTEGER range 0 to 23 := 0;
signal seg_an_signal : std_logic_vector(7 downto 0);
signal seg_data_signal : std_logic_vector(15 downto 0);

-- Monitor procedure FIX THIS
PROCEDURE Monitor(ShouldBeAn: in std_logic_vector(7 downto 0); ShouldBeData: in std_logic_vector(15 downto 0)) is
  VARIABLE lout : line;
begin
  WRITE(lout, NOW, right, 10, ns);
  WRITE(lout, string'(" delay_active --> "));
  WRITE(lout, delay_active);
  WRITE(lout, string'(" full_off --> "));
  WRITE(lout, full_off);
  WRITE(lout, string'(" active_digit --> "));
  WRITE(lout, active_digit);
  WRITE(lout, string'(" scroll_pos --> "));
  WRITE(lout, scroll_pos);
  WRITE(lout, string'(" seg_an --> "));
  WRITE(lout, ShouldBeAn); -- Expected `seg_an`
  WRITE(lout, string'(" seg_data --> "));
  WRITE(lout, ShouldBeData); -- Expected `seg_data`
  WRITELINE(OUTPUT, lout);

  -- Check if outputs match expected values
  ASSERT seg_an_signal = ShouldBeAn REPORT "Test Failed (seg_an mismatch)" SEVERITY FAILURE;
  ASSERT seg_data_signal = ShouldBeData REPORT "Test Failed (seg_data mismatch)" SEVERITY FAILURE;
end Monitor;

begin

M1 : seven_segment_mux PORT MAP(
    delay_active => delay_active,
    full_off => full_off,
    active_digit => active_digit,
    scroll_pos => scroll_pos,
    seg_an => seg_an_signal,
    seg_data => seg_data_signal
);
stim_proc: process 
begin
  wait for 100 ns;
  REPORT "Starting Seven Segment MUX Testbench" SEVERITY NOTE;

  -- Test case 1: Normal operation, active_digit = 0
  delay_active <= '0'; full_off <= '0'; active_digit <= 0; scroll_pos <= 0;
  wait for 5 ns;
  Monitor("00000001", "0000000000000000");  -- Replace expected values as needed

  -- Test case 2: Changing active digit
  active_digit <= 3; scroll_pos <= 5;
  wait for 5 ns;
  Monitor("00001000", "0000000000000000");  -- Replace expected values

  -- Test case 3: Activating delay
  delay_active <= '1';
  wait for 5 ns;
  Monitor("00001000", "1111111111111111");  -- Expected values may vary

  -- Test case 4: Turning off segments
  full_off <= '1';
  wait for 5 ns;
  Monitor("00000000", "1111111111111111");  -- Expected values may vary

  wait;
end process;



end Behavioral;
