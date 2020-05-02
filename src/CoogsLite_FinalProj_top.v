module CoogsLite_FinalProj_top(clk, rst, switches, buttonIn, addrButton,
							   max7seg, score7seg, digit17seg, digit27seg, player7seg, maxPlayer7Seg, g1,g2,g3, redLight, g4);
	
	input clk, rst, buttonIn, addrButton;
	input[17:0] switches;

	output g1,g2,g3, g4;
	output[6:0] max7seg, score7seg, digit17seg, digit27seg, player7seg, maxPlayer7Seg;
	output[15:0] redLight;


	wire bIn, digitTimeout, reconfig, oneSecTimeout, oneSecShaped, finalTimeout, gameEnd, timerEnable, playerADdressButton;
	wire[3:0] score, maxScore;
	wire[2:0] playerAddress, maxUser;

	wire  borrowUp1, noBorrowDown1, borrowUp2;
	wire [3:0] digitCount1, digitCount2;

	button_shaper butIn(clk, rst, buttonIn, bIn);
	button_shaper addrBut(clk, rst, addrButton, playerAddressButton);

	accessCont accessController(clk, rst, switches[3:0], bIn, reconfig, playerAddress, playerAddressButton, switches[17:2], 
		                        score, redLight, g1,g2,g3, finalTimeout, gameEnd, timerEnable, switches[7:4], g4);

	one_second_timer oneSecTimer(clk, rst, timerEnable, oneSecTimeout, 100);
	digitTimer digit1(clk, rst, reconfig, 3'b110, borrowUp1, 1'b1, noBorrowDown1, borrowUp2, digitCount1);
	digitTimer digit2(clk, rst, reconfig, 1'b0, borrowUp2, noBorrowDown1, 
		              finalTimeout, oneSecTimeout, digitCount2);

	score_tracker scoretrack(playerAddress, score, rst, clk, 1'b1, maxScore, maxUser);

	seven_seg maxScoreSeg(maxScore, max7seg);
	seven_seg ScoreSeg(score, score7seg);
	seven_seg digit1Seg(digitCount1, digit17seg);
	seven_seg digit2Seg(digitCount2, digit27seg);
	seven_seg playerSeg(playerAddress, player7seg);
	seven_seg maxPlayerSeg(maxUser, maxPlayer7Seg);

endmodule