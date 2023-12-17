`timescale 10us/10ps
module 	mc_mips_tb();

	wire	[7:0]	ans;

	reg 	ph1, reset;

	//wire MemRead, MemWrite;
	//wire [7:0] MemData, B_data, Address;

	MC_MIPS_Programmed_TL uut(
		.ph1(ph1),
		.reset(reset),
		.ans(ans)
		/*.B_data(B_data),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.Address(Address),
		.MemData(MemData)*/
	);

	/*Memory_prog memory (
        	.ph1(ph1),
        	.reset(reset),
        	.Address(Address),
        	.Write_data(B_data),
        	.MemRead(MemRead),
        	.MemWrite(MemWrite),
        	.MemData(MemData),
		.ans(ans)
    	);*/

	initial begin
	reset = 1;
	ph1 = 0;
	#1
	ph1 = 1;
	#1
	ph1 = 0;
	#1
	ph1 = 1;
	#1
	ph1 = 0;
	reset = 0;
		forever begin
			#1
			ph1 = 1;
			#1
			ph1 = 0;
		end
	end 

endmodule
