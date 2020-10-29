module Pcreg(input clk,rst,freeze,input [31:0]pcin,output reg[31:0]pcout);
  //reg [31:0]pc ;
  always@(posedge clk,posedge rst)begin
    if(rst)begin
      pcout <= 32'b0;
    end else begin
      if(~freeze)begin
          pcout<=pcin;
      end
    end
  end
    //assign pcout=pc;
endmodule