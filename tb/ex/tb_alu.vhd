-- ALU testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end tb_alu;

architecture bhv of tb_alu is

	component ALU 
		port
		(
			ALU_CTRL 	: in std_logic_vector(2 downto 0);
			D1			: in std_logic_vector(31 downto 0);
			D2			: in std_logic_vector(31 downto 0);
			ALU_OUT		: out std_logic_vector(31 downto 0);
			ZERO		: out std_logic
		);
	end component;
	
	signal d1, d2, alu_out : std_logic_vector(31 downto 0);
	signal alu_ctrl : std_logic_vector(2 downto 0);
	signal zero: std_logic;
	
begin

	DUT: ALU port map
	(
		ALU_CTRL 	=> alu_ctrl,
		D1			=> d1,
		D2			=> d2,
		ALU_OUT		=> alu_out,
		ZERO		=> zero
	);

	test: process
	begin
		
		-- Adder test
		alu_ctrl <= "000";
		d1 <= std_logic_vector(to_signed(54,32));
		d2 <= std_logic_vector(to_signed(163,32));
		wait for 10 ns;
		
		-- AND test
		alu_ctrl <= "001";
		wait for 10 ns;
		
		-- XOR test
		alu_ctrl <= "010";
		wait for 10 ns;
		
		-- Compare test
		alu_ctrl <= "100";
		wait for 10 ns;
		d1 <= std_logic_vector(to_signed(50987,32));
		wait for 10 ns;
		d2 <= std_logic_vector(to_signed(5,32));
		wait for 10 ns;
		
		-- Shift test
		alu_ctrl <= "011";
		wait for 10 ns;
		
	end process;
	
end bhv;