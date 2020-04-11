//ECE 5440
//Omar Baig 8007
//sends a high signal every 100 milliseconds for a clock cycle
module one_hundred_ms_timer(clk, rst, enable, timeout);

	input clk, rst, enable;
	output timeout;

	wire one_ms_timeout;

	one_ms_timer one_ms_timer1(clk, rst, enable, one_ms_timeout);
	countTo100 countTo100_1(clk, rst, one_ms_timeout, timeout);
endmodule