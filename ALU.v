module ALU (input [2:0]controller_command ,
 input [31:0] A , B,output reg[31:0] res);
   always@(*)begin
    case(controller_command)
    
      3'b000:res = A+B;   //ADD
      3'b001:res = A-B;   //SUB
      3'b010:res = A&B;   //AND
      3'b011:res = A|B;   //OR
      3'b100: res = A<B ? 8'b00000001:8'b0;  //SLT
      default: res = 0;

    endcase
  end
  
endmodule
