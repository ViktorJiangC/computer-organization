`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/23 14:15:02
// Design Name: 
// Module Name: ALU
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


module ALU(
    input ALUSrc,
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [31:0] imm32,
    output reg zero,
    output reg [31:0]ALUResult
    );

reg [3:0] ALUControl;
wire[31:0] operand2;
assign operand2 = (ALUSrc==1)? imm32 : ReadData2;


always @ *  begin
case(ALUOp)
    2'b00,2'b01: ALUControl = {ALUOp, 2'b10};
    2'b10: begin
          if(funct3 == 3'b000)begin
                if(funct7==7'b0000000)begin
                    ALUControl = 4'b0010;
                end
                if(funct7==7'b0100000)begin
                    ALUControl = 4'b0110;
                end
           end
           else if(funct3 == 3'b111)begin
                ALUControl = 4'b0000;
           end
           else if(funct3 == 3'b110)begin
                ALUControl = 4'b0001;
           end
     end
     default: ALUControl = 4'b0000;
endcase
end

always @ *  begin
case( ALUControl)
        4'b0010:  ALUResult= ReadData1 + operand2;
        4'b0110:  ALUResult= ReadData1 - operand2;
        4'b0000:  ALUResult= ReadData1 & operand2;
        4'b0001:  ALUResult= ReadData1 | operand2;      
endcase
end

always @ *  begin
zero = (ALUResult==0)? 1'b1: 1'b0;
end

endmodule
