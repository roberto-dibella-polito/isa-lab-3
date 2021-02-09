-- Instruction memory definition

-- Read bit strings from a binary file
-- ONE BYTE PER LINE
-- Subdivision in two arrays of 2**16

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

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
	type mem_type is array (0 to (2**16)-1) of std_logic_vector(31 downto 0);
	
	-- Memory intialization function 
	impure function init_ram_hex return  mem_type is
		file text_file : text open READ_MODE is "/home/isa32/DELIVER/isa-lab-3/tb/if/instr_memory_word_mod.hex";
		variable text_line : line;
		variable ram_content : mem_type;
	    begin
		    for i in 0 to (2**16)-1 loop
				if not endfile(text_file) then
					readline(text_file, text_line);
					hread(text_line, ram_content(i));
				else
					ram_content(i) := (others=>'0');
				end if;
		  end loop;
		
		return ram_content;
	end function;
	
	signal M1,M2 : mem_type := init_ram_hex;
	
	signal addr2 : unsigned(31 downto 0);

	signal zero_addr, real_addr : unsigned(31 downto 0);
	
begin
	
	--memory_sel: process(ADDR)	
	--begin
		
	--	if unsigned(ADDR) < (2**16)-1 then
	--		b(0) <= M1(to_integer(unsigned(ADDR(15 downto 0))));
	--		b(1) <= M1(to_integer(unsigned(ADDR(15 downto 0))+1));
	--		b(2) <= M1(to_integer(unsigned(ADDR(15 downto 0))+2));
	--		b(3) <= M1(to_integer(unsigned(ADDR(15 downto 0))+3));
	--	else
	--		addr2 <= unsigned(ADDR) - (2**16);
	--		b(0) <= M2(to_integer(addr2(15 downto 0)));
	--		b(1) <= M2(to_integer(addr2(15 downto 0))+1);
	--		b(2) <= M2(to_integer(addr2(15 downto 0))+2);
	--		b(3) <= M2(to_integer(addr2(15 downto 0))+3);
	--	end if;
	-- end process;
	 
	--INSTR <= b(3) & b(2) & b(1) & b(0);

	zero_addr <= unsigned(ADDR) - x"00400000";
	real_addr <= "00" & zero_addr(31 downto 2);
	
	im_read: process(real_addr)
	begin

		if real_addr < (2**16)-1 then

			INSTR <= M1(to_integer(real_addr(15 downto 0)));

		else

			addr2 <= real_addr - (2**16);
			INSTR <= M2(to_integer(addr2(15 downto 0)));

		end if;

	 end process;	
	
end bhv;
		
		
	
	
