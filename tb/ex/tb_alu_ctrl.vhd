-- ALU testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu_ctrl is
end tb_alu_ctrl;

architecture bhv of tb_alu_ctrl is

	component alu_cu
		port
		(	ALU_OP 		: in std_logic_vector(1 downto 0);
			INSTR_OP	: in std_logic_vector(2 downto 0);
			ALU_CTRL	: out std_logic_vector(2 downto 0)
		);
	end component;
	
	component data_maker
	  port (
		RST_n		: in  std_logic;
		CLK  		: in  std_logic;
		DATA 		: out std_logic_vector(31 downto 0);
		END_SIM 	: out std_logic;
		D_READY		: out std_logic
		);
	end component;
	
	component clk_gen
	  port (
		END_SIM : in  std_logic;
		CLK     : out std_logic);
	end component;
	
	signal clk , rst_en, endsim, d_ready : std_logic;
	signal data 	: std_logic_vector(31 downto 0);
	signal alu_op 	: std_logic_vector(1 downto 0);
	signal alu_ctrl, instr_op : std_logic_vector(2 downto 0);
	
begin

	alu_op <= data(5 downto 4);
	instr_op <= data(14 downto 12);

	DUT: alu_cu port map 
	(	ALU_OP 		=> alu_op,
		INSTR_OP	=> instr_op,
		ALU_CTRL	=> alu_ctrl
	);
	
	clock: clk_gen port map (
		END_SIM => endsim,
		CLK     => clk 
	);
		
	dm: data_maker port map
	(	RST_n		=> rst_en,
		CLK  		=> clk,
		DATA 		=> data,
		END_SIM 	=> endsim,
		D_READY		=> d_ready
	);
		

	test: process
	begin

		rst_en <= '0';
		wait for 5 ns;
		rst_en <= '1';
		wait for 350 ns;
		
	end process;
	
end bhv;