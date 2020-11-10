module RegisterFile (
    input  clk, rst, writeBackEn,
    input  [3:0] src1, src2, Dest_wb,
    input  [31:0] Result_WB,
    output [31:0] reg1, reg2
);

reg [31:0] Reg[0:14];
integer i;

always@ (negedge clk, posedge rst) begin
  if (rst) begin
    for (i = 0; i < 16; i = i + 1)
      Reg[i] <= 0;
  end
  if (writeBackEn && Dest_wb != 4'b0) //: is any of our registers write restricted?
    Reg[Dest_wb] <= Result_WB;
end

assign reg1 = (Reg[src1]);
assign reg2 = (Reg[src2]);

endmodule
