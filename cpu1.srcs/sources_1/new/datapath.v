module datapath(
    input clk,
    input reset,
    output wire[31:0] rData, PC,instruction, rs1_data, rs2_data, imm_ext,ALU_output,
    output wire [1:0] afwd,bfwd,
    output RegWrite, memtoReg, memWrite, ALUsrc,beq,bne,blt,bge,bltu,bgeu,jal,jalr,btaken,N,Z,C,V,stall,
    output [4:0] ALUcontrol,
    output [31:0] x1, x2,x3, Mux1, Mux2, Mux3
);
wire [31:0] PCD, instrD, instr;
    
wire [31:0] PCE,  rs1_dataE, rs2_dataE, imm_extE;
wire [4:0]  rs1E, rs2E,rdE, alucontE;
wire [2:0]  funct3E;
wire        regwriteE, memwriteE, memtoregE, alusrcE;
wire [5:0]  branchE;
wire [1:0]  jE;
    
wire [31:0] PCM,  rs2_dataM, ALU_outputM, result;
wire[4:0] rdM;
wire [2:0]  funct3M;
wire        regwriteM, memwriteM, memtoregM;
wire [1:0]  jM;
    
wire [31:0] PCW, ALU_outputW, rDataW;
wire [4:0] rdW;
wire        regwriteW, memtoregW;
wire [1:0]  jW;


// HAZARD UNIT 
    
data_forwarding T1(.rs1_exe(rs1E),.rs2_exe(rs2E),.rd_mem(rdM),.rd_wb(rdW),.afwd(afwd),.bfwd(bfwd));
interlock T2(.rs1_id(instrD[19:15]), .rs2_id(instrD[24:20]), .rd_exe(rdE),.MemRead_exe(memtoregE), .stall(stall));


//Instruction FETCH

    rv32i_cpu u1(.CLK(clk),.reset(reset),.stall(stall),.a(jE[1]),.b(jE[0]),.c(btaken),.in(Mux3),.PC(PC));
memoryI u2(.Addr(PC), .rData(instruction));
mux3to1b m1(.a(btaken),.b(jE[1]),.c(jE[0]),.x1(instruction),.r(instr));
    
IF_ID A1(.clk(clk),.reset(reset),.clear(),.enable(~stall),.PCF(PC),.instrF(instr),.PCD(PCD),.instrD(instrD));

//Instruction DECODE

regfile u3(.clk(clk),.we(regwriteW), .rs1(instrD[19:15]), .rs2(instrD[24:20]), .rd(rdW), .rd_data(Mux2), .rs1_data(rs1_data), .rs2_data(rs2_data), .x1(x1), .x2(x2), .x3(x3));
signex u4(.instr(instrD),.PC(PCD),.imm_ext(imm_ext));
maindec u5(.opcode(instrD[6:0]),.funct3(instrD[14:12]),.stall(stall),.btaken(btaken),.jE1(jE[1]),.jE2(jE[0]), .RegWrite(RegWrite),.memWrite(memWrite),.memtoReg(memtoReg),.ALUsrc(ALUsrc),.beq(beq),.bne(bne),.blt(blt),.bge(bge),.bltu(bltu),.bgeu(bgeu),.jal(jal),.jalr(jalr));
aludec u6(.opcode(instrD[6:0]),.funct7(instrD[31:25]),.funct3(instrD[14:12]),.ALUcontrol(ALUcontrol));

ID_EX A2(.clk(clk),.reset(reset),.enable(1),.clear(),.PCD(PCD),.rs1(instrD[19:15]),.rs2(instrD[24:20]), .rdD(instrD[11:7]),.rs1_dataD(rs1_data),.rs2_dataD(rs2_data), .imm_extD(imm_ext),
.PCE(PCE),.rs1E(rs1E),.rs2E(rs2E), .rdE(rdE),.rs1_dataE(rs1_dataE),.rs2_dataE(rs2_dataE), .imm_extE(imm_extE));
C_ID_EX B1(.clk(clk),.reset(reset),.enable(1),.clear(),.regwriteD(RegWrite), .memwriteD(memWrite),.memtoregD(memtoReg),.ALUsrcD(ALUsrc),.ALUcontD(ALUcontrol),.branchD({beq,bne,blt,bge,bltu,bgeu}),.jD({jal,jalr}),.funct3D(instrD[14:12]),
           .regwriteE(regwriteE),.memwriteE(memwriteE),.memtoregE(memtoregE),.ALUsrcE(alusrcE),.ALUcontE(alucontE),.branchE(branchE),.jE(jE),.funct3E(funct3E));

//Execution 
    
alu u7(.a(result),.b(Mux1),.alucont(alucontE),.result(ALU_output),.N(N),.Z(Z),.C(C),.V(V));
branchdec u8(.beq(branchE[5]),.bne(branchE[4]),.blt(branchE[3]),.bge(branchE[2]),.bltu(branchE[1]),.bgeu(branchE[0]),.N(N),.C(C),.Z(Z),.V(V),.btaken(btaken));
mux3to1a m2(.a(afwd),.x1(ALU_outputM),.x2(Mux2),.x3(rs1_dataE),.r(result));
mux4to1 m3(.a(alusrcE),.b(bfwd),.x1(imm_extE),.x2(rs2_dataE),.x3(ALU_outputM),.x4(Mux2),.r(Mux1));
mux3to1 m4(.a(btaken),.b(jE[1]),.c(jE[0]),.x1(imm_extE+PCE),.x2(imm_extE+rs1_dataE),.x3(PCE),.r(Mux3));

EX_MEM A3(.clk(clk),.reset(reset),.enable(1),.clear(),.PCE(PCE),.rdE(rdE),.ALU_outputE(ALU_output),.rs2_dataE(rs2_dataE),
          .PCM(PCM),.rdM(rdM),.ALU_outputM(ALU_outputM),.rs2_dataM(rs2_dataM));
C_EX_MEM B2(.clk(clk),.reset(reset),.enable(1),.clear(),.regwriteE(regwriteE), .memwriteE(memwriteE),.memtoregE(memtoregE),.jE(jE),.funct3E(funct3E),
           .regwriteM(regwriteM),.memwriteM(memwriteM),.memtoregM(memtoregM),.jM(jM),.funct3M(funct3M));

//Memory Access

    memoryd u9(.Addr(ALU_outputM),.memwrite(memwriteM),.funct3(funct3M),.clk(clk),.wData(rs2_dataM),.rData(rData));
MEM_WB A4(.clk(clk),.reset(reset),.enable(1),.clear(),.PCM(PCM),.ALU_outputM(ALU_outputM),.rDataM(rData),.rdM(rdM),
         .PCW(PCW), .ALU_outputW(ALU_outputW),.rDataW(rDataW),.rdW(rdW));

C_MEM_WB B4(.clk(clk),.reset(reset),.enable(1),.clear(),.memwtoregM(memtoregM),.regwriteM(regwriteM),.jM(jM),
           .memwtoregW(memtoregW),.regwriteW(regwriteW),.jW(jW));

//WriteBack
mux3to1 m5(.a(jW[1]),.b(jW[0]),.c(memtoregW),.x1(PCW+4),.x2(rDataW),.x3(ALU_outputW),.r(Mux2));



endmodule


