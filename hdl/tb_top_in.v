`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:56:25 05/14/2015
// Design Name:   top
// Module Name:   C:/Users/murai/Documents/vik_bme_msc/rendszerarchitekturak/hazi_feladat/rendszer-architekturak/tb_top_in.v
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

module tb_top_in;

	// Inputs
	reg rst;
	reg clk;
	reg [31:0] control_dat;
	reg [31:0] control_adr;
	reg dat_rdy;
	reg set_addressLength;
	reg we;

	// Outputs
	wire scl;

	// Bidirs
	wire sda;
	
	// Data reg
	reg [31:0]data = {32{1'b1}};

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.rst(rst), 
		.clk(clk), 
		.control_dat(control_dat), 
		.control_adr(control_adr), 
		.dat_rdy(dat_rdy), 
		.set_addressLength(set_addressLength), 
		.we(we), 
		.sda(sda), 
		.scl(scl)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		control_dat = 0;
		control_adr = 0;
		dat_rdy = 0;
		set_addressLength = 0;
		we = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		rst = 0;
		control_adr = 32'h1000_0000;
		we = 1;
		set_addressLength = 1;
		dat_rdy = 1;

	end
	
	always #5
	clk <= ~clk;
	
	reg [15:0]check_addr;
	reg old_sda;
	reg old_scl;
	reg frame_start;
	reg we_feedback;
	reg ack_feedback;
	reg sda_reg;
	
	always @(posedge clk)
	begin
		if(rst) check_addr <= 0;
		else if(((sda == 0) && (old_sda == 1)) && ((scl == 0) && (old_scl == 1))) 
		begin
			frame_start <= 1;
		end
		else frame_start <= 0;
	end
	
	reg [4:0] address_bit_cntr;
	reg [4:0] old_address_bit_cntr;
	always @(posedge clk)
	begin	
		if(rst || (address_bit_cntr == 17)) address_bit_cntr <= 0;
		else if(frame_start) address_bit_cntr <= address_bit_cntr + 1;
		else old_address_bit_cntr <= address_bit_cntr;
	end
	
	always @(posedge clk)
	begin
		if(rst) 
		begin	
			check_addr <= 0;
			we_feedback <= 0;
		end
		else if(old_address_bit_cntr != address_bit_cntr)
		begin
			if((address_bit_cntr == 9) || (address_bit_cntr == 17)) 
			begin
				sda_reg <= 1;
			end
			else if(address_bit_cntr == 8) we_feedback <= sda;
			else
			begin
				check_addr <= {check_addr[14:1], sda};
			end
		end
	end
	
	assign sda = (((data_bit_cntr == 0) && (address_bit_cntr == 0)) || (address_bit_cntr == 8) || (data_bit_cntr == 8))? sda_reg : 1'bz;
	
	reg isEqual;
	always @(posedge clk)
	begin
		if(rst) isEqual <= 0;
		else if((address_bit_cntr == 16) && (check_addr[9:0] == control_adr[31:22])) isEqual <= 1;
	end
	
	reg [4:0] data_bit_cntr;
	reg [4:0] old_data_bit_cntr;
	always @(posedge clk)
	begin	
		if(rst || (data_bit_cntr == 8)) data_bit_cntr <= 0;
		else if(address_bit_cntr == 17) data_bit_cntr <= data_bit_cntr + 1;
		else old_data_bit_cntr <= data_bit_cntr;
	end
	
	always @(posedge clk)
	begin 
		if(rst) ack_feedback <= 0;
		else if(isEqual && we_feedback && (data_bit_cntr != old_data_bit_cntr))
			if (data_bit_cntr == 8) 
				begin
					ack_feedback <= sda;
				end
			else  data = {data[30:1],0};
	end
	
	assign sda = data[31];
      
endmodule

