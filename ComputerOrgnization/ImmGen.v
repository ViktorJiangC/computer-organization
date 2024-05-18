`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/19 14:23:26
// Design Name: 
// Module Name: decode
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


module ImmGen(
    input [31:0] instruction, //riscv instruction
    output reg [31:0] decoded //decoded immediate
);  
reg [11:0] imm_12;
reg [19:0] imm_20;
reg [6:0] opcode;

always @(*) begin
    opcode = instruction[6:0];
    case(opcode) 
    7'b0000011://R-type
        decoded = 32'b0;
    7'b0000111: begin//I-type
        imm_12 = instruction[31:20];
        decoded = imm_12;
    end
    7'b0001111: begin//S-type
        imm_12[4:0] = instruction[11:7];
        imm_12[11:5] = instruction[31:25];
    end
    7'b0001011: begin//B-type
        imm_12[11] = instruction[31];
        imm_12[9:4] = instruction[30:25];
        imm_12[3:0] = instruction[11:8];
        imm_12[10] = instruction[7];
        decoded = imm_12;
        decoded = decoded << 1;
    end
    7'b0011011: begin//U-type
        imm_20 = instruction[31:12];
        decoded = {imm_20,12'b0};
    end
    7'b1101111: begin//J-type
        imm_12[19] = instruction[31];
        imm_12[9:0] = instruction[30:21];
        imm_12[10] = instruction[20];
        imm_12[8:1] = instruction[19:12];
        decoded = imm_12;
        decoded = decoded << 1;
    end
    default: decoded = 32'b0;
    endcase
end

endmodule
