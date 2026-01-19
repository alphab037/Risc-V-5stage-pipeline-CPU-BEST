module mux4to1(
    input a,
    input [1:0] b,
    input [31:0] x1,x2,x3,x4,
    output reg [31:0] r
);

always @(*)
begin 
if(a) r = x1; 
else  begin
    case(b)    
    2'b00: r= x2;
    2'b01: r = x3;
    2'b10: r= x4;
    default:
    r = 0;
    endcase
end    
end
endmodule
