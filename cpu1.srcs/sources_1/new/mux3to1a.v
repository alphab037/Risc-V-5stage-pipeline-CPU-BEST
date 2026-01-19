`timescale 1ns / 1ps

module mux3to1a(
input [1:0] a,
input [31:0] x1,x2,x3,
output reg [31:0] r
    );
always@(*)
    if (a == 2'b01)
         r = x1;
     else if( a== 2'b10)
        r = x2;
     else
        r = x3;

endmodule

