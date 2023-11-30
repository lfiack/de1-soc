library ieee;
use ieee.std_logic_1164.all;

entity VGA_controler_tb is
end entity VGA_controler_tb;

architecture tb of VGA_controler_tb is
    signal tb_i_clk : std_logic;
    signal tb_i_rst_n : std_logic;
    
    signal tb_o_VGA_R : std_logic_vector(7 downto 0);
    signal tb_o_VGA_G : std_logic_vector(7 downto 0);
    signal tb_o_VGA_B : std_logic_vector(7 downto 0);
    signal tb_o_VGA_HS : std_logic;
    signal tb_o_VGA_VS : std_logic;
    signal tb_o_VGA_SYNC : std_logic;
    signal tb_o_VGA_BLANK : std_logic;
    signal tb_o_VGA_CLOCK : std_logic;

    signal finished : boolean := false;
begin
    VGA_controler_0 : entity work.VGA_controler
        port map (
            i_clk => tb_i_clk,
            i_rst_n  => tb_i_rst_n,
    
            o_VGA_R  => tb_o_VGA_R,
            o_VGA_G  => tb_o_VGA_G,
            o_VGA_B  => tb_o_VGA_B,
            o_VGA_HS  => tb_o_VGA_HS,
            o_VGA_VS  => tb_o_VGA_VS,
            o_VGA_SYNC  => tb_o_VGA_SYNC,
            o_VGA_BLANK  => tb_o_VGA_BLANK,
            o_VGA_CLOCK  => tb_o_VGA_CLOCK
        );
    
    p_clk : process
    begin
        tb_i_clk <= '0';
        wait for 5 ns;
        tb_i_clk <= '1';
        wait for 5 ns;
        
        if (finished = true) then
            wait;
        end if;
    end process p_clk;

    p_tb : process
    begin
        tb_i_rst_n <= '0';
        wait for 20 ns;
        tb_i_rst_n <= '1';
        wait for 1000 ns;

        finished <= true;
        wait;
    end process p_tb;
end architecture tb;