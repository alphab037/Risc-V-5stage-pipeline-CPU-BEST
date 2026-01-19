`timescale 1ns/1ps

module tb_top();
     reg        clk;
    reg        reset;
    wire[31:0] rData, PC,instruction, rs1_data, rs2_data, imm_ext, x1, x2, x3, ALU_output,Mux1,Mux2,Mux3;
    wire [1:0] afwd,bfwd;
    wire RegWrite, memtoReg, memWrite, ALUsrc,beq,bne,blt,bge,bltu,bgeu,jal,jalr,btaken,N,Z,C,V,stall;
    wire [4:0] ALUcontrol;
    integer clock_count = 0;
datapath uut(.clk(clk),.reset(reset), .rData(rData), .PC(PC),.instruction(instruction), .rs1_data(rs1_data), .rs2_data(rs2_data), .imm_ext(imm_ext),
    .RegWrite(RegWrite), .memtoReg(memtoReg), .memWrite(memWrite), .ALU_output(ALU_output), .ALUsrc(ALUsrc),.ALUcontrol(ALUcontrol), .x1(x1), .x2(x2), .x3(x3),.Mux1(Mux1),.Mux2(Mux2),.Mux3(Mux3),
    .beq(beq),.bne(bne),.blt(blt),.bge(bge),.bltu(bltu),.bgeu(bgeu),.jal(jal),.jalr(jalr),.btaken(btaken),.N(N),.Z(Z),.C(C),.V(V),.stall(stall),.afwd(afwd),.bfwd(bfwd));

    always begin
        clk = 0; #10;
        clk = 1; #10;
    end
    
    always @(posedge clk) begin
        clock_count = clock_count + 1;
    end
    
    initial begin
        reset = 1; 
        #15;
        reset = 0; 
        #50;
    end

endmodule
