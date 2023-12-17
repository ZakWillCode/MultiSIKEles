module mux2_1 (
    input [7:0] A, B,
    input sel,
    output [7:0] Y
);

    assign Y = !sel ? A : B;

endmodule