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

wire wb_m2s_dat;
wire wb_m2s_adr;
wire wb_m2s_we;
wire wb_m2s_sel;
wire wb_m2s_stb;
wire wb_m2s_cyc;

wire wb_s2m_dat;
wire wb_s2m_ack;

wishbone_master wb_m(
	.rst_i(rst),
	.clk_i(clk),
	.dat_i(wb_s2m_dat),
	.ack_i(wb_s2m_ack),
	
	.adr_o(wb_m2s_adr),
	.dat_o(wb_m2s_dat),
	.we_o(wb_m2s_we),
	.sel_o(wb_m2s_sel),
	.stb_o(wb_m2s_stb),
	.cyc_o(wb_m2s_cyc)
);


wishbone_slave wb_s(

	.rst_i(rst),
	.clk_i(clk),
	.dat_i(wb_m2s_adr),
	.adr_i(wb_m2s_dat),
	.we_i(wb_m2s_we),
	.sel_i(wb_m2s_sel),
	.stb_i(wb_m2s_stb),
	.cyc_i(wb_m2s_cyc),
	
	.dat_o(wb_s2m_dat),
	.ack_o(wb_s2m_ack)   
);
	

endmodule
