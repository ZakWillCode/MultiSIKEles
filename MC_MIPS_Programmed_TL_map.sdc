# ####################################################################

#  Created by Genus Synthesis Solution GENUS15.12 - 15.10-s019_1 on Mon Dec 04 21:47:56 -0500 2023

# ####################################################################

set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1000.0ps

# Set the current design
current_design MC_MIPS_Programmed_TL

create_clock -name "clk1" -add -period 10000.0 -waveform {0.0 5000.0} [get_ports ph1]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports reset]
set_input_delay -clock [get_clocks clk1] -add_delay -min 1.0 [get_ports reset]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[7]}]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[6]}]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[5]}]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[4]}]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[3]}]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[2]}]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[1]}]
set_output_delay -clock [get_clocks clk1] -add_delay -max 2.0 [get_ports {ans[0]}]
set_wire_load_mode "enclosed"
