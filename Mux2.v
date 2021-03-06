module  Mux2 #(parameter n = 1)(
  input  [n-1:0] a,  b,
  input  select,
  output [n-1:0] w
);

  assign w = select ? a : b;

endmodule
