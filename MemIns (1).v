`timescale 1ns / 1ns

module InstructionMemory(input [4:0]address, input writeData, readData, clk, input [7:0]dataIn, output [7:0]DorI);

	reg [7:0]memory[31:0];
	always @(posedge clk)begin
		if(writeData) memory[address] <= dataIn;
	end
	assign DorI = (readData) ? memory[address] : 8'b0;

	initial begin
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

		// memory[0] = 8'b10011101;	// push 8 in St
		// memory[1] = 8'b10011101;	// push 8 in St
		// memory[2] = 8'b00000000;	// add 8 + 8 and stoers 16 in St
		// memory[3] = 8'b11000111;	// jump to instruction 7
		// memory[7] = 8'b11101100;	// does not jumpz to 12 
		// memory[8] = 8'b10011110;	// push 16 on St
		// memory[9] = 8'b00100000;	// sub 16 - 16 and store 0 on St
		// memory[10] = 8'b11101111;	// jumpz 15
		// memory[15] = 8'b10011100;	// push 10101010 on St
		// memory[16] = 8'b10011011;	// push 01100110 on St
		// memory[17] = 8'b01000000;	// and 10101010 & 01100110 and store 01000100 on St
		// memory[18] = 8'b01100000;	// not 01000100 and store 10111011 on St
		// memory[19] = 8'b10111111;	// pop 10111011 from st and store it on Memory[31]
		// memory[20] = 8'b10111110;	// pop 0 from st and store it on Memory[30]

		// memory[27] = 8'b01100110;
		// memory[28] = 8'b10101010;
		// memory[29] = 8'b00001000;
		// memory[30] = 8'b00010000;

	end


endmodule

