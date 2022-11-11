`timescale 1ns/1ns

module MM_tb;
reg clk, rstn;
reg [31:0] A, B, N;
wire [31:0] Z;

MM inst_0 (clk, rstn, A, B, N, Z);

initial clk = 0;
always #5 clk = ~clk;

initial begin
        #0
        rstn = 0;
        A = 67676767;
        B = 52525252;
        N = 123456789;
        #7
        rstn = 1;
        #2000
        $stop;
end

endmodule
