library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_if is
end tb_if;

architecture bhv of tb_if is

	component clk_gen
		port 
		(	END_SIM : in  std_logic;
			CLK     : out std_logic );
	end component;

	component if_stage
		port(
			CLK		: in std_logic;
			RST_n	: in std_logic;	
			PC_EN	: in std_logic;	
			PC_JP	: in std_logic_vector (31 downto 0);
			IM_IN	: out std_logic_vector (31 downto 0);
			IM_OUT	: in std_logic_vector(31 downto 0);
			INSTR	: out std_logic_vector(31 downto 0);
			PC		: buffer std_logic_vector(31 downto 0);
			PC_SEL	: in std_logic
		);
	end component;
	
	component instruction_memory
	port
	(	ADDR	: in std_logic_vector(31 downto 0);
		INSTR	: out std_logic_vector(31 downto 0)
	);
	end component;
	
	signal clock	: std_logic;
	signal reset_n	: std_logic;
	signal pc_enable, pc_selector : std_logic;
	signal instr_memory_in, instr_memory_out, data_out, pc_out, pc_jump : std_logic_vector(31 downto 0);
	
begin

	clock_generator : clk_gen port map
	(	END_SIM => '0',
		CLK		=> clock
	);
	
	DUT: if_stage port map
	(	CLK		=> clock,
		RST_n	=> reset_n,
		PC_EN	=> pc_enable,	
		PC_JP	=> pc_jump,
		IM_IN	=> instr_memory_in,
		IM_OUT	=> instr_memory_out,
		INSTR	=> data_out,
		PC		=> pc_out,
		PC_SEL	=> pc_selector
	);
	
	memory: instruction_memory port map
	(	ADDR	=> instr_memory_in,
		INSTR	=> instr_memory_out
	);
	
	test: process
	begin
		
		-- Reset
		reset_n <= '0';
		pc_enable <= '1';
		pc_selector <= '0';
		wait for 12 ns;
		reset_n <= '1';
		wait for 58 ns;
		
		-- Test for the jump selector
		pc_jump <= std_logic_vector(to_unsigned(40,32));
		wait for 30 ns;
		
	end process;
	
end bhv;
	