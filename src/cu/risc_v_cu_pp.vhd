-- RISC-V
-- Control Unit pipelined

-- Same interface of the non-pipelined one, bt with delayed instructions
-- Schematic followed is the one in PART_3A - Slide 51

library ieee;
use ieee.std_logic_1164.all;

entity risc_v_cu_pp is
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
end risc_v_cu_pp;

architecture structure of risc_v_cu_pp is

	component risc_v_cu
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
	end component;	
	
	signal id_imm_op_out, id_mem_wr_en_out, id_branch_out, id_id_wr_en_out, id_rd_jal_out, id_pc_sel_out : std_logic;
	signal id_alu_op_out, id_wb_sel_out : std_logic_vector(1 downto 0);
	
	signal ex_imm_op_in, ex_mem_wr_en_in, ex_branch_in, ex_id_wr_en_in, ex_rd_jal_in, ex_pc_sel_in : std_logic;
	signal ex_alu_op_in, ex_wb_sel_in : std_logic_vector(1 downto 0);
	
	
	signal ex_mem_wr_en_out, ex_branch_out, ex_rd_jal_out, ex_id_wr_en_out : std_logic;
	signal ex_wb_sel_out, mem_wb_sel_in : std_logic_vector(1 downto 0);
	signal mem_mem_wr_en_in, mem_branch_in, mem_rd_jal_in, mem_id_wr_en_in : std_logic;	

	signal mem_rd_jal_out, mem_id_wr_en_out : std_logic;
	signal wb_rd_jal_in, wb_id_wr_en_in : std_logic;
	signal wb_wb_sel_in, mem_wb_sel_out : std_logic_vector(1 downto 0);

begin

	cu: risc_v_cu port map
		(	CLK			=> CLK,
			RST_n		=> RST_n,
			ASYNC_RST_N	=> ASYNC_RST_N,
			GLOBAL_RST_n=> GLOBAL_RST_n,
			
			-- IF stage controls
			PC_EN		=> PC_EN,
			PC_SEL		=> id_pc_sel_out,
			
			-- ID stage controls
			ID_WR_EN	=> id_id_wr_en_out,
			OPCODE		=> OPCODE,
			RD_JAL		=> id_rd_jal_out,
			
			-- EX stage controls
			IMM_OP		=> id_imm_op_out,
			ALU_OP		=> id_alu_op_out,
			--ZERO		: in std_logic;
			
			-- MEM stage controls
			MEM_WR_EN	=> id_mem_wr_en_out,
			BRANCH		=> id_branch_out,
			
			-- WB stage controls
			WB_SEL		=> id_wb_sel_out
			);

	id_ex_cu_pp: process(CLK, ASYNC_RST_N)
	begin
		if ASYNC_RST_N = '0' then
			
			ex_imm_op_in	<= '0';
			ex_mem_wr_en_in	<= '0'; 
			ex_branch_in	<= '0';
			ex_wb_sel_in	<= (others=>'0');
			ex_id_wr_en_in 	<= '0';
			ex_rd_jal_in 	<= '0';
			ex_alu_op_in 	<= (others=>'0');
			ex_pc_sel_in	<= '0';
		
		elsif (clk'event and clk ='1') then
			if global_rst_n = '0' then
				ex_imm_op_in	<= '0';
				ex_mem_wr_en_in	<= '0'; 
				ex_branch_in	<= '0';
				ex_wb_sel_in	<= (others=>'0');
				ex_id_wr_en_in 	<= '0';
				ex_rd_jal_in 	<= '0';
				ex_alu_op_in 	<= (others=>'0');
				ex_pc_sel_in	<= '0';
			else
				ex_imm_op_in	<= id_imm_op_out;
				ex_mem_wr_en_in	<= id_mem_wr_en_out; 
				ex_branch_in	<= id_branch_out;
				ex_wb_sel_in	<= id_wb_sel_out;
				ex_id_wr_en_in 	<= id_id_wr_en_out;
				ex_rd_jal_in 	<= id_rd_jal_out;
				ex_alu_op_in 	<= id_alu_op_out;
				ex_pc_sel_in	<= id_pc_sel_out;
			end if;
		end if;
	end process;
	
	-- EX IN/OUT INTERNAL CONNECTIONS
	
	ex_mem_wr_en_out <= ex_mem_wr_en_in;
	ex_branch_out <= ex_branch_in;
	ex_id_wr_en_out <= ex_id_wr_en_in;
	ex_rd_jal_out <= ex_rd_jal_in;
	ex_wb_sel_out <= ex_wb_sel_in;
	
	ex_mem_cu_pp: process(CLK, ASYNC_RST_N)
	begin
		if ASYNC_RST_N = '0' then

			mem_mem_wr_en_in	<= '0'; 
			mem_branch_in		<= '0';
			mem_wb_sel_in		<= (others=>'0');
			mem_rd_jal_in		<= '0';
			mem_id_wr_en_in		<= '0';
		
		elsif (clk'event and clk ='1') then
			if global_rst_n = '0' then
				mem_mem_wr_en_in	<= '0'; 
				mem_branch_in		<= '0';
				mem_wb_sel_in		<= (others=>'0');
				mem_rd_jal_in		<= '0';
				mem_id_wr_en_in		<= '0';
			else
				mem_mem_wr_en_in	<= ex_mem_wr_en_out; 
				mem_branch_in		<= ex_branch_out;
				mem_wb_sel_in		<= ex_wb_sel_out;
				mem_rd_jal_in		<= ex_rd_jal_out;
				mem_id_wr_en_in		<= ex_id_wr_en_out;
			end if;
		end if;
	end process;

	-- MEM IN/OUT INTERNAL CONNECTIONS
	mem_wb_sel_out <= mem_wb_sel_in;
	mem_rd_jal_out <= mem_rd_jal_in;
	mem_id_wr_en_out <= mem_id_wr_en_in;
	
	mem_wb_cu_pp: process(CLK, ASYNC_RST_N)
	begin
		if ASYNC_RST_N = '0' then

			wb_wb_sel_in	<= (others=>'0'); 
			wb_rd_jal_in	<= '0';  
			wb_id_wr_en_in	<= '0'; 
		
		
		elsif (clk'event and clk ='1') then
			if global_rst_n = '0' then
				wb_wb_sel_in	<= (others=>'0'); 
				wb_rd_jal_in	<= '0';  
				wb_id_wr_en_in	<= '0';
			else
				wb_wb_sel_in	<= mem_wb_sel_out;
				wb_rd_jal_in	<= mem_rd_jal_out; 
				wb_id_wr_en_in	<= mem_id_wr_en_out;
			end if;
		end if;
	end process;



	--------------------------------------------
	-- CONNECTION TO THE OUTPUT
	--------------------------------------------
	
	PC_SEL		<= ex_pc_sel_in;
			
	-- ID stage controls
	ID_WR_EN	<= wb_id_wr_en_in;
	RD_JAL		<= ex_rd_jal_out;
	
	-- EX stage controls
	IMM_OP		<= ex_imm_op_in;
	ALU_OP		<= ex_alu_op_in;
	--ZERO		: in std_logic;
	
	-- MEM stage controls
	MEM_WR_EN	<= mem_mem_wr_en_in;
	BRANCH		<= mem_branch_in;
	
	-- WB stage controls
	WB_SEL		<=	wb_wb_sel_in;
	
end structure;

