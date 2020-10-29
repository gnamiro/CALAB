module Memory(input[31:0] address,input[31:0] writedata, input clk,writemem,readmem,output[31:0] readmem_out);

reg [31:0]Memory[0:1023];//???????????????????????????????????????? 
initial begin
  // Memory[0] = 32'd10;
  // Memory[1] = 32'd5;
  // Memory[2] = 32'd25;
  // Memory[3] = 32'd13;
  // Memory[4] = 32'd3;
  // Memory[5] = 32'd4;
  // Memory[6] = 32'd0;
  // Memory[7] = 32'd1;
  // Memory[8] = 32'd6;
  // Memory[10] = 32'd50;
  // Memory[11] = 32'd80;
  // Memory[12] = 32'd12;
  // Memory[13] = 32'd14;
  // Memory[14] = 32'd26;
  // Memory[15] = 32'd39;
  // Memory[16] = 32'd19;
  // Memory[17] = 32'd50;
  // Memory[18] = 32'd32;
  // Memory[19] = 32'd9;
  // Memory[20] = 32'd109;
  // Memory[21] = 32'd1;
  // Memory[22] = 32'd16;
  // Memory[23] = 32'd28;
  // Memory[24] = 32'd39;
  // Memory[25] = 32'd49;
  // Memory[26] = 32'd59;
  // Memory[27] = 32'd69;
  // Memory[28] = 32'd79;
  // Memory[29] = 32'd89;

  Memory[999] = 32'd5;
  Memory[1000] = 32'd13;
  Memory[1001] = 32'd5;
  Memory[1002] = 32'd50;
  Memory[1003] = 32'd4;
  Memory[1004] = 32'd12;
		// Memory[0] = 8'b10011001;//push 25 be stack
		// Memory[1] = 8'b10011010;//push 26 be stack
		// Memory[2] = 8'b10011011;//push 27 be stack
		// Memory[3] = 8'b10011100;//push 28 be stack
		// Memory[4] = 8'b10011101;//push 29 be stack
		// Memory[5] = 8'b00000000;//add 
		// Memory[6] = 8'b00000000;//add
		// Memory[7] = 8'b00000000;//add
		// Memory[8] = 8'b00000000;//add
		// Memory[9] = 8'b10111110;//pop be 30

		// Memory[25] = 8'b00001001;
		// Memory[26] = 8'b00000111;
		// Memory[27] = 8'b00000101;
		// Memory[28] = 8'b00000011;
		// Memory[29] = 8'b00000001;

		// Memory[0] = 8'b10011101;	// push 8 in St
		// Memory[1] = 8'b01100000;	//not 00001000
		
		// Memory[2] = 8'b10111111;	// pop 10111011 from st and store it on Memory[31]
		// Memory[3] = 8'b10111110;	// pop 0 from st and store it on Memory[30]

		// Memory[27] = 8'b01100110;//102
		// Memory[28] = 8'b10101010;//170
		// Memory[29] = 8'b00001000;//8
		// Memory[30] = 8'b00010000;//16
    // Memory[0]=8'b10001110 // push M[14]
    // Memory[1]=8'b10001111 // push M[15]
    // Memory[2]=8'b10010000 // push M[16]
    // Memory[3]=8'b10010001 // push M[17]
    // Memory[4]=8'b10010010 // push M[18]
    // Memory[5]=8'b10110011 // pop M[19]
    // Memory[0]=8'b00001010 // add  -4 + -3 = -7
    // Memory[0]00100011 // sub  -7 - 2 = -9
    // Memory[0]01100000 // not -9 = 8
    // Memory[0]10010100 // push M[20]
    // Memory[0]11101101 // jz 13
    // 00000000
    // 00000000
    // 11011111 // jump 31
    // 00000001 // data memory  az inja shooroo mishe
    // 00000010
    // 11111101
    // 11111100
    // 00000101
    // 00000111
    // 00000000

	end
always @(posedge clk)begin
  if (writemem)
    Memory[address] <= writedata ;


  end
  assign readmem_out=readmem?Memory[address]:8'b0;
endmodule
