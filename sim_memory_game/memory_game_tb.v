// ECE 5440
// Omar Baig 8007
// testbench for memory game module
`timescale 10ns/10ns
module memory_game_tb();

	reg clk, rst, enable, bIn, gameTimeout;
	reg[15:0] switchIn;

	wire g1, g2, g3, endGame;
	wire[3:0] score;
	wire[15:0] redLight;

	memory_game memGame_DUT(clk, rst, enable, bIn, switchIn, gameTimeout, score, 
		redLight, g1,g2,g3, endGame);

	always 
		begin
			clk = 0;
			#10;
			clk = 1;
			#10;
		end

	initial
		begin
			rst = 1;
			enable = 0;
			bIn = 0;
			gameTimeout = 0;
			switchIn = 0;

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
			@(posedge clk)
			@(posedge clk)


			bIn = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			bIn = 0;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			//gameTimeout = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

		//	switchIn[a] = 1;
		//	switchIn[f] = 1;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)

			bIn = 1;
			//gameTimeout = 0;
		end

endmodule