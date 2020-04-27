module memoryPairs(clk, rst, enable, A, B, C, D, E, F, endState);
	
	input clk, rst, enable;
	output reg endState;
	output reg [3:0] A, B, C, D, E, F;
	wire [3:0] q;

	reg countWait;

	reg [3:0] counter;

	LFSR_random_number_generator LFSR(clk, rst, q);

	always @(posedge clk)
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
					counter <= 0;
					countWait <= 0;
				end
			else if(enable)
				begin
					countWait <= 1;
					counter <= 0;
				end
			else if(countWait)
				begin
					counter <= counter + 1;

					if(counter == 1)
						A <= q;
					else if(counter == 2)
						B <= q;
					else if(counter == 3)
						C <= q;
					else if(counter == 4)
						D <= q;
					else if(counter == 5)
						E <= q;
					else if(counter == 6)
						F <= q;
					else if(counter > 6)
						begin
							endState <= 1;
							counter <= 0;
							countWait <= 0;
						end
				end
			else
				begin
					endState <= 0;
					counter <= 0;
				end
		end


endmodule