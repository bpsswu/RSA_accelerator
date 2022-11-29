library verilog;
use verilog.vl_types.all;
entity get_length is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        md_start        : in     vl_logic;
        num_in          : in     vl_logic_vector(63 downto 0);
        len_out         : out    vl_logic_vector(7 downto 0);
        md_end          : out    vl_logic
    );
end get_length;
