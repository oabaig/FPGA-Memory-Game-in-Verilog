module memoryPairs(clk, rst, enable, A, B, C, D, E, F, switchArr, endState);
	
	input clk, rst, enable;
	output reg endState;
	output reg [3:0] A, B, C, D, E, F;
	output reg[14:0] switchArr;
	wire [3:0] q;

	LFSR_random_number_generator(clk, rst, enable, q);

	always
		begin
			if(!rst)
				begin
					endState <= 0;
					A <= 0;
					B <= 0;
					C <= 0;
					D <= 0;
					E <= 0;
					F <= 0;
					switchArr <= 0;
				end
			else if(enable)
				begin
					switchArr <= 0;
					A <= q;
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					B <= q;
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					C <= q;
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					D <= q;
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					E <= q;
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					@(posedge clk)
					F <= q;
					switchArr[A] <= 1;
					switchArr[B] <= 1;
					switchArr[C] <= 1;
					switchArr[D] <= 1;
					switchArr[E] <= 1;
					switchArr[F] <= 1;
					endState <= 1;
				end
			else
				endState <= 0;
		end


endmodule