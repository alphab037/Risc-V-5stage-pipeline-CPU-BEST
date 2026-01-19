module memoryI (
    input [31:0] Addr,
    output [31:0] rData
);
reg   [7:0] memory[0:1023];


initial begin
    $readmemh("C:/Users/USER/Desktop/vivadoprojects/cpu1/instr.mem", memory); 
end

assign rData = {memory[Addr[9:0]+3],memory[Addr[9:0]+2],memory[Addr[9:0]+1],memory[Addr[9:0]]};
endmodule
