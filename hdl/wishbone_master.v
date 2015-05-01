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
	//wb signals
	input rst_i,
	input clk_i,
	input [31:0] dat_i,
	input ack_i,
	
	output [31:0] adr_o,
	output [31:0] dat_o,
	output we_o,
	output sel_o,
	output stb_o,
	output cyc_o,
	
	//master controlling signals
	input [31:0] control_dat,
	input [31:0] control_adr,
	input dat_rdy
    );

always @(posedge clk)
begin
	if(rst_i || ack_i)
	begin
		adr_o <= 0;
		dat_o <= 0;
		we_o <= 0;
		sel_o <= 0;
		sys_o <= 0;
	end
	else if(dat_rdy)
	begin
		adr_o <= control_adr;
		dat_o <= control_dat;
		we_o <= 1;					//write
		sel_o <= 1;
		cyc_o <= 1;
	end
end
		

endmodule
