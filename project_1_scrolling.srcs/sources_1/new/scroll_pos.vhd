library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity scroll_pos_decoder is
  port (
    slow_clk   : in  STD_LOGIC;            -- Slowed-down clock for smooth scrolling
    rst_btnC   : in  STD_LOGIC;            -- Reset button (resets scroll position)
    btnU       : in  STD_LOGIC;            -- Button to pause scrolling
    scroll_pos : out INTEGER range 0 to 24 -- Scrolling position output
  );
end entity;

architecture Behavioral of scroll_pos_decoder is
  signal scroll_pos_counter : integer range 0 to 24 := 0;

begin
  -- Update Scroll Position
  process (slow_clk, rst_btnC)
  begin
    if rst_btnC = '1' then
      scroll_pos_counter <= 0; -- Reset to start position
    elsif rising_edge(slow_clk) then
      if btnU = '0' then -- Only update when button is NOT held
        scroll_pos_counter <= (scroll_pos_counter + 1) mod 25;
      end if;
    end if;
  end process;

  scroll_pos <= scroll_pos_counter; -- Output the current scroll position

end architecture;
