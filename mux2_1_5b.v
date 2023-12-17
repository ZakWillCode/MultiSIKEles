module mux2_1_5b (
    input [4:0] A, B,
    input sel,
    output [4:0] Y
);

    assign Y = !sel ? A : B;

endmodule