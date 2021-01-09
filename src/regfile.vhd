-- RISC-V
-- Decode stage
-- Register file
-- The memory has synchronous write, asynchronous read

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
	port
	(	RS1			: in std_logic_vector(4 downto 0);
		RS2			: in std_logic_vector(4 downto 0);
		RD			: in std_logic_vector(4 downto 0);
		DATA_IN		: in std_logic_vector(31 downto 0);
		WR_EN		: in std_logic;
		DATA1_OUT	: out std_logic_vector(31 downto 0);
		DATA2_OUT	: out std_logic_vector(31 downto 0);
		RST_n			: in std_logic;
		CLK			: in std_logic
	);
end regfile;

architecture bhv of regfile is

	type mem_array is array(0 to 31) of std_logic_vector(31 downto 0);
	
	signal reg_file : mem_array;

begin
	
	memory: process(CLK, RST_n)
	begin
		
		if(CLK'event and CLK = '1') then	
			
			if(RST_n = '0') then
				reg_file <= (OTHERS => (OTHERS => '0'));
			elsif( WR_EN = '1') then
				reg_file(to_integer(unsigned(RD))) <= DATA_IN;
			end if;
		
		end if;
	
	end process;
				
	
	-- Data Read
	DATA1_OUT <= reg_file(to_integer(unsigned(RS1)));
	DATA2_OUT <= reg_file(to_integer(unsigned(RS2)));		
	
end bhv;	
