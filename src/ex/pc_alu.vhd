-- RISC-V
-- Execution stage
-- Program Counter ALU: computes addresses and PC-relative addresses

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ALU is
	port
	(
		IMM_IN 	: in std_logic_vector(31 downto 0);
		PC_IN	: in std_logic_vector(31 downto 0);
		PC_OUT	: out std_logic_vector(31 downto 0)
	);
end PC_ALU;

architecture bhv of PC_ALU is

	signal imm_shifted : std_logic_vector(31 downto 0);
	
begin

	-- Shifter
	imm_shifted <= IMM_IN(30 downto 0) & '0';
	
	-- Adder
	PC_OUT <= std_logic_vector(signed(PC_IN) + signed(imm_shifted));
	
end bhv;
	
		