module Data_Memory(A,WD,rst,clk,WE,RD);

input [31:0] A,WD;
input clk,WE,rst;
output [31:0] RD;
//CREATING MEMORY
reg [31:0] Data_MEM [10000:0];

assign RD  =  (rst==1'b1) ? Data_MEM[A]:32'h00000000;  //read

always @(posedge clk)
begin
    if(WE)
     Data_MEM[A]<=WD;
     else
     Data_MEM[A]<=Data_MEM[A] ;
end

initial begin
    Data_MEM[32'h00002000]=32'h00000010;


end
endmodule
