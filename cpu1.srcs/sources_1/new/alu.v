module alu(
    input [31:0] a,b,
    input [4:0] alucont,
    output reg[31:0] result,
    output N,Z,C,V);

wire [31:0] b2,sum;
wire slt, sltu;


assign b2 = alucont[4] ? ~b:b;

likeadder uut(.a(a), .b(b2), .cin(alucont[4]), .sum(sum),
                     .N(N), .Z(Z), .C(C), .V(V)); 

assign slt = N ^ V;
assign sltu = ~ C;

always@(*)
    case(alucont[3:0])
        4'b0000: result <=sum;
        4'b0001: result <=a&b;
        4'b0010: result <=a|b;
        4'b0011: result <=a^b;
        4'b0100: result <=a<< b[4:0];
        4'b0101: result <=a>> b[4:0];
        4'b0110: result <=a>>>b[4:0];
        4'b0111: result <={31'b0, sltu};
        4'b1000: result <={31'b0, slt};
        default: result <=32'b0;
    endcase
endmodule