-- RISC-V-LITE TESTBENCH

-- Version 2: uses the instruction_memory_v2 entity to ease the simulation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_risc_v_lite is
end tb_risc_v_lite;

architecture bhv of tb_risc_v_lite is
	
	component risc_v_lite
		port
		(
			CLK 		: in std_logic;
			ASYNC_RST_N	: in std_logic;
			RST_N		: in std_logic;
		
			-- INSTRUCTION MEMORY INTERFACE
			IM_IN		: out std_logic_vector (31 downto 0);
			IM_OUT		: in std_logic_vector(31 downto 0);
		
			-- Memory interface
			MEM_IN		: out std_logic_vector(31 downto 0);
			MEM_ADDR	: out std_logic_vector(31 downto 0);
			MEM_OUT 	: in std_logic_vector(31 downto 0);
			MEM_EN		: out std_logic
		);
	end component;

	component clk_gen
		port 
		(	END_SIM : in  std_logic;
			CLK     : out std_logic );
	end component;

	component instruction_memory
		port
		(	ADDR	: in std_logic_vector(31 downto 0);
			INSTR	: out std_logic_vector(31 downto 0)
		);
	end component;

	component mem
		port
		(	ADDR		: in std_logic_vector(31 downto 0);
			DATA_OUT	: out std_logic_vector(31 downto 0);
			DATA_IN		: in std_logic_vector(31 downto 0);
			WR_EN		: in std_logic;
			RST_n		: in std_logic;
			CLK			: in std_logic
		);
	end component;

	component EOF_detector is
	  	port 
		(	CLK, RST_N	: in std_logic;
			DATA 		: in std_logic_vector(31 downto 0);
			END_SIM 	: out std_logic
		);
	end component;

	signal clk, async_rst_n, rst_n, endsim, mem_wr_en, i_mem_en : std_logic;
	signal i_im_in, i_im_out, i_mem_in, i_mem_addr, i_mem_out : std_logic_vector(31 downto 0); 	

begin

	dut: risc_v_lite port map
		(
			CLK 		=> clk,
			ASYNC_RST_N	=> async_rst_n,
			RST_N		=> rst_n,
		
			-- INSTRUCTION MEMORY INTERFACE
			IM_IN		=> i_im_in,
			IM_OUT		=> i_im_out,
		
			-- Memory interface
			MEM_IN		=> i_mem_in,
			MEM_ADDR	=> i_mem_addr,
			MEM_OUT 	=> i_mem_out,
			MEM_EN		=> i_mem_en
		);

	im : instruction_memory port map
		(	ADDR	=> i_im_in,
			INSTR	=> i_im_out
		);
	
	data_mem : mem port map
		(	ADDR		=> i_mem_addr,
			DATA_OUT	=> i_mem_out,
			DATA_IN		=> i_mem_in,
			WR_EN		=> i_mem_en,
			RST_n		=> async_rst_n,
			CLK			=> clk
		);

	clock_gen: clk_gen port map 
		(	END_SIM => endsim,
			CLK     => clk );

	eof: EOF_detector port map 
		(	CLK		=> clk,
			RST_N	=> async_rst_n,
			DATA 	=> i_im_out,
			END_SIM => endsim
		);
	
	-- Test
	test: process
	begin

		async_rst_n <= '0';
		wait for 3 ns;
		async_rst_n <= '1';
		wait for 10000 ns;

	end process;

end bhv;
