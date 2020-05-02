//ECE 5440
//Omar Baig 8007
//sends a high signal every 100 milliseconds for a clock cycle
module one_hundred_ms_timer(clk, rst, enable, timeout, N);

	input clk, rst, enable;
	input[9:0] N;
	output timeout;

	wire one_ms_timeout;

	one_ms_timer one_ms_timer1(clk, rst, enable, one_ms_timeout);
	countToN countToN_1(clk, rst, one_ms_timeout, timeout, N);
endmodule