
// memory[7] = 32'b000100,00000,00010,00110,00000100010;  // sample
module memoryInstructor (input [31:0]PC, input rst,output [31:0]Instruction);

    reg [7:0] ROM[0:2499]; //reg [wordsize:0] array_name [0:arraysize]
    always@(posedge rst)begin
        $readmemb("Instructions.mem", ROM);
    end
    assign Instruction = {ROM[PC], ROM[PC + 32'd1], ROM[PC + 32'd2], ROM[PC + 32'd3]};
endmodule
