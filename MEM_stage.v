module MEM_stage(
  output out
  // input[31:0] address,
  // input[31:0] writedata,
  // input clk, writemem, readmem,
  // output[31:0] readmem_out
);

// reg [31:0]Memory[0:1023];//????????????????????????????????????????
//
// always @(posedge clk)begin
//   if (writemem)
//     Memory[address] <= writedata ;
//
//
//   end
//   assign readmem_out=readmem?Memory[address]:8'b0;
  assign out = 1;
endmodule
