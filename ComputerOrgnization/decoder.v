module Decoder(
    input clk, rst,
    input regWrite,
    input [31:0] inst,
    input [31:0] writeData,
    output [31:0] rs1Data, rs2Data,
    output reg [31:0] imm32 
);
reg [31:0] registers[31:0];
reg [11:0] imm_12;
reg [19:0] imm_20;
reg [6:0] opcode;
//bug at 0000011
always @(*) begin
    opcode = inst[6:0];
    case(opcode) 
    7'b0010011:begin//I-type *
        imm_12 = inst[31:20];
        imm32 = {{20{imm_12[11]}}, imm_12};
    end
    7'b0110011: begin//R-type
        imm32 = 32'b0;
    end
    7'b0100011: begin//S-type *
        imm_12[4:0] = inst[11:7];
        imm_12[11:5] = inst[31:25];
        imm32 = {{20{imm_12[11]}}, imm_12};
    end
    7'b1100011: begin//B-type *
        imm_12[11] = inst[31];
        imm_12[9:4] = inst[30:25];
        imm_12[3:0] = inst[11:8];
        imm_12[10] = inst[7];
        imm32 = {{20{imm_12[11]}}, imm_12};
        imm32 = imm32 << 1;
    end
    7'b0011011: begin//U-type
        imm_20 = inst[31:12];
        imm32 = {imm_20,12'b0};
    end
    7'b1101111: begin//J-type
        imm_20[19] = inst[31];
        imm_20[9:0] = inst[30:21];
        imm_20[10] = inst[20];
        imm_20[18:11] = inst[19:12];
        imm32 = {{12{imm_20[19]}}, imm_20};
        imm32 = imm32 << 1;
    end
    7'b0000011: begin//I-type *
        imm_12 = inst[31:20];
        imm32 = {{20{imm_12[11]}}, imm_12};
    end
    default: imm32 = 32'b0;
    endcase
end

wire[4:0] rd = inst[11:7];
assign rs1Data = (inst[19:15] == 5'd0) ? 32'd0 : registers[inst[19:15]];
assign rs2Data = (inst[24:20] == 5'd0) ? 32'd0 : registers[inst[24:20]];

always @(posedge clk) begin
    if (!rst) begin
        registers[0] <= 32'd0;
        registers[1] <= 32'd0;
        registers[2] <= 32'd0;
        registers[3] <= 32'd0;
        registers[4] <= 32'd0;
        registers[5] <= 32'd0;
        registers[6] <= 32'd0;
        registers[7] <= 32'd0;
        registers[8] <= 32'd0;
        registers[9] <= 32'd0;
        registers[10] <= 32'd0;
        registers[11] <= 32'd0;
        registers[12] <= 32'd0;
        registers[13] <= 32'd0;
        registers[14] <= 32'd0;
        registers[15] <= 32'd0;
        registers[16] <= 32'd0;
        registers[17] <= 32'd0;
        registers[18] <= 32'd0;
        registers[19] <= 32'd0;
        registers[20] <= 32'd0;
        registers[21] <= 32'd0;
        registers[22] <= 32'd0;
        registers[23] <= 32'd0;
        registers[24] <= 32'd0;
        registers[25] <= 32'd0;
        registers[26] <= 32'd0;
        registers[27] <= 32'd0;
        registers[28] <= 32'd0;
        registers[29] <= 32'd0;
        registers[30] <= 32'd0;
        registers[31] <= 32'd0;
    end          
    else if (regWrite && (rd != 5'd0)) begin
        registers[rd] <= writeData;
    end
end
endmodule