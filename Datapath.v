module Datapath (input clk, rst, output[5:0] Opcode, Function,[1:0]Flush);

  wire zero,freeze,stall,Forw_unit, branch_taken;
  wire [31:0] sub_reg,ext_offset,offset_out;
  wire [31:0] pc_in,pc_out,next_pc,next_pc1,branch_addr,pc_jump,pc_jump1;   // related to pc
  wire [31:0] instruction, If_out,write_data,datareg1,datareg2,offset;
  wire [1:0] wb_wb,mem_mem,wb_exe,wb_mem,Forw_A,Forw_B;
  wire [4:0] stall_exe,exe_exe;
  wire [1:0] mem_exe,stall_wb,stall_mem;
  wire [4:0] Exe_Dest,Mem_Dest,Rt,Rd,Rs,write_reg_wb;
  wire [31:0] _datareg1, _datareg2, res, res_out, A, B_in, B, store_data, mem_out, read_data, result;
  wire [5:0] prev_command;

  //IF stage
  IF_Stage if_stage(.clk(clk), .rst(rst), .freeze(freeze), .branch_taken(branch_taken), .branch_addr(branch_addr), .pc(next_pc), .instruction(instruction));

  //IF2Id reg
  wire [31:0] instruction_IF2ID_out, next_pc_IF2ID;
  IF2ID_reg if2Id(.flush(flush), .clk(clk), .rst(rst), .freeze(freeze), .pc(next_pc), .instruction_in(instruction), .instruction_out(instruction_IF2ID_out), .pc_out(next_pc_IF2ID));



  assign pc_jump = {next_pc1[31:28], command[25:0], 2'b0};

   //ID stage

  ID_Stage id_state(.clk(clk), .rst(rst), .write_reg_wb(write_reg_wb), .write_data(write_data), .write_en(wb_wb[1]), .instruction(instruction), .Exe_Dest(5'b0), .mem_exe(2'b0), .excutionSignals(5'b11111), .writeBack(2'b11), .memorySignals(2'b11), .datareg1(datareg1), .datareg2(datareg2), .stall_exe(stall_exe), .stall_wb(stall_wb), .stall_mem(stall_mem), .freeze(freeze), .Opcode(Opcode), .Function(Function), .pc_branch(pc_branch));

  // ID2EXE
  ID2EXE_reg id2exe(.clk(clk), .rst(rst), stall_wb, stall_mem, stall_exe, command[25:21], command[20:16], command[15:11], command[31:26]
                ,offset,datareg1,datareg2,wb_exe,mem_exe,exe_exe,Rs,Rt,Rd,offset_out,_datareg1,_datareg2,prev_command);

  // EXE stage
    // forward unit

  EXE_Stage exe_stage( .mem_mem(mem_mem), .wb_mem(wb_mem), .wb_wb(wb_wb), .wb_wb(wb_wb), .Rs(Rs), .Rt(Rt), )

  Forw_Unit forward_unit(mem_mem[1], wb_mem[1], wb_wb[1], Rs, Rt, Mem_Dest, write_reg_wb, Forw_A, Forw_B, Forw_unit);

  Mux4 #(32) mux_Forw_A (_datareg1,write_data,res_out,32'b0,Forw_A,A);
  Mux4 #(32) mux_Forw_B (_datareg2,write_data,res_out,32'b0,Forw_B,B_in);
  Mux2 #(32) mux_offset(offset_out,B_in, exe_exe[3], B);
  Mux2 #(5) mux_dest(Rd,Rt, exe_exe[4], Exe_Dest);

  ALU alu (exe_exe[2:0] , A , B, res);


  // EXE2MEM
  Exe2Mem_reg EXE2MEM(clk, rst, wb_exe, mem_exe, res, B_in, Exe_Dest, wb_mem, mem_mem, res_out, store_data, Mem_Dest);

  //Memory stage
  Memory memory(res_out,store_data,clk,mem_mem[0],mem_mem[1],mem_out);

  // MEM2WB
  MEM2WB_reg MEM2wb(clk,rst,res_out,mem_out,Mem_Dest, wb_mem,read_data,result,write_reg_wb, wb_wb);

  //WB stage
  Mux2 #(32) mux_write_back(result,read_data,wb_wb[0], write_data);
endmodule
