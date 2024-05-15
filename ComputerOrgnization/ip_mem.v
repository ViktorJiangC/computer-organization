`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 14:52:35
// Design Name: 
// Module Name: ip_mem
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


module ip_mem(
    input clk,
    input [13:0] addr,
    output [31:0] dout
    );
    prgrom urom(.clka(clk), .addra(addr), .douta(dout));
//useless fucking ipmem
endmodule
