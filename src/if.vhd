-----------------------------------------------------------------------
-- RISC-V: INSTRUCTION FETCH STAGE
--
-- Instruction memory is not included. It has to be added from outside
-- as component in the testbench
-- 
-- PORTS DESCRIPTION
-- CLK : clock signal
-- RST_n : synchronous reset
-- PC_EN : program counter enable
-- PC_JP : Input for the program counter used for jumps
-- IM_IN : port connector to the input port of the Instruction Memory
-- IM_OUT: port connector to the output port of the Instruction Memory
-- INSTR : Output connecting the instruction memory to the output
-- PC		: Program counter output
-- PC_SEL: Program counter selector signal
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use ieee.std_logic_arith.all;


entity if_stage is
	port(
		CLK		: in std_logic;
		RST_n		: in std_logic;	-- Synchronous reset
		PC_EN		: in std_logic;	-- Program counter register enable
		PC_JP		: in std_logic_vector (31 downto 0);
		IM_IN		: out std_logic_vector (31 downto 0);
		IM_OUT	: in std_logic_vector(31 downto 0);
		INSTR		: out std_logic_vector(31 downto 0);
		PC			: buffer std_logic_vector(31 downto 0);
		PC_SEL	: in std_logic
	);
end if_stage;

architecture bhv of if_stage is

	signal next_pc : std_logic_vector(31 downto 0); -- Next PC value
	signal pc_incr : std_logic_vector(31 downto 0); -- PC incremented by 4
	
begin
	
	-- Program counter selection mux
	
	pc_selector: process(pc_sel,pc_incr,PC_JP)
	begin
		
		if PC_SEL = '0' then next_pc <= pc_incr;
		else next_pc <= PC_JP;
		end if;
		
	end process;
	
	-- PROGRAM COUNTER REGISTER
	PC_reg : process(clk)
	begin
		if CLK'event and CLK = '1' then
			if RST_n = '0' then PC <= (others => '0');
			elsif PC_EN = '1' then
					PC <= next_pc;
			end if;
		end if;
	
	end process;
	
	-- INCREMENTER
	-- Increments the program counter by 4
	
	INCREMENTER: process(PC)
	begin
		
		pc_incr <= unsigned(PC) + 4;
		
	end process incrementer;
	
	-- Instruction Memory interface
	IM_IN <= PC;
	INSTR <= IM_OUT;

end bhv;	

