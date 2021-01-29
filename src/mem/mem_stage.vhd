-- RISC-V
-- Memory stage

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_stage is
	port(
		ALU_OUT : in std_logic_vector(31 downto 0);
		FORWARD	: out std_logic_vector(31 downto 0);
		DATA_WR	: in std_logic_vector(31 downto 0);
		WR_EN	: in std_logic;
		DATA_RD	: out std_logic_vector(31 downto 0);
		
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
end mem_stage;

architecture structure of mem_stage is

begin

	-- Memory connections
	MEM_ADDR <= ALU_OUT;
	MEM_IN <= DATA_WR;
	DATA_RD <= MEM_OUT;
	MEM_EN <= WR_EN;
	
	-- Forwarding
	FORWARD <= ALU_OUT;
	
	RD_OUT <= RD_IN;
	PC_OUT <= PC_IN;
	
end structure;
	
	
	
