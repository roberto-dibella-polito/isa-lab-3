library ieee;
use ieee.std_logic_1164.all;

package riscv_lite_instructions is


-- Control unit input sizes

-- Each instruction begins with '11' -> EXCLUDED into the opcode

constant OP_SIZE 	: integer := 5;
constant FUNC3_SIZE	: integer := 3;
constant FUNC7_SIZE	: integer := 7;
constant RX_SIZE	: integer := 5;
constant IMM12_SIZE	: integer := 12;
constant IMM19_SIZE	: integer := 19;

-- TYPES INSTRUCTION FORMAT

--	 			| 31-25 | 24-20 | 19-15 | 14-12 | 11-7 | 	 6-0  |
--				-------------------------------------------------
-- R-TYPE	| FUNC7 |  rs2	 |  rs1  | FUNC3 |  rd  | opcode |
--          -------------------------------------------------

-- I-TYPE	|		IMM12		 |  rs1  | FUNC3 |  rd  | opcode |  
--				-------------------------------------------------





------------------------------------------------------------------------------
-- ARYTHMETIC --
------------------------------------------------------------------------------

-- ADD 
-- R-TYPE
constant ADD_OP 	: std_logic_vector(OP_SIZE-1 downto 0) 		:= "01100";
constant ADD_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "000";
constant ADD_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) 	:= "0000000";

-- ADDI
-- I-TYPE
constant ADDI_OP	: std_logic_vector(OP_SIZE-1 downto 0)		:= "00100";
constant ADDI_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "000";

-- AUIPC 
-- U-TYPE
constant AUIPC_OP	: std_logic_vector(OP_SIZE-1 downto 0)		:= "00101";

-- LUI 
-- U-TYPE
constant LUI_OP		: std_logic_vector(OP_SIZE-1 downto 0)		:= "01101";

------------------------------------------------------------------------------
-- BRANCH --
------------------------------------------------------------------------------

-- BEQ 
-- B-TYPE
constant BEQ_OP		: std_logic_vector(OP_SIZE-1 downto 0)		:= "11000";
constant BEQ_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0)	:= "000";

------------------------------------------------------------------------------
-- LOAD --
------------------------------------------------------------------------------

-- LW
-- I-TYPE
constant LW_OP		: std_logic_vector(OP_SIZE-1 downto 0)		:= "00000";
constant LW_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0)	:= "010";

------------------------------------------------------------------------------
-- SHIFT --
------------------------------------------------------------------------------

-- SRAI 
-- I-TYPE
constant SRAI_OP 	: std_logic_vector(OP_SIZE-1 downto 0) 		:= "00100";
constant SRAI_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "101";
constant SRAI_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) 	:= "0100000";

------------------------------------------------------------------------------
-- LOGICAL --
------------------------------------------------------------------------------

-- ANDI 
-- I-TYPE
constant ANDI_OP 	: std_logic_vector(OP_SIZE-1 downto 0) 		:= "00100";
constant ANDI_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "111";

-- XOR 
-- R-TYPE
constant XOR_OP 	: std_logic_vector(OP_SIZE-1 downto 0) 		:= "01100";
constant XOR_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "100";
constant XOR_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) 	:= "0000000";

------------------------------------------------------------------------------
-- COMPARE --
------------------------------------------------------------------------------

-- SLT 
-- R-TYPE
constant SLT_OP 	: std_logic_vector(OP_SIZE-1 downto 0) 		:= "01100";
constant SLT_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "010";
constant SLT_FUNC7	: std_logic_vector(FUNC7_SIZE-1 downto 0) 	:= "0000000";

------------------------------------------------------------------------------
-- JUMP & LINK --
------------------------------------------------------------------------------

-- JAL 
-- J-TYPE
constant JAL_OP 	: std_logic_vector(OP_SIZE-1 downto 0) 		:= "11011";

------------------------------------------------------------------------------
-- STORE --
------------------------------------------------------------------------------

-- SW 
-- S-TYPE
constant SW_OP 		: std_logic_vector(OP_SIZE-1 downto 0) 		:= "01000";
constant SW_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "010";

------------------------------------------------------------------------------
-- MODULO --
------------------------------------------------------------------------------

-- MOD 
-- I-TYPE
constant MOD_OP 	: std_logic_vector(OP_SIZE-1 downto 0) 		:= "00010";
constant MOD_FUNC3	: std_logic_vector(FUNC3_SIZE-1 downto 0) 	:= "101";


end riscv_lite_instructions;
