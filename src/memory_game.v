module memory_game(clk, rst, enable, A, B, C, D, E, F, bIn, gameInputs, switchIn, gameTimeout,
				   score, redLight, g1, g2, g3, endGame);

	input clk, rst, enable, bIn, gameTimeout;
	input[3:0] A, B, C, D, E, F;
	input[14:0] switchIn;

	wire[14:0] num1, num2, num3;
	assign num1 = 16'b0000_0000_0000_0000;
	assign num1[A] = 1'b1;
	assign num1[F] = 1'b1;
	assign num2 = 16'b0000_0000_0000_0000;
	assign num2[B] = 1'b1;
	assign num2[E] = 1'b1;
	assign num3 = 16'b0000_0000_0000_0000;
	assign num3[C] = 1'b1;
	assign num3[D] = 1'b1;

	output reg redLight, g1, g2, g3, endGame;
	output reg[3:0] score;

	reg oneSecEnable;
	reg[3:0] state;

	parameter[3:0] GAMEWAIT = 0, FLASH1 = 1, FLASH2 = 2, FLASH3 = 3,
				   PAIR1 = 4, PAIR2 = 5, PAIR3 = 6, GAMEEND = 7;

	wire oneSecTimeout;

	one_second_timer oneSecondTimer(clk, rst, oneSecEnable, oneSecTimeout);

	always @(posedge clk)
		begin
			if(!rst)
				begin
					state <= GAMEWAIT;
					redLight <= 0;
					g1 <= 0;
					g2 <= 0;
					g3 <= 0;
					score <= 0;
					oneSecEnable <= 0;
					endGame <= 0;
				end
			else if(gameTimeout)
				state <= GAMEEND;
			else if(enable)
				begin
					case(state)
						GAMEWAIT:
							begin
								if(bIn)
									state <= FLASH1;
								else
									state <= GAMEWAIT;
							end
						FLASH1:
							begin
								oneSecEnable <= 1;
								if(oneSecTimeout)
									begin
										oneSecEnable <= 0;
										state <= FLASH2;
									end
								else
									state <= FLASH1;
							end
						FLASH2:
							begin
								oneSecEnable <= 1;
								if(oneSecTimeout)
									begin
										oneSecEnable <= 0;
										state <= FLASH3;
									end
								else
									state <= FLASH2;
							end
						FLASH3:
							begin
								oneSecEnable <= 1;
								if(oneSecTimeout)
									begin
										oneSecEnable <= 0;
										state <= PAIR1;
									end
								else
									state <= FLASH3;
							end
						PAIR1:
							begin
								if(bIn)
									begin
										if(num1 == switchIn)
											begin
												g1 <= 1;
												state <= PAIR2;
											end
										else
											state <= PAIR1;
									end
							end
						PAIR2:
							begin
								if(bIn)
									begin
										if(num2 == switchIn)
											begin
												g2 <= 1;
												state <= PAIR3;
											end
										else
											state <= PAIR2;
									end
							end
						PAIR3:
							begin
								if(bIn)
									begin
										if(num3 == switchIn)
											begin
												g3 <= 1;
												state <= FLASH1;
											end
										else
											state <= PAIR3;
									end
							end
						GAMEEND:
							begin
								endGame <= 1;
								state <= GAMEWAIT;
							end
					endcase
				end
		end

endmodule