module mux2to1(
    input [31:0] a,b,
    input s1,
    output wire [31:0] o
);

assign o = (s1==1)? b:a;
endmodule