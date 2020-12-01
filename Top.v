module Top (input clk, rst);

  wire [3:0] Sr, WB_DES, Dest;
  wire freeze, branch_taken, flush, imm;
  wire[8:0] controllerRes;
  wire [23:0] Signed_imm_24;
  wire [11:0] Shift_operand;
  wire [31:0] branch_addr, next_pc, instruction, WB_Value, Val_Rn, Val_Rm;
  wire WB_EN_ID2EXE, MEM_R_EN_ID2EXE, MEM_W_EN_ID2EXE, B_ID2EXE,S_ID2EXE;
  wire [3:0] EXE_CMD_ID2EXE;
  wire [31:0] PC_ID2EXE, Val_Rn_ID2EXE, Val_Rm_ID2EXE;
  wire imm_ID2EXE;
  wire [11:0] Shift_operand_id2EXE;
  wire [23:0] Sigend_imm_24_ID2EXE;
  wire [3:0] Dest_ID2EXE;
  wire[31:0] ALURes;
  wire[3:0] statusRegs, statusRegs_ID2EXE;
  wire[31:0] AluRes_MEM, Val_Rm_MEM;
  wire[3:0] Dest_MEM, WB_Dest;
  wire MEM_R_EN_WB, WB_WB_EN;
  wire [31:0] MEM_OUT, MEM_Res_WB;
  wire[3:0] src2;
  wire MEM_R_EN_MEM, MEM_W_EN_MEM, WB_EN_MEM;

  // IF_stage
  IF_Stage if_stage(.clk(clk), .rst(rst), .freeze(freeze), .branch_taken(B_ID2EXE), .branch_addr(branch_addr), .pc(next_pc), .instruction(instruction));



  wire [31:0] instruction_IF2ID, next_pc_IF2ID;
  IF2ID_reg if2Id(.clk(clk), .rst(rst), .freeze(freeze), .flush(B_ID2EXE), .pc(next_pc), .instruction_in(instruction), .instruction(instruction_IF2ID), .pc_out(next_pc_IF2ID));



  ID_Stage id_stage(.clk(clk), .rst(rst), .WB_Value(WB_Value), .WB_Dest(WB_Dest), .WB_WB_EN(WB_WB_EN), .instruction(instruction_IF2ID), .Freeze(freeze), .Sr(statusRegs), .flush(flush), .Signed_imm_24(Signed_imm_24), .shift_operand(Shift_operand), .imm(imm), .Val_Rn(Val_Rn), .Val_Rm(Val_Rm), .controllerRes(controllerRes), .Dest(Dest), .Src2(src2));


  Hazard_Unit hazard_unit(.Two_src(~imm | controllerRes[6]), .EXE_WB_EN(WB_EN_ID2EXE), .MEM_WB_EN(WB_EN_MEM), .Rn(instruction_IF2ID[19:16]), .EXE_Dest(Dest_ID2EXE), .MEM_Dest(Dest_MEM), .src2(src2), .freeze(freeze));

  wire [31:0] next_pc_ID2EXE, instruction_ID2EXE;
  ID2EXE_reg id2exe(.clk(clk), .rst(rst), .flush(B_ID2EXE), .WB_EN_IN(controllerRes[8]), .MEM_R_EN_IN(controllerRes[7]), .MEM_W_EN_IN(controllerRes[6]), .B_IN(controllerRes[1]), .S_IN(controllerRes[0]), .EXE_CMD_IN(controllerRes[5:2]), .PC_IN(next_pc_IF2ID), .Val_Rn_IN(Val_Rn), .Val_Rm_IN(Val_Rm), .imm_IN(imm), .statusRegs_IN(statusRegs), .Shift_operand_IN(Shift_operand), .Signed_imm_24_IN(Signed_imm_24), .Dest_IN(Dest),
   .WB_EN(WB_EN_ID2EXE), .MEM_R_EN(MEM_R_EN_ID2EXE), .MEM_W_EN(MEM_W_EN_ID2EXE), .B(B_ID2EXE),.S(S_ID2EXE), .EXE_CMD(EXE_CMD_ID2EXE), .PC(next_pc_ID2EXE), .Val_Rn(Val_Rn_ID2EXE), .Val_Rm(Val_Rm_ID2EXE), .imm(imm_ID2EXE), .statusRegs_OUT(statusRegs_ID2EXE), .Shift_operand(Shift_operand_id2EXE), .Signed_imm_24(Sigend_imm_24_ID2EXE), .Dest(Dest_ID2EXE));


  EXE_Stage exe_stage(.clk(clk), .rst(rst), .pc_in(next_pc_ID2EXE), .flush(flush), .MEM_R_EN(MEM_R_EN_ID2EXE), .MEM_W_EN(MEM_W_EN_ID2EXE), .S(S_ID2EXE), .EXE_CMD(EXE_CMD_ID2EXE), .Val_Rn(Val_Rn_ID2EXE), .Val_Rm(Val_Rm_ID2EXE), .imm(imm_ID2EXE), .statusRegs_IN(statusRegs_ID2EXE), .Shift_operand(Shift_operand_id2EXE), .Signed_imm_24(Sigend_imm_24_ID2EXE), .new_branch_addr(branch_addr), .res(ALURes), .statusRegs(statusRegs));


  wire [31:0] instruction_EXE2MEM, next_pc_EXE2MEM;
  EXE2MEM_reg Exe2Mem(.clk(clk), .rst(rst), .WB_EN_IN(WB_EN_ID2EXE), .MEM_R_EN_IN(MEM_R_EN_ID2EXE), .MEM_W_EN_IN(MEM_W_EN_ID2EXE), .ALURes_IN(ALURes), .Val_Rm_IN(Val_Rm_ID2EXE), .Dest_IN(Dest_ID2EXE), .ALURes_MEM(AluRes_MEM), .Val_Rm_MEM(Val_Rm_MEM), .Dest_MEM(Dest_MEM), .MEM_R_EN_MEM(MEM_R_EN_MEM), .WB_EN_MEM(WB_EN_MEM), .MEM_W_EN_MEM(MEM_W_EN_MEM));   // 0=--->    az in be payin mondeh



  wire _out;
  MEM_Stage mem_Stage(.Val_Rm(Val_Rm_MEM), .ALU_Res(AluRes_MEM), .clk(clk), .MEM_W_EN(MEM_W_EN_MEM), .MEM_R_EN(MEM_R_EN_MEM), .MEM_Out(MEM_OUT));


  wire [31:0] ALU_Res_WB;
  MEM2WB_reg MEM2WB(.clk(clk), .rst(rst),.WB_EN_IN(WB_EN_MEM), .MEM_R_EN_IN(MEM_R_EN_MEM), .ALURes_IN(AluRes_MEM), .MEM_Res_IN(MEM_OUT), .Dest_IN(Dest_MEM), .ALURes(ALU_Res_WB), .MEM_Res_OUT(MEM_Res_WB), .Dest(WB_Dest), .MEM_R_EN(MEM_R_EN_WB), .WB_EN(WB_WB_EN));

  Mux2 #(32) WB_mux(.a(MEM_Res_WB), .b(ALU_Res_WB), .select(MEM_R_EN_WB), .w(WB_Value));

endmodule
