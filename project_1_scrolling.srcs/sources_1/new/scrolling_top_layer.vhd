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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scrolling_top_layer is
--  Port ( );
Port(
    clk_100MHz : in STD_LOGIC;
    rst_btnC : in STD_LOGIC;
    seg_an : out STD_LOGIC_VECTOR(7 downto 0);
    seg_data : out STD_LOGIC_VECTOR(15 downto 0)
);
end scrolling_top_layer;

architecture Behavioral of scrolling_top_layer is
signal fast_clk_signal : std_logic;
signal slow_clk_signal : std_logic;
signal counter : std_logic_vector(2 downto 0);
signal active_digit_signal : INTEGER range 0 to 7; 
signal scroll_pos_signal : INTEGER range 0 to 15; 
signal delay_active_signal : std_logic;

begin

fast_clock : entity work.ten_khz_clk
port map(
    clk_100MHz => clk_100MHz,
    rst_btnC => rst_btnC,
    fast_clkout => fast_clk_signal
);

slow_clock : entity work.half_second_clk
port map(
    clk_100MHz => clk_100MHz,
    rst_btnC => rst_btnC,
    slow_clkout => slow_clk_signal
);

--T1 : entity work.three_bit_counter
--port map(
--    clk => slow_clk_signal,
--    reset => rst_btnC,
--    count => counter
--);

A1 : entity work.active_digit_decoder
port map(
    fast_clk => fast_clk_signal,
    rst_btnC => rst_btnC,
    active_digit => active_digit_signal
);

S1 : entity work.scroll_pos_decoder
port map(
    slow_clk => slow_clk_signal,
    rst_btnC => rst_btnC,
    scroll_pos => scroll_pos_signal
);


M1 : entity work.seven_seg_mux
port map(
    clk_100MHz => clk_100MHz,
    active_digit => active_digit_signal,
    scroll_pos => scroll_pos_signal,
    --delay_active => delay_active_signal,
    seg_an => seg_an,
    seg_data => seg_data
);

end Behavioral;
