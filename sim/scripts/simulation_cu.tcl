vcom -93 -work ./work ../src/instruction_set.vhd
vcom -93 -work ./work ../src/cu/alu_op.vhd
vcom -93 -work ./work ../src/risc_v_cu.vhd
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_v2.vhd
vcom -93 -work ./work ../tb/tb_cu.vhd

# Start simulation
#vsim work.tb_iir
#add wave -radix decimal * 

vsim work.tb_risc_v_cu

add wave sim:/tb_risc_v_cu/clk
add wave sim:/tb_risc_v_cu/g_rst_n
add wave sim:/tb_risc_v_cu/async_rst_n
add wave sim:/tb_risc_v_cu/zero
add wave sim:/tb_risc_v_cu/endsim

add wave -divider "Instruction"

add wave -radix hexadecimal sim:/tb_risc_v_cu/data
add wave sim:/tb_risc_v_cu/opcode

add wave -divider "Control signals"
#add wave -radix decimal sim:/tb_iir/DUT/x
#add wave -radix decimal sim:/tb_iir/DUT/w
#add wave -radix decimal sim:/tb_iir/DUT/pl1_out(0)
#add wave -radix decimal sim:/tb_iir/DUT/pl1_out(1)
#add wave -radix decimal sim:/tb_iir/DUT/pl1_out(2)
#add wave -radix decimal sim:/tb_iir/DUT/y

add wave sim:/tb_risc_v_cu/pc_en
add wave sim:/tb_risc_v_cu/pc_sel
add wave sim:/tb_risc_v_cu/id_wr_en
add wave sim:/tb_risc_v_cu/rd_jal
add wave sim:/tb_risc_v_cu/imm_op
add wave sim:/tb_risc_v_cu/mem_wr_en
add wave sim:/tb_risc_v_cu/wb_sel
add wave sim:/tb_risc_v_cu/alu_op



#run 2150 ns
#run 2200 ns
