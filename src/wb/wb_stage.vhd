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
		IMM_IN		: in std_logic_vector(31 downto 0);
		WB_SEL		: in std_logic_vector(1 downto 0);
		DATA_WB		: out std_logic_vector(31 downto 0)
	);
end wb_stage;

architecture structure of wb_stage is

	signal pc_input, data_read, data_forward, data_out : std_logic_vector(31 downto 0);
	signal sel : std_logic_vector(1 downto 0);

begin

	--pc_input <= PC_IN;
	--data_read <= DATA_RD;
	--data_forward <= DATA_FWD;
	--data_out <= DATA_WB;
	--sel <= WB_SEL;

	-- Write-back multiplexer
	mux: process(WB_SEL, PC_IN, DATA_RD, DATA_FWD)
	begin
		case WB_SEL is
			when "00" => DATA_WB <= DATA_RD;
			when "01" => DATA_WB <= DATA_FWD;
			when "10" => DATA_WB <= PC_IN;
			when others => DATA_WB <= (others => IMM_IN);
		end case;
	end process;
	
end structure;
	
