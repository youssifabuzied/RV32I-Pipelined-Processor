`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2023 03:02:07 PM
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
input [4:0] IDEX_rs1,
input [4:0] IDEX_rs2,
input [4:0] EXMEM_rd,
input [4:0] MEMWB_rd,
input EXMEM_Regwrite,
input MEMWB_Regwrite,
output reg [1:0] ForwardA,
output reg [1:0] ForwardB
    );
    
    
always@(*)begin
 if (MEMWB_Regwrite && (MEMWB_rd != 0 && MEMWB_rd == IDEX_rs1))begin
    ForwardA = 01;
    ForwardB = 00;
end

else if (MEMWB_Regwrite && (MEMWB_rd != 0 && MEMWB_rd == IDEX_rs2))begin
    ForwardA = 00;
    ForwardB = 01;
end
else begin
ForwardA = 00;
ForwardB = 00;
end
end
endmodule
