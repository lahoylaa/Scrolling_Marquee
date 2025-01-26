----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2025 12:27:39 AM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
  --  Port ( );
  port (
    clk_100MHz     : in  STD_LOGIC;
    rst_btnC       : in  STD_LOGIC;
    btnU           : in  STD_LOGIC;
    DipSwitchLeft  : in  STD_LOGIC_VECTOR(3 downto 0);
    DipSwitchRight : in  STD_LOGIC_VECTOR(3 downto 0);
    Seg_out        : out std_logic_vector(6 downto 0);
    Anode_out      : out STD_LOGIC_VECTOR(3 downto 0);
    Seg_out_2 : out STD_LOGIC_VECTOR(6 downto 0);
    Anode_out_2 : out STD_LOGIC_VECTOR(3 downto 0)
  );
end entity;

architecture Behavioral of top is

  signal clk_out     : std_logic;
  signal btn_out     : std_logic;
  signal counter     : std_logic_vector(1 downto 0);
  signal segment_out_1 : std_logic_vector(6 downto 0);
  signal segment_out_2 : std_logic_vector(6 downto 0);

begin

  -- create sub modules
  My_clock: entity work.clk_divide_125Hz
    port map (
      clk    => clk_100MHz,
      reset  => rst_btnC,
      clkout => clk_out
    );

  D1: entity work.debouncer
    port map (
      btn_in  => btnU,
      clk     => clk_out,
      reset   => rst_btnC,
      btn_out => btn_out
    );

  B1: entity work.bcd_sevenseg
    port map (
      push_btn    => btn_out,
      switch      => DipSwitchLeft,
      segment_out => segment_out_1
    );

  B2: entity work.bcd_sevenseg
    port map (
      push_btn    => btn_out,
      switch      => DipSwitchRight,
      segment_out => segment_out_2
    );

  T1: entity work.two_bit_counter
    port map (
      clk   => clk_out,
      reset => rst_btnC,
      count => counter
    );

  U1: entity work.multiplexer
    port map (
      Seg_select => counter,
      LeftSeg    => segment_out_1,
      RightSeg   => segment_out_2,
      Anode_out  => Anode_out,
      Seg_out    => Seg_out
    );

    U2: entity work.multiplexer
    port map(
      Seg_select => counter,
      LeftSeg => segment_out_1,
      RightSeg => segment_out_2,
      Anode_out => Anode_out_2,
      Seg_out => Seg_out_2
    );

end architecture;
