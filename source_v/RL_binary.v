module RL_binary(clk, rstn, en, base, exp, N, out);

input clk, rstn, en;
input [31:0] base, exp, N;
output [31:0] out;

reg [31:0] out, y;

wire [31:0] 

mod_exp inst_0 (clk, rstn, en, 

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		out <= 1;
		y <= base;
	end
	
end

endmodule
