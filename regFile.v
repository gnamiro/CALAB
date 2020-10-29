module regFile(input clk,enwrite,input [4:0]readreg1,readreg2,writereg,input [31:0]writedata,
  output [31:0]datareg1,datareg2);
  
  reg [31:0] Reg[0:31];


  always@(*)begin
    if(enwrite)
      Reg[writereg]=writedata;

  end
  
  assign datareg1 = 32'b0;
  assign datareg2 = 32'b00000000000000000000000000000001;

endmodule