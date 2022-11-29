library verilog;
use verilog.vl_types.all;
entity long_div is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        md_start        : in     vl_logic;
        len             : in     vl_logic_vector(7 downto 0);
        num_in          : in     vl_logic_vector(31 downto 0);
        modulus         : in     vl_logic_vector(31 downto 0);
        md_end          : out    vl_logic;
        ld_out          : out    vl_logic_vector(31 downto 0)
    );
end long_div;
