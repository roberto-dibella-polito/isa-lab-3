---------------------------------------------------------------------------
-- RISC-V-LITE top level entity
---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity risc_v_dp is
	port
	(	
		CLK			: in std_logic;
		RST_n		: in std_logic;
		
		-- IF stage controls
		PC_EN		: in std_logic;
		PC_SEL		: in std_logic;
		
		-- Instruction Memory
		IM_IN		: out std_logic_vector (31 downto 0);
		IM_OUT		: in std_logic_vector(31 downto 0);

		-- ID stage controls
		WR_EN		: in std_logic;
		ALU_CTRL	: out std_logic_vector(3 downto 0);
		
		-- simulation
		PC_JP		: in std_logic_vector(31 downto 0);
		WR_BACK		: in std_logic_vector(31 downto 0);
		IMMEDIATE	: out std_logic_vector(31 downto 0);
		DATA_RS1	: out std_logic_vector(31 downto 0);
		DATA_RS2	: out std_logic_vector(31 downto 0);
		INSTR_OUT : out std_logic_vector(31 downto 0);
		PC_OUT : out std_logic_vector(31 downto 0)
		
	);
end risc_v_dp;

architecture structure of risc_v_dp is

	component if_stage
		port
		(	CLK		: in std_logic;
			RST_n	: in std_logic;	-- Synchronous reset
			PC_EN	: in std_logic;	-- Program counter register enable
			PC_JP	: in std_logic_vector (31 downto 0);
			IM_IN	: out std_logic_vector (31 downto 0);
			IM_OUT	: in std_logic_vector(31 downto 0);
			INSTR	: out std_logic_vector(31 downto 0);
			PC		: buffer std_logic_vector(31 downto 0);
			PC_SEL	: in std_logic
		);
	end component;
	
	component id_stage
		port
		(	PC_IN			: in std_logic_vector(31 downto 0);
			PC_OUT			: out std_logic_vector(31 downto 0);
			INSTR_IN		: in std_logic_vector(31 downto 0);
			INSTR_OUT		: out std_logic_vector(31 downto 0);
			DATA_WR_BACK	: in std_logic_vector(31 downto 0);
			WR_EN			: in std_logic;
			DATA1_OUT		: out std_logic_vector(31 downto 0);
			DATA2_OUT		: out std_logic_vector(31 downto 0);
			IMMEDIATE		: out std_logic_vector(31 downto 0);
			ALU_CTRL		: out std_logic_vector(3 downto 0);
			CLK			: in std_logic;
			RST_n			: in std_logic
		);
	end component;

	signal instr0, instr1, pc0, pc1, pc2 : std_logic_vector(31 downto 0);

begin

	instr_fetch: if_stage port map 
	(	CLK		=> CLK,
		RST_n	=> RST_n,
		PC_EN	=> PC_EN,
		PC_JP	=> PC_JP,
		IM_IN	=> IM_IN,
		IM_OUT	=> IM_OUT,
		INSTR	=> instr0,
		PC		=> pc0,
		PC_SEL	=> PC_SEL
	);
	
	instr_decode: id_stage port map
	(	PC_IN			=> pc0,
		PC_OUT			=> PC_OUT,
		INSTR_IN		=> instr0,
		INSTR_OUT		=> INSTR_OUT,
		DATA_WR_BACK	=> WR_BACK,
		WR_EN			=> WR_EN,
		DATA1_OUT		=> DATA_RS1,
		DATA2_OUT		=> DATA_RS2,
		IMMEDIATE		=> IMMEDIATE,
		ALU_CTRL		=> ALU_CTRL,
		CLK			=> CLK,		
		RST_n			=> RST_n
	);
	
end structure;
	