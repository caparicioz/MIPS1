 /******************************************************************* 
* Name:
*	Register.v
* Description:
* 	This module is a register with parameter.
* Inputs:
*	clk: Clock signal 
*  reset: reset signal
*	Data_Input: Data to lache data 
* Outputs:
* 	Mux_Output: Data to provide lached data
* Versión:  
*	1.0
* Author: 
*	José Luis Pizano Escalante
* Fecha: 
*	07/02/2013 
*********************************************************************/

 module Register
#(
	parameter WORD_LENGTH = 32
)
(
	// Input Ports
	input clk,
	input reset,
	input enable,
	input [WORD_LENGTH-1 : 0] Data_Input,
	// Output Ports
	output [WORD_LENGTH-1 : 0] Data_Output
);

reg  [WORD_LENGTH-1 : 0] Data_reg;
always@(posedge clk) begin
	if(~reset) Data_reg <= 0;
	else begin
			if (enable)	Data_reg <= Data_Input;
			else Data_reg <= Data_reg;
		end
end
assign Data_Output = Data_reg;
endmodule