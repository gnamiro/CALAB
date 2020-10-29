module Hazard_Unit(input [4:0] Rt,Rs,Exe_Dest,input exe_read_mem,R_branch,output nop,freeze);

    wire src2_is_valid, hazard;
    assign src2_is_valid =  R_branch;
    assign hazard = exe_read_mem && ((Rs != 5'b0 && Rs == Exe_Dest) || (src2_is_valid && Rt == Exe_Dest));
    assign {nop,freeze} = hazard ? 2'b01:2'b10;
    // assign {nop,freeze} = ({nop,freeze} == 2'b0 && mem_read_mem == 1'b1 && (opcode_exe == 6'b000100 || opcode_exe ==6'b000101)) ? 2'b00 : 2'b11; //2 stalll
    // wire src2_is_valid, exe_has_hazard, mem_has_hazard, hazard, instr_is_branch;
    // assign src2_is_valid =  R_branch;

    // assign exe_has_hazard = write_back_exe && ((Rs != 5'b0 && Rs == Exe_Dest) || (src2_is_valid && Rt == Exe_Dest));
    // assign mem_has_hazard = write_back_mem && (Rs == Mem_Dest || (src2_is_valid && Rt == Mem_Dest));

    // assign hazard = (exe_has_hazard || mem_has_hazard);
    // assign hazard = (exe_has_hazard);
    // assign instr_is_branch = (opcode == 6'b000100 || opcode ==6'b000101);

    // assign hazard_detected = ~Forward_En ? hazard : (instr_is_branch && hazard) || (mem_read_mem && mem_has_hazard) ;
    // assign hazard_detected = ~Forward_En ? hazard : (instr_is_branch && hazard) ;
    // assign {nop,freeze} = ({nop,freeze} == 2'b0 && mem_read_mem == 1'b1 && (opcode_exe == 6'b000100 || opcode_exe ==6'b000101)) ? 2'b00 :(hazard_detected ? 2'b0 : 2'b11 );
    // assign {nop,freeze} = ({nop,freeze} == 2'b0 && mem_read_mem == 1'b1 && (opcode_exe == 6'b000100 || opcode_exe ==6'b000101)) ? 2'b00 :(hazard_detected ? 2'b0 : 2'b11 );
endmodule