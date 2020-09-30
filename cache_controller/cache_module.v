`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:52:54 09/26/2020 
// Design Name: 
// Module Name:    cache_module 
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
module cache_module(
    input clk,
    input rst_n,
    //input [31:0] addr,
	 input [0 : 31] addr,
    //output [31:0] addr_mm,
	 output [0 : 31] addr_mm,
    output reg [31:0] data,
    input [63:0] data_mm,
    input rvalid_mm,
    output reg rvalid,
    output arvalid
    );

//reg [7 : 0] cache [92 : 0];
reg [0 : 92] cache [0 : 7];

wire select;
wire [1 : 0] index;
wire [26 : 0] tag;

assign select = addr[29];
//assign select = addr[2]; //addr -> [31, 30, ..., 1, 0]
assign index = addr[27 : 28];
//assign index = addr[4 : 3];
assign tag = addr[0 : 26];
//assign tag = addr[31 : 5];

reg arvalid_reg;
assign arvalid = arvalid_reg;

assign addr_mm = addr;


//arvalid
always@(negedge clk)
begin
	if(rst_n == 0)
	begin
		arvalid_reg <= 0;
	end
	
	else if((arvalid_reg == 0) && ( (((cache[2 * index][0] == 0) | (cache[2 * index][1 : 27] != tag)) == 1'b1) && (((cache[(2 * index) + 1][0] == 0) | (cache[(2 * index) + 1][1 : 27] != tag)) == 1'b1) ))
	//else if((arvalid_reg == 0) && ( (((cache[2 * index][92] == 0) | (cache[2 * index][91 : 65] != tag)) == 1'b1) && (((cache[(2 * index) + 1][92] == 0) | (cache[(2 * index) + 1][91 : 65] != tag)) == 1'b1) ))
	begin
		arvalid_reg <= 1;
	end
	
	else if(arvalid_reg == 1 && rvalid == 1)
	begin
		arvalid_reg <= 0;
	end
end

//data
always@(negedge clk)
begin

	if(rst_n == 0)
	begin
		data <= 0;
	end
	
	else if((cache[2 * index][0] == 1 && cache[2 * index][1 : 27] == tag) || (cache[(2 * index) + 1][0] == 1 && cache[(2 * index) + 1][1 : 27] == tag))
	//else if((cache[2 * index][92] == 1 && cache[2 * index][91 : 65] == tag) || (cache[(2 * index) + 1][92] == 1 && cache[(2 * index) + 1][91 : 65] == tag))
	begin
		if(cache[2 * index][0] == 1 && cache[2 * index][1 : 27] == tag)
		//if(cache[2 * index][92] == 1 && cache[2 * index][91 : 65] == tag)
		begin
			//data <= cache[2 * index][28 + (32 * select) : 28 + (32 * select) + 31];
			data <= cache[2 * index][28 + (32 * select) +: 32];
			//data <= cache[2 * index][64 - (32 * select) -: 32];
			cache[2 * index][92] <= 0;
			//cache[2 * index][0] <= 0;
			cache[(2 * index) + 1][92] <= 1;
			//cache[(2 * index) + 1][0] <= 1;
		end
			
		else
		begin
			//data <= cache[(2 * index) + 1][28 + (32 * select) : 28 + (32 * select) + 31];
			data <= cache[(2 * index) + 1][28 + (32 * select) +: 32];
			//data <= cache[(2 * index) + 1][64 - (32 * select) -: 32];
			cache[(2 * index) + 1][92] <= 0;
			//cache[2 * index][0] <= 0;
			cache[2 * index][92] <= 1;
			//cache[(2 * index) + 1][0] <= 1;
		end
	end
	
end

//rvalid
always@(negedge clk)
begin
	if(rst_n == 0)
	begin
		rvalid <= 0;
	end
	
	else if((cache[2 * index][0] == 1 && cache[2 * index][1 : 27] == tag) || (cache[(2 * index) + 1][0] == 1 && cache[(2 * index) + 1][1 : 27] == tag))
	//else if((cache[2 * index][92] == 1 && cache[2 * index][91 : 65] == tag) || (cache[(2 * index) + 1][92] == 1 && cache[(2 * index) + 1][91 : 65] == tag))
	begin
		rvalid <= 1;
	end
	
	else if(rvalid == 1)
	begin
		rvalid <= 0;
	end
end

//cache
always@(negedge clk)
begin
	if(rst_n == 0) //invalidate cache
	begin
		cache[0][0] = 0;
		cache[1][0] = 0;
		cache[2][0] = 0;
		cache[3][0] = 0;
		cache[4][0] = 0;
		cache[5][0] = 0;
		cache[6][0] = 0;
		cache[7][0] = 0;
		/*cache[0][92] = 0;
		cache[1][92] = 0;
		cache[2][92] = 0;
		cache[3][92] = 0;
		cache[4][92] = 0;
		cache[5][92] = 0;
		cache[6][92] = 0;
		cache[7][92] = 0;*/
	end
	
	else if(rvalid_mm == 1)
	begin
		if(cache[2 * index][0] == 0)
		//if(cache[2 * index][92] == 0)
		begin
			cache[2 * index][1 : 27] <= tag;
			//cache[2 * index][91 : 65] <= tag;
			cache[2 * index][28 : 91] <= data_mm;
			//cache[2 * index][64 : 1] <= data;
			cache[2 * index][92] <= 0;
			//cache[2 * index][0] <= 0;
			cache[(2 * index) + 1][92] <= 1; //mostly redundant
			//cache[(2 * index) + 1][92] <= 1;
			cache[2 * index][0] <= 1;//VALID
		end
		
		else if(cache[(2 * index) + 1][0] == 0)
		//else if(cache[(2 * index) + 1][92] == 0)
		begin
			cache[(2 * index) + 1][1 : 27] <= tag;
			//cache[(2 * index) + 1][91 : 65] <= tag;
			cache[(2 * index) + 1][28 : 91] <= data_mm;
			//cache[(2 * index) + 1][64 : 1] <= data;
			cache[(2 * index) + 1][92] <= 0;
			//cache[(2 * index) + 1][0] <= 0;
			cache[(2 * index)][92] <= 1; //mostly redundant
			//cache[(2 * index)][92] <= 1;
			cache[(2 * index) + 1][0] <= 1; //VALID
		end
		
		else if(cache[2 * index][92] >= cache[(2 * index) + 1][92]) //REPLACE LRU
		//else if(cache[2 * index][0] <= cache[(2 * index) + 1][0])
		begin
			cache[2 * index][1 : 27] <= tag;
			//cache[2 * index][91 : 65] <= tag;
			cache[2 * index][28 : 91] <= data_mm;
			//cache[2 * index][64 : 1] <= data;
			cache[2 * index][92] <= 0;
			//cache[2 * index][0] <= 0;
			cache[(2 * index) + 1][92] <= 1; //mostly redundant
			//cache[(2 * index) + 1][92] <= 1;
			cache[2 * index][0] <= 1;//VALID
		end
		
		else
		begin
			cache[(2 * index) + 1][1 : 27] <= tag;
			//cache[(2 * index) + 1][91 : 65] <= tag;
			cache[(2 * index) + 1][28 : 91] <= data_mm;
			//cache[(2 * index) + 1][64 : 1] <= data;
			cache[(2 * index) + 1][92] <= 0;
			//cache[(2 * index) + 1][0] <= 0;
			cache[(2 * index)][92] <= 1; //mostly redundant
			//cache[(2 * index)][92] <= 1;
			cache[(2 * index) + 1][0] <= 1; //VALID
		end
	end
end

endmodule
