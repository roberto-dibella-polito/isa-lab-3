# Import files into Design Compiler: ANALYZE
# analyze -f vhdl -lib WORK ../src/<file name>.vhd

#####################################################
#	ANALYSIS SCRIPT									#
#	Design: 		risc-v							#
#	Last modified:			#	
#####################################################


analyze -f vhdl -lib WORK ../src/instruction_set.vhd
analyze -f vhdl -lib WORK ../src/if.vhd
analyze -f vhdl -lib WORK ../src/id/regfile.vhd
analyze -f vhdl -lib WORK ../src/id/imm_generator.vhd
analyze -f vhdl -lib WORK ../src/id/id.vhd
analyze -f vhdl -lib WORK ../src/ex/ALU.vhd
analyze -f vhdl -lib WORK ../src/ex/pc_alu.vhd
analyze -f vhdl -lib WORK ../src/ex/alu_ctrl.vhd
analyze -f vhdl -lib WORK ../src/ex/ex_stage.vhd
analyze -f vhdl -lib WORK ../src/mem/mem_stage.vhd
analyze -f vhdl -lib WORK ../src/wb/wb_stage.vhd
analyze -f vhdl -lib WORK ../src/risc_v.vhd

set power_preserve_rtl_hier_names true

elaborate risc_v_dp -arch structure -lib WORK > results/dp_elaborate.txt



