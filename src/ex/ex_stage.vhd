-- RISC-V
-- Execution stage

-- Purely combinational!
-- add pipeline registers in the main entity

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_stage is
	port (
		PC_IN 		: in std_logic_vector(31 downto 0);
		D1			: in std_logic_vector(31 downto 0);
		D2			: in std_logic_vector(31 downto 0);
		D2_FORWARD	: out std_logic_vector(31 downto 0);
		IMM			: in std_logic_vector(31 downto 0);
		IMM_OP		: in std_logic;
		ALU_OP		: in std_logic_vector(1 downto 0);
		FUNC3		: in std_logic_vector(2 downto 0);
		ALU_OUT		: out std_logic_vector(31 downto 0);
		PC_OUT		: out std_logic_vector(31 downto 0);
		RD_IN		: in std_logic_vector(4 downto 0);
		RD_OUT		: out std_logic_vector(4 downto 0);
		ZERO		: out std_logic
	);
end ex_stage;

architecture structure of ex_stage is
	
	signal operand2 : std_logic_vector(31 downto 0);
	signal control : std_logic_vector(2 downto 0);
	
	component PC_ALU
		port
		(
			IMM_IN 	: in std_logic_vector(31 downto 0);
			PC_IN	: in std_logic_vector(31 downto 0);
			PC_OUT	: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component ALU
		port
		(
			ALU_CTRL 	: in std_logic_vector(2 downto 0);
			D1			: in std_logic_vector(31 downto 0);
			D2			: in std_logic_vector(31 downto 0);
			ALU_OUT		: out std_logic_vector(31 downto 0);
			ZERO		: out std_logic
		);
	end component;
	
	component alu_cu
		port
		(	ALU_OP 		: in std_logic_vector(1 downto 0);
			INSTR_OP	: in std_logic_vector(2 downto 0);
			ALU_CTRL	: out std_logic_vector(2 downto 0)
		);
	end component;
	
begin

	-- Program Counter ALU instantiation
	pc_alu_unit: PC_ALU port map (
		IMM_IN 	=> IMM,
		PC_IN	=> PC_IN,
		PC_OUT	=> PC_OUT
	);
	
	-- Operand2 MUX between D2 and IMM
	op2_mux: process(IMM_OP, D2, IMM)
	begin
		if IMM_OP = '0' then
			operand2 <= D1;
		else
			operand2 <= IMM;
		end if;
	end process;
	
	--  ALU
	ALU_unit: ALU port map (
		ALU_CTRL 	=> control,
		D1			=> D1,
		D2			=> operand2,
		ALU_OUT		=> ALU_OUT,
		ZERO		=> ZERO
	);
	
	-- ALU control unit
	alu_control: alu_cu port map (	
		ALU_OP 		=> ALU_OP,
		INSTR_OP	=> FUNC3,
		ALU_CTRL	=> control
	);
	
	RD_OUT <= RD_IN;
	D2_FORWARD <= D2;
	
end structure;
