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

entity data_maker is
  port (
	RST_n		: in  std_logic;
    CLK  		: in  std_logic;
    DATA 		: out std_logic_vector(31 downto 0);
	END_SIM 	: out std_logic;
	D_READY		: out std_logic);
end data_maker;


architecture beh of data_maker is

	signal sEndSim : std_logic;
	signal END_SIM_i : std_logic_vector(0 to 10);

begin  -- beh

    rd_file: process (CLK)
	
		file fp1 : text open read_mode is "/home/isa32/DELIVER/isa-lab-3/tb/machine.hex";
		variable ptr1, ptr2 : line;
		variable val1, val2 : std_logic_vector(31 downto 0);
	
	begin  -- process

		if RST_n = '0' then
			sEndSim <= '0';
			D_READY <= '0';

		elsif CLK'event and CLK = '1' then  -- rising clock edge
			if not(endfile(fp1)) then
				readline(fp1, ptr1);
				hread(ptr1, val1);     
				DATA <= val1;
				
				--readline(fp2, ptr2);
				--hread(ptr2, val2);     
				--ADDRESS <= val2;
				
				
				sEndSim <= '0';
				D_READY <= '1';
			else 
				sEndSim <= '1';
				D_READY <= '0';
			end if;
		end if;
	end process rd_file;
	
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
