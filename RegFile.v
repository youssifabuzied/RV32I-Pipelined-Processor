`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 02:41:09 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile#(parameter N=32)(input clk,input rst, input [4:0]read1, input [4:0] read2,
input [4:0]writeadd, input [N-1:0]writedata, input enwrite, output [N-1:0] out1, output [N-1:0] out2);
reg [N-1:0] reg_file [31:0];
assign out1 = reg_file[read1];
assign out2 = reg_file[read2];
integer i = 0;
always @(negedge clk, posedge rst)begin
if(rst ==1) begin
for(i = 0; i < 32; i= i+1) reg_file[i] <= 0;
end
else begin
if(enwrite == 1 && writeadd != 0) begin
reg_file[writeadd] <= writedata;
end
end

end 
endmodule
