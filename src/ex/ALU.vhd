-- RISC-V
-- Execution stage
-- Program Counter ALU: computes addresses and PC-relative addresses

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port
	(
		ALU_CTRL 	: in std_logic_vector(2 downto 0);
		D1			: in std_logic_vector(31 downto 0);
		D2			: in std_logic_vector(31 downto 0);
		ALU_OUT		: out std_logic_vector(31 downto 0);
		ZERO		: out std_logic
	);
end ALU;

architecture bhv of ALU is

	signal adder_out 	: std_logic_vector(31 downto 0);
	signal compare_out 	: std_logic_vector(31 downto 0);
	signal and_out		: std_logic_vector(31 downto 0);
	signal xor_out		: std_logic_vector(31 downto 0);
	signal shift_out	: std_logic_vector(31 downto 0);
	signal lui_out		: std_logic_vector(31 downto 0);
	
	signal d1_signed, d2_signed : signed(31 downto 0);
	
begin

	d1_signed <= signed(D1);
	d2_signed <= signed(D2);
	
	-- Adder instatiation
	adder: process(d1_signed, d2_signed, ALU_CTRL) 
	begin
		if ALU_CTRL(2) = '0' then
			adder_out <= std_logic_vector(d1_signed+d2_signed);
		else
			adder_out <= std_logic_vector(d1_signed-d2_signed);
		end if;
	end process;
	
	-- Compare instatiation
	compare: process(adder_out)
	begin
		if adder_out(31)= '0' then
			compare_out <= (others=>'0');
		else
			compare_out <= std_logic_vector(to_signed(1,32));
		end if;
	end process;
	
	-- Bitwise AND instatiation
	and_out <= D1 and D2;
	
	-- Bitwise XOR instantiation
	xor_out <= D1 xor D2;
	
	-- Shift right
	shift_out <= std_logic_vector(shift_right(d1_signed, to_integer(d2_signed)));
	
	-- LUI out signal -> simply a bypass
	lui_out <= D2;
	
	-- Output mux
	out_mux: process(ALU_CTRL, adder_out, compare_out, and_out, xor_out, shift_out, lui_out)
	begin
		
		case ALU_CTRL is
		
			when "000" => ALU_OUT <= adder_out;
			when "001" => ALU_OUT <= and_out;
			when "010" => ALU_OUT <= xor_out;
			when "011" => ALU_OUT <= shift_out;
			when "101" => ALU_OUT <= lui_out;
			when others => ALU_OUT <= compare_out;
		
		end case;
		
	end process;
	
end bhv;
	
		