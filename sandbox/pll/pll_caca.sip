set_global_assignment -entity "pll_caca" -library "lib_pll_caca" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_caca" -library "lib_pll_caca" -name IP_TOOL_VERSION "22.1"
set_global_assignment -entity "pll_caca" -library "lib_pll_caca" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_caca" -name SPD_FILE [file join $::quartus(sip_path) "pll_caca.spd"]

set_global_assignment -library "lib_pll_caca" -name MISC_FILE [file join $::quartus(sip_path) "pll_caca_sim/pll_caca.vho"]
