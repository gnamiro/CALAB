module ID_Stage (
    input clk, rst,
    input[31:0] WB_Value,
    input[3:0] WB_Dest,
    input WB_WB_EN,
    input [31:0] instruction,
    input Freeze,
    input [3:0] Sr,
    output flush,
    output [23:0] Signed_imm_24,
    output[11:0] shift_operand,
    output imm,
    output [31:0] Val_Rn, Val_Rm,
    output [8:0] controllerRes,
    output [3:0] Dest, Src2
);

wire [3:0] Cond;
wire S;
wire [3:0] Op_Code;
wire [1:0] Mode;
wire [8:0] _controllerRes;

wire condRes, notCondRes, controllerSelector;

assign Cond = instruction[31:28];
assign imm = instruction[25];
assign S = instruction[20];
assign Op_Code = instruction[24:21];
assign Mode = instruction[27:26];
assign Signed_imm_24 = instruction[23:0];
assign shift_operand = instruction[11:0];
assign Dest = instruction[15:12];
wire [3:0] src1, src2;
assign src1 = instruction[19:16];

Controller cu(.Mode(Mode), .Op_Code(Op_Code), .S(S), .controllerRes(_controllerRes));
ConditionCheck condCheck(.cond(Cond), .Sr(Sr), .condRes(condRes));

assign notCondRes = ~condRes;
assign controllerSelector = notCondRes | Freeze;

Mux2 #(9) controllerMux(9'b0, _controllerRes, controllerSelector, controllerRes);
Mux2 #(4) src2Mux(instruction[15:12], instruction[3:0], controllerRes[6], src2);
RegisterFile ut(.clk(clk), .rst(rst), .WB_Value(WB_Value), .WB_Dest(WB_Dest), .WB_EN(WB_WB_EN), .src1(src1), .src2(src2), .reg1(Val_Rn), .reg2(Val_Rm));
assign flush = 1'b0;
assign Src2 = src2;
endmodule
