module LFSR_random_number_generator_tb();

	reg clk, rst;

	wire[3:0] q;

	LFSR_random_number_generator RNG(clk, rst, q);

	always
		begin
			clk = 0;
			#5;
			clk = 1;
			#5;
		end

	initial
		begin
			rst = 1;
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
		end

endmodule