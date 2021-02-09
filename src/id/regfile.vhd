-- RISC-V
-- Decode stage
-- Register file
-- The memory has synchronous write, asynchronous read

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
	port
	(	RS1			: in std_logic_vector(4 downto 0);
		RS2			: in std_logic_vector(4 downto 0);
		RD			: in std_logic_vector(4 downto 0);
		DATA_IN		: in std_logic_vector(31 downto 0);
		WR_EN		: in std_logic;
		DATA1_OUT	: out std_logic_vector(31 downto 0);
		DATA2_OUT	: out std_logic_vector(31 downto 0);
		RST_n		: in std_logic;
		ASYNC_RST_N : in std_logic;
		CLK			: in std_logic
	);
end regfile;

architecture bhv of regfile is

	type mem_array is array(0 to 31) of std_logic_vector(31 downto 0);
	
	signal reg_file : mem_array;

begin
	
	memory: process(CLK, ASYNC_RST_N)
	begin
		if ASYNC_RST_N = '0' then

			reg_file <= (OTHERS => (OTHERS => '0'));

		elsif(CLK'event and CLK = '1') then	
			
			if(RST_n = '0') then
				reg_file <= (OTHERS => (OTHERS => '0'));
			elsif( WR_EN = '1') then
				reg_file(to_integer(unsigned(RD))) <= DATA_IN;
			end if;
		
		end if;
	
	end process;
				
	-- MEMORY FORWARDING
	-- Since the instruction can be decoded only after the data is saved into the RF,
	-- It would lead to wait until the WB stage of the latter instruction
	-- before decoding the new one.
	-- To avoid this problem, a "forwarding" asynchronous mechanism is added to
	-- make the data from RD available while it is saved into the RF.
	
	-- Data Read
	
	data_read: process(RD,RS1,RS2,DATA_IN,WR_EN)
	begin
		if RS1 = RD and WR_EN = '1' then
			DATA1_OUT <=  DATA_IN;
		else
			DATA1_OUT <= reg_file(to_integer(unsigned(RS1)));
		end if;
		
		if RS2 = RD and WR_EN = '1' then
			DATA2_OUT <= DATA_IN;
		else
			DATA2_OUT <= reg_file(to_integer(unsigned(RS2)));
		end if;
	end process;
	
end bhv;	
