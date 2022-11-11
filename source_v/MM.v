module MM(clk, rstn, A, B, N, Z);

input clk, rstn;
input [31:0] A, B, N;
output [31:0] Z;

reg [31:0] Z;
reg [7:0] count, index;
reg [1:0] flag;

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		Z <= 0;
		index <= 0;
		flag <= 0;
		count <= 0;
	end
	else begin
		if (count < 96) begin
			if (flag == 0) begin
				Z <= Z + A[index] * B;
				flag <= 1;
			end
			else if (flag == 1) begin
				Z <= Z + Z[0] * N;
				flag <= 2;
			end
			else if (flag == 2) begin
				Z <= Z >> 1;
				flag <= 0;
			end
			count <= count + 1;
			
			if (count % 3 == 2) begin
				index <= index + 1;
			end
		end
		else if (count == 96) begin
			if (Z > N) begin
				Z <= Z - N;
			end
		end
	end
end

endmodule
