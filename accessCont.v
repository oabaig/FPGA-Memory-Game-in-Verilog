//ECE5440
//Eduardo Cantu, 9291
//Module for access controller.
module accessCont(clk, rst, swt_ac,
				  gameSwitches, gameButton, score, redLight, g1, g2, g3, gameTimeout); 
	input clk, rst, b_ac, nbr_dn1, nbr_dn2;
	input [3:0] swt_ac;
	reg dummy1;
	reg [7:0] addr1, addr2;
	reg [3:0] state;
	reg [15:0] USER;
	reg [19:0] PASSWORD;
	wire [15:0] data1;
	wire [19:0] data2;

	ROM_USER ROM_USER_instance(addr1, clk, data1);
	ROM_PASS ROM_PASS_instance(addr2, clk, data2);

	input gameButton, gameTimeout;
	input[15:0] gameSwitches;
	output g1, g2, g3, gameEnd, timerEnable;
	output[4:0] score;
	output[15:0] redLight;
	reg gameEnable;

	memory_game mem_game(clk, rst, gameEnable, gameButton, gameSwitches, gameTimeout
						 score, redLight, g1,g2,g3, gameEnd, timerEnable);
	
	parameter bp_1 = 0; 
	parameter bp_2 = 1; 
	parameter bp_3 = 2;
	parameter bp_4 = 3;
	parameter compData = 4;
	parameter pass = 5;
	parameter adjust = 6;
	parameter auth = 7;
	parameter gameStart = 8;

	always@(posedge clk)
	begin
		if(rst == 0) 
			begin
				USER <= 0;
				addr1 <= 0;
				addr2 <= 0;
				PASSWORD <= 0;
				dummy1 <= 0;
				state <= bp_1;

				gameEnable <= 0;
			end
		else begin
				case(state)
					bp_1: 
						begin
							if(b_ac == 1) begin
								if(dummy1 == 0) begin
									USER[15:12] <= swt_ac;
									state <= bp_2;
								end
								if(dummy1 == 1) begin
									PASSWORD[19:16] <= swt_ac;
									state <= bp_2;
								end
							end
						end	
					bp_2:
						begin
							if(b_ac == 1) begin
								if(dummy1 == 0) begin
									USER[11:8] = swt_ac;
									state <= bp_3;
								end
								if(dummy1 == 1) begin
									PASSWORD[15:12] <= swt_ac;
									state <= bp_3;
								end
							end
						end
					bp_3:
						begin
							if(b_ac == 1) begin
								if(dummy1 == 0) begin
									USER[7:4] <= swt_ac;
									state <= bp_4;
								end
								if(dummy1 == 1) begin
									PASSWORD[11:8] = swt_ac;
									state <= bp_4;
								end
							end
						end
					bp_4:
						begin
							if(b_ac == 1) begin
								if(dummy1 == 0) begin
									USER[3:0] <= swt_ac;
									state <= compData;
								end
								if(dummy1 == 1) begin
									PASSWORD[7:4] <= swt_ac;
									state <= pass;
								end
							end
						end
					compData:
						begin
							if(USER != data1) begin
								addr1 <= addr1 + 1;
								addr2 <= addr2 + 1;
							end
							if(USER == data1) begin
								dummy1 <= 1;
								state <= bp_1;
							end
							if(addr1 >= 7) begin
								dummy1 <= 0;
								state <= bp_1;
							end
						end	
					pass:
						begin
							if(b_ac == 1) begin
									PASSWORD[3:0] <= swt_ac;
									state <= adjust;
							end
						end
				
					adjust:
						begin
							if(addr2 >= 1) begin
								addr2 <= addr2 - 2;
							end
							state <= auth;
						end
					auth:
						begin
							if(PASSWORD == data2) begin
								state <= gameStart;
							end
						end
					gameStart: 
						begin
							gameEnable <= 1;																		
						end
				endcase
			end
	end
endmodule

