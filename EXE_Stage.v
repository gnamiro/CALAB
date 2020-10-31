module EXE_Stage(
input[31:0] pc_in,
//input[1:0] mem_mem, wb_mem, wb_wb, input [4:0] Rs, Rt,
//exe_exe, Mem_Dest, write_reg_wb, input [31:0] _datareg1, _datareg2,
//write_data, res_out,
//output [31:0] res, Exe_Dest
output reg[31:0] new_branch_addr
);

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
//ALU alu (exe_exe[2:0] , A , B, res);

always@(*)begin
  new_branch_addr = pc_in + 32'd16;
end


endmodule
