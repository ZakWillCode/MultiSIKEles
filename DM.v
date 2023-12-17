 module data_mem  
 (  
	input 		            clk,
	input 		            rst,

	input  signed   [7:0]	result,  	// write ports
    input           [7:0]   ea,
	input			        mem_en,  

	output signed   [7:0]	data  		// read port
 );  

	reg    signed   [7:0]   ram     [255:0]; 
	integer i;

	always @(negedge clk) begin 

		if (rst) begin
			for (i = 0; i < 256; i = i + 1) begin
        			ram[i] <= 8'b00000000;
      			end
		end else if (mem_en) begin
            ram[ea] <= result; //For write data only
        end
	end     

    assign data = ram[ea];

 endmodule  
