module branchdec(
   input beq, bne, blt, bge, bltu, bgeu,
    input N, C, Z, V,
    output btaken
);
    wire lt = N ^ V;

assign btaken =
    (beq  &  Z) |
    (bne  & ~Z) |
    (blt  &  lt) |
    (bge  & ~lt) |
    (bltu & ~C) |
    (bgeu &  C);

endmodule

