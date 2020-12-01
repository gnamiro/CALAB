module IF2ID_reg(
  input clk, rst, freeze, flush,
  input [31:0] pc, instruction_in,
  output reg [31:0] instruction, pc_out
);

    always@(posedge clk, posedge rst) begin
        if (rst) begin
            instruction <= 32'b11100000000000000000000000000000;
            pc_out <= 32'b0;
        end
        else if (~freeze) begin
            if (flush) begin
                instruction <= 32'b11100000000000000000000000000000;
                pc_out <= 32'b0;
            end
            else begin
                instruction <= instruction_in;
                pc_out <= pc;
            end
        end
    end
endmodule
