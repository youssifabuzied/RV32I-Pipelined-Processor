`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 11:49:13 AM
// Design Name: 
// Module Name: CU
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


module CU(input [4:0]inst, input[2:0] fun3, input bit_20, output reg Branch, output reg MemRead, output reg MemtoReg,
output reg[2:0] ALUOp, output reg MemWrite, output reg ALUSrc, output reg RegWrite, output reg[2:0] read_part, output reg [1:0] write_part,
 output reg terminate, output reg A_source, output reg jump);
always@(*)begin
case(inst)
5'b01100: begin
Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 010; 
 MemWrite = 0;
 ALUSrc = 0; 
 RegWrite = 1;
 terminate = 0;
 A_source = 0;
 jump = 0;
end

5'b01101: begin
Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 100; 
 MemWrite = 0;
 ALUSrc = 1; 
 RegWrite = 1;
 terminate = 0;
  A_source = 0;
   jump = 0;

end

5'b11100: begin
if (bit_20 == 0) begin 
Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 0;
 ALUSrc = 0; 
 RegWrite = 0;
 terminate = 0;
 A_source = 0;
  jump = 0;

 end
 else begin
 Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 0;
 ALUSrc = 0; 
 RegWrite = 0;
 terminate = 1;
  A_source = 0;
      jump = 0;


 end
end
5'b00011: begin
Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 0;
 ALUSrc = 0; 
 RegWrite = 0;
 terminate = 0;
 A_source = 0;
   jump = 0;

end
5'b00100: begin
Branch = 0; 
MemRead = 0; 
MemtoReg = 0; 
ALUOp = 011; 
MemWrite = 0;
ALUSrc = 1; 
RegWrite = 1;
terminate = 0;
A_source = 0;
jump = 0;

end
5'b00000: begin
Branch = 0; 
MemRead = 1; 
MemtoReg = 1; 
ALUOp = 000; 
MemWrite = 0;
ALUSrc = 1; 
RegWrite = 1;
terminate = 0;
 A_source = 0;
   jump = 0;

 case (fun3)
3'b001: read_part = 1;
3'b000: read_part = 3;
3'b100: read_part = 4;
3'b101: read_part = 2;
3'b010: read_part = 0;
 
 endcase
end
5'b01000: begin
 Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 1;
 ALUSrc = 1; 
 RegWrite = 0;
 terminate = 0;
 A_source = 0;
   jump = 0;

  case (fun3)
3'b010: write_part = 0;
3'b001: write_part = 1;
3'b000: write_part = 2;

 
 endcase
end
5'b11000: begin
 Branch = 1; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 001; 
 MemWrite = 0;
 ALUSrc = 0; 
 RegWrite = 0;
 terminate = 0;
 A_source = 0;
   jump = 0;

end
5'b00101: begin
 Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 0;
 ALUSrc = 1; 
 RegWrite = 1;
 terminate = 0;
 A_source = 1;
   jump = 0;

end

5'b11011: begin
 Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 0;
 ALUSrc = 1; 
 RegWrite = 1;
 terminate = 0;
 A_source = 1;
   jump = 1;

end

5'b11001: begin
 Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 0;
 ALUSrc = 1; 
 RegWrite = 1;
 terminate = 0;
 A_source = 0;
   jump = 1;

end
default: begin
 Branch = 0; 
 MemRead = 0; 
 MemtoReg = 0; 
 ALUOp = 000; 
 MemWrite = 0;
 ALUSrc = 0; 
 RegWrite = 0;
   terminate = 0;
 A_source = 0;
   jump = 0;

end

endcase
end
endmodule
