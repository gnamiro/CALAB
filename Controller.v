module Controller(input[5:0]opcode,Function,input zero,rst
,output pcCondition,[1:0]Flush,output reg R_branch, output[1:0] pcSrc,writeBack,memorySignals,output[4:0]excutionSignals);

reg [1:0] pc_src;
reg pc_condition;
reg[1:0] write_back,memory_signals,flush;
reg [4:0]execution_signals;
always@(*) begin
  if(rst)begin
    {pc_src,pc_condition} = 3'b0;
    execution_signals = 3'b000;
    write_back = 2'b00;
    memory_signals = 2'b00;
    R_branch = 1'b0;
  end else begin
    
    {pc_src,pc_condition} = 3'b0;
    execution_signals = 3'b000;
    write_back = 2'b00;
    memory_signals = 2'b00;
    R_branch = 1'b0;
    case(opcode)
      6'b100011:begin write_back = 2'b10; memory_signals = 2'b10; execution_signals = 5'b01000;  end //Load
      
      6'b101011:begin write_back = 2'b00; memory_signals = 2'b01; execution_signals = 5'b01000;end //Store
      
      6'b000010:begin write_back = 2'b00; memory_signals = 2'b00; execution_signals = 5'b00000; pc_src = 2'd2; flush = 2'd2;end  //Jump
      
      6'b000100:begin  pc_condition = 1; flush = zero ? 2'b01:2'b0;  pc_src = zero  ? 2'b01 : 2'b0; R_branch = 1'b1;  end // Beq 

      6'b000101:begin  pc_condition = 1; flush = zero ? 2'b0:2'b01;  pc_src = zero  ? 2'b00 : 2'b01; R_branch = 1'b1;  end // Neq 
      
      6'b000000:begin //R_type 
        R_branch = 1'b1;
        write_back = 2'b11;
        memory_signals = 2'b00;
        case(Function)
          6'b100000:begin //add
                    execution_signals = 5'b10000; 
                    end
                      
          6'b100010:begin //subtract
                    execution_signals = 5'b10001; 
                    end

          6'b100100:begin //and
                    execution_signals = 5'b10010; 
                    end

          6'b100101:begin //or 
                    execution_signals = 5'b10011; 
                    end

          6'b101010:begin //set less than
                    execution_signals = 5'b10100; 
                    end
        endcase
      end

      6'b111111: begin flush = 2'b0; end //nop

      default: begin {pc_src,pc_condition}=3'b0; execution_signals=3'b000; write_back = 2'b00; memory_signals = 2'b00; R_branch = 1'b1; end
    endcase
  end
end
  
  assign pcSrc = pc_src;
//   assign pcEn = pc_en;
  assign Flush = flush;
  assign pcCondition = pc_condition;
  assign writeBack = write_back;
  assign memorySignals = memory_signals;
  assign excutionSignals = execution_signals;
endmodule