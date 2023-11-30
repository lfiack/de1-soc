TOP = VGA_controler

all: 
	ghdl -a $(TOP).vhd
	ghdl -a $(TOP)_tb.vhd
	ghdl -e $(TOP)_tb
	ghdl -r $(TOP)_tb --wave=$(TOP)_tb.ghw