//ECE 5440
//Omar Baig 8007
//creates a digit for the timer
//borrowDown gives a carry to lower sig digit, noBorrowUp means higher sig digit can't give a carry
//borrowUp asks for a carry from higher sig digit, noBorrowDown means can't give lower sig digit a carry

module digitTimer(clk, rst, reconfig, numIn, borrowUp, noBorrowUp, noBorrowDown, borrowDown, count);

    input clk, rst, reconfig, noBorrowUp, borrowDown;
    input[3:0] numIn;

    output borrowUp, noBorrowDown;
    reg borrowUp, noBorrowDown;
	
    output[3:0] count;
    reg[3:0] count;

    always @(posedge clk)
        begin
            if(rst == 0)
                begin
                    count <= 0;
                    borrowUp <= 1'b1;
                    noBorrowDown <= 1'b1;
                end
            else if(reconfig == 1)
                begin
				    if(numIn > 0)
						begin
							count <= numIn;
						    borrowUp <= 1'b0;
						    noBorrowDown <= 1'b0;	
						end

                    if(count > 4'b1001)
                        count <= 4'b1001;
                end
				else
					begin
						if(borrowUp == 1) // if this unit needs to borrow
							 begin
								  if(noBorrowUp == 1) // if unit above can't give
										begin
											noBorrowDown <= 1;
											count <= 0;
										end
									else
										begin
											borrowUp <= 0;
											noBorrowDown <= 0;
										end
							 end
						else if(borrowDown == 1) // can give down
							 begin
								  count <= count - 1;
								  if(count == 0)
										begin
											borrowUp <= 1;
										end
							 end
					end
			if(count > 9)
					count <= 9;
        end

endmodule
