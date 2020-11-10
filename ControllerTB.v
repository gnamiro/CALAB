module ControllerTB();
reg [1:0] Mode;
reg [3:0] Op_Code;
reg       S;
wire  [8:0] controllerRes;

Controller ut(
    .Mode(Mode),
    .Op_Code(Op_Code),
    .S(S),
    .controllerRes(controllerRes)
);

initial begin
  Mode    = 2'b0;       // Arithmatic
  Op_Code = 4'b0100; // Add
  S       = 1'b0;
  #100;
  Mode    = 2'b0;       // Arithmatic
  Op_Code = 4'b0000; // And
  S       = 1'b0;
  #100;
  Mode    = 2'b01;       // Load Store
  Op_Code = 4'b0100;
  S       = 1'b1; // Load
  #100000;
  $stop;

end
endmodule
