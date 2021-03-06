-- RISC-V
-- Instruction Decode stage

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_stage is
	port
	(	PC_IN			: in std_logic_vector(31 downto 0);
		PC_4_IN			: in std_logic_vector(31 downto 0);
		PC_OUT			: out std_logic_vector(31 downto 0);
		INSTR_IN		: in std_logic_vector(31 downto 0);
		--INSTR_OUT		: out std_logic_vector(31 downto 0);
		RD_OUT			: out std_logic_vector(4 downto 0);
		RD_IN			: in std_logic_vector(4 downto 0);
		DATA_WR_BACK	: in std_logic_vector(31 downto 0);
		WR_EN			: in std_logic;
		DATA1_OUT		: out std_logic_vector(31 downto 0);
		DATA2_OUT		: out std_logic_vector(31 downto 0);
		IMMEDIATE		: out std_logic_vector(31 downto 0);
		OPCODE			: out std_logic_vector(4 downto 0);
		ALU_CTRL		: out std_logic_vector(2 downto 0);
		
		RD_JAL			: in std_logic;
		
		CLK				: in std_logic;
		ASYNC_RST_N 	: in std_logic;
		RST_n			: in std_logic;
		INSTR_RST_N		: in std_logic
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
			ASYNC_RST_N : in std_logic;
			CLK			: in std_logic
		);
	end component;
	
	signal instruction,progcount : std_logic_vector(31 downto 0);
	signal rd_pipeline : std_logic_vector(4 downto 0);
	signal regfile_data_in : std_logic_vector(31 downto 0); 
	
begin	

	-- INPUT MUX
	-- To choose between regular instructions and JAL
	
	mux : process(DATA_WR_BACK,PC_4_IN,RD_JAL)
	begin
		if RD_JAL = '1' then
			regfile_data_in <= PC_4_IN;
		else
			regfile_data_in <= DATA_WR_BACK;
		end if;
	end process;
	
	-- Register File
	
	memory: regfile port map
	(	RS1			=> instruction(19 downto 15),
		RS2			=> instruction(24 downto 20),
		RD			=> RD_IN,
		DATA_IN		=> regfile_data_in,
		WR_EN		=> WR_EN,
		DATA1_OUT	=> DATA1_OUT,
		DATA2_OUT	=> DATA2_OUT,
		RST_n		=> RST_n,
		ASYNC_RST_N => ASYNC_RST_N,
		CLK			=> CLK
	); 
	
	-- Instruction pipeline register
	instruction_reg: process(CLK, ASYNC_RST_N)
	begin
		if(ASYNC_RST_n = '0') then
			instruction <= (others => '0');
		elsif( CLK'event and CLK = '1') then
			if(RST_n = '0' or INSTR_RST_N ='0') then
				instruction <= (others => '0');
			else
				instruction <= INSTR_IN;
			end if;
		end if;
	end process;
	
	ALU_CTRL 	<= instruction(14 downto 12);
	RD_OUT 		<= instruction(11 downto 7);
	OPCODE 		<= INSTR_IN(6 downto 2);
	
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
	
	--INSTR_OUT <= instruction;
	PC_OUT <= PC_IN;

end bhv;
