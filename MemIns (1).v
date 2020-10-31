`timescale 1ns / 1ns

module InstructionMemory(input [4:0]address, input writeData, readData, clk, rst, input [7:0]dataIn, output [7:0]DorI);

	reg [7:0]memory[31:0];
	always @(posedge clk, posedge rst)begin
	  if(rst)begin
	    memory[0] = 8'b10011001;//push 25 be stack
	   	memory[1] = 8'b10011010;//push 26 be stack
	   	memory[2] = 8'b10011011;//push 27 be stack
		  memory[3] = 8'b10011100;//push 28 be stack
		  memory[4] = 8'b10011101;//push 29 be stack
		  memory[5] = 8'b00000000;//add 
		  memory[6] = 8'b00000000;//add
	   	memory[7] = 8'b00000000;//add
		  memory[8] = 8'b00000000;//add
		  memory[9] = 8'b10111110;//pop be 30

		  memory[25] = 8'b00001001;
		  memory[26] = 8'b00000111;
		  memory[27] = 8'b00000101;
		  memory[28] = 8'b00000011;
		  memory[29] = 8'b00000001;
	  end
		if(writeData) memory[address] <= dataIn;
	end
	assign DorI = (readData) ? memory[address] : 8'b0;

endmodule

