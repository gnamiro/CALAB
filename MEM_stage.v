`timescale 1ns / 1ns
module MEM_Stage(
  input [31:0] Val_Rm, ALU_Res,
  input clk, MEM_W_EN, MEM_R_EN,
  output [31:0] MEM_Out
);


wire [31:0] Address;
reg [31:0] RAM[0:64512]; //1024 to 2**16
assign Address = ((ALU_Res  - 32'd1024)>>2) % 32'd64513;

always @ (posedge clk) begin
    if (MEM_W_EN) begin
        RAM[Address] <= Val_Rm;
    end
end



assign MEM_Out = MEM_R_EN ? RAM[Address] : 0;
endmodule
