`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:40 04/11/2015 
// Design Name: 
// Module Name:    top 
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
module top(
	input rst,
	input clk
    );

wishbone_master wb_m(
	.rst_i(rst),
	.clk_i(clk),
	.dat_i(),
	.ack_i(),
	
	.adr_o(),
	.dat_o(),
	.we_o(),
	.sel_o(),
	.stb_o(),
	.cyc_o()
);


wishbone_slave wb_s(

	.rst_i(rst),
	.clk_i(clk),
	.dat_i(),
	.adr_i(),
	.we_i(),
	.sel_i(),
	.stb_i(),
	.cyc_i(),
	
	.dat_o(),
	.ack_o()   
);
	

endmodule
