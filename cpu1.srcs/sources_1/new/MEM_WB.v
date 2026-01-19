`timescale 1ns / 1ps

module MEM_WB(
    input clk, reset, enable, clear,
    input [31:0] PCM, ALU_outputM, rDataM, rdM,
    output reg [31:0] PCW,ALU_outputW, rDataW, rdW
    );

always @(posedge clk, posedge reset) begin
    if (reset) begin
        PCW <= 0;
        ALU_outputW <= 0;
        rDataW <= 0;
        rdW <= 0;
    end
    else if (enable) begin
        if (clear) begin
            PCW <= 0;
            ALU_outputW <= 0;
            rDataW <= 0;
            rdW <= 0;
        end
        else begin
            PCW <= PCM;
            ALU_outputW <= ALU_outputM;
            rDataW <= rDataM;
            rdW <= rdM;
        end
    end
end

endmodule
