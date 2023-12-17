module 	memory_tb();

    reg           ph1, reset;
    reg           RegWrite;
    reg   [4:0]   inst2521, inst2016;
    reg  [7:0]   Write_data;

    wire  [7:0]   Read_data_1, Read_data_2;
Registers registers (
        .ph1(ph1),
        .reset(reset),
        .Read_register_1(inst2521),
        .Read_register_2(inst2016),
        .Write_register(Write_register),
        .Write_data(Write_data),
        .RegWrite(RegWrite),
        .Read_data_1(Read_data_1),
        .Read_data_2(Read_data_2)
    );
	initial begin
	inst2521 = 1;
	inst2016 = 1;
	reset = 1;
	ph1 = 0;
	#10
	ph1 = 1;
	#10
	ph1 = 0;
	#10
	ph1 = 1;
	#10
	ph1 = 0;
	#10
	reset = 0;
		forever begin
			#10
			ph1 = 1;
			inst2521 = inst2521 +1;
			inst2016 = inst2016;
			#10
			ph1 = 0;
		end
	end 

endmodule
