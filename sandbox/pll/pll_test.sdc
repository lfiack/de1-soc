# 50MHz means 20ns
create_clock -name clk -period 20 [get_ports {clk}]

# I don't know why yet, but it seems important
derive_pll_clocks
derive_clock_uncertainty