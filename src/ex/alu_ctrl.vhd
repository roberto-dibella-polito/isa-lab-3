-- RISC-V 
-- Execution unit
-- ALU control unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
		if ALU_OP(0) = '0' then
			ALU_CTRL <= "000";
		elsif ALU_OP(1) <= '0' then
			case INSTR_OP is
				when "000" => ALU_CTRL <= "000";
				when "101" => ALU_CTRL <= "001";
				when "111" => ALU_CTRL <= "011";
				when others => ALU_CTRL <= "111";
			end case;
		else
			case INSTR_OP is
				when "000" => ALU_CTRL <= "000";
				when "010" => ALU_CTRL <= "100";
				when "011" => ALU_CTRL <= "010";
				when others => ALU_CTRL <= "111";
			end case;
		end if;
	end process;

end structure;