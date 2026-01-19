`timescale 1ns / 1ps

module C_MEM_WB(
    input clk, reset, enable, clear,
    input memwtoregM, regwriteM,
    input [1:0] jM,
    output reg memwtoregW, regwriteW,
    output reg [1:0] jW
    );

always @(posedge clk, posedge reset) begin
    if (reset) begin
        memwtoregW <= 0;
        regwriteW <= 0;
        jW <= 0;
    end
    else if (enable) begin
        if (clear) begin
            memwtoregW <= 0;
            regwriteW <= 0;
            jW <= 0;
        end
        else begin
            memwtoregW <= memwtoregM;
            regwriteW <= regwriteM;
            jW <= jM;
        end
    end
end

endmodule
