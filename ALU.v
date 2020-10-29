module ALU (input [2:0]controller_command ,
 input [31:0] A , B,output reg[31:0] res);
   always@(*)begin
    res = A + B;
  end
  
endmodule
