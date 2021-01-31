---------------------------------------------------------------------------
-- RISC-V-LITE top level entity
-- Last modification: interface written
---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity risc_v_dp is
	port
	(	
		CLK			: in std_logic;
		RST_n		: in std_logic;
		ASYNC_RST_N	: in std_logic;
		
		-- IF stage controls
		PC_EN		: in std_logic;
		PC_JAL		: in std_logic;
		
		-- Instruction Memory
		IM_IN		: out std_logic_vector (31 downto 0);
		IM_OUT		: in std_logic_vector(31 downto 0);

		-- ID stage controls
		ID_WR_EN	: in std_logic;
		OPCODE		: out std_logic_vector(4 downto 0);
		RD_JAL		: in std_logic;
		
		-- EX stage controls
		IMM_OP		: in std_logic;
		ALU_OP		: in std_logic_vector(1 downto 0);
		ZERO		: out std_logic;
		
		-- MEM stage controls
		MEM_WR_EN	: in std_logic;
		BRANCH		: in std_logic;
		
		-- Memory interface
		MEM_IN		: out std_logic_vector(31 downto 0);
		MEM_ADDR	: out std_logic_vector(31 downto 0);
		MEM_OUT 	: in std_logic_vector(31 downto 0);
		MEM_EN		: out std_logic;
		
		-- WB stage controls
		WB_SEL		: in std_logic_vector(1 downto 0)
		
	);
end risc_v_dp;

