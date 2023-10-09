library ieee;
use ieee.std_logic_1164.all;

library pll_caca;
use pll_caca.all;

entity pll_test is
	port (
		clk : in std_logic;
		nrst : in std_logic;
		leds : out std_logic_vector(1 downto 0)
	);
end entity pll_test;

architecture rtl of pll_test is
	signal clk100 : std_logic;

	signal blink_counter : integer range 0 to 50000000 := 0;
begin
	pll_0 : entity pll_caca.pll_caca
		port map (
			refclk => clk,
			rst => not nrst,
			outclk_0 => clk100,
			locked => leds(1)
		);

	p_blink : process (clk100, nrst)
	begin
		if (nrst = '0') then
			blink_counter <= 0;
		elsif (rising_edge(clk100)) then
			if (blink_counter = 49999999) then
				blink_counter <= 0;
			else
				blink_counter <= blink_counter + 1;
			end if;
		end if;
	end process p_blink;
	
	leds(0) <= '1' when blink_counter < 24999999 else '0';
end architecture rtl;