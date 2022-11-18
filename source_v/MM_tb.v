`timescale 1ns/1ns

module MM_tb;

reg clk, rstn, en;
reg [31:0] A, B, N;
wire [31:0] Z;
wire module_end;

MM inst_0 (clk, rstn, en, A, B, N, Z, module_end);

initial clk = 0;
always #5 clk = ~clk;

initial begin
        #0
        rstn = 0;
		  en = 0;
        A = 67676767;
        B = 52525252;
        N = 100000;
        #7
        rstn = 1;
		  #20
		  en = 1;
        #2500
        $stop;
end

endmodule
