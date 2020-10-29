module pipeline(input clk,rst);

  wire [5:0] Opcode,Function;
  wire [4:0] excutionSignals;
  wire [1:0] pcSrc,writeBack,memorySignals,Flush;
  wire Zero,pcCondition,R_branch;

  Datapath Dp(clk,rst,Opcode,Function, Zero,pcCondition,Flush,R_branch,pcSrc,writeBack,memorySignals,excutionSignals);
  

  Controller cont(Opcode,Function, Zero,rst,pcCondition,Flush,R_branch,pcSrc, writeBack,memorySignals,excutionSignals);
  
endmodule