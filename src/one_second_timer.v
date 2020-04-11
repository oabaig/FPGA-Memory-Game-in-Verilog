//ECE 5440
//Omar Baig 8007
//sends out a high signal every 1 second for a clock cycle
module one_second_timer(clk, rst, enable, timeout);

	input clk, rst, enable;
	output timeout;

	wire one_hundred_ms_timeout;

	one_hundred_ms_timer one_hundred_ms_timer1(clk, rst, enable, one_hundred_ms_timeout);
	countTo10 countTo10_1(clk, rst, one_hundred_ms_timeout, timeout);
endmodule