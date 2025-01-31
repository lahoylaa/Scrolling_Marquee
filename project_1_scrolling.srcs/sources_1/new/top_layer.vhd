----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2025 02:47:25 PM
-- Design Name: 
-- Module Name: top_layer - Behavioral
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

entity top_layer is
--  Port ( );
Port(
    clk_100MHz : in STD_LOGIC;
    rst_btnC : in STD_LOGIC;
    Seg_out : out STD_LOGIC_VECTOR(7 downto 0);
    Seg_out_two : out STD_LOGIC_VECTOR (7 downto 0);
    Anode_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end top_layer;

architecture Behavioral of top_layer is

signal clk_out : std_logic;
signal counter : std_logic_vector(2 downto 0);
signal startVal : std_logic_vector(3 downto 0) := "0000";
signal segmentVal : std_logic_vector(7 downto 0);

begin

 My_Clock : entity work.clk_divide_125Hz
 port map(
    clk => clk_100MHz,
    reset => rst_btnC,
    clkout => clk_out
 );

T1 : entity work.two_bit_counter
port map(
    clk => clk_out,
    reset => rst_btnC,
    count => counter
);

B1 : entity work.bcd_sevenseg
port map(
    dispVal => startVal,
    segment_out => segmentVal
);

M1 : entity work.mux
port map(
    SegSelect => counter,
    SegIn => segmentVal,
    AnodeOut => Anode_out,
    SegOut => Seg_out,
    SegOutTwo => Seg_out_two
);

end Behavioral;
