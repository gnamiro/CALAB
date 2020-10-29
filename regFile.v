module regFile(input clk,enwrite,input [4:0]readreg1,readreg2,writereg,input [31:0]writedata,
  output [31:0]datareg1,datareg2);
  
  reg [31:0] Reg[0:31];

  integer i;
  initial begin
    for(i=0;i<32;i=i+1)begin
      Reg[i]=32'b0;
    end
    Reg[1] = 32'b1;
  end

  always@(*)begin
    if(enwrite)
      Reg[writereg]=writedata;

  end
  assign datareg1=Reg[readreg1];
  assign datareg2=Reg[readreg2];

endmodule