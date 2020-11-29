module IF_Stage (
    input clk, rst, freeze,
    input branch_taken,
    input  [31 : 0] branch_addr,
    output [31 : 0] pc, instruction
);

  wire [31:0] pc_in, pc_out, addr_offset, next_pc;
  wire  adder_co;
  assign addr_offset = 32'd4;

  Pcreg pc_reg(clk, rst, freeze, pc_in, pc_out);
  // Mem mem_ins(.in_addr(pc_out), .val_Rm(32'b0), .rst(rst), .MEM_W_EN(1'b0), .MEM_R_EN(1'b0), .out(instruction));
  INSTRUCTION_MEMORY instMem(.rst(rst), .PC(pc_out), .Instruction(instruction));
  Adder #(32) pc_adder(.ci(1'b0), .a(pc_out), .b(32'd1), .c(next_pc), .co(adder_co));
  Mux2 #(32) pc_mux (.a(branch_addr), .b(next_pc), .select(branch_taken), .w(pc_in));
  assign pc = next_pc;

endmodule
