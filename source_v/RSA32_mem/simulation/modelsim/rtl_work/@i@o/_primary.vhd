library verilog;
use verilog.vl_types.all;
entity IO is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        md_start_push   : in     vl_logic;
        good            : out    vl_logic;
        bad             : out    vl_logic
    );
end IO;
