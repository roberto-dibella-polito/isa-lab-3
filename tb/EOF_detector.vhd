----------------------------------------------------------------
-- DATA MAKER
-- It reads, line by line, the samples stored into the the file
-- "fp_samples.hex" and sends it to the DUT from the DATA port.
-- The END_SIM output signal is raised after 10 clock cycles
-- from the reaching of EOF.
-- D_READY is raised every team a new valid data is 
-- read from the input file.
--
-- Project: Lab 2
-- Authors: Group 32 (Chatrasi, Di Bella, Zangeneh)
-- Last modified: 8/12/2020 16:35
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity EOF_detector is
  port (
	CLK, RST_N	: in std_logic;
    DATA 		: in std_logic_vector(31 downto 0);
	END_SIM 	: out std_logic
	);
end EOF_detector;


architecture beh of EOF_detector is

	signal sEndSim : std_logic;
	signal END_SIM_i : std_logic_vector(0 to 10);

begin  -- beh

    rd_data: process (CLK)
	begin
		if unsigned(DATA) = 0 then
			sEndSim <= '1';
		else 
			sEndSim <= '0';
		end if;
	end process rd_data;
	
	shift_count: process (CLK, RST_n)
	
	begin  -- process
		if RST_n = '0' then                 -- asynchronous reset (active low)
			END_SIM_i <= (others => '0');
		elsif CLK'event and CLK = '1' then  -- rising clock edge
			END_SIM_i(0) <= sEndSim;
			END_SIM_i(1 to 10) <= END_SIM_i(0 to 9);
		end if;
	end process shift_count;

  	END_SIM <= END_SIM_i(10);

end beh;
