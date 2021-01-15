-- RISC-V
-- Write back stage

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wb_stage is
	port(
		PC_IN 		: in std_logic_vector(31 downto 0);
		DATA_RD		: in std_logic_vector(31 downto 0);
		DATA_FWD	: in std_logic_vector(31 downto 0);
		WB_SEL		: in std_logic_vector(1 downto 0);
		DATA_WB		: out std_logic_vector(31 downto 0);
	);
end wb_stage;

architecture structure of mem_stage is

begin

	-- Write-back multiplexer
	mux: process(PC_IN, DATA_RD, DATA_FWD, DATA_WB, WB_SEL)
	begin
		case WB_SEL is
			when "00" => DATA_WB <= DATA_RD;
			when "01" => DATA_WB <= DATA_FWD;
			when "10" => DATA_WB <= PC_IN;
			when others => DATA_WB <= (others => '0');
		end case;
	end process;
	
end structure;
	