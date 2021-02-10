library verilog;
use verilog.vl_types.all;
entity risc_v_lite is
    port(
        CLK             : in     vl_logic;
        ASYNC_RST_N     : in     vl_logic;
        RST_N           : in     vl_logic;
        IM_IN           : out    vl_logic_vector(31 downto 0);
        IM_OUT          : in     vl_logic_vector(31 downto 0);
        MEM_IN          : out    vl_logic_vector(31 downto 0);
        MEM_ADDR        : out    vl_logic_vector(31 downto 0);
        MEM_OUT         : in     vl_logic_vector(31 downto 0);
        MEM_EN          : out    vl_logic
    );
end risc_v_lite;
