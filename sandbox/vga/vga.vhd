library ieee;
use ieee.std_logic_1164.all;

library pll;
use pll.all;

entity vga is
	port (
		i_clk_50 : in std_logic;
		i_rst_n : in std_logic;
				  
		o_led : out std_logic;

		o_VGA_R : out std_logic_vector(7 downto 0);
		o_VGA_G : out std_logic_vector(7 downto 0);
		o_VGA_B : out std_logic_vector(7 downto 0);
		o_VGA_HS : out std_logic;
		o_VGA_VS : out std_logic;
		o_VGA_SYNC : out std_logic;
		o_VGA_BLANK : out std_logic;
		o_VGA_CLOCK : out std_logic
	);
end entity vga;

architecture rtl of vga is
	signal s_clk_25 : std_logic;
	signal s_rst : std_logic;
begin
	pll_0 : entity pll.pll
		port map (
			refclk => i_clk_50,
			rst => not(i_rst_n),
			outclk_0 => s_clk_25,
			locked => s_rst
		);
	
	p_blink : process(s_clk_25, s_rst)
		variable counter : integer range 0 to 25000000 := 0;
	begin
		if (s_rst = '0') then
			counter := 0;
			o_led <= '0';
		elsif (rising_edge(s_clk_25)) then
			if (counter < 25000000) then
				counter := counter + 1;
			else
				counter := 0;
			end if;
			if (counter < 12500000) then
				o_led <= '1';
			else
				o_led <= '0';
			end if;
		end if;
	end process;

    VGA_controler_0 : entity work.VGA_controler
        port map (
            i_clk => s_clk_25,
            i_rst_n  => s_rst,
    
            o_VGA_R  => o_VGA_R,
            o_VGA_G  => o_VGA_G,
            o_VGA_B  => o_VGA_B,
            o_VGA_HS  => o_VGA_HS,
            o_VGA_VS  => o_VGA_VS,
            o_VGA_SYNC  => o_VGA_SYNC,
            o_VGA_BLANK  => o_VGA_BLANK,
            o_VGA_CLOCK  => o_VGA_CLOCK
        );
end architecture rtl;