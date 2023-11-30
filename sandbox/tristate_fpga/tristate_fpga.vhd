library ieee;
use ieee.std_logic_1164.all;

entity tristate_fpga is
	port (
		clk : in std_logic;
		sw0 : in std_logic;
		sw1 : in std_logic;
		sw2 : in std_logic;
		sel : in std_logic_vector(1 downto 0);
		led : out std_logic
	);
end entity tristate_fpga;

architecture rtl of tristate_fpga is
	signal r0, r1, r2, r3 : std_logic := '0';
	signal internal : std_logic := 'Z';
begin
	process (clk) is
	begin
		if (rising_edge(clk)) then
			r0 <= sw0;
			r1 <= sw1;
			r2 <= sw2;
		end if;
	end process;
		
	internal <= r0 when (sel = "00") else 'Z';
	internal <= r1 when (sel = "01") else 'Z';
	internal <= r2 when (sel = "10") else 'Z';

	led <= internal;
end architecture rtl;