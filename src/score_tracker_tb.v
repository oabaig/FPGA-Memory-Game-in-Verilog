
`timescale 10ns/100ps 

module score_tracker_tb(); 

	reg [2:0] playerID; // Input signal comes from Access Controller specifying which player is currently in game
	reg [2:0] newScore; //Input signal comes from ___ module with total points from player in the round 
	reg  clk, rst; 
	wire [2:0] maxSeg; // Outputs player ID with the max number of points
	

	score_tracker DUT_score_tracker_1( playerID, newScore, rst, clk, maxSeg);
	always begin 
		clk <=0;
		#5; clk<=1; 
		#5; 
	end 

initial 
	begin 
rst=1; 
@ (posedge clk); 
@ (posedge clk);
rst=0;  
@ (posedge clk); 
@ (posedge clk); 
rst=1;
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
 playerID<=0; 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
 newScore<=3'b011;
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
playerID<=3'b001; 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
 newScore<=3'b100;
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk);
@ (posedge clk);  
 playerID<=3'b010; 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
 newScore<=3'b110;
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
 playerID<=0; 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
newScore<=3'b001;
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 

/// add new high score to see if it updates 
playerID<=3'b010; 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
 newScore<=3'b111;
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk); 
@ (posedge clk);
	end 
endmodule  