architecture structure of risc_v_dp is

	component reg_n 
		generic( N : integer := 8 );
		port
		(	clk			: in std_logic;
			rst_n 		: in std_logic;
			async_rst_n : in std_logic;
			D			: in std_logic_vector(N-1 downto 0);
			Q			: out std_logic_vector(N-1 downto 0)
		);
	end component;

	component if_stage
		port
		(	CLK		: in std_logic;
			RST_n	: in std_logic;	-- Synchronous reset
			PC_EN	: in std_logic;	-- Program counter register enable
			PC_JP	: in std_logic_vector(31 downto 0);
			IM_IN	: out std_logic_vector(31 downto 0);
			IM_OUT	: in std_logic_vector(31 downto 0);
			INSTR	: out std_logic_vector(31 downto 0);
			PC		: buffer std_logic_vector(31 downto 0);
			PC_4		: out std_logic_vector(31 downto 0);
			PC_SEL	: in std_logic
		);
	end component;
	
	component id_stage
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
			RST_n			: in std_logic
		);
	end component;

	component ex_stage
		port 
		(	PC_IN 		: in std_logic_vector(31 downto 0);
			D1			: in std_logic_vector(31 downto 0);
			D2			: in std_logic_vector(31 downto 0);
			D2_FWD		: out std_logic_vector(31 downto 0);
			IMM			: in std_logic_vector(31 downto 0);
			IMM_OUT		: out std_logic_vector(31 downto 0);
			IMM_OP		: in std_logic;
			ALU_OP		: in std_logic_vector(1 downto 0);
			FUNC3		: in std_logic_vector(2 downto 0);
			ALU_OUT		: out std_logic_vector(31 downto 0);
			PC_OUT		: out std_logic_vector(31 downto 0);
			RD_IN		: in std_logic_vector(4 downto 0);
			RD_OUT		: out std_logic_vector(4 downto 0);
			ZERO		: out std_logic
		);
	end component;
	
	component mem_stage
		port
		(	ALU_OUT : in std_logic_vector(31 downto 0);
			FORWARD	: out std_logic_vector(31 downto 0);
			DATA_WR	: in std_logic_vector(31 downto 0);
			WR_EN	: in std_logic;
			DATA_RD	: out std_logic_vector(31 downto 0);
			
			BRANCH	: in std_logic;
			ZERO	: in std_logic;
			BRANCH_T: out std_logic;
			
			IMM_IN	: in std_logic_vector(31 downto 0);
			IMM_OUT	: out std_logic_vector(31 downto 0);
			
			PC_IN	: in std_logic_vector(31 downto 0);
			PC_OUT	: out std_logic_vector(31 downto 0);
			
			RD_IN	: in std_logic_vector(4 downto 0);
			RD_OUT	: out std_logic_vector(4 downto 0);
			
			-- Memory interface
			MEM_IN	: out std_logic_vector(31 downto 0);
			MEM_ADDR: out std_logic_vector(31 downto 0);
			MEM_OUT : in std_logic_vector(31 downto 0);
			MEM_EN	: out std_logic
		);
	end component;
	
	component wb_stage
		port
		(	PC_IN 		: in std_logic_vector(31 downto 0);
			DATA_RD		: in std_logic_vector(31 downto 0);
			DATA_FWD	: in std_logic_vector(31 downto 0);
			IMM_IN		: in std_logic_vector(31 downto 0);
			WB_SEL		: in std_logic_vector(1 downto 0);
			DATA_WB		: out std_logic_vector(31 downto 0)
		);
	end component;
	
	
	signal if_id_instr, if_pc_out, if_pc4_out_1, if_pc4_out2 : std_logic_vector(31 downto 0);
	signal if_pc_jump : std_logic;
	
	signal id_pc_in, id_pc_out, id_data1_out, id_data2_out, id_imm_out, id_pc_4_in : std_logic_vector(31 downto 0);
	signal id_rd_out : std_logic_vector(4 downto 0);
	signal id_alu_ctrl_out: std_logic_vector(2 downto 0);
	
	signal ex_pc_in, ex_pc_out, ex_data1_in, ex_data2_in, ex_imm_in, ex_imm_out, ex_alu_out, ex_fwd_out : std_logic_vector(31 downto 0);
	signal ex_alu_ctrl_in : std_logic_vector(2 downto 0);
	signal ex_rd_in, ex_rd_out : std_logic_vector(4 downto 0);
	signal ex_zero_out : out std_logic;
	
	signal mem_rd_in, mem_rd_out : std_logic_vector(4 downto 0);
	signal mem_imm_in, mem_imm_out, mem_pc_in, mem_pc_out, mem_data_out, mem_fwd_out, mem_alu_in, mem_data_in : std_logic_vector(31 downto 0);
	signal mem_if_branch_t, mem_zero_in : std_logic;

	
	signal wb_imm_in, wb_data_out, wb_pc_in, wb_data_in, wb_fwd_in : std_logic_vector(31 downto 0);
	signal wb_rd_out : std_logic_vector(4 downto 0);
	
