-- RISC-V 
-- Execution unit
-- ALU control unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_lite_alu_ctrl.all;

entity alu_cu is
	port
	(	ALU_OP 		: in std_logic_vector(1 downto 0);
		INSTR_OP	: in std_logic_vector(2 downto 0);
		ALU_CTRL	: out std_logic_vector(2 downto 0)
	);
end alu_cu;

architecture structure of alu_cu is

begin
	
	LUT: process(ALU_OP, INSTR_OP)
	begin
		case ALU_OP is
			--when "00" => ALU_CTRL <= ALU_ADD;
			when "01" => 
				
				case INSTR_OP is
					when "111" => ALU_CTRL <= ALU_AND;
					when "101" => ALU_CTRL <= ALU_SHIFT;
					when others => ALU_CTRL <= ALU_ADD;
				end case;	
				
			when "10" =>
			
				case INSTR_OP is
					when "010" => ALU_CTRL <= ALU_COMPARE;
					when "100" => ALU_CTRL <= ALU_XOR;
					when others => ALU_CTRL <= ALU_ADD;
				end case;
				
			when "11" => ALU_CTRL <= ALU_MOD;
			
			when others => ALU_CTRL <= ALU_ADD;
		end case;
					
	end process;

end structure;