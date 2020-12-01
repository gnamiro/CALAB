module StatusRegister(input clk, rst, input [3:0] Status_values, input S, output reg[3:0] StatusRegs);
  always @ (negedge clk, posedge rst) begin
    if(rst)
      StatusRegs <= 4'b1110;
    else if(S)
      StatusRegs <= Status_values;
  end
endmodule // StatusRegister
