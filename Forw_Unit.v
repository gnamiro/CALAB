module Forw_Unit(input mem_read,reg_Write_mem,reg_Write_wb,input[4:0]Rs,Rt,exe_mem_reg,mem_wb_reg,output [1:0] Forw_A,Forw_B,output Forw_unit);
    // reg_write = wb[1]        last bit of wb[1]
    assign Forw_A = (reg_Write_mem == 1'b1)&&(Rs == exe_mem_reg) ? 3'b010 :((reg_Write_wb == 1'b1)&&(Rs == mem_wb_reg) ? 3'b001 : 3'b000);
    // assign Forw_A = (reg_Write == 1'b1)&&(Rs == mem_wb_reg) ? 3'b001 : 3'b000;

    assign Forw_B = (mem_read == 1'b0) ? ((reg_Write_mem == 1'b1)&&(Rt == exe_mem_reg) ? 3'b010 : ((reg_Write_wb == 1'b1)&&(Rt == mem_wb_reg) ? 3'b001 : 3'b000)) :3'b000;

    assign Forw_unit = (Forw_A != 3'b000 || Forw_B != 3'b000) ? 1'b1 : 1'b0;
    // assign Forw_B = (reg_Write == 1'b1)&&(Rt == mem_wb_reg) ? 3'b001 : 3'b000;
    

endmodule