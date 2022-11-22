/*
	module name 	: long_div
	@ input			: num_in, R(= 2^len), modulus
	@ output		: ld_out
	@ description	: ld_out = (num_in * R) % modulus
*/
module long_div(
	clk, rstn, md_start, len, num_in, modulus,
	md_end, ld_out);

input clk, rstn, md_start;
input [7:0] len;
input [31:0] num_in, modulus;
output md_end;
output [31:0] ld_out;

reg md_end;
reg [31:0] ld_out;
wire [31:0] r;
wire [63:0] mult;
wire [7:0] gl_1_out;
wire gl_1_end;
reg [7:0] m_len, i, j;
reg [31:0] buf2;
reg [1:0] flag;
reg load, loop_end;

assign r = 2 ** len;
assign mult = num_in * r;

get_length gl_1 (clk, rstn, md_start, mult, gl_1_out, gl_1_end);

always @ (posedge gl_1_end or negedge rstn) begin
	if (!rstn) begin
		m_len <= 0;
	end
	else begin
		m_len <= gl_1_out;
	end
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		md_end <= 0;
		ld_out <= 0;
		buf2 <= 0;
		i <= 0;
		j <= 0;
		flag <= 0;
		load <= 0;
		loop_end <= 0;
	end
	else begin
		if (gl_1_end == 1) begin
			load <= 0;
		end
		
		if (load == 0) begin
			i <= (m_len * 4);
			j <= m_len;
			load <= 1;
		end
		
		if (i > 0) begin
			if (flag == 0) begin
				ld_out <= (ld_out << 1);
				flag <= 1;
			end
			else if (flag == 1) begin
				if (mult[j-1] == 1) begin
					ld_out <= (ld_out + 1);
				end
				flag <= 2;
			end
			else if (flag == 2) begin
				if (ld_out >= modulus) begin
					ld_out <= (ld_out - modulus);
					buf2 <= (buf2 + 1);
				end
				flag <= 3;
			end
			else if (flag == 3) begin
				if (ld_out >= modulus) begin
					buf2 <= (buf2 << 1);
				end
				flag <= 0;
			end
			
			i <= (i - 1);
			if (i == 1) begin
				loop_end <= 1;
			end
			
			if (i % 4 == 1) begin
				j <= (j - 1);
			end
			
		end
		
		if (loop_end == 1) begin
			md_end <= 1;
			loop_end <= 0;
		end
		
		if (md_end == 1) begin
			md_end <= 0;
		end
	end
end

endmodule
