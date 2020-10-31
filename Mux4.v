module Mux4 #(parameter n = 1) (
  input [n-1:0] A, B, C, D,
  input [1:0] Sel, input[n-1:0] w);

    assign w = (Sel == 2'b00) ? A :
               ( (Sel == 2'b01) ? B :
               ( (Sel == 2'b10) ? C : D ) ) ;
endmodule
