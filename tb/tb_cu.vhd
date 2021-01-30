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
			END_SIM 	: out std_logic;
			D_READY		: out std_logic
		);
	end component;
	
	signal clk, rst_n, g_rst_n, async_rst_n, endsim, pc_en, pc_sel, id_wr_en, rd_jal, imm_op, mem_wr_en, zero, d_ready: std_logic;
	signal opcode : std_logic_vector(4 downto 0);
	signal data : std_logic_vector(31 downto 0);
	signal wb_sel, alu_op : std_logic_vector(1 downto 0);

begin

	clkgen: clk_gen port map
	(	END_SIM => endsim,
		CLK     => clk );
	
	datamaker: data_maker port map (
		RST_n		=> g_rst_n,
		CLK  		=> clk,
		DATA 		=> data,
		END_SIM 	=> endsim,
		D_READY		=> d_ready
	);
	
	dut: risc_v_cu port map
	(	CLK			=> clk,
		RST_n		=> rst_n,
		ASYNC_RST_N	=> async_rst_n,
		GLOBAL_RST_n=> g_rst_n,
		
		-- IF stage controls
		PC_EN		=> pc_en,
		PC_SEL		=> pc_sel,
		
		-- ID stage controls
		ID_WR_EN	=> id_wr_en,
		OPCODE		=> opcode,
		RD_JAL		=> rd_jal,
		
		-- EX stage controls
		IMM_OP		=> imm_op,
		ALU_OP		=> alu_op,
		ZERO		=> zero,
		
		-- MEM stage controls
		MEM_WR_EN	=> mem_wr_en,
		
		-- WB stage controls
		WB_SEL		=> wb_sel
	);
	
	opcode <= data(6 downto 2);

	test: process
	begin
		
		g_rst_n <= '0';
		async_rst_n <= '0';
		wait for 4 ns;
		async_rst_n <= '1';
		wait for 2 ns;
		g_rst_n <= '1';
		wait for 5000 ns;
	end process;

end bhv;
