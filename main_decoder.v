module  main_decoder(op,zero,RegWrite,Memwrite,ResultSrc,branch,Jump,ALUSrc,ImmSrc,ALUop,PCSrc);
input [6:0] op;
input zero;
output RegWrite,Memwrite,ALUSrc,PCSrc,branch,Jump;
output [1:0] ImmSrc,ResultSrc,ALUop;

assign Regwrite= ((op==7'b0000011) | (op==7'b0110011)) ? 1'b1 : 1'b0 ;
assign MEMORYe= (op==7'b0100011) ? 1'b1 : 1'b0 ;
assign ResultSrc =(op==7'b0000011) ? 2'b01 :
                  (op==7'b0100011) ? 2'bxx :
                  (op==7'b0110011) ? 2'b00 :
                  (op==7'b1100011) ? 2'bxx :
                  (op==7'b0010011) ? 2'b00 :
                  (op==7'b1101111) ? 2'b10 : 0 ;

assign ALUSrc=((op==7'b0000011) | (op==7'b0100011)) ? 1'b1 : 1'b0 ;
assign branch=(op==7'b0000001) ? 1'b1 : 1'b0 ;
assign Jump = (op==7'b1101111) ? 1'b1 : 1'b0 ;
assign ImmSrc=(op==7'b0100011) ? 2'b01 : (op==7'b1100011) ? 2'b10 : 2'b00 ;
assign ALUop=(op==7'b1100011)? 2'b01 : (op==7'b0110011) ? 2'b10 : 2'b00 ;
assign PCSrc=(zero & branch) | Jump ;

endmodule