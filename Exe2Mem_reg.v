module Exe2Mem_reg(input clk,rst,input [1:0]write_back_signal,memory_signal
                    ,input[31:0]result,Rb,input [4:0]Reg_Dst
                    ,output reg [1:0] Write_back_signal,Memory_signal
                    ,output reg[31:0] Result,RB,output reg[4:0]REG_DST);
    
    always@(posedge clk,posedge rst)begin
        if(rst)begin
            Write_back_signal <=2'b0;
            Result <= 32'b0;
            RB <= 32'b0;
            REG_DST <= 5'b0;
            Memory_signal <=2'b0;
        end else begin
            Write_back_signal <=write_back_signal;
            Result <= result;
            RB <= Rb;
            REG_DST <= Reg_Dst;
            Memory_signal <= memory_signal;
        end
    end

endmodule