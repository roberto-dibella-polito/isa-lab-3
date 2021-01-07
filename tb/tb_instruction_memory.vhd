library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_im is
end tb_im;

architecture bhv of tb_im is

	component instruction_memory
		port
		(	ADDR	: in std_logic_vector(31 downto 0);
			INSTR	: out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal address 	: std_logic_vector(31 downto 0);
	signal dout		: std_logic_vector(31 downto 0);
	
begin

	DUT: instruction_memory port map
	(	ADDR => address,
		INSTR=> dout );
		
	test: process
	begin
		
		address <= (others=>'0');
		wait for 5 ns;
		address <= "00000000000000000000000000000100";
		wait for 5 ns;
		
	end process;
	
end bhv;
	