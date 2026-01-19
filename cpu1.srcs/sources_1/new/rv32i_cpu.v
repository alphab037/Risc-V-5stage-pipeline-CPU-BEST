module rv32i_cpu(
input CLK,
input reset,stall,
input a,b,c,
input [31:0] in,
output reg [31:0] PC);

always @(posedge CLK, posedge reset)
begin
    if (reset) PC<=32'h0;
   else if ((a === 1'b1) || (b === 1'b1) || (c === 1'b1))
    PC <= in;
    else  if(~stall) PC <= PC+4;
    end
endmodule