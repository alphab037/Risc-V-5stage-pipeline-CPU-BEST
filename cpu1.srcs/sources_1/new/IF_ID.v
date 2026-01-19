`timescale 1ns / 1ps
module IF_ID(
    input clk, reset, clear, enable,
    input [31:0] PCF, instrF,
    output reg [31:0] PCD, instrD);
    
always @( posedge clk, posedge reset ) begin
    if (reset) begin 
        instrD <= 0;
        PCD <= 0;
    end
     else if (clear) begin 
			  instrD <= 0;
			  PCD <= 0;
     end
		 
	else if(enable) begin	 
			  instrD <= instrF;
			  PCD <= PCF;
	end
	end
endmodule
