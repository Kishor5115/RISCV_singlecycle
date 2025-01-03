module alu_decoder(ALUop,op5,funct3,funct7,ALUControl);

input op5,funct7;
input [2:0] funct3;
input [1:0] ALUop;
output [2:0]ALUControl;


wire [1:0] op_funct7={op5,funct7};

assign ALUControl=(ALUop==2'b00) ? 3'b000 :
                  (ALUop==2'b01) ? 3'b001 :
                  ((ALUop==2'b10) &(funct3==3'b010)) ? 3'b101 :
                  ((ALUop==2'b10) &(funct3==3'b110)) ? 3'b011 :
                  ((ALUop==2'b10) &(funct3==3'b111)) ? 3'b010 :
                  ((ALUop==2'b10) &(funct3==3'b000))&(op_funct7==2'b11) ? 3'b001 :
                  ((ALUop==2'b10) &(funct3==3'b000))&(op_funct7!=2'b11) ? 3'b000 : 3'b000 ;

endmodule