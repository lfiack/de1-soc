# inform Quartus that the clk port brings a 50MHz clock into our design so
# that timing closure on our design can be analyzed
create_clock -name i_clk -period "50MHz" [get_ports i_clk]
# inform Quartus that the LED output port has no critical timing requirements
# it’s a single output port driving an LED, there are no timing relationships
# that are critical for this
set_false_path -from * -to [get_ports o_led[0]]
set_false_path -from * -to [get_ports o_led[1]]
set_false_path -from * -to [get_ports o_led[2]]
set_false_path -from * -to [get_ports o_led[3]]
set_false_path -from [get_ports i_reset_n] -to *