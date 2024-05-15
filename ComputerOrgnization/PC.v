module PC(
    input clk,
    input rst,
    input [13:0] PC_in,
    output reg [13:0] PC_out
);
reg [13:0] PC_reg;
always @(*) begin
    PC_reg = PC_in;
end
always @(posedge clk) begin
    if(rst) begin
        PC_reg <= 14'b0;
        PC_out <= 14'b0;
    end
    else begin
        PC_out <= PC_reg;
    end
end
endmodule