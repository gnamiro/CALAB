module IF2ID_reg(
  input flush, clk, rst, freeze,
  input [31:0] pc, instruction_in,
  output reg [31:0] instruction_out, pc_out
);

    always@(posedge clk, posedge rst) begin
        if (rst) begin
            instruction_out <= {32'b1110_00_0_0000_0_0000_0000_00000000000};
            pc_out <= 32'b0;
        end
        if (~freeze) begin
            if (flush) begin
                instruction_out <= {32'b1110_00_0_0000_0_0000_0000_00000000000};
            end
            else begin
                instruction_out <= instruction_in;
                pc_out <= pc;
            end
        end
    end
endmodule
