
module interlock(
input [4:0] rs1_id,
input [4:0] rs2_id,
input [4:0] rd_exe,
input MemRead_exe,
output reg stall
    );

always @(*)
begin 
    if( MemRead_exe &&( (rd_exe[4:0] == rs1_id[4:0]) || (rd_exe[4:0] == rs2_id[4:0])))
    stall = 1'b1;
    else 
    stall = 1'b0;
    end
    
endmodule
