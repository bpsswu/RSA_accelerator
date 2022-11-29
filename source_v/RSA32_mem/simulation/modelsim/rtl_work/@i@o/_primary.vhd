library verilog;
use verilog.vl_types.all;
entity IO is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        md_start_push   : in     vl_logic;
        debug1          : out    vl_logic;
        debug2          : out    vl_logic;
        debug3          : out    vl_logic;
        good            : out    vl_logic;
        bad             : out    vl_logic
    );
end IO;
