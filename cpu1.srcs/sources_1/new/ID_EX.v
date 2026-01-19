`timescale 1ns / 1ps

module ID_EX(
    input clk,reset,enable,clear,
    input [31:0] PCD, rdD,rs1_dataD,rs2_dataD, imm_extD,
    input [4:0] rs1,rs2,
    output reg [4:0] rs1E, rs2E,
    output reg [31:0] PCE, rdE,rs1_dataE,rs2_dataE, imm_extE
    );

always @( posedge clk, posedge reset ) begin
    if (reset) begin 
        PCE <= 0;
        rdE <= 0;
        rs1_dataE <=0;
        rs2_dataE <=0;
        imm_extE <= 0;
         rs1E<= 0;
         rs2E <=0;
    end

    else if (enable) begin 
		 if (clear) begin 
            PCE <= 0;
            rdE <= 0;
            rs1_dataE <=0;
            rs2_dataE <=0;
            imm_extE <= 0;
            rs1E<= 0;
            rs2E <=0;
		 end
		 
		 else begin	 
            PCE <= PCD;
            rdE <= rdD;
            rs1_dataE <= rs1_dataD;
            rs2_dataE <= rs2_dataD;
            imm_extE <= imm_extD;
            rs1E <= rs1;
            rs2E <= rs2;
		 end
	 end
end

endmodule

