module ID2EXE_reg(input clk,rst,input [1:0]write_back_signal,memory_signal,input [4:0]EXE_signal,Rs,Rt,Rd,input [5:0] opcode
                ,input [31:0]signed_val,datareg1,datareg2
                ,output reg[1:0]Write_back_signal,Memory_signal
                ,output reg[4:0]_Exe_signal,RS,RT,RD
                ,output reg[31:0] output_val,Datareg1,Datareg2
                ,output reg[5:0] Opcode);
            
    always @(posedge clk,posedge rst)begin
        if(rst)begin
            Write_back_signal <= 2'b0;
            Memory_signal <= 2'b0;
            _Exe_signal <= 5'b0;
            RS <= 5'b0;
            RT <= 5'b0;
            RD <= 5'b0;
            //{Beq,Neq} <= 2'b0;
            Opcode <= 6'b0;
            Datareg1 <= 32'b0;
            Datareg2 <= 32'b0;
        end else begin
            output_val <= signed_val;
            Write_back_signal <= write_back_signal;
            Memory_signal <= memory_signal;
            _Exe_signal <= EXE_signal;
            RS <= Rs;
            RT <= Rt;
            RD <= Rd;
            Opcode <= opcode;
            Datareg1 <= datareg1;
            Datareg2 <= datareg2;
        end

    end

endmodule