library verilog;
use verilog.vl_types.all;
entity mod_exp is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        md_start        : in     vl_logic;
        len             : in     vl_logic_vector(7 downto 0);
        num_a           : in     vl_logic_vector(31 downto 0);
        num_b           : in     vl_logic_vector(31 downto 0);
        modulus         : in     vl_logic_vector(31 downto 0);
        mm_2_out        : out    vl_logic_vector(31 downto 0);
        mm_2_end        : out    vl_logic
    );
end mod_exp;
