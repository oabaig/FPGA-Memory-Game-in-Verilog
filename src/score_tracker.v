 module score_tracker(
	playerID, // Input signal comes from Access Controller specifying which player is currently in game
	newScore, //Input signal comes from game module with total points from player in the round 
	 rst, clk,
	enable, // request signal that only does comparisons when asked, else state machine will run for no reason. 
	 // Outputs player the max number of points of the game 
	maxSeg 
	);

	input [2:0] playerID; 
	input [2:0] newScore; 
	input  clk, rst, enable; 

	output [2:0] maxSeg; 

	
	// Registers and Wires for RAM Module 
	reg [2:0] RAMaddr, data;//needed for RAM instation 
	reg wren; 
	wire [2:0] q;

	 
	reg [2:0] currentScore,scoreIN; //Current score that is stored in RAM...which will be zero until new score is written into it, ScoreIN is reg for new score inputs
	reg[2:0] maxPoints,maxSeg; //Maxpoints - reg for the high score in RAM;  MaxSeg- High Score to displey to 7seg
	reg[3:0] state; 

	parameter RAM_RESET= 0, COMPARE_SCORE=1; 
	parameter STORE_SCORE=2, GET_MAX=3; 
	parameter COMPARE_MAX1=4, COMPARE_SCORE1=5;
	parameter DISPLAY_MAX=6, WAIT2=7;
	parameter INIT=8, WAIT1=9;
	parameter STORE_MAX=10, WAIT4=11;
	parameter WAIT5=12, WAIT6=13;
	parameter COMPARE_MAX2=14, RAM_RESET2=15; 

	RAMinitial Ram_init_1 (RAMaddr,clk,data,wren,q);

always @(posedge clk) 

begin 
	if(rst == 0) 
		begin 
		state<= RAM_RESET;
		end 
	else 
		begin 
case(state) 

	RAM_RESET: 
	begin 
		RAMaddr<=0;
		state<=RAM_RESET2;
	end 
	
	RAM_RESET2: 
	begin 
		wren<=1; 
		data<=3'b000;
		if(RAMaddr < 3'b100)
		begin 
			RAMaddr<=RAMaddr+1;
			state<=RAM_RESET2; 
		end 
		else 
			state<=INIT;
	end 

	INIT:
	begin 
		if(enable ==1) 
		begin 
			scoreIN<=newScore; 
			RAMaddr <= playerID; 
			wren<=0;
			state <= WAIT1;
		end 
	
		else 
			state<=INIT; 
	end 
	
	WAIT1:
	begin 
		state<=WAIT2;
	end 

	WAIT2:
	begin 
		state<=COMPARE_SCORE;
	end 
	

	COMPARE_SCORE:
	 
	begin 
		
		currentScore<=q;
		state<= COMPARE_SCORE1; 
	end 
	
	COMPARE_SCORE1: begin 
		
		if(currentScore > scoreIN)
			begin 
				state <= INIT; 
			end 
		else 
			begin 
				state<= STORE_SCORE; // store the new score 
				
			end 
	end 

	STORE_SCORE: 

	begin 
		//Need to store newScore into playersID/Addr
		RAMaddr<=playerID;  
		wren <= 1; 
		data <= scoreIN;
 
		state<= GET_MAX; 
		//state<=INIT;
		
	end 

	GET_MAX: 
	begin 
		
		RAMaddr<=3'b101;
		wren<=0;
		state<=WAIT4;
	end 
	
	WAIT4:
	begin 
		state<=WAIT5;
	end 

	WAIT5:
	begin 
		state<=COMPARE_MAX1;
	end 

	COMPARE_MAX1: 
	begin
		maxPoints<=q; 
		state<=COMPARE_MAX2;
	end 

	COMPARE_MAX2:
	begin 
		if( scoreIN > maxPoints) 
			begin 
				state<=STORE_MAX;
			end 
		else 
			begin 
				state<=INIT; 
			end 
	end 

	STORE_MAX: begin 
		wren <= 1; 
		RAMaddr<= 3'b101; //MAX score always in held in address 5
		data <= scoreIN; // store this in the MAX RAM address 
		//maxPoints <= newScore; // new maxPoints variable should be new score that came in now 
		state<= DISPLAY_MAX;
		end 

	DISPLAY_MAX: begin 
		
		//maxSeg<=maxPoints;
		maxSeg<=scoreIN; 
		state<=INIT;

		end 

		

endcase 
end 
end 
endmodule 
		
		
		
		
		
		
	

