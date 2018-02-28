module Mux2to1
#(
	parameter WORD_LENGTH
)
(
	// Input Ports
	input selector,
	input [WORD_LENGTH-1:0]Data_0,
	input [WORD_LENGTH-1:0]Data_1,	
	// Output Ports
	output [WORD_LENGTH-1:0] Mux_Output
);
assign Mux_Output=selector ? Data_1:Data_0;

endmodule
