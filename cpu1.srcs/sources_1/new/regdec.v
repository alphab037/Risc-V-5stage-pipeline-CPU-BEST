module maindec(
input [6:0] opcode, [2:0] funct3, 
input stall,btaken,jE1,jE2,
output reg RegWrite,memWrite,memtoReg,ALUsrc,beq,bne,blt,bge,bltu,bgeu,jal,jalr
);


always @(*) begin
if(stall || btaken || jE1 || jE2) begin 
     memWrite<= 1'b0;
            memtoReg<= 1'b0;
            ALUsrc<=  1'b0;
            RegWrite<=1'b0; 
            beq <= 1'b0;
            bne <= 1'b0;
            blt <= 1'b0;
            bge <= 1'b0;
            bltu <= 1'b0;
            bgeu <= 1'b0;
            jal <= 1'b0;
            jalr <= 1'b0;
end
else begin 
    case(opcode)
        7'b011_0011: begin 
            memWrite<= 1'b0;
            memtoReg<= 1'b0;
            ALUsrc<=  1'b0;
            RegWrite<=1'b1; 
            beq <= 1'b0;
            bne <= 1'b0;
            blt <= 1'b0;
            bge <= 1'b0;
            bltu <= 1'b0;
            bgeu <= 1'b0;
            jal <= 1'b0;
            jalr <= 1'b0;
            //R-type
        end
        7'b001_0011: begin
            memWrite<= 1'b0;
            memtoReg<= 1'b0;
            ALUsrc<=  1'b1;
            RegWrite<=1'b1;
            beq <= 1'b0;
            bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
            jal <= 1'b0;
            jalr <= 1'b0;
        end //I-type Arithmetic
        7'b000_0011:begin 
            memWrite<= 1'b0;
            memtoReg<= 1'b1;
            ALUsrc<=  1'b1;
            RegWrite<=1'b1;
            beq <= 1'b0;
            bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
            jal <= 1'b0;
            jalr <= 1'b0;
             //I-type Logic
        end
        7'b110_0111: begin
            memWrite<= 1'b0;
            memtoReg<= 1'b0;
            ALUsrc<=  1'b1;
            RegWrite<=1'b1;
            beq <= 1'b0;
            bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
            jal <= 1'b0;
            jalr <= 1'b1;
        end//I-Jalr
        7'b010_0011: begin
            memWrite<= 1'b1;
            memtoReg<= 1'b0;
            ALUsrc<=  1'b1;
            RegWrite<=1'b0;
            beq <= 1'b0;
            bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
            jal <= 1'b0;
            jalr <= 1'b0; 
        end//S-type Store        
        7'b110_0011: begin
        memWrite<= 1'b0;
        memtoReg<= 1'b0;
        ALUsrc<=  1'b0;
        RegWrite<=1'b0;
        jal <= 1'b0;
        jalr <= 1'b0;
        case(funct3)
            3'b000: begin
            beq <=1'b1;
            bne <= 1'b0;
            blt <= 1'b0;
            bge <= 1'b0;
            bltu <= 1'b0;
            bgeu <= 1'b0;
            end
            3'b001:begin 
             beq <=1'b0;
            bne <= 1'b1;
            blt <= 1'b0;
            bge <= 1'b0;
            bltu <= 1'b0;
            bgeu <= 1'b0;
            end
            3'b100:begin
             beq <=1'b0;
            bne <= 1'b0;
            blt <= 1'b1;
            bge <= 1'b0;
            bltu <= 1'b0;
            bgeu <= 1'b0;
            end
            3'b101:begin
             beq <=1'b0;
            bne <= 1'b0;
            blt <= 1'b0;
            bge <= 1'b1;
            bltu <= 1'b0;
            bgeu <= 1'b0;
            end
            3'b110:begin
             beq <=1'b0;
            bne <= 1'b0;
            blt <= 1'b0;
            bge <= 1'b0;
            bltu <= 1'b1;
            bgeu <= 1'b0;
            end
            3'b111:begin
            beq <=1'b0;
            bne <= 1'b0;
            blt <= 1'b0;
            bge <= 1'b0;
            bltu <= 1'b0;
            bgeu <= 1'b1;
            end
            default: begin
            beq <=1'b0;
            bne <= 1'b0;
            blt <= 1'b0;
            bge <= 1'b0;
            bltu <= 1'b0;
            bgeu <= 1'b0;
            end
        endcase   
            
        end
         //B-type Branch
        7'b011_0111: begin 
        memWrite<= 1'b0;
        memtoReg<= 1'b0;
        ALUsrc<=  1'b1;
        RegWrite<=1'b1;
        beq <= 1'b0;
        bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
        jal <= 1'b0;
        jalr <= 1'b0;
        end //LUI


        7'b001_0111: begin 
        memWrite<= 1'b0;
        memtoReg<= 1'b0;
        ALUsrc<=  1'b1;
        RegWrite<=1'b1;
        beq <= 1'b0;
        bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
        jal <= 1'b0;
        jalr <= 1'b0;
        end //AUIPC
        
        7'b110_1111: begin 
        memWrite<= 1'b0;
        memtoReg<= 1'b0;
        ALUsrc<=  1'b0;
        RegWrite<=1'b1;
        beq <= 1'b0;
        bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
        jal <= 1'b1;
        jalr <= 1'b0;
        end //JAL
        
        default: begin
        memWrite<= 1'b0;
        memtoReg<= 1'b0;
        ALUsrc<= 1'b0;
        RegWrite <=1'b0;
        beq <= 1'b0;
        bne <= 1'b0;
        blt <= 1'b0;
        bge <= 1'b0;
        bltu <= 1'b0;
        bgeu <= 1'b0;
        jal <= 1'b0;
        jalr <= 1'b0;
        end
     endcase
end
end
endmodule