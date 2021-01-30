-- RISC-V-LITE
-- CONTROL UNIT TESTBENCH

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_risc_v_cu is
end tb_risc_v_cu;

architecture bhv of tb_risc_v_cu is

	component clk_gen
		port 
		(	END_SIM : in  std_logic;
			CLK     : out std_logic );
	end component;

	component risc_v_cu is
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
			ZERO		: in std_logic;
			
			-- MEM stage controls
			MEM_WR_EN	: out std_logic;
			
			-- WB stage controls
			WB_SEL		: out std_logic_vector(1 downto 0)
		);
	end component;
	
	component data_maker is
		port (
			RST_n		: in  std_logic;
			CLK  		: in  std_logic;
			DATA 		: out std_logic_vector(31 downto 0);
			ADDRESS		: out std_logic_vector(31 downto 0);
			END_SIM 	: out std_logic;
			D_READY		: out std_logic
		);
	end component;
	
	signal 
begin