library ieee;
use ieee.std_logic_1164.all;

package riscv_lite_alu_ctrl is

constant ALU_CTRL_SIZE : integer := 3;

constant ALU_ADD 		: std_logic_vector(2 downto 0) := "000";
constant ALU_AND 		: std_logic_vector(2 downto 0) := "001";
constant ALU_XOR 		: std_logic_vector(2 downto 0) := "010";
constant ALU_SHIFT 		: std_logic_vector(2 downto 0) := "011";
constant ALU_COMPARE	: std_logic_vector(2 downto 0) := "100";

end riscv_lite_alu_ctrl;