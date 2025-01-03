
`include "program_counter.v"
`include "Instruction_Memory.v"
`include "Data_Mem.v"
`include "Register_files.v"
`include "sign_extend.v"
`include "alu.v"
`include "control_unit_top.v"
`include "pc_adder.v"
`include "mux.v"


module Single_cycle_Top(clk,rst);
  
  input clk,rst;
  wire [31:0] PC_Top,RD_Instr,RD1_Top,imm_ext_top,ALUResult,ReadData,pc_plus4,RD2_Top,SrcB,RD_Top,PC_Target,PCNext_Top;
  wire [2:0] ALUControl_Top;
  wire [1:0] ImmSrc,ResultSrc;
  wire RegWrite,Memwrite,ALUSrc,PCSrc;

    P_C PC
    (
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PCNext(PCNext_Top)
    );  


    PC_Adder PC_Adder
    (
        .a(PC_Top),
        .b(32'd4),
        .c(pc_plus4)

    );


    instr_Mem Instruction_Memory
    (

        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );


    Reg_file Register_file
    (

        .clk(clk),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .WE3(RegWrite),
        .WD3(RD_Top),
        .rst(rst),
        .RD1(RD1_Top),
        .RD2(RD2_Top)

    );

    Sign_Extend Sign_Extend
    (

        .in(RD_Instr),
        .imm_ext(imm_ext_top),
        .ImmSrc(ImmSrc)

    );


    ALU ALU
    (

        .A(RD1_Top),
        .B(SrcB),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .Overflow(),
        .Carry(),
        .Negative()

    );


    control_unit_top control_unit_top
    (

        .op(RD_Instr[6:0]),
        .RegWrite(Regwrite),
        .Memwrite(Memwrite),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[31:25]),
        .ALUControl(ALUControl_Top),
        .PCSrc(PCSrc)

    );


    Data_Memory Data_Memory
    (

        .A(ALUResult),
        .rst(rst),
        .WD(RD2_Top),
        .clk(clk),
        .WE(Memwrite),
        .RD(ReadData)

    );
    

    mux mux_alu
    (

        .a(RD2_Top),
        .b(imm_ext_top),
        .sel(ALUSrc),
        .c(SrcB)

    );


    mux mux_data
    (

        .a(ALUResult),
        .b(ReadData),
        .c(RD_Top),
        .sel(ResultSrc[0])
    );


    mux mux_pcgt
    (
        .a(pc_plus4),
        .b(PC_Target),
        .c(PCNext_Top),
        .sel(PCSrc)

    );

    PC_Adder pc_target
    (

       .a(PC_Top),
       .b(imm_ext_top),
       .c(PC_Target)


    );

endmodule