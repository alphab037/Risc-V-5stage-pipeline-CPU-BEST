`timescale 1ns / 1ps

module C_EX_MEM(
    input clk, reset, enable, clear,
    input memwriteE, regwriteE, memtoregE,
    input [1:0] jE,
    input  [2:0] funct3E,
    output reg memwriteM, regwriteM, memtoregM,
    output reg [1:0] jM,
    output reg [2:0] funct3M
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        memwriteM <= 0;
        regwriteM <= 0;
        memtoregM <= 0;
        jM        <= 0;
        funct3M   <= 0;
    end
    else if (enable) begin
        if (clear) begin
            memwriteM <= 0;
            regwriteM <= 0;
            memtoregM <= 0;
            jM        <= 0;
            funct3M   <= 0;
        end
        else begin
            memwriteM <= memwriteE;
            regwriteM <= regwriteE;
            memtoregM <= memtoregE;
            jM        <= jE;
            funct3M   <= funct3E;
        end
    end
end

endmodule
