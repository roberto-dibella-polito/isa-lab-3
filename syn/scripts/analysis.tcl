# Import files into Design Compiler: ANALYZE
# analyze -f vhdl -lib WORK ../src/<file name>.vhd

#####################################################
#	ANALYSIS SCRIPT									#
#	Design: 		risc-v							#
#	Last modified:			#	
#####################################################

#Delete the working directory -> to clean everything
file delete -force "work"
echo *************** Previous work directory deleted ****************

# Create again the work directory
file mkdir "work"
echo *************** New work directory created *********************


analyze -f vhdl -lib WORK ../src/instruction_set.vhd
analyze -f vhdl -lib WORK ../src/cu/alu_op.vhd
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
analyze -f vhdl -lib WORK ../src/risc_v_dp.vhd

# Control unit
analyze -f vhdl -lib WORK ../src/cu/risc_v_cu.vhd
analyze -f vhdl -lib WORK ../src/cu/risc_v_cu_pp.vhd

# Top level entity
analyze -f vhdl -lib WORK ../src/risc_v.vhd

set power_preserve_rtl_hier_names true

elaborate risc_v_lite -arch structure -lib WORK > results/elaborate.txt
uniquify
link



