`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/13 18:45:39
// Design Name: 
// Module Name: Registers
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


module Registers(
    input [4:0]Readregister1,
    input [4:0]Readregister2,
    input [4:0]Writeregister,
    input [31:0]Writedata,
    input RegWrite,
    output reg [31:0]Readdata1,
    output reg [31:0]Readdata2
);

reg [31:0] registers[31:0];

always @* begin
    if (RegWrite) begin
        registers[Writeregister] = Writedata;
    end
    Readdata1 = registers[Readregister1];
    Readdata2 = registers[Readregister2];
end

endmodule
