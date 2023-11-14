`timescale 1ns / 1ps


module N_bitRF#(parameter N = 32)(
input clk,
input rst,
input load,
input[N-1:0] D,
output  [N-1:0] Q
    );
genvar i;
wire  [N-1:0] in;
generate 
for (i=0; i<N; i=i+1) begin
MUX2x1 m(Q[i], D[i], load, in[i]);
DFF d (clk, rst, in[i], Q[i]);

end
endgenerate
endmodule
