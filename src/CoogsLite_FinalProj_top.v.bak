module CoogsLite_FinalProj_top(clk, rst, switches, buttonIn,
							   max7seg, score7seg, digit17seg, digit27seg, g1,g2,g3, redLight);
	
	input clk, rst, buttonIn;
	input[15:0] switches;

	output g1,g2,g3;
	output[6:0] max7seg, score7seg, digit17seg, digit27seg;
	output[15:0] redLight;

	assign passwordSwitch = switches[3:0];

	wire bIn, digitTimeout, reconfig, oneSecTimeout, oneSecShaped, finalTimeout;
	wire[3:0] score, maxScore;
	wire[7:0] playerAddress;

	wire  borrowUp1, noBorrowDown1, borrowUp2, final;
	wire [3:0] digitCount1, digitCount2;

	button_shaper butIn(clk, rst, buttonIn, bIn);
	button_shaper oneSecShape(clk, rst, finalTimeout, final); // shaped one second timeout to make it a short pulse

	accessCont accessController(clk, rst, passwordSwitch, bIn, reconfig, playerAddress, switches, 
		                        score, redLight, g1,g2,g3, final);

	digitTimer digit1(clk, rst, reconfig, 3'b110, borrowUp1, 1'b1, noBorrowDown1, borrowUp2, digitCount1);
	digitTimer digit2(clk, rst, reconfig, 1'b0, borrowUp2, noBorrowDown1, 
		              finalTimeout, oneSecTimeout, digitCount2);

	score_tracker scoretrack(playerAddress, score, rst, clk, 1'b1, maxScore);

	seven_seg maxScoreSeg(maxScore, max7seg);
	seven_seg ScoreSeg(score, score7seg);
	seven_seg digit1Seg(digitCount1, digit17seg);
	seven_seg digit2Seg(digitCount2, digit27seg);

endmodule