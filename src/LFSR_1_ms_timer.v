module LFSR_1_ms_timer(clk, rst, enable, timeout);
  input clk, rst, enable;
  output reg timeout;
 // output [15:0] q;

  reg [15:0] LFSR;

  always @(posedge clk)
  begin
    if(timeout)
        begin
            LFSR <= 0;
            timeout <= 0;
        end
    else if(!rst)
        begin
            LFSR <= 0;
            timeout <= 0;
        end
    else if(enable)
        begin
            LFSR[0] <= ~LFSR[1] ^ LFSR[2] ^ LFSR[4] ^ LFSR[15];
            LFSR[15:1] <= LFSR[14:0];
            if(LFSR == 50000)
                timeout <= 1;
        end
  end

 // assign q = LFSR;
endmodule