module  instr_Mem(A,rst,RD);
input [31:0] A;
input rst;
output  [31:0] RD;

reg [31:0]  Mem [0:1023];

assign RD   =   (rst==1'b0) ?   32'h00000000    :   Mem[A[31:2]];


    initial 
    begin
    $readmemh("mem_file.hex",Mem);
    end



endmodule