//ECE 5440
//Omar Baig 8007
//access_controller
//acts as a password manager for the binary math game.
//must input a number and press the button to load a number
//if password is correct, light turns green
module access_controller(clk, rst, loadP1, loadP2, pw, pwButton, finalTimeout,
						 loadP1Pass, loadP2Pass, GR, RD, reconfig, timerEnable);

	input clk, rst, pwButton, loadP1, loadP2, finalTimeout; //clock, reset, password button, loadP1 signal, loadP2 signal
	input [3:0]	pw; //password

	output GR, RD, loadP1Pass, loadP2Pass, reconfig, timerEnable; //green, red, "set if good", loadP1Pass, loadP2Pass

	
	reg GR, RD, loadP1Pass, loadP2Pass, pwManager, reconfig, timerEnable;
	reg [3:0] state; //state

	reg [3:0] passInput; // takes input from pw stores into passInput during DIGIT
	reg [1:0] addr; // ROM address
   wire [3:0] data; // ROM data
	reg [3:0] ROMout; // takes input from data during ROMOUT

	ROM_MODULE ROM_module_instance(addr, clk, data); // ROM instance
	
	parameter DIGIT = 0, WAIT1 = 1, WAIT2 = 2;
    parameter ROMOUT = 3, COMPARE = 4, INCREMENT = 5, PWCHECK = 6, PASSED = 7;
    parameter RECONFIG = 8, GAMEWAIT = 9, GAMESTART = 10, GAMEOVER = 11;

	always @(posedge clk)
		begin
			if(rst == 0)
				begin
					state <= DIGIT;
					loadP1Pass <= 0;
					loadP2Pass <= 0;
					GR <= 0;
					RD <= 1;
					pwManager <= 1'b1; //so far so good
					reconfig <= 0;
					timerEnable <= 0;
					addr <= 0;
				end
			else
				begin
					case(state)
						DIGIT:	
							begin
								if(pwButton == 1)
									begin
										state <= WAIT1;
										passInput <= pw;
									end
								else
									state <= DIGIT;
							end
						WAIT1:
							state <= WAIT2;
						WAIT2:
							state <= ROMOUT;
						ROMOUT:
							begin
								ROMout <= data;
								state <= COMPARE;
							end
						COMPARE:
							begin
								if(passInput != ROMout)
									begin
										pwManager <= 0;
									end
								state <= INCREMENT;
							end
						INCREMENT:
							begin
								addr <= addr + 1;
								if(addr == 3)
									state <= PWCHECK;
								else
									state <= DIGIT;
							end
						PWCHECK:
							begin
								if(pwManager == 1)
									begin
										state <= PASSED;
									end
								else
									begin
										state <= DIGIT;
										pwManager <= 1;
										addr <= 0;
									end
							end
						PASSED:
							begin
								GR <= 1;
								RD <= 0;
								state <= RECONFIG;
							end
						RECONFIG:
							begin
								reconfig <= pwButton;
								if(pwButton == 1)
									begin
										state <= GAMEWAIT;
									end
								else
									state <= RECONFIG;
							end
						GAMEWAIT:
							begin
								reconfig <= 0;
								if(pwButton == 1)
									state <= GAMESTART;
								else
									state <= GAMEWAIT;
							end
						GAMESTART:
							begin
								timerEnable <= 1;
								loadP1Pass <= loadP1;
								loadP2Pass <= loadP2;
								if(finalTimeout == 1)
									state <= GAMEOVER;
								else
									state <= GAMESTART;
							end
						GAMEOVER:
							begin
								loadP1Pass <= 0;
								loadP2Pass <= 0;
								timerEnable <= 0;
								RD <= 1;
								state <= RECONFIG;
							end
					endcase
				end
		end
endmodule
