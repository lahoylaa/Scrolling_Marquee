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
  use IEEE.STD_LOGIC_1164.all;
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
end entity;

architecture Behavioral of scroll_pos_tb is

  -- Compenent
  component scroll_pos_decoder
    port (
      slow_clk, rst_btnC, btnU : in  STD_LOGIC;
      scroll_pos               : out INTEGER range 0 to 23
    );
  end component;

  signal slow_clk, rst_btnC, btnU : STD_LOGIC := '0';
  signal scroll_pos_signal        : INTEGER range 0 to 23;

  -- Monitor procedure
  procedure Monitor(ShouldBe : in INTEGER) is
    variable lout : line;
  begin
    WRITE(lout, NOW, right, 10, ns);
    WRITE(lout, string'(" slow_clk --> "));
    WRITE(lout, slow_clk);
    WRITE(lout, string'(" rst_btnC --> "));
    WRITE(lout, rst_btnC);
    WRITE(lout, string'(" btnU --> "));
    WRITE(lout, btnU);
    WRITE(lout, string'(" Expected (scroll_pos) --> "));
    WRITE(lout, ShouldBe); -- Expected scroll_pos
    WRITE(lout, string'(" scroll_pos --> "));
    WRITE(lout, scroll_pos_signal); -- Measured scroll_pos
    WRITELINE(OUTPUT, lout);
    assert scroll_pos_signal = ShouldBe report "Test Failed (scroll_pos mismatch)" severity FAILURE;
  end procedure;

begin
  S1: scroll_pos_decoder
    port map (
      slow_clk   => slow_clk,
      rst_btnC   => rst_btnC,
      btnU       => btnU,
      scroll_pos => scroll_pos_signal
    );

  stim_proc: process
  begin
    wait for 10 ns;
    report "Beginning the Scroll Position Testbench" severity NOTE;

    -- Test case 1 : Initial value
    slow_clk <= '0';
    rst_btnC <= '0';
    btnU <= '0';
    wait for 10 ns;
    Monitor(0);

    -- Test case 2 : slow_clk high
    slow_clk <= '1';
    rst_btnC <= '0';
    btnU <= '0';
    wait for 10 ns;
    Monitor(1);

    -- Test case 3: slow_clk remained high
    slow_clk <= '1';
    rst_btnC <= '0';
    btnU <= '0';
    wait for 10 ns;
    Monitor(1);

    -- Test case 4: slow_clk low
    slow_clk <= '0';
    rst_btnC <= '0';
    btnU <= '0';
    wait for 10 ns;
    Monitor(1);

    -- Test case 5: slow_clk high
    slow_clk <= '1';
    rst_btnC <= '0';
    btnU <= '0';
    wait for 10 ns;
    Monitor(2);

    -- Test case 6: rst_btnC high
    slow_clk <= '0';
    rst_btnC <= '1';
    btnU <= '0';
    wait for 10 ns;
    Monitor(0);

    -- Test case 7: btnU high
    slow_clk <= '1';
    rst_btnC <= '0';
    btnU <= '1';
    wait for 10 ns;
    Monitor(0);

    -- Test case 8: Increments when button is released
    slow_clk <= '0';
    rst_btnC <= '0';
    btnU <= '1';
    wait for 10 ns;
    Monitor(0);

    slow_clk <= '1';
    rst_btnC <= '0';
    btnU <= '0';
    wait for 10 ns;
    Monitor(1);

    -- Test case 9: Force Failure
    slow_clk <= '0';
    rst_btnC <= '1';
    btnU <= '0';
    wait for 10 ns;
    Monitor(2);

    wait;
  end process;
end architecture;
