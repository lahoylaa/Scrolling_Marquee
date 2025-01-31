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

entity seven_segment_mux_tb is
  --  Port ( );
end entity;

architecture Behavioral of seven_segment_mux_tb is

  -- Compenent
  component seven_seg_mux
    port (
      active_digit : in  INTEGER range 0 to 7;
      scroll_pos   : in  INTEGER range 0 to 23;
      seg_an       : out std_logic_vector(7 downto 0);
      seg_data     : out std_logic_vector(15 downto 0)
    );
  end component;

  signal active_digit    : INTEGER range 0 to 7  := 0;
  signal scroll_pos      : INTEGER range 0 to 23 := 0;
  signal seg_an_signal   : std_logic_vector(7 downto 0);
  signal seg_data_signal : std_logic_vector(15 downto 0);

  -- Monitor procedure FIX THIS
  procedure Monitor(ShouldBeAn : in std_logic_vector(7 downto 0); ShouldBeData : in std_logic_vector(15 downto 0)) is
    variable lout : line;
  begin
    WRITE(lout, NOW, right, 10, ns);
    WRITE(lout, string'(" active_digit --> "));
    WRITE(lout, active_digit);
    WRITE(lout, string'(" scroll_pos --> "));
    WRITE(lout, scroll_pos);
    WRITE(lout, string'(" Expected (seg_an) --> "));
    WRITE(lout, ShouldBeAn); -- Expected `seg_an`
    WRITE(lout, string'(" Expected (seg_data) --> "));
    WRITE(lout, ShouldBeData); -- Expected `seg_data`
    WRITE(lout, string'(" seg_an  --> "));
    WRITE(lout, seg_an_signal); -- Measured 'seg_an'
    WRITE(lout, string'(" seg_data --> "));
    WRITE(lout, seg_data_signal); -- Measure 'seg_data'
    WRITELINE(OUTPUT, lout);

    -- Check if outputs match expected values
    assert seg_an_signal = ShouldBeAn report "Test Failed (seg_an mismatch)" severity FAILURE;
    assert seg_data_signal = ShouldBeData report "Test Failed (seg_data mismatch)" severity FAILURE;
  end procedure;

begin

  M1: seven_seg_mux
    port map (
      active_digit => active_digit,
      scroll_pos   => scroll_pos,
      seg_an       => seg_an_signal,
      seg_data     => seg_data_signal
    );

  stim_proc: process
  begin
    wait for 100 ns;
    report "Starting Seven Segment MUX Testbench" severity NOTE;

    -- Test case 1: Normal operation, active_digit = 0
    active_digit <= 0;
    scroll_pos <= 0;
    wait for 100 ns;
    Monitor("11111110", "1111111111111111");

    -- Test case 2: Changing active digit
    active_digit <= 1;
    scroll_pos <= 0;
    wait for 100 ns;
    Monitor("11111101", "1111111111111111"); 

    -- Test case 3: Changing scroll pos
    active_digit <= 0;
    scroll_pos <= 15;
    wait for 100 ns;
    Monitor("11111110", "1111111110001000");

    -- Test case 4: Force Failure
    active_digit <= 1;
    scroll_pos <= 15;
    wait for 100 ns;
    Monitor("11111110", "1111111110001000");

    wait;
  end process;

end architecture;
