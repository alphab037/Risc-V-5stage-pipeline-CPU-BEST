`timescale 1ns / 1ps

module mux3to1(
input a, b, c,
input [31:0] x1,x2,x3,
output reg [31:0] r
    );
always@(*)
    if (a | b)
         r = x1;
     else if(c)
        r = x2;
     else
        r = x3;

endmodule
