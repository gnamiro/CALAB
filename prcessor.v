
module processor(input clk,rst);
  wire pc_write,pc_write_cond,IorD,IR_write,Pc_src,readmem,writemem,MtoS,ld_A,ld_B,pop,push,tos,Sel_A,Sel_B;
  wire [1:0] controller_command;
  wire [2:0] opcode;
 Datapath Dp(clk,rst,pc_write,pc_write_cond,IorD,IR_write,Pc_src
 ,readmem,writemem,MtoS,ld_A,ld_B,pop,push,tos,Sel_A,Sel_B
,controller_command
,opcode);

  Controller Cn(opcode,pc_write,pc_write_cond,IorD,IR_write,Pc_src
,readmem,writemem,MtoS,ld_A,ld_B,pop,push,tos,Sel_A,Sel_B
,controller_command
,clk,rst);

endmodule  
  