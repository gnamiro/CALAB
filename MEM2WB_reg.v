`timescale 1ns / 1ns

module MEM2WB_reg(
  input clk, rst,
  input WB_EN_IN, MEM_R_EN_IN,
  input [31:0] ALURes_IN, MEM_Res_IN,
  input [3:0]  Dest_IN,
  output reg [31:0] ALURes, MEM_Res_OUT,
  output reg [3:0] Dest,
  output reg MEM_R_EN, WB_EN
  );



    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            {ALURes, Dest, MEM_R_EN, WB_EN, MEM_Res_OUT} = 0;
        end
        else begin
            ALURes <= ALURes_IN;
            Dest <= Dest_IN;
            MEM_R_EN <= MEM_R_EN_IN;
            WB_EN <= WB_EN_IN;
            MEM_Res_OUT <= MEM_Res_IN;
        end
    end
endmodule
