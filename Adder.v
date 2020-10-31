module Adder #(parameter n = 32)(
  input  ci,
  input  [n-1:0] a, b,
  output [n-1:0] c,
  output co
);


  assign {co, c} = a + b + ci;


endmodule
