//ECE5440
//Eduardo Cantu, 9291
//Module for access controller.
module accessCont(clk, rst, b_ac, swt_ac, led_r, led_g, b_1, b_out, b_rand, b_start, b_start1, nbr_dn1, nbr_dn2, bi_rand); 
	input clk, rst, b_ac, b_1, bi_rand, nbr_dn1, nbr_dn2;
	input [3:0] swt_ac;
	output led_r, led_g, b_out, b_rand, b_start, b_start1;
	reg led_r, led_g, b_out, b_rand, b_start, b_start1, dummy1;
	reg [7:0] addr1, addr2;
	reg [3:0] state;
	reg [15:0] USER;
	reg [19:0] PASSWORD;
	wire [15:0] data1;
	wire [19:0] data2;
	
	ROM_USER ROM_USER_instance(addr1, clk, data1);
	ROM_PASS ROM_PASS_instance(addr2, clk, data2);
	
	parameter bp_1 = 0; 
	parameter bp_2 = 1; 
	parameter bp_3 = 2;
	parameter bp_4 = 3;
	parameter compData = 4;
	parameter pass = 5;
	parameter adjust = 6;
	parameter auth = 7;
	parameter gameStart = 8;
	parameter stage1 = 9;
	parameter stage2 = 10;	
	parameter stage3 = 11;
	always@(posedge clk)
		begin
			if(rst == 0) 
				begin
					led_r <= 1'b1;
					led_g <= 1'b0;
					b_out = 0;
					b_rand <= 1;
					b_start1 <= 0;
					b_start <= 0;
					USER <= 0;
					addr1 <= 0;
					addr2 <= 0;
					PASSWORD <= 0;
					dummy1 <= 0;
					state <= bp_1;
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
									led_g <= 1;
									led_r <= 0;
									b_out = b_1;									
									b_rand = bi_rand;
									if(b_ac == 1) begin
										b_start <= 1;
										state <=stage1;
									end
									else begin
									state <= gameStart;
									end																			
							end
						stage1:
							begin
								if(b_ac == 1) begin
									b_out = b_1;									
									b_rand = bi_rand;
									b_start1 = 1;
									b_start = 0;
									state = stage2;	
								end
								else begin
									state <= stage1;
								end
							end
						stage2: 
							begin	
									b_out = b_1;									
									b_rand = bi_rand;
								if(nbr_dn1 == 1 && nbr_dn2 == 1) begin
									state <= stage3;
								end
								else begin
									state <= stage2;
								end
							end
						stage3: 
							begin
									b_out = 0;									
									b_rand = 1;
								if(b_ac == 1) begin
									b_start <= 1;
									state <= stage1;
								end
								else begin
									state <= stage3;
								end
							end
					endcase
				end
		end
endmodule

