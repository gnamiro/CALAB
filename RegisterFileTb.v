module RegisterFileTB();
  reg          clk = 0, rst, writeBackEn;
  reg [3:0]    src1, src2, Dest_wb;
  reg [31:0]   Result_WB;
  wire [31:0]  reg1, reg2;
  always #200  clk = ~clk;
  RegisterFile ut(
      .clk(clk), .rst(rst), .writeBackEn(writeBackEn),
      .src1(src1), .src2(src2), .Dest_wb(Dest_wb),
      .Result_WB(Result_WB),
      .reg1(reg1), .reg2(reg2)
  );
  initial begin
    writeBackEn = 0;
    rst = 1;
    #100;
    rst = 0;
    writeBackEn = 1;
    #100;
    Dest_wb = 4'd5;
    Result_WB = 32'd6;
    #450;
    writeBackEn = 1;
    Dest_wb = 4'd6;
    Result_WB = 32'd7;
    #450;
    writeBackEn = 0;
    src1 = 4'd6;
    src2 = 4'd5;
    #100000;
    $stop;

  end
endmodule
