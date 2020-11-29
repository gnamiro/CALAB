// module Mem (
//   input [31:0] in_addr, val_Rm,
//   input rst, MEM_W_EN, MEM_R_EN,
//   output reg [31:0] out
// );
//
//     reg [7:0] ROM [0 : 1023];
//     reg [7:0] RAM [0 : 1023];
//     always@ (*) begin
//         if (rst) begin
//             $readmemb("Instructions.mem", ROM);
//         end
//         else begin
//             if (in_addr < 32'd1024) begin
//                 out =  {ROM[in_addr], ROM[in_addr + 32'd1], ROM[in_addr + 32'd2], ROM[in_addr + 32'd3]};
//             end
//             else begin
//                 out =  {RAM[in_addr - 32'd1024], RAM[in_addr - 32'd1024 + 32'd1], RAM[in_addr - 32'd1024 + 32'd2], RAM[in_addr - 32'd1024 + 32'd3]};
//                 if(MEM_R_EN)begin
//                   {RAM[in_addr - 32'd1024], RAM[in_addr - 32'd1024 + 32'd1], RAM[in_addr - 32'd1024 + 32'd2], RAM[in_addr - 32'd1024 + 32'd3]} = val_Rm;
//                 end
//             end
//         end
//     end
//
// endmodule

`timescale 1ns / 1ns
module INSTRUCTION_MEMORY(rst, PC, Instruction);
    input [31:0] PC;
    input rst;
    output reg [31:0] Instruction;
    reg [31:0] ROM[0:1023]; //reg [wordsize:0] array_name [0:arraysize]
    always @ (*) begin
        if (rst) begin
            $readmemb("Instructions.mem", ROM);
            Instruction <= 32'b11100000000000000000000000000000;
        end
        else begin
            Instruction <= PC == -1 ? 32'b11100000000000000000000000000000 : ROM[PC];
        end
    end
endmodule
