module ID_Stage (
    input clk, rst, write_reg_wb, write_data, write_en
    input [31 : 0] instruction,
    input [5:0] Exe_Dest,
    input [1:0] mem_exe,
    input [5:0] excutionSignals,
    input [1:0] writeBack, memorySignals,
    output [31 : 0] datareg1, datareg2,
    output reg [5:0] stall_exe,
    output reg [1:0] stall_wb, stall_mem,
    output reg freeze,
    output [5:0] Opcode, Function,
    output [2:0] pc_branch
);

reg stall;
regFile reg_file(clk, write_en, instruction[25:21], instruction[20:16], write_reg_wb, write_data, datareg1, datareg2);


//hazard unit
Hazard_Unit hazard_unit(instruction[20:16], instruction[25:21], Exe_Dest, mem_exe, 1'b0, stall, freeze);

assign Opcode = instruction[31:26];
assign Function = instruction  [5:0];
//assign sub_reg = datareg1 - datareg2;
//assign Zero = (sub_reg == 32'b0) ? 1'b1 : 1'b0;
assign pc_branch = 32'b011;

Mux2 #(5) cont_exe(excutionSignals, 5'b0, stall,stall_exe);
Mux2 #(2) cont_wb(writeBack, 2'b0, stall, stall_wb);
Mux2 #(2) cont_mem(memorySignals, 2'b0, stall, stall_mem);


endmodule
