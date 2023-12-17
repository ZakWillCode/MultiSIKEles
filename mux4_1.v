module mux4_1(
    input [7:0] A, B, C, D,
    input [1:0] sel,
    output [7:0] Y
);

    assign Y = sel[1] ? (sel[0]?D:C) : (sel[0]?B:A);

endmodule