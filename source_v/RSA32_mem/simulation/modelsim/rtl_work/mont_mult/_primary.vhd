library verilog;
use verilog.vl_types.all;
entity mont_mult is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        md_start        : in     vl_logic;
        len             : in     vl_logic_vector(7 downto 0);
        num_1           : in     vl_logic_vector(31 downto 0);
        num_2           : in     vl_logic_vector(31 downto 0);
        modulus         : in     vl_logic_vector(31 downto 0);
        md_end          : out    vl_logic;
        mm_out          : out    vl_logic_vector(31 downto 0)
    );
end mont_mult;
