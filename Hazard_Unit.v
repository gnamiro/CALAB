module Hazard_Unit(input [4:0] Rt, Rs, Exe_Dest, input exe_read_mem, R_branch, output nop, freeze);

    // wire src2_is_valid, hazard;
    // assign src2_is_valid =  R_branch;
    // assign hazard = exe_read_mem && ((Rs != 5'b0 && Rs == Exe_Dest) || (src2_is_valid && Rt == Exe_Dest));
    assign {nop, freeze} = 2'b10;

endmodule
