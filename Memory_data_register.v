module  Memory_data_register (
    input                   ph1, reset,
    input           [7:0]   MemData,
    output  reg     [7:0]   RegData
);

    always @(posedge ph1) begin
        if (reset) 
            RegData <= 8'b0;
        else
            RegData <= MemData;
    end    

endmodule