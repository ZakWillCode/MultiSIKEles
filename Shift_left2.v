module SL2 (

    input   [31:0]  Instruction,

    output  [7:0]   Jump_address

);

    assign Jump_address = Instruction[5:0] << 2;

endmodule