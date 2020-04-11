//ECE 5440
//Omar Baig 8007
//adder
//takes two numerical inputs and adds them together and stores them into an output

module adder(num1, num2, sum);

	input	[3:0] num1, num2;
	output	[3:0] sum;
	reg	[3:0] sum;

	always @(num1, num2)
		begin
			sum = num1 + num2;
		end
endmodule

