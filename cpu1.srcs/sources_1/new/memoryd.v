module memoryd (
    input [31:0] Addr,
    input memwrite,
    input [2:0] funct3,
    input clk,
    input[31:0] wData,
    output reg [31:0] rData
);
reg   [7:0] memory[0:1023];
integer i;
initial begin
        for(i=0; i<1024;i=i+1) begin
            memory[i] = 8'b0; 
        end
end

wire [1:0] memsize = funct3[1:0];

always @(posedge clk) begin
    if(memwrite) begin
        case(memsize)
            2'b00:
            memory[Addr[9:0]] <= wData[7:0];
            2'b01: begin
            memory[Addr[9:0]] <= wData[7:0];
            memory[Addr[9:0]+1] <= wData[15:8];
            end
            2'b10: begin 
            memory[Addr[9:0]] <= wData[7:0];
            memory[Addr[9:0]+1] <= wData[15:8];
            memory[Addr[9:0]+2] <= wData[23:16];
            memory[Addr[9:0]+3] <= wData[31:24];
            end
            default: begin
            memory[Addr[9:0]] <= wData[7:0];
            memory[Addr[9:0]+1] <= wData[15:8];
            memory[Addr[9:0]+2] <= wData[23:16];
            memory[Addr[9:0]+3] <= wData[31:24];
            end
        endcase
    end
end
always @(*) begin
    case(funct3)
        3'b000:
            rData = {{24{memory[Addr][7]}}, memory[Addr[9:0]]};
        3'b001: begin
            rData = {{16{memory[Addr[9:0]+1][7]}}, memory[Addr[9:0]+1], memory[Addr[9:0]]};
        end
        3'b010: begin 
            rData = {memory[Addr[9:0]+3],memory[Addr[9:0]+2],memory[Addr[9:0]+1],memory[Addr[9:0]]};
        end
        3'b100:begin
            rData = {{24{memory[Addr[9:0]][7]}}, memory[Addr[9:0]]};
        end
        3'b101: begin
            rData = {{16{memory[Addr[9:0]+1][7]}}, memory[Addr[9:0]+1],memory[Addr[9:0]]};
        end
        default: begin
            rData = 32'b0;
        end
    endcase
end


endmodule
