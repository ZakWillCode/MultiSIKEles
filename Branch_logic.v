module Branch_logic (
    input Zero, PCWriteCond, PCWrite,
    
    output PCEn
);

    assign PCEn = (Zero & PCWriteCond) | PCWrite;

endmodule