file delete -force "work"
vlib work

# Packages
vcom -93 -work ./work ../src/instruction_set.vhd
vcom -93 -work ./work ../src/cu/alu_op.vhd

vlog -work ./work ../netlist/risc_v_lite.v

# Testbench elements
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/EOF_detector.vhd
vcom -93 -work ./work ../tb/if/instruction_memory_v2_mod.vhd
vcom -93 -work ./work ../tb/mem/mem_v2.vhd

# top level entity
vcom -93 -work ./work ../tb/tb_risc_v_lite_v2.vhd

vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftype /tb_risc_v_lite/DUT=../netlist/risc_v_lite.sdf work.tb_risc_v_lite

vcd file ../vcd/risc_v_lite_syn.vcd
vcd add /tb_risc_v_lite/DUT/*


add wave sim:/tb_risc_v_lite/clk
add wave sim:/tb_risc_v_lite/async_rst_n
add wave sim:/tb_risc_v_lite/rst_n

add wave -divider "Instruction Memory"
add wave -radix hexadecimal sim:/tb_risc_v_lite/im/zero_addr
add wave -radix hexadecimal sim:/tb_risc_v_lite/im/addr
add wave -radix hexadecimal sim:/tb_risc_v_lite/im/instr

add wave -divider "Data Memory"
add wave -radix hexadecimal sim:/tb_risc_v_lite/data_mem/addr
add wave -radix unsigned sim:/tb_risc_v_lite/data_mem/addr_1
add wave -radix unsigned sim:/tb_risc_v_lite/data_mem/addr_2
add wave -radix hexadecimal sim:/tb_risc_v_lite/data_mem/data_out
add wave -radix hexadecimal sim:/tb_risc_v_lite/data_mem/data_in

add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(0)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(1)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(2)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(3)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(4)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(5)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(6)
add wave -radix decimal sim:/tb_risc_v_lite/data_mem/m2(9)

run 1420 ns
