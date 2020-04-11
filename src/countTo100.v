//ECE 5440
//Omar Baig 8007
//counts to 100 everytime enable is high
module countTo100(clk, rst, enable, timeout);

	input clk, rst, enable;
	output timeout;
	reg timeout;

	reg [6:0] count;

	always @(posedge clk)
		begin
			if(timeout == 1)
				begin
					count <= 0;
					timeout <= 0;
				end
			else if(rst == 0)
				begin
					count <= 0;
					timeout <= 0;
				end
			else if(enable == 1)
				begin
					count <= count + 1;
					if(count == 100)
						timeout <= 1;
				end
		end 
endmodule