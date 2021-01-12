-- RISC-V
-- Instruction Decode stage

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_stage is
	port
	(	PC_IN			: in std_logic_vector(31 downto 0);
		PC_OUT			: out std_logic_vector(31 downto 0);
		INSTR_IN		: in std_logic_vector(31 downto 0);
		INSTR_OUT		: out std_logic_vector(31 downto 0);
		RD_OUT			: out std_logic_vector(4 downto 0);
		RD_IN			: in std_logic_vector(4 downto 0);
		DATA_WR_BACK	: in std_logic_vector(31 downto 0);
		WR_EN			: in std_logic;
		DATA1_OUT		: out std_logic_vector(31 downto 0);
		DATA2_OUT		: out std_logic_vector(31 downto 0);
		IMMEDIATE		: out std_logic_vector(31 downto 0);
		OPCODE			: out std_logic_vector(6 downto 0);
		ALU_CTRL		: out std_logic_vector(2 downto 0);
		CLK				: in std_logic;
		RST_n			: in std_logic
	);
end id_stage;

architecture bhv of id_stage is

	component imm_gen
		port(
			INSTR 		: in std_logic_vector(31 downto 0);
			IMM			: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component regfile
		port
		(	RS1			: in std_logic_vector(4 downto 0);
			RS2			: in std_logic_vector(4 downto 0);
			RD			: in std_logic_vector(4 downto 0);
			DATA_IN		: in std_logic_vector(31 downto 0);
			WR_EN		: in std_logic;
			DATA1_OUT	: out std_logic_vector(31 downto 0);
			DATA2_OUT	: out std_logic_vector(31 downto 0);
			RST_n		: in std_logic;
			CLK			: in std_logic
		);
	end component;
	
	signal instruction,progcount : std_logic_vector(31 downto 0);
	signal rd_pipeline : in std_logic_vector(4 downto 0);
	
begin	
	
	memory: regfile port map
	(	RS1			=> INSTR_IN(19 downto 15),
		RS2			=> INSTR_IN(24 downto 20),
		RD			=> RD_IN,
		DATA_IN		=> DATA_WR_BACK,
		WR_EN		=> WR_EN,
		DATA1_OUT	=> DATA1_OUT,
		DATA2_OUT	=> DATA2_OUT,
		RST_n		=> RST_n,
		CLK			=> CLK
	); 
	
	-- Instruction pipeline register
	instruction_reg: process(CLK, RST_n)
	begin
		if(RST_n = '0') then
			instruction <= (others => '0');
		elsif( CLK'event and CLK = '1') then
			instruction <= INSTR_IN;
		end if;
	end process;
	
	ALU_CTRL 	<= instruction(14 downto 12);
	RD_OUT 		<= instruction(11 downto 7);
	OPCODE 		<= instruction(6 downto 0);
	
	imm_generator: imm_gen port map
	(
		INSTR 		=> instruction,
		IMM			=> IMMEDIATE
	);
	
	--pc_reg: process(CLK, RST_n)
	--begin
	--	
	--	if(RST_n = '0') then
	--		progcount <= (others => '0');
	--	elsif( CLK'event and CLK = '1') then
	--		progcount <= PC_IN;
	--	end if;
	--end process;
	
	INSTR_OUT <= instruction;
	PC_OUT <= PC_IN;

end bhv;