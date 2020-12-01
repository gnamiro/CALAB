module Controller(
  input [1:0] Mode,
  input [3:0] Op_Code,
  input S,
  output [8:0] controllerRes
);

reg B, MEM_W_EN, MEM_R_EN, WB_EN;
reg [3:0] EXE_CMD;

always@ (*) begin
  {WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B} = 0;
  case (Mode)
    2'b00: begin // arithmatic
      B = 1'b0;
      MEM_R_EN = 1'b0;
      MEM_W_EN = 1'b0;
      WB_EN = 1'b1;
    end
    2'b01: begin // load or store
      B = 1'b0;
      if (S == 1'b1) begin  //load
        MEM_R_EN = 1'b1;
        MEM_W_EN = 1'b0;
        WB_EN = 1'b1;
      end
      else begin //store
        MEM_R_EN = 1'b0;
        MEM_W_EN = 1'b1;
        WB_EN = 1'b0;
      end

    end
    2'b10: begin // branch
      B = 1'b1;
      MEM_W_EN = 1'b0;
      MEM_R_EN = 1'b0;
      WB_EN = 1'b0;
    end
  endcase
  case(Op_Code)
    4'b0000: EXE_CMD = 4'b0110; // AND
    4'b1101: EXE_CMD = 4'b0001; // MOV
    4'b1111: EXE_CMD = 4'b1001; // MVN
    4'b0100: EXE_CMD = 4'b0010; // ADD
    4'b0101: EXE_CMD = 4'b0011; // ADC
    4'b0010: EXE_CMD = 4'b0100; // SUB
    4'b0110: EXE_CMD = 4'b0101; // SBC
    4'b1100: EXE_CMD = 4'b0111; // ORR
    4'b0001: EXE_CMD = 4'b1000; // EOR
    4'b1010:begin EXE_CMD = 4'b0100; WB_EN = 1'b0; end// CMP
    4'b1000:begin EXE_CMD = 4'b0110; WB_EN = 1'b0; end// TST
  endcase
end
assign controllerRes  = {WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S};
endmodule
