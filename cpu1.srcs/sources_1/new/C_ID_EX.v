`timescale 1ns / 1ps

module C_ID_EX(
    input clk,reset,enable,clear,
    input regwriteD, memwriteD, memtoregD,ALUsrcD,
    input [4:0] ALUcontD,
    input [5:0] branchD,
    input [1:0] jD,
    input  [2:0] funct3D,
output reg [2:0] funct3E,
    output reg regwriteE, memwriteE, memtoregE,ALUsrcE,
    output reg [4:0] ALUcontE,
    output reg [5:0] branchE,
    output reg [1:0] jE
    );

always @(posedge clk or posedge reset) begin
    if (reset) begin 
        regwriteE <= 0;
        memwriteE <= 0;
        memtoregE <= 0;
        ALUsrcE   <= 0;
        ALUcontE <= 0;
        branchE  <= 0;
        jE       <= 0;
        funct3E  <= 0;
    end
    else if (enable) begin 
        if (clear) begin 
            regwriteE <= 0;
            memwriteE <= 0;
            memtoregE <= 0;
            ALUsrcE   <= 0;
            ALUcontE <= 0;
            branchE  <= 0;
            jE       <= 0;
            funct3E  <= 0;
        end
        else begin	 
            regwriteE <= regwriteD;
            memwriteE <= memwriteD;
            memtoregE <= memtoregD;
            ALUsrcE   <= ALUsrcD;
            ALUcontE <= ALUcontD;
            branchE  <= branchD;
            jE       <= jD;
            funct3E  <= funct3D;
        end
    end
end
endmodule
