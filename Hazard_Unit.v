module Hazard_Unit(
      input Two_src, EXE_WB_EN, MEM_WB_EN,
      input [3:0] Rn, EXE_Dest, MEM_Dest, src2,
      // output reg nop,
      output reg freeze
);
    always @ ( * ) begin
        freeze = 0;
        if(Rn != 4'b0)begin
          if (EXE_WB_EN) begin
              if (Rn == EXE_Dest) begin
                  freeze = 1;
              end
              if (Two_src && src2 == EXE_Dest) begin
                  freeze = 1;
              end
          end
          if (MEM_WB_EN) begin
              if (Rn == MEM_Dest) begin
                  freeze = 1;
              end
              if (Two_src && src2 == MEM_Dest) begin
                  freeze = 1;
              end
          end
        end
    end
    // wire src2_is_valid, hazard;
    // assign src2_is_valid =  R_branch;
    // assign hazard = exe_read_mem && ((Rs != 5'b0 && Rs == Exe_Dest) || (src2_is_valid && Rt == Exe_Dest));
endmodule



// 3 no hazard:
//   read after write:
//      tozih: neveshtan dar register, dar stage e WB rokh mide, va khoondan azash too 2 stage e ghabl
//      detection: biaim dst e stage EXE ro(be shart e inke WB_EN e stage e exe 1 bashe) ba 2 ta src e too stage e ID check konim, agar dst ba src2(khorooji e mux)(src2 hamishe RM e bejoz dar store) ya Rn(src1) barabar bood, dastoor ie ke too ID bood ro negah darim
//                 sar e stage e memory ham mitoone rokh bede(or hast na and)(oon or i ke too id hast, vaase ine ke agar imm dashtim ya dastoor load bood(tak src bood), fgt ba src1 check konim)
//      fix: hazard ro 1 konim, IF2EXE_reg, ID2EXE_reg freeze shan, be pc bere, va 0 kardan e tamam e controll signal ha
//    write after read:
//    chon pardazande out of order nis, pas moshkeli ijad nemikone

//  ID az register file bekhoone, va WB ham write kone(hazard e sakhtari)
//  ke write register file dar negedge bashe

//  chon too exe branch taken maloom mishe, bayad 2 dastoor e vared shode ro flush konim
