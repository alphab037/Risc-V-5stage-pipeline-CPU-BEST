module regfile(
    input clk,
    input we,
    input [4:0] rs1, rs2,
    input [4:0] rd,
    input [31:0] rd_data,
    output [31:0] rs1_data, rs2_data,
    output [31:0] x1,x2,x3);

reg [31:0] legi [0:31];

integer i;
initial begin
        for(i=0; i<32;i=i+1) begin
            legi[i] = 32'b0; 
        end
end

always @(posedge clk)begin 
    if(we)
    legi[rd] <= rd_data;
end

assign rs1_data = (rs1 == 5'b0) ? 32'b0 : legi[rs1];
assign rs2_data = (rs2 == 5'b0) ? 32'b0 : legi[rs2];

assign x1 = legi[1];
assign x2 = legi[2];
assign x3 = legi[3];
endmodule
