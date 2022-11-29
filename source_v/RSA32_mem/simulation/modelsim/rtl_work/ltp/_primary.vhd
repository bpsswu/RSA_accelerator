library verilog;
use verilog.vl_types.all;
entity ltp is
    generic(
        IDLE            : integer := 0;
        ACT             : integer := 1;
        LONG            : integer := 2
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        ltp_in          : in     vl_logic;
        ltp_out         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of ACT : constant is 1;
    attribute mti_svvh_generic_type of LONG : constant is 1;
end ltp;
