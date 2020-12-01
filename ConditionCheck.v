module ConditionCheck(
  input [3:0] cond, Sr,
  output reg condRes
);

reg _c, _z, _n, _v;
always @ ( * ) begin
  {_n, _z, _c, _v} = Sr;
  case(cond)
    4'b0000:begin condRes = _z == 1'b1 ? 1'b1: 1'b0; end
    4'b0001:begin condRes = _z == 1'b0 ? 1'b1: 1'b0; end
    4'b0010:begin condRes = _c == 1'b1 ? 1'b1: 1'b0; end
    4'b0011:begin condRes = _c == 1'b0 ? 1'b1: 1'b0; end
    4'b0100:begin condRes = _n == 1'b1 ? 1'b1: 1'b0; end
    4'b0101:begin condRes = _n == 1'b0 ? 1'b1: 1'b0; end
    4'b0110:begin condRes = _v == 1'b1 ? 1'b1: 1'b0; end
    4'b0111:begin condRes = _v == 1'b0 ? 1'b1: 1'b0; end
    4'b1000:begin condRes = (_c == 1'b1) && (_z == 1'b0) ? 1'b1: 1'b0; end
    4'b1001:begin condRes = (_c == 1'b0) && (_z == 1'b1) ? 1'b1: 1'b0; end
    4'b1010:begin condRes = (_n == _v) ? 1'b1: 1'b0; end
    4'b1011:begin condRes = (_n != _v) ? 1'b1: 1'b0; end
    4'b1100:begin condRes = (_n == _v) && (_z == 1'b0) ? 1'b1: 1'b0; end
    4'b1101:begin condRes = (_n != _v) && (_z == 1'b1) ? 1'b1: 1'b0; end
    4'b1110:begin condRes = 1'b1; end
    default:begin condRes = 1'b1; end
  endcase
end
// assign condRes = cond == 4'b1110 ? 1'b1 : cond == Sr ? 1'b1 : 1'b0;

endmodule
