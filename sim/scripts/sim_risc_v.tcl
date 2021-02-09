# Packages
vcom -93 -work ./work ../src/instruction_set.vhd
vcom -93 -work ./work ../src/cu/alu_op.vhd

# Datapath
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
vcom -93 -work ./work ../src/risc_v_dp.vhd

# Control unit
vcom -93 -work ./work ../src/cu/risc_v_cu.vhd
vcom -93 -work ./work ../src/cu/risc_v_cu_pp.vhd

# Top level entity
vcom -93 -work ./work ../src/risc_v.vhd

# Testbench elements
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/EOF_detector.vhd
vcom -93 -work ./work ../tb/if/instruction_memory_v2.vhd
vcom -93 -work ./work ../tb/mem/mem_v2.vhd

# top level entity
vcom -93 -work ./work ../tb/tb_risc_v_lite_v2.vhd

vsim work.tb_risc_v_lite


add wave sim:/tb_risc_v_lite/clk
add wave sim:/tb_risc_v_lite/async_rst_n
add wave sim:/tb_risc_v_lite/rst_n
add wave sim:/tb_risc_v_lite/dut/datapath/pipe_rst_n

add wave -divider "IF"
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_fetch/pc_jp
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_fetch/pc_sel
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_fetch/pc
add wave -radix hexadecimal sim:/tb_risc_v_lite/im/zero_addr
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_fetch/instr

add wave -divider "ID"
add wave sim:/tb_risc_v_lite/dut/control_unit/cu/state
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/memory/reg_file 
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/instruction
add wave -radix unsigned sim:/tb_risc_v_lite/dut/datapath/instr_decode/memory/rs1
add wave -radix unsigned sim:/tb_risc_v_lite/dut/datapath/instr_decode/memory/rs2
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/data1_out
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/data2_out
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/immediate
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/alu_ctrl
add wave -radix unsigned sim:/tb_risc_v_lite/dut/datapath/instr_decode/memory/rd
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/memory/data_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/if_pc4_out_1
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/if_pc4_out2
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/if_pc4_out3
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/if_pc4_out4
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/id_pc_4_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/id_pc_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/control_unit/rd_jal
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/instr_decode/pc_out



add wave -divider "EX"
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/execute/pc_alu_unit/pc_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/execute/pc_alu_unit/imm_shifted
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/execute/imm_out
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/execute/d1
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/execute/alu_unit/d2
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/execute/alu_out
add wave sim:/tb_risc_v_lite/dut/datapath/execute/alu_op
add wave sim:/tb_risc_v_lite/dut/control_unit/ex_rd_jal_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/execute/pc_alu_unit/pc_out
add wave sim:/tb_risc_v_lite/dut/datapath/execute/zero

add wave -divider "MEM"
add wave -radix hexadecimal sim:/tb_risc_v_lite/data_mem/addr
add wave -radix unsigned sim:/tb_risc_v_lite/data_mem/addr_1
add wave -radix unsigned sim:/tb_risc_v_lite/data_mem/addr_2
add wave -radix hexadecimal sim:/tb_risc_v_lite/data_mem/data_out
add wave -radix hexadecimal sim:/tb_risc_v_lite/data_mem/data_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/memory/imm_out
add wave sim:/tb_risc_v_lite/dut/datapath/memory/branch
add wave sim:/tb_risc_v_lite/dut/datapath/memory/zero
add wave sim:/tb_risc_v_lite/dut/datapath/memory/branch_t
add wave sim:/tb_risc_v_lite/dut/control_unit/mem_rd_jal_in
add wave sim:/tb_risc_v_lite/dut/datapath/memory/pc_in

add wave -divider "WB"
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/write_back/pc_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/write_back/data_rd
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/write_back/data_fwd
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/write_back/imm_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/write_back/wb_sel
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/write_back/data_wb


add wave -divider "Data Memory"
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(0)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(1)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(2)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(3)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(4)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(5)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(6)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(9)

add wave -divider "PIPELINE"
add wave -divider "ID/EX"
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/ex_pc_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/ex_data1_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/ex_data2_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/ex_alu_ctrl_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/ex_rd_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/ex_imm_in

add wave -divider "EX/MEM"
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/mem_pc_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/mem_data_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/mem_alu_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/mem_zero_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/mem_rd_in
add wave -radix hexadecimal sim:/tb_risc_v_lite/dut/datapath/mem_imm_in

run 2500 ns
