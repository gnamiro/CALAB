module Datapath (input clk,rst,output [5:0]Opcode,Function,output  Zero
,input pcCondition,[1:0]Flush,input R_branch, input [1:0] pcSrc,writeBack,memorySignals,input[4:0]excutionSignals);
  
  wire zero,freeze,stall,Forw_unit;
  wire [31:0] sub_reg,ext_offset,offset_out;
  wire [31:0] pc_in,pc_out,next_pc,next_pc1,pc_branch,pc_jump,pc_jump1;   // related to pc
  wire [31:0] command,If_out,write_data,datareg1,datareg2,offset; 
  wire [1:0] wb_wb,mem_mem,wb_exe,wb_mem,Forw_A,Forw_B;
  wire [4:0] stall_exe,exe_exe;
  wire [1:0] mem_exe,stall_wb,stall_mem;
  wire [4:0] Exe_Dest,Mem_Dest,Rt,Rd,Rs,write_reg_wb;
  wire [31:0] _datareg1,_datareg2,res,res_out,A,B_in,B,store_data,mem_out,read_data,result;
  wire [5:0] prev_command;

  //IF stage
  Pcreg pc_reg(clk,rst,freeze,pc_in,pc_out);
  memoryInstructor mem_ins(pc_out,If_out);
  assign next_pc = 32'd4 + pc_out;
  Mux4 #(32) pc_mux (next_pc,pc_branch,pc_jump,next_pc,pcSrc,pc_in);

  //IF2Id reg
  IF2ID_reg if2Id(Flush,clk,rst,freeze,command[25:0],next_pc,If_out,command,next_pc1);
  assign pc_jump={next_pc1[31:28],command[25:0],2'b0};
  // assign pc_jump = pc_jump1<<2;
   //ID stage
  regFile reg_file(clk,wb_wb[1],command[25:21],command[20:16],write_reg_wb,write_data,datareg1,datareg2);
     //hazard unit

  // Hazard_Unit hazard_unit(command[31:26],prev_command, command[20:16],command[25:21],Exe_Dest,Mem_Dest,mem_mem[1],wb_exe[1],wb_mem[1],R_branch,Forw_unit, stall,freeze);
  Hazard_Unit hazard_unit(command[20:16],command[25:21],Exe_Dest,mem_exe[1],R_branch,stall,freeze);
  assign offset = {command[15],command[15],command[15],command[15],command[15],command[15],command[15],command[15],
                  command[15],command[15],command[15],command[15],command[15],command[15],command[15],command[15],command[15:0]};
  assign Opcode = command[31:26];
  assign Function =command[5:0];
  assign sub_reg = datareg1 - datareg2;
  assign Zero = (sub_reg == 32'b0) ? 1'b1 : 1'b0;
  assign ext_offset = offset << 2 ;
  assign pc_branch = next_pc1 +  ext_offset;

  Mux2 #(5) cont_exe(excutionSignals,5'b0, stall,stall_exe);
  Mux2 #(2) cont_wb(writeBack,2'b0, stall, stall_wb);
  Mux2 #(2) cont_mem(memorySignals,2'b0, stall, stall_mem);

  // ID2EXE
  ID2EXE_reg ID2EXE(clk,rst,stall_wb,stall_mem,stall_exe,command[25:21], command[20:16], command[15:11],command[31:26]
                ,offset,datareg1,datareg2,wb_exe,mem_exe,exe_exe,Rs,Rt,Rd,offset_out,_datareg1,_datareg2,prev_command);
  
  // EXE stage
    // forward unit
  Forw_Unit forward_unit(mem_mem[1],wb_mem[1],wb_wb[1],Rs,Rt,Mem_Dest,write_reg_wb,Forw_A,Forw_B, Forw_unit);

  Mux4 #(32) mux_Forw_A (_datareg1,write_data,res_out,32'b0,Forw_A,A);
  Mux4 #(32) mux_Forw_B (_datareg2,write_data,res_out,32'b0,Forw_B,B_in);
  Mux2 #(32) mux_offset(offset_out,B_in, exe_exe[3], B);
  Mux2 #(5) mux_dest(Rd,Rt, exe_exe[4], Exe_Dest);

  ALU alu (exe_exe[2:0] , A , B, res);

  // EXE2MEM
  Exe2Mem_reg EXE2MEM(clk,rst,wb_exe,mem_exe,res,B_in,Exe_Dest, wb_mem,mem_mem,res_out,store_data,Mem_Dest);

  //Memory stage
  Memory memory(res_out,store_data,clk,mem_mem[0],mem_mem[1],mem_out);

  // MEM2WB
  MEM2WB_reg MEM2wb(clk,rst,res_out,mem_out,Mem_Dest, wb_mem,read_data,result,write_reg_wb, wb_wb);

  //WB stage
  Mux2 #(32) mux_write_back(result,read_data,wb_wb[0], write_data);
endmodule
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


