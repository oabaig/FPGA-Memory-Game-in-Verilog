//ECE 5440
//Omar Baig 8007
//prevents numbers from passing until button is pressed
module load_register(clk, rst, in, bp, out); 
 
 	input 	 	clk, rst, bp;  	
	input 	[3:0] 	in; 
 	 
 	output [3:0] out;  reg [3:0] out; 
 
 	always @ (posedge clk) 
 	 	begin 
			if(rst == 0)
				out = 0;
 	 	 	else if(bp == 1)  	 	 	 	
				out = in; 
 	 	end 
endmodule 

