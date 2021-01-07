library ieee;
use ieee.std_logic_1164.all;

package riscv_lite_instructions is


-- Control unit input sizes

constant OP_SIZE 		: integer := 7;
constant FUNC3_SIZE	: integer := 3;
constant FUNC7_SIZE	: integer := 7;
constant RX_SIZE		: integer := 5;
constant IMM12_SIZE	: integer := 12;
constant IMM19_SIZE	: integer := 19;

-- TYPES INSTRUCTION FORMAT

--	 			| 31-25 | 24-20 | 19-15 | 14-12 | 11-7 | 	 6-0  |
--				-------------------------------------------------
-- R-TYPE	| FUNC7 |  rs2	 |  rs1  | FUNC3 |  rd  | opcode |
--          -------------------------------------------------

-- I-TYPE	|		IMM12		 |  rs1  | FUNC3 |  rd  | opcode |  
--				-------------------------------------------------






-- ARYTHMETIC
constant ADD_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 	:= "0110011";
constant ADD_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) := "000";
constant ADD_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) := "0000000";

constant ADDI_OP		: std_logic_vector(OP_SIZE-1 downto 0)		:= "0010011";
constant ADDI_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) := "000";

constant AUIPC_OP		: std_logic_vector(OP_SIZE-1 downto 0)		:= "0010111";

constant LUI_OP		: std_logic_vector(OP_SIZE-1 downto 0)		:= "0110011";

-- BRANCH
constant BEQ_OP		: std_logic_vector(OP_SIZE-1 downto 0)		:= "1100011";
constant BEQ_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0)	:= "000";

-- LOAD
constant LW_OP			: std_logic_vector(OP_SIZE-1 downto 0)		:= "0000011";
constant LW_FUNC3		: std_logic_vector(FUNC3_SIZE-1 downto 0)	:= "010";

-- SHIFT
constant SRAI_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 	:= "0010011";
constant SRAI_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) := "101";
constant SRAI_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) := "0100000";

-- LOGICAL
constant ANDI_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 	:= "0010011";
constant ANDI_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) := "111";

constant XOR_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 	:= "0110011";
constant XOR_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) := "100";
constant XOR_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) := "0000000";

-- COMPARE
constant SLT_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 	:= "0110011";
constant SLT_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) := "010";
constant SLT_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) := "0000000";

-- JUMP&LINK
constant JAL_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 	:= "1101111";

-- STORE
constant SW_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 	:= "0100011";
constant SW_FUNC3		: std_logic_vector(FUNC3_SIZE-1 downto 0) := "010";

end riscv_lite_instructions;