begin
	
	----------------------------------------------------
	-- INSTRUCTION FETCH STAGE
	----------------------------------------------------
	
	if_pc_jump <= PC_JAL or mem_if_branch_t;

	instr_fetch: if_stage port map 
	(	CLK		=> CLK,
		RST_n	=> RST_n,
		PC_EN	=> PC_EN,
		PC_JP	=> ex_pc_out,
		IM_IN	=> IM_IN,
		IM_OUT	=> IM_OUT,
		INSTR	=> if_id_instr,
		PC		=> if_pc_out,
		PC_4	=> if_pc4_out_1,
		PC_SEL	=> if_pc_jump
	);
	
	-----------------------------------------------------
	-- IF-ID PIPELINING
	-- INSTR is internally pipelined in ID
	-- Signal to be pipelined: PC
	-----------------------------------------------------
	
	if_id_pp: process(CLK, ASYNC_RST_N)
	begin
		
		if ASYNC_RST_N = '0' then
		
			id_pc_in 	<= (others=>'0');
			if_pc4_out2	<= (others=>'0');
		
		elsif (clk'event and clk ='1') then
			if rst_n = '0' then
				id_pc_in 	<= (others=>'0');
				if_pc4_out2	<= (others=>'0');
			else
				id_pc_in 	<= if_pc_out;
				if_pc4_out2	<= if_pc4_out_1;
			end if;
		end if;
	end process;
	
	pc_4_pp2: process(CLK, ASYNC_RST_N)
	begin
		if ASYNC_RST_N = '0' then

			id_pc_4_in	<= (others=>'0');
		
		elsif (clk'event and clk ='1') then
			if rst_n = '0' then
				id_pc_4_in	<= (others=>'0');
			else
				id_pc_4_in	<= if_pc4_out2;
			end if;
		end if;
	end process;

	-----------------------------------------------------
	-- INSTRUCTION DECODE STAGE
	-----------------------------------------------------
	
	
	instr_decode: id_stage port map
	(	PC_IN			=> id_pc_in,
		PC_OUT			=> id_pc_out,
		INSTR_IN		=> if_id_instr,
		RD_OUT			=> id_rd_out,
		RD_IN			=> wb_rd_out,
		DATA_WR_BACK	=> wb_data_out,
		WR_EN			=> ID_WR_EN,
		DATA1_OUT		=> id_data1_out,
		DATA2_OUT		=> id_data2_out,
		IMMEDIATE		=> id_imm_out,
		OPCODE			=> OPCODE,
		ALU_CTRL		=> id_alu_ctrl_out,
		CLK				=> CLK,
		RST_n			=> RST_n,
		PC_4_IN			=> id_pc_4_in,
		RD_JAL			=> RD_JAL
	);
	
	-----------------------------------------------------
	-- ID-EX PIPELINING
	-- Signal to be pipelined: 	PC_OUT
	--							DATA1_OUT 
	-- 							DATA2_OUT
	--							IMMEDIATE
	--							ALU_CTRL
	--							RD_OUT
	-----------------------------------------------------
	
	id_ex_pp: process(CLK, ASYNC_RST_N)
	begin
		
		if ASYNC_RST_N = '0' then
		
			ex_pc_in <= (others=>'0');
			ex_data1_in <= (others=>'0');
			ex_data2_in <= (others=>'0');
			ex_alu_ctrl_in <= (others=>'0');
			ex_rd_in <= (others=>'0');
			ex_imm_in <= (others=>'0');
		
		elsif (clk'event and clk ='1') then
			if rst_n = '0' then
				ex_pc_in 		<= (others=>'0');
				ex_data1_in 	<= (others=>'0');
				ex_data2_in		<= (others=>'0');
				ex_alu_ctrl_in 	<= (others=>'0');
				ex_rd_in 		<= (others=>'0');
				ex_imm_in 		<= (others=>'0');
			else
				ex_pc_in 		<= id_pc_out;
				ex_data1_in 	<= id_data1_out;
				ex_data2_in 	<= id_data2_out;
				ex_alu_ctrl_in 	<= id_alu_ctrl_out;
				ex_rd_in 		<= id_rd_out;
				ex_imm_in 		<= id_imm_out;
			end if;
		end if;
	end process;
	
	-----------------------------------------------------
	-- EXECUTION STAGE
	-----------------------------------------------------
	
	execute: ex_stage port map
	(	PC_IN 		=> ex_pc_in,
		D1			=> ex_data1_in,
		D2			=> ex_data2_in,
		D2_FWD		=> ex_fwd_out,
		IMM			=> ex_imm_in,
		IMM_OUT		=> ex_imm_out,
		IMM_OP		=> IMM_OP,
		ALU_OP		=> ALU_OP,
		FUNC3		=> ex_alu_ctrl_in,
		ALU_OUT		=> ex_alu_out,
		PC_OUT		=> ex_pc_out,
		RD_IN		=> ex_rd_in,
		RD_OUT		=> ex_rd_out,
		ZERO		=> ZERO
	); 
	
	-----------------------------------------------------
	-- EX-MEM PIPELINING
	-- Signal to be pipelined: 	PC_OUT
	--							ALU_OUT 
	-- 							D2_FWD
	--							RD_OUT
	--							ZERO
	-----------------------------------------------------
	
	ex_mem_pp: process(CLK, ASYNC_RST_N)
	begin
		
		if ASYNC_RST_N = '0' then
		
			mem_pc_in 	<= (others=>'0');
			mem_alu_in 	<= (others=>'0');
			mem_data_in <= (others=>'0');
			mem_rd_in 	<= (others=>'0');
			mem_imm_in	<= (others=>'0');
			mem_zero_in <= (others=>'0');
		
		elsif (clk'event and clk ='1') then
			if rst_n = '0' then
				mem_pc_in 	<= (others=>'0');
				mem_alu_in 	<= (others=>'0');
				mem_data_in <= (others=>'0');
				mem_rd_in 	<= (others=>'0');
				mem_imm_in	<= (others=>'0');
				mem_zero_in <= (others=>'0');
			else
				mem_pc_in 	<= ex_pc_out;
				mem_alu_in 	<= ex_alu_out;
				mem_data_in <= ex_fwd_out;
				mem_rd_in 	<= ex_rd_out;
				mem_imm_in	<= ex_imm_out;
				mem_zero_in <= ex_zero_out;
			end if;
		end if;
	end process;

	-----------------------------------------------------
	-- MEMORY STAGE
	-----------------------------------------------------
	
	memory: mem_stage port map 
	(	ALU_OUT => mem_alu_in,
		FORWARD	=> mem_fwd_out,
		DATA_WR	=> mem_data_in,
		WR_EN	=> MEM_WR_EN,
		DATA_RD	=> mem_data_out,
		
		BRANCH	=> branch,
		ZERO	=> zero,
		BRANCH_T=> mem_if_branch_t,
		
		PC_IN	=> mem_pc_in,
		PC_OUT	=> mem_pc_out,
		
		RD_IN	=> mem_rd_in,
		RD_OUT	=> mem_rd_out,
		
		IMM_IN	=> mem_imm_in,
		IMM_OUT	=> mem_imm_out,
		
		-- Memory interface
		MEM_IN	=> MEM_IN,
		MEM_ADDR=> MEM_ADDR,
		MEM_OUT => MEM_OUT,
		MEM_EN	=> MEM_EN
	);

	-----------------------------------------------------
	-- MEM-WB PIPELINING
	-- Signal to be pipelined: 	PC_OUT
	--							DATA_RD 
	-- 							FORWARD
	-----------------------------------------------------
	
	mem_wb_pp: process(CLK, ASYNC_RST_N)
	begin
		
		if ASYNC_RST_N = '0' then
		
			wb_pc_in 	<= (others=>'0');
			wb_data_in 	<= (others=>'0');
			wb_fwd_in 	<= (others=>'0');
			wb_rd_out	<= (others=>'0');
			wb_imm_in	<= (others=>'0');
		elsif (clk'event and clk ='1') then
			if rst_n = '0' then
				wb_pc_in 	<= (others=>'0');
				wb_data_in 	<= (others=>'0');
				wb_fwd_in 	<= (others=>'0');
				wb_rd_out	<= (others=>'0');
				wb_imm_in	<= (others=>'0');
			else
				wb_pc_in 	<= mem_pc_out;
				wb_data_in 	<= mem_data_out;
				wb_fwd_in 	<= mem_fwd_out;
				wb_rd_out	<= mem_rd_out;
				wb_imm_in	<= mem_imm_out;
			end if;
		end if;
	end process;
	
	-----------------------------------------------------
	-- WRITE BACK STAGE
	-----------------------------------------------------
	
	write_back: wb_stage port map 
	(	PC_IN 		=> wb_pc_in,
		DATA_RD		=> wb_data_in,
		DATA_FWD	=> wb_fwd_in,
		IMM_IN		=> wb_imm_in,
		WB_SEL		=> WB_SEL,
		DATA_WB		=> wb_data_out
	);
	
end structure;
	