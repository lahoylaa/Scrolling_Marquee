----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 10:11:16 PM
-- Design Name: 
-- Module Name: scrolling_top_layer - Behavioral
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

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --use IEEE.NUMERIC_STD.ALL;
  -- Uncomment the following library declaration if instantiating
  -- any Xilinx leaf cells in this code.
  --library UNISIM;
  --use UNISIM.VComponents.all;

entity scrolling_top_layer is
  --  Port ( );
  port (
    clk_100MHz : in  STD_LOGIC;
    rst_btnC   : in  STD_LOGIC;
    btnU       : in  STD_LOGIC; -- Button to hold display
    btnIn      : in  STD_LOGIC;
    switch     : in  STD_LOGIC_VECTOR(3 downto 0);
    seg_an     : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data   : out STD_LOGIC_VECTOR(15 downto 0);

    led_data   : out STD_LOGIC_VECTOR(5 downto 0)
  );
end entity;

architecture Behavioral of scrolling_top_layer is
  signal fast_clk_signal       : std_logic;
  signal slow_clk_signal       : std_logic;
  signal active_digit_signal   : INTEGER range 0 to 7;
  signal scroll_pos_signal     : INTEGER range 0 to 24;
  signal lock_signal           : std_logic;
  signal btn_signal            : std_logic;
  signal clk_out_signal        : std_logic;
  signal led_clk_signal        : std_logic;
  signal sequence_state_signal : std_logic;
  signal progress_state_signal : std_logic;

begin

  button_clock: entity work.clk_divide_125Hz
    port map (
      clk    => clk_100MHz,
      reset  => rst_btnC,
      clkout => clk_out_signal
    );

  fast_clock: entity work.clk_divide_500Hz
    port map (
      clk_100MHz  => clk_100MHz,
      rst_btnC    => rst_btnC,
      fast_clkout => fast_clk_signal
    );

  slow_clock: entity work.half_second_clk
    port map (
      clk_100MHz  => clk_100MHz,
      rst_btnC    => rst_btnC,
      slow_clkout => slow_clk_signal
    );

  led_clock: entity work.led_clk_divider
    port map (
      clk_100MHz => clk_100MHz,
      rst_btnC   => rst_btnC,
      led_clkout => led_clk_signal
    );

  D1: entity work.debouncer
    port map (
      btn_in  => btnIn,
      clk     => clk_out_signal,
      reset   => rst_btnC,
      btn_out => btn_signal
    );

  L1: entity work.switch_decoder
    port map (
      switch => switch,
      btnIn  => btn_signal,
      lock   => lock_signal
    );

  A1: entity work.active_digit_decoder
    port map (
      fast_clk     => fast_clk_signal,
      rst_btnC     => rst_btnC,
      active_digit => active_digit_signal
    );

  S1: entity work.scroll_pos_decoder
    port map (
      slow_clk   => slow_clk_signal,
      rst_btnC   => rst_btnC,
      btnU       => btnU,
      scroll_pos => scroll_pos_signal
    );

  K1: entity work.sequence_checker
    port map (
      scroll_pos     => scroll_pos_signal,
      lock           => lock_signal,
      sequence_state => sequence_state_signal
     -- progress_state => progress_state_signal
    );

  P1: entity work.led_decoder
    port map (
      lock           => lock_signal,
      led_clk        => led_clk_signal,
      --progress_state => progress_state_signal,
      led_data       => led_data
    );

  M1: entity work.seven_seg_mux
    port map (
      active_digit   => active_digit_signal,
      scroll_pos     => scroll_pos_signal,
      sequence_state => sequence_state_signal,
      seg_an         => seg_an,
      seg_data       => seg_data
    );

end architecture;
