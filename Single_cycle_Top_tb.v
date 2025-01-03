`include "Single_cycle_Top.v"

module Single_cylce_Top_tb();
 reg clk=1'b0,rst;
 Single_cycle_Top Single_cycle_Top(
        .clk(clk),
        .rst(rst)
 );
    initial begin
        $dumpfile("Single Cycle.vcd");
        $dumpvars(0,Single_cylce_Top_tb);

            end

    always 
    begin
        clk=~clk;
        #50;
    end

    initial
         begin
         rst=1'b0;
         #100;
         rst=1'b1;
         #300;
         $finish;   
         end




 endmodule