/*
	module name 	: RL_binary
	@ input			: base, exp, modulus
	@ output		: r
	@ description	: r = (base ^ exp) % modulus
*/
module RL_binary(
	clk, rstn, md_start, base, exp, modulus,
	md_end, r);

input clk, rstn, md_start;
input [31:0] base, exp, modulus;
output md_end;
output [31:0] r;

parameter STANDBY = 2'b00, GETLEN = 2'b01, FLAG0 = 2'b10, FLAG1 = 2'b11;
reg [1:0] state, next;

reg [31:0] r;
reg [31:0] y;
wire [7:0] gl_out;
wire [31:0] me_1_out, me_2_out;
wire gl_end, me_1_end, me_2_end;
reg me_1_start, me_2_start;
wire md_end;
reg [7:0] i;
reg not_hp;

assign md_end = (i == 32) && me_2_end;

get_length gl_RL (
	clk, rstn, md_start, {32'b0, modulus}, 
	gl_out, gl_end);

mod_exp me_1 (
	clk, rstn, me_1_start, gl_out, r, y, modulus,
	me_1_out, me_1_end);
	
mod_exp me_2 (
	clk, rstn, me_2_start, gl_out, y, y, modulus,
	me_2_out, me_2_end);

 always @ (posedge clk or negedge rstn) begin
	if (!rstn) state <= STANDBY;
	else begin
		state <= next;
	end
end

always @ (*) begin 
	next = 2'bx;
	case(state)
		STANDBY : begin
			if (md_start) next = GETLEN;
			else next = STANDBY;
		end
		GETLEN : begin
			if (gl_end) next = FLAG0;
			else next = GETLEN;
		end
		FLAG0 : begin
			if (me_1_end | not_hp) next = FLAG1;
			else next = FLAG0;
		end
		FLAG1 : begin
			if (me_2_end) next = FLAG0;
			else if (i == 32) next = STANDBY;
			else next = FLAG1;
		end
	endcase
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		me_1_start <= 0;
		me_2_start <= 0;
		i <= 0;
		not_hp <= 0;
	end
	else begin
		
		if (md_start) begin
			i <= 0;
			me_1_start <= 0;
			me_2_start <=0;
			not_hp <= 0;
		end
		
		if ((state == GETLEN && next == FLAG0) || (state == FLAG1 && next == FLAG0)) begin
			if (i < 32) begin
				if (exp[i]) begin
					me_1_start <= 1;
				end
				else begin
					not_hp <= 1;
				end
			end
		end
		
		else if (state == FLAG0 && next == FLAG0) begin
			if (me_1_start) begin
				me_1_start <= 0;
			end
			if (not_hp) begin
				not_hp <= 0;
			end
		end
		
		else if (state == FLAG0 && next == FLAG1) begin
			if (i < 32) begin
				me_2_start <= 1;
				i <= (i + 1);
			end
		end
		
		else if (state == FLAG1 && next == FLAG1) begin
			if (me_2_start) begin
				me_2_start <= 0;
				not_hp <= 0;
			end
		end
		
		if (i == 32) begin
			me_2_start <= 0;
			not_hp <= 0;
		end

	end
end
		
always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		r <= 0;
		y <= 0;
	end
	else begin
		if (md_start == 1) begin
			r <= 1;
			y <= base;
		end
		if (me_1_end == 1) begin
			r <= me_1_out;
		end
		if (me_2_end == 1) begin
			y <= me_2_out;
		end
	end
end

endmodule