`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:10:24 04/11/2015 
// Design Name: 
// Module Name:    wishbone 
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
module wishbone_master(
	input rst_i,
	input clk_i,
	input [31:0] dat_i,
	input ack_i,
	
	output [31:0] adr_o,
	output [31:0] dat_o,
	output we_o,
	output sel_o,
	output stb_o,
	output cyc_o
    );


endmodule
