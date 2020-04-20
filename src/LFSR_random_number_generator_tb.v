module LFSR_random_number_generator_tb();

	reg clk, rst, enable;

	wire[3:0] q;

	LFSR_random_number_generator RNG(clk, rst, enable, q);

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

			enable = 0;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			enable = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			enable = 0;
		end

endmodule