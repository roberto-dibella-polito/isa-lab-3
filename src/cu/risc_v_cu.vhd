-- RISC-V-LITE
-- Control Unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_lite_instructions.all;
use work.riscv_lite_alu_ctrl.all;

entity risc_v_cu is
	port
	(	CLK			: in std_logic;
		RST_n		: out std_logic;
		ASYNC_RST_N	: in std_logic;
		GLOBAL_RST_n: in std_logic;
		
		-- IF stage controls
		PC_EN		: out std_logic;
		PC_SEL		: out std_logic;
		
		-- ID stage controls
		ID_WR_EN	: out std_logic;
		OPCODE		: in std_logic_vector(4 downto 0);
		RD_JAL		: out std_logic;
		
		-- EX stage controls
		IMM_OP		: out std_logic;
		ALU_OP		: out std_logic_vector(1 downto 0);
		--ZERO		: in std_logic;
		
		-- MEM stage controls
		MEM_WR_EN	: out std_logic;
		BRANCH		: out std_logic;
		
		-- WB stage controls
		WB_SEL		: out std_logic_vector(1 downto 0)
	);
end risc_v_cu;

architecture fsm of risc_v_cu is

	type state_type is (LW,ROTR,IMM,AUIPC,SW,OP,LUI,BEQ,JAL,NOP);
	
	signal state, next_state : state_type := NOP;

begin

	-- Next state generation
	next_state_gen: process(OPCODE)
	begin
		case OPCODE is
			
			when LW_OP => next_state <= LW;
			when ROR_OP => next_state <= ROTR;
			when ADDI_OP => next_state <= IMM;
			when AUIPC_OP => next_state <= AUIPC;
			when SW_OP => next_state <= SW;
			when ADD_OP => next_state <= OP;
			when LUI_OP => next_state <= LUI;
			when BEQ_OP => next_state <= BEQ;
			when JAL_OP => next_state <= JAL;
			when others => next_state <= NOP;
			
		end case;
		
	end process;

	-- State transition
	state_transition: process(CLK, ASYNC_RST_N)
	begin
		
		if ASYNC_RST_N = '0' then
			state <= NOP;
		elsif CLK'event and CLK = '1' then
			if GLOBAL_RST_n = '0' then 
				state <= NOP;
			else
				state <= next_state;
			end if;
		end if;
	end process;
			
	-- Output Generation
	
	out_gen: process(state)
	begin	
		case state is 
		
			when LW => 

				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_ADD;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "00";
				
			when ROTR =>
				
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_ROTR;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "01";
				
			when IMM =>
			
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_IMM;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "01";
				
			when AUIPC =>
			
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_ADD;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "10";
				
			when SW =>
			
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '0';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_IMM;
				--------------------------- MEM
				MEM_WR_EN	<= '1';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "11";
				
			when OP =>
			
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '0';
				ALU_OP		<= ALU_OP_OP;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "01";
				
			when LUI =>
			
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_ADD;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "11";
				
			when BEQ =>
			
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '0';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_ADD;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '1';
				--------------------------- WB
				WB_SEL		<= "11";
				
				-- ATTENTION: I should FLUSH the pipeline!
			
			when JAL =>
			
				RST_n		<= '1';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '1';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '1';
				--------------------------- EX
				IMM_OP		<= '1';
				ALU_OP		<= ALU_OP_ADD;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "11";
				
				-- ATTENTION: I should FLUSH the pipeline!

			when others => -- NOP
			
				RST_n		<= '0';
				--------------------------- IF 
				PC_EN		<= '1';
				PC_SEL		<= '0';				
				--------------------------- ID
				ID_WR_EN	<= '1';
				RD_JAL		<= '0';
				--------------------------- EX
				IMM_OP		<= '0';
				ALU_OP		<= ALU_OP_ADD;
				--------------------------- MEM
				MEM_WR_EN	<= '0';
				BRANCH		<= '0';
				--------------------------- WB
				WB_SEL		<= "00";
				
		end case;
		
	end process;
end fsm;
