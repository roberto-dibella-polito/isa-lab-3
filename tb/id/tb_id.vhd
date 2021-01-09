library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_id is
end tb_id;

architecture bhv of tb_id is

	component clk_gen
		port 
		(	END_SIM : in  std_logic;
			CLK     : out std_logic );
	end component;

	component id_stage
		port(
			PC_IN			: in std_logic_vector(31 downto 0);
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
	
	signal clock	: std_logic;
	signal reset_n	: std_logic;
	
	signal pc_in, pc_out 		: std_logic_vector(31 downto 0);
	signal instr_in, instr_out 	: std_logic_vector(31 downto 0);
	signal wb 					: std_logic_vector(31 downto 0);
	signal wr_en, endsim		: std_logic;
	signal dout1, dout2 		: std_logic_vector(31 downto 0);
	signal imm 					: std_logic_vector(31 downto 0);
	signal alu_ctrl 			: std_logic_vector(3 downto 0);
	
begin

	clock_generator : clk_gen port map
	(	END_SIM => '0',
		CLK		=> clock
	);
	
	DUT: id_stage port map
	(	PC_IN			=> pc_in,
		PC_OUT			=> pc_out,
		INSTR_IN		=> instr_in,
		INSTR_OUT		=> instr_out,
		DATA_WR_BACK	=> wb,
		WR_EN			=> wr_en,
		DATA1_OUT		=> dout1,
		DATA2_OUT		=> dout2,
		IMMEDIATE		=> imm,
		ALU_CTRL		=> alu_ctrl,
		CLK				=> clock,
		RST_n			=> reset_n
	);
	
	memory: data_maker port map
	(	RST_n		=> reset_n,
		CLK  		=> clock,
		DATA 		=> wb,
		ADDRESS		=> instr_in,
		END_SIM 	=> endsim,
		D_READY		=> wr_en
	);
	
	test: process
	begin
		
		-- Reset
		reset_n <= '0';
		pc_in <= (others => '0');
		
		wait for 12 ns;
		reset_n <= '1';
		wait for 160 ns;
		
	end process;
	
end bhv;
	