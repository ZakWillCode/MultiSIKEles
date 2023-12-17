# timing constrain file for the CPU 
# Author: Zakary Williams
# File: MC_MIPS_Programmed_TL.v

# Make sure to start "clean" (remove all assignments in memory) 
reset_design

current_design MC_MIPS_Programmed_TL

# Specify parameters
# set input_del_max 4
# set input_del_min 3
# set output_del_max 3 
# set output_del_min 2

# Design Constraints File Organization: 
# 1. Clock Constraints
# 2. Derived Constraints
# 3. Input and Output Delays
# 4. Timing Exceptions 
# 5. Reports (optional)



# 1. Clock Constraints
# Create Clock
create_clock [get_ports {ph1}] -name clk1 -period 10000 -waveform {0 5000}
#create_generated_clock -name neg_edge_clk -source [get_ports {ph1}] -master_clock clk1 -multiply_by 1 -invert -add [get_pins /designs/MC_MIPS_Programmed_TL/instances_hier/control/pins_in/ph1]

# Set Clock Groups

# Set Clock Latency
# set_clock_latency -source 0.02 [get_clocks clk1]

# Set Clock Uncertainty

# set_clock_uncertainty 0.04 -to [get_clocks clk1] -setup 
# set_clock_uncertainty 0.04 -to [get_clocks clk1] -hold

# 2. Derived Constraints
# derive_pll_clocks

# 3. Input and Output Delays

# Inputs
set_input_delay -clock clk1 -max 2 [get_ports {reset}]
set_input_delay -clock clk1 -min 1 [get_ports {reset}]
set_input_delay -clock clk1 -max 2 [get_ports {MemData}]
set_input_delay -clock clk1 -min 1 [get_ports {MemData}]

# Outputs
set_output_delay -clock clk1 -max 2 [get_ports {ans}]
#set_output_delay -clock clk1 -max 2 [get_ports {Address}]
#set_output_delay -clock clk1 -min 1 [get_ports {Address}]
#set_output_delay -clock clk1 -max 2 [get_ports {B_data}]
#set_output_delay -clock clk1 -min 1 [get_ports {B_data}]
#set_output_delay -clock clk1 -max 2 [get_ports {MemRead}]
#set_output_delay -clock clk1 -min 1 [get_ports {MemRead}]
#set_output_delay -clock clk1 -max 2 [get_ports {MemWrite}]
#set_output_delay -clock clk1 -min 1 [get_ports {MemWrite}]





