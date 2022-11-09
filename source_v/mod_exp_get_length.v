module get_length(a,b);
    input [63:0] a;
    output [7:0] b;
    integer count;

    reg [7:0] idx;
	 reg [7:0] b;

    initial begin
		count <= 0;
      idx <= 64;
    end
    always @ (a) begin

        while(count == -1) begin
            if(a[idx]) begin
                b = idx;
                count <= -1;
            end
				idx = idx - 1;
        end
    end
endmodule


module mod_exp(msg, N, len, res);
   input [31:0] msg, N;
   input [7:0] len;
   output [63:0] res; //buf1
	integer i, count;

    //multiply
   reg [63:0] buff, res, mult;
	
	always @(msg) begin
		mult = msg;
		count = 0;
		for( count = 0; count < 64; count = count + 1) begin
			if(count < len)
				mult = mult << 1;
		end
	end
	 
   always @(*) begin
		for(i = 64; i > 0; i = i - 1) begin
			buff = buff << 1;
         if(mult[i-1])
				buff[0] = 1;
         if(buff >= N)
            buff = buff - N;
      end
      res <= buff;
	end
endmodule

