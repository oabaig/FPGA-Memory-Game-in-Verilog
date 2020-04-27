module LFSR_random_number_generator(clk, rst, q);
  input clk, rst;
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

    q <= LFSR;
  end

endmodule