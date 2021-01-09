-- RISC-V
-- Instruction decode stage
-- Immediate generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_lite_instructions.all;

entity imm_gen is
	port(
		INSTR 		: in std_logic_vector(31 downto 0);
		TO_ALU_CTRL : out std_logic_vector(3 downto 0);
		IMM			: out std_logic_vector(31 downto 0)
	);
end imm_gen;

architecture bhv of imm_gen is

	--signal immediate 		: signed(11 downto 0);
	--signal long_immediate	: signed(19 downto 0);
	signal opcode			: std_logic_vector(4 downto 0);

begin
	
	opcode <= INSTR(6 downto 2); 
	
	imm_generator: process(opcode, INSTR)
		
		variable immediate : signed(11 downto 0);
		variable long_immediate	: signed(19 downto 0);
	
	begin
		
		-- I-type
		if( (opcode = "00000") or (opcode = "00100") ) then
			
			immediate := signed(INSTR(31 downto 20));
			IMM <= std_logic_vector(resize(immediate,32));
			
		-- S-type
		elsif( (opcode = SW_OP) ) then

			immediate := signed(INSTR(31 downto 25) & INSTR(11 downto 7));
			IMM <= std_logic_vector(resize(immediate,32));
			
		-- U-type
		elsif( (opcode = LUI_OP) or (opcode = AUIPC_OP) ) then
		
			long_immediate := signed(INSTR(31 downto 12));
			IMM <= std_logic_vector(resize(long_immediate, 32));
			
		-- J-type
		elsif( opcode = JAL_OP ) then
			
			long_immediate := signed( INSTR(31) & INSTR(19 downto 12) & INSTR(20) & INSTR(30 downto 21) );
			IMM <= std_logic_vector(resize(long_immediate, 32));
		
		-- B-type
		elsif( opcode = BEQ_OP ) then
			
			immediate := signed( INSTR(31) & INSTR(7) & INSTR(30 downto 25) & INSTR(11 downto 8) );
			IMM <= std_logic_vector(resize(immediate,32));
				
		else
			immediate := (others=>'0');
			long_immediate := (others=>'0');
			IMM <= (others=>'0');
		end if;
		
	end process;
	
	TO_ALU_CTRL <= INSTR(30) & INSTR(14 downto 12);
	
end bhv;