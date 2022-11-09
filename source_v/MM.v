module MM(clk, rstn, A, B, N, Z);
input clk, rstn;
input [31:0] A, B, N;
output [31:0] Z;

reg [31:0] Z;

integer i;

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		Z <= 0;
		i <= 0;
	end
	else begin
		if (i < 32) begin
			Z <= Z + A[i] * B;
			Z <= Z + Z[i] * N; 
			i <= i + 1;
		end
		else begin
			if (Z > N) begin
				Z <= Z - N;
			end	
		end
	end
end

endmodule 
