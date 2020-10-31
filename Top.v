module Top (input clk, rst);

  // wire zero,freeze,stall,Forw_unit, branch_taken;
  // wire [31:0] sub_reg,ext_offset,offset_out;
  // wire [31:0] pc_in,pc_out,next_pc,next_pc1,branch_addr,pc_jump,pc_jump1;   // related to pc
  // wire [31:0] instruction, If_out,write_data,datareg1,datareg2,offset;
  // wire [1:0] wb_wb,mem_mem,wb_exe,wb_mem,Forw_A,Forw_B;
  // wire [4:0] stall_exe,exe_exe;
  // wire [1:0] mem_exe,stall_wb,stall_mem;
  // wire [4:0] Exe_Dest,Mem_Dest,Rt,Rd,Rs,write_reg_wb;
  // wire [31:0] _datareg1, _datareg2, res, res_out, A, B_in, B, store_data, mem_out, read_data, result;
  // wire [5:0] prev_command;


  //IF stage
  wire freeze, branch_taken, flush;
  wire [31:0] branch_addr, next_pc, instruction;
  IF_Stage if_stage(.clk(clk), .rst(rst), .freeze(freeze), .branch_taken(branch_taken), .branch_addr(branch_addr), .pc(next_pc), .instruction(instruction));


  //IF2Id reg
  wire [31:0] instruction_IF2ID, next_pc_IF2ID;
  IF2ID_reg if2Id(.clk(clk), .rst(rst), .freeze(freeze), .flush(flush),.pc(next_pc), .instruction_in(instruction), .instruction(instruction_IF2ID), .pc_out(next_pc_IF2ID));
  // IF2ID_reg if2Id(.flush(flush), .clk(clk), .rst(rst), .freeze(freeze), .pc(next_pc), .instruction_in(instruction), .instruction_out(instruction_IF2ID_out), .pc_out(next_pc_IF2ID));



  // assign pc_jump = {next_pc1[31:28], command[25:0], 2'b0};

   //ID stage

  wire [24:0] branch_offset;
  //ID_Stage id_state(.clk(clk), .rst(rst), .write_reg_wb(write_reg_wb), .write_data(write_data), .write_en(wb_wb[1]), .instruction(instruction), .Exe_Dest(5'b0), .mem_exe(2'b0), .excutionSignals(5'b11111), .writeBack(2'b11), .memorySignals(2'b11), .datareg1(datareg1), .datareg2(datareg2), .stall_exe(stall_exe), .stall_wb(stall_wb), .stall_mem(stall_mem), .freeze(freeze), .Opcode(Opcode), .Function(Function), .pc_branch(pc_branch));
  ID_Stage id_stage(.clk(clk), .rst(rst), .instruction(instruction_IF2ID), .freeze(freeze), .flush(flush),.Signed_imm_24(branch_offset));
  // ID2EXE
  //ID2EXE_reg id2exe(.clk(clk), .rst(rst), stall_wb, stall_mem, stall_exe, command[25:21], command[20:16], command[15:11], command[31:26]
  //              ,offset,datareg1,datareg2,wb_exe,mem_exe,exe_exe,Rs,Rt,Rd,offset_out,_datareg1,_datareg2,prev_command);
  wire [31:0] next_pc_ID2EXE, instruction_ID2EXE;
  ID2EXE_reg id2exe(.clk(clk), .rst(rst), .flush(flush), .next_pc_in(next_pc_IF2ID), .instruction_in(instruction_IF2ID), .next_pc(next_pc_ID2EXE), .instruction(instruction_ID2EXE), .branch_taken(branch_taken));


  // EXE stage
  //EXE_Stage exe_stage( .mem_mem(mem_mem), .wb_mem(wb_mem), .wb_wb(wb_wb), .wb_wb(wb_wb), .Rs(Rs), .Rt(Rt), .exe_exe(exe_exe), .Mem_Dest(Mem_Dest), .write_reg_wb(write_reg_wb), ._datareg1(_datareg1), ._datareg2(_datareg2), .write_data(write_data), .res_out(res_out), .res(res), .Exe_Dest(Exe_Dest))
  EXE_Stage exe_stage(.pc_in(next_pc_ID2EXE), .new_branch_addr(branch_addr));

  // EXE2MEM
  //Exe2Mem_reg EXE2MEM(clk, rst, wb_exe, mem_exe, res, B_in, Exe_Dest, wb_mem, mem_mem, res_out, store_data, Mem_Dest);
  wire [31:0] instruction_EXE2MEM, next_pc_EXE2MEM;
  EXE2MEM_reg Exe2Mem(.clk(clk), .rst(rst), .instruction_in(instruction_ID2EXE), .next_pc_in(next_pc_ID2EXE), .instruction(instruction_EXE2MEM), .next_pc(next_pc_EXE2MEM));


  //Memory stage
  //Memory memory(res_out,store_data,clk,mem_mem[0],mem_mem[1],mem_out);
  // reg [31:0] out;
  // Mem memory(.in_addr(32'd1025), .val_Rm(32'b0), .rst(rst), .MEM_W_EN(1'b0), .MEM_R_EN(1'b0), out);
  wire _out;
  MEM_stage mem_stage(.out(_out));

  // MEM2WB
  //MEM2WB_reg MEM2wb(clk,rst,res_out,mem_out,Mem_Dest, wb_mem,read_data,result,write_reg_wb, wb_wb);
  wire [31:0] next_pc_MEM, instruction_MEM;
  MEM2WB_reg MEM2wb(.clk(clk), .rst(rst), .instruction_in(instruction_EXE2MEM), .next_pc_in(next_pc_EXE2MEM), .next_pc(next_pc_MEM), .instruction(instruction_MEM));

  WB_Stage wb_stage(.out(_out));

  //WB stage
  //Mux2 #(32) mux_write_back(result,read_data,wb_wb[0], write_data);
endmodule
