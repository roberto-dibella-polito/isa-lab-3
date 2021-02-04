-- RISC-V
-- Memory stage - tb
-- Memory
-- The memory has synchronous write, asynchronous read

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	port
	(	ADDR		: in std_logic_vector(31 downto 0);
		DATA_OUT	: out std_logic_vector(31 downto 0);
		DATA_IN		: in std_logic_vector(31 downto 0);
		WR_EN		: in std_logic;
		RST_n		: in std_logic;
		ASYNC_RST_N	: in std_logic;
		CLK			: in std_logic
	);
end mem;

architecture bhv of mem is

	-- Memory type definition
	type mem_type is array (0 to (2**16)-1) of std_logic_vector(31 downto 0);
	
	signal M1, M2 : mem_type;
	
	--type byte_array is array (0 to 3) of std_logic_vector(7 downto 0);
	--signal b : byte_array;
	
	signal addr_1 : unsigned(31 downto 0);
	signal addr_2 : signed(31 downto 0);

	signal addr_1_sh, addr_2_sh : unsigned(15 downto 0);

begin

	addr_1 <= unsigned(ADDR);
	addr_2 <= signed(ADDR)-2**16;

	addr_1_sh <= "00" & addr_1(15 downto 2);
	addr_2_sh <= "00" & unsigned(addr_2(15 downto 2));
	
	memory_write: process(CLK, ASYNC_RST_N	)
	begin
		
		if( ASYNC_RST_N = '0' ) then 
			M1 <= (OTHERS => (OTHERS => '0'));
			M2 <= (OTHERS => (OTHERS => '0'));
		
		elsif(CLK'event and CLK = '1') then	
			
			if(RST_n = '0') then
				M1 <= (OTHERS => (OTHERS => '0'));
				M2 <= (OTHERS => (OTHERS => '0'));
			elsif( WR_EN = '1') then
				if unsigned(ADDR) < (2**16)-1 then
					M1(to_integer(addr_1_sh))	<= DATA_IN;
				else
					M2(to_integer(addr_2_sh))	<= DATA_IN;
				end if;
			end if;
		
		end if;
	
	end process;
	
	-- Asynchronous read project
	memory_read: process(addr_1_sh, addr_2_sh, addr_2)
	begin
		if addr_2 < 0 then
			DATA_OUT <= M1(to_integer(addr_1_sh));
		else
			DATA_OUT <= M2(to_integer(addr_2_sh));
		end if;
	 end process;					
	
end bhv;	
