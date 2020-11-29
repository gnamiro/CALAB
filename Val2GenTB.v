module Val2GenTB();
  reg [31:0] Val_Rm;
  reg [11:0] Shift_operand;
  reg imm, val2GenSel;
  wire [31:0] val2GenOut;
  Val2_Gen ut(.Val_Rm(Val_Rm), .Shift_operand(Shift_operand), .imm(imm), .val2GenSel(val2GenSel), .val2GenOut(val2GenOut));

  initial begin
      imm = 1'b1;
      val2GenSel = 1'b1;
      Val_Rm = 32'd100;
      Shift_operand = -12'd4; //sign Extend test
      #400;
      val2GenSel = 1'b0;
      Shift_operand = 12'b001110110111;

      // Val_Rn = 3;
      // ALU_Res = 200;
      // #400;
      // MEM_W_EN = 0;
      // #400;
      // MEM_R_EN = 1;
      // #400;
      // Val_Rn = 2;
      // #400;
      // MEM_R_EN = 0;
      #100000000;
      $stop;
  end
endmodule
