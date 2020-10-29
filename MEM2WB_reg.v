module MEM2WB_reg(input clk,rst,input [31:0]result,read_data,input [4:0]reg_dst
                ,input [1:0] write_back_signal
                ,output reg [31:0]Read_data,Result
                ,output reg [4:0]Reg_Dst
                ,output reg [1:0] Write_back_signal);

    always@(posedge clk,posedge rst)begin
        if(rst)begin
            Read_data <= 32'b0;
            Result <= 32'b0;
            Reg_Dst <= 5'b0;
            Write_back_signal <= 2'b0;
        end else begin
            Read_data <= read_data;
            Result <= result;
            Reg_Dst <= reg_dst;
            Write_back_signal <= write_back_signal;
        end
    end

endmodule