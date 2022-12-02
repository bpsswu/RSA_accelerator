/*
	module name 	: ltp
	@ input			: ltp_in (level signal)
	@ output		: ltp_out (pulse_signal
	@ description	: level to pulse converter (moore fsm)
*/
module ltp(
	clk, rstn, ltp_in,
	ltp_out);
	
input clk, rstn, ltp_in;
output ltp_out;

reg ltp_out;
reg [1:0] state, next;

parameter IDLE = 0, ACT = 1, LONG = 2;

always @ (posedge clk or negedge rstn) begin
	if (!rstn) state <= IDLE;
	else state <= next;
end

always @ (*) begin
	case (state)
		IDLE : begin
			ltp_out = 0;
			if (!ltp_in) next = IDLE;
			else next = ACT;
		end
		ACT : begin
			ltp_out = 1;
			if (!ltp_in) next = IDLE;
			else next = LONG;
		end
		LONG : begin
			ltp_out = 0;
			if (!ltp_in) next = IDLE;
			else next = LONG;
		end
	endcase
end

endmodule