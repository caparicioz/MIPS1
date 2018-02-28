module MIPS_TB;
//Input Ports
reg clk, reset;

MIPS #(.DATA_WIDTH(32), .ADDR_WIDTH(32), .ADDR_SIZE(8), .DATA_BASE_ADDRESS('h40_0000)) duv(.clk(clk), .reset(reset));
/*********************************************************/
initial begin // Clock generator
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 clk = 0;
	#0 reset = 0;
	#10 reset = 1;
end
endmodule
