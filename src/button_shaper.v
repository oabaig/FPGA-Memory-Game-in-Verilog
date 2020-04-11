//ECE 5440
//Omar Baig 8007
//shapes the button input to a short high pulse from long low pulse
module button_shaper(clk, rst, bIn, bOut); 
 
 	input 	clk, rst, bIn; 
 	output bOut;  	
	reg  	bOut; 
 	reg [1:0] state; 
 
 	parameter INIT = 2'b00, PULSE = 2'b01, WAIT = 2'b10; 
 
 	always @ (posedge clk) 
 	 	begin 
 	 	 	if(rst == 0) 
 	 	 	 	begin 
 	 	 	 	 	state <= INIT;  	 	
		 	 	 	bOut = 1'b0; 
 	 	 	 	end 
 	 	 	else  	 	 	 	
				begin 
 	 	 	 	 	case(state) 
 	 	 	 	 	 	INIT:   	 	
		 	 	 	 	 	begin 
 	 	 	 	 	 	 	 	if(bIn == 1'b1) 
 	 	 	 	 	 	 	 	 	begin 
 	 	 	 	 	 	 	 	 	 	state = INIT;  	 	 	 	 	 	 	 	 	 	
										bOut = 1'b0; 
	 	 	 	 	 	 	 	 	end 
 	 	 	 	 	 	 		else  	 	 	 	 	 	 	 
									begin 
	 	 	 	 	 	 	 	 	 	state = PULSE; 
 	 	 	 	 	 	 	 	 	 	bOut = 1'b1; 
 	 	 	 	 	 	 	 	 	end  	 	 	 	 	 	
						 	end 
 	 	 	 	 	 	PULSE:   	 	 	 	 	 	 	
							begin 
 	 	 	 	 	 	 	 	state = WAIT;  	 	 	 	 	 	 	 	
								bOut = 1'b0; 
 	 	 	 	 	 	 	end  	 	 	 	 	 	
						WAIT:  	 	 	 	 	 	 	
							begin 
 	 	 	 	 	 	 	 	if(bIn == 1'b1) 
 	 	 	 	 	 	 	 	 	begin 
 	 	 	 	 	 	 	 	 	 	state = INIT;  	 	 	 	 	 	 	 	 	 	
										bOut = 1'b0; 
 	 	 	 	 	 	 	 	 	end  	 	 	 	 	 	 	 	
								else  	 	 	 	 	 	 	 	
								 	begin 
 	 	 	 	 	 	 	 	 	 	state = WAIT;  	 	 	 	 	 	 	 	 	 	
										bOut = 1'b0; 
 	 	 	 	 	 	 	 	 	end  	 	 	 	 	 	 	
							end 
 	 	 	 	 	endcase 
 	 	 	 	end 
 	 	end 
endmodule 

