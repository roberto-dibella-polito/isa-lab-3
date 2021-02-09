#################################################################################
#	FIRST COMPILATION SCRIPT													#
#	Design: 		risc_v														#
#	Goal:			Find the maximum frequency  								#
#	Last modified:	February 9, 12:17											#	
#################################################################################

# Timing constraints
create_clock -name MY_CLK -period 0.9 CLK	
set_dont_touch_network MY_CLK				
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

# Load constraints
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

# Timing & Area report

report_timing > results/timing_clk_0_90.txt
report_area > results/area_clk_0_90.txt
