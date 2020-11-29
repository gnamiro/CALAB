module TB();
  reg clk=0, rst=0;
  Top tp(clk, rst);
  always begin #40 clk=~clk;end

  initial begin rst=1;
  #20;rst=0;  #100000; $stop; end
endmodule
