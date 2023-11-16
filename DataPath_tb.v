`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2023 03:06:49 PM
// Design Name: 
// Module Name: DataPath_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataPath_tb();
reg clk;
reg rst;
reg[1:0] ledSel;
wire [15:0] Led_out;
 DataPath DP(clk, rst, ledSel, Led_out);
initial begin
clk = 1'b1;
forever #(5) clk = ~clk;
end

initial begin
rst = 1;
ledSel = 0;
#10
rst = 0;
ledSel = 1;
#3000
$finish;
end
endmodule
