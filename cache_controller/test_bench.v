`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:19 09/26/2020
// Design Name:   main
// Module Name:   /home/ise/ise_projects/cache_controller/test_bench.v
// Project Name:  cache_controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench;

	// Inputs
	reg clk;
	reg rst_n;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.rst_n(rst_n)
	);

	/*initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end*/
	
	initial begin
		clk = 0;
	end
	
	always
	#5 clk = !clk;
	
	initial begin
		rst_n = 0;
		#15
		rst_n = 1;
	end
      
endmodule

