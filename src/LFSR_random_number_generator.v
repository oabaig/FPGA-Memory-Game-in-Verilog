module LFSR_random_number_generator(clk, rst, enable, q);
  input clk, rst, enable;
  output [3:0] q;

  reg [3:0] q;
  reg [15:0] LFSR;

  always @(posedge clk)
  begin
  	if(!rst)
  		begin
  			LFSR <= 0;
  			q <= 0;
  		end
  	else
  		begin
		    LFSR[0] <= ~LFSR[1] ^ LFSR[2] ^ LFSR[4] ^ LFSR[15];
		    LFSR[15:1] <= LFSR[14:0];
    	end

    if(enable)
    	q <= LFSR;
  end

endmodule