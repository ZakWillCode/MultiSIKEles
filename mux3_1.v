module mux3_1(
    input [7:0] A, B, C,
    input [1:0] sel,
    output [7:0] Y
);

    assign Y = sel[1] ? (sel[0] ? 8'b0 : C) : (sel[0] ? B : A);

endmodule