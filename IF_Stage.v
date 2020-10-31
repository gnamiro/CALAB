module IF_Stage (
    input clk, rst, freeze, branch_taken,
    input  [31 : 0] branch_addr,
    output [31 : 0] pc, instruction
);

  wire [31:0] pc_in, pc_out, addr_offset = 32'd4;
  wire        adder_co;

  Pcreg pc_reg(clk, rst, freeze, pc_in, pc_out);
  Adder #(32) pc_adder(.ci(0), .a(pc_out), .b(addr_offset), .c(next_pc), .co(adder_co));
  memoryInstructor mem_ins(pc_out, instruction);
  Mux2 #(32) pc_mux (.a(branch_addr), .b(next_pc), .Sel(branch_taken), .w(pc_in));

endmodule
