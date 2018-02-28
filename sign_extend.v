/******************************************************************* 
* Name:
*	sign_extend.v
* Description:
* 	combinational module that extends sign from a 16 input data into a 32 to output dat
* Inputs:
*  Data_in: input data
* Outputs:
* 	Data_out: Output data
* Versión:  
*	1.0
* Author: 
*	Christian Aparicio Zuleta
* Fecha: 
*	05/05/2017 
*********************************************************************/
module sign_extend(
	input [15:0] Data_in,
	output [31:0] Data_out
);

assign Data_out = (Data_in[15])?{{16{1'b1}},Data_in}:{{16{1'b0}},Data_in};
endmodule