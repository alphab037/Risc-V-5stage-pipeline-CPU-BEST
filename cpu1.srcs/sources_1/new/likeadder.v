module likeadder( input [31:0] a, b,
                  input cin,
                  output [31:0] sum,
                  output N,Z,C,V);
wire [32:0] c;
assign N = sum[31];
assign Z = (sum == 32'b0);
assign C = c[32];
assign V = c[32] ^ c[31];
genvar i;
assign c[0]=cin;
generate 
    for(i=0; i<32;i=i+1) begin: gen_add
        assign c[i+1]=(a[i]&b[i])|(a[i]&c[i])|(b[i]&c[i]);
        assign sum[i] = a[i] ^b[i]^ c[i];
    end
endgenerate
endmodule    