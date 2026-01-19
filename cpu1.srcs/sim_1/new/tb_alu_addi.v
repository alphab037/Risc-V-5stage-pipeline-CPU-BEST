`timescale 1ns / 1ps
`timescale 1ns/1ps

module tb_alu_addi;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [4:0]  alucont;
    wire [31:0] result;

    // DUT
    alu dut (
        .a(a),
        .b(b),
        .alucont(alucont),
        .result(result)
    );

    initial begin
        $display("=== ADDI test start ===");

        // addi x1, x0, 100
        a = 32'd0;          // x0
        b = 32'd100;        // imm = 100
        alucont = 5'b00000; // ADD

        #10;

        if (result !== 32'd100) begin
            $display("FAIL: result = %d (expected 100)", result);
        end else begin
            $display("PASS: addi result = %d", result);
        end

        $display("=== ADDI test end ===");
        $finish;
    end

endmodule

