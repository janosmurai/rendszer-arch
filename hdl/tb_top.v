`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:43:42 05/13/2015
// Design Name:   top
// Module Name:   C:/Users/murai/Documents/vik_bme_msc/rendszerarchitekturak/hazi_feladat/rendszer-architekturak/tb_top.v
// Project Name:  rendszer-architekturak
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_top;

	// Inputs
	reg rst;
	reg clk;
	reg [31:0] control_dat;
	reg [31:0] control_adr;
	reg dat_rdy;
	reg set_addressLength;
	reg we;		//we == 0 -> write

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.rst(rst), 
		.clk(clk),
		.control_dat(control_dat),
		.control_adr(control_adr),
		.set_addressLength(set_addressLength),
		.we(we)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		control_adr = 0;
		control_dat = 0;
		dat_rdy = 0;
		set_addressLength = 0;
		we = 0;

		// Wait 100 ns for global reset to finish
		#100;
		        
		rst = 0;
		#5
		control_adr = 32'h1000_0000;
		control_dat = 32'hffff_ffff;
		set_addressLength = 1;			//10 bit periphery adress
		
		#5
		dat_rdy = 1;
		$display(dat_rdy);
		

	end
	
	always #5
	clk <= ~clk;
      
endmodule

