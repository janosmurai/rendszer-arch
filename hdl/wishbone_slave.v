`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:34 04/11/2015 
// Design Name: 
// Module Name:    wishbone_slave 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module wishbone_slave(
	input rst_i,
	input clk_i,
	input [31:0] dat_i,
	input [31:0] adr_i,
	input we_i,
	input sel_i,
	input stb_i,
	input cyc_i,
	
	output [31:0] dat_o,
	output ack_o   
	);

reg [31:0] shift_reg;

always @(posedge clk_i)
begin
	//itt kéne szépen megvalósítani azt, hogy az i2c frekijének mefelelõen kishiftelni az adatokat
end

endmodule
