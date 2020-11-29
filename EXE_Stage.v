module EXE_Stage(
input clk, rst,
input[31:0] pc_in,
input flush, MEM_R_EN, MEM_W_EN, S,
input[3:0] EXE_CMD,
input[31:0] Val_Rn, Val_Rm,
input imm,
input[3:0] statusRegs_IN,
input[11:0] Shift_operand,
input[23:0] Signed_imm_24,
output[31:0] new_branch_addr,
output[31:0] res,
output[3:0] statusRegs
);

wire val2GenSel;
wire [31:0]val2GenOut;
wire [3:0]status_values;

assign val2GenSel = MEM_R_EN | MEM_W_EN;
/*
wire [31:0] A, B, B_in, Exe_Dest;
wire [1:0] Forw_A, Forw_B;
wire Forw_unit;

Forw_Unit forward_unit(mem_mem[1], wb_mem[1], wb_wb[1], Rs, Rt, Mem_Dest, write_reg_wb, Forw_A, Forw_B, Forw_unit);

Mux4 #(32) mux_Forw_A (_datareg1,write_data,res_out,32'b0,Forw_A,A);
Mux4 #(32) mux_Forw_B (_datareg2,write_data,res_out,32'b0,Forw_B,B_in);
Mux2 #(32) mux_offset(offset_out,B_in, exe_exe[3], B);
Mux2 #(5) mux_dest(Rd,Rt, exe_exe[4], Exe_Dest);
*/
Val2_Gen val2Gen(.Val_Rm(Val_Rm), .Shift_operand(Shift_operand), .imm(imm), .val2GenSel(val2GenSel), .val2GenOut(val2GenOut));
ALU alu (.flush(flush), .statusRegs_IN(statusRegs_IN), .controller_command(EXE_CMD), .A(Val_Rn), .B(val2GenOut), .res(res), .Status_values(status_values));
StatusRegister statusReg(.clk(clk), .rst(rst), .Status_values(status_values), .S(S), .StatusRegs(statusRegs));

assign new_branch_addr = pc_in + { {6{Signed_imm_24[23]}}, Signed_imm_24<<2};


endmodule
