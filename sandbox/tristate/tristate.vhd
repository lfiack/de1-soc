library ieee;
use ieee.std_logic_1164.all;

entity tristate is
	port (
		clk : in std_logic;
		sb_to_x : in std_logic;
		x_to_sb : in std_logic;
		s_bus : inout std_logic_vector(7 downto 0)
	);
end entity tristate;

architecture rtl of tristate is
	signal reg : std_logic_vector(7 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if sb_to_x = '1' then
				reg <= s_bus;
			end if;
		end if;
	end process;

	s_bus <= reg when x_to_sb = '1' else (others => 'Z');
end architecture rtl;
