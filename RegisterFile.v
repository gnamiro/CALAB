module RegisterFile (
    input  clk, rst,
    input[31:0] WB_Value,
    input[3:0] WB_Dest,
    input WB_EN,
    input  [3:0] src1, src2,
    output [31:0] reg1, reg2
);

reg [31:0] Reg[0:15];
integer i;

always@ (negedge clk, posedge rst) begin
  if (rst) begin
    for (i = 0; i < 16; i = i + 1)
      Reg[i] <= 0;
  end
  // if (WB_EN && WB_Dest != 4'b0) //: is any of our registers write restricted?
  //   Reg[WB_Dest] <= WB_Value;
  if (WB_EN) //: is any of our registers write restricted?
    Reg[WB_Dest] <= WB_Value;

end

assign reg1 = (Reg[src1]);
assign reg2 = (Reg[src2]);

endmodule
