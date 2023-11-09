library ieee;
use ieee.std_logic_1164.all;

entity cyclone10 is
	port (
		i_clk : in std_logic;
		i_reset_n : in std_logic;
		o_led : out std_logic_vector(3 downto 0)
	);
end entity cyclone10;

architecture rtl of cyclone10 is
	constant c_divider : positive := 10000000;
	signal r_led : std_logic_vector(3 downto 0);
begin
	o_led <= r_led;
	
	process(i_clk, i_reset_n)
		variable counter : integer range 0 to c_divider := 0;
	begin
		if (i_reset_n = '0') then
			counter := 0;
			r_led <= "1110";
		elsif (rising_edge(i_clk)) then
			counter := counter + 1;
			if (counter = c_divider) then
				counter := 0;
				r_led(1) <= r_led(0);
				r_led(2) <= r_led(1);
				r_led(3) <= r_led(2);
				r_led(0) <= r_led(3);
			end if;
		end if;
	end process;

end architecture rtl;