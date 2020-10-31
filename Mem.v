module Mem (
  input [31:0] in_addr, val_Rm,
  input rst, MEM_W_EN, MEM_R_EN,
  output reg [31:0] out
);

    reg [7:0] ROM [0 : 1023];
    reg [7:0] RAM [0 : 1023];
    always@ (*) begin
        if (rst) begin
            $readmemb("Instructions.mem", ROM);
            $readmemb("Data.mem", RAM);
        end
        else begin
            if (in_addr < 32'd1024) begin
                out =  {ROM[in_addr], ROM[in_addr + 32'd1], ROM[in_addr + 32'd2], ROM[in_addr + 32'd3]};
            end
            else begin
                out =  {RAM[in_addr - 32'd1024], RAM[in_addr - 32'd1024 + 32'd1], RAM[in_addr - 32'd1024 + 32'd2], RAM[in_addr - 32'd1024 + 32'd3]};
                if(MEM_R_EN)begin
                  {RAM[in_addr - 32'd1024], RAM[in_addr - 32'd1024 + 32'd1], RAM[in_addr - 32'd1024 + 32'd2], RAM[in_addr - 32'd1024 + 32'd3]} = val_Rm;
                end
            end
        end
    end

endmodule
