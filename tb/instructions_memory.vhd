-- Instruction memory definition

-- Read bit strings from a binary file
-- ONE BYTE PER LINE
-- Subdivision in two arrays of 2**16

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity instruction_memory is
	port
	(	ADDR	: in std_logic_vector(31 downto 0);
		INSTR	: out std_logic_vector(31 downto 0)
	);
end instruction_memory;

architecture bhv of instruction_memory is
	
	type byte_array is array (0 to 3) of std_logic_vector(7 downto 0);
	
	signal data_out: std_logic_vector(31 downto 0);
	signal b : byte_array;
	
	
	-- Memory depth
	constant ram_depth : integer := 5;
	
	-- Memory type definition
	type mem_type is array (0 to (2**16)-1) of bit_vector(7 downto 0);
	
	-- Memory intialization function 
	impure function init_ram_hex return  mem_type is
		file text_file : text open READ_MODE is "C:\intelFPGA_lite\18.1\Projects\ISA\Lab3\instr_memory.txt";
		variable text_line : line;
		variable ram_content : mem_type;
	    begin
		    for i in 0 to (2**16)-1 loop
				if not endfile(text_file) then
					readline(text_file, text_line);
					read(text_line, ram_content(i));
				else
					ram_content(i) := (others=>'0');
				end if;
		  end loop;
		
		return ram_content;
	end function;
	
	signal M1,M2 : mem_type := init_ram_hex;
	
	signal addr0, addr2 : unsigned(31 downto 0);
	
begin
	
	memory_sel: process(ADDR)	
	begin
		
		if unsigned(ADDR) < (2**16)-1 then
			b(0) <= to_stdlogicvector(M1(to_integer(unsigned(ADDR(15 downto 0)))));
			b(1) <= to_stdlogicvector(M1(to_integer(unsigned(ADDR(15 downto 0))+1)));
			b(2) <= to_stdlogicvector(M1(to_integer(unsigned(ADDR(15 downto 0))+2)));
			b(3) <= to_stdlogicvector(M1(to_integer(unsigned(ADDR(15 downto 0))+3)));
		else
			addr2 <= unsigned(ADDR) - (2**16);
			b(0) <= to_stdlogicvector(M2(to_integer(addr2(15 downto 0))));
			b(1) <= to_stdlogicvector(M2(to_integer(addr2(15 downto 0))+1));
			b(2) <= to_stdlogicvector(M2(to_integer(addr2(15 downto 0))+2));
			b(3) <= to_stdlogicvector(M2(to_integer(addr2(15 downto 0))+3));
		end if;
	 end process;
	 
	INSTR <= b(3) & b(2) & b(1) & b(0);
	
end bhv;
		
		
	
	