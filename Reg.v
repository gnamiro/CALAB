module Reg #(parameter n =1)(input clk,ld,[n-1:0]in,output[n-1:0]Out);
    reg [n-1:0] out;
    always @(posedge clk)begin 
        if(ld)
            out <= in;
    end
    assign Out=out;
endmodule 