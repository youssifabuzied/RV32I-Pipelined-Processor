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
input [4:0] MEMWB_rd,
input MEMWB_Regwrite,
output reg  ForwardA,
output reg ForwardB
    );
    
    
always@(*)begin
 if (MEMWB_Regwrite && (MEMWB_rd != 0 && MEMWB_rd == IDEX_rs1))begin
    ForwardA = 1'b1;
    ForwardB = 1'b0;
end

else if (MEMWB_Regwrite && (MEMWB_rd != 0 && MEMWB_rd == IDEX_rs2))begin
    ForwardA = 1'b0;
    ForwardB = 1'b1;
end
else begin
ForwardA = 1'b0;
ForwardB = 1'b0;
end
end
endmodule
