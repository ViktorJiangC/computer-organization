`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/14 16:30:05
// Design Name: 
// Module Name: IFetch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module IFetch(
    input clk,
    input rst,//low active
    input zero,
    input branch,
    input [31:0] imm32,
    output [31:0] inst
    );
reg [31:0]PC = 32'b0;
always@(negedge clk)begin
    if(!rst)begin
        PC<=0;
    end
    else begin
        if(branch&zero)begin
            PC<=PC+imm32;
        end
        else begin
            PC<=PC+4;
        end
    end
end

prgrom urom(.clka(clk),.addra(PC[15:2]),.douta(inst));
    
endmodule