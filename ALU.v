module ALU (input flush, input[3:0] statusRegs_IN,input [3:0] controller_command, input [31:0] A, B, output reg[31:0] res, output reg[3:0] Status_values);
reg _c, _n, _v, _z;

always@ (*) begin
  {_c, _n, _v, _z} = 4'b0;
  if(flush)begin
    {_c, _n, _v, _z} = 4'b0;
    res = 32'b0;
  end
  else begin
    case(controller_command)
      4'b0001: res = B;
      4'b1001: res = ~B;
      4'b0010:begin {_c,res} = A + B; _v = (~res[31] & A[31] & B[31]) | (res[31] & ~A[31] & ~B[31]); end   //overflow
      4'b0011:begin {_c, res} = A + B + statusRegs_IN[1];  _v = (~res[31] & A[31] & B[31]) | (res[31] & ~A[31] & ~B[31]); end//overflow
      4'b0100:begin res = A - B; _v = res[31] != A[31]; _v = (~res[31] & A[31] & ~B[31]) | (res[31] & ~A[31] & B[31]); end   //underflow
      4'b0101:begin res = A - B - 1; _v = res[31] != A[31]; _v = (~res[31] & A[31] & ~B[31]) | (res[31] & ~A[31] & B[31]); end   //underflow
      4'b0110: res = A & B;
      4'b0111: res = A | B;
      4'b1000: res = A ^ B;
      default: res = 32'b0;
    endcase
    _z = res == 32'b0;
    _n = res[31] == 1'b1;

    Status_values = {_n, _z, _c, _v};
  end
end

endmodule
