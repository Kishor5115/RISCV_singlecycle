module Reg_file(A1,A2,A3,WD3,WE3,clk,rst,RD1,RD2);

input clk,rst;
input [4:0] A1,A2,A3;
input [31:0] WD3;
output [31:0] RD1,RD2;
input WE3;
//creating memory
reg [31:0] Registers [0:31];


//read
assign RD1= (rst==1'b0) ?   32'h00000000 : Registers[A1];
assign RD2= (rst==1'b0) ?   32'h00000000 : Registers[A2];

always @(negedge clk , negedge rst)
begin
      if(WE3)
      Registers[A3]<=WD3;
end

initial begin
      Registers[0]=0 ;
end
endmodule