/*
	module name 	: mont_mul
	@ input			: num_1, num_2, modulus
	@ output		: mm_out
	@ description	: mm_out = (num_1 * num_2 * R^-1) % modulus
*/
module mont_mult(
	clk, rstn, md_start, len, num_1, num_2, modulus,
	md_end, mm_out);

input clk, rstn, md_start;
input [7:0] len;
input [31:0] num_1, num_2, modulus;
output md_end;
output [31:0] mm_out;

reg md_end;
reg [31:0] mm_out;
reg [7:0] count, index;
reg [1:0] flag;
reg enable;
wire trig;

assign trig = md_start | md_end;

always @ (posedge trig or negedge rstn) begin
	if (!rstn) begin
		enable <= 0;
	end
	else begin
		enable <= ~(enable);
	end
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		md_end <= 0;
		mm_out <= 0;
		count <= 0;
		index <= 0;
		flag <= 0;
	end
	else if (enable) begin

		if (md_start) begin
			count <= 0;
		end

		if (count < len*3) begin
			if (flag == 0) begin
				mm_out <= mm_out + num_1[index] * num_2;
				flag <= 1;
			end
			else if (flag == 1) begin
				mm_out <= mm_out + mm_out[0] * modulus;
				flag <= 2;
			end
			else if (flag == 2) begin
				mm_out <= (mm_out >> 1);
				flag <= 0;
			end
			
			count <= count + 1;
			
			if (count % 3 == 2) begin
				index <= index + 1;
			end
		end
		else if (count == len*3) begin
			if (mm_out >= modulus) begin
				mm_out <= mm_out - modulus;
			end
			else begin
				count <= count + 1;
				md_end <= 1;
			end
		end
	end
	else if (count == len*3 + 1) begin
		count <= count + 1;
		md_end <= 0;
	end
end

endmodule
