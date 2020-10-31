`timescale 1ns / 1ns

module ID2EXE_reg(
  input clk, rst, flush,// flush, WB_IN_EN_in, MEM_R_EN_in, MEM_W_EN_in, MemToRegIn, RegDstIn, ALUSrcIn, B_in, S_in;
  // WB_IN_EN = RegWriteIn
  // B = branch_taken
  input [31:0] next_pc_in, //, ReadDataRF0In, ReadDataRF1In, SignExtendedIn;
  // input [4:0]  Rt_in, Rs_in, Rd_in;
  // input [2:0]  EXE_CMD_in;
  // input [1:0]  PCSrcIn;
  // input [25:0] Signed_imm_24_in;
  input [31:0] instruction_in,
  // output reg  [25:0] Signed_imm_24;
  // output reg  WB_IN_EN, MemRead, MemWrite, MemToReg, RegDst, ALUSrc;
  output reg branch_taken,
  output reg  [31:0] next_pc, //, ReadDataRF0, ReadDataRF1, SignExtended;
  output reg [31:0] instruction
  // output reg  [4:0]  Rn, Rm, Rd;
  // output reg  [2:0] EXE_CMD;
  // output reg  [1:0] PCSrc;
);



    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            // {JumpAddress, RegWrite, MemRead, MemWrite, ALUControl, MemToReg, PCPlus4, ReadDataRF0, ReadDataRF1, SignExtended, Rt, Rs, Rd, PCSrc, RegDst, ALUSrc} = 0;
            next_pc <= 0;
            instruction <= 0;
            branch_taken <= 0;
        end
        else begin
            if (flush) begin
                next_pc <= 0;
                instruction <= 0;
                branch_taken <= 0;
            end
            else begin
                next_pc <= next_pc_in;
                instruction <= instruction_in;
                branch_taken <=0;
            end
            // Signed_imm_24 <= Signed_imm_24_in;
            // WB_IN_EN <= WB_IN_EN_in;
            // MemRead <= MEM_R_EN_in;
            // MemWrite <= MEM_W_EN_in;
            // B <= B_in;
            // S <= S_in;
            // MemToReg <= MemToRegIn;
            // PCSrc <= PCSrcIn;
            // RegDst <= RegDstIn;
            // PCPlus4 <= next_pc_in;
            // ReadDataRF0 <= ReadDataRF0In;
            // ReadDataRF1 <= ReadDataRF1In;
            // SignExtended <= SignExtendedIn;
            // Rt <= Rt_in;
            // Rs <= Rs_in;
            // Rd <= Rd_in;
            // EXE_CMD <= EXE_CMD_in;
            // ALUSrc <= ALUSrcIn;
        end
    end
endmodule
