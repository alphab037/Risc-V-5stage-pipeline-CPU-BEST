`timescale 1ns / 1ps

module data_forwarding(
    input [4:0] rs1_exe,
    input [4:0] rs2_exe,
    input [4:0] rd_mem,
    input [4:0] rd_wb,
    output reg [1:0] afwd,
    output reg [1:0] bfwd
    );

always @(*)
begin 
    if (rd_mem[4:0] == rs1_exe[4:0]) afwd = 2'b01;
    else if(rd_wb[4:0] == rs1_exe[4:0]) afwd = 2'b10;
    else afwd = 2'b00;
end
always @(*)
begin 
    if (rd_mem[4:0] == rs2_exe[4:0]) bfwd = 2'b01;
    else if(rd_wb[4:0] == rs2_exe[4:0]) bfwd = 2'b10;
    else bfwd = 2'b00;
end
endmodule
