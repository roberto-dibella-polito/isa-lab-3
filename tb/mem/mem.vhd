-- RISC-V
-- Memory stage - tb
-- Memory
-- The memory has synchronous write, asynchronous read

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
	port
	(	ADDR		: in std_logic_vector(31 downto 0);
		DATA_OUT	: out std_logic_vector(31 downto 0);
		WR_EN		: in std_logic;
		RST_n		: in std_logic;
		CLK			: in std_logic
	);
end regfile;

architecture bhv of regfile is

	-- Memory type definition
	type mem_type is array (0 to (2**16)-1) of std_logic_vector(7 downto 0);
	
	signal mem_block_1, mem_block_2 : mem_array;
	
	type byte_array is array (0 to 3) of std_logic_vector(7 downto 0);
	signal b : byte_array;
	
	signal addr2 : unsigned(31 downto 0);

begin
	
	memory_write: process(CLK, RST_n)
	begin
		
		if(CLK'event and CLK = '1') then	
			
			if(RST_n = '0') then
				mem_block_1 <= (OTHERS => (OTHERS => '0'));
				mem_block_2 <= (OTHERS => (OTHERS => '0'));
			elsif( WR_EN = '1') then
				if unsigned(ADDR) < (2**16)-1 then
					b(0) <= to_stdlogicvector(mem_block_1(to_integer(unsigned(ADDR(15 downto 0)))));
					b(1) <= to_stdlogicvector(mem_block_1(to_integer(unsigned(ADDR(15 downto 0))+1)));
					b(2) <= to_stdlogicvector(mem_block_1(to_integer(unsigned(ADDR(15 downto 0))+2)));
					b(3) <= to_stdlogicvector(mem_block_1(to_integer(unsigned(ADDR(15 downto 0))+3)));
				else
					addr2 <= unsigned(ADDR) - (2**16);
					b(0) <= to_stdlogicvector(mem_block_2(to_integer(addr2(15 downto 0))));
					b(1) <= to_stdlogicvector(mem_block_2(to_integer(addr2(15 downto 0))+1));
					b(2) <= to_stdlogicvector(mem_block_2(to_integer(addr2(15 downto 0))+2));
					b(3) <= to_stdlogicvector(mem_block_2(to_integer(addr2(15 downto 0))+3));
				end if;
			end if;
		
		end if;
	
	end process;
	
	-- Asynchronous read project
	memory_read: process(ADDR)
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
	 
	DATA_OUT <= b(3) & b(2) & b(1) & b(0);
						
	
end bhv;	
