-- GENERIC BEHAVIORAL REGISTERS
-- Synchronous and asynchronous reset

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg_n is 
	generic( N : integer := 8 );
	port
	(	clk			: in std_logic;
		rst_n 		: in std_logic;
		async_rst_n : in std_logic;
		D			: in std_logic_vector(N-1 downto 0);
		Q			: out std_logic_vector(N-1 downto 0)
	);
end reg_n;

architecture bhv of reg_n is

begin
	
	reg: process(clk, async_rst_n)
	begin
		
		if async_rst_n = '0' then
			Q <= (others=>'0');
		elsif (clk'event and clk ='1') then
			if rst_n = '0' then
				Q <= (others=>'0');
			else
				Q <= A;
			end if;
		end if;
	end process;
	
end bhv;

