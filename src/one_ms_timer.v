//ECE 5440
//Omar Baig 8007
//sends a high signal every millisecond for a clock cycle
module one_ms_timer(clk, rst, enable, timeout);

	input clk, rst, enable;
	output timeout;
	reg timeout;

	reg [15:0] count;

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
					if(count == 50000)
						timeout <= 1;
				end
		end
endmodule