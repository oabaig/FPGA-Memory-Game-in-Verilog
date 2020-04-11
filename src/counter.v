//ECE 5440
//Omar Baig 8007
//counts from 0 to 15 based on button input
//overflow causes cout to go back to 0
module counter(clk, rst, in, cOut);

	input clk, rst, in;

	output [3:0] cOut;
	reg	   [3:0] cOut;

	always @(posedge clk)
		begin
			if(rst == 0)
				cOut <= 0;
			else if(in == 1'b1)
				cOut <= cOut + 1;
		end
endmodule