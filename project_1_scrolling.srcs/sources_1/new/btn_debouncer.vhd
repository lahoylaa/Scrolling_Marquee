----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 07:17:05 PM
-- Design Name: 
-- Module Name: debouncer - Behavioral
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
  use IEEE.std_logic_unsigned.all;

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --use IEEE.NUMERIC_STD.ALL;
  -- Uncomment the following library declaration if instantiating
  -- any Xilinx leaf cells in this code.
  --library UNISIM;
  --use UNISIM.VComponents.all;

entity btn_debouncer is
  --  Port ( );
  port (
    btn_in  : in  STD_LOGIC;
    clk     : in  STD_LOGIC;
    reset   : in  STD_LOGIC;
    btn_out : out STD_LOGIC
  );

end entity;

architecture Behavioral of btn_debouncer is

  signal count    : std_logic_vector(1 downto 0);
  signal debounce : std_logic := '0';

begin
  process (clk, reset)
  begin
    if (reset = '1') then
      count <= "00";
      debounce <= '0';
    elsif (clk'event and rising_edge(clk)) then
      if (btn_in = '1') then
        if (count = "11") then
          debounce <= '1';
          count <= "00";
        else
          debounce <= '0';
          count <= count + 1;
        end if;

      else
        debounce <= '0';
        count <= "00";
      end if;
    end if;
  end process;

  btn_out <= debounce;

end architecture;
