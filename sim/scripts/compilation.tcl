vcom -93 -work ./work ../src/instruction_set.vhd
vcom -93 -work ./work ../src/if.vhd
vcom -93 -work ./work ../src/id/regfile.vhd
vcom -93 -work ./work ../src/id/imm_generator.vhd
vcom -93 -work ./work ../src/id/id.vhd
vcom -93 -work ./work ../src/ex/ALU.vhd
vcom -93 -work ./work ../src/ex/alu_ctrl.vhd
vcom -93 -work ./work ../src/ex/pc_alu.vhd
vcom -93 -work ./work ../src/ex/ex_stage.vhd
vcom -93 -work ./work ../src/mem/mem_stage.vhd
vcom -93 -work ./work ../src/wb/wb_stage.vhd
vcom -93 -work ./work ../src/risc_v.vhd

#vlog -work ./work ../tb/tb_iir_adv.v

# Start simulation
#vsim work.tb_iir
#add wave -radix decimal * 

#add wave -divider "Internal signals"
#add wave -radix decimal sim:/tb_iir/DUT/x
#add wave -radix decimal sim:/tb_iir/DUT/w
#add wave -radix decimal sim:/tb_iir/DUT/pl1_out(0)
#add wave -radix decimal sim:/tb_iir/DUT/pl1_out(1)
#add wave -radix decimal sim:/tb_iir/DUT/pl1_out(2)
#add wave -radix decimal sim:/tb_iir/DUT/y

#run 2150 ns
#run 2200 ns
