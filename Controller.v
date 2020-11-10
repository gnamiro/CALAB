module Controller(
  input [1:0] Mode,
  input [3:0] Op_Code,
  input S,
  output [8:0] controllerRes
);

reg B, MEM_W_EN, MEM_R_EN, WB_EN;
reg [3:0] EXE_CMD;

always@ (*) begin
  case (Mode)
    2'b00: begin // arithmatic
      B = 1'b0;
      EXE_CMD = Op_Code;
      MEM_R_EN = 1'b0;
      MEM_W_EN = 1'b0;
      WB_EN = 1'b1;
    end
    2'b01: begin // load or store
      B = 1'b0;
      EXE_CMD = Op_Code;
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
      EXE_CMD = 4'bx;
      MEM_W_EN = 1'b0;
      MEM_R_EN = 1'b0;
      WB_EN = 1'b0;
    end
  endcase
end
assign controllerRes  = {WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S};
endmodule
