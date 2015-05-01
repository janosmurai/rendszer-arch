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
module wishbone_slave #(
	parameter slave_addr = 32'h00000000)
	(
	input rst_i,
	input clk_i,
	input [31:0] dat_i,
	input [31:0] adr_i,
	input we_i,
	input sel_i,
	input stb_i,
	input cyc_i,
	
	output [31:0] dat_o,
	output ack_o,   
	
	//interfész az i2c felé
	input spi_en,
	
	output spi_out
	
	);
	
reg selected;
reg ack;
reg [31:0] shift_reg;

always @(posedge clk_i)
begin
	if(rst) selected <= 0;
	else if(adr_i == slave_addr) selected <= 1;
	else selected <= 0;
end
	
	
always @(posedge clk_i)
begin
	if(rst)
	begin
		shift_reg <= 0;
		ack <= 0;
	end
	else if(sel_i && we_i && stb_i && selected)
	begin
		shift_reg <= dat_i;
		ack <= 1;
	end
	else 
		ack <= 0;
end


always @(posedge clk_i)
begin
	if(rst) spi_out <= 0;
	else if(spi_en) shift_reg <= {0,shift_reg[31:1]};
end

assign spi_out = shift_reg[0];

endmodule
