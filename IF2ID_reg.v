module IF2ID_reg(input[1:0] flush,input clk,rst,freeze,[25:0]inst,input[31:0]pc,instruction,output reg [31:0] Instruction,pc_out);

    always@(posedge clk,posedge rst)begin
        if(rst)begin
            Instruction <= {6'b111111,inst};
            pc_out <= 32'b0;
        end
        if(~freeze)begin
            if(flush != 2'b0)begin
                Instruction<= {6'b111111,26'b0};
                // pc_out<=32'b0;
            end else begin
                Instruction <= instruction;
                pc_out <= pc;
            end
        end
    end
endmodule