module ConditionCheck(
  input [3:0] cond, Sr,
  output condRes
);

assign condRes = cond == 4'b1110 ? 1'b1 : cond == Sr ? 1'b1 : 1'b0;

endmodule
