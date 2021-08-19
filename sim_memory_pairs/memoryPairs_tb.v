// ECE 5440
// Omar Baig 8007
// test bench for memory pairs module
module memoryPairs_tb();
	
	reg clk, rst, enable;
	wire countWait;
	wire endState;
	wire[3:0] A, B, C, D, E, F;
	wire [3:0] counter;

	memoryPairs memoryPairs_DUT(clk, rst, enable, A, B, C, D, E, F, endState);

	always begin
		clk = 0;
		#10;
		clk = 1;
		#10;
	end

	initial
		begin
			rst = 1;
			enable = 0;

			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			rst = 0;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			rst = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			enable = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			enable = 0;

			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			enable = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			enable = 0;

			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			enable = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			enable = 0;

			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			enable = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			enable = 0;
		end

endmodule