module memory_game(clk, rst, enable, bIn, switchIn, gameTimeout, // inputs
				   score, redLight, g1, g2, g3, endGame); // outputs

	input clk, rst, enable, bIn, gameTimeout;
	input[15:0] switchIn;
	
	output reg g1, g2, g3, endGame;
	output reg[3:0] score;
	output reg[15:0] redLight;

	reg oneSecEnable, enablePairs;
	reg[15:0] num1, num2, num3;

	reg[3:0] state;
	parameter[3:0] GAMEWAIT = 0, INIT = 1, RETRIEVE = 2, FLASH1 = 3, FLASH2 = 4, FLASH3 = 5,
				   PAIR1 = 6, PAIR2 = 7, PAIR3 = 8, GAMEEND = 9;

	wire oneSecTimeout, endPairs;
	wire [3:0] A, B, C, D, E, F;

	wire [3:0] counter;

	memoryPairs memPairs(clk, rst, enablePairs, A, B, C, D, E, F, endPairs);
	one_second_timer oneSecondTimer(clk, rst, oneSecEnable, oneSecTimeout);

	always @(posedge clk)
		begin
			if(!rst)
				begin
					state <= GAMEWAIT;
					redLight <= 16'b0000_0000_0000_0000;
					g1 <= 0;
					g2 <= 0;
					g3 <= 0;
					score <= 0;
					oneSecEnable <= 0;
					endGame <= 0;
					enablePairs <= 0;
				end
			else if(gameTimeout)
				state <= GAMEEND;
			else if(enable)
				begin
					case(state)
						GAMEWAIT:
							begin
								if(bIn)
									state <= INIT;
								else
									state <= GAMEWAIT;
							end
						INIT:
							begin
								g1 <= 0;
								g2 <= 0;
								g3 <= 0;
								enablePairs <= 1;
								state <= RETRIEVE;
							end
						RETRIEVE:
							begin
								enablePairs <= 0;
								if(endPairs)
									begin
										num1 = 16'b0000_0000_0000_0000;
										num1[A] = 1'b1;
										num1[F] = 1'b1;
										num2 = 16'b0000_0000_0000_0000;
										num2[B] = 1'b1;
										num2[E] = 1'b1;
										num3 = 16'b0000_0000_0000_0000;
										num3[C] = 1'b1;
										num3[D] = 1'b1;
										enablePairs <= 0;
										state <= FLASH1;
									end
								else
									state <= RETRIEVE;
							end
						FLASH1:
							begin
								oneSecEnable <= 1;
								redLight[A] <= 1'b1;
								redLight[F] <= 1'b1;
								if(oneSecTimeout)
									begin
										redLight <= 16'b0000_0000_0000_0000;
										oneSecEnable <= 0;
										state <= FLASH2;
									end
								else
									state <= FLASH1;
							end
						FLASH2:
							begin
								oneSecEnable <= 1;
								redLight[B] <= 1'b1;
								redLight[E] <= 1'b1;
								if(oneSecTimeout)
									begin
										redLight <= 16'b0000_0000_0000_0000;
										oneSecEnable <= 0;
										state <= FLASH3;
									end
								else
									state <= FLASH2;
							end
						FLASH3:
							begin
								oneSecEnable <= 1;
								redLight[C] <= 1'b1;
								redLight[D] <= 1'b1;
								if(oneSecTimeout)
									begin
										redLight <= 16'b0000_0000_0000_0000;
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
								else
									state <= PAIR1;
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
								else
									state <= PAIR2;
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
											begin
												state <= INIT;
												score <= score + 1;
											end
									end
								else 
									state <= PAIR3;
							end
						GAMEEND:
							begin
								endGame <= 1;
								state <= GAMEWAIT;
								redLight <= 0;
							end
					endcase
				end
		end

endmodule