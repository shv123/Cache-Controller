`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:51 09/26/2020 
// Design Name: 
// Module Name:    main 
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
module main(
    input clk,
    input rst_n
    //input [31:0] addr,
    //output rvalid,
	 //output [31 : 0] data
    );

wire [31 : 0] addr_mm;
wire [63 : 0] data_mm;
wire rvalid_mm;
wire arvalid;

wire rvalid;
wire [31 : 0] addr;
wire [31 : 0] data;

cache_module i1(.clk(clk), .rst_n(rst_n), .addr(addr), .addr_mm(addr_mm), .data(data), .data_mm(data_mm), .rvalid_mm(rvalid_mm), .rvalid(rvalid), .arvalid(arvalid));
main_mem_module i2(.clk(clk), .rst_n(rst_n), .arvalid(arvalid), .addr(addr), .data(data_mm), .rvalid(rvalid_mm));
processor i3(.clk(clk), .rst_n(rst_n), .rvalid(rvalid), .addr(addr), .data(data));

endmodule
