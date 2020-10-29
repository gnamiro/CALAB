module TB();
  reg clk=0,rst=0;
  pipeline pp(clk,rst);
  always begin #20 clk=~clk;end

  initial begin rst=1;
  #40;rst=0;  #100000; $stop; end
endmodule 
  
