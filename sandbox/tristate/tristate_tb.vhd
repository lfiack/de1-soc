library ieee;
use ieee.std_logic_1164.all;

entity tristate_tb is
end entity tristate_tb;

architecture tb of tristate_tb is
	signal tb_clk : std_logic;
	signal tb_sb_to_x : std_logic;
	signal tb_x_to_sb : std_logic;
	signal tb_s_bus : std_logic_vector(7 downto 0);
begin
	tristate_0 : entity work.tristate
	port map (
		clk => tb_clk,
		sb_to_x => tb_sb_to_x,
		x_to_sb => tb_x_to_sb,
		s_bus => tb_s_bus
	);

	process
	begin
		tb_clk <= '0';
		tb_sb_to_x <= '0';
		tb_x_to_sb <= '0';
		tb_s_bus <= "ZZZZZZZZ";

		wait for 5 ns; tb_clk <= '1'; wait for 5 ns;

		tb_clk <= '0'; 
		tb_sb_to_x <= '1';
		tb_s_bus <= x"A5";

		wait for 5 ns; tb_clk <= '1'; wait for 5 ns;

		tb_clk <= '0'; 
		tb_sb_to_x <= '0';

		wait for 5 ns; tb_clk <= '1'; wait for 5 ns;

		tb_clk <= '0';
		tb_s_bus <= "ZZZZZZZZ";

		wait for 5 ns; tb_clk <= '1'; wait for 5 ns;

		tb_clk <= '0'; 
		tb_x_to_sb <= '1';

		wait for 5 ns; tb_clk <= '1'; wait for 5 ns;

		wait;
	end process;
end architecture tb;
