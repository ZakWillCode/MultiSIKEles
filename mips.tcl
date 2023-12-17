###################################################
#Author: Yushi Zhou
#Edits: Zakary Williams
#Date: November 2023
#Description: Environment setup for Cadence Genus(RTL Compiler)
#             The script is revised based on posted file from Dr. Sudip@UBC
####################################################
puts "==================="
puts "Synthesis Started"
date
puts "==================="

# set varaibles used for the following
set DESIGN MC_MIPS_Programmed_TL
set SYN_EFF medium
set MAP_EFF medium
set SYN_PATH "."

# specific commands for Genus to compile source files
# set the search path for ".lib" files from PDK's library
# here, we use free 45nm PDK
#set_attribute lib_search_path ../FreePDK45/osu_soc/lib/files
set_attribute lib_search_path ../Project

# set tech library from PDK
set_attribute library {gscl45nm.lib}

# set the search path for your own design, e.g. hdl files
set_attribute init_hdl_search_path ../Project/Verilog/MultiSIKEles-main

############################################
# read .v/.vhdl/.sv files, can be list more
# read_hdl file1.v
# read_hdl file2.v
# read_hdl file3.v ... or
# read_hdl {file1.v file2.v file3.v ...}
read_hdl {MC_MIPS_Programmed_TL.v A.v B.v ALU.v ALU_controller.v ALUOut.v Branch_logic.v Control.v Instruction_register.v Memory_programmed.v Memory_data_register.v mux2_1.v mux2_1_5b.v  mux3_1.v mux4_1.v PC.v Registers.v Shift_left2.v}

#read_hdl xxx
# elaboration validates the top module
elaborate $DESIGN

#return problems with your RTL code
check_design -unresolved

#################################
# Read timing constrain file. sdc
#read .sdc file
read_sdc ./synth/in/mips.sdc

######################################################
# synthesizing to generic cell(not related to the PDK)

synthesize -to_generic -effort $SYN_EFF
#syn_generic -effort $SYN_EFF

# synthesizing to gates from the used PDK
#synthesize -to_mapped -no_incremental -effort $MAP_EFF

# incremental synthesis
synthesize -to_mapped -incremental -effort $MAP_EFF
#syn_map -incremental -effort $MAP_EFF

#insert_tiehilo_cells
#######################################################
# generate reports for area, timging and power
report area > ./synth//out/${DESIGN}_area.rpt

#report timing -from y[0] -to s[63] > ./out/${DESIGN}_timing.rpt
report timing > ./synth/out/${DESIGN}_timing.rpt
report power > ./synth/out/${DESIGN}_power.rpt

# generate verilog files with actual gates--> used in Encounter and ModelSim
write_hdl -mapped > ./synth/out/${DESIGN}_map.v
write_hdl -mapped > ./synth/out/${DESIGN}_map.sv

# generate constrain files for Encounter
write_sdc > ./synth/out/${DESIGN}_map.sdc

# generate delay files for ModelSim
write_sdf > ./synth/out/${DESIGN}_map.sdf

puts "Final Runtime & Memory."
timestat Final

puts "==================="
puts "Synthesis Completed"
puts "==================="

#quit
