`define OP_R 7'b0110011
`define OP_I_ARITH 7'b0010011
`define OP_I_LOAD 7'b0000011
`define OP_I_JALR 7'b1100111
`define OP_S 7'b0100011
`define OP_B 7'b1100011
`define OP_U_LUI 7'b0110111
`define OP_U_AUIPC 7'b0010111
`define OP_J_JAL 7'b1101111

module aludec(input [6:0] opcode,
             input [6:0] funct7,
             input[2:0] funct3,
             output reg[4:0] ALUcontrol);
             
always@(*)
    case(opcode)
        `OP_R:
        begin
            case({funct7,funct3})
            10'b0000000_000:ALUcontrol <= 5'b00000;
            10'b0100000_000:ALUcontrol <= 5'b10000;
            10'b0000000_001:ALUcontrol <= 5'b00100;
            10'b0000000_010:ALUcontrol <= 5'b10111;
            10'b0000000_011:ALUcontrol <= 5'b11000;
            10'b0000000_100:ALUcontrol <= 5'b00011;
            10'b0000000_101:ALUcontrol <= 5'b00101;
            10'b1000000_101:ALUcontrol <= 5'b00110;
            10'b0000000_110:ALUcontrol <= 5'b00010;
            10'b0000000_111:ALUcontrol <= 5'b00001;
            default: ALUcontrol <= 5'bxxxxx;
            endcase
         end
         
        `OP_I_ARITH:
        begin
            casez({funct7, funct3})
                10'b???????_000: ALUcontrol<=5'b00000;
                10'b0000000_001: ALUcontrol<=5'b00100;
                10'b???????_010: ALUcontrol<=5'b10111;
                10'b???????_011: ALUcontrol<=5'b11000;
                10'b???????_100: ALUcontrol<=5'b00011;
                10'b0000000_101: ALUcontrol<=5'b00101;
                10'b0100000_101: ALUcontrol<=5'b00110;

            10'b???????_110: ALUcontrol<=5'b00001;
            10'b???????_111: ALUcontrol<=5'bxxxxx;
            default:
            ALUcontrol <= 5'bxxxxx;
            endcase
        end
        `OP_I_LOAD,
        `OP_S,
        `OP_U_LUI,
        `OP_U_AUIPC:
            ALUcontrol<=5'b00000;

        `OP_B:
            ALUcontrol<=5'b10000;
        default:
            ALUcontrol<=5'b00000;
        endcase
endmodule