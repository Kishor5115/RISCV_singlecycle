`ifndef mux_v
`define mux_v
module  mux(a,b,c,sel);
input [31:0] a,b;
input sel;
output [31:0] c;
    
    assign c = sel ? b : a ;

    
endmodule
`endif