`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:47:02 09/26/2020 
// Design Name: 
// Module Name:    main_mem_module 
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
module main_mem_module(
    input clk,
    input rst_n,
    input arvalid,
    //input [31:0] addr,
	 input [0 : 31] addr,
    output [63:0] data,
    output rvalid
    );

//reg [127 : 0] main_mem [7 : 0];
reg [0 : 7] main_mem [0 : 127];

reg rvalid_reg;
reg [3 : 0] cnt;
reg busy;

assign rvalid = rvalid_reg;
assign data = (addr % 8 == 0) ? {main_mem[addr][0 : 7], main_mem[addr + 1][0 : 7], main_mem[addr + 2][0 : 7], main_mem[addr + 3][0 : 7], main_mem[addr + 4][0 : 7], main_mem[addr + 5][0 : 7], main_mem[addr + 6][0 : 7], main_mem[addr + 7][0 : 7]} : {main_mem[addr - 4][0 : 7], main_mem[addr - 3][0 : 7], main_mem[addr - 2][0 : 7], main_mem[addr - 1][0 : 7], main_mem[addr][0 : 7], main_mem[addr + 1][0 : 7], main_mem[addr + 2][0 : 7], main_mem[addr + 3][0 : 7]};

//main_mem
always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		$readmemh("MainMem.mem", main_mem);
	end
end

//busy
always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		busy <= 0;
	end
	
	else if(arvalid == 1 && busy == 0)
	begin
		busy <= 1;
		//cnt <= 0;
	end
	
	else if(busy == 1 && cnt == 8)
	begin
		//cnt <= 0;
		busy <= 0;
	end
end

//cnt
always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		cnt <= 0;
	end
	
	else if(busy == 0 && arvalid == 1)
	begin
		cnt <= 0;
	end
	
	else if(busy == 1 && cnt < 8)
	begin
		cnt = cnt + 1;
	end
	
	/*else if(busy == 1 && cnt == 8)
	begin
		cnt <= 0;
	end*/
end

//rvalid_reg
always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		rvalid_reg <= 0;
	end
	
	else if(busy == 1 && cnt == 7 && rvalid_reg == 0)
	begin
		rvalid_reg <= 1;
	end
	
	else if(rvalid_reg == 1)
	begin
		rvalid_reg <= 0;
	end
end

endmodule
