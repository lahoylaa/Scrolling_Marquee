----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2025 02:56:07 PM
-- Design Name: 
-- Module Name: led_decoder_tb - Behavioral
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

entity led_decoder_tb is
  --  Port ( );
end entity;

architecture Behavioral of led_decoder_tb is

  -- Component
  component led_decoder
    port (

      lock       : in  INTEGER range 0 to 17;
      led_clk    : in  STD_LOGIC;
      scroll_pos : in  INTEGER range 0 to 18; -- Now integer to track scrolling
      state      : in  INTEGER range 0 to 2;
      led_data   : out STD_LOGIC_VECTOR(5 downto 0)

    );
  end component;

  -- Signals
  signal lock            : integer range 0 to 17;
  signal led_clk         : std_logic;
  signal scroll_pos      : integer range 0 to 18;
  signal state           : integer range 0 to 2;
  signal led_data_signal : std_logic_vector(5 downto 0);

  -- Monitor procedure
  procedure Monitor(ShouldBe : in STD_LOGIC_VECTOR) is
    variable lout : line;
  begin
    WRITE(lout, NOW, right, 10, ns);
    WRITE(lout, string'(" lock --> "));
    WRITE(lout, lock);
    WRITE(lout, string'(" led_clk --> "));
    WRITE(lout, led_clk);
    WRITE(lout, string'(" scroll_pos --> "));
    WRITE(lout, scroll_pos);
    WRITE(lout, string'(" state --> "));
    WRITE(lout, state);
    WRITE(lout, string'(" Expected (led_data) --> "));
    WRITE(lout, ShouldBe); -- Expected active digit
    WRITE(lout, string'(" led_data --> "));
    WRITE(lout, led_data_signal); -- Measured active_digit
    WRITELINE(OUTPUT, lout);
    assert led_data_signal = ShouldBe report "Test Failed (led_data mismatch)" severity FAILURE;
  end procedure;
begin
L1: led_decoder
port map(
    lock => lock,
    led_clk => led_clk,
    scroll_pos => scroll_pos,
    state => state,
    led_data => led_data_signal
);

stim_proc: process
begin 
wait for 100 ns;
report "Beginning the Led Decoder Testbench" severity NOTE;

-- Test case 1 : Initial Values
lock <= 0;
led_clk <= '0';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000000");

-- Test case 2 : Blink PURPLE LEDs (ENTER state)
lock <= 0;
led_clk <= '1';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000000");

lock <= 0;
led_clk <= '0';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000000");

lock <= 0;
led_clk <= '1';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("101101");

-- Test case 3 : Transition Delay (ENTER -> PASS) BLUE LEDs blinking
lock <= 0;
led_clk <= '0';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("101101");

lock <= 1;
led_clk <= '1';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000000");

lock <= 1;
led_clk <= '0';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000000");

lock <= 1;
led_clk <= '1';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("001001");

-- Test case 4 : PASS State (GREEN LEDs Blinking)
lock <= 1;
led_clk <= '0';
scroll_pos <= 18;
state <= 1;
wait for 10 ns;
Monitor("001001");

lock <= 1;
led_clk <= '1';
scroll_pos <= 18;
state <= 1;
wait for 10 ns;
Monitor("000000");

lock <= 1;
led_clk <= '0';
scroll_pos <= 18;
state <= 1;
wait for 10 ns;
Monitor("000000");

lock <= 1;
led_clk <= '1';
scroll_pos <= 18;
state <= 1;
wait for 10 ns;
Monitor("010010");


-- Test case 5 : Transition Delay (ENTER -> FAIL) BLUE LEDs Blinking
lock <= 0;
led_clk <= '0';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("010010");

lock <= 2;
led_clk <= '1';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000000");

lock <= 2;
led_clk <= '0';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000000");

lock <= 2;
led_clk <= '1';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("001001");

-- Test case 6 : FAIL State (RED LEDs Blinking)
lock <= 2;
led_clk <= '0';
scroll_pos <= 18;
state <= 2;
wait for 10 ns;
Monitor("001001");

lock <= 2;
led_clk <= '1';
scroll_pos <= 18;
state <= 2;
wait for 10 ns;
Monitor("000000");

lock <= 2;
led_clk <= '0';
scroll_pos <= 18;
state <= 2;
wait for 10 ns;
Monitor("000000");

lock <= 2;
led_clk <= '1';
scroll_pos <= 18;
state <= 2;
wait for 10 ns;
Monitor("100100");

-- Test case 8 : Force Fail
lock <= 0;
led_clk <= '0';
scroll_pos <= 0;
state <= 0;
wait for 10 ns;
Monitor("000001");

wait;
end process;

end architecture;
