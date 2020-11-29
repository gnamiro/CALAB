module Val2_Gen(input [31:0]Val_Rm, input[11:0]Shift_operand, input imm, val2GenSel, output reg[31:0] val2GenOut);

reg[63:0] immTemp;
reg[63:0] immShiftTemp;
reg[7:0] immed_8;
reg[3:0] rotate_imm;
reg[5:0] shift_imm;
reg[1:0] shift;

always@(*)begin
  if(val2GenSel)
    val2GenOut = { {20{Shift_operand[11]}}, Shift_operand};
  else begin
    if(imm) begin
      immed_8 = Shift_operand[7:0];
      rotate_imm = Shift_operand[11:8];
      immTemp = {24'b0, immed_8};
      while(rotate_imm != 4'b0)begin
        immTemp = {immTemp[0], immTemp[31:1]};
        rotate_imm = rotate_imm - 1'b1;
      end
      rotate_imm = Shift_operand[11:8];
      while(rotate_imm != 4'b0)begin
        immTemp = {immTemp[0], immTemp[31:1]};
        rotate_imm = rotate_imm - 1'b1;
      end
      val2GenOut = immTemp;

    end
    else if(imm == 1'b0 && Shift_operand[4] == 1'b0)begin
      shift = Shift_operand[6:5];
      shift_imm = Shift_operand[11:7];
      immShiftTemp = Val_Rm;
      case(shift)
        2'b00:begin
          val2GenOut = Val_Rm << shift_imm;
        end
        2'b01:begin
          val2GenOut = Val_Rm >> shift_imm;
        end
        2'b10:begin
          val2GenOut = Val_Rm >>> shift_imm;
        end
        2'b11:begin
          while(shift_imm != 4'b0)begin
            immTemp = {immTemp[0], immTemp[31:1]};
            shift_imm = shift_imm - 1'b1;
          end
          shift_imm = Shift_operand[11:7];
          while(shift_imm != 4'b0)begin
            immTemp = {immTemp[0], immTemp[31:1]};
            shift_imm = shift_imm - 1'b1;
          end
          val2GenOut = immTemp;
        end

        default: val2GenOut = 32'b0;
      endcase
    end

  end
end

endmodule // Val2_Gen
