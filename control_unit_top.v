`include "main_decoder.v"
`include "alu_decoder.v"

module control_unit_top(op,zero,Jump,RegWrite,Memwrite,ResultSrc,ALUSrc,PCSrc,ImmSrc,branch,funct3,funct7,ALUControl);

input [6:0] op,funct7;
input [2:0] funct3 ;
input zero;
output RegWrite,Memwrite,ALUSrc,branch,PCSrc,Jump;
output [1:0] ImmSrc,ResultSrc;
output [2:0] ALUControl;

wire [1:0] ALUop;


    main_decoder main_decoder(
        .op(op),
        .RegWrite(RegWrite),
        .Memwrite(Memwrite),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .ALUop(ALUop),
        .PCSrc(PCSrc)

    );

 

    alu_decoder alu_decoder(
        .ALUop(ALUop),
        .op5(op5),
        .funct3(funct3),
        .funct7(funct7[5]),
        .ALUControl(ALUControl)

    );



endmodule