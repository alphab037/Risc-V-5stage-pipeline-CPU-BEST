`timescale 1ns / 1ps

module EX_MEM(
    input clk,reset,enable,clear,
    input [31:0] PCE, ALU_outputE, rs2_dataE,
    input [4:0] rdE,
    output reg [4:0] rdM,
    output reg [31:0] PCM,ALU_outputM, rs2_dataM
    );

always @( posedge clk, posedge reset ) begin
    if (reset) begin 
        PCM <= 0;
        rdM <= 0;
        ALU_outputM <= 0;
        rs2_dataM <= 0;
    end
    else if (enable) begin 
        if (clear) begin 
            PCM <= 0;
            rdM <= 0;
            ALU_outputM <= 0;
            rs2_dataM <= 0;
        end
        else begin	 
            PCM <= PCE;
            rdM <= rdE;
            ALU_outputM <= ALU_outputE;
            rs2_dataM <= rs2_dataE;
        end
    end
end

endmodule
