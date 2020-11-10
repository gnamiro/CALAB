`timescale 1ns / 1ns

module ID2EXE_reg(
  input clk, rst, flush,
  WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN,
  input [3:0] EXE_CMD_IN,
  input [31:0] PC_IN, Val_Rn_IN, Val_Rm_IN,
  input imm_IN,
  input [11:0] Shift_operand_IN,
  input [23:0] Signed_imm_24_IN,
  input [3:0] Dest_IN,


  output reg  WB_EN, MEM_R_EN, MEM_W_EN, B, S,
  output reg [3:0] EXE_CMD,
  output reg  [31:0] PC, Val_Rn, Val_Rm,
  output reg imm,
  output reg [11:0] Shift_operand,
  output reg [23:0] Signed_imm_24,
  output reg [3:0] Dest

);



    always @ (posedge clk, posedge rst) begin
        if (rst) begin
          {WB_EN, MEM_R_EN, MEM_W_EN, B, S} <= 0;
          EXE_CMD <= 0;
          {PC, Val_Rn, Val_Rm} <= 0;
          imm <= 0;
          Shift_operand <= 0;
          Signed_imm_24 <= 0;
          Dest <= 0;
        end
        else begin
            Signed_imm_24 <= Signed_imm_24_IN;
            WB_EN <= WB_EN_IN;
            MEM_R_EN <= MEM_R_EN_IN;
            MEM_W_EN <= MEM_W_EN_IN;
            B <= B_IN;
            S <= S_IN;
            EXE_CMD <= EXE_CMD_IN;
            PC <= PC_IN;
            Val_Rn <= Val_Rn_IN;
            Val_Rm <= Val_Rm_IN;
            imm <= 0;
            Shift_operand <= Shift_operand_IN;
            Signed_imm_24 <= Signed_imm_24_IN;
            Dest <= Dest_IN;

            if (flush) begin
                PC <= 0;
                B <= 0;
            end
            else begin
                PC <= PC_IN;
                B <= 0;
            end
        end
    end
endmodule
