//ECE 5440
//Omar Baig 8007
//counts to 10 everytime enable is high
module countTo10(clk, rst, enable, timeout);

input clk, rst, enable;
	output timeout;
	reg timeout;

	reg [3:0] count;

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
					if(count == 10)
						timeout <= 1;
				end
		end
endmodule