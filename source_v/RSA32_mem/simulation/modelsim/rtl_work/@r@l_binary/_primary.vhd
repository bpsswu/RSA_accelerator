library verilog;
use verilog.vl_types.all;
entity RL_binary is
    generic(
        STANDBY         : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        GETLEN          : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        FLAG0           : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        FLAG1           : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        md_start        : in     vl_logic;
        base            : in     vl_logic_vector(31 downto 0);
        exp             : in     vl_logic_vector(31 downto 0);
        modulus         : in     vl_logic_vector(31 downto 0);
        md_end          : out    vl_logic;
        r               : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STANDBY : constant is 1;
    attribute mti_svvh_generic_type of GETLEN : constant is 1;
    attribute mti_svvh_generic_type of FLAG0 : constant is 1;
    attribute mti_svvh_generic_type of FLAG1 : constant is 1;
end RL_binary;
