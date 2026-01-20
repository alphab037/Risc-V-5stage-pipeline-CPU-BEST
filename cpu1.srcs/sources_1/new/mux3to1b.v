`timescale 1ns / 1ps

module mux3to1b(
input a,b,c,
input [31:0] x1,
output reg [31:0] r
    );
always@(*)
    if (a || b || c)
         r = {7'b0,x1[24:15],3'b0,x1[11:7],7'b0};
    else
        r = x1;
endmodule

