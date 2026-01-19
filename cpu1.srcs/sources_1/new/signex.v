module signex(
    input[31:0] instr,PC,
    output reg [31:0] imm_ext
);
wire [6:0] opcode;
assign opcode = instr[6:0] ;
always @(*) begin
    case (opcode)
        7'b0010011, // I-type ALU
        7'b0000011, // Load
        7'b1100111: // JALR
            imm_ext <= {{20{instr[31]}}, instr[31:20]};

        7'b0100011: // S-type
            imm_ext <= {{20{instr[31]}}, instr[31:25], instr[11:7]};

        7'b1100011: // B-type
            imm_ext <= {{19{instr[31]}}, instr[31], instr[7],
                   instr[30:25], instr[11:8], 1'b0};

        7'b0110111: // LUI
                    imm_ext <= {instr[31:12], 12'b0};
        7'b0010111: // AUIPC
                    imm_ext <= {instr[31:12], 12'b0}+PC;

        7'b1101111: // JAL
            imm_ext <= {{11{instr[31]}}, instr[31],
                   instr[19:12], instr[20],
                   instr[30:21], 1'b0};

        default:
            imm_ext <= 32'b0;
    endcase
end
endmodule