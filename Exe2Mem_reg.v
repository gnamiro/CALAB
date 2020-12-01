module EXE2MEM_reg(
  input clk, rst,
  input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
  input [31:0] ALURes_IN,
  input [31:0] Val_Rm_IN,
  input [3:0] Dest_IN,
  output reg[31:0] ALURes_MEM, Val_Rm_MEM,
  output reg[3:0] Dest_MEM,
  output reg MEM_R_EN_MEM, WB_EN_MEM, MEM_W_EN_MEM
);

    always@(posedge clk, posedge rst) begin
        if(rst) begin
            ALURes_MEM <= 32'b0;
            Val_Rm_MEM <= 32'b0;
            Dest_MEM <= 5'b0;
            MEM_R_EN_MEM <=1'b0;
            WB_EN_MEM <= 1'b0;
            MEM_W_EN_MEM <= 1'b0;
        end else begin
          ALURes_MEM <= ALURes_IN;
          Val_Rm_MEM <= Val_Rm_IN;
          Dest_MEM <= Dest_IN;
          MEM_R_EN_MEM <=MEM_R_EN_IN;
          WB_EN_MEM <= WB_EN_IN;
          MEM_W_EN_MEM <= MEM_W_EN_IN;
        end
    end

endmodule
